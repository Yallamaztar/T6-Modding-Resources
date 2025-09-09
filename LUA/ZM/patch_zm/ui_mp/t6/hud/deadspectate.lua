require("T6.DualButtonPrompt")
CoD.DeadSpectate = InheritFrom(LUI.UIElement)
CoD.DeadSpectate.SwitchPlayerBarHeight = 22
CoD.DeadSpectate.BodyStart = CoD.DeadSpectate.SwitchPlayerBarHeight
CoD.DeadSpectate.TextSize = CoD.textSize.Default
CoD.DeadSpectate.EmblemSideLength = 38
CoD.DeadSpectate.Width = 300
CoD.DeadSpectate.Height = CoD.DeadSpectate.SwitchPlayerBarHeight + CoD.DeadSpectate.EmblemSideLength
CoD.DeadSpectate.Bottom = -120
CoD.DeadSpectate.Font = CoD.fonts.ExtraSmall
CoD.DeadSpectate.TextSize = CoD.textSize.Default
LUI.createMenu.DeadSpectate = function (LocalClientIndex)
	local DeadSpectateWidget = CoD.Menu.NewSafeAreaFromState("DeadSpectate", LocalClientIndex)
	DeadSpectateWidget.m_ownerController = LocalClientIndex
	DeadSpectateWidget.m_selectedClientNum = nil
	
	local DeadSpectateHud = CoD.SplitscreenScaler.new(nil, 1.5)
	DeadSpectateHud:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	DeadSpectateHud:setTopBottom(false, true, CoD.DeadSpectate.Bottom - CoD.DeadSpectate.Height, CoD.DeadSpectate.Bottom)
	DeadSpectateWidget:addElement(DeadSpectateHud)
	DeadSpectateWidget.hud = DeadSpectateHud
	
	local f1_local2 = LUI.UIImage.new()
	f1_local2:setLeftRight(false, false, -76, 150)
	f1_local2:setTopBottom(true, false, 0, 62)
	f1_local2:setImage(RegisterMaterial(CoD.MPZM("hud_shoutcasting_change_tab", "hud_spectating_change_tab_zm")))
	DeadSpectateHud.switchPlayerBar = LUI.UIElement.new()
	DeadSpectateHud.switchPlayerBar:setLeftRight(true, false, 64, 237)
	DeadSpectateHud.switchPlayerBar:setTopBottom(true, false, -3, 29)
	local f1_local3 = 9
	local f1_local4 = Engine.Localize("MPUI_SPECTATING")
	local f1_local5 = {}
	f1_local5 = GetTextDimensions(f1_local4, CoD.DeadSpectate.Font, CoD.DeadSpectate.TextSize)
	local f1_local6 = f1_local5[3]
	local f1_local7 = CoD.DualButtonPrompt.new
	local f1_local8 = "shoulderl"
	local f1_local9 = f1_local4
	local f1_local10 = "shoulderr"
	local f1_local11, f1_local12, f1_local13 = nil
	local f1_local14, f1_local15 = false
	f1_local7 = f1_local7(f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local14, f1_local15, 0, "mouse1", "mouse2")
	f1_local7:setLeftRight(false, false, -f1_local6 / 2 - f1_local3 - 12, -f1_local6 / 2 - f1_local3)
	f1_local7:setTopBottom(false, false, -10, 10)
	DeadSpectateHud.switchPlayerBar:addElement(f1_local7)
	f1_local8 = LUI.UIImage.new()
	f1_local8:setLeftRight(false, false, -146, 146)
	f1_local8:setTopBottom(true, false, CoD.DeadSpectate.BodyStart - 4, 68)
	f1_local8:setImage(RegisterMaterial(CoD.MPZM("hud_shoutcasting_viewing_box_dead", "hud_spectating_viewing_box_dead_zm")))
	f1_local8:setAlpha(1)
	f1_local9 = CoD.DeadSpectate.Height - CoD.DeadSpectate.BodyStart
	f1_local10 = CoD.DeadSpectate.BodyStart + f1_local9 / 2 - CoD.DeadSpectate.TextSize / 2
	DeadSpectateHud.playerName = LUI.UITightText.new()
	DeadSpectateHud.playerName:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	DeadSpectateHud.playerName:setTopBottom(true, false, f1_local10, f1_local10 + CoD.DeadSpectate.TextSize)
	DeadSpectateHud.playerName:setAlignment(LUI.Alignment.Center)
	f1_local11 = f1_local10 + f1_local9
	f1_local12 = LUI.UIHorizontalList.new()
	f1_local12:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	f1_local12:setTopBottom(true, false, f1_local11, f1_local11 + CoD.DeadSpectate.TextSize * 0.75)
	f1_local12:setAlignment(LUI.Alignment.Center)
	if Engine.GetActiveLocalClientsCount() == 1 and 0 == Engine.GetGametypeSetting("disableThirdPersonSpectating") then
		f1_local13 = CoD.ButtonPrompt.new
		f1_local14 = "alt2"
		f1_local15 = ""
		local f1_local16 = DeadSpectateHud
		local f1_local17 = nil
		local f1_local18, f1_local19 = false
		DeadSpectateHud.spectateModeButton = f1_local13(f1_local14, f1_local15, f1_local16, f1_local17, f1_local18, f1_local19, false, "mouse3")
		DeadSpectateHud.spectateModeButton:setFont(CoD.DeadSpectate.Font)
		f1_local12:addElement(DeadSpectateHud.spectateModeButton)
	end
	DeadSpectateHud:addElement(f1_local2)
	DeadSpectateHud:addElement(f1_local8)
	DeadSpectateHud:addElement(DeadSpectateHud.switchPlayerBar)
	DeadSpectateHud:addElement(DeadSpectateHud.playerName)
	DeadSpectateHud:addElement(f1_local12)
	DeadSpectateHud.playerName:setText("")
	DeadSpectateHud:setAlpha(1)
	DeadSpectateWidget:setAlpha(0)
	DeadSpectateWidget.visible = false
	DeadSpectateWidget:registerEventHandler("hud_update_refresh", CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_TEAM_SPECTATOR, CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DRAW_SPECTATOR_MESSAGES, CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.DeadSpectate.UpdateVisibility)
	DeadSpectateWidget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_THIRD_PERSON, CoD.DeadSpectate.Update)
	return DeadSpectateWidget
end

CoD.DeadSpectate.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_TEAM_SPECTATOR) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SPECTATING_CLIENT) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DRAW_SPECTATOR_MESSAGES) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_FINAL_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
		CoD.DeadSpectate.Update(f2_arg0, f2_arg1)
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

CoD.DeadSpectate.Update = function (f3_arg0, f3_arg1)
	local f3_local0 = Engine.GetSpectatingClientInfo(f3_arg0.m_ownerController)
	if f3_arg0.m_selectedClientNum ~= f3_local0.clientNum then
		f3_arg0.m_selectedClientNum = f3_local0.clientNum
		local f3_local1 = nil
		if f3_local0.clanTag ~= nil then
			f3_local1 = CoD.getClanTag(f3_local0.clanTag) .. f3_local0.name
		else
			f3_local1 = f3_local0.name
		end
		f3_arg0.hud.playerName:setText(f3_local1)
	end
	if f3_arg0.hud.spectateModeButton then
		if UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IS_THIRD_PERSON) == 1 then
			CoD.ButtonPrompt.SetText(f3_arg0.hud.spectateModeButton, Engine.Localize("MPUI_FIRST_PERSON_VIEW"))
		else
			CoD.ButtonPrompt.SetText(f3_arg0.hud.spectateModeButton, Engine.Localize("MPUI_THIRD_PERSON_VIEW"))
		end
	end
end

