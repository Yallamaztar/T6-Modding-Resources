CoD.ConfirmWeaponPrestige = {}
CoD.MAX_WEAPON_PRESTIGE = 2
local f0_local0 = function (f1_arg0, f1_arg1)
	CoD.perController[f1_arg1.controller].weaponPrestigeItemIndex = nil
	f1_arg0:goBack()
end

local f0_local1 = function (f2_arg0, f2_arg1)
	local f2_local0 = Engine.GetPlayerStats(f2_arg1.controller)
	local f2_local1 = CoD.perController[f2_arg1.controller].weaponPrestigeItemIndex
	local f2_local2 = f2_local0.itemStats[f2_local1]
	local f2_local3 = f2_local2.pLevel:get()
	if f2_local3 < CoD.MAX_WEAPON_PRESTIGE then
		f2_local2.xp:set(0)
		f2_local2.pLevel:set(f2_local3 + 1)
		for f2_local4 = 0, 9, 1 do
			for f2_local7 = 0, 2, 1 do
				if Engine.GetClassItem(f2_arg1.controller, f2_local4, "primary") == f2_local1 then
					Engine.SetClassItem(f2_arg1.controller, f2_local4, "primaryattachment" .. f2_local7 + 1, 0)
				end
				if Engine.GetClassItem(f2_arg1.controller, f2_local4, "secondary") == f2_local1 then
					Engine.SetClassItem(f2_arg1.controller, f2_local4, "secondaryattachment" .. f2_local7 + 1, 0)
				end
			end
		end
	else
		f2_local2.pLevel:set(CoD.MAX_WEAPON_PRESTIGE)
	end
	if f2_arg0.occludedMenu and f2_arg0.occludedMenu.weaponLevel then
		f2_arg0.occludedMenu.weaponLevel:update(f2_arg1.controller, f2_local1)
	end
	f0_local0(f2_arg0, f2_arg1)
end

LUI.createMenu.ConfirmWeaponPrestige = function (f3_arg0)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(event.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(event.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	end
	local f3_local0 = CoD.Popup.SetupPopupChoice("ConfirmWeaponPrestige", f3_arg0)
	f3_local0:addBackButton()
	f3_local0:registerEventHandler("weapon_prestige_action", f0_local1)
	f3_local0:registerEventHandler("menu_changed", CoD.Menu.MenuChanged)
	local f3_local1 = CoD.perController[f3_arg0].weaponPrestigeItemIndex
	local f3_local2 = CoD.WeaponLevel.GetWeaponLevel(f3_arg0, f3_local1)
	local f3_local3 = CoD.WeaponLevel.GetWeaponPLevel(f3_arg0, f3_local1)
	local f3_local4 = 0
	local f3_local5 = ""
	if f3_local1 ~= nil then
		f3_local4 = UIExpression.GetNumItemAttachmentsWithAttachPoint(f3_arg0, f3_local1, 0) - 1
	end
	if f3_local4 < 0 then
		f3_local4 = 0
	end
	f3_local0.title:setText(Engine.Localize("MPUI_CONFIRM_WEAPON_PRESTIGE"))
	if f3_local3 == 0 then
		if f3_local4 > 0 then
			f3_local5 = Engine.Localize("MPUI_CONFIRM_WEAPON_PRESTIGE_DESC", f3_local2, f3_local3 + 1)
		else
			f3_local5 = Engine.Localize("MPUI_CONFIRM_WEAPON_PRESTIGE_DESC_SPECIALS", f3_local2, f3_local3 + 1)
		end
	elseif f3_local4 > 0 then
		f3_local5 = Engine.Localize("MPUI_CONFIRM_WEAPON_PRESTIGE_DESC2", f3_local2, f3_local3, f3_local3 + 1)
	else
		f3_local5 = Engine.Localize("MPUI_CONFIRM_WEAPON_PRESTIGE_DESC2_SPECIALS", f3_local2, f3_local3, f3_local3 + 1)
	end
	f3_local0.msg:setText(f3_local5)
	f3_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f3_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f3_local0.choiceA:setActionEventName("weapon_prestige_action")
	f3_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	return f3_local0
end

CoD.ConfirmWeaponPrestige.OpenIfNecessary = function (f4_arg0, f4_arg1, f4_arg2)
	if CoD.WeaponLevel.GetWeaponLevel(f4_arg1, f4_arg2) and CoD.WeaponLevel.GetWeaponPLevel(f4_arg1, f4_arg2) < CoD.MAX_WEAPON_PRESTIGE then
		CoD.perController[f4_arg1].weaponPrestigeItemIndex = f4_arg2
		return f4_arg0:openPopup("ConfirmWeaponPrestige", f4_arg1)
	else

	end
end

