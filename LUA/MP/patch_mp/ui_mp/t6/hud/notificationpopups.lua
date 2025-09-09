require("T6.HUD.NotificationDoubleXP")
CoD.NotificationPopups = {}
CoD.NotificationPopups.KillstreakLaserInTime = 600
CoD.NotificationPopups.KillstreakImageInTime = 1000
CoD.NotificationPopups.KillstreakImageSize = 128
CoD.NotificationPopups.PlayerCallout_Y = 270
CoD.NotificationPopups.PlayerCallout_Height = CoD.NamePlate.Height
CoD.NotificationPopups.PlayerEmblem_Size = CoD.NamePlate.PlayerEmblem_Size
CoD.NotificationPopups.PlayerCallout_Width = CoD.NamePlate.Width
CoD.NotificationPopups.MedalNameColumn = 2
CoD.NotificationPopups.MedalMaterialColumn = 3
CoD.NotificationPopups.MedalInTime = 200
CoD.NotificationPopups.MedalVisibleTime = 2000
CoD.NotificationPopups.MedalOutTime = 250
CoD.NotificationPopups.MedalImageHeight = 128
CoD.NotificationPopups.MedalImageWidth = 128
CoD.NotificationPopups.GunLevelInTime = 200
CoD.NotificationPopups.GunLevelVisibleTime = 2000
CoD.NotificationPopups.GunLevelOutTime = 250
CoD.NotificationPopups.GunLevelImageHeight = 96
CoD.NotificationPopups.GunLevelImageWidth = 96
CoD.NotificationPopups.RankUpImageWidth = 96
CoD.NotificationPopups.RankUpImageHeight = 96
CoD.NotificationPopups.ChallengeImageHeight = 170
CoD.NotificationPopups.ChallengeImageWidth = 170
CoD.NotificationPopups.ChallengeTextHeight = 55
CoD.NotificationPopups.ChallengeTextDescHeight = 87
CoD.NotificationPopups.TextHeight = 26
CoD.NotificationPopups.FontName = "Default"
CoD.NotificationPopups.TitleFontName = "Condensed"
CoD.NotificationPopups.ObitPlayerCallout_Y = 360
CoD.NotificationPopups.SplitscreenImageRatio = 0.75
CoD.NotificationPopups.SplitscreenImageTopOffset = 20
CoD.NotificationPopups.Priorities = {}
CoD.NotificationPopups.Priorities.Rank = 8
CoD.NotificationPopups.Priorities.Challenge = 8
CoD.NotificationPopups.Priorities.GunLevel = 9
CoD.NotificationPopups.Priorities.Medals = 10
CoD.NotificationPopups.Priorities.Killstreaks = 20
CoD.NotificationPopups.Challenge_Global = 0
CoD.NotificationPopups.Challenge_Weapon = 1
CoD.NotificationPopups.Challenge_GameType = 2
CoD.NotificationPopups.Challenge_Group = 3
CoD.NotificationPopups.Challenge_Attachments = 4
LUI.createMenu.NotificationPopups = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("NotificationPopups", f1_arg0)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_ROUND_END_KILLCAM, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_ENABLE_POPUPS, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.NotificationPopups.UpdateVisibility)
	f1_local0:registerEventHandler("killstreak_received", CoD.NotificationPopups.KillstreakReceived)
	f1_local0:registerEventHandler("medal_received", CoD.NotificationPopups.MedalReceived)
	f1_local0:registerEventHandler("player_callout", CoD.NotificationPopups.PlayerCallout)
	f1_local0:registerEventHandler("player_obituary_callout", CoD.NotificationPopups.PlayerObituaryCallout)
	f1_local0:registerEventHandler("pump_queue", CoD.NotificationPopups.PumpQueue)
	f1_local0:registerEventHandler("notification_complete", CoD.NotificationPopups.NotificationComplete)
	f1_local0:registerEventHandler("gun_level_complete", CoD.NotificationPopups.GunLevelComplete)
	f1_local0:registerEventHandler("rank_up", CoD.NotificationPopups.RankUp)
	f1_local0:registerEventHandler("challenge_complete", CoD.NotificationPopups.ChallengeComplete)
	f1_local0:registerEventHandler("demo_jump", CoD.NotificationPopups.ClearQueue)
	f1_local0.visible = true
	f1_local0.NotificationActive = false
	f1_local0.NotificationQueue = {}
	f1_local0.Priorities = {}
	return f1_local0
end

CoD.NotificationPopups.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_FINAL_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_ROUND_END_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_ENABLE_POPUPS) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.NotificationPopups.NotificationComplete = function (f3_arg0)
	f3_arg0.NotificationActive = false
	f3_arg0:processEvent({
		name = "pump_queue"
	})
end

CoD.NotificationPopups.ClearQueue = function (f4_arg0, f4_arg1)
	for f4_local0 = 1, #f4_arg0.NotificationQueue, 1 do
		table.remove(f4_arg0.NotificationQueue, f4_local0)
	end
	f4_arg0.NotificationActive = false
	f4_arg0:dispatchEventToChildren(f4_arg1)
end

CoD.NotificationPopups.PumpQueue = function (f5_arg0)
	if f5_arg0.NotificationActive == false and #f5_arg0.NotificationQueue > 0 then
		local f5_local0 = -1
		local f5_local1 = -1
		for f5_local2 = 1, #f5_arg0.NotificationQueue, 1 do
			if f5_local0 < f5_arg0.NotificationQueue[f5_local2].priority then
				f5_local0 = f5_arg0.NotificationQueue[f5_local2].priority
				f5_local1 = f5_local2
			end
		end
		if f5_local0 < 0 or f5_local1 < 1 then
			error("Incorrect priority " .. f5_local0 .. " or notificationIndex " .. f5_local1 .. " in notificationPopups. ")
		end
		local f5_local2 = f5_arg0.NotificationQueue[f5_local1]
		f5_arg0.NotificationActive = true
		table.remove(f5_arg0.NotificationQueue, f5_local1)
		f5_local2.callback(f5_arg0, f5_local2.event)
	end
end

CoD.NotificationPopups.AddToQueue = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	table.insert(f6_arg0.NotificationQueue, {
		priority = f6_arg1,
		callback = f6_arg2,
		event = f6_arg3
	})
	f6_arg0:processEvent({
		name = "pump_queue"
	})
end

CoD.NotificationPopups.ShouldShowPopups = function (f7_arg0)
	if not CoD.IsShoutcaster(f7_arg0.controller) or CoD.ExeProfileVarBool(f7_arg0.controller, "shoutcaster_playernotifications") then
		return true
	else
		return false
	end
end

CoD.NotificationPopups.KillstreakReceived = function (f8_arg0, f8_arg1)
	CoD.NotificationPopups.AddToQueue(f8_arg0, CoD.NotificationPopups.Priorities.Killstreaks, CoD.NotificationPopups.KillstreakNotify, f8_arg1)
end

CoD.NotificationPopups.KillstreakNotify = function (f9_arg0, f9_arg1)
	if not CoD.IsShoutcaster(f9_arg1.controller) or CoD.ExeProfileVarBool(f9_arg1.controller, "shoutcaster_scorestreaksnotification") then
		local f9_local0 = f9_arg1.data[1]
		local f9_local1 = Engine.GetIString(f9_arg1.data[2], "CS_LOCALIZED_STRINGS")
		local f9_local2 = CoD.NotificationPopups.KillstreakImageSize
		local f9_local3 = 20
		if Engine.IsSplitscreen() == true then
			f9_local2 = f9_local2 * CoD.NotificationPopups.SplitscreenImageRatio
		end
		local f9_local4 = CoD.SplitscreenScaler.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f9_local2 / 2,
			right = f9_local2 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = f9_local2,
			alpha = 1
		}, CoD.SplitscreenNotificationMultiplier)
		f9_local4:setUseGameTime(true)
		f9_local4.id = "KillstreakNotifyContainer"
		f9_local4:registerAnimationState("out", {
			alpha = 0
		})
		f9_local4:registerEventHandler("in", CoD.NotificationPopups.KillstreakNotify_In)
		f9_local4:registerEventHandler("out", CoD.NotificationPopups.KillstreakNotify_Out)
		f9_local4:registerEventHandler("transition_complete_out", f9_local4.close)
		f9_local4:registerEventHandler("demo_jump", f9_local4.close)
		f9_local4:registerEventHandler("killstreak_notify_start", CoD.NotificationPopups.KillstreakNotifyStart)
		f9_local4.itemIndex = f9_local0
		f9_local4.informDialog = f9_local1
		f9_local4.killstreakImageSize = f9_local2
		f9_local4.killstreakImageTop = f9_local3
		f9_arg0:addElement(f9_local4)
		local f9_local5 = LUI.UIStreamedImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f9_local2 / 2,
			right = f9_local2 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f9_local3,
			bottom = f9_local3 + f9_local2,
			material = RegisterMaterial(UIExpression.GetItemImage(nil, f9_local0) .. "_big"),
			shaderVector0 = {
				0,
				0,
				0,
				0
			},
			alpha = 0.9
		}, 4000)
		f9_local5:registerAnimationState("in", {
			shaderVector0 = {
				0,
				0,
				0,
				0
			}
		})
		f9_local5:registerAnimationState("in2", {
			shaderVector0 = {
				0,
				1,
				0,
				0
			}
		})
		f9_local5:registerAnimationState("out", {
			alpha = 0
		})
		f9_local5:registerEventHandler("transition_complete_in", CoD.NotificationPopups.KillstreakNotify_Image_In)
		f9_local5:registerEventHandler("streamed_image_ready", CoD.NotificationPopups.KillstreakImageStreamed)
		f9_local5:registerEventHandler("streamed_image_timed_out", CoD.NotificationPopups.KillstreakImageStreamTimeOut)
		f9_local4.image = f9_local5
		f9_local4:addElement(f9_local5)
	else
		f9_arg0:processEvent({
			name = "notification_complete"
		})
	end
end

CoD.NotificationPopups.KillstreakImageStreamed = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToParent({
		name = "killstreak_notify_start"
	})
end

CoD.NotificationPopups.KillstreakImageStreamTimeOut = function (f11_arg0, f11_arg1)
	f11_arg0:setupUIImage()
	f11_arg0:setImage(RegisterMaterial("hud_ks_default_big"))
	f11_arg0:dispatchEventToParent({
		name = "killstreak_notify_start"
	})
end

CoD.NotificationPopups.KillstreakNotifyStart = function (f12_arg0, f12_arg1)
	local f12_local0 = 2500
	f12_arg0.image:animateToState("in", CoD.NotificationPopups.KillstreakLaserInTime)
	f12_arg0:addElement(LUI.UITimer.new(CoD.NotificationPopups.KillstreakLaserInTime + CoD.NotificationPopups.KillstreakImageInTime - CoD.DistFieldText.PulseInTime, "in", true))
	f12_arg0:addElement(LUI.UITimer.new(f12_local0, "out", true))
end

CoD.NotificationPopups.KillstreakNotify_Image_In = function (f13_arg0, f13_arg1)
	f13_arg0:animateToState("in2", CoD.NotificationPopups.KillstreakImageInTime)
end

CoD.NotificationPopups.KillstreakNotify_In = function (f14_arg0, f14_arg1)
	Engine.PlaySound(f14_arg0.informDialog)
	local f14_local0 = f14_arg0.killstreakImageSize
	local f14_local1 = f14_arg0.killstreakImageTop
	f14_arg0.darkSplash = LUI.UIImage.new()
	f14_arg0.darkSplash:setLeftRight(false, false, -f14_local0 / 2, f14_local0 / 2)
	f14_arg0.darkSplash:setTopBottom(true, false, f14_local1, f14_local1 + f14_local0)
	f14_arg0.darkSplash:setImage(RegisterMaterial("ks_menu_background"))
	f14_arg0.darkSplash:setAlpha(1)
	f14_arg0.darkSplash:setPriority(-100)
	f14_arg0:addElement(f14_arg0.darkSplash)
	local f14_local2 = 175
	local f14_local3 = 50
	local f14_local4 = 3
	f14_arg0.textDarkSplash = LUI.UIImage.new()
	f14_arg0.textDarkSplash:setLeftRight(false, false, -f14_local2 / 2, f14_local2 / 2)
	f14_arg0.textDarkSplash:setTopBottom(false, true, -2 - f14_local3 / 2 + f14_local4, -2 + CoD.textSize[CoD.NotificationPopups.FontName] + f14_local3 / 2 + f14_local4)
	f14_arg0.textDarkSplash:setImage(RegisterMaterial("ks_menu_background"))
	f14_arg0:addElement(f14_arg0.textDarkSplash)
	
	local text = LUI.UIText.new()
	text:setLeftRight(true, true, 0, 0)
	text:setTopBottom(false, true, -2, -2 + CoD.textSize[CoD.NotificationPopups.FontName])
	text:setFont(CoD.fonts[CoD.NotificationPopups.FontName])
	text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	text:setAlpha(0.7)
	text:setText(UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f14_arg0.itemIndex))))
	f14_arg0:addElement(text)
	f14_arg0.text = text
	
	local glow = CoD.AdditiveTextOverlay.new(90, 55, CoD.ScoreFeed.Color1, CoD.ScoreFeed.Color2, CoD.ScoreFeed.Color3, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f14_arg0:addElement(glow)
	f14_arg0.glow = glow
	
end

CoD.NotificationPopups.KillstreakNotify_Out = function (f15_arg0, f15_arg1)
	f15_arg0:addElement(LUI.UITimer.new(CoD.AdditiveTextOverlay.PulseOutTime, "killstreakNotify_complete", true))
	f15_arg0:registerEventHandler("killstreakNotify_complete", CoD.NotificationPopups.KillstreakNotifyComplete)
	f15_arg0.image:close()
	f15_arg0.text:close()
	f15_arg0.textDarkSplash:close()
	f15_arg0.darkSplash:close()
	f15_arg0.glow:out()
end

CoD.NotificationPopups.KillstreakNotifyComplete = function (f16_arg0, f16_arg1)
	f16_arg0:dispatchEventToParent({
		name = "notification_complete"
	})
	f16_arg0:close()
end

CoD.NotificationPopups.MedalReceived = function (f17_arg0, f17_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f17_arg1) then
		CoD.NotificationPopups.AddToQueue(f17_arg0, CoD.NotificationPopups.Priorities.Medals, CoD.NotificationPopups.MedalNotify, f17_arg1)
	end
end

CoD.NotificationPopups.MedalNotify = function (f18_arg0, f18_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f18_arg1) then
		local f18_local0 = f18_arg1.data[1]
		local f18_local1 = UIExpression.TableLookupGetColumnValueForRow(f18_arg1.controller, CoD.scoreInfoTable, f18_local0, CoD.NotificationPopups.MedalMaterialColumn)
		local f18_local2 = CoD.NotificationPopups.MedalImageHeight
		local f18_local3 = CoD.NotificationPopups.MedalImageWidth
		local f18_local4 = 0
		if Engine.IsSplitscreen() == true then
			f18_local2 = f18_local2 * CoD.NotificationPopups.SplitscreenImageRatio
			f18_local3 = f18_local3 * CoD.NotificationPopups.SplitscreenImageRatio
			f18_local4 = f18_local4 + CoD.NotificationPopups.SplitscreenImageTopOffset
		end
		local f18_local5 = CoD.SplitscreenScaler.new({
			rightAnchor = false,
			leftAnchor = false,
			left = -f18_local3 / 2,
			right = f18_local3 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = f18_local2,
			alpha = 0
		}, CoD.SplitscreenNotificationMultiplier)
		f18_local5:setUseGameTime(true)
		f18_local5.id = "MedalNotifyContainer"
		f18_local5:registerAnimationState("in", {
			alpha = 1
		})
		f18_local5:registerAnimationState("out", {
			alpha = 0
		})
		f18_local5:registerEventHandler("transition_complete_out", CoD.NotificationPopups.MedalNotifyComplete)
		f18_local5:registerEventHandler("outState", CoD.NotificationPopups.MedalNotify_Out)
		f18_local5:registerEventHandler("medal_notify_start", CoD.NotificationPopups.MedalNotifyStart)
		f18_local5:registerEventHandler("demo_jump", f18_local5.close)
		f18_local5.medalIndex = f18_local0
		f18_arg0:addElement(f18_local5)
		local f18_local6 = LUI.UIStreamedImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f18_local3 / 2,
			right = f18_local3 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f18_local4,
			bottom = f18_local4 + f18_local2,
			material = RegisterMaterial(f18_local1),
			alpha = 0.9
		}, 4000)
		f18_local6:registerEventHandler("streamed_image_ready", CoD.NotificationPopups.MedalImageStreamed)
		f18_local6:registerEventHandler("streamed_image_timed_out", CoD.NotificationPopups.MedalImageStreamTimeOut)
		f18_local5.image = f18_local6
		f18_local5.controller = f18_arg1.controller
		f18_local5:addElement(f18_local6)
	else
		f18_arg0:processEvent({
			name = "notification_complete"
		})
	end
end

CoD.NotificationPopups.MedalImageStreamTimeOut = function (f19_arg0, f19_arg1)
	f19_arg0:setupUIImage()
	f19_arg0:setImage(RegisterMaterial("hud_medals_default"))
	f19_arg0:dispatchEventToParent({
		name = "medal_notify_start"
	})
end

CoD.NotificationPopups.MedalImageStreamed = function (f20_arg0, f20_arg1)
	f20_arg0:dispatchEventToParent({
		name = "medal_notify_start"
	})
end

CoD.NotificationPopups.MedalNotifyStart = function (f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0.medalIndex
	local f21_local1 = CoD.NotificationPopups.MedalInTime
	local f21_local2 = CoD.NotificationPopups.MedalVisibleTime
	local f21_local3 = CoD.NotificationPopups.MedalOutTime
	local f21_local4 = UIExpression.TableLookupGetColumnValueForRow(nil, CoD.scoreInfoTable, f21_local0, CoD.NotificationPopups.MedalNameColumn)
	f21_arg0:animateToState("in", f21_local1)
	f21_arg0.image:setupBitchinFX(RegisterMaterial("bitchin_glint_reveal"))
	f21_arg0.image:playBitchinFX(500)
	Engine.PlaySound("mus_lau_medal")
	if CoD.NotificationPopups.GlowMaterial == nil then
		CoD.NotificationPopups.GlowMaterial = RegisterMaterial("hud_lui_medal_glow")
	end
	local f21_local5 = CoD.AdditiveTextOverlay.new(70, 50, CoD.ScoreFeed.Color1, CoD.ScoreFeed.Color2, CoD.ScoreFeed.Color3, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, CoD.NotificationPopups.GlowMaterial)
	f21_local5.glow:animateToState("default")
	f21_arg0:addElement(f21_local5)
	local f21_local6 = 128
	if Engine.IsSplitscreen() == true then
		f21_local6 = f21_local6 * CoD.NotificationPopups.SplitscreenImageRatio + 15
	end
	local text = CoD.NotificationPopups.CreateText(f21_local6, UIExpression.ToUpper(nil, Engine.Localize(f21_local4)))
	f21_arg0:addElement(text)
	f21_arg0.text = text
	
	f21_arg0:addElement(LUI.UITimer.new(f21_local2 - f21_local1 - f21_local3, "outState", true))
	local f21_local8 = Engine.GetXPScale(f21_arg0.controller)
	if f21_local8 and f21_local8 > 1 then
		local f21_local9 = f21_local6 + 5 - CoD.NotificationDoubleXP.Height
		local f21_local10 = CoD.NotificationDoubleXP.New(f21_local9)
		f21_local10:setLeftRight(true, false, -CoD.NotificationDoubleXP.Width, 0)
		f21_local10:setTopBottom(true, false, f21_local9, f21_local9 + CoD.NotificationDoubleXP.Height)
		f21_local10:setAlpha(0)
		f21_arg0:addElement(f21_local10)
	end
end

CoD.NotificationPopups.MedalNotify_Out = function (f22_arg0, f22_arg1)
	f22_arg0:animateToState("out", CoD.NotificationPopups.MedalOutTime)
end

CoD.NotificationPopups.MedalNotifyComplete = function (f23_arg0, f23_arg1)
	f23_arg0:dispatchEventToParent({
		name = "notification_complete"
	})
	f23_arg0.image:close()
	f23_arg0:close()
end

CoD.NotificationPopups.CreateImage = function (f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4, f24_arg5, f24_arg6)
	local f24_local0 = LUI.UIImage.new()
	f24_local0:setLeftRight(f24_arg2, f24_arg3, f24_arg4, f24_arg4 + f24_arg0)
	f24_local0:setTopBottom(true, false, f24_arg5, f24_arg5 + f24_arg1)
	f24_local0:setImage(RegisterMaterial(f24_arg6))
	f24_local0:setAlpha(1)
	f24_local0:setPriority(-10)
	return f24_local0
end

CoD.NotificationPopups.CreateText = function (f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setPriority(-50)
	local f25_local1 = CoD.NotificationPopups.FontName
	if f25_arg2 ~= nil and f25_arg2 == true then
		f25_local1 = CoD.NotificationPopups.TitleFontName
	end
	if nil ~= disableDarkSpash then
		f25_arg3 = false
	end
	if f25_arg4 == nil then
		f25_arg4 = false
	end
	if f25_arg3 == false then
		local f25_local2 = 250
		local f25_local3 = 50
		local f25_local4 = 3
		local f25_local5 = LUI.UIImage.new()
		f25_local5:setLeftRight(false, false, -f25_local2 / 2, f25_local2 / 2)
		f25_local5:setTopBottom(true, false, f25_arg0 - f25_local3 / 2 + f25_local4, f25_arg0 + CoD.textSize[f25_local1] + f25_local3 / 2 + f25_local4)
		f25_local5:setImage(RegisterMaterial("ks_menu_background"))
		Widget:addElement(f25_local5)
	end
	local f25_local2 = LUI.UIText.new()
	if f25_arg4 == true then
		f25_local2:setLeftRight(false, false, -202, 198)
	else
		f25_local2:setLeftRight(true, true, 2, 2)
	end
	f25_local2:setTopBottom(true, false, f25_arg0 + 2, f25_arg0 + 2 + CoD.textSize[f25_local1])
	f25_local2:setFont(CoD.fonts[f25_local1])
	f25_local2:setRGB(0, 0, 0)
	if f25_arg4 == true then
		f25_local2:setAlignment(LUI.Alignment.Center)
	end
	f25_local2:setAlpha(0.5)
	f25_local2:setText(f25_arg1)
	Widget:addElement(f25_local2)
	f25_local2 = LUI.UIText.new()
	if f25_arg4 == true then
		f25_local2:setLeftRight(false, false, -200, 200)
	else
		f25_local2:setLeftRight(true, true, 0, 0)
	end
	f25_local2:setTopBottom(true, false, f25_arg0, f25_arg0 + CoD.textSize[f25_local1])
	f25_local2:setFont(CoD.fonts[f25_local1])
	f25_local2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f25_local2:setAlpha(1)
	if f25_arg4 == true then
		f25_local2:setAlignment(LUI.Alignment.Center)
	end
	f25_local2:setText(f25_arg1)
	Widget:addElement(f25_local2)
	return Widget
end

CoD.NotificationPopups.GunLevelComplete = function (f26_arg0, f26_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f26_arg1) then
		CoD.NotificationPopups.AddToQueue(f26_arg0, CoD.NotificationPopups.Priorities.GunLevel, CoD.NotificationPopups.GunLevelNotify, f26_arg1)
	end
end

CoD.NotificationPopups.GunLevelNotify = function (f27_arg0, f27_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f27_arg1) then
		local f27_local0 = f27_arg1.data[3]
		local f27_local1 = f27_arg1.data[4]
		local f27_local2 = f27_arg1.data[2]
		if f27_local0 == 0 and f27_local1 == 0 then
			f27_arg0:processEvent({
				name = "notification_complete"
			})
			return 
		end
		local f27_local3 = nil
		local f27_local4 = CoD.NotificationPopups.GunLevelImageHeight
		local f27_local5 = CoD.NotificationPopups.GunLevelImageWidth
		if f27_local0 ~= 0 then
			f27_local3 = UIExpression.GetAttachmentImage(f27_arg1.controller, f27_local0)
		else
			f27_local5 = f27_local5 * 2
			f27_local3 = UIExpression.GetItemImage(f27_arg1.controller, f27_local2)
		end
		if Engine.IsSplitscreen() == true then
			f27_local4 = f27_local4 * CoD.NotificationPopups.SplitscreenImageRatio
			f27_local5 = f27_local5 * CoD.NotificationPopups.SplitscreenImageRatio
		end
		local f27_local6 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenNotificationMultiplier)
		f27_local6:setLeftRight(false, false, -f27_local5 * 1.5, f27_local5 * 1.5)
		f27_local6:setTopBottom(true, false, -f27_local4 / 2, f27_local4 / 2)
		f27_local6:setAlpha(1)
		f27_local6:setUseGameTime(true)
		f27_local6.id = "GunLevelNotifyContainer"
		f27_local6:registerAnimationState("in", {
			alpha = 1
		})
		f27_local6:registerAnimationState("out", {
			alpha = 0
		})
		f27_local6:registerEventHandler("transition_complete_out", CoD.NotificationPopups.PopupNotifyComplete)
		f27_local6:registerEventHandler("outState", CoD.NotificationPopups.PopupNotify_Out)
		f27_local6:registerEventHandler("demo_jump", f27_local6.close)
		f27_local6.rankId = f27_arg1.data[1]
		f27_local6.itemIndex = f27_local2
		f27_local6.attachmentIndex = f27_local0
		f27_local6.rewardXP = f27_local1
		f27_arg0:addElement(f27_local6)
		if f27_local3 ~= "" then
			local image = CoD.NotificationPopups.CreateImage(f27_local5, f27_local4, false, false, -f27_local5 / 2, f27_local4 / 2, f27_local3)
			f27_local6:addElement(image)
			f27_local6.image = image
			
			image:setupBitchinFX(RegisterMaterial("bitchin_grid"))
			image:playBitchinFX(1000, true)
		end
		local image = 24
		if f27_local0 ~= 0 then
			local attachmentText = CoD.NotificationPopups.CreateText(f27_local4 * 1.5, Engine.Localize("RANK_GUN_UNLOCK_ATT", Engine.Localize(UIExpression.GetAttachmentName(nil, f27_local0))))
			f27_local6:addElement(attachmentText)
			f27_local6.attachmentText = attachmentText
			
		elseif f27_local1 ~= 0 then
			local attachmentText = CoD.NotificationPopups.CreateText(f27_local4 * 1.5, Engine.Localize("RANK_XP", f27_local1))
			f27_local6:addElement(attachmentText)
			f27_local6.attachmentText = attachmentText
		end
		local weaponText = CoD.NotificationPopups.CreateText(f27_local4 * 1.5 + image, Engine.Localize(UIExpression.GetItemName(nil, f27_local6.itemIndex)))
		f27_local6:addElement(weaponText)
		f27_local6.weaponText = weaponText
		
		local f27_local10 = CoD.NotificationPopups.GunLevelInTime
		local f27_local11 = CoD.NotificationPopups.GunLevelVisibleTime
		local f27_local12 = CoD.NotificationPopups.GunLevelOutTime
		Engine.PlaySound("mus_lau_gun")
		f27_local6:animateToState("in", f27_local10, false, true)
		f27_local6:addElement(LUI.UITimer.new(f27_local11 - f27_local10 - f27_local12, "outState", true))
	else
		f27_arg0:processEvent({
			name = "notification_complete"
		})
	end
end

CoD.NotificationPopups.RankUp = function (f28_arg0, f28_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f28_arg1) then
		CoD.NotificationPopups.AddToQueue(f28_arg0, CoD.NotificationPopups.Priorities.Rank, CoD.NotificationPopups.RankUpNotify, f28_arg1)
	end
end

CoD.NotificationPopups.RankUpNotify = function (f29_arg0, f29_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f29_arg1) then
		local f29_local0 = 4
		local f29_local1 = 5
		local f29_local2 = f29_arg1.data[1]
		local f29_local3 = f29_arg1.data[2]
		local f29_local4 = f29_arg1.data[3]
		local f29_local5 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f29_local2, f29_local3 + 1)
		local f29_local6 = f29_local5 .. "_128"
		local f29_local7 = UIExpression.TableLookup(controller, CoD.rankTable, 0, f29_local2, f29_local1)
		local f29_local8 = CoD.NotificationPopups.RankUpImageHeight
		local f29_local9 = CoD.NotificationPopups.RankUpImageWidth
		local f29_local10 = 10
		if Engine.IsSplitscreen() == true then
			f29_local8 = f29_local8 * CoD.NotificationPopups.SplitscreenImageRatio
			f29_local9 = f29_local9 * CoD.NotificationPopups.SplitscreenImageRatio
			f29_local10 = f29_local10 + CoD.NotificationPopups.SplitscreenImageTopOffset
		end
		local f29_local11 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenNotificationMultiplier)
		f29_local11:setLeftRight(false, false, -f29_local9 * 1.5, f29_local9 * 1.5)
		f29_local11:setTopBottom(true, false, 10, 10 + f29_local8 * 2)
		f29_local11:setAlpha(0)
		f29_local11:setScale(0)
		f29_local11:setUseGameTime(true)
		f29_local11.id = "RankUpNotifyContainer"
		f29_local11:registerAnimationState("out", {
			scale = 0,
			zRot = 360,
			alpha = 0
		})
		f29_local11:registerEventHandler("rankup_notify_start", CoD.NotificationPopups.RankUpNotifyStart)
		f29_local11:registerEventHandler("transition_complete_out", CoD.NotificationPopups.PopupNotifyComplete)
		f29_local11:registerEventHandler("outState", CoD.NotificationPopups.PopupNotify_Out)
		f29_local11:registerEventHandler("demo_jump", f29_local11.close)
		local f29_local12 = LUI.UIStreamedImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f29_local9 / 2,
			right = f29_local9 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f29_local10,
			bottom = f29_local10 + f29_local8,
			material = RegisterMaterial(f29_local6),
			alpha = 0.9
		}, 4000)
		f29_local12:registerEventHandler("streamed_image_ready", CoD.NotificationPopups.RankupImageStreamed)
		f29_local12:registerEventHandler("streamed_image_timed_out", CoD.NotificationPopups.RankupImageStreamTimeOut)
		f29_local11.weaponImage = f29_local12
		f29_local12.lowRes = f29_local5
		f29_local11:addElement(f29_local12)
		local f29_local13 = 6
		local f29_local14 = 30
		if Engine.IsSplitscreen() == true then
			f29_local13 = f29_local13 + 10
			f29_local14 = f29_local14 + 10
		end
		local ranktext = CoD.NotificationPopups.CreateText(f29_local8 + f29_local13, Engine.Localize(f29_local7))
		f29_local11:addElement(ranktext)
		f29_local11.ranktext = ranktext
		
		local text = CoD.NotificationPopups.CreateText(f29_local8 + f29_local14, Engine.Localize("RANK_PROMOTED"))
		f29_local11:addElement(text)
		f29_local11.text = text
		
		f29_arg0:addElement(f29_local11)
	else
		f29_arg0:processEvent({
			name = "notification_complete"
		})
	end
end

CoD.NotificationPopups.RankupImageStreamed = function (f30_arg0, f30_arg1)
	f30_arg0:dispatchEventToParent({
		name = "rankup_notify_start"
	})
end

CoD.NotificationPopups.RankupImageStreamTimeOut = function (f31_arg0, f31_arg1)
	f31_arg0:setupUIImage()
	f31_arg0:setImage(RegisterMaterial(f31_arg0.lowRes))
	f31_arg0:dispatchEventToParent({
		name = "rankup_notify_start"
	})
end

CoD.NotificationPopups.RankUpNotifyStart = function (f32_arg0, f32_arg1)
	local f32_local0 = CoD.NotificationPopups.GunLevelInTime
	local f32_local1 = CoD.NotificationPopups.GunLevelVisibleTime
	local f32_local2 = CoD.NotificationPopups.GunLevelOutTime
	Engine.PlaySound("mus_lau_rank_up")
	f32_arg0:beginAnimation("in", f32_local0, true, true)
	f32_arg0:setScale(1.15)
	f32_arg0:setAlpha(1)
	f32_arg0:registerEventHandler("transition_complete_in", CoD.NotificationPopups.RankUpIn2)
	f32_arg0:addElement(LUI.UITimer.new(f32_local1 - f32_local0 - f32_local2, "outState", true))
end

CoD.NotificationPopups.RankUpIn2 = function (f33_arg0, f33_arg1)
	f33_arg0:beginAnimation("in2", 100, true, true)
	f33_arg0:setScale(1)
end

CoD.NotificationPopups.ChallengeComplete = function (f34_arg0, f34_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f34_arg1) then
		CoD.NotificationPopups.AddToQueue(f34_arg0, CoD.NotificationPopups.Priorities.Challenge, CoD.NotificationPopups.ChallengeCompleteNotify, f34_arg1)
	end
end

string.starts = function (f35_arg0, f35_arg1)
	return string.sub(f35_arg0, 1, string.len(f35_arg1)) == f35_arg1
end

CoD.NotificationPopups.ChallengeCompleteNotify = function (f36_arg0, f36_arg1)
	if CoD.NotificationPopups.ShouldShowPopups(f36_arg1) then
		local f36_local0 = f36_arg1.data[1]
		local f36_local1 = f36_arg1.data[2]
		local f36_local2 = f36_arg1.data[3]
		local f36_local3 = f36_arg1.data[4]
		local f36_local4 = f36_arg1.data[5]
		local f36_local5 = f36_arg1.data[6]
		local f36_local6 = f36_arg1.data[7]
		local f36_local7 = "hud_medals_challenge"
		local f36_local8 = "mp/statsmilestones" .. f36_local3 + 1 .. ".csv"
		local f36_local9 = UIExpression.TableLookupGetColumnValueForRow(f36_arg1.controller, f36_local8, f36_local4, 5)
		local f36_local10 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f36_arg1.controller, f36_local8, f36_local4, 1))
		local f36_local11 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f36_arg1.controller, f36_local8, f36_local4 + 1, 1))
		local f36_local12 = UIExpression.TableLookupGetColumnValueForRow(f36_arg1.controller, f36_local8, f36_local4, 9)
		local f36_local13 = CoD.NotificationPopups.ChallengeTextHeight
		local f36_local14 = CoD.NotificationPopups.ChallengeTextDescHeight
		local f36_local15 = CoD.NotificationPopups.ChallengeImageHeight
		local f36_local16 = CoD.NotificationPopups.ChallengeImageWidth
		local f36_local17 = false
		if Engine.IsSplitscreen() == true then
			f36_local13 = f36_local13 * CoD.NotificationPopups.SplitscreenImageRatio
			f36_local15 = f36_local15 * CoD.NotificationPopups.SplitscreenImageRatio
			f36_local16 = f36_local16 * CoD.NotificationPopups.SplitscreenImageRatio
		end
		if f36_local10 > 0 then
			f36_local17 = true
		elseif f36_local11 == 1 then
			f36_local17 = true
		end
		local f36_local18 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenNotificationMultiplier)
		f36_local18:setLeftRight(false, false, -f36_local16 * 1.5, f36_local16 * 1.5)
		f36_local18:setTopBottom(true, false, -f36_local15 / 2, 0)
		f36_local18:setAlpha(1)
		f36_local18:setScale(0)
		f36_local18:setUseGameTime(true)
		f36_local18.id = "RankUpNotifyContainer"
		f36_local18:registerAnimationState("in", {
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = f36_local15 / 2,
			scale = 1,
			alpha = 1
		})
		f36_local18:registerAnimationState("out", {
			alpha = 0
		})
		f36_local18:registerEventHandler("transition_complete_out", CoD.NotificationPopups.PopupNotifyComplete)
		f36_local18:registerEventHandler("outState", CoD.NotificationPopups.PopupNotify_Out)
		f36_local18:registerEventHandler("demo_jump", f36_local18.close)
		f36_arg0:addElement(f36_local18)
		
		local weaponImage = CoD.NotificationPopups.CreateImage(f36_local16, f36_local15, false, false, -f36_local16 / 2, 0, f36_local7)
		f36_local18:addElement(weaponImage)
		f36_local18.weaponImage = weaponImage
		
		weaponImage:setPriority(-100)
		weaponImage:setAlpha(0.7)
		local f36_local20 = nil
		local f36_local21 = ""
		if f36_local17 == true then
			f36_local21 = Engine.Localize("CHALLENGE_TIER_" .. f36_local10)
		end
		local f36_local22, f36_local23, f36_local24 = nil
		if f36_local12 ~= "" then
			f36_local24 = f36_local9 .. "_AWARD"
		else
			f36_local24 = f36_local9
		end
		if f36_local2 == CoD.NotificationPopups.Challenge_Weapon then
			local f36_local25 = UIExpression.GetItemName(nil, f36_local1)
			local f36_local26 = f36_local5
			if f36_local12 ~= "" and string.starts(f36_local12, "camo_") then
				f36_local26 = Engine.Localize(UIExpression.TableLookup(f36_arg1.controller, CoD.attachmentTable, 4, f36_local12, 7))
			end
			f36_local22 = CoD.NotificationPopups.CreateText(f36_local13, Engine.Localize(f36_local24, f36_local26, f36_local25, f36_local21), true, true)
			f36_local23 = CoD.NotificationPopups.CreateText(f36_local14, Engine.Localize(f36_local9 .. "_DESC", f36_local5, f36_local25, f36_local21), false, true, true)
		elseif f36_local2 == CoD.NotificationPopups.Challenge_Group then
			if f36_local12 == "camo_diamond" then
				f36_local5 = Engine.Localize("MPUI_DIAMOND")
			end
			local f36_local25 = Engine.Localize("CHALLENGE_TYPE_" .. UIExpression.GetItemGroupByIndex(nil, f36_local1))
			f36_local22 = CoD.NotificationPopups.CreateText(f36_local13, Engine.Localize(f36_local24, f36_local5, f36_local25, f36_local21), true, true)
			f36_local23 = CoD.NotificationPopups.CreateText(f36_local14, Engine.Localize(f36_local9 .. "_DESC", f36_local5, f36_local25, f36_local21), false, true, true)
		elseif f36_local2 == CoD.NotificationPopups.Challenge_GameType then
			local f36_local25 = Dvar.g_gametype:get()
			if 0 ~= Dvar.scr_hardcore:get() then
				f36_local25 = "hc" .. f36_local25
			end
			local f36_local26 = Engine.Localize("CHALLENGE_TYPE_" .. f36_local25)
			f36_local22 = CoD.NotificationPopups.CreateText(f36_local13, Engine.Localize(f36_local24, f36_local5, f36_local26, f36_local21), true, true)
			f36_local23 = CoD.NotificationPopups.CreateText(f36_local14, Engine.Localize(f36_local9 .. "_DESC", f36_local5, f36_local26, f36_local21), false, true, true)
		elseif f36_local2 == CoD.NotificationPopups.Challenge_Attachments then
			local f36_local25 = UIExpression.GetAttachmentName(nil, f36_local1)
			local f36_local26 = Engine.Localize(f36_local25)
			local f36_local27 = f36_local5
			local f36_local28 = f36_local25
			if f36_local12 ~= "" and string.starts(f36_local12, "reticle_") then
				f36_local27 = Engine.Localize("MPUI_RETICLE_" .. UIExpression.TableLookup(f36_arg1.controller, CoD.attachmentTable, 3, f36_local25, 4) .. string.sub(f36_local12, string.len("reticle_"), string.len(f36_local12)))
			end
			f36_local22 = CoD.NotificationPopups.CreateText(f36_local13, Engine.Localize(f36_local24, f36_local27, f36_local26, f36_local21), true, true)
			f36_local23 = CoD.NotificationPopups.CreateText(f36_local14, Engine.Localize(f36_local9 .. "_DESC", f36_local5, f36_local26, f36_local21), false, true, true)
		elseif f36_local2 == CoD.NotificationPopups.Challenge_Global then
			f36_local22 = CoD.NotificationPopups.CreateText(f36_local13, Engine.Localize(f36_local24, f36_local5, "", f36_local21), true, true)
			f36_local23 = CoD.NotificationPopups.CreateText(f36_local14, Engine.Localize(f36_local9 .. "_DESC", f36_local5, "", f36_local21), false, true, true)
		end
		if f36_local22 ~= nil then
			f36_local18:addElement(f36_local22)
			f36_local18.text = f36_local22
		end
		if f36_local23 ~= nil then
			f36_local18:addElement(f36_local23)
			f36_local18.text = f36_local23
		end
		local f36_local25 = CoD.NotificationPopups.GunLevelInTime
		local f36_local26 = CoD.NotificationPopups.GunLevelVisibleTime
		local f36_local27 = CoD.NotificationPopups.GunLevelOutTime
		Engine.PlaySound("mus_lau_challenge")
		f36_local18:animateToState("in", f36_local25, false, true)
		weaponImage:setupBitchinFX(RegisterMaterial("bitchin_glint"))
		weaponImage:playBitchinFX(600, true)
		f36_local18:addElement(LUI.UITimer.new(f36_local26 - f36_local25 - f36_local27, "outState", true))
	else
		f36_arg0:processEvent({
			name = "notification_complete"
		})
	end
end

CoD.NotificationPopups.PopupNotify_Out = function (f37_arg0, f37_arg1)
	f37_arg0:animateToState("out", 250, true, false)
end

CoD.NotificationPopups.PopupNotifyComplete = function (f38_arg0, f38_arg1)
	f38_arg0:dispatchEventToParent({
		name = "notification_complete"
	})
	f38_arg0:close()
end

CoD.NotificationPopups.PlayerCallout_Close = function (f39_arg0, f39_arg1)
	if f39_arg0.calloutType == "obituary_callout" then
		f39_arg0:beginAnimation("outState", 150, true, false)
		CoD.NotificationPopups.ObituaryState(f39_arg0, "out")
	else
		f39_arg0:beginAnimation("outState", 150, true, false)
		CoD.NotificationPopups.PlayerCalloutState(f39_arg0, "out")
	end
end

CoD.NotificationPopups.CalloutBackgroundImageStreamed = function (f40_arg0, f40_arg1)
	if f40_arg0.calloutType == "obituary_callout" then
		f40_arg0:beginAnimation("inState", 150, true, false)
		CoD.NotificationPopups.ObituaryState(f40_arg0, "in", f40_arg0.calloutTopOffset)
	else
		f40_arg0:beginAnimation("inState", 150, true, false)
		CoD.NotificationPopups.PlayerCalloutState(f40_arg0, "in")
	end
end

CoD.NotificationPopups.CalloutBackgroundImageStreamTimeOut = function (f41_arg0, f41_arg1)
	f41_arg0.namePlateSelectedBg:setupUIImage()
	f41_arg0.namePlateSelectedBg:setImage(RegisterMaterial("emblem_bg_default"))
	CoD.NotificationPopups.CalloutBackgroundImageStreamed(f41_arg0, f41_arg1)
end

CoD.NotificationPopups.DisplayCallout = function (f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4)
	local f42_local0 = CoD.NamePlate.New(f42_arg1.controller, f42_arg1, f42_arg2, CoD.SplitscreenNotificationMultiplier)
	local f42_local1 = 0
	if f42_arg1.controller and UIExpression.IsVisibilityBitSet(f42_arg1.controller, CoD.BIT_SPECTATING_CLIENT) == 1 then
		f42_local1 = 35
	end
	if f42_arg4 == "obituary_callout" then
		f42_local0:setTopBottom(false, false, CoD.NotificationPopups.ObitPlayerCallout_Y + 20 + f42_local1, CoD.NotificationPopups.ObitPlayerCallout_Y + 20 + f42_local1 + CoD.NotificationPopups.PlayerCallout_Height)
		f42_local0:registerEventHandler("closeObituaryCallout", f42_local0.close)
		f42_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, f42_local0.close)
	else
		CoD.NotificationPopups.PlayerCalloutState(f42_local0, "out")
		f42_local0:registerEventHandler("closePlayerCallout", f42_local0.close)
	end
	f42_local0.calloutTopOffset = f42_local1
	f42_local0.calloutType = f42_arg4
	f42_local0:registerEventHandler("close", CoD.NotificationPopups.PlayerCallout_Close)
	f42_local0:registerEventHandler("transition_complete_outState", f42_local0.close)
	f42_local0:registerEventHandler("streamed_image_ready", CoD.NotificationPopups.CalloutBackgroundImageStreamed)
	f42_local0:registerEventHandler("streamed_image_timed_out", CoD.NotificationPopups.CalloutBackgroundImageStreamTimeOut)
	f42_arg0:addElement(f42_local0)
	f42_local0:addElement(LUI.UITimer.new(f42_arg3, "close", true))
end

CoD.NotificationPopups.ObituaryState = function (f43_arg0, f43_arg1, f43_arg2)
	if f43_arg1 == "in" then
		if f43_arg2 == nil then
			f43_arg2 = 0
		end
		f43_arg0:setLeftRight(false, false, -CoD.NotificationPopups.PlayerCallout_Width / 2, CoD.NotificationPopups.PlayerCallout_Width / 2)
		f43_arg0:setTopBottom(false, false, CoD.NotificationPopups.ObitPlayerCallout_Y + f43_arg2 - 2 * CoD.NotificationPopups.PlayerCallout_Height, CoD.NotificationPopups.ObitPlayerCallout_Y + f43_arg2 - CoD.NotificationPopups.PlayerCallout_Height)
	elseif f43_arg1 == "out" then
		f43_arg0:setLeftRight(false, false, -CoD.NotificationPopups.PlayerCallout_Width / 2, CoD.NotificationPopups.PlayerCallout_Width / 2)
		f43_arg0:setTopBottom(false, false, CoD.NotificationPopups.ObitPlayerCallout_Y, CoD.NotificationPopups.ObitPlayerCallout_Y + CoD.NotificationPopups.PlayerCallout_Height)
	end
end

CoD.NotificationPopups.PlayerObituaryCallout = function (f44_arg0, f44_arg1)
	local f44_local0 = f44_arg1.controller
	if (not CoD.IsShoutcaster(f44_local0) or CoD.ExeProfileVarBool(f44_local0, "shoutcaster_calloutcards")) and (UIExpression.IsDemoPlaying(f44_local0) == 0 or UIExpression.IsVisibilityBitSet(f44_local0, CoD.BIT_DEMO_HUD_HIDDEN) == 1) then
		f44_arg0:dispatchEventToChildren({
			name = "closeObituaryCallout"
		})
		CoD.NotificationPopups.DisplayCallout(f44_arg0, f44_arg1, f44_arg1.killString, 2500, "obituary_callout")
	end
end

CoD.NotificationPopups.PlayerCalloutState = function (f45_arg0, f45_arg1)
	local f45_local0 = 10
	local f45_local1 = CoD.NotificationPopups.PlayerCallout_Y
	if Engine.IsSplitscreen() == false then
		if f45_arg1 == "in" then
			f45_arg0:setLeftRight(true, false, f45_local0, f45_local0 + CoD.NotificationPopups.PlayerCallout_Width)
			f45_arg0:setTopBottom(true, false, f45_local1, f45_local1 + CoD.NotificationPopups.PlayerCallout_Height)
		elseif f45_arg1 == "out" then
			f45_arg0:setLeftRight(true, false, -10 - CoD.NotificationPopups.PlayerCallout_Width, -10)
			f45_arg0:setTopBottom(true, false, f45_local1, f45_local1 + CoD.NotificationPopups.PlayerCallout_Height)
		end
	else
		f45_local0 = -70
		f45_local1 = f45_local1 - 150
		if f45_arg1 == "in" then
			f45_arg0:setLeftRight(false, true, f45_local0 - CoD.NotificationPopups.PlayerCallout_Width, f45_local0)
			f45_arg0:setTopBottom(true, false, f45_local1, f45_local1 + CoD.NotificationPopups.PlayerCallout_Height)
		elseif f45_arg1 == "out" then
			f45_arg0:setLeftRight(false, true, -10, -10 + CoD.NotificationPopups.PlayerCallout_Width)
			f45_arg0:setTopBottom(true, false, f45_local1, f45_local1 + CoD.NotificationPopups.PlayerCallout_Height)
		end
	end
end

CoD.NotificationPopups.PlayerCallout = function (f46_arg0, f46_arg1)
	if not CoD.IsShoutcaster(f46_arg1.controller) or CoD.ExeProfileVarBool(f46_arg1.controller, "shoutcaster_calloutcards") then
		f46_arg0:dispatchEventToChildren({
			name = "closePlayerCallout"
		})
		Engine.PlaySound("uin_alert_slideout")
		CoD.NotificationPopups.DisplayCallout(f46_arg0, Engine.GetCalloutPlayerData(f46_arg1.controller, f46_arg1.data[2]), Engine.Localize(Engine.GetIString(f46_arg1.data[1], "CS_LOCALIZED_STRINGS")), 2000, "player_callout")
	end
end

