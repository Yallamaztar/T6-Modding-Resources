CoD.MissionSelectFirstTimePopup = {}
LUI.createMenu.MissionSelectFirstTimePopup = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmOverwritePopup")
	f1_local0:registerEventHandler("okay", CoD.MissionSelectFirstTimePopup.OkayContinue)
	local f1_local1 = "Default"
	local f1_local2 = 0
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize[f1_local1])
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0.title:setFont(CoD.fonts[f1_local1])
	f1_local0.title:setText(Engine.Localize("MENU_MISSION_FIRST_TIME_Q_CAPS"))
	f1_local0:addElement(f1_local0.title)
	local f1_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height - 21,
		bottom = -15
	})
	f1_local0:addElement(f1_local3)
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_OK_CAPS"))
	f1_local4:setActionEventName("okay")
	f1_local4:processEvent({
		name = "gain_focus"
	})
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	return f1_local0
end

CoD.MissionSelectFirstTimePopup.OkayContinue = function (f2_arg0, f2_arg1)
	f2_arg0:openMenu("MissionSelectMenu", f2_arg1.controller)
	f2_arg0:close()
	Engine.ExecNow(controller, "setprofile com_first_time_mission_select 0")
	Engine.ExecNow(controller, "updategamerprofile")
end

