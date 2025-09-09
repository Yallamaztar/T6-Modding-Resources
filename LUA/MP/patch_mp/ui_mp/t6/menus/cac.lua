CoD.CAC = {}
CoD.CAC.createPanel = {}
CoD.CAC.ButtonActionSound = "uin_navigation_select_main"
CoD.CAC.LockImageMaterial = RegisterMaterial("menu_mp_lobby_locked")
CoD.CAC.LockImageBigMaterial = RegisterMaterial("menu_mp_lobby_locked_big")
CoD.CAC.ButtonGridLockImageSize = 30
require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
require("T6.Menus.CACClassSelection")
require("T6.Menus.CACClassOptions")
require("T6.Menus.CACLoadOut")
require("T6.Menus.CACLoadOutOverview")
require("T6.Menus.CACWeaponSlot")
require("T6.Menus.CACGrenadeSelection")
require("T6.Menus.CACPerksSelection")
require("T6.Menus.CACPurchaseConfirmationPopup")
CoD.CAC.FadeInTime = 250
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7, f0_local8, f0_local9, f0_local10 = nil
CoD.CAC.OpenPopup = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.MFPopup.new(f1_arg0, nil, nil, Engine.Localize("MENU_CREATE_A_CLASS_CAPS"))
	f1_local0.body.background:close()
	f1_local0.body:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = -CoD.AllocationSubtitle.Height - 2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("menu_mp_tab_frame_inner")
	}))
	f1_local0:registerEventHandler("destroy_panel", CAC_DestroyPanel)
	f1_local0:registerEventHandler("item_purchased", CAC_ItemPurchased)
	f1_local0.createPanel = f0_local0
	f1_local0.openPanel = f0_local1
	f1_local0.closePanel = f0_local2
	f1_local0.getPanel = f0_local3
	f1_local0.getAllocationSubtitle = f0_local4
	f1_local0.update = f0_local7
	f1_local0.openClassPreview = f0_local8
	f1_local0.closeClassPreview = f0_local9
	f1_local0.m_ownerController = f1_arg1
	f0_local10(f1_local0)
	f1_local0:openPopup(nil, true)
	return f1_local0
end

f0_local10 = function (f2_arg0, f2_arg1)
	f2_arg0:addSelectButton()
	f2_arg0:addBackButton()
	f2_arg0:registerEventHandler("button_prompt_back", CAC_ButtonPromptBack)
	local f2_local0 = f2_arg0.m_ownerController
	f2_arg0.body.panels = {}
	f2_arg0.body.classItems = {}
	CoD.CACUtility.SetupElementForClassData(f2_arg0.body.classItems)
	local f2_local1 = 0
	if CoD.perController[f2_local0].classNumInternal ~= nil then
		f2_local1 = CoD.perController[f2_local0].classNumInternal
	end
	local f2_local2 = CoD.CACUtility.GetClassData(f2_local0, f2_local1)
	f2_arg0:openPanel("ClassSelection", nil, 0)
	f2_arg0:openPanel("Allocation", nil, 0)
	f2_arg0:openClassPreview(0)
	local f2_local3 = f2_arg0:getPanel("Perks")
	f2_local3.currentPerkCount = #f2_local2.perks
	f2_local3.currentPerkInFocus = 1
	f2_arg0:update()
end

function CAC_ButtonPromptBack(f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "uploadstats")
	Engine.CommitProfileChanges(f3_arg1.controller)
	Engine.PartyHostClearUIState()
	f3_arg0:closePopup(nil, true)
end

f0_local0 = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.body
	local f4_local1 = f4_local0.panels[f4_arg1]
	if f4_local1 == nil then
		if CoD.CAC.createPanel[f4_arg1] == nil then
			error("LUI Error: no create function associated with " .. f4_arg1 .. " panel. ")
		end
		f4_local1 = CoD.CAC.createPanel[f4_arg1](f4_arg0)
		if f4_local1 ~= nil then
			f4_local0.panels[f4_arg1] = f4_local1
			f4_local0:addElement(f4_local1)
		end
	end
	return f4_local1
end

f0_local1 = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = f5_arg0.m_ownerController
	if f5_arg3 == nil then
		f5_arg3 = CoD.CAC.FadeInTime
	end
	if f5_arg2 == nil then
		f5_arg2 = "primary"
	end
	local f5_local1 = f5_arg0:createPanel(f5_arg1)
	if f5_local1 ~= nil then
		Engine.PlaySound(CoD.CAC.ButtonActionSound)
		f5_local1:animateToState(f5_arg2, f5_arg3, true, true)
		if f5_arg2 == "primary" then
			f5_local1.m_inputDisabled = nil
			f5_local1:processEvent({
				name = "on_activate",
				controller = f5_local0
			})
		else
			f5_local1.m_inputDisabled = true
			f5_local1:processEvent({
				name = "on_deactivate",
				controller = f5_local0
			})
		end
	end
end

f0_local2 = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = f6_arg0.body.panels[f6_arg1]
	local f6_local1 = f6_arg0.m_ownerController
	if f6_arg4 == nil then
		f6_arg4 = CoD.CAC.FadeInTime
	end
	if f6_arg2 == nil then
		f6_arg2 = "default"
	end
	if f6_local0 ~= nil then
		f6_local0:animateToState(f6_arg2, f6_arg4, true, true)
		if f6_arg3 == true then
			f6_local0:processEvent({
				name = "on_close",
				controller = f6_local1
			})
			f6_local0:addElement(LUI.UITimer.new(f6_arg4, {
				name = "destroy_panel",
				panelName = f6_arg1
			}, true, f6_arg0))
		else
			f6_local0:processEvent({
				name = "lose_focus"
			})
			f6_local0:processEvent({
				name = "on_deactivate",
				controller = f6_local1
			})
		end
	end
end

function CAC_DestroyPanel(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.panelName
	if f7_arg0.body.panels[f7_local0] ~= nil then
		f7_arg0.body.panels[f7_local0]:close()
		f7_arg0.body.panels[f7_local0] = nil
	end
end

f0_local3 = function (f8_arg0, f8_arg1)
	return f8_arg0.body.panels[f8_arg1]
end

f0_local7 = function (f9_arg0)
	local f9_local0 = f9_arg0:getPanel("Allocation")
	if f9_local0 ~= nil then
		f9_local0:update()
	end
	local f9_local1 = f9_arg0.m_ownerController
	local f9_local2 = CoD.perController[f9_local1].classNumInternal
	if f9_local2 == nil then
		f9_local2 = 0
	end
	local f9_local3 = CoD.CACUtility.GetClassData(f9_local1, f9_local2)
	local f9_local4 = f9_arg0:getPanel("Perks")
	if f9_local4 ~= nil then
		f9_local4.currentPerkCount = #f9_local3.perks
		if f9_local4.isActive == true then
			f9_local4:align()
		end
	end
	CoD.CACUtility.UpdateUIFromClassData(f9_local3, f9_arg0.body.classItems, f9_local1)
end

f0_local8 = function (f10_arg0, f10_arg1)
	f10_arg0:openPanel("PrimaryWeapon", nil, f10_arg1)
	f10_arg0:openPanel("SecondaryWeapon", nil, f10_arg1)
	f10_arg0:openPanel("Grenades", nil, f10_arg1)
	f10_arg0:openPanel("Perks", nil, f10_arg1)
end

f0_local9 = function (f11_arg0, f11_arg1)
	f11_arg0:closePanel("PrimaryWeapon", nil, f11_arg1)
	f11_arg0:closePanel("SecondaryWeapon", nil, f11_arg1)
	f11_arg0:closePanel("Grenades", nil, f11_arg1)
	f11_arg0:closePanel("Perks", nil, f11_arg1)
end

f0_local4 = function (f12_arg0)
	local f12_local0 = f12_arg0:getPanel("Allocation")
	if f12_local0 ~= nil then
		return f12_local0.allocationSubtitle
	else

	end
end

CoD.CAC.AddUnlockTokenText = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4)
	local f13_local0 = CoD.textSize.Default
	local f13_local1 = CoD.fonts.Default
	local f13_local2 = f13_local0
	if f13_arg4 == nil then
		f13_arg4 = 0
	end
	local unlockTokenText = LUI.UIText.new({
		left = 0,
		top = -f13_local2 - f13_arg4,
		right = 0,
		bottom = -f13_arg4,
		leftAnchor = f13_arg2,
		topAnchor = false,
		rightAnchor = f13_arg3,
		bottomAnchor = true,
		font = f13_local1
	})
	f13_arg0:addElement(unlockTokenText)
	f13_arg0.unlockTokenText = unlockTokenText
	
	f13_arg0.weaponGroup = f13_arg1
end

function CAC_ItemPurchased(f14_arg0, f14_arg1)
	f14_arg0:update()
	local f14_local0 = f14_arg0:getPanel("ItemsGrid")
	if f14_local0 ~= nil then
		f14_local0:updateButtonGrid(f14_arg0:getAllocationSubtitle())
	end
	local f14_local1 = f14_arg0:getPanel("ItemInfo")
	if f14_local1 ~= nil then
		f14_local1:update(f14_arg1.itemGridButton)
	end
end

local f0_local11 = function (f15_arg0)
	f15_arg0:closePopup(nil, true, f15_arg0.CAC)
	if f15_arg0.CAC ~= nil then
		f15_arg0.CAC:setBlur(true)
		f15_arg0.CAC:processEvent({
			name = "item_purchased",
			itemGridButton = f15_arg0.itemGridButton
		})
	end
end

local f0_local12 = function (f16_arg0, f16_arg1)
	f0_local11(f16_arg0)
end

local f0_local13 = function (f17_arg0, f17_arg1)
	f0_local11(f17_arg0.popup)
end

local f0_local14 = function (f18_arg0, f18_arg1)
	Engine.PurchaseItem(f18_arg1.controller, f18_arg0.popup.itemGridButton.itemIndex)
	f0_local11(f18_arg0.popup)
end

CoD.CAC.CanAffordUnlocksForItemIndex = function (f19_arg0, f19_arg1)
	if CoD.CAC.GetUnlockCountForGroup(f19_arg0, UIExpression.GetItemGroup(nil, f19_arg1)) < UIExpression.GetItemCost(nil, f19_arg1) then
		return false
	else
		return true
	end
end

CoD.CAC.IsWideWeaponImage = function (f20_arg0)
	if f20_arg0 < 64 then
		return true
	else
		return false
	end
end

CoD.CAC.GetMaterialName = function (f21_arg0)
	local f21_local0 = UIExpression.GetItemImage(nil, f21_arg0)
	if CoD.IsPerk(f21_arg0) then
		return f21_local0 .. "_256"
	elseif CoD.IsReward(f21_arg0) or f21_arg0 < 64 then
		return f21_local0 .. "_big"
	else
		return f21_local0
	end
end

CoD.CAC.SetItemMaterialForAttachmentIndex = function (f22_arg0, f22_arg1)
	f22_arg0:addElement(LUI.UIImage.new({
		left = 10,
		top = -(25 + 128),
		right = 10 + 128,
		bottom = -25,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		material = RegisterMaterial(UIExpression.GetAttachmentImage(nil, f22_arg1)),
		alpha = 1
	}))
end

CoD.CAC.SetItemMaterialForItemIndex = function (f23_arg0, f23_arg1)
	local f23_local0 = 128
	if CoD.CAC.IsWideWeaponImage(f23_arg1) then
		f23_local0 = f23_local0 * 2
	end
	local f23_local1 = 128
	local f23_local2 = RegisterMaterial(CoD.CAC.GetMaterialName(f23_arg1))
	local f23_local3 = {
		0,
		0,
		0,
		0
	}
	if CoD.IsReward(f23_arg1) then
		f23_local3 = {
			0,
			1,
			0,
			0
		}
	end
	f23_arg0:addElement(LUI.UIImage.new({
		left = 10,
		top = 10,
		right = 10 + f23_local0,
		bottom = 10 + f23_local1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		material = f23_local2,
		alpha = 1,
		shaderVector0 = f23_local3
	}))
end

CoD.CAC.SetPrestigeTokenText = function (f24_arg0, f24_arg1, f24_arg2)
	if f24_arg0.prestigeTokenText ~= nil then
		local f24_local0 = Engine.GetPermanentUnlockCount(f24_arg1)
		local f24_local1 = ""
		if f24_local0 and f24_local0 > 0 then
			if f24_local0 == 1 then
				f24_local1 = Engine.Localize("MPUI_PERMANENT_UNLOCK_AVAILABLE", f24_local0)
			else
				f24_local1 = Engine.Localize("MPUI_PERMANENT_UNLOCKS_AVAILABLE", f24_local0)
			end
		end
		f24_arg0.prestigeTokenText:setText(f24_local1)
		f24_arg0.prestigeTokenText:setLeftRight(false, true, -f24_arg2, -f24_arg2)
		if f24_arg0.prestigeTokenImage then
			if f24_local0 == 0 then
				f24_arg0.prestigeTokenImage:close()
			else
				local f24_local2, f24_local3, f24_local4, f24_local5 = GetTextDimensions(f24_local1, CoD.fonts.Default, CoD.textSize.Default)
				f24_arg0.prestigeTokenImage:setLeftRight(false, true, -f24_local4 - f24_arg2 - 2 - 32, -f24_local4 - f24_arg2 - 2)
				f24_arg0:addElement(f24_arg0.prestigeTokenImage)
			end
		end
	end
end

CoD.CAC.GetUnlockCountForGroup = function (f25_arg0, f25_arg1)
	return UIExpression.GetDStat(f25_arg0, "unlocks", UIExpression.GetUnlockIndexFromGroupName(nil, f25_arg1))
end

CoD.CAC.GetUnlockNameForGroup = function (f26_arg0)
	return Engine.Localize(UIExpression.GetUnlockLocString(nil, UIExpression.GetUnlockIndexFromGroupName(nil, f26_arg0)))
end

CoD.CAC.GetUnlockTokenText = function (f27_arg0, f27_arg1, f27_arg2, f27_arg3)
	local f27_local0 = f27_arg2
	if f27_arg3 ~= nil and f27_arg0 == 1 then
		f27_local0 = f27_arg3
	end
	local f27_local1 = UIExpression.GetUnlockLocString(nil, f27_arg1)
	return Engine.Localize(f27_local0, f27_arg0)
end

CoD.CAC.SetUnlockItemText = function (f28_arg0, f28_arg1)
	local f28_local0 = 0
	if f28_arg0.unlockTokenText ~= nil then
		local f28_local1 = f28_arg0.weaponGroup or "weapon_smg"
		local f28_local2 = CoD.CAC.GetUnlockTokenText(CoD.CAC.GetUnlockCountForGroup(f28_arg1, f28_local1), UIExpression.GetUnlockIndexFromGroupName(nil, f28_local1), "MPUI_UNLOCK_TOKENS_AVAILABLE", "MPUI_UNLOCK_TOKEN_AVAILABLE")
		f28_arg0.unlockTokenText:setText(f28_local2)
		if f28_arg0.tokenImage then
			local f28_local3, f28_local4, f28_local5, f28_local6 = GetTextDimensions(f28_local2, CoD.fonts.Default, CoD.textSize.Default)
			local f28_local7 = f28_local5
			f28_arg0.tokenImage:setLeftRight(false, true, -f28_local7 - 2 - 32, -f28_local7 - 2)
			f28_arg0:addElement(f28_arg0.tokenImage)
			f28_local0 = f28_local7 + 2 + 32 + 2
		end
	end
	CoD.CAC.SetPrestigeTokenText(f28_arg0, f28_arg1, f28_local0)
end

CoD.CAC.PurchaseItemIfPossible = function (f29_arg0, f29_arg1, f29_arg2)
	local f29_local0 = f29_arg2.itemIndex
	if UIExpression.IsItemPurchased(f29_arg1, f29_local0) == 0 then
		if CoD.CAC.CanAffordUnlocksForItemIndex(f29_arg1, f29_local0) == true then
			local f29_local1 = f29_arg0:openPopup("PurchaseConfirmation", f29_arg1)
			f29_local1.topRightTitle:setText(Engine.Localize(UIExpression.GetItemName(nil, f29_local0)))
			CoD.CAC.AddUnlockTokenText(f29_local1, UIExpression.GetItemGroup(nil, f29_local0), false, false, CoD.textSize.Default)
			CoD.CAC.SetUnlockItemText(f29_local1, f29_arg1)
			CoD.CAC.SetItemMaterialForItemIndex(f29_local1, f29_local0)
			f29_local1.itemGridButton = f29_arg2
			f29_local1.CAC = f29_arg0
			f29_arg0.popup = f29_local1
		else
			Engine.PlaySound(CoD.CACUtility.denySFX)
		end
	end
end

CoD.CAC.SetLockIcon = function (f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = LUI.UIImage.new()
	local f30_local1 = f30_arg1 / 2
	f30_local0:setLeftRight(false, false, -f30_local1, f30_local1)
	f30_local0:setTopBottom(false, false, -f30_local1, f30_local1)
	f30_local0:setImage(f30_arg2)
	f30_arg0:addElement(f30_local0)
	return f30_local0
end

CoD.CAC.SetTokenIcon = function (f31_arg0, f31_arg1)
	local f31_local0 = LUI.UIImage.new()
	local f31_local1 = 5
	local f31_local2 = -28
	local f31_local3 = 32
	f31_local0:setLeftRight(true, false, f31_local1, f31_local1 + f31_local3)
	f31_local0:setTopBottom(false, true, f31_local2 - f31_local3, f31_local2)
	f31_local0:setImage(f31_arg1)
	f31_arg0:addElement(f31_local0)
	return f31_local0
end

CoD.CAC.SetNewIcon = function (f32_arg0, f32_arg1)
	if f32_arg1 then
		if not f32_arg0.newIcon then
			local f32_local0 = 14
			
			local newIcon = LUI.UIImage.new()
			newIcon:setLeftRight(true, false, 8, 8 + CoD.CACUtility.ButtonGridNewImageWidth)
			newIcon:setTopBottom(true, false, f32_local0 - CoD.CACUtility.ButtonGridNewImageHeight / 2, f32_local0 + CoD.CACUtility.ButtonGridNewImageHeight / 2)
			newIcon:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
			f32_arg0:addElement(newIcon)
			f32_arg0.newIcon = newIcon
			
		end
	elseif f32_arg0.newIcon then
		f32_arg0.newIcon:close()
		f32_arg0.newIcon = nil
	end
end

CoD.CAC.SetPrestigeTokenButton = function (f33_arg0, f33_arg1, f33_arg2)
	if f33_arg0.prestigeTokenText ~= nil and f33_arg1 and f33_arg2 then
		if not Engine.IsItemPermanentlyUnlocked(f33_arg1, f33_arg2) and UIExpression.GetItemCost(nil, f33_arg2) > 0 then
			f33_arg0:dispatchEventToParent({
				name = "add_prestige_unlock_button"
			})
		else
			f33_arg0:dispatchEventToParent({
				name = "remove_prestige_unlock_button"
			})
		end
	end
end

CoD.CAC.CreateUnlockTokensFooter = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.SDSafeWidth / 2, CoD.SDSafeWidth / 2)
	Widget:setTopBottom(false, true, -CoD.ButtonPrompt.Height - 2 - 32, -CoD.ButtonPrompt.Height - 2)
	
	local unlockTokenText = LUI.UIText.new()
	unlockTokenText:setLeftRight(false, true, 0, 0)
	unlockTokenText:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	unlockTokenText:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget:addElement(unlockTokenText)
	Widget.unlockTokenText = unlockTokenText
	
	local f34_local2 = LUI.UIImage.new()
	f34_local2:setLeftRight(true, false, 0, 32)
	f34_local2:setTopBottom(false, false, -16, 16)
	f34_local2:setImage(RegisterMaterial("menu_mp_lobby_token_64"))
	Widget.tokenImage = f34_local2
	Widget:addElement(f34_local2)
	if InstanceRef then
		local f34_local3 = Engine.GetPermanentUnlockCount(InstanceRef)
		if f34_local3 and f34_local3 > 0 then
			local f34_local4 = Engine.Localize("MPUI_PERMANENT_UNLOCK_AVAILABLE", f34_local3)
			if f34_local3 > 1 then
				f34_local4 = Engine.Localize("MPUI_PERMANENT_UNLOCKS_AVAILABLE", f34_local3)
			end
			local prestigeTokenText = LUI.UIText.new()
			prestigeTokenText:setLeftRight(false, true, 0, 0)
			prestigeTokenText:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
			prestigeTokenText:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
			prestigeTokenText:setText(f34_local4)
			Widget:addElement(prestigeTokenText)
			Widget.prestigeTokenText = prestigeTokenText
			
			local f34_local6 = LUI.UIImage.new()
			f34_local6:setLeftRight(true, false, 0, 32)
			f34_local6:setTopBottom(false, false, -16, 16)
			f34_local6:setImage(RegisterMaterial("menu_prestige_unlock_token_64"))
			Widget:addElement(f34_local6)
			Widget.prestigeTokenImage = f34_local6
		end
	end
	Widget:registerEventHandler("purchased", function (f35_arg0, f35_arg1)
		CoD.CAC.SetUnlockItemText(f35_arg0, f35_arg1.controller)
	end)
	Widget:registerEventHandler("highlighted", function (f36_arg0, f36_arg1)
		CoD.CAC.SetPrestigeTokenButton(f36_arg0, f36_arg1.controller, f36_arg1.weaponItemIndex)
	end)
	return Widget
end

