CoD.EquipNotification = {}
CoD.EquipNotification.NotificationQueue = {}
CoD.EquipNotification.NotificationFontName = "Default"
CoD.EquipNotification.NotificationFont = CoD.fonts[CoD.EquipNotification.NotificationFontName]
CoD.EquipNotification.NotificationFontHeight = CoD.textSize[CoD.EquipNotification.NotificationFontName]
CoD.EquipNotification.Height = CoD.EquipNotification.NotificationFontHeight
CoD.EquipNotification.FadeInDuration = 600
CoD.EquipNotification.FadeOutDuration = 400
CoD.EquipNotification.new = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = "EquipNotification"
	Widget.text = LUI.UIText.new()
	Widget.text:setLeftRight(true, true, 0, 0)
	Widget.text:setTopBottom(true, true, 0, 0)
	Widget.text:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	Widget.text:setAlpha(0)
	Widget.text:setFont(CoD.EquipNotification.NotificationFont)
	Widget.text:setAlignment(LUI.Alignment.Right)
	Widget.text:setText("Equipment Notification")
	Widget.text:registerEventHandler("transition_complete_fade_in", CoD.EquipNotification.Text_TransitionCompleteFadeIn)
	Widget.text:registerEventHandler("transition_complete_fade_out", CoD.EquipNotification.Text_TransitionCompleteFadeOut)
	Widget:addElement(Widget.text)
	Widget:registerEventHandler("update_class", CoD.EquipNotification.Update)
	return Widget
end

CoD.EquipNotification.SetNotificationText = function (f2_arg0, f2_arg1)
	local f2_local0 = nil
	if f2_arg1.itemType == "bonusCard" then
		if f2_arg1.itemStatus == "equipped" then
			f2_local0 = "MENU_ACTIVATED_CAPS"
		else
			f2_local0 = "MENU_DEACTIVATED_CAPS"
		end
		f2_arg0:setText(Engine.Localize(f2_local0) .. " " .. UIExpression.ToUpper(nil, Engine.Localize(f2_arg1.itemName)) .. " " .. Engine.Localize("MENU_WILDCARD_CAPS"))
	else
		if f2_arg1.itemStatus == "equipped" then
			f2_local0 = "MPUI_EQUIPPED_CAPS"
		else
			f2_local0 = "MENU_UNEQUIPPED_CAPS"
		end
		f2_arg0:setText(Engine.Localize(f2_local0) .. " " .. UIExpression.ToUpper(nil, Engine.Localize(f2_arg1.itemName)))
	end
end

CoD.EquipNotification.Text_FadeIn = function (f3_arg0, f3_arg1)
	f3_arg0:beginAnimation("fade_in", CoD.EquipNotification.FadeInDuration)
	CoD.EquipNotification.SetNotificationText(f3_arg0, f3_arg1)
	f3_arg0:setAlpha(1)
end

CoD.EquipNotification.Update = function (f4_arg0, f4_arg1)
	if #CoD.EquipNotification.NotificationQueue == 0 or f4_arg0.text.animating == true then
		return 
	else
		CoD.EquipNotification.Text_FadeIn(f4_arg0.text, CoD.EquipNotification.NotificationQueue[1])
		f4_arg0.text.animating = true
	end
end

CoD.EquipNotification.Text_TransitionCompleteFadeIn = function (f5_arg0, f5_arg1)
	f5_arg0:beginAnimation("fade_out", CoD.EquipNotification.FadeOutDuration)
	f5_arg0:setAlpha(0)
end

CoD.EquipNotification.Text_TransitionCompleteFadeOut = function (f6_arg0, f6_arg1)
	table.remove(CoD.EquipNotification.NotificationQueue, 1)
	if #CoD.EquipNotification.NotificationQueue == 0 then
		f6_arg0.animating = false
		return 
	else
		CoD.EquipNotification.Text_FadeIn(f6_arg0, CoD.EquipNotification.NotificationQueue[1])
	end
end

CoD.EquipNotification.AddToNotificationQueue = function (f7_arg0, f7_arg1, f7_arg2)
	table.insert(CoD.EquipNotification.NotificationQueue, {
		itemType = f7_arg0,
		itemStatus = f7_arg1,
		itemName = f7_arg2
	})
end

CoD.EquipNotification.ClearNotificationQueue = function ()
	CoD.EquipNotification.NotificationQueue = {}
end

