require("T6.Drc.DrcPanelButton")
CoD.DrcRadioButtonList = {}
CoD.DrcRadioButtonList.RadioButtonActionEvent = "radio_button_action"
CoD.DrcRadioButtonList.RadioButtonItemSelected = "radio_button_item_selected"
CoD.DrcRadioButtonList.DefaultTypeParams = {
	containerType = LUI.UIHorizontalList,
	itemWidth = 190,
	itemHeight = 90,
	wedgeLeftRight = {
		true,
		true,
		0,
		0
	},
	wedgeTopBottom = {
		true,
		true,
		-20,
		24
	},
	labelLeftRight = {
		true,
		true,
		32,
		0
	},
	labelTopBottom = {
		true,
		false,
		30,
		30 + CoD.CoD9Button.TextHeight
	},
	confirmText = Engine.Localize("PLATFORM_CONFIRM_CAPS")
}
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg1 == f1_arg0.candidateButton then
		f1_arg1:setLabel(f1_arg0.typeParams.confirmText)
	else
		f1_arg1:setLabel(f1_arg1.labelText)
	end
	if f1_arg1 == f1_arg0.candidateButton or f1_arg1 == f1_arg0.selectedButton then
		f1_arg1.label:setRGB(CoD.DrcOptionElement.HighlightColor.red, CoD.DrcOptionElement.HighlightColor.green, CoD.DrcOptionElement.HighlightColor.blue)
	else
		f1_arg1.label:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	end
	if f1_arg1 ~= f1_arg0.candidateButton then
		CoD.DrcPanelButton.ButtonUp(f1_arg1.button)
	else
		CoD.DrcPanelButton.ButtonDown(f1_arg1.button)
	end
	local f1_local0 = nil
	if f1_arg0.candidateButton ~= nil then
		f1_local0 = f1_arg0.candidateButton.hintText
	elseif f1_arg0.selectedButton ~= nil then
		f1_local0 = f1_arg0.selectedButton.hintText
	end
	if f1_arg0.hintText ~= nil then
		if f1_local0 ~= nil then
			f1_arg0.hintText:updateText(f1_local0)
		else
			f1_arg0.hintText:removeText()
		end
	end
end

local f0_local1 = function (f2_arg0)
	local f2_local0 = f2_arg0.candidateButton
	if f2_local0 ~= nil then
		f2_arg0.candidateButton = nil
		f0_local0(f2_arg0, f2_local0)
	end
end

CoD.DrcRadioButtonList.ButtonUp = function (f3_arg0, f3_arg1)

end

CoD.DrcRadioButtonList.RadioButtonActionEventHandler = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.button.container
	if f4_local0 == f4_arg0.candidateButton then
		f4_arg0:selectButton(f4_local0.radioId, true)
		return 
	else
		f0_local1(f4_arg0)
		f4_arg0.candidateButton = f4_local0
		f0_local0(f4_arg0, f4_local0)
	end
end

CoD.DrcRadioButtonList.AddButton = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = CoD.DrcPanelButton.new({
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = f5_arg0.typeParams.itemWidth,
		top = 0,
		bottom = f5_arg0.typeParams.itemHeight
	}, CoD.DrcRadioButtonList.RadioButtonActionEvent, LUI.UITouchpadButton)
	f5_local0:addGlow()
	f5_local0.labelText = f5_arg2
	f5_local0.button:setLeftRight(true, true, 0, 0)
	f5_local0.button:setTopBottom(true, true, 0, 0)
	f5_local0.button.animUpTime = 0
	f5_local0.button.animDownTime = 0
	f5_local0.wedge:setLeftRight(unpack(f5_arg0.typeParams.wedgeLeftRight))
	f5_local0.glow:setLeftRight(unpack(f5_arg0.typeParams.wedgeLeftRight))
	f5_local0.wedge:setTopBottom(unpack(f5_arg0.typeParams.wedgeTopBottom))
	f5_local0.glow:setTopBottom(unpack(f5_arg0.typeParams.wedgeTopBottom))
	f5_local0:setLabel(f5_arg2)
	f5_local0.label:setLeftRight(unpack(f5_arg0.typeParams.labelLeftRight))
	f5_local0.label:setTopBottom(unpack(f5_arg0.typeParams.labelTopBottom))
	f5_local0.label:setAlignment(LUI.Alignment.Left)
	f5_local0.label:setupButtonDownPulsing()
	if f5_arg0.gainFocusSFX ~= nil then
		f5_local0:setGainFocusSFX(f5_arg0.gainFocusSFX)
	end
	if f5_arg0.actionSFX ~= nil then
		f5_local0:setActionSFX(f5_arg0.actionSFX)
	end
	f5_local0.radioId = f5_arg1
	f5_local0.hintText = f5_arg3
	f5_local0.button:registerEventHandler("button_over", CoD.DrcRadioButtonList.ButtonUp)
	f5_local0.button:registerEventHandler("button_up", CoD.DrcRadioButtonList.ButtonUp)
	f5_arg0.buttons[f5_arg1] = f5_local0
	f5_arg0:addElement(f5_local0)
end

CoD.DrcRadioButtonList.DeselectButton = function (f6_arg0)
	local f6_local0 = f6_arg0.selectedButton
	if f6_local0 ~= nil then
		f6_arg0.selectedButton = nil
		f0_local0(f6_arg0, f6_local0)
	end
end

CoD.DrcRadioButtonList.SelectButton = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = f7_arg0.buttons[f7_arg1]
	if f7_local0 ~= nil and f7_arg2 then
		f7_arg0:processEvent({
			name = CoD.DrcRadioButtonList.RadioButtonItemSelected,
			controller = f7_arg0.controller,
			id = f7_arg1
		})
	end
	f7_arg0.candidateButton = nil
	f7_arg0:deselectButton()
	local f7_local1 = nil
	f7_arg0.selectedButton = f7_local0
	f0_local0(f7_arg0, f7_local0)
end

CoD.DrcRadioButtonList.new = function (f8_arg0, f8_arg1, f8_arg2)
	if f8_arg2 == nil then
		f8_arg2 = CoD.DrcRadioButtonList.DefaultTypeParams
	end
	local f8_local0 = f8_arg2.containerType.new(f8_arg1)
	f8_local0.controller = f8_arg0
	f8_local0.typeParams = f8_arg2
	f8_local0.buttons = {}
	f8_local0.selectedButton = nil
	f8_local0.candidateButton = nil
	f8_local0.addButton = CoD.DrcRadioButtonList.AddButton
	f8_local0.selectButton = CoD.DrcRadioButtonList.SelectButton
	f8_local0.deselectButton = CoD.DrcRadioButtonList.DeselectButton
	f8_local0:registerEventHandler(CoD.DrcRadioButtonList.RadioButtonActionEvent, CoD.DrcRadioButtonList.RadioButtonActionEventHandler)
	return f8_local0
end

