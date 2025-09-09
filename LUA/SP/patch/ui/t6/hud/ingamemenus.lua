require("T6.CoDBase")
require("T6.Options")
CoD.InGameMenu = InheritFrom(CoD.Menu)
CoD.InGameMenu.ClassSelected = nil
CoD.InGameMenu.New = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = CoD.Menu.New(f1_arg0)
	f1_local0:setClass(CoD.InGameMenu)
	f1_local0:setOwner(f1_arg1)
	f1_local0.isInGameMenu = true
	if f1_arg2 ~= nil then
		f1_local0:addTitle(f1_arg2)
	end
	if f1_arg3 then
		f1_local0:registerEventHandler("button_prompt_back", CoD.Menu.ButtonPromptBack)
	end
	f1_local0.removeButtonPrompts = CoD.InGameMenu.removeButtonPrompts
	return f1_local0
end

CoD.InGameMenu.BackButtonPressed = function (f2_arg0, f2_arg1)
	if not Dvar.ui_isSaving:get() then
		CoD.InGameMenu.CloseAllInGameMenus(f2_arg0, {
			name = "close_all_ingame_menus",
			controller = f2_arg1.controller
		})
	end
end

CoD.InGameMenu.StartButtonPressed = function (f3_arg0, f3_arg1)
	if not Dvar.ui_isSaving:get() then
		CoD.InGameMenu.CloseAllInGameMenus(f3_arg0, {
			name = "close_all_ingame_menus",
			controller = f3_arg1.controller
		})
	end
end

CoD.InGameMenu.removeButtonPrompts = function (f4_arg0)
	if f4_arg0.backButtonPrompt then
		f4_arg0.backButtonPrompt:close()
	end
	if f4_arg0.startButtonPrompt then
		f4_arg0.startButtonPrompt:close()
	end
end

CoD.InGameMenu.addButtonPrompts = function (f5_arg0)
	f5_arg0:addSelectButton()
	f5_arg0:addBackButton()
	f5_arg0.startButtonPrompt = CoD.ButtonPrompt.new("start", "", f5_arg0, "button_prompt_start", true)
	f5_arg0.backButtonPrompt = CoD.ButtonPrompt.new("select", "", f5_arg0, "button_prompt_back", true)
	f5_arg0:addRightButtonPrompt(f5_arg0.startButtonPrompt)
	f5_arg0:addRightButtonPrompt(f5_arg0.backButtonPrompt)
end

CoD.InGameMenu.CloseAllInGameMenus = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToChildren(f6_arg1)
	if not f6_arg0.m_inputDisabled then
		if LUI.savedMenuStates.Menu.ObjectiveInfoMenu then
			LUI.savedMenuStates.Menu.ObjectiveInfoMenu = nil
		end
		f6_arg0.previousMenuName = nil
		f6_arg0:goBack()
		if f6_arg0.occludedMenu then
			f6_arg0.occludedMenu:processEvent(f6_arg1)
		end
	end
	f6_arg0 = nil
	Engine.SetUIActive(f6_arg1.controller, false)
	Engine.PauseGame(f6_arg1.controller, false)
	Engine.ClearUIMenuState(f6_arg1.controller)
end

CoD.InGameMenu:registerEventHandler("close_all_ingame_menus", CoD.InGameMenu.CloseAllInGameMenus)
CoD.InGameMenu:registerEventHandler("button_prompt_back", CoD.InGameMenu.BackButtonPressed)
CoD.InGameMenu:registerEventHandler("button_prompt_start", CoD.InGameMenu.StartButtonPressed)
