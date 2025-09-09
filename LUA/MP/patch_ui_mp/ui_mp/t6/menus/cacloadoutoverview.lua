CoD.LoadoutButton = {}
CoD.LoadoutWeaponButton = {}
CoD.LoadoutOverview = {}
CoD.LoadoutOverview.width = 580
CoD.LoadoutOverview.height = 600
function CACLoadoutOverview_ButtonPromptLoadoutOverview(f1_arg0, f1_arg1)
	if f1_arg0:isInFocus() then

	else

	end
end

function CACLoadoutOverview_ButtonPromptBack(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.CAC
	local f2_local1 = f2_local0:getPanel("ClassSelection")
	local f2_local2 = CoD.perController[f2_arg1.controller].classNumInternal
	f2_local0.popup:closePopup(nil, true, f2_local0)
	f2_local1.classButtons[f2_local2 + 1]:processEvent({
		name = "gain_focus"
	})
end

function CACLoadoutOverview_LoadoutButtonGainFocus(f3_arg0, f3_arg1)
	LUI.UIButton.gainFocus(f3_arg0, f3_arg1)
	f3_arg0.highlight:animateToState("show")
end

function CACLoadoutOverview_LoadoutButtonLoseFocus(f4_arg0, f4_arg1)
	LUI.UIButton.loseFocus(f4_arg0, f4_arg1)
	f4_arg0.highlight:animateToState("hide")
end

function CACLoadoutOverview_LoadoutButtonAction(f5_arg0, f5_arg1)

end

function CACLoadoutOverview_PopulateWeaponButton(f6_arg0, f6_arg1, f6_arg2)
	f6_arg0:animateToState("hide")
	f6_arg0:makeNotFocusable()
	if f6_arg1 ~= nil then
		CACLoadoutOverview_PopulateButton(f6_arg0, f6_arg1[1], f6_arg2)
	end
end

function CACLoadoutOverview_PopulateButton(f7_arg0, f7_arg1, f7_arg2)
	f7_arg0:animateToState("hide")
	f7_arg0:makeNotFocusable()
	if f7_arg1 ~= nil then
		f7_arg0:animateToState("show")
		f7_arg0:makeFocusable()
		if f7_arg0.name ~= nil then
			f7_arg0.name:setText(UIExpression.ToUpper(nil, Engine.Localize(f7_arg1.name)))
		end
		if f7_arg0.image ~= nil then
			f7_arg0.image:registerAnimationState("material_change", {
				material = f7_arg1.material,
				alpha = 1
			})
			f7_arg0.image:animateToState("material_change")
		end
		if f7_arg0.costLabel ~= nil then
			f7_arg0.costLabel:setText(f7_arg1.cost)
		end
		f7_arg0.cost = f7_arg1.cost
		f7_arg0.itemIndex = f7_arg1.itemIndex
		if f7_arg2 ~= nil and f7_arg0.attachmentNames ~= nil then
			CoD.PopulateWeaponAttachmentInfo(f7_arg2, f7_arg0.attachmentNames)
		end
	end
end

CoD.LoadoutButton.new = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	if f8_arg1 == nil then
		f8_arg1 = 0
	end
	if f8_arg2 == nil then
		f8_arg2 = 0
	end
	local f8_local0 = LUI.UIButton.new(f8_arg3, f8_arg4)
	f8_local0.id = f8_local0.id .. "." .. f8_arg0
	f8_local0.bgImage = LUI.UIImage.new({
		left = f8_arg1,
		top = f8_arg1,
		right = -f8_arg1,
		bottom = -f8_arg1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.1
	})
	f8_local0:addElement(f8_local0.bgImage)
	f8_local0.highlight = LUI.UIImage.new({
		left = f8_arg1,
		top = f8_arg1,
		right = -f8_arg1,
		bottom = -f8_arg1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("lui_overlay_glow"),
		alpha = 0
	})
	f8_local0.highlight:registerAnimationState("show", {
		alpha = 1
	})
	f8_local0.highlight:registerAnimationState("hide", {
		alpha = 0
	})
	f8_local0:addElement(f8_local0.highlight)
	f8_local0.brackets = CoD.Brackets.new(12, CoD.green.r, CoD.green.g, CoD.green.b, 1)
	f8_local0.highlight:addElement(f8_local0.brackets)
	f8_local0.image = LUI.UIImage.new({
		left = f8_arg2,
		top = 0,
		right = f8_arg2,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f8_local0:addElement(f8_local0.image)
	f8_local0.costLabel = LUI.UIText.new({
		left = -f8_arg1 - 1,
		top = -f8_arg1 - CoD.textSize.Default,
		right = -f8_arg1,
		bottom = -f8_arg1,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Default
	})
	f8_local0:addElement(f8_local0.costLabel)
	f8_local0:registerAnimationState("show", {
		alpha = 1
	})
	f8_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f8_local0:registerEventHandler("gain_focus", CACLoadoutOverview_LoadoutButtonGainFocus)
	f8_local0:registerEventHandler("lose_focus", CACLoadoutOverview_LoadoutButtonLoseFocus)
	f8_local0:registerEventHandler("button_action", CACLoadoutOverview_LoadoutButtonAction)
	return f8_local0
end

CoD.LoadoutWeaponButton.new = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = CoD.LoadoutButton.new(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	f9_local0.costLabel:registerAnimationState("default", {
		left = -f9_arg1 - 1,
		top = -f9_arg1 - CoD.textSize.Big,
		right = -f9_arg1,
		bottom = -f9_arg1,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Big
	})
	f9_local0.costLabel:animateToState("default")
	f9_local0.name = LUI.UIText.new({
		left = -f9_arg1 - 1,
		top = 0,
		right = -f9_arg1,
		bottom = CoD.textSize.Big,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Big
	})
	f9_local0:addElement(f9_local0.name)
	f9_local0.attachmentNames = {}
	local f9_local1 = CoD.textSize.Big
	for f9_local2 = 1, CoD.CACUtility.maxAttachments, 1 do
		f9_local0.attachmentNames[f9_local2] = LUI.UIText.new({
			left = -f9_arg1 - 1,
			top = f9_local1,
			right = -f9_arg1,
			bottom = f9_local1 + CoD.textSize.Default,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alpha = 0.2,
			font = CoD.fonts.Default
		})
		f9_local0:addElement(f9_local0.attachmentNames[f9_local2])
		f9_local1 = f9_local1 + CoD.textSize.Default
	end
	return f9_local0
end

function CACLoadoutOverview_AddElements(f10_arg0)
	local f10_local0 = 10
	f10_arg0.body.overviewList = LUI.UIVerticalList.new({
		left = 0,
		top = f10_local0,
		right = -f10_local0,
		bottom = -CoD.AllocationSubtitle.Height - f10_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("menu_mp_tab_frame_inner"),
		spacing = 5
	})
	f10_arg0.body.overviewList.id = "UIVerticalList.OverviewList"
	f10_arg0.body:addElement(f10_arg0.body.overviewList)
	local f10_local1 = 50
	local f10_local2 = 4
	local f10_local3 = 300
	local f10_local4 = 150
	local f10_local5 = 0
	local f10_local6 = -30
	f10_arg0.body.primaryWeaponList = LUI.UIHorizontalList.new({
		left = -CoD.LoadoutOverview.width,
		top = 0,
		right = 0,
		bottom = f10_local4,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alignment = LUI.Alignment.Right
	})
	f10_arg0.body.primaryWeaponList.id = "UIHorizontalList.PrimaryWeaponList"
	f10_arg0.body.primaryWeaponList:makeFocusable()
	f10_arg0.body.overviewList:addElement(f10_arg0.body.primaryWeaponList)
	f10_arg0.body.secondaryWeaponList = LUI.UIHorizontalList.new({
		left = -CoD.LoadoutOverview.width,
		top = 0,
		right = 0,
		bottom = f10_local4,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alignment = LUI.Alignment.Right
	})
	f10_arg0.body.secondaryWeaponList.id = "UIHorizontalList.SecondaryWeaponList"
	f10_arg0.body.secondaryWeaponList:makeFocusable()
	f10_arg0.body.overviewList:addElement(f10_arg0.body.secondaryWeaponList)
	f10_arg0.body.grenadeNames = LUI.UIText.new({
		left = -CoD.LoadoutOverview.width,
		top = 0,
		right = 0,
		bottom = CoD.textSize.Default,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	f10_arg0.body.overviewList:addElement(f10_arg0.body.grenadeNames)
	local f10_local7 = 60
	local f10_local8 = 0
	f10_arg0.body.grenadeList = LUI.UIHorizontalList.new({
		left = -CoD.LoadoutOverview.width,
		top = 0,
		right = 0,
		bottom = f10_local7,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alignment = LUI.Alignment.Right,
		spacing = 2
	})
	f10_arg0.body.grenadeList.id = "UIHorizontalList.grenadeList"
	f10_arg0.body.grenadeList:makeFocusable()
	f10_arg0.body.overviewList:addElement(f10_arg0.body.grenadeList)
	f10_arg0.body.perkName = LUI.UIText.new({
		left = -CoD.LoadoutOverview.width,
		top = 0,
		right = 0,
		bottom = CoD.textSize.Default,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	f10_arg0.body.overviewList:addElement(f10_arg0.body.perkName)
	local f10_local9 = 50
	local f10_local10 = 0
	f10_arg0.body.perkList = LUI.UIHorizontalList.new({
		left = -CoD.LoadoutOverview.width,
		top = 0,
		right = 0,
		bottom = f10_local9,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alignment = LUI.Alignment.Right,
		spacing = 2
	})
	f10_arg0.body.perkList.id = "UIHorizontalList.perkList"
	f10_arg0.body.perkList:makeFocusable()
	f10_arg0.body.overviewList:addElement(f10_arg0.body.perkList)
	local f10_local11 = {
		left = 0,
		top = -f10_local1,
		right = f10_local1,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	}
	local f10_local12 = {
		left = 0,
		top = 0,
		right = f10_local3,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}
	f10_arg0.body.primaryWeapon = CoD.LoadoutWeaponButton.new("primary_weapon", f10_local5, f10_local6, f10_local12)
	f10_arg0.body.primaryWeaponList:addElement(f10_arg0.body.primaryWeapon)
	f10_arg0.body.primaryAttachments = {}
	for f10_local13 = 1, CoD.CACUtility.maxAttachments, 1 do
		f10_arg0.body.primaryAttachments[f10_local13] = CoD.LoadoutButton.new("primary_attachment_" .. f10_local13, f10_local2, 0, f10_local11)
		f10_arg0.body.primaryWeaponList:addElement(f10_arg0.body.primaryAttachments[f10_local13])
	end
	f10_arg0.body.secondaryWeapon = CoD.LoadoutWeaponButton.new("secondary_weapon", f10_local5, f10_local6, f10_local12)
	f10_arg0.body.secondaryWeaponList:addElement(f10_arg0.body.secondaryWeapon)
	f10_arg0.body.secondaryAttachments = {}
	for f10_local13 = 1, CoD.CACUtility.maxAttachments, 1 do
		f10_arg0.body.secondaryAttachments[f10_local13] = CoD.LoadoutButton.new("secondary_attachment_" .. f10_local13, f10_local2, 0, f10_local11)
		f10_arg0.body.secondaryWeaponList:addElement(f10_arg0.body.secondaryAttachments[f10_local13])
	end
	local f10_local13 = {
		left = 0,
		top = -f10_local7,
		right = f10_local7,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	}
	f10_arg0.body.grenades = {}
	for f10_local14 = 1, CoD.CACUtility.maxGrenades, 1 do
		f10_arg0.body.grenades[f10_local14] = CoD.LoadoutButton.new("grenade_" .. f10_local14, f10_local8, 0, f10_local13)
		f10_arg0.body.grenadeList:addElement(f10_arg0.body.grenades[f10_local14])
	end
	local f10_local14 = {
		left = 0,
		top = -f10_local9,
		right = f10_local9,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	}
	f10_arg0.body.perks = {}
	for f10_local15 = 1, CoD.CACUtility.maxPerks, 1 do
		f10_arg0.body.perks[f10_local15] = CoD.LoadoutButton.new("perk_" .. f10_local15, f10_local10, 0, f10_local14)
		f10_arg0.body.perkList:addElement(f10_arg0.body.perks[f10_local15])
	end
end

function CACLoadoutOverview_PopulateElements(f11_arg0, f11_arg1)
	if f11_arg1 == nil then
		f11_arg1 = CoD.CACUtility.GetClassData(f11_arg0.controller)
	end
	CACLoadoutOverview_PopulateWeaponButton(f11_arg0.body.primaryWeapon, f11_arg1.primaryWeapon, f11_arg1.primaryAttachments)
	CACLoadoutOverview_PopulateWeaponButton(f11_arg0.body.secondaryWeapon, f11_arg1.secondaryWeapon, f11_arg1.secondaryAttachments)
	for f11_local0 = 1, CoD.CACUtility.maxAttachments, 1 do
		CACLoadoutOverview_PopulateButton(f11_arg0.body.primaryAttachments[f11_local0], f11_arg1.primaryAttachments[f11_local0])
		CACLoadoutOverview_PopulateButton(f11_arg0.body.secondaryAttachments[f11_local0], f11_arg1.secondaryAttachments[f11_local0])
	end
	CoD.PopulateGrenadeLabel(f11_arg1.grenades, f11_arg0.body.grenadeNames)
	for f11_local0 = 1, CoD.CACUtility.maxGrenades, 1 do
		CACLoadoutOverview_PopulateButton(f11_arg0.body.grenades[f11_local0], f11_arg1.grenades[f11_local0])
	end
	for f11_local0 = 1, CoD.CACUtility.maxPerks, 1 do
		CACLoadoutOverview_PopulateButton(f11_arg0.body.perks[f11_local0], f11_arg1.perks[f11_local0])
	end
end

function CACLoadoutOverview_AnyChildFocusable(f12_arg0)
	local f12_local0 = f12_arg0:getFirstChild()
	while f12_local0 do
		if f12_local0.m_focusable then
			return true
		end
		f12_local0 = f12_local0:getNextSibling()
	end
	return false
end

function CACLoadoutOverview_UpdateNavigation(f13_arg0)
	if not CACLoadoutOverview_AnyChildFocusable(f13_arg0.body.primaryWeaponList) then
		f13_arg0.body.primaryWeaponList:makeNotFocusable()
	end
	if not CACLoadoutOverview_AnyChildFocusable(f13_arg0.body.secondaryWeaponList) then
		f13_arg0.body.secondaryWeaponList:makeNotFocusable()
	end
	if not CACLoadoutOverview_AnyChildFocusable(f13_arg0.body.grenadeList) then
		f13_arg0.body.grenadeList:makeNotFocusable()
	end
	if not CACLoadoutOverview_AnyChildFocusable(f13_arg0.body.perkList) then
		f13_arg0.body.perkList:makeNotFocusable()
	end
	LUI.UIVerticalList.UpdateNavigation(f13_arg0.body.overviewList)
	LUI.UIHorizontalList.UpdateNavigation(f13_arg0.body.primaryWeaponList)
	LUI.UIHorizontalList.UpdateNavigation(f13_arg0.body.secondaryWeaponList)
	LUI.UIHorizontalList.UpdateNavigation(f13_arg0.body.grenadeList)
	LUI.UIHorizontalList.UpdateNavigation(f13_arg0.body.perkList)
end

CoD.CAC.OpenLoadoutOverview = function (f14_arg0, f14_arg1)
	local f14_local0 = CoD.MFPopup.new(f14_arg0, CoD.LoadoutOverview.width, CoD.LoadoutOverview.height, Engine.Localize("MENU_LOADOUT_OVERVIEW_CAPS"))
	f14_local0.id = "MFPopup.LoadoutOverview"
	f14_local0:addBackButton()
	f14_local0.body.background:close()
	f14_local0.body.backgroundImage = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = -CoD.AllocationSubtitle.Height - 2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("menu_mp_tab_frame_inner")
	})
	f14_local0.body:addElement(f14_local0.body.backgroundImage)
	f14_local0:registerEventHandler("button_prompt_back", CACLoadoutOverview_ButtonPromptBack)
	f14_local0.CAC = f14_arg0
	f14_arg0.popup = f14_local0
	CACLoadoutOverview_AddElements(f14_local0)
	local f14_local1 = CoD.CACUtility.GetClassData(f14_arg1)
	f14_local0.controller = f14_arg1
	CACLoadoutOverview_PopulateElements(f14_local0, f14_local1)
	CACLoadoutOverview_UpdateNavigation(f14_local0)
	f14_local0.body.overviewList:processEvent({
		name = "gain_focus"
	})
	f14_local0.body.allocationBackgroundImage = LUI.UIImage.new({
		left = 0,
		top = -CoD.AllocationSubtitle.Height,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("lui_overlay_combatload")
	})
	f14_local0.body:addElement(f14_local0.body.allocationBackgroundImage)
	local f14_local2 = 12
	f14_local0:openPopup(nil, true, f14_arg0)
	return f14_local0
end

