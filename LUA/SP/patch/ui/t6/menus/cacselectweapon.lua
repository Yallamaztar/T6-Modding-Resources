require("T6.WeaponCarouselButton")
require("T6.CardCarousel")
require("T6.CategoryCarousel")
require("T6.Menus.CACUtility")
CoD.CACSelectWeapon = {}
CoD.CACSelectWeapon.descriptionFontName = "Default"
CoD.CACSelectWeapon.descriptionFont = CoD.fonts[CoD.CACSelectWeapon.descriptionFontName]
CoD.CACSelectWeapon.descriptionFontSize = CoD.textSize[CoD.CACSelectWeapon.descriptionFontName]
CoD.CACSelectWeapon.weaponFontName = "Condensed"
CoD.CACSelectWeapon.descriptionTop = CoD.textSize[CoD.CACSelectWeapon.weaponFontName]
CoD.CACSelectWeapon.ItemWidth = 192
CoD.CACSelectWeapon.ItemHeight = 146
CoD.CACSelectWeapon.HighlightedItemWidth = 384
CoD.CACSelectWeapon.HighlightedItemHeight = 242
CoD.CACSelectWeapon.weaponInfoSideBorder = 20
CoD.CACSelectWeapon.weaponInfoWidth = CoD.CACSelectWeapon.HighlightedItemWidth + 30
CoD.CACSelectWeapon.weaponInfoHeight = 110
CoD.CACSelectWeapon.CarouselHeight = CoD.CACSelectWeapon.HighlightedItemHeight + CoD.CardCarousel.MiniCarouselItemWidth
CoD.CACSelectWeapon.TypeHeight = 30
CoD.CACSelectWeapon.TypeCarouselVerticalOffset = CoD.Menu.TitleHeight
CoD.CACSelectWeapon.WeaponTypeTextSize = CoD.textSize.Condensed + CoD.CACUtility.ButtonGridNewImageHeight
CoD.CACSelectWeapon.CarouselTop = CoD.CACSelectWeapon.TypeCarouselVerticalOffset + CoD.CACSelectWeapon.TypeHeight + 60
CoD.CACSelectWeapon.InformationTop = CoD.CACSelectWeapon.CarouselTop + CoD.CACSelectWeapon.CarouselHeight + 30
CoD.CACSelectWeapon.CamolessWeaponGroups = {}
CoD.CACSelectWeapon.CamolessWeapons = {
	"WEAPON_METALSTORM",
	"WEAPON_MINIGUN",
	"WEAPON_MGL",
	"WEAPON_TITUS",
	"WEAPON_M1911",
	"WEAPON_BROWNINGHP",
	"WEAPON_MAKAROV",
	"WEAPON_RPG",
	"WEAPON_STINGER",
	"WEAPON_KNIFE_BALLISTIC_80S",
	"WEAPON_MINIGUN_80S",
	"WEAPON_M32",
	"WEAPON_CROSSBOW_80S"
}
LUI.createMenu.CACSelectWeaponMenu = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACSelectWeapon")
	f1_local0:addTitle(Engine.Localize("MENU_SELECT_WEAPON_CAPS"), LUI.Alignment.Center)
	f1_local0:setPreviousMenu("CACLoadOutMenu")
	f1_local0:setOwner(f1_arg0)
	f1_local0:registerEventHandler("carousel_category_changed", CoD.CACSelectWeapon.CarouselCategoryChanged)
	f1_local0:registerEventHandler("card_gain_focus", CoD.CACSelectWeapon.WeaponFocusChanged)
	f1_local0:registerEventHandler("weapon_selected", CoD.CACSelectWeapon.WeaponSelected)
	f1_local0:registerEventHandler("fade_out_carousel", CoD.CACSelectWeapon.FadeOutCarousel)
	f1_local0:registerEventHandler("gamepad_button", CoD.CACSelectWeapon.GamepadButton)
	local f1_local1 = CoD.CACSelectWeapon
	local f1_local2 = CoD.CACSelectWeapon
	local f1_local3, f1_local4 = CoD.CACUtility.GetCurrentSPMapDefaultWeapons(f1_arg0)
	f1_local2.defaultSecondary = f1_local4
	f1_local1.defaultPrimary = f1_local3
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACSelectWeapon.ButtonPromptBack)
	f1_local0.currentWeaponGroup = nil
	f1_local0.currentWeaponIndexTable = {}
	CoD.CACSelectWeapon.AddWeaponTypeCarousel(f1_local0)
	CoD.CACSelectWeapon.AddWeaponCarousel(f1_local0)
	CoD.CACSelectWeapon.AddWeaponInfo(f1_local0)
	CoD.CACSelectWeapon.setLoadout(f1_arg0, f1_local0, CoD.perController[f1_arg0].weaponSlot)
	return f1_local0
end

CoD.CACSelectWeapon.ButtonPromptBack = function (f2_arg0, f2_arg1)
	if f2_arg0.weaponCarousel then
		CoD.CACSelectWeapon.RemoveNewOnSelectedWeapon(f2_arg0.weaponCarousel)
		f2_arg0.weaponCarousel:clearAllItems()
	end
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.CACSelectWeapon.CreateWeaponTypeListener = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = f3_arg3:addCategory(f3_arg2, f3_arg1)
	if Engine.WeaponGroupHasNewItem(f3_arg0:getOwner(), f3_arg2) then
		f3_local0:addNewImage()
	end
	table.insert(f3_arg0.carouselGroups, f3_local0)
end

CoD.CACSelectWeapon.GamepadButton = function (f4_arg0, f4_arg1)
	if f4_arg1.button ~= "up" and f4_arg1.button ~= "down" and f4_arg1.button ~= "left" and f4_arg1.button ~= "right" then
		f4_arg0:dispatchEventToChildren(f4_arg1)
		return nil
	elseif f4_arg1.down == true and (f4_arg1.button == "left" or f4_arg1.button == "right") and f4_arg0.weaponCarousel then
		if CoD_CardCarousel_PerformEdgeBounce(f4_arg0.weaponCarousel, f4_arg1.button, f4_arg1.buttonRepeat) == true then
			return true
		else
			f4_arg0:dispatchEventToChildren(f4_arg1)
			return nil
		end
	else
		f4_arg0:dispatchEventToChildren(f4_arg1)
	end
end

CoD.CACSelectWeapon.AddWeaponTypeCarousel = function (f5_arg0)
	local f5_local0 = 50
	local f5_local1 = 200
	local f5_local2 = CoD.CACSelectWeapon.WeaponTypeTextSize
	local f5_local3 = CoD.Menu.TitleHeight
	local f5_local4 = CoD.CategoryCarousel.new({
		leftAnchor = true,
		rightAnchor = true,
		left = f5_local0,
		right = -f5_local0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local3,
		bottom = f5_local3 + f5_local2
	}, f5_local1, f5_local2, 50, CoD.MainMenu.CarouselScrollTime)
	f5_local4:setMouseRange(1)
	f5_arg0.carouselGroups = {}
	for f5_local8, f5_local9 in pairs(CoD.CACUtility.CommonWeapons) do
		if f5_local9.name and f5_local9.text then
			CoD.CACSelectWeapon.CreateWeaponTypeListener(f5_arg0, f5_local9.text, f5_local9.name, f5_local4)
		end
	end
	if UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, Dvar.ui_mapname:get(), 3) ~= "nineteeneighties" then
		for f5_local10, f5_local11 in pairs(CoD.CACUtility.TwentiesOnlyWeapons) do
			if f5_local11.name and f5_local11.text then
				CoD.CACSelectWeapon.CreateWeaponTypeListener(f5_arg0, f5_local11.text, f5_local11.name, f5_local4)
			end
		end
	else
		for f5_local10, f5_local11 in pairs(CoD.CACUtility.EightiesOnlyWeapons) do
			if f5_local11.name and f5_local11.text then
				CoD.CACSelectWeapon.CreateWeaponTypeListener(f5_arg0, f5_local11.text, f5_local11.name, f5_local4)
			end
		end
	end
	f5_arg0.weaponTypeCarousel = f5_local4
	f5_arg0:addElement(f5_local4)
end

CoD.CACSelectWeapon.AddWeaponCarousel = function (f6_arg0)
	local f6_local0 = 2
	local f6_local1 = 50
	local f6_local2 = 3
	local f6_local3 = f6_local1 * f6_local0 * f6_local2 + 100
	local f6_local4 = f6_local1 * (f6_local2 + 6)
	local f6_local5 = CoD.CardCarousel.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.CACSelectWeapon.CarouselTop,
		bottom = CoD.CACSelectWeapon.CarouselTop + CoD.CACSelectWeapon.CarouselHeight
	}, CoD.CACSelectWeapon.ItemWidth, CoD.CACSelectWeapon.ItemHeight, CoD.CACSelectWeapon.HighlightedItemWidth, CoD.CACSelectWeapon.HighlightedItemHeight, nil, true, true)
	f6_local5:setCardActionSFX("uin_loadout_edit_sel")
	f6_local5.horizontalList:registerEventHandler("transition_complete_move_carousel", CoD.CACSelectWeapon.CarouselFadeButton)
	f6_arg0.weaponCarousel = f6_local5
	f6_arg0:addElement(f6_local5)
	f6_arg0.weaponCarousel.horizontalList:processEvent({
		name = "gain_focus",
		controller = f6_arg0:getOwner()
	})
end

CoD.CACSelectWeapon.AddWeaponInfo = function (f7_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.CACSelectWeapon.weaponInfoWidth / 2, CoD.CACSelectWeapon.weaponInfoWidth / 2)
	Widget:setTopBottom(true, false, CoD.CACSelectWeapon.InformationTop, CoD.CACSelectWeapon.InformationTop + CoD.CACSelectWeapon.weaponInfoHeight)
	f7_arg0.hintText = CoD.HintText.new()
	f7_arg0.hintText:setLeftRight(true, true, 5, 0)
	f7_arg0.hintText:setTopBottom(true, false, 0, CoD.HintText.Height)
	f7_arg0.descriptionElements = LUI.UIElement.new()
	f7_arg0.descriptionElements:setLeftRight(true, true, 0, 0)
	f7_arg0.descriptionElements:setTopBottom(true, true, CoD.HintText.Height + 5, 0)
	CoD.CACUtility.SetupElementForItemInformation(f7_arg0.descriptionElements, CoD.CACSelectWeapon.weaponInfoWidth, CoD.textSize[CoD.CACUtility.ElementDescriptionFont] * 3 + 5, true, false, true)
	Widget:addElement(f7_arg0.hintText)
	Widget:addElement(f7_arg0.descriptionElements)
	f7_arg0:addElement(Widget)
end

CoD.CACSelectWeapon.PopulateWeaponCarousel = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	f8_arg2:beginAnimation("screen_fade_in")
	f8_arg2:setAlpha(1)
	local f8_local0 = CoD.GetUnlockablesByGroupName(f8_arg3)
	local f8_local1 = 0
	local f8_local2 = 0
	for f8_local6, f8_local7 in pairs(f8_local0) do
		local f8_local8 = CoD.WeaponCarouselButton.new(f8_arg2, f8_arg0, f8_local7, f8_arg3)
		f8_local8:setActionEventName("weapon_selected")
		if f8_local7 == f8_arg1.currentWeapon then
			f8_local8:setInUse(true)
			f8_local1 = f8_local6
		elseif f8_local7 == f8_arg1.otherWeapon then
			f8_local8:setInUse(true)
		else
			f8_local8:setInUse(false)
		end
		if f8_local7 == CoD.CACSelectWeapon.defaultPrimary or f8_local7 == CoD.CACSelectWeapon.defaultSecondary then
			f8_local8:setRecommended(true)
		end
		if UIExpression.IsItemLocked(f8_arg0, f8_local7) ~= 0 then
			f8_local8:setLocked(true)
		else
			f8_local8:setLocked(false)
		end
		if Engine.IsItemNew(f8_arg0, f8_local7) then
			f8_local2 = f8_local6
			f8_local8:setNew(true)
		else
			f8_local8:setNew(false)
		end
	end
	f8_local3 = f8_arg4[f8_arg3]
	if f8_local3 ~= nil and f8_local3 <= f8_arg2:getNumCards() then
		f8_arg2.horizontalList.cards[f8_local3]:processEvent({
			name = "gain_focus"
		})
	elseif f8_local1 ~= 0 then
		f8_arg2.horizontalList.cards[f8_local1]:processEvent({
			name = "gain_focus"
		})
	elseif f8_local2 ~= 0 then
		f8_arg2.horizontalList.cards[f8_local2]:processEvent({
			name = "gain_focus"
		})
	elseif f8_arg2.horizontalList.cards and f8_arg2.horizontalList.cards[1] then
		f8_arg2.horizontalList.cards[1]:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.CACSelectWeapon.CarouselFadeButton = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0.m_currentCardIndex
	local f9_local1 = f9_arg0.cards
	for f9_local2 = 1, #f9_local1, 1 do
		if math.abs(f9_local0 - f9_local2) > 1 then
			f9_local1[f9_local2]:animateToState("fade_out", 25)
		end
		if f9_local2 ~= f9_local0 then
			f9_local1[f9_local2]:animateToState("fade_default", 50)
		else
			f9_local1[f9_local2]:animateToState("fade_in", 50)
		end
	end
end

CoD.CACSelectWeapon.RemoveNewOnSelectedWeapon = function (f10_arg0)
	if f10_arg0 then
		local f10_local0 = f10_arg0.horizontalList
		if f10_local0 ~= nil then
			local f10_local1 = f10_local0.m_currentCardIndex
			if f10_local1 then
				local f10_local2 = f10_local0.cards[f10_local1]
				if f10_local2.newImage then
					Engine.SetItemAsOld(UIExpression.GetPrimaryController(), f10_local2.itemIndex)
					f10_local2:setNew(false)
				end
			end
		end
	end
end

CoD.CACSelectWeapon.CarouselCategoryChanged = function (f11_arg0, f11_arg1)
	if f11_arg0.currentWeaponGroup == f11_arg1.category and f11_arg1.category ~= nil then
		return 
	end
	local f11_local0 = f11_arg0.weaponCarousel
	local f11_local1 = f11_arg0.currentWeaponIndexTable
	if f11_arg0.currentWeaponGroup and f11_local0.horizontalList ~= nil then
		f11_local1[f11_arg0.currentWeaponGroup] = f11_local0.horizontalList.m_currentCardIndex
	end
	CoD.CACSelectWeapon.RemoveNewOnSelectedWeapon(f11_local0)
	f11_local0:clearAllItems()
	if f11_arg0.currentWeaponGroup ~= nil then
		for f11_local5, f11_local6 in ipairs(f11_arg0.carouselGroups) do
			if f11_local6 and f11_local6.category == f11_arg0.currentWeaponGroup and not Engine.WeaponGroupHasNewItem(f11_arg0:getOwner(), f11_local6.category) and f11_local6.newImage then
				f11_local6:removeNewImage()
			end
		end
	end
	CoD.CACSelectWeapon.PopulateWeaponCarousel(f11_arg0.m_ownerController, f11_arg0, f11_local0, f11_arg1.category, f11_local1)
	if f11_local0:getNumCards() == 0 then
		CoD.CACUtility.UpdateElementWithItemInformation(f11_arg0.descriptionElements, CoD.CACSelectWeapon.weaponInfoWidth, "", "", "", 0)
	end
	f11_arg0.currentWeaponGroup = f11_arg1.category
end

CoD.CACSelectWeapon.WeaponFocusChanged = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1.card.displayName
	local f12_local1 = ""
	local f12_local2 = nil
	if not f12_arg1.card.lockImage then
		f12_local1 = f12_arg1.card.description
		f12_local2 = f12_arg1.card.itemIndex
	end
	local f12_local3 = ""
	if f12_arg1.card.itemIndex == CoD.CACSelectWeapon.defaultPrimary or f12_arg1.card.itemIndex == CoD.CACSelectWeapon.defaultSecondary then
		f12_local3 = Engine.Localize("SPUI_RECOMMENDED")
	end
	if f12_arg0.currentWeaponGroup ~= nil then
		for f12_local7, f12_local8 in ipairs(f12_arg0.carouselGroups) do
			if f12_local8 and f12_local8.weaponGroup == f12_arg0.currentWeaponGroup and not Engine.WeaponGroupHasNewItem(f12_arg0:getOwner(), f12_local8.weaponGroup) and f12_local8.image then
				f12_local8:removeElement(f12_local8.image)
				f12_local8.image:close()
				f12_local8.image = nil
			end
		end
	end
	CoD.CACUtility.UpdateElementWithItemInformation(f12_arg0.descriptionElements, CoD.CACSelectWeapon.weaponInfoWidth, f12_local0, f12_local1, f12_local3, f12_local2)
	f12_arg0.hintText:updateText(f12_arg1.hintText)
	f12_arg0.hintText:updateImage(f12_arg1.hintImage)
end

CoD.CACSelectWeapon.WeaponSelected = function (f13_arg0, f13_arg1)
	if UIExpression.IsItemLocked(f13_arg1.controller, f13_arg1.button.itemIndex) ~= 0 then
		LUI.UIButton.setActionSFX(f13_arg1.button, CoD.CACUtility.denySFX)
		return 
	elseif f13_arg1.button.newImage then
		Engine.SetItemAsOld(f13_arg1.controller, f13_arg1.button.itemIndex)
		f13_arg1.button:setNew(false)
	end
	local f13_local0 = CoD.perController[f13_arg1.controller].classNumInternal
	local f13_local1 = f13_arg0.loadoutSlot
	if f13_local0 == nil then
		f13_local0 = 0
	end
	if f13_arg1.button.itemIndex == f13_arg0.otherWeapon then
		return 
	elseif f13_arg1.button.itemIndex ~= f13_arg0.currentWeapon then
		CoD.SetClassItem(f13_arg1.controller, f13_local0, f13_local1, f13_arg1.button.itemIndex)
	end
	local f13_local2 = true
	for f13_local6, f13_local7 in pairs(CoD.CACSelectWeapon.CamolessWeaponGroups) do
		if f13_local7 == f13_arg1.button.weaponGroup then
			f13_local2 = false
		end
	end
	for f13_local6, f13_local7 in pairs(CoD.CACSelectWeapon.CamolessWeapons) do
		if f13_local7 == f13_arg1.button.name then
			f13_local2 = false
		end
	end
	if f13_local2 then
		f13_local3 = f13_arg0:swapMenu("CACSelectCamo", f13_arg1.controller)
		f13_local3:setPreviousMenu("CACSelectWeaponMenu")
	else
		f13_local3 = f13_arg0:swapMenu("CACLoadOutMenu", f13_arg1.controller)
		if 0 ~= Dvar.ui_campaignstate:get() then
			f13_local3:setPreviousMenu("CampaignMissionBriefingMenu")
		else
			f13_local3:setPreviousMenu("MissionBriefingMenu")
		end
	end
end

CoD.CACSelectWeapon.FadeOutCarousel = function (f14_arg0, f14_arg1)
	f14_arg0.weaponCarousel:beginAnimation("screen_fade_out", f14_arg1.duration)
	f14_arg0.weaponCarousel:setAlpha(0)
end

CoD.CACSelectWeapon.setLoadout = function (f15_arg0, f15_arg1, f15_arg2)
	f15_arg1.loadoutSlot = f15_arg2
	local f15_local0 = CoD.perController[f15_arg0].classNumInternal
	if f15_arg2 == CoD.CACUtility.loadoutSlotNames.primaryWeapon then
		f15_arg1.currentWeapon = CoD.GetClassItem(f15_arg1:getOwner(), f15_local0, CoD.CACUtility.loadoutSlotNames.primaryWeapon)
		f15_arg1.otherWeapon = CoD.GetClassItem(f15_arg1:getOwner(), f15_local0, CoD.CACUtility.loadoutSlotNames.secondaryWeapon)
	elseif f15_arg2 == CoD.CACUtility.loadoutSlotNames.secondaryWeapon then
		f15_arg1.currentWeapon = CoD.GetClassItem(f15_arg1:getOwner(), f15_local0, CoD.CACUtility.loadoutSlotNames.secondaryWeapon)
		f15_arg1.otherWeapon = CoD.GetClassItem(f15_arg1:getOwner(), f15_local0, CoD.CACUtility.loadoutSlotNames.primaryWeapon)
	end
	local f15_local1 = UIExpression.GetItemGroup(nil, f15_arg1.currentWeapon)
	f15_arg1.currentWeaponIndexTable = {}
	f15_arg1.currentWeaponGroup = nil
	for f15_local5, f15_local6 in ipairs(f15_arg1.carouselGroups) do
		if f15_local6 ~= nil and f15_local6.category == f15_local1 then
			f15_arg1.weaponTypeCarousel:setStartItem(f15_local5)
			return 
		end
	end
end

