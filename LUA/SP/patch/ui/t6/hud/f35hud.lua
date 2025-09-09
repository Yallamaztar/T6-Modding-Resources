require("T6.CoDBase")
require("T6.HUD.F35AmmoCounter")
CoD.F35Hud = {}
CoD.F35Hud.Green = {}
CoD.F35Hud.Green.r = 0.24
CoD.F35Hud.Green.g = 0.72
CoD.F35Hud.Green.b = 0.47
CoD.F35Hud.Blue = {}
CoD.F35Hud.Blue.r = 0.42
CoD.F35Hud.Blue.g = 0.57
CoD.F35Hud.Blue.b = 0.78
CoD.F35Hud.Blue.a = 0.5
CoD.F35Hud.BaseColor = {}
CoD.F35Hud.BaseColor.r = 1
CoD.F35Hud.BaseColor.g = 1
CoD.F35Hud.BaseColor.b = 1
CoD.F35Hud.AlphaEmpty = 1
CoD.F35Hud.BracketContainerHeight = 300
CoD.F35Hud.BracketContainerWidth = 800
CoD.F35Hud.BracketWidth = 40
CoD.F35Hud.BracketContainerCinematicHeight = 100
CoD.F35Hud.LockOnBracketWidth = 10
CoD.F35Hud.LockOnBracketHeight = 10
CoD.F35Hud.ReticuleWidth = 1024
CoD.F35Hud.ReticuleHeight = 256
CoD.F35Hud.CrosshairWidth = 20
CoD.F35Hud.CrosshairHeight = 20
CoD.F35Hud.TargetingBracketContainerWidth = 35
CoD.F35Hud.TargetingBracketContainerHeight = 25
CoD.F35Hud.TargetingBracketWidth = 10
CoD.F35Hud.TargetingBracketHeight = 10
CoD.F35Hud.TargetLockWidth = 35
CoD.F35Hud.TargetLockHeight = 35
CoD.F35Hud.TargetingSpinnerWidth = 25
CoD.F35Hud.TargetingSpinnerHeight = 25
CoD.F35Hud.TargetLockFrameHeight = 45
CoD.F35Hud.TargetLockFrameBorder = 25
CoD.F35Hud.CompassWidth = 1500
CoD.F35Hud.CompassHeight = 40
CoD.F35Hud.CannonWidth = 35
CoD.F35Hud.CannonHeight = 60
CoD.F35Hud.CannonSpacing = -8
CoD.F35Hud.ReticulePitchOffset = 100
CoD.F35Hud.Red = {}
CoD.F35Hud.Red.r = 1
CoD.F35Hud.Red.g = 0.1
CoD.F35Hud.Red.b = 0.1
CoD.F35Hud.Red.a = 1
CoD.F35Hud.TopBarHeight = 64
CoD.F35Hud.new = function (f1_arg0, f1_arg1)
	CoD.F35Hud.BracketMaterial = RegisterMaterial("hud_f35_bracket")
	CoD.F35Hud.BracketFuzzMaterial = RegisterMaterial("hud_f35_bracket_fuzz")
	CoD.F35Hud.TargetLockMaterial = RegisterMaterial("hud_sam_diamond")
	CoD.F35Hud.TargetingSpinnerMaterial = RegisterMaterial("hud_sam_spinner")
	CoD.F35Hud.TargetingSpinnerPieceMaterial = RegisterMaterial("hud_sam_dot")
	CoD.F35Hud.SpecMaterial = RegisterMaterial("hud_f35_spec")
	CoD.F35Hud.MissileKeyLineMaterial = RegisterMaterial("hud_f35_missile_keyline")
	CoD.F35Hud.MissileKeyLineFuzzMaterial = RegisterMaterial("f35_rocket_keyline_fuzz")
	CoD.F35Hud.MissileFillMaterial = RegisterMaterial("hud_f35_missile_fill")
	CoD.F35Hud.MissileFillFuzzMaterial = RegisterMaterial("f35_rocket_fill_fuzz")
	CoD.F35Hud.ArrowMaterial = RegisterMaterial("hud_f35_arrow")
	CoD.F35Hud.CannonMaterial = RegisterMaterial("hud_f35_cannon")
	CoD.F35Hud.CannonFuzzMaterial = RegisterMaterial("hud_f35_cannon_fuzz")
	CoD.F35Hud.CannonKeyLineMaterial = RegisterMaterial("hud_f35_cannon_heat_line")
	CoD.F35Hud.CannonKeyLineFuzzMaterial = RegisterMaterial("hud_f35_cannon_heat_line_fuzz")
	CoD.F35Hud.CannonFillMaterial = RegisterMaterial("hud_f35_cannon_heat_fill")
	CoD.F35Hud.CannonFillFuzzMaterial = RegisterMaterial("hud_f35_cannon_heat_fill_fuzz")
	CoD.F35Hud.InnerReticleMaterial = RegisterMaterial("hud_f35_reticule_inner")
	CoD.F35Hud.OuterReticleMaterial = RegisterMaterial("hud_f35_reticule_outer")
	CoD.F35Hud.CrossHairMaterial = RegisterMaterial("hud_f35_center")
	CoD.F35Hud.CrossHairFuzzMaterial = RegisterMaterial("hud_f35_center_fuzz")
	CoD.F35Hud.TriangleMaterial = RegisterMaterial("hud_sp_triangle")
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	Widget:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	if not CoD.isWIIU then
		local reticule = LUI.UIImage.new({
			left = -CoD.F35Hud.CrosshairWidth / 2,
			right = CoD.F35Hud.CrosshairWidth / 2,
			top = -CoD.F35Hud.CrosshairHeight / 2,
			bottom = CoD.F35Hud.CrosshairHeight / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			red = CoD.F35Hud.BaseColor.r,
			green = CoD.F35Hud.BaseColor.g,
			blue = CoD.F35Hud.BaseColor.b,
			alpha = 0.5,
			material = CoD.F35Hud.CrossHairMaterial,
			zRot = 45
		})
		Widget:addElement(LUI.UIImage.new({
			left = -CoD.F35Hud.CrosshairWidth / 2,
			right = CoD.F35Hud.CrosshairWidth / 2,
			top = -CoD.F35Hud.CrosshairHeight / 2,
			bottom = CoD.F35Hud.CrosshairHeight / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			red = CoD.F35Hud.BaseColor.r,
			green = CoD.F35Hud.BaseColor.g,
			blue = CoD.F35Hud.BaseColor.b,
			alpha = 0.5,
			material = CoD.F35Hud.CrossHairFuzzMaterial,
			zRot = 45
		}))
		Widget:addElement(reticule)
	end
	local reticule = CoD.F35Hud.CreateReticule(Widget, f1_arg1)
	Widget:addElement(reticule)
	Widget.reticule = reticule
	
	Widget.bracketContainer = CoD.F35Hud.CreateBracket(Widget)
	if f1_arg1 then
		local f1_local2 = LUI.UIImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -640,
			right = 640,
			topAnchor = false,
			bottomAnchor = false,
			top = -360,
			bottom = 360,
			material = RegisterMaterial("visor_hexagon"),
			red = CoD.F35Hud.Blue.r,
			green = CoD.F35Hud.Blue.g,
			blue = CoD.F35Hud.Blue.b,
			alpha = CoD.F35Hud.Blue.a * 0.35,
			shaderVector0 = {
				-0.5,
				-0.5,
				0,
				0
			}
		})
		Widget:addElement(f1_local2)
		f1_local2:registerAnimationState("down", {
			shaderVector0 = {
				1.5,
				1.5,
				0,
				0
			}
		})
		f1_local2:registerAnimationState("down_reset", {
			shaderVector0 = {
				1.5,
				1.5,
				-1,
				0
			}
		})
		f1_local2:registerAnimationState("up", {
			shaderVector0 = {
				-0.5,
				-0.5,
				-0.5,
				0
			}
		})
		f1_local2:registerEventHandler("transition_complete_up", f1_local2.close)
		local f1_local3 = 0
		Widget:addElement(LUI.UITimer.new(f1_local3, {
			name = "animate",
			animationStateName = "down",
			duration = 2000,
			easeIn = true,
			easeOut = true
		}, true, f1_local2))
		Widget:addElement(LUI.UITimer.new(f1_local3 + 2000, {
			name = "animate",
			animationStateName = "down_reset",
			duration = 0,
			easeIn = true,
			easeOut = true
		}, true, f1_local2))
		Widget:addElement(LUI.UITimer.new(f1_local3 + 2000, {
			name = "animate",
			animationStateName = "up",
			duration = 2000,
			easeIn = true,
			easeOut = true
		}, true, f1_local2))
	end
	Widget:registerEventHandler("hud_update_vehicledata", CoD.F35Hud.UpdateVehicleData)
	Widget:registerEventHandler("hud_missile_fire", CoD.F35Hud.UpdateMissiles)
	Widget:registerEventHandler("hud_damage", CoD.F35Hud.UpdateDamage)
	Widget:registerEventHandler("hud_weapon_heat", CoD.F35Hud.UpdateWeaponHeat)
	Widget:registerEventHandler("cinematic_start", CoD.F35Hud.CinematicStart)
	Widget:registerEventHandler("cinematic_stop", CoD.F35Hud.CinematicStop)
	Widget:addElement(CoD.F35AmmoCounter.new())
	return Widget
end

CoD.F35Hud.CreateBox = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	local f2_local0 = 128
	local f2_local1 = 128
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = f2_arg0 - f2_local0 / 2,
		right = f2_arg0 + f2_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = f2_arg1 - f2_local1 / 2,
		bottom = f2_arg1 + f2_local1 / 2,
		alpha = 1
	})
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	Widget:addElement(Widget)
	Widget:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f2_local0 / 2,
		right = f2_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f2_local1 / 2,
		bottom = f2_local1 / 2,
		material = RegisterMaterial("hud_f35_box")
	}))
	local f2_local4 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Default - CoD.textSize.ExtraSmall / 2,
		right = 0,
		bottom = -CoD.textSize.Default + CoD.textSize.ExtraSmall / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = textAlpha,
		font = CoD.fonts.ExtraSmall
	})
	Widget:addElement(f2_local4)
	f2_local4:setText(f2_arg2)
	Widget.boxText = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Default / 2,
		right = 0,
		bottom = CoD.textSize.Default / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = textAlpha,
		font = CoD.fonts.Default
	})
	Widget:addElement(Widget.boxText)
	if f2_arg3 then
		local f2_local5 = 3000
		local f2_local6 = CoD.TypewriterText.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -640,
			right = 640,
			topAnchor = true,
			bottomAnchor = false,
			top = 32,
			bottom = 32 + CoD.textSize.ExtraSmall,
			font = CoD.fonts.ExtraSmall,
			red = CoD.F35Hud.Blue.r,
			green = CoD.F35Hud.Blue.g,
			blue = CoD.F35Hud.Blue.b,
			alpha = CoD.F35Hud.Blue.a,
			alignment = LUI.Alignment.Center
		})
		f2_local6:registerAnimationState("hide", {
			alpha = 0
		})
		f2_local6:registerEventHandler("transition_complete_hide", f2_local6.close)
		Widget:addElement(f2_local6)
		Widget:addElement(LUI.UITimer.new(f2_arg5, {
			name = "typewrite",
			text = f2_arg4,
			duration = f2_local5
		}, true, f2_local6))
		Widget:addElement(LUI.UITimer.new(f2_arg5 + f2_local5 + 500, {
			name = "animate",
			animationStateName = "hide",
			duration = 250
		}, true, f2_local6))
		Widget:addElement(LUI.UITimer.new(f2_arg5 + f2_local5 + 500, {
			name = "animate",
			animationStateName = "show",
			duration = 1000
		}, true, Widget))
	else
		Widget:animateToState("show")
	end
	return Widget
end

CoD.F35Hud.CreateReticule = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -360,
		bottom = 360,
		alpha = 1
	})
	Widget:setUseStencil(true)
	Widget:registerAnimationState("expand", {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.F35Hud.ReticuleWidth / 2,
		right = CoD.F35Hud.ReticuleWidth / 2
	})
	Widget:registerAnimationState("fullbright", {
		alpha = 1
	})
	if InstanceRef then
		HudRef:addElement(LUI.UITimer.new(6500, {
			name = "animate",
			animationStateName = "expand",
			duration = 1500
		}, true, Widget))
	else
		Widget:animateToState("expand")
		Widget:animateToState("fullbright", 1000)
	end
	local Widget = LUI.UIElement.new({
		left = -CoD.F35Hud.ReticuleWidth / 2,
		right = CoD.F35Hud.ReticuleWidth / 2,
		top = -CoD.F35Hud.ReticuleHeight / 2,
		bottom = CoD.F35Hud.ReticuleHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:addElement(Widget)
	CoD.F35Hud.AddCompass(Widget)
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
	Widget:setupRollLevel()
	Widget:addElement(Widget)
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
	Widget:setupRollLevel(-1)
	Widget:addElement(Widget)
	if not CoD.isWIIU then
		Widget:addElement(LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			material = CoD.F35Hud.OuterReticleMaterial,
			zRot = 180
		}))
		Widget:addElement(LUI.UIImage.new({
			left = -CoD.F35Hud.ReticuleHeight / 2,
			top = -CoD.F35Hud.ReticuleHeight / 2,
			right = CoD.F35Hud.ReticuleHeight / 2,
			bottom = CoD.F35Hud.ReticuleHeight / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			material = CoD.F35Hud.InnerReticleMaterial
		}))
	end
	Widget:addElement(LUI.UIImage.new({
		left = -256,
		top = -128 - CoD.F35Hud.ReticuleHeight / 4,
		right = 256,
		bottom = 128 - CoD.F35Hud.ReticuleHeight / 4,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		material = RegisterMaterial("hud_f35_reticule_meter")
	}))
	local f3_local4 = CoD.textSize.ExtraSmall
	local f3_local5 = -85
	local f3_local6 = 40
	local f3_local7 = 200
	local f3_local8 = -200
	local f3_local9 = -368
	local f3_local10 = 100
	local f3_local11 = -180
	local f3_local12 = 180
	local f3_local13 = CoD.F35Hud.Blue.a
	local f3_local14 = 128
	local f3_local15 = 128
	HudRef.sysBox = CoD.F35Hud.CreateBox(f3_local9, f3_local10, "SYS", InstanceRef, Engine.Localize("LA_2_SYS_BOOTUP"), 0)
	HudRef.sysBox.boxText:registerAnimationState("red", {
		red = CoD.F35Hud.Red.r,
		green = CoD.F35Hud.Red.g,
		blue = CoD.F35Hud.Red.b,
		alpha = CoD.F35Hud.Red.a
	})
	HudRef.sysBox.boxText:setText("OK")
	HudRef:addElement(HudRef.sysBox)
	local f3_local16 = 32
	local f3_local17 = f3_local16
	local f3_local18 = 15
	local leftWarningTriangle = LUI.UIImage.new({
		left = f3_local9 - f3_local14 / 2 - f3_local16 + f3_local18,
		top = f3_local10 - f3_local17 / 2,
		right = f3_local9 - f3_local14 / 2 + f3_local18,
		bottom = f3_local10 + f3_local17 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.F35Hud.Red.r,
		green = CoD.F35Hud.Red.g,
		blue = CoD.F35Hud.Red.b,
		alpha = 0,
		material = CoD.F35Hud.TriangleMaterial
	})
	HudRef:addElement(leftWarningTriangle)
	HudRef.leftWarningTriangle = leftWarningTriangle
	leftWarningTriangle:registerAnimationState("show", {
		alpha = CoD.F35Hud.Red.a
	})
	
	
	leftWarningTriangle = LUI.UIImage.new({
		left = f3_local9 + f3_local14 / 2 - f3_local18,
		top = f3_local10 - f3_local17 / 2,
		right = f3_local9 + f3_local14 / 2 + f3_local16 - f3_local18,
		bottom = f3_local10 + f3_local17 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.F35Hud.Red.r,
		green = CoD.F35Hud.Red.g,
		blue = CoD.F35Hud.Red.b,
		alpha = 0,
		material = CoD.F35Hud.TriangleMaterial
	})
	leftWarningTriangle:registerAnimationState("show", {
		alpha = CoD.F35Hud.Red.a
	})
	HudRef.rightWarningTriangle = leftWarningTriangle
	HudRef:addElement(leftWarningTriangle)
	HudRef.fltBox = CoD.F35Hud.CreateBox(-f3_local9, f3_local10, "FLT", InstanceRef, Engine.Localize("LA_2_FLT_BOOTUP"), 9000)
	HudRef.fltBox.boxText:setText("VTOL")
	HudRef:addElement(HudRef.fltBox)
	HudRef.altBox = CoD.F35Hud.CreateBox(-f3_local7, f3_local8, "ALT", InstanceRef, Engine.Localize("LA_2_ALT_BOOTUP"), 3000)
	HudRef.altBox.boxText:setText("--- FT")
	HudRef:addElement(HudRef.altBox)
	HudRef.spdBox = CoD.F35Hud.CreateBox(f3_local7, f3_local8, "SPD", InstanceRef, Engine.Localize("LA_2_SPD_BOOTUP"), 6000)
	HudRef.spdBox.boxText:setText("-- KTS")
	HudRef:addElement(HudRef.spdBox)
	local f3_local20 = LUI.UIText.new({
		left = 0,
		top = -f3_local6 - f3_local4,
		right = 0,
		bottom = -f3_local6,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = f3_local13,
		font = CoD.fonts.ExtraSmall
	})
	f3_local20:setText("VTOL OFF ")
	Widget.vtolText = f3_local20
	local f3_local21 = LUI.UIText.new({
		left = f3_local11,
		top = -f3_local4 / 2,
		right = f3_local11 + 1,
		bottom = f3_local4 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = f3_local13,
		font = CoD.fonts.ExtraSmall
	})
	f3_local21:setText("32")
	Widget.pitchLeftText = f3_local21
	local f3_local22 = LUI.UIText.new({
		left = f3_local12,
		top = -f3_local4 / 2,
		right = f3_local12 + 1,
		bottom = f3_local4 / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = f3_local13,
		font = CoD.fonts.ExtraSmall
	})
	f3_local22:setText("32")
	Widget.pitchRightText = f3_local22
	local f3_local23 = 22
	local f3_local24 = 72
	local f3_local25 = 150
	
	local targetingText = LUI.UIElement.new({
		left = f3_local25,
		top = -f3_local24 - f3_local23,
		right = f3_local25 + 1,
		bottom = -f3_local24,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		alphaMultiplier = 0
	})
	targetingText:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	targetingText:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	
	local text = LUI.UIText.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull
	})
	text:setText("SYNCING...")
	targetingText:addElement(text)
	targetingText.text = text
	
	Widget:addElement(targetingText)
	Widget.targetingText = targetingText
	
	local f3_local28 = 20
	local f3_local29 = 78
	local f3_local30 = 190
	
	local firingText = LUI.UIElement.new({
		left = f3_local30,
		top = -f3_local29 - f3_local28,
		right = f3_local30 + 1,
		bottom = -f3_local29,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		alphaMultiplier = 0
	})
	firingText:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	firingText:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	
	local text = LUI.UIText.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = f3_local13
	})
	text:setText("LOCKED")
	firingText:addElement(text)
	firingText.text = text
	
	Widget:addElement(firingText)
	Widget.firingText = firingText
	
	return Widget
end

CoD.F35Hud.CreateBracket = function (f4_arg0)
	local Widget = LUI.UIElement.new({
		left = -CoD.F35Hud.BracketContainerWidth / 100,
		top = -CoD.F35Hud.BracketContainerHeight / 2,
		right = CoD.F35Hud.BracketContainerWidth / 100,
		bottom = CoD.F35Hud.BracketContainerHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:registerAnimationState("bootUp", {
		left = -CoD.F35Hud.BracketContainerWidth / 2,
		right = CoD.F35Hud.BracketContainerWidth / 2,
		leftAnchor = false,
		rightAnchor = false
	})
	Widget:animateToState("bootUp", 1000, true, true)
	CoD.F35Hud.AddCompass(Widget)
	local f4_local1 = 25
	local f4_local2 = 90
	local f4_local3 = -8
	local f4_local4 = 20
	local f4_local5 = 1
	local f4_local6 = 10
	local f4_local7 = -50
	local f4_local8 = LUI.UIImage.new({
		left = -CoD.F35Hud.BracketWidth,
		right = 0,
		top = -f4_local6,
		bottom = f4_local6,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = f4_local5,
		material = CoD.F35Hud.BracketMaterial,
		yRot = 180,
		zRot = 180
	})
	Widget:addElement(LUI.UIImage.new({
		left = -CoD.F35Hud.BracketWidth,
		right = 0,
		top = -f4_local6,
		bottom = f4_local6,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.SamHud.BaseColor.b,
		alpha = f4_local5,
		material = CoD.F35Hud.BracketFuzzMaterial,
		yRot = 180,
		zRot = 180
	}))
	local Widget = LUI.UIElement.new({
		left = f4_local3,
		top = f4_local4,
		right = f4_local3 + f4_local1,
		bottom = f4_local4 + f4_local2,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	local f4_local10 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.MissileFillMaterial
	})
	local f4_local11 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.MissileFillFuzzMaterial
	})
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:setUseStencil(true)
	f4_arg0.missileStencilRight = Widget
	local f4_local13 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = -f4_local2,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = 0.6,
		material = CoD.F35Hud.MissileKeyLineFuzzMaterial
	})
	local f4_local14 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = -f4_local2,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = 1,
		material = CoD.F35Hud.MissileKeyLineMaterial
	})
	Widget:addElement(f4_local13)
	Widget:addElement(f4_local14)
	Widget:addElement(f4_local11)
	Widget:addElement(Widget)
	Widget:addElement(f4_local10)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new({
		left = CoD.F35Hud.CannonSpacing,
		right = CoD.F35Hud.CannonWidth + CoD.F35Hud.CannonSpacing,
		top = -CoD.F35Hud.CannonHeight,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f4_local16 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonMaterial
	})
	Widget:addElement(LUI.UIImage.new({
		left = -CoD.F35Hud.CannonWidth / 2,
		right = CoD.F35Hud.CannonWidth / 2,
		top = -CoD.F35Hud.CannonHeight / 2,
		bottom = CoD.F35Hud.CannonHeight / 2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonFuzzMaterial
	}))
	local f4_local17 = 8
	local f4_local18 = 10
	local f4_local19 = 50
	local f4_local20 = LUI.UIImage.new({
		left = f4_local17,
		right = f4_local18 + f4_local17,
		top = -f4_local19,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonKeyLineMaterial
	})
	local f4_local21 = LUI.UIImage.new({
		left = f4_local17 / 2,
		right = f4_local18 * 2 + f4_local17 / 2,
		top = -f4_local19 * 1.5,
		bottom = f4_local19 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonKeyLineFuzzMaterial
	})
	local Widget = LUI.UIElement.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:setUseStencil(true)
	local f4_local23 = LUI.UIImage.new({
		left = -f4_local18 / 2,
		right = f4_local18 / 2,
		top = -f4_local19 * 1.5,
		bottom = f4_local19 / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonFillFuzzMaterial
	})
	local f4_local24 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = -f4_local19,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonFillMaterial
	})
	Widget:addElement(f4_local23)
	Widget:addElement(f4_local24)
	local f4_local25 = 5
	local f4_local26 = 0
	local f4_local27 = LUI.UIImage.new({
		left = -f4_local25,
		right = 0,
		top = -f4_local25 / 2 + f4_local26,
		bottom = f4_local25 / 2 + f4_local26,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.ArrowMaterial,
		zRot = 0
	})
	f4_local20:addElement(f4_local27)
	local f4_local28 = LUI.UIImage.new({
		left = 0,
		right = f4_local25,
		top = -f4_local25 / 2 + f4_local26,
		bottom = f4_local25 / 2 + f4_local26,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.ArrowMaterial,
		zRot = 180
	})
	f4_local20:addElement(f4_local28)
	f4_local20:addElement(Widget)
	Widget:addElement(f4_local16)
	Widget:addElement(f4_local21)
	Widget:addElement(f4_local20)
	Widget:addElement(Widget)
	Widget.height = f4_local19
	f4_arg0.cannonRightStencil = Widget
	f4_arg0.cannonRightArrowL = f4_local27
	f4_arg0.cannonRightArrowR = f4_local28
	f4_arg0.cannonArrowSize = f4_local25
	f4_arg0.cannonArrowOffset = f4_local26
	Widget:addElement(f4_local8)
	local f4_local29 = LUI.UIImage.new({
		left = 0,
		right = CoD.F35Hud.BracketWidth,
		top = -f4_local6,
		bottom = f4_local6,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = f4_local5,
		material = CoD.F35Hud.BracketMaterial,
		zRot = 180
	})
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		right = CoD.F35Hud.BracketWidth,
		top = -f4_local6,
		bottom = f4_local6,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = f4_local5,
		material = CoD.F35Hud.BracketFuzzMaterial,
		zRot = 180
	}))
	local Widget = LUI.UIElement.new({
		left = -f4_local3 - f4_local1,
		top = f4_local4,
		right = -f4_local3,
		bottom = f4_local4 + f4_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	local f4_local31 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.MissileFillMaterial
	})
	local f4_local32 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.MissileFillFuzzMaterial
	})
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:setUseStencil(true)
	f4_arg0.missileStencilLeft = Widget
	local f4_local34 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = -f4_local2,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = 0.6,
		material = CoD.F35Hud.MissileKeyLineFuzzMaterial
	})
	local f4_local35 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = -f4_local2,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = 1,
		material = CoD.F35Hud.MissileKeyLineMaterial
	})
	Widget:addElement(f4_local34)
	Widget:addElement(f4_local35)
	Widget:addElement(f4_local32)
	Widget:addElement(Widget)
	Widget:addElement(f4_local31)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new({
		left = -CoD.F35Hud.CannonWidth - CoD.F35Hud.CannonSpacing,
		right = -CoD.F35Hud.CannonSpacing,
		top = -CoD.F35Hud.CannonHeight,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	local f4_local37 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonMaterial
	})
	Widget:addElement(LUI.UIImage.new({
		left = -CoD.F35Hud.CannonWidth / 2,
		right = CoD.F35Hud.CannonWidth / 2,
		top = -CoD.F35Hud.CannonHeight / 2,
		bottom = CoD.F35Hud.CannonHeight / 2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonFuzzMaterial
	}))
	local f4_local38 = LUI.UIImage.new({
		left = -f4_local18 - f4_local17,
		right = -f4_local17,
		top = -f4_local19,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonKeyLineMaterial
	})
	local f4_local39 = LUI.UIImage.new({
		left = -f4_local18 * 2 - f4_local17 / 2,
		right = -f4_local17 / 2,
		top = -f4_local19 * 1.5,
		bottom = f4_local19 / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonKeyLineFuzzMaterial
	})
	local Widget = LUI.UIElement.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:setUseStencil(true)
	local f4_local41 = LUI.UIImage.new({
		left = -f4_local18 / 2,
		right = f4_local18 / 2,
		top = -f4_local19 * 1.5,
		bottom = f4_local19 / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonFillFuzzMaterial
	})
	local f4_local42 = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = -f4_local19,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.CannonFillMaterial
	})
	Widget:addElement(f4_local41)
	Widget:addElement(f4_local42)
	local f4_local43 = 5
	local f4_local44 = LUI.UIImage.new({
		left = -f4_local43,
		right = 0,
		top = -f4_local43 / 2,
		bottom = f4_local43 / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.ArrowMaterial,
		zRot = 0
	})
	f4_local38:addElement(f4_local44)
	local f4_local45 = LUI.UIImage.new({
		left = 0,
		right = f4_local43,
		top = -f4_local43 / 2,
		bottom = f4_local43 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.F35Hud.BaseColor.r,
		green = CoD.F35Hud.BaseColor.g,
		blue = CoD.F35Hud.BaseColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.F35Hud.ArrowMaterial,
		zRot = 180
	})
	f4_local38:addElement(f4_local45)
	f4_local38:addElement(Widget)
	Widget:addElement(f4_local37)
	Widget:addElement(f4_local39)
	Widget:addElement(f4_local38)
	Widget:addElement(Widget)
	Widget.height = f4_local19
	f4_arg0.cannonLeftStencil = Widget
	f4_arg0.cannonLeftArrowL = f4_local44
	f4_arg0.cannonLeftArrowR = f4_local45
	f4_arg0.cannonArrowSize = f4_local43
	f4_arg0.cannonArrowOffset = f4_local26
	Widget:addElement(f4_local37)
	Widget:addElement(Widget)
	Widget:addElement(f4_local29)
	return Widget
end

CoD.F35Hud.AddCompass = function (f5_arg0)
	local f5_local0 = -385
	local f5_local1 = 0.65
	local Widget = LUI.UIElement.new({
		left = -234 * f5_local1,
		top = f5_local0,
		right = 234 * f5_local1,
		bottom = f5_local0 + CoD.F35Hud.TopBarHeight,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0,
		green = 0.8,
		blue = 1,
		material = RegisterMaterial("hud_horizontal_compass_top"),
		shaderVector0 = {
			f5_local1,
			-0.5,
			0,
			0
		}
	})
	Widget:setupHorizontalCompass()
	f5_arg0:addElement(Widget)
end

CoD.F35Hud.UpdateVehicleData = function (f6_arg0, f6_arg1)
	if f6_arg1 ~= nil then
		if f6_arg1.alt ~= nil then
			f6_arg0.altBox.boxText:setText(f6_arg1.alt .. "FT")
		end
		if f6_arg1.dir ~= nil and f6_arg0.orientationText ~= nil then
			f6_arg0.orientationText:setText(f6_arg1.dir)
		end
		if f6_arg1.speed ~= nil then
			f6_arg0.spdBox.boxText:setText(f6_arg1.speed .. "KTS")
		end
		if f6_arg1.vehicleType ~= nil then
			if f6_arg1.vehicleType == "plane_f35_player_vtol" or f6_arg1.vehicleType == "plane_f35_player_vtol_dogfight" then
				f6_arg0.fltBox.boxText:setText("VTOL")
			else
				f6_arg0.fltBox.boxText:setText("CTOL")
			end
		end
		if f6_arg1.yaw ~= nil then

		else

		end
		if f6_arg1.roll ~= nil and f6_arg0.reticule ~= nil then

		else

		end
		if f6_arg1.pitch ~= nil and f6_arg0.reticule ~= nil then
			local f6_local0 = f6_arg1.pitch / 90 * -CoD.F35Hud.ReticulePitchOffset
		end
		if f6_arg1.pitch ~= nil then
			if f6_arg0.reticule.pitchLeftText ~= nil then
				f6_arg0.reticule.pitchLeftText:setText(f6_arg1.roll)
			end
			if f6_arg0.reticule.pitchRightText ~= nil then
				if f6_arg1.roll ~= 0 then
					f6_arg0.reticule.pitchRightText:setText(-f6_arg1.roll)
				else
					f6_arg0.reticule.pitchRightText:setText(f6_arg1.roll)
				end
			end
		end
		if f6_arg1.yawSpeed ~= nil and f6_arg0.reticule ~= nil then
			local f6_local0 = f6_arg1.yawSpeed * CoD.F35Hud.ReticulePitchOffset
		end
	end
end

CoD.F35Hud.UpdateMissiles = function (f7_arg0, f7_arg1)
	if f7_arg1 ~= nil then
		if f7_arg0.missileStencilRight ~= nil then
			f7_arg0.missileStencilRight:registerAnimationState("fired", {
				bottom = 0,
				top = 0,
				topAnchor = false,
				bottomAnchor = true
			})
			f7_arg0.missileStencilRight:animateToState("fired")
			f7_arg0.missileStencilRight:registerAnimationState("reload", {
				bottom = 0,
				top = 0,
				topAnchor = true,
				bottomAnchor = true
			})
			f7_arg0.missileStencilRight:animateToState("reload", 1000, true, true)
		end
		if f7_arg0.missileStencilLeft ~= nil then
			f7_arg0.missileStencilLeft:registerAnimationState("fired", {
				bottom = 0,
				top = 0,
				topAnchor = false,
				bottomAnchor = true
			})
			f7_arg0.missileStencilLeft:animateToState("fired")
			f7_arg0.missileStencilLeft:registerAnimationState("reload", {
				bottom = 0,
				top = 0,
				topAnchor = true,
				bottomAnchor = true
			})
			f7_arg0.missileStencilLeft:animateToState("reload", 1000, true, true)
		end
	end
	f7_arg0:dispatchEventToChildren(f7_arg1)
end

CoD.F35Hud.UpdateDamage = function (f8_arg0, f8_arg1)
	if f8_arg1 ~= nil and f8_arg1.data ~= nil and f8_arg1.data[1] ~= nil then
		if f8_arg1.data[1] > 0 then
			f8_arg0.sysBox.boxText:animateToState("red")
			f8_arg0.sysBox.boxText:setText("DMG")
			f8_arg0.leftWarningTriangle:animateToState("show")
			f8_arg0.rightWarningTriangle:animateToState("show")
		else
			f8_arg0.sysBox.boxText:animateToState("default")
			f8_arg0.sysBox.boxText:setText("OK")
			f8_arg0.leftWarningTriangle:animateToState("default")
			f8_arg0.rightWarningTriangle:animateToState("default")
		end
	end
end

CoD.F35Hud.UpdateWeaponHeat = function (f9_arg0, f9_arg1)
	if f9_arg1.data ~= nil then
		local f9_local0 = f9_arg1.data[1] / 100
		local f9_local1 = f9_arg0.cannonRightStencil.height
		if f9_arg0.cannonRightStencil ~= nil then
			f9_arg0.cannonRightStencil:registerAnimationState("fill", {
				top = -f9_local1 * f9_local0,
				bottom = 0,
				topAnchor = false,
				bottomAnchor = true
			})
			f9_arg0.cannonRightStencil:animateToState("fill", 50, false, false)
		end
		if f9_arg0.cannonRightArrowL ~= nil then
			f9_arg0.cannonRightArrowL:registerAnimationState("fill", {
				top = -f9_local1 * f9_local0 - f9_arg0.cannonArrowSize / 2,
				bottom = -f9_local1 * f9_local0 + f9_arg0.cannonArrowSize / 2,
				topAnchor = false,
				bottomAnchor = true
			})
			f9_arg0.cannonRightArrowL:animateToState("fill", 50, false, false)
		end
		if f9_arg0.cannonRightArrowR ~= nil then
			f9_arg0.cannonRightArrowR:registerAnimationState("fill", {
				top = -f9_local1 * f9_local0 - f9_arg0.cannonArrowSize / 2,
				bottom = -f9_local1 * f9_local0 + f9_arg0.cannonArrowSize / 2,
				topAnchor = false,
				bottomAnchor = true
			})
			f9_arg0.cannonRightArrowR:animateToState("fill", 50, false, false)
		end
		if f9_arg0.cannonLeftStencil ~= nil then
			f9_arg0.cannonLeftStencil:registerAnimationState("fill", {
				top = -f9_arg0.cannonRightStencil.height * f9_local0,
				bottom = 0,
				topAnchor = false,
				bottomAnchor = true
			})
			f9_arg0.cannonLeftStencil:animateToState("fill", 50, false, false)
		end
		if f9_arg0.cannonLeftArrowL ~= nil then
			f9_arg0.cannonLeftArrowL:registerAnimationState("fill", {
				top = -f9_local1 * f9_local0 - f9_arg0.cannonArrowSize / 2,
				bottom = -f9_local1 * f9_local0 + f9_arg0.cannonArrowSize / 2,
				topAnchor = false,
				bottomAnchor = true
			})
			f9_arg0.cannonLeftArrowL:animateToState("fill", 50, false, false)
		end
		if f9_arg0.cannonLeftArrowR ~= nil then
			f9_arg0.cannonLeftArrowR:registerAnimationState("fill", {
				top = -f9_local1 * f9_local0 - f9_arg0.cannonArrowSize / 2,
				bottom = -f9_local1 * f9_local0 + f9_arg0.cannonArrowSize / 2,
				topAnchor = false,
				bottomAnchor = true
			})
			f9_arg0.cannonLeftArrowR:animateToState("fill", 50, false, false)
		end
	end
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.F35Hud.CinematicStart = function (f10_arg0, f10_arg1)
	f10_arg0.bracketContainer:registerAnimationState("cinematicStart", {
		top = -CoD.F35Hud.BracketContainerCinematicHeight / 2,
		bottom = CoD.F35Hud.BracketContainerHeight / 2,
		topAnchor = false,
		bottomAnchor = false
	})
	f10_arg0.bracketContainer:animateToState("cinematicStart", 250, true, true)
end

CoD.F35Hud.CinematicStop = function (f11_arg0, f11_arg1)
	f11_arg0.bracketContainer:registerAnimationState("cinematicStop", {
		top = -CoD.F35Hud.BracketContainerHeight / 2,
		bottom = CoD.F35Hud.BracketContainerHeight / 2,
		topAnchor = false,
		bottomAnchor = false
	})
	f11_arg0.bracketContainer:animateToState("cinematicStop", 250, true, true)
end

