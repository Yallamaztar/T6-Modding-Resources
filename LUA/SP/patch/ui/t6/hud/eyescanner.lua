require("T6.Line")
CoD.EyeScanner = {}
CoD.EyeScanner.DefaultAlpha = 1
CoD.EyeScanner.FolderCenter = -370
CoD.EyeScanner.FolderWidth = 192
CoD.EyeScanner.FolderSpacing = 40
CoD.EyeScanner.FolderImageScale = 1.2
CoD.EyeScanner.AngledFolderOffset = 15
CoD.EyeScanner.WhiteOutEyeCenter = 128
CoD.EyeScanner.WhiteOutEyeSize = 230
CoD.EyeScanner.BlueRetinaRelativeSize = 1
CoD.EyeScanner.BlueRetinaBottom = 0.45
CoD.EyeScanner.BracketRelativeYOffset = -0.1
CoD.EyeScanner.BracketRelativeWidth = 1.6
CoD.EyeScanner.BracketRelativeHeight = 1.6
CoD.EyeScanner.BottomLine = 216
CoD.EyeScanner.HighlightSize = 0.08
CoD.EyeScanner.Highlights = {
	{
		0.15,
		-0.3
	},
	{
		-0.3,
		0.6
	},
	{
		0.6,
		0.35
	},
	{
		-0.32,
		-0.1
	},
	{
		0.15,
		0.8
	}
}
LUI.createMenu.EyeScanner = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f1_local1, f1_local2, f1_local3 = nil
	local f1_local4 = CoD.EyeScanner.BottomLine
	local f1_local5 = f1_local4 - 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	f1_local1 = CoD.EyeScanner.FolderCenter
	f1_local2 = CoD.EyeScanner.FolderWidth
	
	local retinaFolder = LUI.UIElement.new()
	retinaFolder:setLeftRight(false, false, f1_local1 - f1_local2 / 2, f1_local1 + f1_local2 / 2)
	retinaFolder:setTopBottom(false, false, f1_local5 - f1_local2, f1_local5)
	retinaFolder:setAlpha(0)
	Widget:addElement(retinaFolder)
	Widget.retinaFolder = retinaFolder
	
	local retinaImage = LUI.UIImage.new()
	retinaImage:setLeftRight(true, true, 10, -10)
	retinaImage:setTopBottom(true, true, 10, -10)
	retinaImage:setImage(RegisterMaterial("hud_eyescan_retina"))
	retinaImage:setAlpha(0)
	retinaFolder:addElement(retinaImage)
	Widget.retinaImage = retinaImage
	
	local f1_local9 = LUI.UIImage.new()
	f1_local9:setLeftRight(false, false, -f1_local2 / 2 * CoD.EyeScanner.FolderImageScale, f1_local2 / 2 * CoD.EyeScanner.FolderImageScale)
	f1_local9:setTopBottom(false, false, -f1_local2 / 2 * CoD.EyeScanner.FolderImageScale, f1_local2 / 2 * CoD.EyeScanner.FolderImageScale)
	f1_local9:setImage(RegisterMaterial("hud_eyescan_green_bracket"))
	retinaFolder:addElement(f1_local9)
	local f1_local10 = f1_local1
	local f1_local11 = f1_local5 - f1_local2
	local f1_local12 = f1_local2 * 0.03
	f1_local1 = f1_local1 + CoD.EyeScanner.AngledFolderOffset
	local f1_local13 = f1_local11 - CoD.EyeScanner.FolderSpacing
	
	local eyeFolder = LUI.UIElement.new()
	eyeFolder:setLeftRight(false, false, f1_local1 - f1_local2 / 2, f1_local1 + f1_local2 / 2)
	eyeFolder:setTopBottom(false, false, f1_local13 - f1_local2, f1_local13)
	eyeFolder:setAlpha(0)
	Widget:addElement(eyeFolder)
	Widget.eyeFolder = eyeFolder
	
	local eyeballImage = LUI.UIImage.new()
	eyeballImage:setLeftRight(true, true, 10, -10)
	eyeballImage:setTopBottom(true, true, 10, -10)
	eyeballImage:setImage(RegisterMaterial("hud_eyescan_eyeball01"))
	eyeballImage:setAlpha(0)
	eyeFolder:addElement(eyeballImage)
	Widget.eyeballImage = eyeballImage
	
	f1_local9 = LUI.UIImage.new()
	f1_local9:setLeftRight(false, false, -f1_local2 / 2 * CoD.EyeScanner.FolderImageScale, f1_local2 / 2 * CoD.EyeScanner.FolderImageScale)
	f1_local9:setTopBottom(false, false, -f1_local2 / 2 * CoD.EyeScanner.FolderImageScale, f1_local2 / 2 * CoD.EyeScanner.FolderImageScale)
	f1_local9:setImage(RegisterMaterial("hud_eyescan_green_bracket01"))
	eyeFolder:addElement(f1_local9)
	f1_local3 = f1_local13 - f1_local2 - 5 - CoD.textSize.Condensed
	
	local accessText = CoD.TypewriterText.new()
	accessText:setLeftRight(false, false, f1_local1 - f1_local2 / 2 + 20, 600)
	accessText:setTopBottom(false, false, f1_local3, f1_local3 + CoD.textSize.Condensed)
	accessText:setAlignment(LUI.Alignment.Left)
	accessText:setFont(CoD.fonts.Condensed)
	accessText:setRGB(CoD.visorBlue3.r, CoD.visorBlue3.g, CoD.visorBlue3.b)
	Widget:addElement(accessText)
	Widget.accessText = accessText
	
	local eyeScanContainer = LUI.UIElement.new()
	eyeScanContainer:setLeftRight(true, true, 0, 0)
	eyeScanContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(eyeScanContainer)
	Widget.eyeScanContainer = eyeScanContainer
	
	f1_local1 = 65
	f1_local2 = CoD.EyeScanner.WhiteOutEyeSize
	local f1_local18 = 40
	
	local blackBg = LUI.UIImage.new()
	blackBg:setLeftRight(false, false, f1_local1 - f1_local2 / 2, f1_local1 + f1_local2 / 2)
	blackBg:setTopBottom(false, false, -f1_local2 / 2 + f1_local18, f1_local2 / 2 + f1_local18)
	blackBg:setImage(RegisterMaterial("hud_eyescan_backing"))
	blackBg:setAlpha(0)
	eyeScanContainer:addElement(blackBg)
	Widget.blackBg = blackBg
	
	local whiteEye = LUI.UIImage.new()
	whiteEye:setLeftRight(false, false, f1_local1 - f1_local2 / 2, f1_local1 + f1_local2 / 2)
	whiteEye:setTopBottom(false, false, -f1_local2 / 2 + f1_local18, f1_local2 / 2 + f1_local18)
	whiteEye:setImage(RegisterMaterial("hud_eyescan_eyeball"))
	whiteEye:setAlpha(0)
	eyeScanContainer:addElement(whiteEye)
	Widget.whiteEye = whiteEye
	
	local f1_local21 = f1_local1 + f1_local2 / 2
	local f1_local22 = f1_local2 * CoD.EyeScanner.BracketRelativeWidth
	local f1_local23 = f1_local2 * CoD.EyeScanner.BracketRelativeHeight
	f1_local3 = f1_local2 * CoD.EyeScanner.BracketRelativeYOffset + f1_local18
	
	local reticle = LUI.UIImage.new()
	reticle:setLeftRight(false, false, -f1_local22 / 2 + f1_local1, f1_local22 / 2 + f1_local1)
	reticle:setTopBottom(false, false, f1_local3 - f1_local23 / 2, f1_local3 + f1_local23 / 2)
	reticle:setImage(RegisterMaterial("hud_eyescan_reticule"))
	reticle:setAlpha(0)
	eyeScanContainer:addElement(reticle)
	Widget.reticle = reticle
	
	f1_local2 = f1_local2 * CoD.EyeScanner.BlueRetinaRelativeSize
	f1_local1 = f1_local1 + f1_local2 / 2 + 100
	
	local blueRetina = LUI.UIImage.new()
	blueRetina:setLeftRight(false, false, f1_local1 - f1_local2 / 2, f1_local1 + f1_local2 / 2)
	blueRetina:setTopBottom(false, false, -f1_local2 / 2 + f1_local18, f1_local2 / 2 + f1_local18)
	blueRetina:setAlpha(0)
	blueRetina:setImage(RegisterMaterial("hud_eyescan_eyeball_blue"))
	eyeScanContainer:addElement(blueRetina)
	Widget.blueRetina = blueRetina
	
	local f1_local26 = f1_local2
	Widget.highlightPoints = {}
	f1_local2 = f1_local2 * CoD.EyeScanner.HighlightSize
	for f1_local30, f1_local31 in ipairs(CoD.EyeScanner.Highlights) do
		local f1_local32 = LUI.UIImage.new()
		f1_local32:setLeftRight(false, false, f1_local1 + f1_local26 * f1_local31[1] / 2 - f1_local2 / 2, f1_local1 + f1_local26 * f1_local31[1] / 2 + f1_local2 / 2)
		f1_local32:setTopBottom(false, false, f1_local3 + f1_local26 * f1_local31[2] / 2 - f1_local2 / 2, f1_local3 + f1_local26 * f1_local31[2] / 2 + f1_local2 / 2)
		f1_local32:setAlpha(0)
		f1_local32:setImage(RegisterMaterial("hud_eyescan_orange_dot"))
		eyeScanContainer:addElement(f1_local32)
		table.insert(Widget.highlightPoints, f1_local32)
	end
	Widget.retinaLine = CoD.EyeScanner.CreateLine(f1_local21, f1_local4, f1_local1, f1_local26 * CoD.EyeScanner.BlueRetinaBottom)
	Widget:addElement(Widget.retinaLine)
	Widget.bottomLine = CoD.EyeScanner.CreateLine(f1_local10 + CoD.EyeScanner.FolderSpacing, f1_local4, f1_local21, f1_local4)
	Widget:addElement(Widget.bottomLine)
	Widget.folderLine = CoD.EyeScanner.CreateLine(f1_local10 + CoD.EyeScanner.FolderSpacing, f1_local4, f1_local10, f1_local5 + f1_local12)
	Widget:addElement(Widget.folderLine)
	Widget.folderConnector = CoD.EyeScanner.CreateLine(f1_local10, f1_local13 + f1_local12, f1_local10, f1_local11)
	Widget:addElement(Widget.folderConnector)
	f1_local1 = 65
	f1_local27 = CoD.textSize.Default + 10
	f1_local3 = f1_local4 - 5 - f1_local27
	
	compileText = LUI.UIText.new()
	compileText:setLeftRight(false, false, -f1_local22 / 2 + f1_local1, f1_local22 / 2 + f1_local1)
	compileText:setTopBottom(false, false, f1_local3, f1_local3 + f1_local27)
	compileText:setAlignment(LUI.Alignment.Center)
	compileText:setFont(CoD.fonts.Default)
	compileText:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	Widget:addElement(compileText)
	Widget.compileText = compileText
	
	Widget:registerEventHandler("load_retina_scan", CoD.EyeScanner.LoadingAnimation)
	Widget:registerEventHandler("begin_retina_scan", CoD.EyeScanner.BeginScan)
	Widget:registerEventHandler("highlight_point", CoD.EyeScanner.HighlightPoint)
	Widget:registerEventHandler("hud_update_refresh", CoD.EyeScanner.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.EyeScanner.UpdateVisibility)
	return Widget
end

CoD.EyeScanner.GetSizeHelper = function (f2_arg0, f2_arg1, f2_arg2)
	return math.max(f2_arg0 * f2_arg1, f2_arg2)
end

CoD.EyeScanner.CreateLine = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)
	if f3_arg4 == nil then
		f3_arg4 = CoD.visorBlue3
	end
	if f3_arg5 == nil then
		f3_arg5 = 6
	end
	local f3_local0 = math.sqrt((f3_arg2 - f3_arg0) * (f3_arg2 - f3_arg0) + (f3_arg3 - f3_arg1) * (f3_arg3 - f3_arg1))
	local f3_local1 = (f3_arg0 + f3_arg2) / 2
	local f3_local2 = (f3_arg1 + f3_arg3) / 2
	local f3_local3 = 360 - math.atan2(f3_arg3 - f3_arg1, f3_arg2 - f3_arg0) / math.pi * 180
	local f3_local4 = LUI.UIImage.new()
	f3_local4.left = f3_local1 - f3_local0 / 2
	f3_local4.right = f3_local1 + f3_local0 / 2
	f3_local4.top = f3_local2 - f3_arg5 / 2
	f3_local4.bottom = f3_local2 + f3_arg5 / 2
	f3_local4.angle = f3_local3
	f3_local4:setTopBottom(false, false, f3_arg1 - f3_arg5 / 2, f3_arg1 + f3_arg5 / 2)
	f3_local4:setLeftRight(false, false, f3_arg0, f3_arg0)
	f3_local4:setRGB(f3_arg4.r, f3_arg4.g, f3_arg4.b)
	f3_local4:setImage(RegisterMaterial("hud_eyescan_greenline"))
	f3_local4:setZRot(f3_local3)
	f3_local4:setAlpha(1)
	return f3_local4
end

CoD.EyeScanner.LoadingAnimation = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.step
	local f4_local1 = nil
	if f4_local0 == nil then
		f4_local0 = 1
	end
	local f4_local2 = 4000
	if f4_arg1.data and f4_arg1.totalTime then
		f4_local2 = f4_arg1.totalTime
	end
	if CoD.EyeScanner["LoadingStage" .. f4_local0] then
		f4_local1 = CoD.EyeScanner["LoadingStage" .. f4_local0](f4_arg0, f4_local2)
	end
	if f4_local1 then
		f4_arg0:addElement(LUI.UITimer.new(f4_local1, {
			name = "load_retina_scan",
			step = f4_local0 + 1,
			totalTime = f4_local2
		}, true, f4_arg0))
	end
	return true
end

CoD.EyeScanner.LoadingStage1 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1 / 4
	f5_arg0.blueRetina:beginAnimation("load", f5_local0)
	f5_arg0.blueRetina:setAlpha(1)
	return f5_local0
end

CoD.EyeScanner.LoadingStage2 = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1 / 8
	f6_arg0.whiteEye:beginAnimation("load", f6_local0)
	f6_arg0.whiteEye:setAlpha(1)
	f6_arg0.blackBg:beginAnimation("load", f6_local0)
	f6_arg0.blackBg:setAlpha(0.2)
	return f6_local0 * 2
end

CoD.EyeScanner.LoadingStage3 = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1 / 8
	f7_arg0.compileText:setText(Engine.Localize("KARMA_ACCESS_GRANTED"))
	return f7_local0
end

CoD.EyeScanner.LoadingStage4 = function (f8_arg0, f8_arg1)
	local f8_local0 = 1250
	f8_arg0.eyeScanContainer:flicker(f8_local0, 0, 0.2, 1, f8_local0 / 4, f8_local0 / 4)
	return f8_local0
end

CoD.EyeScanner.BeginScan = function (f9_arg0, f9_arg1)
	local f9_local0 = 1000
	if f9_arg1.data and f9_arg1.data[1] then
		f9_local0 = f9_arg1.data[1]
	end
	f9_arg0.reticle:beginAnimation("scan", f9_local0)
	f9_arg0.reticle:setAlpha(1)
	f9_arg0:processEvent({
		name = "highlight_point",
		totalTime = f9_local0
	})
	return true
end

CoD.EyeScanner.HighlightPoint = function (f10_arg0, f10_arg1)
	if f10_arg0.highlightPoints == nil then
		return 
	end
	local f10_local0 = f10_arg1.step
	local f10_local1 = nil
	if f10_local0 == nil then
		f10_local0 = 1
	end
	local f10_local2 = f10_arg1.totalTime / (#f10_arg0.highlightPoints + 1)
	if f10_arg0.highlightPoints[f10_local0] then
		f10_local1 = true
		f10_arg0.highlightPoints[f10_local0]:beginAnimation("show", f10_local2)
		f10_arg0.highlightPoints[f10_local0]:setAlpha(1)
	end
	if f10_local1 then
		f10_arg0:addElement(LUI.UITimer.new(f10_local2, {
			name = "highlight_point",
			step = f10_local0 + 1,
			totalTime = f10_arg1.totalTime
		}, true, f10_arg0))
	end
	return true
end

CoD.EyeScanner.UpdateVisibility = function (f11_arg0, f11_arg1)
	if UIExpression.IsVisibilityBitSet(f11_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f11_arg0.visible ~= true then
			f11_arg0:setAlpha(CoD.EyeScanner.DefaultAlpha)
			f11_arg0.visible = true
		end
	elseif f11_arg0.visible == true then
		f11_arg0:setAlpha(0)
		f11_arg0.visible = nil
	end
	f11_arg0:dispatchEventToChildren(f11_arg1)
end

