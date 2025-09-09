require("T6.DrcButton")
require("T6.Drc.DrcPopup")
CoD.DrcOutput = {}
CoD.DrcOutput.DisplayTv = 0
CoD.DrcOutput.DisplayDrc = 1
CoD.DrcOutput.ShowSingleClient = 0
CoD.DrcOutput.ShowSplitScreen = 1
CoD.DrcOutput.ShowSecondScreen = 2
CoD.DrcOutput.ShowLUIDrcRoot = 3
CoD.DrcOutput.ShowDisabled = 4
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg1 then
		local f1_local0 = nil
		if Engine.IsSplitscreen() then
			f1_local0 = CoD.DrcOutput.ShowSecondScreen
		else
			f1_local0 = CoD.DrcOutput.ShowSingleClient
		end
		local f1_local1, f1_local2 = Engine.WiiUGetDisplayConfiguration(CoD.DrcOutput.DisplayDrc)
		Engine.WiiUDisplayConfigure(CoD.DrcOutput.DisplayDrc, f1_local0, f1_local2)
	end
	f1_arg0:drcPopupClose()
end

LUI.createMenu.DrcOutputDevicePopup = function (f2_arg0)
	local f2_local0 = LUI.UIText.new()
	f2_local0:setLeftRight(true, true, 0, 0)
	f2_local0:setTopBottom(false, true, -(-120 + CoD.Menu.TitleHeight), 120)
	f2_local0:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
	f2_local0:setFont(CoD.Menu.TitleFont)
	f2_local0:setText(Engine.Localize("DRC_EXPLAIN_FULL_SCREEN_DRC"))
	local f2_local1 = CoD.DrcPopup.New("DrcOutputDevicePopup", Engine.Localize("DRC_TOUCHSCREEN_DISPLAY"), "yesno")
	f2_local1.controller = f2_arg0
	f2_local1:registerEventHandler("drc_popup_yes", function (f8_arg0, f8_arg1)
		f0_local0(f8_arg0, true)
	end)
	f2_local1:registerEventHandler("drc_popup_no", function (f9_arg0, f9_arg1)
		f0_local0(f9_arg0, false)
	end)
	f2_local1:addElement(f2_local0)
	return f2_local1
end

CoD.DrcOutput.OpenDrcOuputDevicePopup = function (f3_arg0)
	f3_arg0:dispatchEventToParent({
		name = "open_drc_popup",
		popupName = "DrcOutputDevicePopup",
		controller = 0
	})
end

local f0_local1 = function (f4_arg0, f4_arg1)
	if f4_arg1 then
		local f4_local0, f4_local1 = Engine.WiiUGetDisplayConfiguration(CoD.DrcOutput.DisplayDrc)
		Engine.WiiUDisplayConfigure(CoD.DrcOutput.DisplayDrc, CoD.DrcOutput.ShowLUIDrcRoot, f4_local1)
	end
	f4_arg0:drcPopupClose()
end

local f0_local2 = function (f5_arg0, f5_arg1)
	if f5_arg1.popupName == "TVOutputDevicePopup" then
		return true
	else
		return CoD.Menu.OpenPopup(f5_arg0, f5_arg1)
	end
end

LUI.createMenu.TVOutputDevicePopup = function (f6_arg0)
	local f6_local0 = CoD.DrcPopup.New("TVOutputDevicePopup", Engine.Localize("DRC_GADGET_DISPLAY"), "yesno")
	f6_local0.controller = f6_arg0
	f6_local0:registerEventHandler("drc_popup_yes", function (f10_arg0)
		f0_local1(f10_arg0, true)
	end)
	f6_local0:registerEventHandler("drc_popup_no", function (f11_arg0)
		f0_local1(f11_arg0, false)
	end)
	f6_local0:registerEventHandler("open_popup", f0_local2)
	return f6_local0
end

CoD.DrcOutput.CreateDrcOutputButton = function (f7_arg0)
	if not f7_arg0 then
		f7_arg0 = {
			leftAnchor = true,
			rightAnchor = false,
			topAnchor = true,
			bottomAnchor = false,
			left = 0,
			right = CoD.DrcPopup.ButtonWidth,
			top = 0,
			bottom = CoD.DrcPopup.ButtonHeight
		}
	end
	local f7_local0 = CoD.DrcPanelButton.new(f7_arg0, "drc_output_button_pressed")
	local f7_local1 = Engine.Localize("DRC_DISPLAY")
	f7_local0:setLabel(f7_local1)
	f7_local0.drawnContainer.actionDelay = 500
	f7_local0.button:registerEventHandler("mouseenter", function (Sender, Event)
		Sender:processEvent({
			name = "button_over_down",
			controller = Event.controller
		})
	end)
	f7_local0.button:registerEventHandler("mouseleave", function (Sender, Event)
		Sender:processEvent({
			name = "button_over",
			controller = Event.controller
		})
	end)
	f7_local0.button:makeNotFocusable()
	f7_local0:registerEventHandler("drc_output_button_pressed", function (f14_arg0)
		if not f7_local0.buttonUpTimer then
			f7_local0.buttonUpTimer = LUI.UITimer.new(400, {
				name = "drc_output_button_up"
			}, true, f7_local0)
			f7_local0:addElement(f7_local0.buttonUpTimer)
		end
	end)
	f7_local0:registerEventHandler("drc_output_button_up", function (f15_arg0)
		f15_arg0:dispatchEventToParent({
			name = "open_drc_popup",
			popupName = "DrcOutputDevicePopup",
			controller = 0
		})
		f15_arg0.buttonUpTimer = nil
	end)
	local f7_local2 = CoD.Menu.TitleFont
	local f7_local3, f7_local4, f7_local5, f7_local6 = GetTextDimensions(f7_local1, f7_local2, f7_local2)
	f7_local0.label:setFont(f7_local2)
	f7_local0.label:setLeftRight(false, false, -f7_local5 / 2, f7_local5 / 2)
	f7_local0.label:setTopBottom(false, false, -CoD.DrcPopup.ButtonHeight / 10, CoD.DrcPopup.ButtonHeight / 10)
	f7_local0.button.animDownTime = f7_local0.button.animDownTime * 0.5
	f7_local0.button.animUpTime = f7_local0.button.animUpTime * 0.5
	return f7_local0
end

