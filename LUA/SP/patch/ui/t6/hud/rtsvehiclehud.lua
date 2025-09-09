CoD.RTSVehicleHud = {}
CoD.RTSVehicleHud.ArrowMaterial = "hud_rts_mech_arrow"
CoD.RTSVehicleHud.BracketMaterial = "hud_rts_mech_bracket"
CoD.RTSVehicleHud.BinkHudMaterial = "mtl_sam_bink"
CoD.RTSVehicleHud.ContainerWidth = 512
CoD.RTSVehicleHud.BracketHeight = 512
CoD.RTSVehicleHud.BracketWidth = 64
CoD.RTSVehicleHud.ArrowHeight = 32
CoD.RTSVehicleHud.ArrowWidth = 128
CoD.RTSVehicleHud.new = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	local f1_local1 = RegisterMaterial(CoD.RTSVehicleHud.BracketMaterial)
	local f1_local2 = RegisterMaterial(CoD.RTSVehicleHud.ArrowMaterial)
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.RTSVehicleHud.ContainerWidth / 2 - CoD.RTSVehicleHud.BracketWidth,
		right = CoD.RTSVehicleHud.ContainerWidth / 2 + CoD.RTSVehicleHud.BracketWidth,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.RTSVehicleHud.BracketHeight / 2,
		bottom = CoD.RTSVehicleHud.BracketHeight / 2
	})
	Widget.id = Widget.id .. ".BracketContainer"
	Widget:addElement(Widget)
	local f1_local4 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.RTSVehicleHud.BracketWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1,
		material = f1_local1
	})
	f1_local4.id = f1_local4.id .. ".LeftBracket"
	Widget:addElement(f1_local4)
	local f1_local5 = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -CoD.RTSVehicleHud.BracketWidth,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1,
		material = f1_local1,
		yRot = 180
	})
	f1_local5.id = f1_local5.id .. ".BracketRight"
	Widget:addElement(f1_local5)
	local f1_local6 = 17
	local f1_local7 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local6,
		right = CoD.RTSVehicleHud.ArrowWidth + f1_local6,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.RTSVehicleHud.ArrowHeight / 2,
		bottom = CoD.RTSVehicleHud.ArrowHeight / 2,
		material = f1_local2
	})
	f1_local7.id = f1_local7.id .. ".LeftArrow"
	Widget:addElement(f1_local7)
	local f1_local8 = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -CoD.RTSVehicleHud.ArrowWidth - f1_local6,
		right = -f1_local6,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.RTSVehicleHud.ArrowHeight / 2,
		bottom = CoD.RTSVehicleHud.ArrowHeight / 2,
		material = f1_local2,
		zRot = 180
	})
	f1_local8.id = f1_local8.id .. ".RightArrow"
	Widget:addElement(f1_local8)
	local f1_local9 = 35
	local f1_local10 = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.RTSVehicleHud.ArrowWidth / 2,
		right = CoD.RTSVehicleHud.ArrowWidth / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local9,
		bottom = CoD.RTSVehicleHud.ArrowHeight + f1_local9,
		material = f1_local2,
		zRot = -90
	})
	f1_local10.id = f1_local10.id .. ".TopArrow"
	Widget:addElement(f1_local10)
	return Widget
end

