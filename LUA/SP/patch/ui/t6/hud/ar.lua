CoD.AR = {}
CoD.AR.TargetMaterialName = "hud_rts_target"
CoD.AR.TargetSize = 64
CoD.AR.TargetSizeLarge = 96
CoD.AR.ActivateDuration = 250
CoD.AR.RotationDuration = 1000
CoD.AR.LetterTypeSpeed = 1
CoD.AR.new = function ()
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget.targets = {}
	Widget:registerEventHandler("ar_activate_target", CoD.AR.ActivateTarget)
	Widget:registerEventHandler("ar_hide_target", CoD.AR.HideTarget)
	Widget:registerEventHandler("ar_show_target", CoD.AR.ShowTarget)
	return Widget
end

CoD.AR.ActivateTarget = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.data[1]
	local f2_local1 = f2_arg1.data[2]
	local f2_local2 = Engine.GetIString(f2_arg1.data[3], "CS_LOCALIZED_STRINGS")
	local f2_local3 = CoD.AR.CreateTargetIfNecessary(f2_arg0, f2_local0, f2_local1, f2_arg1.data[4], f2_arg1.data[5], f2_arg1.data[6])
	f2_local2 = Engine.Localize(f2_local2)
	local f2_local4, f2_local5, f2_local6, f2_local7 = GetTextDimensions(f2_local2, CoD.fonts.ExtraSmall, CoD.textSize.ExtraSmall)
	f2_local3.background:registerAnimationState("active2", {
		leftAnchor = false,
		rightAnchor = false,
		left = CoD.AR.TargetSize / 2,
		right = CoD.AR.TargetSize / 2 + f2_local4 + f2_local6 + 10
	})
	f2_local3.background:animateToState("active2")
	f2_local3.background:registerAnimationState("active2", {
		scale = 1
	})
	f2_local3.background:animateToState("active", CoD.AR.ActivateDuration, false, true)
	f2_local3.reticleImage:animateToState("active", CoD.AR.ActivateDuration)
	f2_local3.textElement:setText("")
	f2_local3.textElement.fullString = f2_local2
	f2_local3.textElement.letterTypeIndex = 0
	f2_local3.textElement:animateToState("active", CoD.AR.LetterTypeSpeed)
end

CoD.AR.Background_Active = function (f3_arg0, f3_arg1)
	if not f3_arg1.interrupted then
		f3_arg0:animateToState("active2", 100, true, false)
	end
end

CoD.AR.CreateTargetIfNecessary = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local Widget = f4_arg0.targets[f4_arg1]
	if not Widget then
		Widget = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -1,
			right = 1,
			topAnchor = false,
			bottomAnchor = false,
			top = -1,
			bottom = 1
		})
		Widget:setupEntityContainer(f4_arg2, f4_arg3, f4_arg4, f4_arg5)
		f4_arg0:addElement(Widget)
		local Widget = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -CoD.AR.TargetSize / 2,
			right = CoD.AR.TargetSize / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.AR.TargetSize / 2,
			bottom = CoD.AR.TargetSize / 2
		})
		Widget:addElement(Widget)
		Widget:registerAnimationState("active", {
			zRot = 0
		})
		Widget:registerAnimationState("active2", {
			zRot = -180
		})
		Widget:registerAnimationState("active3", {
			zRot = -360
		})
		Widget:registerEventHandler("transition_complete_active", CoD.AR.Reticle_Active)
		Widget:registerEventHandler("transition_complete_active2", CoD.AR.Reticle_Active2)
		Widget:registerEventHandler("transition_complete_active3", CoD.AR.Reticle_Active3)
		Widget:animateToState("active")
		Widget.background = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = CoD.AR.TargetSize / 2,
			right = CoD.AR.TargetSize / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.textSize.ExtraSmall,
			bottom = CoD.textSize.ExtraSmall + 2,
			scale = 0
		})
		Widget:addElement(Widget.background)
		Widget.background:registerAnimationState("active", {
			scale = 1.1
		})
		Widget.background:registerEventHandler("transition_complete_active", CoD.AR.Background_Active)
		Widget.background:addElement(LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			red = 0,
			green = 0.1,
			blue = 0,
			alpha = 0.5
		}))
		Widget.background:addElement(CoD.Border.new(1, 0, 0.4, 0, 0.5))
		local f4_local2 = LUI.UIImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = 0,
			right = 0,
			topAnchor = false,
			bottomAnchor = false,
			top = 0,
			bottom = 0,
			material = RegisterMaterial(CoD.AR.TargetMaterialName),
			red = 0.5,
			green = 0.5,
			blue = 0.5
		})
		Widget:addElement(f4_local2)
		f4_local2:registerAnimationState("show", {
			leftAnchor = false,
			rightAnchor = false,
			left = -CoD.AR.TargetSize / 2,
			right = CoD.AR.TargetSize / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.AR.TargetSize / 2,
			bottom = CoD.AR.TargetSize / 2
		})
		f4_local2:animateToState("show", CoD.AR.ActivateDuration, true, true)
		Widget.reticleImage = LUI.UIImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -CoD.AR.TargetSize / 2,
			right = CoD.AR.TargetSize / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.AR.TargetSize / 2,
			bottom = CoD.AR.TargetSize / 2,
			material = RegisterMaterial(CoD.AR.TargetMaterialName),
			red = 0,
			green = 0,
			blue = 0,
			zRot = 45
		})
		Widget:addElement(Widget.reticleImage)
		Widget.reticleImage:registerAnimationState("active", {
			leftAnchor = false,
			rightAnchor = false,
			left = -CoD.AR.TargetSizeLarge / 2,
			right = CoD.AR.TargetSizeLarge / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.AR.TargetSizeLarge / 2,
			bottom = CoD.AR.TargetSizeLarge / 2,
			red = 1,
			green = 1,
			blue = 1
		})
		Widget.textElement = LUI.UIText.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 5,
			right = 1280,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.textSize.ExtraSmall,
			bottom = 0,
			alignment = LUI.Alignment.Left,
			font = CoD.fonts.ExtraSmall,
			red = 0.75,
			green = 1,
			blue = 0.75,
			alpha = 0
		})
		Widget.background:addElement(Widget.textElement)
		Widget.textElement:registerAnimationState("active", {
			alpha = 0.75
		})
		Widget.textElement:registerAnimationState("show", {
			alpha = 0
		})
		Widget.textElement:registerEventHandler("transition_complete_active", CoD.AR.TextElement_Active)
		f4_arg0.targets[f4_arg1] = Widget
	end
	return Widget
end

CoD.AR.Reticle_Active = function (f5_arg0, f5_arg1)
	if not f5_arg1.interrupted then
		f5_arg0:animateToState("active2", CoD.AR.RotationDuration)
	end
end

CoD.AR.Reticle_Active2 = function (f6_arg0, f6_arg1)
	if not f6_arg1.interrupted then
		f6_arg0:animateToState("active3", CoD.AR.RotationDuration)
	end
end

CoD.AR.Reticle_Active3 = function (f7_arg0, f7_arg1)
	if not f7_arg1.interrupted then
		f7_arg0:animateToState("active")
	end
end

CoD.AR.HideTarget = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.data[1]
	DebugPrint("HIDE TARGET " .. f8_local0)
	local f8_local1 = f8_arg0.targets[f8_local0]
	if f8_local1 then
		f8_local1:close()
		f8_arg0.targets[f8_local0] = nil
	end
end

CoD.AR.ShowTarget = function (f9_arg0, f9_arg1)
	local f9_local0 = CoD.AR.CreateTargetIfNecessary(f9_arg0, f9_arg1.data[1], f9_arg1.data[2], f9_arg1.data[3], f9_arg1.data[4], f9_arg1.data[5])
	f9_local0.background:animateToState("default", CoD.AR.ActivateDuration)
	f9_local0.reticleImage:animateToState("default", CoD.AR.ActivateDuration)
	f9_local0.textElement:animateToState("show", CoD.AR.ActivateDuration, true, true)
end

CoD.AR.TextElement_Active = function (f10_arg0, f10_arg1)
	if not f10_arg1.interrupted then
		f10_arg0.letterTypeIndex = f10_arg0.letterTypeIndex + 1
		local f10_local0 = Engine.SubstringLeft(f10_arg0.fullString, f10_arg0.letterTypeIndex)
		if f10_local0 ~= nil then
			f10_arg0:setText(f10_local0)
			if f10_local0 ~= f10_arg0.fullString then
				f10_arg0:animateToState("active", CoD.AR.LetterTypeSpeed)
			end
		else
			f10_arg0:setText(f10_arg0.fullString)
		end
	end
end

