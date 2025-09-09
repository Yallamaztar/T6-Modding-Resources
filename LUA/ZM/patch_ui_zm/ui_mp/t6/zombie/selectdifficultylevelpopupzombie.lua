CoD.SelectDifficultyLevelPopupZombie = {}
LUI.createMenu.SelectDifficultyLevelZM = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("SelectDifficultyLevelZM")
	f1_local0.m_ownerController = f1_arg0
	f1_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f1_local0, "choose_difficultylevel_accepted")
	f1_local0:addLeftButtonPrompt(f1_local0.primaryButton)
	f1_local0:registerEventHandler("choose_difficultylevel_accepted", CoD.SelectDifficultyLevelPopupZombie.ChoiceAccepted)
	local f1_local1 = LUI.UIText.new()
	f1_local0:addElement(f1_local1)
	f1_local1:setLeftRight(true, true, 10, -10)
	f1_local1:setTopBottom(false, false, -10, 20)
	f1_local1:setAlignment(LUI.Alignment.Left)
	f1_local1:setText(Engine.Localize("ZMUI_FIRSTTIME_HOST_DIFFICULTY_DESC"))
	local f1_local2 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 30,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 5,
		bottom = 0
	})
	f1_local0:addElement(f1_local2)
	local f1_local3 = nil
	for f1_local7, f1_local8 in pairs(CoD.Zombie.GameOptions) do
		if f1_local8.id == "zmDifficulty" then
			f1_local3 = f1_local8
		end
	end
	if f1_local3 ~= nil then
		f1_local4 = f1_local2:addGametypeSettingLeftRightSelector(f1_arg0, Engine.Localize(f1_local3.name), f1_local3.id, Engine.Localize(f1_local3.hintText), 250)
		for f1_local5 = 1, #f1_local3.labels, 1 do
			f1_local4:addChoice(f1_arg0, Engine.Localize(f1_local3.labels[f1_local5]), f1_local3.values[f1_local5])
		end
		if CoD.useController and not f1_local0:restoreState() then
			f1_local4:processEvent({
				name = "gain_focus"
			})
		end
	end
	return f1_local0
end

CoD.SelectDifficultyLevelPopupZombie.UpdateHint = function (f2_arg0)
	f2_arg0.parentSelectorButton.hintText = f2_arg0.extraParams.associatedHintText
	local f2_local0 = f2_arg0.parentSelectorButton:getParent()
	if f2_local0 ~= nil and f2_local0.hintText ~= nil then
		f2_local0.hintText:updateText(f2_arg0.parentSelectorButton.hintText)
	end
end

CoD.SelectDifficultyLevelPopupZombie.ChoiceAccepted = function (f3_arg0, f3_arg1)
	Engine.ExecNow(f3_arg1.controller, "setprofile com_first_time_privategame_host_zm 0")
	Engine.Exec(f3_arg1.controller, "updategamerprofile")
	Engine.Exec(f3_arg1.controller, "xupdatepartystate")
	f3_arg0:saveState()
	f3_arg0:goBack(f3_arg1.controller)
end

