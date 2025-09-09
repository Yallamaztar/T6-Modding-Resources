require("t6/CoDBase")
CoD.SpiderbotHud = {}
CoD.SpiderbotHud.Red = CoD.RTSColors.red
CoD.SpiderbotHud.Blue = CoD.RTSColors.blue
CoD.SpiderbotHud.Magenta = CoD.RTSColors.magenta
CoD.SpiderbotHud.Yellow = CoD.RTSColors.yellow
CoD.SpiderbotHud.Servo = {}
CoD.SpiderbotHud.Servo.FontName = "ExtraSmall"
CoD.SpiderbotHud.Servo.FontSize = CoD.textSize[CoD.SpiderbotHud.Servo.FontName]
CoD.SpiderbotHud.Servo.Font = CoD.fonts[CoD.SpiderbotHud.Servo.FontName]
CoD.SpiderbotHud.Servo.LabelColor = CoD.SpiderbotHud.Blue
CoD.SpiderbotHud.Servo.ValueColor = CoD.SpiderbotHud.Yellow
CoD.SpiderbotHud.Servo.TextBoxWidth = 130
CoD.SpiderbotHud.Servo.TextBoxHeight = 100
CoD.SpiderbotHud.Servo.LabelRatio = 0.6
CoD.SpiderbotHud.Servo.LabelWidth = CoD.SpiderbotHud.Servo.TextBoxWidth * CoD.SpiderbotHud.Servo.LabelRatio
CoD.SpiderbotHud.Servo.ColumnSpacerRatio = 0.1
CoD.SpiderbotHud.Servo.ColumnSpacerWidth = CoD.SpiderbotHud.Servo.TextBoxWidth * CoD.SpiderbotHud.Servo.ColumnSpacerRatio
CoD.SpiderbotHud.Servo.ValueWidth = CoD.SpiderbotHud.Servo.TextBoxWidth - CoD.SpiderbotHud.Servo.LabelWidth - CoD.SpiderbotHud.Servo.ColumnSpacerWidth
CoD.SpiderbotHud.BottomRightHud = {}
CoD.SpiderbotHud.BottomRightHud.TextBoxWidth = 130
CoD.SpiderbotHud.BottomRightHud.TextBoxHeight = 130
CoD.SpiderbotHud.QuarterWidth = 490
CoD.SpiderbotHud.QuarterHeight = CoD.SpiderbotHud.QuarterWidth / 2
CoD.SpiderbotHud.ArrowContainerSize = 235
CoD.SpiderbotHud.ArrowWidth = 150
CoD.SpiderbotHud.ArrowHeight = CoD.SpiderbotHud.ArrowWidth
CoD.SpiderbotHud.CrosshairWidth = 128
CoD.SpiderbotHud.CrosshairHeight = CoD.SpiderbotHud.CrosshairWidth
CoD.SpiderbotHud.MidLineWidth = 550
CoD.SpiderbotHud.MidLineHeight = CoD.SpiderbotHud.MidLineWidth / 2
CoD.SpiderbotHud.ChargerIconWidth = 16
CoD.SpiderbotHud.ChargerIconHeight = CoD.SpiderbotHud.ChargerIconWidth * 7
CoD.SpiderbotHud.ChargerWidthOffset = 5
CoD.SpiderbotHud.ChargerHeightOffset = 2
CoD.SpiderbotHud.BoltArrowWidth = 50
CoD.SpiderbotHud.BoltArrowHeight = CoD.SpiderbotHud.BoltArrowWidth
CoD.SpiderbotHud.Spinner3DSize = 110
CoD.SpiderbotHud.TopBarHeight = 64
CoD.SpiderbotHud.CompassArrowHeight = 16
CoD.SpiderbotHud.CompassArrowWidth = CoD.SpiderbotHud.CompassArrowHeight * 2
CoD.SpiderbotHud.BaseColor = CoD.SpiderbotHud.Red
CoD.SpiderbotHud.PercentColor = CoD.SpiderbotHud.Yellow
CoD.SpiderbotHud.FontAlpha = 0.6
CoD.SpiderbotHud.ScanningColor = CoD.SpiderbotHud.Blue
CoD.SpiderbotHud.TextScanDuration = 6000
CoD.SpiderbotHud.new = function (f1_arg0, f1_arg1)
	CoD.SpiderbotHud.QuarterTopMaterial = RegisterMaterial("hud_spiderbot_bottom_bracket")
	CoD.SpiderbotHud.QuarterBottomMaterial = RegisterMaterial("hud_spiderbot_top_bracket")
	CoD.SpiderbotHud.ArrowMaterial = RegisterMaterial("hud_spiderbot_arrow02")
	CoD.SpiderbotHud.BoltArrowMaterial = RegisterMaterial("hud_spiderbot_bolt_arrow")
	CoD.SpiderbotHud.CrosshairMaterial = RegisterMaterial("hud_spiderbot_crosshair02")
	CoD.SpiderbotHud.MidLineMaterial = RegisterMaterial("hud_spiderbot_mid_line")
	CoD.SpiderbotHud.ChargerKeyLineMaterial = RegisterMaterial("hud_spiderbot_charge")
	CoD.SpiderbotHud.GlowMaterial = RegisterMaterial("hud_sam_glow")
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = Widget.id .. ".SpiderbotHud"
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(false, false, -640, 640)
	f1_local1:setTopBottom(false, false, -360, 360)
	f1_local1:setImage(CoD.SpiderbotHud.GlowMaterial)
	
	local hudContainer = CoD.SpiderbotHud.CreateHudContainer(Widget, f1_arg0, f1_arg1)
	Widget:addElement(hudContainer)
	Widget.hudContainer = hudContainer
	
	CoD.SpiderbotHud.AddMidLinesAndArrows(Widget, hudContainer)
	CoD.SpiderbotHud.AddCompass(Widget, hudContainer)
	CoD.SpiderbotHud.AddChargers(Widget, hudContainer)
	CoD.SpiderbotHud.AddDynamicText(Widget, hudContainer)
	Widget.moveToDefault = CoD.SpiderbotHud.MoveToDefault
	Widget.moveToBinkStart = CoD.SpiderbotHud.MoveToBinkStart
	Widget:registerEventHandler("hud_vehicle_turret_fire", CoD.SpiderbotHud.VehicleTurretFire)
	Widget:registerEventHandler("hud_spiderbot_eyescan", CoD.SpiderbotHud.EyescanEventBegin)
	Widget:registerEventHandler("hud_spiderbot_eyescan_end", CoD.SpiderbotHud.EyescanEventEnd)
	Widget:registerEventHandler("hud_update_refresh", CoD.SpiderbotHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.SpiderbotHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.SpiderbotHud.UpdateVisibility)
	Widget:registerEventHandler("move_to_default", CoD.SpiderbotHud.MoveToDefault)
	Widget:registerEventHandler("bink_bootup_sequence", CoD.SpiderbotHud.BinkSequence)
	Widget:processEvent({
		name = "move_to_default"
	})
	return Widget
end

CoD.SpiderbotHud.CreateHudContainer = function (f2_arg0, f2_arg1, f2_arg2)
	local Widget = LUI.UIElement.new(f2_arg1)
	Widget.id = Widget.id .. ".HudContainer"
	local f2_local1 = 0
	local f2_local2 = 70
	
	local leftTopQuarter = LUI.UIImage.new()
	leftTopQuarter:setImage(CoD.SpiderbotHud.QuarterTopMaterial)
	leftTopQuarter:setXRot(180)
	leftTopQuarter:setYRot(180)
	leftTopQuarter.id = leftTopQuarter.id .. ".LeftTopQuarter"
	Widget:addElement(leftTopQuarter)
	f2_arg0.leftTopQuarter = leftTopQuarter
	
	local leftBottomQuarter = LUI.UIImage.new()
	leftBottomQuarter:setImage(CoD.SpiderbotHud.QuarterBottomMaterial)
	leftBottomQuarter:setXRot(180)
	leftBottomQuarter:setYRot(180)
	leftBottomQuarter.id = leftBottomQuarter.id .. ".LeftBottomQuarter"
	Widget:addElement(leftBottomQuarter)
	f2_arg0.leftBottomQuarter = leftBottomQuarter
	
	local rightTopQuarter = LUI.UIImage.new()
	rightTopQuarter:setImage(CoD.SpiderbotHud.QuarterTopMaterial)
	rightTopQuarter:setXRot(180)
	rightTopQuarter.id = rightTopQuarter.id .. ".RightTopQuarter"
	Widget:addElement(rightTopQuarter)
	f2_arg0.rightTopQuarter = rightTopQuarter
	
	local rightBottomQuarter = LUI.UIImage.new()
	rightBottomQuarter:setImage(CoD.SpiderbotHud.QuarterBottomMaterial)
	rightBottomQuarter:setXRot(180)
	rightBottomQuarter.id = rightBottomQuarter.id .. ".RightBottomQuarter"
	Widget:addElement(rightBottomQuarter)
	f2_arg0.rightBottomQuarter = rightBottomQuarter
	
	local Widget = LUI.UIElement.new()
	Widget.id = Widget.id .. ".CrosshairContainer"
	Widget:addElement(Widget)
	Widget:setupMovingCrosshair(f2_arg2)
	f2_arg0.crosshairContainer = Widget
	local f2_local8 = LUI.UIImage.new()
	f2_local8:setLeftRight(true, true, 0, 0)
	f2_local8:setTopBottom(true, true, 0, 0)
	f2_local8:setImage(CoD.SpiderbotHud.CrosshairMaterial)
	f2_local8:setAlpha(0.5)
	f2_local8.id = f2_local8.id .. ".Crosshair"
	Widget:addElement(f2_local8)
	f2_local8:registerEventHandler("show_elem", CoD.SpiderbotHud.HudContainer_ShowAnim)
	Widget.crosshair = f2_local8
	return Widget
end

CoD.SpiderbotHud.AddMidLinesAndArrows = function (HudRef, InstanceRef)
	local midLineContainer = LUI.UIElement.new()
	midLineContainer:setLeftRight(true, true, 0, 0)
	midLineContainer:setTopBottom(true, true, 0, 0)
	InstanceRef:addElement(midLineContainer)
	HudRef.midLineContainer = midLineContainer
	
	local f3_local1 = 45
	
	local leftMidLine = LUI.UIImage.new()
	leftMidLine:setImage(CoD.SpiderbotHud.MidLineMaterial)
	leftMidLine.id = leftMidLine.id .. ".LeftMidLine"
	midLineContainer:addElement(leftMidLine)
	HudRef.leftMidLine = leftMidLine
	
	local rightMidLine = LUI.UIImage.new()
	rightMidLine:setImage(CoD.SpiderbotHud.MidLineMaterial)
	rightMidLine:setYRot(180)
	rightMidLine.id = rightMidLine.id .. ".RightMidLine"
	midLineContainer:addElement(rightMidLine)
	HudRef.rightMidLine = rightMidLine
	
	local arrowContainer = LUI.UIElement.new()
	midLineContainer:addElement(arrowContainer)
	HudRef.arrowContainer = arrowContainer
	
	local Widget = LUI.UIElement.new()
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setupRollLevel()
	HudRef.arrowContainer:addElement(Widget)
	local f3_local6 = 50
	
	local leftSideArrow = LUI.UIImage.new()
	leftSideArrow:setLeftRight(true, false, -f3_local6, CoD.SpiderbotHud.ArrowWidth - f3_local6)
	leftSideArrow:setTopBottom(false, false, -CoD.SpiderbotHud.ArrowHeight / 2, CoD.SpiderbotHud.ArrowHeight / 2)
	leftSideArrow:setImage(CoD.SpiderbotHud.ArrowMaterial)
	leftSideArrow.id = leftSideArrow.id .. ".LeftSideArrow"
	leftSideArrow:registerEventHandler("show_elem", CoD.SpiderbotHud.HudContainer_ShowAnim)
	Widget:addElement(leftSideArrow)
	InstanceRef.leftSideArrow = leftSideArrow
	
	local rightSideArrow = LUI.UIImage.new()
	rightSideArrow:setLeftRight(false, true, -CoD.SpiderbotHud.ArrowWidth + f3_local6, f3_local6)
	rightSideArrow:setTopBottom(false, false, -CoD.SpiderbotHud.ArrowHeight / 2, CoD.SpiderbotHud.ArrowHeight / 2)
	rightSideArrow:setImage(CoD.SpiderbotHud.ArrowMaterial)
	rightSideArrow:setZRot(180)
	rightSideArrow.id = rightSideArrow.id .. ".RightSideArrow"
	rightSideArrow:registerEventHandler("show_elem", CoD.SpiderbotHud.HudContainer_ShowAnim)
	Widget:addElement(rightSideArrow)
	InstanceRef.rightSideArrow = rightSideArrow
	
end

local f0_local0 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = CoD.SpiderbotHud.Servo.FontSize * 0.9
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f4_local0 * f4_arg1, f4_local0 * f4_arg1 + CoD.SpiderbotHud.Servo.FontSize * 0.7)
	Widget.label = LUI.UIText.new()
	Widget.label:setAlignment(LUI.Alignment.Right)
	Widget.label:setLeftRight(true, false, 0, CoD.SpiderbotHud.Servo.LabelWidth)
	Widget.label:setTopBottom(true, true, 0, 0)
	Widget.label:setAlpha(0.5)
	Widget.label:setText(f4_arg2)
	Widget.label:setRGB(CoD.SpiderbotHud.Servo.LabelColor.r, CoD.SpiderbotHud.Servo.LabelColor.g, CoD.SpiderbotHud.Servo.LabelColor.b)
	Widget:addElement(Widget.label)
	Widget.value = LUI.UIText.new()
	Widget.value:setAlignment(LUI.Alignment.Left)
	Widget.value:setLeftRight(false, true, -CoD.SpiderbotHud.Servo.ValueWidth, 0)
	Widget.value:setTopBottom(true, true, 0, 0)
	Widget.value:setAlpha(0.5)
	Widget.value:setText(f4_arg3)
	Widget.value:setRGB(CoD.SpiderbotHud.Servo.ValueColor.r, CoD.SpiderbotHud.Servo.ValueColor.g, CoD.SpiderbotHud.Servo.ValueColor.b)
	Widget:addElement(Widget.value)
	f4_arg0:addElement(Widget)
	return Widget
end

CoD.SpiderbotHud.Timer = function (f5_arg0, f5_arg1, f5_arg2)
	if f5_arg0.value ~= nil and f5_arg2.start ~= nil then
		CoD.SpiderbotHud.Blink(f5_arg0, f5_arg1)
		local f5_local0 = os.clock() - f5_arg2.start
		local f5_local1 = math.floor(f5_local0 / 60)
		local f5_local2 = math.floor(f5_local1 / 60)
		f5_arg0.value:setText(string.format("%02d:%02d", math.abs(f5_local1 % 60), math.abs(f5_local0 % 60)))
	end
end

CoD.SpiderbotHud.Blink = function (f6_arg0, f6_arg1)
	if f6_arg0.value ~= nil then
		local f6_local0 = math.random(200)
		f6_arg0.value:setAlpha(0.5)
		if f6_local0 == 100 then
			f6_arg0.value:setAlpha(0.2)
		end
	end
end

CoD.SpiderbotHud.UpdatePercentages = function (f7_arg0, f7_arg1, f7_arg2)
	if f7_arg0.value ~= nil then
		CoD.SpiderbotHud.Blink(f7_arg0, f7_arg1)
		if math.random(100) > 95 then
			if f7_arg2 ~= nil then
				f7_arg0.value:setText(math.random(f7_arg2.low, f7_arg2.high) .. "%")
			else
				f7_arg0.value:setText(math.random(82, 89) .. "%")
			end
		end
	end
end

CoD.SpiderbotHud.OverlayUpdate = function (f8_arg0, f8_arg1)
	if f8_arg0.updateRows ~= nil then
		for f8_local3, f8_local4 in pairs(f8_arg0.updateRows) do
			if f8_local4 ~= nil and f8_local4.callback ~= nil then
				f8_local4.callback(f8_local4.self, f8_arg1, f8_local4.values)
			end
		end
	end
end

CoD.SpiderbotHud.AddDynamicText = function (HudRef, InstanceRef)
	local textOverlayContainer = LUI.UIElement.new()
	textOverlayContainer.updateRows = {}
	textOverlayContainer:setLeftRight(true, true, CoD.SpiderbotHud.Servo.TextBoxWidth / 2, -CoD.SpiderbotHud.Servo.TextBoxWidth / 2)
	textOverlayContainer:setTopBottom(true, true, 0, 0)
	textOverlayContainer:registerEventHandler("spiderhud_update_tick", CoD.SpiderbotHud.OverlayUpdate)
	InstanceRef:addElement(LUI.UITimer.new(100, "spiderhud_update_tick", false, textOverlayContainer))
	InstanceRef:addElement(textOverlayContainer)
	HudRef.textOverlayContainer = textOverlayContainer
	
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, -CoD.SpiderbotHud.Servo.TextBoxWidth / 2, 2 * CoD.SpiderbotHud.Servo.TextBoxWidth / 4)
	Widget:setTopBottom(true, false, 0, CoD.SpiderbotHud.Servo.TextBoxHeight)
	textOverlayContainer:addElement(Widget)
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 0, "JRZ-ACTUATER:", "95%"),
		callback = CoD.SpiderbotHud.UpdatePercentages,
		values = {
			low = "92",
			high = "99"
		}
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 1, "ARM SERVO 1:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 2, "ARM SERVO 2:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 3, "ARM SERVO 3:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 4, "ARM SERVO 4:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 5, "ARM SERVO 5:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 6, "ARM SERVO 6:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 7, "RTG BATTERY:", "80%"),
		callback = CoD.SpiderbotHud.UpdatePercentages
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 8, "KLIM SYSTEM:", "NOMINAL"),
		callback = CoD.SpiderbotHud.Blink
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 9, "STAT PRESSURE:", "NOMINAL"),
		callback = CoD.SpiderbotHud.Blink
	})
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, -CoD.SpiderbotHud.Servo.TextBoxWidth / 2, 2 * CoD.SpiderbotHud.Servo.TextBoxWidth / 4)
	Widget:setTopBottom(false, true, -CoD.SpiderbotHud.Servo.TextBoxHeight, 0)
	textOverlayContainer:addElement(Widget)
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 0, "MISSION TIME:", "00:00"),
		callback = CoD.SpiderbotHud.Timer,
		values = {
			start = os.clock()
		}
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 1, "CAC FEED:", "LIVE"),
		callback = CoD.SpiderbotHud.Blink
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 2, "DTO:", "45M"),
		callback = CoD.SpiderbotHud.Blink
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 3, "X:", "1200"),
		callback = CoD.SpiderbotHud.Blink
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 4, "Y:", "-1230"),
		callback = CoD.SpiderbotHud.Blink
	})
	local f9_local3 = LUI.UIText.new()
	f9_local3.font = "Condensed"
	f9_local3:setLeftRight(true, false, -CoD.SpiderbotHud.Servo.TextBoxWidth / 2, 2 * CoD.SpiderbotHud.Servo.TextBoxWidth / 4)
	f9_local3:setTopBottom(false, true, -CoD.SpiderbotHud.Servo.TextBoxHeight - CoD.textSize[f9_local3.font], -CoD.SpiderbotHud.Servo.TextBoxHeight)
	f9_local3:setFont(CoD.fonts[f9_local3.font])
	f9_local3:setRGB(CoD.SpiderbotHud.Yellow.r, CoD.SpiderbotHud.Yellow.g, CoD.SpiderbotHud.Yellow.b)
	f9_local3:setText("TA-45")
	f9_local3:setAlpha(0.5)
	f9_local3:setAlignment(LUI.Alignment.Center)
	textOverlayContainer:addElement(f9_local3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, 2 * -CoD.SpiderbotHud.BottomRightHud.TextBoxWidth / 3, CoD.SpiderbotHud.BottomRightHud.TextBoxWidth / 3)
	Widget:setTopBottom(false, true, -CoD.SpiderbotHud.BottomRightHud.TextBoxHeight, 0)
	textOverlayContainer:addElement(Widget)
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 0, "ADL OUT:", "10:08"),
		callback = CoD.SpiderbotHud.Blink
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 1, "TARGET ID:", "NONE"),
		callback = CoD.SpiderbotHud.Blink
	})
	table.insert(textOverlayContainer.updateRows, {
		self = f0_local0(Widget, 2, "TRAC-E", "INACTIVE"),
		callback = CoD.SpiderbotHud.Blink
	})
end

CoD.SpiderbotHud.AddCompass = function (f10_arg0, f10_arg1)
	local f10_local0 = 0.8
	local f10_local1 = 25
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234 * f10_local0, 234 * f10_local0)
	Widget:setTopBottom(false, false, -CoD.SpiderbotHud.TopBarHeight / 2 + CoD.SpiderbotHud.QuarterHeight + f10_local1, CoD.SpiderbotHud.TopBarHeight / 2 + CoD.SpiderbotHud.QuarterHeight + f10_local1)
	Widget:setAlpha(0.5)
	Widget:setImage(RegisterMaterial("hud_spiderbot_compass"))
	Widget:setShaderVector(0, f10_local0, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f10_arg1:addElement(Widget)
end

CoD.SpiderbotHud.AddChargers = function (HudRef, InstanceRef)
	local chargerLeftContainer = LUI.UIElement.new()
	chargerLeftContainer.id = chargerLeftContainer.id .. ".ChargerLeftContainer"
	InstanceRef:addElement(chargerLeftContainer)
	HudRef.chargerLeftContainer = chargerLeftContainer
	
	local f11_local1 = LUI.UIImage.new()
	f11_local1:setLeftRight(false, true, -CoD.SpiderbotHud.ChargerIconWidth, 0)
	f11_local1:setTopBottom(false, false, -CoD.SpiderbotHud.ChargerIconHeight / 2, CoD.SpiderbotHud.ChargerIconHeight / 2)
	f11_local1:setImage(CoD.SpiderbotHud.ChargerKeyLineMaterial)
	f11_local1.id = f11_local1.id .. ".ChargerLeftLine"
	chargerLeftContainer:addElement(f11_local1)
	local f11_local2 = CoD.SpiderbotHud.ChargerWidthOffset
	local f11_local3 = CoD.SpiderbotHud.ChargerHeightOffset
	
	local chargerLeftFill = LUI.UIImage.new()
	chargerLeftFill:setLeftRight(false, true, -CoD.SpiderbotHud.ChargerIconWidth + f11_local2, -f11_local2)
	chargerLeftFill:setTopBottom(false, true, -CoD.SpiderbotHud.ChargerIconHeight + f11_local3, -f11_local3)
	chargerLeftFill:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	chargerLeftFill:setAlpha(0.5)
	chargerLeftFill.id = chargerLeftFill.id .. ".ChargerLeftFill"
	chargerLeftContainer:addElement(chargerLeftFill)
	HudRef.chargerLeftFill = chargerLeftFill
	
	chargerLeftFill:registerEventHandler("change_topBottom", CoD.SpiderbotHud.Charger_ChangeTopBottom)
	local f11_local5 = 15
	local f11_local6 = 22
	
	local leftBoltArrow = LUI.UIImage.new()
	leftBoltArrow:setLeftRight(true, false, f11_local5, CoD.SpiderbotHud.BoltArrowWidth + f11_local5)
	leftBoltArrow:setTopBottom(false, true, -CoD.SpiderbotHud.ChargerIconHeight + f11_local3 - CoD.SpiderbotHud.BoltArrowHeight / 2, -CoD.SpiderbotHud.ChargerIconHeight + f11_local3 * 2 + CoD.SpiderbotHud.BoltArrowHeight / 2)
	leftBoltArrow:setImage(CoD.SpiderbotHud.BoltArrowMaterial)
	leftBoltArrow:setYRot(180)
	leftBoltArrow.id = leftBoltArrow.id .. ".LeftBoltArrow"
	chargerLeftContainer:addElement(leftBoltArrow)
	HudRef.leftBoltArrow = leftBoltArrow
	
	leftBoltArrow:registerEventHandler("change_topBottom", CoD.SpiderbotHud.BoltArrow_ChangeTopBottom)
	
	local chargerRightContainer = LUI.UIElement.new()
	chargerRightContainer.id = chargerRightContainer.id .. ".ChargerRightContainer"
	InstanceRef:addElement(chargerRightContainer)
	HudRef.chargerRightContainer = chargerRightContainer
	
	local f11_local9 = LUI.UIImage.new()
	f11_local9:setLeftRight(true, false, 0, CoD.SpiderbotHud.ChargerIconWidth)
	f11_local9:setTopBottom(false, false, -CoD.SpiderbotHud.ChargerIconHeight / 2, CoD.SpiderbotHud.ChargerIconHeight / 2)
	f11_local9:setImage(CoD.SpiderbotHud.ChargerKeyLineMaterial)
	f11_local9.id = f11_local9.id .. ".ChargerRightLine"
	chargerRightContainer:addElement(f11_local9)
	
	local chargerRightFill = LUI.UIImage.new()
	chargerRightFill:setLeftRight(true, false, f11_local2, CoD.SpiderbotHud.ChargerIconWidth - f11_local2)
	chargerRightFill:setTopBottom(false, true, -CoD.SpiderbotHud.ChargerIconHeight + f11_local3, -f11_local3)
	chargerRightFill:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	chargerRightFill:setAlpha(0.5)
	chargerRightFill.id = chargerRightFill.id .. ".ChargerRightFill"
	chargerRightContainer:addElement(chargerRightFill)
	HudRef.chargerRightFill = chargerRightFill
	
	chargerRightFill:registerEventHandler("change_topBottom", CoD.SpiderbotHud.Charger_ChangeTopBottom)
	
	local rightBoltArrow = LUI.UIImage.new()
	rightBoltArrow:setLeftRight(false, true, -CoD.SpiderbotHud.BoltArrowWidth - f11_local5, -f11_local5)
	rightBoltArrow:setTopBottom(false, true, -CoD.SpiderbotHud.ChargerIconHeight + f11_local3 - CoD.SpiderbotHud.BoltArrowHeight / 2, -CoD.SpiderbotHud.ChargerIconHeight + f11_local3 * 2 + CoD.SpiderbotHud.BoltArrowHeight / 2)
	rightBoltArrow:setImage(CoD.SpiderbotHud.BoltArrowMaterial)
	rightBoltArrow.id = rightBoltArrow.id .. ".RightBoltArrow"
	chargerRightContainer:addElement(rightBoltArrow)
	HudRef.rightBoltArrow = rightBoltArrow
	
	rightBoltArrow:registerEventHandler("change_topBottom", CoD.SpiderbotHud.BoltArrow_ChangeTopBottom)
end

CoD.SpiderbotHud.Charger_ChangeTopBottom = function (f12_arg0, f12_arg1)
	local f12_local0 = 0
	if f12_arg1.time then
		f12_local0 = f12_arg1.time
	end
	local f12_local1 = 1
	if f12_arg1.scale then
		f12_local1 = f12_arg1.scale
	end
	local f12_local2 = CoD.SpiderbotHud.ChargerHeightOffset
	local f12_local3 = -f12_local2 + f12_local1 * (-CoD.SpiderbotHud.ChargerIconHeight + 2 * f12_local2)
	f12_arg0:beginAnimation("grow", f12_local0)
	f12_arg0:setTopBottom(false, true, f12_local3, -f12_local2)
end

CoD.SpiderbotHud.BoltArrow_ChangeTopBottom = function (f13_arg0, f13_arg1)
	local f13_local0 = 0
	if f13_arg1.time then
		f13_local0 = f13_arg1.time
	end
	local f13_local1 = 1
	if f13_arg1.scale then
		f13_local1 = f13_arg1.scale
	end
	local f13_local2 = CoD.SpiderbotHud.ChargerHeightOffset
	local f13_local3 = -f13_local2 + f13_local1 * (-CoD.SpiderbotHud.ChargerIconHeight + 2 * f13_local2)
	f13_arg0:beginAnimation("grow", f13_local0)
	f13_arg0:setTopBottom(false, true, f13_local3 - CoD.SpiderbotHud.BoltArrowHeight / 2, f13_local3 - f13_local2 + CoD.SpiderbotHud.BoltArrowHeight / 2)
end

CoD.SpiderbotHud.VehicleTurretFire = function (f14_arg0, f14_arg1)
	local f14_local0 = f14_arg1.data[1]
	if f14_arg0.chargerLeftFill then
		f14_arg0.chargerLeftFill:processEvent({
			name = "change_topBottom",
			scale = 0,
			time = f14_local0
		})
		f14_arg0.chargerLeftFill:addElement(LUI.UITimer.new(f14_local0, "change_topBottom", true, f14_arg0.chargerLeftFill))
	end
	if f14_arg0.chargerRightFill then
		f14_arg0.chargerRightFill:processEvent({
			name = "change_topBottom",
			scale = 0,
			time = f14_local0
		})
		f14_arg0.chargerRightFill:addElement(LUI.UITimer.new(f14_local0, "change_topBottom", true, f14_arg0.chargerRightFill))
	end
	if f14_arg0.leftBoltArrow then
		f14_arg0.leftBoltArrow:processEvent({
			name = "change_topBottom",
			scale = 0,
			time = f14_local0
		})
		f14_arg0.leftBoltArrow:addElement(LUI.UITimer.new(f14_local0, "change_topBottom", true, f14_arg0.leftBoltArrow))
	end
	if f14_arg0.rightBoltArrow then
		f14_arg0.rightBoltArrow:processEvent({
			name = "change_topBottom",
			scale = 0,
			time = f14_local0
		})
		f14_arg0.rightBoltArrow:addElement(LUI.UITimer.new(f14_local0, "change_topBottom", true, f14_arg0.rightBoltArrow))
	end
end

CoD.SpiderbotHud.MoveToDefault = function (f15_arg0, f15_arg1)
	local f15_local0 = 0
	if f15_arg1.totalTime then
		f15_local0 = f15_arg1.totalTime
	end
	local f15_local1 = 1
	if f15_arg1.step then
		f15_local1 = f15_arg1.step
	end
	local f15_local2 = 0
	if f15_local1 == 1 then
		if f15_local0 == 0 then
			f15_arg0:setAlpha(0)
			f15_arg0.textOverlayContainer:setAlpha(0)
		else
			f15_arg0:flicker(0, 1, 0.6, 1, 150, 250)
		end
		local f15_local3 = f15_local0 / 5
		f15_local2 = f15_local3
		local f15_local4 = 0
		local f15_local5 = 70
		f15_arg0.leftTopQuarter:beginAnimation("move", f15_local3)
		f15_arg0.leftTopQuarter:setLeftRight(false, false, -CoD.SpiderbotHud.QuarterWidth, 0)
		f15_arg0.leftTopQuarter:setTopBottom(false, false, -CoD.SpiderbotHud.QuarterHeight - f15_local5, -f15_local5)
		f15_arg0.leftBottomQuarter:beginAnimation("move", f15_local3)
		f15_arg0.leftBottomQuarter:setLeftRight(false, false, -CoD.SpiderbotHud.QuarterWidth, 0)
		f15_arg0.leftBottomQuarter:setTopBottom(false, false, f15_local5, CoD.SpiderbotHud.QuarterHeight + f15_local5)
		f15_arg0.rightTopQuarter:beginAnimation("move", f15_local3)
		f15_arg0.rightTopQuarter:setLeftRight(false, false, 0, CoD.SpiderbotHud.QuarterWidth)
		f15_arg0.rightTopQuarter:setTopBottom(false, false, -CoD.SpiderbotHud.QuarterHeight - f15_local5, -f15_local5)
		f15_arg0.rightBottomQuarter:beginAnimation("move", f15_local3)
		f15_arg0.rightBottomQuarter:setLeftRight(false, false, 0, CoD.SpiderbotHud.QuarterWidth)
		f15_arg0.rightBottomQuarter:setTopBottom(false, false, f15_local5, CoD.SpiderbotHud.QuarterHeight + f15_local5)
	elseif f15_local1 == 2 then
		local f15_local3 = f15_local0 * 2 / 5
		f15_local2 = f15_local3
		local f15_local4 = 45
		f15_arg0.midLineContainer:beginAnimation("move", f15_local3)
		f15_arg0.midLineContainer:setZRot(0)
		f15_arg0.leftMidLine:beginAnimation("move", f15_local3)
		f15_arg0.leftMidLine:setLeftRight(false, false, -CoD.SpiderbotHud.MidLineWidth - f15_local4, -f15_local4)
		f15_arg0.leftMidLine:setTopBottom(false, false, -CoD.SpiderbotHud.MidLineHeight / 2, CoD.SpiderbotHud.MidLineHeight / 2)
		f15_arg0.rightMidLine:beginAnimation("move", f15_local3)
		f15_arg0.rightMidLine:setLeftRight(false, false, f15_local4, CoD.SpiderbotHud.MidLineWidth + f15_local4)
		f15_arg0.rightMidLine:setTopBottom(false, false, -CoD.SpiderbotHud.MidLineHeight / 2, CoD.SpiderbotHud.MidLineHeight / 2)
		f15_arg0.arrowContainer:beginAnimation("move", f15_local3)
		f15_arg0.arrowContainer:setLeftRight(false, false, -CoD.SpiderbotHud.ArrowContainerSize, CoD.SpiderbotHud.ArrowContainerSize)
		f15_arg0.arrowContainer:setTopBottom(false, false, -CoD.SpiderbotHud.ArrowContainerSize, CoD.SpiderbotHud.ArrowContainerSize)
	elseif f15_local1 == 3 then
		if f15_local0 ~= 0 then
			f15_arg0:processEvent({
				name = "close_flicker_timer"
			})
			f15_arg0.textOverlayContainer:flicker(0, 1, 0.6, 1, 150, 250)
		end
		local f15_local3 = f15_local0 / 5
		f15_local2 = f15_local3
		f15_arg0.chargerLeftContainer:beginAnimation("move", f15_local3)
		f15_arg0.chargerLeftContainer:setAlpha(1)
		f15_arg0.chargerRightContainer:beginAnimation("move", f15_local3)
		f15_arg0.chargerRightContainer:setAlpha(1)
		f15_arg0.arrowContainer:beginAnimation("move", f15_local3)
		f15_arg0.arrowContainer:setAlpha(1)
	elseif f15_local1 == 4 then
		local f15_local3 = f15_local0 / 5
		f15_local2 = f15_local3
		f15_arg0.arrowContainer:beginAnimation("move", f15_local3)
		f15_arg0.arrowContainer:setZRot(0)
		local f15_local4 = 30
		local f15_local5 = CoD.SpiderbotHud.ChargerIconWidth + CoD.SpiderbotHud.BoltArrowWidth
		f15_arg0.chargerLeftContainer:beginAnimation("move", f15_local3)
		f15_arg0.chargerLeftContainer:setLeftRight(false, false, -f15_local5 / 2 - CoD.SpiderbotHud.QuarterWidth, f15_local5 / 2 - CoD.SpiderbotHud.QuarterWidth)
		f15_arg0.chargerLeftContainer:setTopBottom(false, false, -CoD.SpiderbotHud.ChargerIconHeight / 2, CoD.SpiderbotHud.ChargerIconHeight / 2)
		f15_arg0.chargerRightContainer:beginAnimation("move", f15_local3)
		f15_arg0.chargerRightContainer:setLeftRight(false, false, -f15_local5 / 2 + CoD.SpiderbotHud.QuarterWidth, f15_local5 / 2 + CoD.SpiderbotHud.QuarterWidth)
		f15_arg0.chargerRightContainer:setTopBottom(false, false, -CoD.SpiderbotHud.ChargerIconHeight / 2, CoD.SpiderbotHud.ChargerIconHeight / 2)
		f15_arg0.chargerLeftFill:processEvent({
			name = "change_topBottom",
			scale = 1,
			time = f15_local3
		})
		f15_arg0.chargerRightFill:processEvent({
			name = "change_topBottom",
			scale = 1,
			time = f15_local3
		})
		f15_arg0.leftBoltArrow:processEvent({
			name = "change_topBottom",
			scale = 1,
			time = f15_local3
		})
		f15_arg0.rightBoltArrow:processEvent({
			name = "change_topBottom",
			scale = 1,
			time = f15_local3
		})
	else
		if f15_local0 == 0 then
			f15_arg0:setAlpha(1)
			f15_arg0.textOverlayContainer:setAlpha(1)
		else
			f15_arg0.textOverlayContainer:processEvent({
				name = "close_flicker_timer"
			})
		end
		return 
	end
	f15_arg0:addElement(LUI.UITimer.new(f15_local2, {
		name = "move_to_default",
		step = f15_local1 + 1,
		totalTime = f15_local0
	}, true, f15_arg0))
end

CoD.SpiderbotHud.MoveToBinkStart = function (f16_arg0)
	local f16_local0 = 0
	local f16_local1 = 0
	local f16_local2 = 70
	f16_arg0.leftTopQuarter:beginAnimation("move_to_start", f16_local0)
	f16_arg0.leftTopQuarter:setLeftRight(false, false, 0, 0)
	f16_arg0.leftTopQuarter:setTopBottom(false, false, 0, 0)
	f16_arg0.leftBottomQuarter:beginAnimation("move_to_start", f16_local0)
	f16_arg0.leftBottomQuarter:setLeftRight(false, false, 0, 0)
	f16_arg0.leftBottomQuarter:setTopBottom(false, false, 0, 0)
	f16_arg0.rightTopQuarter:beginAnimation("move_to_start", f16_local0)
	f16_arg0.rightTopQuarter:setLeftRight(false, false, 0, 0)
	f16_arg0.rightTopQuarter:setTopBottom(false, false, 0, 0)
	f16_arg0.rightBottomQuarter:beginAnimation("move_to_start", f16_local0)
	f16_arg0.rightBottomQuarter:setLeftRight(false, false, 0, 0)
	f16_arg0.rightBottomQuarter:setTopBottom(false, false, 0, 0)
	local f16_local3 = 45
	f16_arg0.midLineContainer:beginAnimation("move", f16_local0)
	f16_arg0.midLineContainer:setZRot(-45)
	f16_arg0.leftMidLine:beginAnimation("move_to_start", f16_local0)
	f16_arg0.leftMidLine:setLeftRight(false, false, -f16_local3, -f16_local3)
	f16_arg0.rightMidLine:beginAnimation("move_to_start", f16_local0)
	f16_arg0.rightMidLine:setLeftRight(false, false, f16_local3, f16_local3)
	f16_arg0.arrowContainer:beginAnimation("move_to_start", f16_local0)
	f16_arg0.arrowContainer:setZRot(135)
	f16_arg0.arrowContainer:setAlpha(0)
	local f16_local4 = 30
	local f16_local5 = CoD.SpiderbotHud.ChargerIconWidth + CoD.SpiderbotHud.BoltArrowWidth
	local f16_local6 = CoD.SpiderbotHud.QuarterWidth * 1.2
	f16_arg0.chargerLeftContainer:beginAnimation("move_to_start", f16_local0)
	f16_arg0.chargerLeftContainer:setLeftRight(false, false, -f16_local5 / 2 - f16_local6, f16_local5 / 2 - f16_local6)
	f16_arg0.chargerLeftContainer:setTopBottom(false, false, -CoD.SpiderbotHud.ChargerIconHeight / 2, CoD.SpiderbotHud.ChargerIconHeight / 2)
	f16_arg0.chargerLeftContainer:setAlpha(0)
	f16_arg0.chargerRightContainer:beginAnimation("move_to_start", f16_local0)
	f16_arg0.chargerRightContainer:setLeftRight(false, false, -f16_local5 / 2 + f16_local6, f16_local5 / 2 + f16_local6)
	f16_arg0.chargerRightContainer:setTopBottom(false, false, -CoD.SpiderbotHud.ChargerIconHeight / 2, CoD.SpiderbotHud.ChargerIconHeight / 2)
	f16_arg0.chargerRightContainer:setAlpha(0)
	f16_arg0.chargerLeftFill:processEvent({
		name = "change_topBottom",
		scale = 0,
		time = f16_local0
	})
	f16_arg0.chargerRightFill:processEvent({
		name = "change_topBottom",
		scale = 0,
		time = f16_local0
	})
	f16_arg0.leftBoltArrow:processEvent({
		name = "change_topBottom",
		scale = 0,
		time = f16_local0
	})
	f16_arg0.rightBoltArrow:processEvent({
		name = "change_topBottom",
		scale = 0,
		time = f16_local0
	})
	f16_arg0.textOverlayContainer:beginAnimation("move", 0)
	f16_arg0.textOverlayContainer:setAlpha(0)
end

CoD.SpiderbotHud.BinkSequence = function (f17_arg0, f17_arg1)
	f17_arg0:moveToBinkStart()
	f17_arg0:addElement(LUI.UITimer.new(500, {
		name = "move_to_default",
		totalTime = 3500
	}, true, f17_arg0))
end

CoD.SpiderbotHud.BigEyeToSmallEyeRatio = 0.6
CoD.SpiderbotHud.EyeScanCircleSize = 270
CoD.SpiderbotHud.BlurShapeWidth = CoD.SpiderbotHud.EyeScanCircleSize
CoD.SpiderbotHud.BlurShapeHeight = CoD.SpiderbotHud.BlurShapeWidth / 2
CoD.SpiderbotHud.SmallEyeSize = CoD.SpiderbotHud.EyeScanCircleSize * CoD.SpiderbotHud.BigEyeToSmallEyeRatio
CoD.SpiderbotHud.CircleBarSize = CoD.SpiderbotHud.SmallEyeSize * 1.3
CoD.SpiderbotHud.RedDotSize = 20
CoD.SpiderbotHud.RedDotSmallSize = 15
CoD.SpiderbotHud.EyescanEventBegin = function (f18_arg0, f18_arg1)
	CoD.SpiderbotHud.BlurCircleMaterial = RegisterMaterial("hud_eyescan_blur_circle")
	CoD.SpiderbotHud.BlurShapeMaterial = RegisterMaterial("hud_eyescan_blur_shape")
	CoD.SpiderbotHud.CircleMeterMaterial = RegisterMaterial("hud_eyescan_circle_meter")
	CoD.SpiderbotHud.EyeShapeMaterial = RegisterMaterial("hud_eyescan_retina")
	CoD.SpiderbotHud.EyeScanLinesMaterial = RegisterMaterial("hud_eyescan_lines")
	CoD.SpiderbotHud.HoneyCombMaterial = RegisterMaterial("hud_eyescan_honeycomb")
	CoD.SpiderbotHud.RedDotMaterial = RegisterMaterial("hud_eyescan_red_dot")
	CoD.SpiderbotHud.RedDotSmallMaterial = RegisterMaterial("hud_eyescan_yellow_dot")
	CoD.SpiderbotHud.RotateCircleMaterial = RegisterMaterial("hud_eyescan_rotate_circle")
	local f18_local0 = f18_arg0.hudContainer
	f18_local0.crosshair:setAlpha(0)
	f18_local0.leftSideArrow:setAlpha(0)
	f18_local0.rightSideArrow:setAlpha(0)
	local f18_local1 = -15
	local f18_local2 = CoD.SpiderbotHud.QuarterWidth / 2 + CoD.SpiderbotHud.SmallEyeSize + -115
	local f18_local3 = CoD.SpiderbotHud.QuarterHeight / 4 + f18_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, f18_local2, CoD.SpiderbotHud.SmallEyeSize + f18_local2)
	Widget:setTopBottom(false, false, -CoD.SpiderbotHud.SmallEyeSize - f18_local3, -f18_local3)
	Widget.id = Widget.id .. ".SmallEyeContainer"
	f18_local0:addElement(Widget)
	Widget:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	f18_local0.smallEyeContainer = Widget
	
	local bigCircleContainer = LUI.UIElement.new()
	bigCircleContainer:setLeftRight(false, false, -CoD.SpiderbotHud.EyeScanCircleSize / 2, CoD.SpiderbotHud.EyeScanCircleSize / 2)
	bigCircleContainer:setTopBottom(false, false, -CoD.SpiderbotHud.EyeScanCircleSize / 2, CoD.SpiderbotHud.EyeScanCircleSize / 2)
	bigCircleContainer.id = bigCircleContainer.id .. ".BigCircleContainer"
	bigCircleContainer:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	f18_local0:addElement(bigCircleContainer)
	f18_local0.bigCircleContainer = bigCircleContainer
	
	local f18_local6 = LUI.UIImage.new()
	f18_local6:setLeftRight(true, true, 0, 0)
	f18_local6:setTopBottom(true, true, 0, 0)
	f18_local6:setImage(CoD.SpiderbotHud.BlurCircleMaterial)
	f18_local6.id = f18_local6.id .. ".BlurCircle"
	bigCircleContainer:addElement(f18_local6)
	local f18_local7 = LUI.UIImage.new()
	f18_local7:setLeftRight(true, true, 0, 0)
	f18_local7:setTopBottom(true, true, 0, 0)
	f18_local7:setImage(CoD.SpiderbotHud.EyeScanLinesMaterial)
	f18_local7.id = f18_local7.id .. ".CircleLines"
	local f18_local8 = LUI.UIImage.new()
	f18_local8:setLeftRight(false, false, -2 * CoD.SpiderbotHud.EyeScanCircleSize / 5, 2 * CoD.SpiderbotHud.EyeScanCircleSize / 5)
	f18_local8:setTopBottom(false, false, -2 * CoD.SpiderbotHud.EyeScanCircleSize / 5, 2 * CoD.SpiderbotHud.EyeScanCircleSize / 5)
	f18_local8:setImage(CoD.SpiderbotHud.HoneyCombMaterial)
	f18_local8:setAlpha(0.4)
	f18_local8.id = f18_local8.id .. ".HoneyComb"
	bigCircleContainer:addElement(f18_local8)
	local f18_local9 = 25
	local f18_local10 = LUI.UIImage.new()
	f18_local10:setLeftRight(true, true, f18_local9, -f18_local9)
	f18_local10:setTopBottom(true, true, f18_local9, -f18_local9)
	f18_local10:setImage(CoD.SpiderbotHud.RotateCircleMaterial)
	f18_local10:setAlpha(0.25)
	f18_local10.id = f18_local10.id .. ".RotateCircle"
	bigCircleContainer:addElement(f18_local10)
	f18_local10:registerAnimationState("rotate_0", {
		zRot = 0
	})
	f18_local10:registerAnimationState("rotate_360", {
		zRot = -360
	})
	f18_local10:registerEventHandler("transition_complete_rotate_0", function (f35_arg0, f35_arg1)
		if not f35_arg1.interrupted then
			f35_arg0:animateToState("rotate_360", 1500)
		end
	end)
	f18_local10:registerEventHandler("transition_complete_rotate_360", function (f36_arg0, f36_arg1)
		if not f36_arg1.interrupted then
			f36_arg0:animateToState("rotate_0")
		end
	end)
	f18_local10:animateToState("rotate_0")
	local f18_local11 = LUI.UIImage.new()
	f18_local11:setLeftRight(false, false, -CoD.SpiderbotHud.BlurShapeWidth / 2, CoD.SpiderbotHud.BlurShapeWidth / 2)
	f18_local11:setTopBottom(true, false, -CoD.SpiderbotHud.BlurShapeHeight / 2, CoD.SpiderbotHud.BlurShapeHeight / 2)
	f18_local11:setImage(CoD.SpiderbotHud.BlurShapeMaterial)
	f18_local11:setAlpha(0.5)
	f18_local11.id = f18_local11.id .. ".ScanBlur"
	f18_local11:registerAnimationState("scan_top", {
		topAnchor = true,
		bottomAnchor = false,
		top = -CoD.SpiderbotHud.BlurShapeHeight / 2,
		bottom = CoD.SpiderbotHud.BlurShapeHeight / 2,
		alpha = 0.2
	})
	f18_local11:registerAnimationState("scan_bottom", {
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.SpiderbotHud.BlurShapeHeight,
		bottom = 20,
		alpha = 0.2
	})
	f18_local11:registerEventHandler("transition_complete_scan_bottom", function (f37_arg0, f37_arg1)
		if not f37_arg1.interrupted then
			f37_arg0:animateToState("scan_top", 1250)
		end
	end)
	f18_local11:registerEventHandler("blur_scan_update", CoD.SpiderbotHud.BlurScanUpdate)
	f18_local0.scanBlur = f18_local11
	local f18_local12 = LUI.UIImage.new()
	f18_local12:setLeftRight(true, true, 0, 0)
	f18_local12:setTopBottom(true, true, 0, 0)
	f18_local12:setImage(CoD.SpiderbotHud.EyeShapeMaterial)
	f18_local12:setAlpha(0.8)
	f18_local12.id = f18_local12.id .. ".SmallEyeShape"
	Widget:addElement(f18_local12)
	f18_local0:registerEventHandler("progress_scan", CoD.SpiderbotHud.ScanProgress)
	f18_local0:registerEventHandler("progress_update", CoD.SpiderbotHud.UpdateScanPercent)
	local f18_local13 = -15
	local f18_local14 = CoD.SpiderbotHud.QuarterWidth / 2 + CoD.SpiderbotHud.SmallEyeSize + -115
	local f18_local15 = CoD.SpiderbotHud.QuarterHeight / 4 + f18_local13
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, f18_local14 - 25, CoD.SpiderbotHud.SmallEyeSize + f18_local14 + 25)
	Widget:setTopBottom(false, false, -CoD.SpiderbotHud.SmallEyeSize - f18_local15 - 25, -f18_local15 + 25)
	Widget.id = Widget.id .. ".SmallCombContainer"
	f18_local0:addElement(Widget)
	Widget:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	f18_local0.smallCombContainer = Widget
	local f18_local17 = LUI.UIImage.new()
	f18_local17:setLeftRight(true, true, 0, 0)
	f18_local17:setTopBottom(true, true, 0, 0)
	f18_local17:setAlpha(0.4)
	f18_local17:setImage(CoD.SpiderbotHud.HoneyCombMaterial)
	f18_local17.id = f18_local17.id .. ".CombEyeShape"
	Widget:addElement(f18_local17)
	f18_local17:registerAnimationState("pulse_scanning_text", {
		alpha = 0.4
	})
	f18_local17:registerAnimationState("pulse_scanning_text_transparent", {
		alpha = 0.2
	})
	f18_local17:registerEventHandler("transition_complete_pulse_scanning_text", function (f38_arg0, f38_arg1)
		if not f38_arg1.interrupted then
			f38_arg0:animateToState("pulse_scanning_text_transparent", 1250)
		end
	end)
	f18_local17:registerEventHandler("transition_complete_pulse_scanning_text_transparent", function (f39_arg0, f39_arg1)
		if not f39_arg1.interrupted then
			f39_arg0:animateToState("pulse_scanning_text", 1250)
		end
	end)
	local f18_local18 = 0
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.SpiderbotHud.CircleBarSize / 2 + f18_local18, CoD.SpiderbotHud.CircleBarSize / 2 + f18_local18)
	Widget:setTopBottom(false, false, -CoD.SpiderbotHud.CircleBarSize / 2, CoD.SpiderbotHud.CircleBarSize / 2)
	Widget.id = Widget.id .. ".CircleBarContainer"
	Widget:addElement(Widget)
	local f18_local20 = LUI.UIImage.new()
	f18_local20:setLeftRight(true, true, 0, 0)
	f18_local20:setTopBottom(true, true, 0, 0)
	f18_local20:setImage(CoD.SpiderbotHud.CircleMeterMaterial)
	f18_local20:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	f18_local20:setAlpha(0.15)
	f18_local20:setShaderVector(0, 0.5, 0, 0, 0)
	f18_local20.id = f18_local20.id .. ".CircleBarEmtpy"
	Widget:addElement(f18_local20)
	
	local circleBarFill = LUI.UIImage.new()
	circleBarFill:setLeftRight(true, true, 0, 0)
	circleBarFill:setTopBottom(true, true, 0, 0)
	circleBarFill:setImage(CoD.SpiderbotHud.CircleMeterMaterial)
	circleBarFill:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	circleBarFill:setAlpha(0.55)
	circleBarFill:setXRot(180)
	circleBarFill:setShaderVector(0, 0.35, 0, 0, 0)
	circleBarFill.id = circleBarFill.id .. ".CircleBarFill"
	Widget:addElement(circleBarFill)
	f18_local0.circleBarFill = circleBarFill
	
	local f18_local22 = LUI.UIText.new()
	local f18_local23 = 2
	f18_local22:setLeftRight(false, false, -CoD.SpiderbotHud.SmallEyeSize / 14, -CoD.SpiderbotHud.SmallEyeSize / 14)
	f18_local22:setTopBottom(false, false, CoD.SpiderbotHud.SmallEyeSize / 2 - f18_local23, CoD.textSize.Condensed * 1.2 + CoD.SpiderbotHud.SmallEyeSize / 2 - f18_local23)
	f18_local22:setFont(CoD.fonts.Condensed)
	f18_local22:setAlignment(LUI.Alignment.Right)
	f18_local22:setRGB(CoD.SpiderbotHud.PercentColor.r, CoD.SpiderbotHud.PercentColor.g, CoD.SpiderbotHud.PercentColor.b)
	f18_local22:setAlpha(CoD.SpiderbotHud.FontAlpha)
	f18_local22.id = f18_local22.id .. ".ScanPercentText"
	Widget:addElement(f18_local22)
	f18_local22:setText("0%")
	f18_local0.scanPercentText = f18_local22
	local f18_local24 = LUI.UIText.new()
	f18_local24.scanningTextFont = "Default"
	f18_local24.scanningFont = CoD.fonts[f18_local24.scanningTextFont]
	f18_local24.localizedScanningText = Engine.Localize("MENU_SCANNING_CAPS")
	f18_local24.fontSize = CoD.textSize[f18_local24.scanningTextFont]
	f18_local24.metrics = {}
	local f18_local25 = f18_local24.metrics
	local f18_local26 = f18_local24.metrics
	local f18_local27 = f18_local24.metrics
	local f18_local28 = f18_local24.metrics
	local f18_local29, f18_local30, f18_local31, f18_local32 = GetTextDimensions(f18_local24.localizedScanningText, f18_local24.scanningFont, f18_local24.fontSize)
	f18_local28.textBottom = f18_local32
	f18_local27.textRight = f18_local31
	f18_local26.textTop = f18_local30
	f18_local25.textLeft = f18_local29
	f18_local24:setLeftRight(false, false, -f18_local24.metrics.textRight / 2, -f18_local24.metrics.textRight / 2)
	f18_local24:setTopBottom(false, false, CoD.SpiderbotHud.EyeScanCircleSize / 2 - f18_local24.metrics.textTop / 4, CoD.SpiderbotHud.EyeScanCircleSize / 2 + 3 * f18_local24.metrics.textTop / 4)
	f18_local24:setFont(f18_local24.scanningFont)
	f18_local24:setRGB(CoD.SpiderbotHud.ScanningColor.r, CoD.SpiderbotHud.ScanningColor.g, CoD.SpiderbotHud.ScanningColor.b)
	f18_local24:setAlpha(CoD.SpiderbotHud.FontAlpha)
	f18_local24.id = f18_local24.id .. ".ScanningText"
	f18_local24:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	Widget:addElement(f18_local24)
	f18_local24:setText(Engine.Localize("MENU_SCANNING_CAPS"))
	f18_local24:registerAnimationState("pulse_scanning_text", {
		alpha = CoD.SpiderbotHud.FontAlpha
	})
	f18_local24:registerAnimationState("pulse_scanning_text_transparent", {
		alpha = 0.1
	})
	f18_local24:registerEventHandler("transition_complete_pulse_scanning_text", function (f40_arg0, f40_arg1)
		if not f40_arg1.interrupted then
			f40_arg0:animateToState("pulse_scanning_text_transparent", 400)
		end
	end)
	f18_local24:registerEventHandler("transition_complete_pulse_scanning_text_transparent", function (f41_arg0, f41_arg1)
		if not f41_arg1.interrupted then
			f41_arg0:animateToState("pulse_scanning_text", 400)
		end
	end)
	f18_local0.scanningText = f18_local24
	f18_local25 = LUI.UIText.new()
	f18_local25.matchingTextFont = "Default"
	f18_local25.matchingFont = CoD.fonts[f18_local25.matchingTextFont]
	f18_local25.fontSize = CoD.textSize[f18_local25.matchingTextFont]
	f18_local25.localizedMatchingText = Engine.Localize("MENU_MATCHING_CAPS")
	f18_local25.metrics = {}
	f18_local26 = f18_local25.metrics
	f18_local27 = f18_local25.metrics
	f18_local28 = f18_local25.metrics
	f18_local29 = f18_local25.metrics
	local f18_local30, f18_local31, f18_local32, f18_local33 = GetTextDimensions("0/5" .. f18_local25.localizedMatchingText, f18_local25.matchingFont, f18_local25.fontSize)
	f18_local29.textBottom = f18_local33
	f18_local28.textRight = f18_local32
	f18_local27.textTop = f18_local31
	f18_local26.textLeft = f18_local30
	f18_local25:setLeftRight(false, false, -2 * f18_local25.metrics.textRight / 3, 0)
	f18_local25:setTopBottom(false, false, CoD.SpiderbotHud.EyeScanCircleSize / 2 + 2 * f18_local25.metrics.textTop / 3, CoD.SpiderbotHud.EyeScanCircleSize / 2 + 5 * f18_local25.metrics.textTop / 3)
	f18_local25:setFont(CoD.fonts.Default)
	f18_local25:setRGB(CoD.SpiderbotHud.ScanningColor.r, CoD.SpiderbotHud.ScanningColor.g, CoD.SpiderbotHud.ScanningColor.b)
	f18_local25:setAlpha(CoD.SpiderbotHud.FontAlpha)
	f18_local25.id = f18_local25.id .. ".MatchingText"
	Widget:addElement(f18_local25)
	f18_local25:registerEventHandler("matching_text", CoD.SpiderbotHud.MatchingText)
	f18_local25:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	f18_local25:setText("0/5 " .. f18_local25.localizedMatchingText)
	f18_local0.matchingText = f18_local25
	CoD.SpiderbotHud.AddRedDots(bigCircleContainer, Widget, 1, -60, -40)
	CoD.SpiderbotHud.AddLines(bigCircleContainer, 1, 70, -100, 403, 17)
	CoD.SpiderbotHud.AddRedDots(bigCircleContainer, Widget, 2, -40, 25)
	CoD.SpiderbotHud.AddLines(bigCircleContainer, 2, 85, -43, 406, 19)
	CoD.SpiderbotHud.AddRedDots(bigCircleContainer, Widget, 3, 30, 55)
	CoD.SpiderbotHud.AddLines(bigCircleContainer, 3, 150, -16, 395, 21)
	CoD.SpiderbotHud.AddRedDots(bigCircleContainer, Widget, 4, 70, 10)
	CoD.SpiderbotHud.AddLines(bigCircleContainer, 4, 193, -55, 380, 20)
	CoD.SpiderbotHud.AddRedDots(bigCircleContainer, Widget, 5, 20, -80)
	CoD.SpiderbotHud.AddLines(bigCircleContainer, 5, 146, -135, 383, 16)
	f18_local0.bar1 = CoD.SpiderbotHud.AddEyeScanBars(f18_local0, 1, 0.5, 0.85, -5, -3, 0, -90)
	f18_local0.bar2 = CoD.SpiderbotHud.AddEyeScanBars(f18_local0, 2, 0.5, 0.85, 0, 2, 0, -90)
	f18_local0.bar3 = CoD.SpiderbotHud.AddEyeScanBars(f18_local0, 3, -0.85, -0.5, -5, -3, 90, 0)
	f18_local0.bar4 = CoD.SpiderbotHud.AddEyeScanBars(f18_local0, 4, -0.85, -0.5, 0, 2, 90, 0)
	f18_local0.signalBar1 = CoD.SpiderbotHud.AddSignalBar(f18_local0, 1, 0, 1)
	f18_local0.signalBar2 = CoD.SpiderbotHud.AddSignalBar(f18_local0, 2, 7, 0.7)
	f18_local0.signalBar3 = CoD.SpiderbotHud.AddSignalBar(f18_local0, 3, 14, 0.4)
	f18_local0:processEvent({
		name = "progress_scan"
	})
end

CoD.SpiderbotHud.ScanNumbers = function (f19_arg0, f19_arg1)
	f19_arg0.testTime = f19_arg0.testTime + f19_arg1.timeElapsed
	local f19_local0 = f19_arg0.testTime / CoD.SpiderbotHud.TextScanDuration
	if f19_local0 > 1 then
		f19_arg1.timer:close()
		f19_local0 = 1
	end
	f19_arg0:setText(12345.68 * f19_local0)
end

CoD.SpiderbotHud.AddSignalBar = function (f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	local f20_local0 = CoD.SpiderbotHud.MidLineWidth / 2 - 40
	local f20_local1 = -25
	local f20_local2 = LUI.UIImage.new()
	f20_local2:setLeftRight(true, false, f20_local0 + f20_arg2, f20_local0 + f20_arg2 + 4)
	f20_local2:setTopBottom(false, false, f20_local1 * f20_arg3, f20_local1 + 20)
	f20_local2:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	f20_local2:setAlpha(0.5)
	f20_arg0:addElement(f20_local2)
	f20_local2.id = f20_local2.id .. ".SignalBar_" .. f20_arg1
	f20_local2:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	return f20_local2
end

CoD.SpiderbotHud.AddEyeScanBars = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4, f21_arg5, f21_arg6, f21_arg7)
	local f21_local0 = 20
	local f21_local1 = LUI.UIImage.new()
	f21_local1:setLeftRight(false, false, (CoD.SpiderbotHud.EyeScanCircleSize + f21_local0) * f21_arg2, (CoD.SpiderbotHud.EyeScanCircleSize + f21_local0) * f21_arg3)
	f21_local1:setTopBottom(false, false, 2 * f21_arg4, 2 * f21_arg5)
	f21_local1:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	f21_local1:setAlpha(0.5)
	f21_arg0:addElement(f21_local1)
	f21_local1.id = f21_local1.id .. ".Bar_" .. f21_arg1
	f21_local1:registerAnimationState("bar_short", {
		leftAnchor = false,
		rightAnchor = false,
		left = (CoD.SpiderbotHud.EyeScanCircleSize + f21_local0) * f21_arg2,
		right = (CoD.SpiderbotHud.EyeScanCircleSize + f21_local0) * f21_arg3
	})
	f21_local1:registerAnimationState("bar_wide", {
		leftAnchor = false,
		rightAnchor = false,
		left = (CoD.SpiderbotHud.EyeScanCircleSize + f21_local0) * f21_arg2 + f21_arg6,
		right = (CoD.SpiderbotHud.EyeScanCircleSize + f21_local0) * f21_arg3 + f21_arg7
	})
	f21_local1:registerAnimationState("bar_hide", {
		alpha = 0
	})
	f21_local1:registerEventHandler("transition_complete_bar_short", CoD.SpiderbotHud.BarShort)
	f21_local1:registerEventHandler("transition_complete_bar_wide", CoD.SpiderbotHud.BarWide)
	f21_local1:registerEventHandler("hide_scan_elem", CoD.SpiderbotHud.HudContainer_HideAnim)
	return f21_local1
end

CoD.SpiderbotHud.BarShort = function (f22_arg0, f22_arg1)
	if not f22_arg1.interrupted then
		f22_arg0:animateToState("bar_wide", math.random(3, 7) * 250)
	end
end

CoD.SpiderbotHud.BarWide = function (f23_arg0, f23_arg1)
	if not f23_arg1.interrupted then
		f23_arg0:animateToState("bar_short", math.random(3, 7) * 100)
	end
end

CoD.SpiderbotHud.AddRedDots = function (f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
	local f24_local0 = LUI.UIImage.new()
	f24_local0:setLeftRight(false, false, -CoD.SpiderbotHud.RedDotSize / 2 + f24_arg3, CoD.SpiderbotHud.RedDotSize / 2 + f24_arg3)
	f24_local0:setTopBottom(false, false, -CoD.SpiderbotHud.RedDotSize / 2 + f24_arg4, CoD.SpiderbotHud.RedDotSize / 2 + f24_arg4)
	f24_local0:setImage(CoD.SpiderbotHud.RedDotMaterial)
	f24_local0:setAlpha(0)
	f24_local0.id = f24_local0.id .. ".RedDot_" .. f24_arg2
	f24_arg0:addElement(f24_local0)
	f24_local0:registerAnimationState("show_dot" .. f24_arg2, {
		alpha = 1
	})
	local f24_local1 = 0.75
	local f24_local2 = LUI.UIImage.new()
	f24_local2:setLeftRight(false, false, -CoD.SpiderbotHud.RedDotSmallSize / 2 + f24_arg3 * f24_local1, CoD.SpiderbotHud.RedDotSmallSize / 2 + f24_arg3 * f24_local1)
	f24_local2:setTopBottom(false, false, -CoD.SpiderbotHud.RedDotSmallSize / 2 + f24_arg4 * f24_local1, CoD.SpiderbotHud.RedDotSmallSize / 2 + f24_arg4 * f24_local1)
	f24_local2:setImage(CoD.SpiderbotHud.RedDotSmallMaterial)
	f24_local2:setAlpha(0)
	f24_local2.id = f24_local2.id .. ".RedDotSmall_" .. f24_arg2
	f24_arg1:addElement(f24_local2)
	f24_local2:registerAnimationState("show_dotSmall" .. f24_arg2, {
		alpha = 0.3
	})
end

CoD.SpiderbotHud.AddLines = function (f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4, f25_arg5)
	local f25_local0 = LUI.UIImage.new()
	f25_local0:setLeftRight(true, false, f25_arg2, f25_arg2 + f25_arg4)
	f25_local0:setTopBottom(false, false, f25_arg3, f25_arg3 + 1)
	f25_local0:setRGB(CoD.SpiderbotHud.BaseColor.r, CoD.SpiderbotHud.BaseColor.g, CoD.SpiderbotHud.BaseColor.b)
	f25_local0:setAlpha(0)
	f25_local0:setZRot(f25_arg5)
	f25_local0.id = f25_local0.id .. ".Line_" .. f25_arg1
	f25_arg0:addElement(f25_local0)
	f25_local0:registerAnimationState("show_dotLine" .. f25_arg1, {
		alpha = 0.6
	})
end

CoD.SpiderbotHud.BlurScanUpdate = function (f26_arg0, f26_arg1)
	if f26_arg0.scanCount >= 1 then
		f26_arg1.timer:close()
		f26_arg0:registerAnimationState("fade_scan", {
			topAnchor = false,
			bottomAnchor = false,
			top = 0,
			bottom = 0,
			alpha = 0
		})
		f26_arg0:animateToState("fade_scan")
	else
		f26_arg0.scanCount = f26_arg0.scanCount + 1
		f26_arg0:animateToState("scan_bottom", 1250)
	end
end

local f0_local1 = function (f27_arg0, f27_arg1)
	local f27_local0 = math.ceil(f27_arg1.interval / 3)
	f27_arg0:addElement(LUI.UITimer.new(f27_arg1.delayTime, {
		name = "animate",
		animationStateName = "show_dot" .. f27_arg1.number,
		duration = 0
	}, true, f27_arg0))
	f27_arg0:addElement(LUI.UITimer.new(f27_arg1.delayTime + f27_local0, {
		name = "animate",
		animationStateName = "show_dotLine" .. f27_arg1.number,
		duration = f27_local0
	}, true, f27_arg0))
	f27_arg0:addElement(LUI.UITimer.new(f27_arg1.delayTime + f27_local0, {
		name = "animate",
		animationStateName = "show_dotSmall" .. f27_arg1.number,
		duration = 0
	}, true, f27_arg0))
	f27_arg0:addElement(LUI.UITimer.new(f27_arg1.delayTime + f27_local0, {
		name = "matching_text",
		text = string.format("%i/5 %s", f27_arg1.number, Engine.Localize("MENU_MATCHING_CAPS"))
	}, true, f27_arg0.matchingText))
end

CoD.SpiderbotHud.ScanProgress = function (f28_arg0, f28_arg1)
	f28_arg0.scanTime = {}
	f28_arg0.scanTime.totalTime = 4250
	f28_arg0.scanTime.minimum = 400
	f28_arg0.scanTime.maximum = 1000
	f28_arg0.scanTime.updateInterval = 33
	f28_arg0.currentPercentage = 0
	f28_arg0:addElement(LUI.UITimer.new(f28_arg0.scanTime.updateInterval, "progress_update", false, f28_arg0))
	f28_arg0.scanBlur.scanCount = 0
	f28_arg0.scanBlur:animateToState("scan_bottom", 1250)
	f28_arg0.scanBlur:addElement(LUI.UITimer.new(2500, "blur_scan_update", false, f28_arg0.scanBlur))
	f28_arg0.scanTime.dot = {}
	f28_arg0.scanTime.dot.dots = 5
	local f28_local0 = f28_arg0.scanTime.totalTime - f28_arg0.scanTime.minimum * f28_arg0.scanTime.dot.dots
	for f28_local1 = 1, f28_arg0.scanTime.dot.dots - 1, 1 do
		f28_arg0.scanTime.dot[f28_local1] = {}
		f28_arg0.scanTime.dot[f28_local1].time = math.random(0, math.min(f28_arg0.scanTime.maximum, f28_local0))
		f28_local0 = f28_local0 - f28_arg0.scanTime.dot[f28_local1].time
		f28_arg0.scanTime.dot[f28_local1].time = f28_arg0.scanTime.dot[f28_local1].time + f28_arg0.scanTime.minimum
	end
	f28_arg0.scanTime.dot[5] = {}
	f28_arg0.scanTime.dot[5].time = f28_arg0.scanTime.minimum + f28_local0
	local f28_local1 = 0
	for f28_local2 = 1, 5, 1 do
		f28_local1 = f28_local1 + f28_arg0.scanTime.dot[f28_local2].time
		f0_local1(f28_arg0, {
			delayTime = f28_local1,
			interval = f28_arg0.scanTime.dot[f28_local2].time,
			number = f28_local2
		})
	end
	f28_arg0:dispatchEventToChildren({
		name = "animate",
		animationStateName = "bar_wide"
	})
	f28_arg0:dispatchEventToChildren({
		name = "animate",
		animationStateName = "pulse_scanning_text"
	})
end

CoD.SpiderbotHud.UpdateScanPercent = function (f29_arg0, f29_arg1)
	if f29_arg0.scanPercentText and f29_arg0.circleBarFill and f29_arg0.scanBlur then
		if f29_arg0.currentPercentage >= 100 then
			f29_arg1.timer:close()
			f29_arg0.scanPercentText:setText("100%")
			f29_arg0.circleBarFill:beginAnimation("progress")
			f29_arg0.circleBarFill:setShaderVector(0, 0.5, 0, 0, 0)
			f29_arg0:dispatchEventToChildren({
				name = "animate",
				animationStateName = "bar_hide",
				duration = 250
			})
		else
			if f29_arg0.scanTime.currentTime == nil then
				f29_arg0.scanTime.currentTime = 0
				f29_arg0.scanTime.endtime = f29_arg0.scanTime.totalTime * 1.2
				f29_arg0.scanTime.intervals = table.getn(f29_arg0.scanTime.dot)
				f29_arg0.scanTime.interval = 1
				f29_arg0.scanTime.intervalPercentage = 100 / f29_arg0.scanTime.intervals
				f29_arg0.scanTime.intervalGrowthRate = f29_arg0.scanTime.intervalPercentage / f29_arg0.scanTime.dot[f29_arg0.scanTime.interval].time * f29_arg0.scanTime.updateInterval
			end
			f29_arg0.scanTime.currentTime = f29_arg0.scanTime.currentTime + f29_arg0.scanTime.updateInterval
			f29_arg0.scanPercentText:setText(math.ceil(f29_arg0.currentPercentage) .. "%")
			f29_arg0.circleBarFill:beginAnimation("progress")
			f29_arg0.circleBarFill:setShaderVector(0, f29_arg0.currentPercentage * 0, 0, 0, 0)
			if f29_arg0.scanTime.intervalPercentage * f29_arg0.scanTime.interval <= f29_arg0.currentPercentage then
				f29_arg0.scanTime.interval = f29_arg0.scanTime.interval + 1
				f29_arg0.scanTime.intervalGrowthRate = f29_arg0.scanTime.intervalPercentage / f29_arg0.scanTime.dot[f29_arg0.scanTime.interval].time * f29_arg0.scanTime.updateInterval
			end
			f29_arg0.currentPercentage = f29_arg0.currentPercentage + f29_arg0.scanTime.intervalGrowthRate
		end
	end
end

CoD.SpiderbotHud.MatchingText = function (f30_arg0, f30_arg1)
	if not f30_arg1.text then
		f30_arg0:animateToState("default")
		f30_arg0:setText("")
		return 
	else
		f30_arg0:setText(f30_arg1.text)
	end
end

CoD.SpiderbotHud.EyescanEventEnd = function (f31_arg0, f31_arg1)
	f31_arg0.hudContainer:dispatchEventToChildren({
		name = "show_elem"
	})
	f31_arg0.hudContainer:dispatchEventToChildren({
		name = "hide_scan_elem"
	})
end

CoD.SpiderbotHud.HudContainer_HideAnim = function (f32_arg0, f32_arg1)
	f32_arg0:setAlpha(0)
end

CoD.SpiderbotHud.HudContainer_ShowAnim = function (f33_arg0, f33_arg1)
	f33_arg0:setAlpha(1)
end

CoD.SpiderbotHud.UpdateVisibility = function (f34_arg0, f34_arg1)
	local f34_local0 = f34_arg1.controller
	if UIExpression.IsVisibilityBitSet(f34_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f34_local0, CoD.BIT_UI_ACTIVE) == 0 then
		if f34_arg0.visible ~= true then
			f34_arg0:setAlpha(1)
			f34_arg0.visible = true
		end
	elseif f34_arg0.visible == true then
		f34_arg0:setAlpha(0)
		f34_arg0.visible = nil
	end
	f34_arg0:dispatchEventToChildren(f34_arg1)
end

