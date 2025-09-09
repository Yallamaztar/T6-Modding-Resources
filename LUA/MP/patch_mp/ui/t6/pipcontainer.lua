CoD.PipContainer = {}
CoD.PipContainer.PipWidth = 225
CoD.PipContainer.PipHeight = CoD.PipContainer.PipWidth * 0.75
CoD.PipContainer.PipOffset = 5
CoD.PipContainer.Spacing = 5
CoD.PipContainer.SignalMaterial = RegisterMaterial("hud_sp_signal_strength_anim")
CoD.PipContainer.SignalImageWidth = 24
CoD.PipContainer.SignalImageHeight = CoD.PipContainer.SignalImageWidth
CoD.PipContainer.ColorValue = {}
CoD.PipContainer.ColorValue.r = 1
CoD.PipContainer.ColorValue.b = 1
CoD.PipContainer.ColorValue.g = 1
CoD.PipContainer.new = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.id = Widget.id .. ".PipContainer"
	Widget.controller = f1_arg0
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.id = Widget.id .. ".PipImageHolder"
	Widget:addElement(Widget)
	Widget:registerEventHandler("transition_complete_minimize", CoD.PipContainer.CloseSlot)
	local f1_local2 = CoD.VisorImage.new("menu_vis_diamond_group", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, {
		r = 0.05,
		g = 0.05,
		b = 0.05
	})
	f1_local2.id = f1_local2.id .. ".DiamondBackground"
	Widget:addElement(f1_local2)
	f1_local2:setAlpha(0)
	Widget.diamondBackground = f1_local2
	local f1_local3 = CoD.VisorImage.new("visor_bracket_minimap", {
		leftAnchor = true,
		rightAnchor = true,
		left = -18,
		right = 25,
		topAnchor = true,
		bottomAnchor = true,
		top = -18,
		bottom = 18
	}, {
		r = 1,
		g = 1,
		b = 1
	})
	Widget:addElement(f1_local3)
	f1_local3:setAlpha(0)
	Widget.bracket = f1_local3
	local f1_local4 = 17
	local f1_local5 = -7
	
	local signalImage = LUI.UIImage.new()
	signalImage:setLeftRight(true, false, f1_local4, CoD.PipContainer.SignalImageWidth + f1_local4)
	signalImage:setTopBottom(false, true, -CoD.PipContainer.SignalImageHeight + f1_local5, f1_local5)
	signalImage:setImage(CoD.PipContainer.SignalMaterial)
	signalImage:setRGB(0.4, 0.4, 0.4)
	signalImage:setAlpha(0)
	signalImage.id = signalImage.id .. ".SignalStrength"
	Widget.imageHolder = Widget
	signalImage:registerEventHandler("show", CoD.PipContainer.ShowAnimation)
	Widget:addElement(signalImage)
	Widget.signalImage = signalImage
	
	Widget:registerEventHandler("maximize_pip", CoD.PipContainer.MaximizePip)
	Widget:registerEventHandler("minimize_pip", CoD.PipContainer.MinimizePip)
	Widget:registerEventHandler("fullscreen_pip", CoD.PipContainer.FullscreenPip)
	Widget:registerEventHandler("fullscreen_animate", CoD.PipContainer.FullscreenAnimate)
	Widget:registerEventHandler("minimize_fullscreen_pip", CoD.PipContainer.MinimizeFullscreenPip)
	Widget:registerEventHandler("dispatch_minimize", CoD.PipContainer.DispatchMinimizeToParent)
	Widget:registerEventHandler("remove_pip", CoD.PipContainer.RemovePip)
	Widget.addSlot = CoD.PipContainer.AddSlot
	Widget:registerEventHandler("extracam_show", CoD.PipContainer.ExtraCamShow)
	Widget:registerEventHandler("extracam_show_large", CoD.PipContainer.ExtraCamShow)
	Widget:registerEventHandler("extracam_hide", CoD.PipContainer.ExtraCamHide)
	Widget:registerEventHandler("cinematic_start", CoD.PipContainer.BinkStart)
	Widget:registerEventHandler("cinematic_stop", CoD.PipContainer.BinkStop)
	return Widget
end

CoD.PipContainer.MaximizeAnimation = function (f2_arg0, f2_arg1, f2_arg2)
	if not f2_arg1 then
		f2_arg1 = 0
	end
	if not f2_arg2 then
		f2_arg2 = 1
	end
	f2_arg0:completeAnimation()
	f2_arg0:beginAnimation("maximize", f2_arg1)
	f2_arg0:setLeftRight(true, false, 0, CoD.PipContainer.PipWidth * f2_arg2)
	f2_arg0:setTopBottom(true, false, 0, CoD.PipContainer.PipHeight * f2_arg2)
end

CoD.PipContainer.MinimizeAnimation = function (f3_arg0, f3_arg1)
	if not f3_arg1 then
		f3_arg1 = 0
	end
	f3_arg0:beginAnimation("minimize", f3_arg1)
	f3_arg0:setLeftRight(true, true, 0, 0)
	f3_arg0:setTopBottom(true, true, 0, 0)
end

CoD.PipContainer.AddSlot = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = nil
	local f4_local1 = CoD.GetDefaultAnimationState()
	if f4_arg2 ~= nil then
		f4_local0 = CoD.VisorImage.new("visor_bink", f4_local1, CoD.PipContainer.ColorValue)
	else
		f4_local0 = CoD.VisorImage.new(f4_arg1, f4_local1, CoD.PipContainer.ColorValue)
	end
	f4_local0.id = f4_local0.id .. ".PipImage"
	if f4_arg1 ~= nil then
		f4_local0.id = f4_local0.id .. "." .. f4_arg1
	elseif f4_arg2 ~= nil then
		f4_local0.id = f4_local0.id .. "." .. f4_arg2
	end
	f4_arg0.imageHolder:addElement(f4_local0)
	f4_arg0.imageHolder.controller = f4_arg0.controller
	f4_arg0.imageHolder.image = f4_local0
	f4_arg0.imageHolder.materialName = f4_arg1
	f4_arg0.imageHolder.binkName = f4_arg2
	f4_arg0.imageHolder.inUse = true
end

CoD.PipContainer.ShowAnimation = function (f5_arg0, f5_arg1)
	f5_arg0:beginAnimation("show", f5_arg1.duration or 0)
	f5_arg0:setAlpha(1)
end

CoD.PipContainer.MaximizePip = function (f6_arg0, f6_arg1)
	CoD.PipContainer.MaximizeAnimation(f6_arg0.imageHolder, f6_arg1.duration, f6_arg1.scale)
	if f6_arg0.imageHolder.binkName ~= nil then
		f6_arg0.imageHolder.diamondBackground:beginAnimation("show", f6_arg1.duration)
		f6_arg0.imageHolder.diamondBackground:setAlpha(1)
		f6_arg0.imageHolder.bracket:beginAnimation("show")
		f6_arg0.imageHolder.bracket:setAlpha(1)
		f6_arg0:addElement(LUI.UITimer.new(f6_arg1.duration - 100, "show", true, f6_arg0.imageHolder.signalImage))
	end
end

CoD.PipContainer.MinimizePip = function (f7_arg0, f7_arg1)
	CoD.PipContainer.MinimizeAnimation(f7_arg0.imageHolder, f7_arg1.duration)
	f7_arg0:dispatchEventToParent({
		name = "default_anim",
		duration = f7_arg1.duration
	})
	if f7_arg0.imageHolder.binkName ~= nil then
		f7_arg0.imageHolder.diamondBackground:beginAnimation("hide", f7_arg1.duration)
		f7_arg0.imageHolder.diamondBackground:setAlpha(0)
		f7_arg0.imageHolder.bracket:beginAnimation("hide")
		f7_arg0.imageHolder.bracket:setAlpha(0)
		f7_arg0.imageHolder.signalImage:beginAnimation("hide", 100)
		f7_arg0.imageHolder.signalImage:setAlpha(0)
	end
end

CoD.PipContainer.FullscreenPip = function (f8_arg0, f8_arg1)
	if not f8_arg0.imageHolder.inUse then
		return 
	elseif f8_arg1 ~= nil then
		f8_arg0:dispatchEventToParent({
			name = "resize_pip_fullscreen",
			duration = f8_arg1.data[1] or 1000
		})
	end
end

CoD.PipContainer.FullscreenAnimate = function (f9_arg0, f9_arg1)
	f9_arg0.imageHolder:beginAnimation("fullscreen", f9_arg1.duration or 1000)
	f9_arg0.imageHolder:setLeftRight(true, true, 0, 0)
	f9_arg0.imageHolder:setTopBottom(true, true, 0, 0)
end

CoD.PipContainer.MinimizeFullscreenPip = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.data[1] or 1000
	CoD.PipContainer.MaximizeAnimation(f10_arg0.imageHolder, f10_local0)
	f10_arg0:dispatchEventToParent({
		name = "default_anim",
		duration = f10_local0
	})
	if f10_arg0.imageHolder.binkName ~= nil then
		f10_arg0.imageHolder.diamondBackground:beginAnimation("show", f10_local0)
		f10_arg0.imageHolder.diamondBackground:setAlpha(1)
		f10_arg0.imageHolder.bracket:beginAnimation("show")
		f10_arg0.imageHolder.bracket:setAlpha(1)
		local f10_local1 = f10_local0 - 100
		if f10_local1 < 0 then
			f10_local1 = 0
		end
		f10_arg0:addElement(LUI.UITimer.new(f10_local1, "show", true, f10_arg0.imageHolder.signalImage))
	end
end

CoD.PipContainer.DispatchMinimizeToParent = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "default_anim",
		duration = f11_arg1.duration
	})
end

CoD.PipContainer.CloseSlot = function (f12_arg0, f12_arg1)
	if f12_arg0.binkName ~= nil and f12_arg0.image.cinematicId ~= nil then
		Engine.Stop3DCinematic(f12_arg0.image.cinematicId)
		Engine.SendMenuResponse(f12_arg0.controller, "cinematic", f12_arg0.image.cinematicId)
	end
	f12_arg0:dispatchEventToParent({
		name = "remove_pip"
	})
	f12_arg0:dispatchEventToParent({
		name = "show_block_container",
		duration = 500
	})
end

CoD.PipContainer.RemovePip = function (f13_arg0, f13_arg1)
	if f13_arg0.imageHolder.image ~= nil then
		f13_arg0.imageHolder.image:close()
		f13_arg0.imageHolder.inUse = nil
	end
end

CoD.PipContainer.ExtraCamShow = function (f14_arg0, f14_arg1)
	if f14_arg0.imageHolder.inUse then
		return 
	elseif f14_arg1.data ~= nil and f14_arg1.data[1] ~= nil then
		f14_arg0:addSlot(Engine.GetIString(f14_arg1.data[1], "CS_LOCALIZED_STRINGS"))
		if f14_arg1.data[2] == 1 then
			f14_arg0:processEvent({
				name = "fullscreen_pip",
				data = {
					0
				}
			})
		else
			local f14_local0 = 1
			if f14_arg1.name == "extracam_show_large" then
				f14_local0 = 2
			end
			f14_arg0:processEvent({
				name = "maximize_pip",
				duration = 500,
				scale = f14_local0
			})
		end
		f14_arg0:dispatchEventToParent({
			name = "hide_block_container",
			duration = 500
		})
	end
end

CoD.PipContainer.ExtraCamHide = function (f15_arg0, f15_arg1)
	if f15_arg1.data ~= nil and f15_arg1.data[1] ~= nil then
		local f15_local0 = Engine.GetIString(f15_arg1.data[1], "CS_LOCALIZED_STRINGS")
		f15_arg0:processEvent({
			name = "minimize_pip",
			duration = 500
		})
	end
end

CoD.PipContainer.BinkStart = function (f16_arg0, f16_arg1)
	if f16_arg0.imageHolder.inUse then
		return 
	elseif f16_arg1.data and f16_arg1.data[1] and f16_arg1.data[2] then
		local f16_local0 = Engine.GetIString(f16_arg1.data[1], "CS_LOCALIZED_STRINGS")
		local f16_local1 = Engine.GetIString(f16_arg1.data[2], "CS_LOCALIZED_STRINGS")
		local f16_local2 = false
		local f16_local3 = false
		local f16_local4 = false
		local f16_local5 = false
		if f16_arg1.data[6] then
			if f16_arg1.data[6] ~= 0 then
				f16_local5 = true
			else
				f16_local5 = false
			end
		end
		if f16_arg1.data[5] then
			if f16_arg1.data[5] ~= 0 then
				f16_local4 = true
			else
				f16_local4 = false
			end
		end
		if f16_arg1.data[4] then
			if f16_arg1.data[4] ~= 0 then
				f16_local3 = true
			else
				f16_local3 = false
			end
		end
		if f16_arg1.data[3] then
			if f16_arg1.data[3] ~= 0 then
				f16_local2 = true
			else
				f16_local2 = false
			end
		end
		if f16_local1 then
			f16_arg0:addSlot(f16_local0, f16_local1)
			if f16_arg1.data[7] then
				local f16_local6 = f16_arg1.data[7]
				if f16_local6 == 1 then
					f16_arg0:processEvent({
						name = "maximize_pip",
						duration = 500,
						scale = 2
					})
				elseif f16_local6 == 2 then
					f16_arg0:processEvent({
						name = "fullscreen_pip",
						data = {
							0
						}
					})
				else
					f16_arg0:processEvent({
						name = "maximize_pip",
						duration = 500,
						scale = 1
					})
				end
			end
			f16_arg0.imageHolder.image.cinematicId = Engine.Start3DCinematic(f16_local1, f16_local2, f16_local3, f16_local4, f16_local5)
			Engine.SendMenuResponse(f16_arg0.controller, "cinematic", f16_arg0.imageHolder.image.cinematicId)
			if f16_local2 == false then
				f16_arg0.imageHolder.cinematicPreloadingTimer = LUI.UITimer.new(500, "preload_timer", false)
				f16_arg0.imageHolder:addElement(f16_arg0.imageHolder.cinematicPreloadingTimer)
				f16_arg0.imageHolder:registerEventHandler("preload_timer", CoD.PipContainer.GetTimeRemaining)
			end
			f16_arg0:dispatchEventToParent({
				name = "hide_block_container",
				duration = 500
			})
		end
	end
end

CoD.PipContainer.GetTimeRemaining = function (f17_arg0, f17_arg1)
	if Engine.IsCinematicPreloading(f17_arg0.image.cinematicId) == false then
		local f17_local0 = Engine.GetCinematicTimeRemaining(f17_arg0.image.cinematicId)
		if f17_local0 > 1 then
			f17_local0 = f17_local0 - 0.5
		end
		f17_arg0.image:addElement(LUI.UITimer.new(f17_local0 * 1000, "cinematic_timer", true, f17_arg0))
		f17_arg0.image:registerEventHandler("cinematic_timer", CoD.PipContainer.AutoBinkStop)
		f17_arg0.cinematicPreloadingTimer:close()
	end
end

CoD.PipContainer.BinkStop = function (f18_arg0, f18_arg1)
	f18_arg0:processEvent({
		name = "minimize_pip",
		duration = 500
	})
	if f18_arg0.imageHolder.cinematicPreloadingTimer ~= nil then
		f18_arg0.imageHolder.cinematicPreloadingTimer:close()
	end
end

CoD.PipContainer.AutoBinkStop = function (f19_arg0, f19_arg1)
	f19_arg0:dispatchEventToParent({
		name = "cinematic_stop",
		cinematicId = f19_arg0.image.cinematicId
	})
end

