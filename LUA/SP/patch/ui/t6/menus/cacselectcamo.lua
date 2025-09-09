require("T6.CamoGridButton")
require("T6.Unlockables")
CoD.CACSelectCamo = {}
CoD.CACSelectCamo.GridTop = 50
CoD.CACSelectCamo.GridColumns = 6
CoD.CACSelectCamo.GridItemSpacing = 14
CoD.CACSelectCamo.GridWidth = CoD.Menu.Width * 0.85
CoD.CACSelectCamo.GridItemWidth = (CoD.CACSelectCamo.GridWidth - CoD.CACSelectCamo.GridItemSpacing * (CoD.CACSelectCamo.GridColumns - 1)) / CoD.CACSelectCamo.GridColumns
CoD.CACSelectCamo.GridItemHeight = 65
CoD.CACSelectCamo.AnimationTime = 300
CoD.CACSelectCamo.defaultAttachments = {}
LUI.createMenu.CACSelectCamo = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACSelectCamo")
	f1_local0:setOwner(f1_arg0)
	local f1_local1 = CoD.perController[f1_arg0].classNumInternal
	local f1_local2 = CoD.perController[f1_arg0].weaponSlot
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACSelectCamo.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACSelectCamo.ContentButtonSelected)
	f1_local0:registerEventHandler("show_grid", CoD.CACSelectCamo.ShowGrid)
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACSelectCamo.ButtonPromptBack)
	local f1_local3 = CoD.CACSelectCamo.GridTop
	local f1_local4 = CoD.GetClassItem(f1_arg0, f1_local1, f1_local2)
	local f1_local5 = 364
	local f1_local6 = f1_local5 / 1.9
	local f1_local7 = -10
	local f1_local8 = 155
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local5 / 2 + f1_local7, f1_local5 / 2 + f1_local7)
	Widget:setTopBottom(true, false, f1_local8, f1_local8 + f1_local6)
	f1_local0:addElement(Widget)
	local f1_local10 = LUI.UIImage.new()
	f1_local10:setLeftRight(true, true, 0, 0)
	f1_local10:setTopBottom(true, true, 0, 0)
	f1_local10:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f1_local4) .. "_big"))
	Widget:addElement(f1_local10)
	f1_local0:addTitle(Engine.Localize("MENU_SELECT_CAMO_CAPS", UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f1_local4)))), LUI.Alignment.Center)
	Widget:beginAnimation("move", CoD.CACSelectCamo.AnimationTime)
	Widget:setTopBottom(true, false, f1_local3, f1_local3 + f1_local6)
	f1_local3 = f1_local3 + f1_local6 + 5
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACSelectCamo.GridColumns, {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.CACSelectCamo.GridWidth / 2,
		right = CoD.CACSelectCamo.GridWidth / 2,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local3,
		bottom = 0
	}, CoD.CACSelectCamo.GridItemWidth, CoD.CACSelectCamo.GridItemHeight, CoD.CACSelectCamo.GridItemSpacing)
	f1_local0.contentGrid.m_inputDisabled = true
	f1_local0.contentGrid:setAlpha(0)
	f1_local0:addElement(f1_local0.contentGrid)
	f1_local3 = f1_local3 + CoD.CACSelectCamo.GridItemHeight * 3 + CoD.CACSelectCamo.GridItemSpacing * 2 + 6
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(false, false, -CoD.CACSelectCamo.GridWidth / 2, CoD.CACSelectCamo.GridWidth / 2)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local3, f1_local3 + CoD.HintText.Height)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local3 = f1_local3 + CoD.HintText.Height + 12
	CoD.CACSelectCamo.AddCamoSwatches(f1_local0, f1_arg0, CoD.perController[f1_arg0].classNumInternal, f1_local2)
	f1_local0:addElement(LUI.UITimer.new(CoD.CACSelectCamo.AnimationTime / 2, "show_grid", true, f1_local0))
	return f1_local0
end

CoD.CACSelectCamo.ShowGrid = function (f2_arg0, f2_arg1)
	f2_arg0.contentGrid:beginAnimation("show", CoD.CACSelectCamo.AnimationTime / 2)
	f2_arg0.contentGrid:setAlpha(1)
	f2_arg0.contentGrid.m_inputDisabled = false
end

CoD.CACSelectCamo.AddCamoSwatches = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = Engine.GetCustomClass(f3_arg1, CoD.perController[f3_arg1].classNumInternal)
	local f3_local1 = f3_local0[f3_arg3]
	local f3_local2 = {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}
	local f3_local3 = Engine.GetNumWeaponOptions(CoD.CACUtility.weaponGroupNames.camo)
	local f3_local4 = nil
	for f3_local5 = 1, f3_local3, 1 do
		local f3_local8 = CoD.CamoGridButton.new(f3_local5, CoD.Unlockables.IsCamoUnlocked(f3_local5 - 1))
		f3_arg0.contentGrid:addButton(f3_local8)
		f3_local8:setupButtonImages()
		if not f3_local4 then
			f3_local4 = f3_local8
		end
	end
	f3_arg0.contentGrid:dispatchEventToChildren({
		name = "update_class",
		selectedItem = f3_local0[f3_arg3 .. "camo"],
		controller = f3_arg1
	})
	f3_local4:processEvent({
		name = "gain_focus"
	})
end

CoD.CACSelectCamo.ButtonPromptBack = function (f4_arg0, f4_arg1)
	if f4_arg0.highlightedButton ~= nil then
		f4_arg0.highlightedButton:setNew(false, f4_arg1.controller)
	end
	f4_arg0:goBack(f4_arg1.controller)
end

CoD.CACSelectCamo.ContentButtonHighlighted = function (f5_arg0, f5_arg1)
	f5_arg0.hintTextElement:updateText(f5_arg1.hintText)
	f5_arg0.highlightedButton = f5_arg1.button
end

CoD.CACSelectCamo.ContentButtonSelected = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	local f6_local1 = CoD.perController[f6_local0].classNumInternal
	local f6_local2 = CoD.perController[f6_local0].weaponSlot
	local f6_local3 = f6_arg1.contentIndex
	if f6_local3 then
		Engine.PlaySound(CoD.CACUtility.EquipSFX)
		Engine.SetClassItem(f6_local0, f6_local1, f6_local2 .. "camo", f6_local3)
	end
	local f6_local4 = f6_arg0:swapMenu("CACLoadOutMenu", f6_arg1.controller)
	if Dvar.ui_campaignstate:get() ~= 0 then
		f6_local4:setPreviousMenu("CampaignMissionBriefingMenu")
	else
		f6_local4:setPreviousMenu("MissionBriefingMenu")
	end
end

