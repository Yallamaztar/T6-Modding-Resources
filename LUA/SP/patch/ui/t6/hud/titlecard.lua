CoD.TitleCard = {}
CoD.TitleCard.ContainerWidth = 1024
CoD.TitleCard.ContainerHeight = 512
CoD.TitleCard.UI3DWindowOffset = 10
CoD.TitleCard.Color = CoD.offWhite
CoD.TitleCard.UI3DWindowWidth = 1024
CoD.TitleCard.UI3DWindowHeight = 512
CoD.TitleCard.TextHeightMultiplier = 1.5
LUI.createMenu.TitleCard = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f1_local1 = UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, Dvar.ui_mapname:get(), 3)
	CoD.TitleCard.IntroscreenMaterial = RegisterMaterial("visor_introscreen")
	if not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) and f1_local1 == "nineteeneighties" then
		CoD.TitleCard.IntroscreenMaterial = RegisterMaterial("visor_introscreen_80s")
	end
	local f1_local2 = 0
	local f1_local3 = 0
	
	local ui3dWindowContainer = LUI.UIElement.new()
	ui3dWindowContainer:setLeftRight(true, true, 0, 0)
	ui3dWindowContainer:setTopBottom(true, true, 0, 0)
	ui3dWindowContainer:setUI3DWindow(4)
	Widget:addElement(ui3dWindowContainer)
	Widget.ui3dWindowContainer = ui3dWindowContainer
	
	local f1_local5 = 0
	local f1_local6 = 150
	local f1_local7 = 500
	local f1_local8 = 250
	Widget.screenContainer = LUI.UIElement.new()
	Widget.screenContainer:setLeftRight(true, true, 0, 0)
	Widget.screenContainer:setTopBottom(false, true, -f1_local8, 0)
	Widget:addElement(Widget.screenContainer)
	Widget:registerEventHandler("hud_add_title_line", CoD.TitleCard.AddTitleCard)
	Widget:registerEventHandler("remove_title_lines", CoD.TitleCard.RemoveTitleLineFromUI3DWindow)
	Widget:registerEventHandler("hud_update_refresh", CoD.TitleCard.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.TitleCard.UpdateVisibility)
	if CoD.isPC then
		Widget:registerEventHandler("resolution_changed", CoD.TitleCard.ResolutionChanged)
	end
	return Widget
end

CoD.TitleCard.AddTitleLineText = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0, f2_local1, f2_local2, f2_local3 = GetTextDimensions(f2_arg0, f2_arg1, f2_arg2)
	local f2_local4 = f2_local2 - f2_local0
	local f2_local5 = CoD.TitleCard.UI3DWindowOffset
	f2_arg3 = f2_arg3 + f2_local5
	local f2_local6 = LUI.UIText.new()
	f2_local6:setLeftRight(true, false, f2_local5 * CoD.TitleCard.TextHeightMultiplier, (f2_local4 + f2_local5) * CoD.TitleCard.TextHeightMultiplier)
	f2_local6:setTopBottom(true, false, f2_arg3 * CoD.TitleCard.TextHeightMultiplier, (f2_arg2 + f2_arg3) * CoD.TitleCard.TextHeightMultiplier)
	f2_local6:setFont(f2_arg1)
	f2_local6:setText(f2_arg0)
	f2_local6.id = f2_local6.id .. ".Line"
	local f2_local7, f2_local8 = Engine.GetUnredactTextDimensions(f2_arg0, f2_arg1, f2_arg2)
	return f2_local6, f2_local4, f2_local7, f2_local8
end

CoD.TitleCard.AddTitleCard = function (f3_arg0, f3_arg1)
	CoD.TitleCard.SetupUI3DWindowsForTitleCardIntro()
	f3_arg0.m_allowResize = true
	local f3_local0 = Engine.GetIString(f3_arg1.data[1], "CS_LOCALIZED_STRINGS")
	local f3_local1 = f3_arg1.data[2]
	local f3_local2 = f3_arg1.data[3] * 1000
	CoD.TitleCard.Color = f3_arg1.data[4]
	if not CoD.TitleCard.Color then
		CoD.TitleCard.Color = 0
	end
	local f3_local3, f3_local4 = nil
	local f3_local5 = CoD.TitleCard.ContainerHeight
	local f3_local6 = f3_arg0.screenContainer
	f3_local6:registerEventHandler("reveal_line", CoD.TitleCard.LoadingAnimation)
	local f3_local7 = f3_arg0.ui3dWindowContainer
	local f3_local8, f3_local9, f3_local10, f3_local11, f3_local12, f3_local13, f3_local14, f3_local15, f3_local16, f3_local17, f3_local18, f3_local19 = nil
	if f3_local1 >= 1 then
		f3_local3 = Engine.Localize(f3_local0 .. "_INTROSCREEN_LINE_1")
		f3_local4 = CoD.fonts.Big
		f3_local8 = CoD.textSize.Big - 10
		f3_local13 = 0
		local f3_local20, f3_local21, f3_local22, f3_local23 = CoD.TitleCard.AddTitleLineText(f3_local3, f3_local4, f3_local8, f3_local13)
		f3_local7.textLine1 = f3_local20
		f3_local7:addElement(f3_local20)
		f3_local6.titleLine1 = CoD.TitleCard.CreateTitleCardTextLine(f3_local13, f3_local8, f3_local21, f3_local22, f3_local23)
		f3_local6:addElement(f3_local6.titleLine1)
		f3_local6.titleLine1.width = f3_local21
		f3_local6.titleLine1.wordWidth = f3_local23 - f3_local22
		f3_local18 = f3_local8
		f3_local19 = f3_local13
	end
	if f3_local1 >= 2 then
		f3_local3 = Engine.Localize(f3_local0 .. "_INTROSCREEN_LINE_2")
		f3_local4 = CoD.fonts.Big
		f3_local9 = CoD.textSize.Big - 10
		f3_local14 = f3_local13 + f3_local8
		local f3_local20, f3_local21, f3_local22, f3_local23 = CoD.TitleCard.AddTitleLineText(f3_local3, f3_local4, f3_local9, f3_local14)
		f3_local7.textLine2 = f3_local20
		f3_local7:addElement(f3_local20)
		f3_local6.titleLine2 = CoD.TitleCard.CreateTitleCardTextLine(f3_local14, f3_local9, f3_local21, f3_local22, f3_local23)
		f3_local6:addElement(f3_local6.titleLine2)
		f3_local6.titleLine2.width = f3_local21
		f3_local6.titleLine2.wordWidth = f3_local23 - f3_local22
		f3_local18 = f3_local9
		f3_local19 = f3_local14
	end
	if f3_local1 >= 3 then
		f3_local3 = Engine.Localize(f3_local0 .. "_INTROSCREEN_LINE_3")
		f3_local4 = CoD.fonts.Condensed
		f3_local10 = CoD.textSize.Condensed
		f3_local15 = f3_local14 + f3_local9
		local f3_local20, f3_local21, f3_local22, f3_local23 = CoD.TitleCard.AddTitleLineText(f3_local3, f3_local4, f3_local10, f3_local15)
		f3_local7.textLine3 = f3_local20
		f3_local7:addElement(f3_local20)
		f3_local6.titleLine3 = CoD.TitleCard.CreateTitleCardTextLine(f3_local15, f3_local10, f3_local21, f3_local22, f3_local23)
		f3_local6:addElement(f3_local6.titleLine3)
		f3_local6.titleLine3.width = f3_local21
		f3_local6.titleLine3.wordWidth = f3_local23 - f3_local22
		f3_local18 = f3_local10
		f3_local19 = f3_local15
	end
	if f3_local1 >= 4 then
		f3_local3 = Engine.Localize(f3_local0 .. "_INTROSCREEN_LINE_4")
		f3_local4 = CoD.fonts.Condensed
		f3_local11 = CoD.textSize.Condensed
		f3_local16 = f3_local15 + f3_local10
		local f3_local20, f3_local21, f3_local22, f3_local23 = CoD.TitleCard.AddTitleLineText(f3_local3, f3_local4, f3_local11, f3_local16)
		f3_local7.textLine4 = f3_local20
		f3_local7:addElement(f3_local20)
		f3_local6.titleLine4 = CoD.TitleCard.CreateTitleCardTextLine(f3_local16, f3_local11, f3_local21, f3_local22, f3_local23)
		f3_local6:addElement(f3_local6.titleLine4)
		f3_local6.titleLine4.width = f3_local21
		f3_local6.titleLine4.wordWidth = f3_local23 - f3_local22
		f3_local18 = f3_local11
		f3_local19 = f3_local16
	end
	if f3_local1 >= 5 then
		f3_local3 = Engine.Localize(f3_local0 .. "_INTROSCREEN_LINE_5")
		f3_local4 = CoD.fonts.Default
		f3_local12 = CoD.textSize.Default
		f3_local17 = f3_local16 + f3_local11
		local f3_local20, f3_local21, f3_local22, f3_local23 = CoD.TitleCard.AddTitleLineText(f3_local3, f3_local4, f3_local12, f3_local17)
		f3_local7.textLine5 = f3_local20
		f3_local7:addElement(f3_local20)
		f3_local6.titleLine5 = CoD.TitleCard.CreateTitleCardTextLine(f3_local17, f3_local12, f3_local21, f3_local22, f3_local23)
		f3_local6:addElement(f3_local6.titleLine5)
		f3_local6.titleLine5.width = f3_local21
		f3_local6.titleLine5.wordWidth = f3_local23 - f3_local22
		f3_local18 = f3_local12
		f3_local19 = f3_local17
	end
	f3_local6:processEvent({
		name = "reveal_line",
		totalTime = f3_local2,
		numberOfLines = f3_local1
	})
end

CoD.TitleCard.CreateTitleCardTextLine = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = CoD.TitleCard.ContainerHeight
	if not f4_arg3 then
		f4_arg3 = f4_arg2 / 4
	end
	if not f4_arg4 then
		f4_arg4 = f4_arg2 / 2
	end
	local f4_local1 = CoD.TitleCard.UI3DWindowOffset
	f4_arg0 = f4_arg0 + f4_local1
	local f4_local2 = CoD.TitleCard.UI3DWindowWidth / 720 * Engine.GetAspectRatio()
	local f4_local3 = CoD.TitleCard.UI3DWindowHeight / 720
	local f4_local4 = CoD.TitleCard.UI3DWindowWidth / CoD.TitleCard.TextHeightMultiplier * 1.5
	local f4_local5 = LUI.UIImage.new()
	f4_local5:setLeftRight(true, false, 25, 25 + f4_local4)
	f4_local5:setTopBottom(true, false, f4_arg0 - f4_local1, f4_arg1 + f4_arg0 - f4_local1)
	f4_local5:setImage(CoD.TitleCard.IntroscreenMaterial)
	f4_local2 = f4_local2 * CoD.TitleCard.TextHeightMultiplier
	f4_local3 = f4_local3 * CoD.TitleCard.TextHeightMultiplier
	f4_local5:setShaderVector(0, f4_local1 * f4_local2, f4_arg0 * f4_local3, (f4_arg2 + f4_local1) * f4_local2, (f4_arg0 + f4_arg1) * f4_local3)
	f4_local5:setShaderVector(1, (f4_arg3 + f4_local1) * f4_local2, (f4_arg4 + f4_local1) * f4_local2, CoD.TitleCard.Color, 0)
	f4_local5:setShaderVector(2, 0, 0, 0, 0)
	f4_local5:setShaderVector(3, CoD.TitleCard.TextHeightMultiplier, f4_arg0, 1, f4_arg0 + f4_arg1)
	return f4_local5
end

CoD.TitleCard.RemoveTitleLineFromUI3DWindow = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.ui3dWindowContainer
	local f5_local1 = f5_arg1.numberOfLines
	for f5_local2 = 1, f5_local1, 1 do
		local f5_local5 = f5_local0["textLine" .. f5_local2]
		f5_local5:setUI3DWindow(-1)
		f5_local5:close()
		f5_local5 = nil
	end
	f5_arg0.screenContainer:removeAllChildren()
end

CoD.TitleCard.LoadingAnimation = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.step
	local f6_local1 = f6_arg1.subStep
	local f6_local2 = nil
	local f6_local3 = f6_arg1.numberOfLines
	if not f6_local0 then
		f6_local0 = 1
	end
	if not f6_local1 then
		f6_local1 = 1
	end
	local f6_local4 = 10000
	if f6_arg1.totalTime then
		f6_local4 = f6_arg1.totalTime
	end
	if CoD.TitleCard["LoadingStage" .. f6_local0] then
		local f6_local5, f6_local6 = CoD.TitleCard["LoadingStage" .. f6_local0](f6_arg0, f6_local4, f6_local1, f6_local3)
		f6_local1 = f6_local6
		f6_local2 = f6_local5
		if f6_local1 == f6_local3 + 1 or not f6_local1 then
			f6_local0 = f6_local0 + 1
			f6_local1 = nil
		end
	end
	if f6_local2 then
		f6_arg0:addElement(LUI.UITimer.new(f6_local2, {
			name = "reveal_line",
			step = f6_local0,
			subStep = f6_local1,
			totalTime = f6_local4,
			numberOfLines = f6_local3
		}, true, f6_arg0))
	elseif Dvar.ui_mapname:get() == "penny_test" then
		f6_arg0:addElement(LUI.UITimer.new(0, {
			name = "reveal_line",
			step = 1,
			subStep = f6_local1,
			totalTime = f6_local4,
			numberOfLines = f6_local3
		}, true, f6_arg0))
	else
		f6_arg0.m_allowResize = nil
		CoD.TitleCard.SetupUI3DWindowsForInGame()
		f6_arg0:dispatchEventToParent({
			name = "remove_title_lines",
			numberOfLines = f6_local3
		})
	end
	return true
end

CoD.TitleCard.LoadingStage1 = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = f7_arg1 * 0.08
	local f7_local1 = f7_arg0["titleLine" .. f7_arg2]
	local f7_local2 = f7_local1.width * 6 + f7_local0
	f7_local1:beginAnimation("reveal", f7_local2)
	f7_local1:setShaderVector(2, 1, 0, 0, 0)
	if f7_arg2 == f7_arg3 then
		return f7_local2 + 250, f7_arg2 + 1
	else
		return f7_local0, f7_arg2 + 1
	end
end

CoD.TitleCard.LoadingStage2 = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = f8_arg1 * 0.1
	for f8_local1 = 1, f8_arg3, 1 do
		local f8_local4 = f8_arg0["titleLine" .. f8_local1]
		f8_local4:beginAnimation("disperse", f8_local0)
		f8_local4:setShaderVector(2, 1, 1, 0, 0)
	end
	return f8_local0, nil
end

CoD.TitleCard.LoadingStage3 = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = f9_arg1 * 0.1
	for f9_local1 = 1, f9_arg3, 1 do
		local f9_local4 = f9_arg0["titleLine" .. f9_local1]
		f9_local4:beginAnimation("slide", f9_local0)
		f9_local4:setShaderVector(2, 1, 1, 1, 0)
	end
	return f9_local0 + 250, nil
end

CoD.TitleCard.LoadingStage4 = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0 = f10_arg1 * 0.08
	local f10_local1 = f10_arg0["titleLine" .. f10_arg2]
	local f10_local2 = 1200 + f10_local0
	f10_local1:beginAnimation("fade", f10_local2)
	f10_local1:setShaderVector(2, 1, 1, 1, 1)
	if f10_arg2 == f10_arg3 then
		return f10_local2, f10_arg2 + 1
	else
		return f10_local0, f10_arg2 + 1
	end
end

CoD.TitleCard.LoadingStage5 = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = 0
	for f11_local1 = 1, f11_arg3, 1 do
		local f11_local4 = f11_arg0["titleLine" .. f11_local1]
		f11_local4:beginAnimation("reset", f11_local0)
		f11_local4:setShaderVector(2, 0, 0, 0, 0)
	end
	return f11_local0, nil
end

CoD.TitleCard.SetupUI3DWindowsForTitleCardIntro = function ()
	local f12_local0 = Engine.GetAspectRatio() * 512 / 1024
	local f12_local1 = 1024 / Engine.GetAspectRatio() / 512
	if f12_local0 < 1 then
		f12_local1 = 1
	else
		f12_local0 = 1
	end
	Engine.SetUI3DWindows(0, 0, 0, 0, 0)
	Engine.SetUI3DWindows(1, 0, 0, 0, 0)
	Engine.SetUI3DWindows(2, 0, 0, 0, 0)
	Engine.SetUI3DWindows(3, 0, 0, 0, 0)
	Engine.SetUI3DWindows(4, 0, 0, f12_local0, f12_local1)
	Engine.SetUI3DWindows(5, 0, 0, 0, 0)
	CoD.TitleCard.UI3DWindowWidth = f12_local0 * 1024
	CoD.TitleCard.UI3DWindowHeight = f12_local1 * 512
end

CoD.TitleCard.SetupUI3DWindowsForInGame = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		Engine.SetUI3DWindows(0, 0, 0, 1, 1)
		Engine.SetUI3DWindows(1, 0, 0, 0, 0)
		Engine.SetUI3DWindows(2, 0, 0, 0, 0)
		Engine.SetUI3DWindows(3, 0, 0, 0, 0)
		Engine.SetUI3DWindows(4, 0, 0, 0, 0)
		Engine.SetUI3DWindows(5, 0, 0, 0, 0)
	else
		Engine.SetUI3DWindows(0, 0, 0, 0.12, 0.12)
		Engine.SetUI3DWindows(1, 0, 0.25, 0.12, 0.12)
		Engine.SetUI3DWindows(2, 0.12, 0, 0.12, 0.5)
		Engine.SetUI3DWindows(3, 0.25, 0, 0.25, 0.5)
		Engine.SetUI3DWindows(4, 0, 0.5, 0.5, 0.5)
		Engine.SetUI3DWindows(5, 0.5, 0, 0.5, 1)
	end
end

CoD.TitleCard.UpdateVisibility = function (f14_arg0, f14_arg1)
	if UIExpression.IsVisibilityBitSet(f14_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f14_arg0.visible ~= true then
			f14_arg0:setAlpha(CoD.CCTVHud.DefaultAlpha)
			f14_arg0.visible = true
		end
	elseif f14_arg0.visible == true then
		f14_arg0:setAlpha(0)
		f14_arg0.visible = nil
	end
	f14_arg0:dispatchEventToChildren(f14_arg1)
end

CoD.TitleCard.ResolutionChanged = function (f15_arg0, f15_arg1)
	if f15_arg0.m_allowResize then
		CoD.TitleCard.SetupUI3DWindowsForTitleCardIntro()
	end
end

