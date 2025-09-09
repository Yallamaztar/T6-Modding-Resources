require("T6.Drc.DrcPanelButton")
CoD.DrcPopup = {}
CoD.DrcPopup.ButtonLeftOffset = 150
CoD.DrcPopup.ButtonBottomOffset = 75
CoD.DrcPopup.ButtonWidth = 256
CoD.DrcPopup.ButtonHeight = 256
CoD.DrcPopup.ButtonSpacing = 50
CoD.DrcPopup.MODE_YESNO = 0
CoD.DrcPopup.MODE_OKCANCEL = 1
CoD.DrcPopup.Modes = {
	yesno = {
		{
			label = "YES",
			actionEventName = "drc_popup_yes"
		},
		{
			label = "NO",
			actionEventName = "drc_popup_no"
		}
	},
	okcancel = {
		{
			label = "OK",
			actionEventName = "drc_popup_ok"
		},
		{
			label = "Cancel",
			actionEventName = "drc_popup_cancel"
		}
	}
}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0:processEvent({
		name = "button_over_down",
		controller = f1_arg1.controller
	})
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0:processEvent({
		name = "button_up",
		controller = f2_arg1.controller
	})
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.DrcPanelButton.new({
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = CoD.DrcPopup.ButtonWidth,
		top = 0,
		bottom = CoD.DrcPopup.ButtonHeight
	}, f3_arg1 .. "_pressed")
	f3_local0:setLabel(f3_arg1)
	f3_local0.delayedEvent = f3_arg2
	f3_local0.button:registerEventHandler("mouseenter", function (Sender, Event)
		Sender:processEvent({
			name = "button_over_down",
			controller = Event.controller
		})
	end)
	f3_local0.button:registerEventHandler("mouseleave", function (Sender, Event)
		Sender:processEvent({
			name = "button_up",
			controller = Event.controller
		})
	end)
	f3_local0.button:makeNotFocusable()
	local f3_local1 = CoD.Menu.TitleFont
	local f3_local2, f3_local3, f3_local4, f3_local5 = GetTextDimensions(f3_arg1, f3_local1, f3_local1)
	f3_local0.label:setFont(f3_local1)
	f3_local0.label:setLeftRight(false, false, -f3_local4 / 2, f3_local4 / 2)
	f3_local0.label:setTopBottom(false, false, -CoD.DrcPopup.ButtonHeight / 10, CoD.DrcPopup.ButtonHeight / 10)
	f3_local0:registerEventHandler(f3_arg1 .. "_pressed", function (f8_arg0)
		f3_local0:addElement(LUI.UITimer.new(500, {
			name = "drc_button_anim_up_finished"
		}, true, f3_local0))
	end)
	f3_local0:registerEventHandler("drc_button_anim_up_finished", function (f9_arg0)
		f9_arg0:dispatchEventToParent({
			name = f9_arg0.delayedEvent
		})
	end)
	f3_arg0:addElement(f3_local0)
	f3_local0.button.animDownTime = f3_local0.button.animDownTime * 0.5
	f3_local0.button.animUpTime = f3_local0.button.animUpTime * 0.5
	return f3_local0
end

CoD.DrcPopup.Close = function (f4_arg0)
	local f4_local0 = f4_arg0:getParent()
	if f4_arg0.previousMenu then
		f4_local0:addElement(f4_arg0.previousMenu)
	end
	f4_local0:removeElement(f4_arg0)
end

CoD.DrcPopup.New = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = LUI.UIHorizontalList.new()
	f5_local0:setLeftRight(true, true, CoD.DrcPopup.ButtonLeftOffset, 0)
	f5_local0:setTopBottom(true, true, CoD.DrcPopup.ButtonBottomOffset, CoD.DrcPopup.ButtonBottomOffset + CoD.DrcPopup.ButtonHeight)
	f5_local0:setSpacing(CoD.DrcPopup.ButtonSpacing)
	for f5_local4, f5_local5 in ipairs(CoD.DrcPopup.Modes[f5_arg2]) do
		local f5_local6 = f0_local2(f5_local0, f5_local5.label, f5_local5.actionEventName)
		f5_local6.debugName = f5_arg0 .. ".button." .. f5_local4
	end
	f5_local1 = CoD.Menu.NewMediumPopup(f5_arg0)
	f5_local1:addTitle(f5_arg1, LUI.Alignment.Center)
	f5_local1:addElement(f5_local0)
	f5_local1.debugName = f5_arg0
	f5_local1:setOwner(0)
	f5_local1.drcPopupClose = CoD.DrcPopup.Close
	f5_local1.drcPrimaryDisplay = Engine.IsDrcPrimaryDisplay(f5_arg3)
	if not f5_local1.drcPrimaryDisplay then
		f5_local1.updateBlur = function ()

		end

	end
	return f5_local1
end

