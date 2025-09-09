require("T6.AttributeBarList")
require("T6.Menus.ConfirmDefaultWeapons")
CoD.CACLoadOutMenu = {}
CoD.CACLoadOutMenu.AnimateLoadout = true
LUI.createMenu.CACLoadOutMenu = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACLoadOutMenu")
	if Dvar.ui_campaignstate:get() ~= 0 then
		f1_local0:setPreviousMenu("CampaignMissionBriefingMenu")
	else
		f1_local0:setPreviousMenu("MissionBriefingMenu")
	end
	f1_local0:setOwner(f1_arg0)
	f1_local0:addTitle(Engine.Localize("SPUI_EDIT_LOADOUT_CAPS"), LUI.Alignment.Center)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local loadoutUI = CoD.ButtonPrompt.new
	local f1_local2 = "alt2"
	local f1_local3 = Engine.Localize("SPUI_RESTORE_DEFAULTS")
	local f1_local4 = f1_local0
	local f1_local5 = "button_restore_defaults"
	local f1_local6, f1_local7 = false
	local f1_local8, f1_local9 = false
	f1_local0.restoreDefaultsPrompt = loadoutUI(f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, "R")
	f1_local0:addLeftButtonPrompt(f1_local0.restoreDefaultsPrompt)
	
	loadoutUI = CoD.CACClassLoadout.new(f1_arg0, false)
	f1_local0:addElement(loadoutUI)
	f1_local0.loadoutUI = loadoutUI
	
	if CoD.CACLoadOutMenu.AnimateLoadout then
		loadoutUI:moveToCenter(250)
	else
		loadoutUI:moveToCenter(0)
	end
	CoD.CACLoadOutMenu.AnimateLoadout = false
	loadoutUI:dispatchEventToChildren({
		name = "animate",
		animationStateName = "hide_text_brackets"
	})
	f1_local0:registerEventHandler("open_weapon_selection", CoD.CACLoadOutMenu.OpenWeaponSelection)
	f1_local0:registerEventHandler("open_grid_selection", CoD.CACLoadOutMenu.OpenGridSelection)
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACLoadOutMenu.ButtonPromptBack)
	f1_local0:registerEventHandler("button_restore_defaults", CoD.CACLoadOutMenu.ButtonRestoreDefaults)
	f1_local0:registerEventHandler("weapon_chosen", CoD.CACLoadOutMenu.OpenWeaponSelection)
	f1_local0:registerEventHandler("attachment_slot_chosen", CoD.CACLoadOutMenu.OpenGridSelection)
	f1_local0:registerEventHandler("grenades_chosen", CoD.CACLoadOutMenu.OpenGridSelection)
	f1_local0:registerEventHandler("perk_slot_chosen", CoD.CACLoadOutMenu.OpenGridSelection)
	f1_local0:registerEventHandler("go_back", CoD.CACLoadOutMenu.Backtrack)
	loadoutUI:registerEventHandler("transition_complete_move_to_default", CoD.CACLoadOutMenu.LoadOut_ExitAnimationComplete)
	CoD.MissionBriefing.CheckNewItemsAvailable(f1_local0, f1_arg0)
	return f1_local0
end

CoD.CACLoadOutMenu.ButtonPromptBack = function (f2_arg0, f2_arg1)
	f2_arg0.loadoutUI:processEvent({
		name = "lose_focus"
	})
	f2_arg0.loadoutUI:moveToDefault(125)
end

CoD.CACLoadOutMenu.RestoreDefaults = function ()
	local f3_local0 = UIExpression.GetPrimaryController()
	local f3_local1 = UIExpression.TableLookup(f3_local0, CoD.AARUtility.LevelTable, 1, Dvar.ui_mapname:get(), 2)
	Engine.PlaySound(CoD.CACUtility.RestoreDefault)
	Engine.ExecNow(f3_local0, "uiEquipDefaultClass " .. Engine.GetClassIndexFromName("custom_" .. f3_local1) .. " " .. f3_local1)
end

CoD.CACLoadOutMenu.ButtonRestoreDefaults = function (f4_arg0, f4_arg1)
	f4_arg0:openPopup("ConfirmDefaultWeapons", controller, {
		loadout = f4_arg0
	})
	f4_arg0.loadoutUI:update(f4_arg1.controller)
end

CoD.CACLoadOutMenu.Backtrack = function (f5_arg0, f5_arg1)
	f5_arg0:goBack()
end

CoD.CACLoadOutMenu.LoadOut_ExitAnimationComplete = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "go_back"
	})
end

CoD.CACLoadOutMenu.UpdateBackPromptButton = function (f7_arg0, f7_arg1)
	if f7_arg1.type == "weapon" then
		f7_arg0:registerEventHandler("button_prompt_back", CoD.CACLoadOutMenu.CloseWeaponSelectOptions)
	end
end

CoD.CACLoadOutMenu.CloseWeaponSelectOptions = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.loadoutUI
	if f8_local0.weaponOptions ~= nil then
		f8_local0:removeElement(f8_local0.weaponOptions)
		f8_arg0:registerEventHandler("button_prompt_back", CoD.Menu.ButtonPromptBack)
		if CoD.useController then
			f8_local0.buttons[f8_local0.weaponOptions.parentWeapon]:processEvent({
				name = "gain_focus"
			})
		end
		f8_local0.weaponOptions = nil
		f8_arg0:dispatchEventToChildren({
			name = "reenable_input"
		})
	end
end

CoD.CACLoadOutMenu.OpenWeaponSelection = function (f9_arg0, f9_arg1)
	CoD.perController[f9_arg1.controller].weaponSlot = f9_arg1.weaponSlot
	CoD.CACClassLoadout.PreviousSelection = f9_arg1.weaponSlot
	f9_arg0:saveState()
	f9_arg0:swapMenu("CACSelectWeaponMenu", f9_arg1.controller)
end

CoD.CACLoadOutMenu.OpenGridSelection = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.controller
	local f10_local1 = nil
	if f10_arg1.indexMap then
		f10_local1 = f10_arg1.indexMap[f10_arg1.slotIndex]
	end
	f10_arg0:saveState()
	if f10_arg1.name == "attachment_slot_chosen" then
		CoD.perController[f10_local0].weaponSlot = f10_arg1.weaponSlot
		CoD.CACClassLoadout.PreviousSelection = f10_arg1.weaponSlot .. "Attachments"
		CoD.perController[f10_local0].slotIndex = f10_local1
		f10_arg0:swapMenu("CACSelectAttachments", f10_local0)
	elseif f10_arg1.name == "grenades_chosen" then
		CoD.CACClassLoadout.PreviousSelection = "grenades"
		f10_arg0:swapMenu("CACSelectGrenade", f10_local0)
	elseif f10_arg1.name == "perk_slot_chosen" then
		CoD.CACClassLoadout.PreviousSelection = "perks"
		f10_arg0:swapMenu("CACSelectPerks", f10_local0)
	end
end

