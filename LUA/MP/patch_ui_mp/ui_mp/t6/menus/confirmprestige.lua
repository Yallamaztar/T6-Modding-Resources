CoD.ConfirmPrestige = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0:goBack(f1_arg1.controller)
end

local f0_local1 = function (f2_arg0)
	f2_arg0.choiceA:processEvent({
		name = "lose_focus"
	})
	f2_arg0.choiceB:processEvent({
		name = "gain_focus"
	})
end

local f0_local2 = function (f3_arg0, f3_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f3_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	else
		Engine.ExecNow(f3_arg1.controller, "exec mp/prestige_reset.cfg")
		local f3_local0 = f3_arg0.occludedMenu
		f0_local0(f3_arg0, f3_arg1)
		f3_local0:processEvent({
			name = "prestige_action_complete",
			controller = f3_arg1.controller
		})
	end
end

local f0_local3 = function (f4_arg0, f4_arg1)
	f4_arg0.msg:setText(Engine.Localize("MENU_PRESTIGE_MODE_DESC_2"))
	f4_arg0.choiceA:setLabel(Engine.Localize("MENU_ENTER_PRESTIGE"))
	f4_arg0.choiceA:setActionEventName("prestige_action")
	f0_local1(f4_arg0)
end

local f0_local4 = function (f5_arg0, f5_arg1)
	f5_arg0.title:setText(Engine.Localize("MPUI_PRESTIGE_MODE_CAPS"))
	f5_arg0.msg:setText(Engine.Localize("MENU_PRESTIGE_MODE_DESC_1"))
	f5_arg0.choiceA:setLabel(Engine.Localize("MENU_LEARN_MORE"))
	f5_arg0.choiceB:setLabel(Engine.Localize("MENU_NOT_NOW"))
	f5_arg0.choiceA:setActionEventName("prestige_confirm")
	f0_local1(f5_arg0)
end

local f0_local5 = function (f6_arg0, f6_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f6_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	else
		Engine.ExecNow(f6_arg1.controller, "PrestigeStatsResetAll")
		local f6_local0 = f6_arg0.occludedMenu
		f0_local0(f6_arg0, f6_arg1)
		f6_local0:processEvent({
			name = "prestige_action_complete",
			controller = f6_arg1.controller
		})
	end
end

local f0_local6 = function (f7_arg0, f7_arg1)
	f7_arg0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_ARE_YOU_SURE")))
	f7_arg0.msg:setText(Engine.Localize("MENU_PRESTIGE_FRESH_START_WARNING2"))
	f7_arg0.choiceA:setLabel(Engine.Localize("MENU_YES_USE_FRESH_START"))
	f7_arg0.choiceA:setActionEventName("resetstats_action")
	f0_local1(f7_arg0)
end

local f0_local7 = function (f8_arg0, f8_arg1)
	f8_arg0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_ARE_YOU_SURE")))
	f8_arg0.msg:setText(Engine.Localize("MENU_PRESTIGE_FRESH_START_WARNING"))
	f8_arg0.choiceA:setLabel(Engine.Localize("MENU_YES_USE_FRESH_START"))
	f8_arg0.choiceA:setActionEventName("resetstats_confirm2")
	f0_local1(f8_arg0)
end

local f0_local8 = function (f9_arg0, f9_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f9_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	else
		Engine.ExecNow(f9_arg1.controller, "PrestigeRespec")
		local f9_local0 = f9_arg0.occludedMenu
		f0_local0(f9_arg0, f9_arg1)
		f9_local0:processEvent({
			name = "prestige_action_complete",
			controller = f9_arg1.controller
		})
	end
end

local f0_local9 = function (f10_arg0, f10_arg1)
	f10_arg0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_ARE_YOU_SURE")))
	f10_arg0.msg:setText(Engine.Localize("MENU_PRESTIGE_REFUND_WARNING"))
	f10_arg0.choiceA:setLabel(Engine.Localize("MENU_YES_USE_REFUND"))
	f10_arg0.choiceA:setActionEventName("respec_action")
	f0_local1(f10_arg0)
end

local f0_local10 = function (f11_arg0, f11_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f11_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	else
		Engine.ExecNow(f11_arg1.controller, "PrestigeAddCAC")
		local f11_local0 = f11_arg0.occludedMenu
		f0_local0(f11_arg0, f11_arg1)
		f11_local0:processEvent({
			name = "prestige_action_complete",
			controller = f11_arg1.controller
		})
	end
end

local f0_local11 = function (f12_arg0, f12_arg1)
	f12_arg0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_ARE_YOU_SURE")))
	f12_arg0.msg:setText(Engine.Localize("MENU_PRESTIGE_EXTRACAC_WARNING"))
	f12_arg0.choiceA:setLabel(Engine.Localize("MENU_YES_USE_EXTRACAC"))
	f12_arg0.choiceA:setActionEventName("extraCAC_action")
	f0_local1(f12_arg0)
end

LUI.createMenu.ConfirmPrestige = function (f13_arg0, f13_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f13_arg0, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	end
	local f13_local0 = CoD.Popup.SetupPopupChoice("ConfirmPrestige", f13_arg0, nil, CoD.Popup.Type.WIDE)
	f13_local0:addBackButton()
	f13_local0:registerEventHandler("prestige_action", f0_local2)
	f13_local0:registerEventHandler("open_prestige_confirm", f0_local4)
	f13_local0:registerEventHandler("prestige_confirm", f0_local3)
	f13_local0:registerEventHandler("resetstats_action", f0_local5)
	f13_local0:registerEventHandler("resetstats_confirm", f0_local7)
	f13_local0:registerEventHandler("resetstats_confirm2", f0_local6)
	f13_local0:registerEventHandler("respec_action", f0_local8)
	f13_local0:registerEventHandler("respec_confirm", f0_local9)
	f13_local0:registerEventHandler("extraCAC_action", f0_local10)
	f13_local0:registerEventHandler("extraCAC_confirm", f0_local11)
	f13_local0:registerEventHandler("menu_changed", CoD.Menu.MenuChanged)
	f13_local0.userData = f13_arg1
	f13_local0.title:setText(UIExpression.ToUpper(nil, Engine.Localize(f13_arg1.title)))
	f13_local0.msg:setText(Engine.Localize(f13_arg1.message))
	if f13_arg1.image and f13_arg1.image ~= "" and f13_local0.rightInfoContainer then
		local f13_local1 = 250
		local f13_local2 = 250
		local f13_local3 = 200
		local f13_local4 = 200
		local Widget = LUI.UIElement.new()
		local f13_local6 = 20
		local f13_local7 = 20
		Widget:setLeftRight(false, false, -f13_local1 / 2 + f13_local7, f13_local1 / 2 + f13_local7)
		Widget:setTopBottom(false, false, -f13_local2 / 2 - f13_local6, f13_local2 / 2 - f13_local6)
		Widget:addElement(CoD.GetInformationContainer())
		Widget:addElement(CoD.GetCenteredImage(f13_local3, f13_local4, f13_arg1.image))
		f13_local0.rightInfoContainer:addElement(Widget)
	end
	local f13_local1 = Engine.Localize("MENU_YES")
	local f13_local2 = Engine.Localize("MENU_CANCEL")
	if f13_arg1.choiceAText then
		f13_local1 = f13_arg1.choiceAText
	end
	if f13_arg1.choiceBText then
		f13_local2 = f13_arg1.choiceBText
	end
	f13_local0.choiceA:setLabel(f13_local1)
	f13_local0.choiceB:setLabel(f13_local2)
	f13_local0.choiceA:setActionEventName(f13_arg1.action)
	f13_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	return f13_local0
end

