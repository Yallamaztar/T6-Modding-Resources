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
	local SpectateChangeTabImage = LUI.UIImage.new()
	SpectateChangeTabImage:setLeftRight(false, false, -76, 150)
	SpectateChangeTabImage:setTopBottom(true, false, 0, 62)
	SpectateChangeTabImage:setImage(RegisterMaterial(CoD.MPZM("hud_shoutcasting_change_tab", "hud_spectating_change_tab_zm")))
	DeadSpectateHud.switchPlayerBar = LUI.UIElement.new()
	DeadSpectateHud.switchPlayerBar:setLeftRight(true, false, 64, 237)
	DeadSpectateHud.switchPlayerBar:setTopBottom(true, false, -3, 29)
	local SpectatingPromptText = Engine.Localize("MPUI_SPECTATING")
 	local f1_local5_1, f1_local5_2, f1_local5_3, f1_local5_4 = GetTextDimensions(SpectatingPromptText, CoD.DeadSpectate.Font, CoD.DeadSpectate.TextSize)
	local SpectateBar = CoD.DualButtonPrompt.new("shoulderl", SpectatingPromptText, "shoulderr", nil, nil, nil, false, false, 0, "mouse1", "mouse2")
	SpectateBar:setLeftRight(false, false, -f1_local5_3 / -19, -f1_local5_3 / -7)
	SpectateBar:setTopBottom(false, false, -10, 10)
	DeadSpectateHud.switchPlayerBar:addElement(SpectateBar)
	local ViewBoxImage = LUI.UIImage.new()
	ViewBoxImage:setLeftRight(false, false, -146, 146)
	ViewBoxImage:setTopBottom(true, false, CoD.DeadSpectate.BodyStart - 4, 68)
	ViewBoxImage:setImage(RegisterMaterial(CoD.MPZM("hud_shoutcasting_viewing_box_dead", "hud_spectating_viewing_box_dead_zm")))
	ViewBoxImage:setAlpha(1)
	local f1_local10 = CoD.DeadSpectate.BodyStart + CoD.DeadSpectate.Height - CoD.DeadSpectate.BodyStart / 2 - CoD.DeadSpectate.TextSize / 2
	DeadSpectateHud.playerName = LUI.UITightText.new()
	DeadSpectateHud.playerName:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	DeadSpectateHud.playerName:setTopBottom(true, false, f1_local10, f1_local10 + CoD.DeadSpectate.TextSize)
	DeadSpectateHud.playerName:setAlignment(LUI.Alignment.Center)
	local f1_local11 = f1_local10 + CoD.DeadSpectate.Height - CoD.DeadSpectate.BodyStart
	local HorizontalList = LUI.UIHorizontalList.new()
	HorizontalList:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	HorizontalList:setTopBottom(true, false, f1_local11, f1_local11 + CoD.DeadSpectate.TextSize * 0.75)
	HorizontalList:setAlignment(LUI.Alignment.Center)
	if Engine.GetActiveLocalClientsCount() == 1 and Engine.GetGametypeSetting("disableThirdPersonSpectating") == 0 then
		DeadSpectateHud.spectateModeButton = CoD.ButtonPrompt.new("alt2", "", DeadSpectateHud, nil, false, false, false, "mouse3")
		DeadSpectateHud.spectateModeButton:setFont(CoD.DeadSpectate.Font)
		HorizontalList:addElement(DeadSpectateHud.spectateModeButton)
	end
	DeadSpectateHud:addElement(SpectateChangeTabImage)
	DeadSpectateHud:addElement(ViewBoxImage)
	DeadSpectateHud:addElement(DeadSpectateHud.switchPlayerBar)
	DeadSpectateHud:addElement(DeadSpectateHud.playerName)
	DeadSpectateHud:addElement(HorizontalList)
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

CoD.DeadSpectate.UpdateVisibility = function (DeadSpectateWidget, ClientInstance)
	if UIExpression.IsVisibilityBitSet(ClientInstance.controller, CoD.BIT_TEAM_SPECTATOR) == 0 and UIExpression.IsVisibilityBitSet(ClientInstance.controller, CoD.BIT_SPECTATING_CLIENT) == 1 and UIExpression.IsVisibilityBitSet(ClientInstance.controller, CoD.BIT_DRAW_SPECTATOR_MESSAGES) == 1 and UIExpression.IsVisibilityBitSet(ClientInstance.controller, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(ClientInstance.controller, CoD.BIT_FINAL_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(ClientInstance.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if not DeadSpectateWidget.visible then
			DeadSpectateWidget:setAlpha(1)
			DeadSpectateWidget.visible = true
		end
		CoD.DeadSpectate.Update(DeadSpectateWidget, ClientInstance)
	elseif DeadSpectateWidget.visible then
		DeadSpectateWidget:setAlpha(0)
		DeadSpectateWidget.visible = nil
	end
end

CoD.DeadSpectate.Update = function (DeadSpectateWidget, f3_arg1)
	local SpectatedClientInfo = Engine.GetSpectatingClientInfo(DeadSpectateWidget.m_ownerController)
	if DeadSpectateWidget.m_selectedClientNum ~= SpectatedClientInfo.clientNum then
		DeadSpectateWidget.m_selectedClientNum = SpectatedClientInfo.clientNum
		local SpectatedClientName = nil
		if SpectatedClientInfo.clanTag ~= nil then
			SpectatedClientName = CoD.getClanTag(SpectatedClientInfo.clanTag) .. SpectatedClientInfo.name
		else
			SpectatedClientName = SpectatedClientInfo.name
		end
		DeadSpectateWidget.hud.playerName:setText(SpectatedClientName)
	end
	if DeadSpectateWidget.hud.spectateModeButton then
		if UIExpression.IsVisibilityBitSet(controller, CoD.BIT_IS_THIRD_PERSON) == 1 then
			CoD.ButtonPrompt.SetText(DeadSpectateWidget.hud.spectateModeButton, Engine.Localize("MPUI_FIRST_PERSON_VIEW"))
		else
			CoD.ButtonPrompt.SetText(DeadSpectateWidget.hud.spectateModeButton, Engine.Localize("MPUI_THIRD_PERSON_VIEW"))
		end
	end
end

