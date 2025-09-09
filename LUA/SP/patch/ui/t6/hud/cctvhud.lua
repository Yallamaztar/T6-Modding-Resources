CoD.CCTVHud = {}
CoD.CCTVHud.ContainerWidth = 800
CoD.CCTVHud.ContainerHeight = CoD.CCTVHud.ContainerWidth * 0.65
CoD.CCTVHud.DefaultAlpha = 1
CoD.CCTVHud.BracketSize = 260
CoD.CCTVHud.ArrowSize = 41.6
CoD.CCTVHud.LongLineHeight = 20.8
CoD.CCTVHud.LongLineWidth = CoD.CCTVHud.LongLineHeight * 8
CoD.CCTVHud.ShortLineWidth = 20.8
CoD.CCTVHud.ShortLineHeight = CoD.CCTVHud.ShortLineWidth * 4
CoD.CCTVHud.FontAlpha = 0.5
CoD.CCTVHud.BracketAlpha = 0.5
LUI.createMenu.CCTVHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewFromState("CCTVHud")
	f1_local0:setLeftRight(true, true, 0, 0)
	f1_local0:setTopBottom(true, true, 0, 0)
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	Widget:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	f1_local0:addElement(Widget)
	local f1_local4 = RegisterMaterial("hud_cctv_orange_square_blur")
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(true, true, 0, 0)
	f1_local5:setTopBottom(true, true, 0, 0)
	f1_local5:setImage(f1_local4)
	f1_local5:setAlpha(0.5)
	f1_local0:addElement(f1_local5)
	CoD.CCTVHud.AddBrackets(Widget)
	CoD.CCTVHud.AddLinesAndArrows(Widget)
	CoD.CCTVHud.AddBlackBoxes(Widget)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.CCTVHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.CCTVHud.UpdateVisibility)
	return f1_local0
end

CoD.CCTVHud.AddBrackets = function (f2_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.CCTVHud.ContainerWidth / 2, CoD.CCTVHud.ContainerWidth / 2)
	Widget:setTopBottom(false, false, -CoD.CCTVHud.ContainerHeight / 2, CoD.CCTVHud.ContainerHeight / 2)
	f2_arg0:addElement(Widget)
	local f2_local1 = RegisterMaterial("hud_cctv_orange_square_bracket")
	local f2_local2 = 100
	local f2_local3 = 100
	local f2_local4 = LUI.UIImage.new()
	f2_local4:setLeftRight(true, false, 0, CoD.CCTVHud.BracketSize)
	f2_local4:setTopBottom(true, false, 0, CoD.CCTVHud.BracketSize)
	f2_local4:setImage(f2_local1)
	f2_local4:setAlpha(CoD.CCTVHud.BracketAlpha)
	Widget:addElement(f2_local4)
	local f2_local5 = LUI.UIImage.new()
	f2_local5:setLeftRight(false, true, -CoD.CCTVHud.BracketSize, 0)
	f2_local5:setTopBottom(true, false, 0, CoD.CCTVHud.BracketSize)
	f2_local5:setImage(f2_local1)
	f2_local5:setAlpha(CoD.CCTVHud.BracketAlpha)
	f2_local5:setYRot(180)
	Widget:addElement(f2_local5)
	local f2_local6 = LUI.UIImage.new()
	f2_local6:setLeftRight(true, false, 0, CoD.CCTVHud.BracketSize)
	f2_local6:setTopBottom(false, true, -CoD.CCTVHud.BracketSize, 0)
	f2_local6:setImage(f2_local1)
	f2_local6:setAlpha(CoD.CCTVHud.BracketAlpha)
	f2_local6:setXRot(180)
	Widget:addElement(f2_local6)
	local f2_local7 = LUI.UIImage.new()
	f2_local7:setLeftRight(false, true, -CoD.CCTVHud.BracketSize, 0)
	f2_local7:setTopBottom(false, true, -CoD.CCTVHud.BracketSize, 0)
	f2_local7:setImage(f2_local1)
	f2_local7:setAlpha(CoD.CCTVHud.BracketAlpha)
	f2_local7:setXRot(180)
	f2_local7:setYRot(180)
	Widget:addElement(f2_local7)
end

CoD.CCTVHud.AddLinesAndArrows = function (f3_arg0)
	local f3_local0 = RegisterMaterial("hud_cctv_orange_arrow")
	local f3_local1 = RegisterMaterial("hud_cctv_orange_line_long")
	local f3_local2 = RegisterMaterial("hud_cctv_orange_line_short")
	local f3_local3 = CoD.CCTVHud.ArrowSize
	local f3_local4 = CoD.CCTVHud.ArrowSize
	local f3_local5 = LUI.UIImage.new()
	f3_local5:setLeftRight(false, false, -CoD.CCTVHud.ShortLineWidth / 2, CoD.CCTVHud.ShortLineWidth / 2)
	f3_local5:setTopBottom(true, false, f3_local3, CoD.CCTVHud.ShortLineHeight + f3_local3)
	f3_local5:setImage(f3_local2)
	f3_local5:setAlpha(CoD.CCTVHud.BracketAlpha)
	f3_local5:setZRot(180)
	f3_arg0:addElement(f3_local5)
	local f3_local6 = LUI.UIImage.new()
	f3_local6:setLeftRight(false, false, -CoD.CCTVHud.ArrowSize / 2, CoD.CCTVHud.ArrowSize / 2)
	f3_local6:setTopBottom(true, false, 0, CoD.CCTVHud.ArrowSize)
	f3_local6:setImage(f3_local0)
	f3_arg0:addElement(f3_local6)
	local f3_local7 = LUI.UIImage.new()
	f3_local7:setLeftRight(false, false, -CoD.CCTVHud.ShortLineWidth / 2, CoD.CCTVHud.ShortLineWidth / 2)
	f3_local7:setTopBottom(false, true, -CoD.CCTVHud.ShortLineHeight - f3_local3, -f3_local3)
	f3_local7:setImage(f3_local2)
	f3_local7:setAlpha(CoD.CCTVHud.BracketAlpha)
	f3_arg0:addElement(f3_local7)
	local f3_local8 = LUI.UIImage.new()
	f3_local8:setLeftRight(false, false, -CoD.CCTVHud.ArrowSize / 2, CoD.CCTVHud.ArrowSize / 2)
	f3_local8:setTopBottom(false, true, -CoD.CCTVHud.ArrowSize, 0)
	f3_local8:setImage(f3_local0)
	f3_local8:setZRot(180)
	f3_arg0:addElement(f3_local8)
	local f3_local9 = LUI.UIImage.new()
	f3_local9:setLeftRight(true, false, f3_local4, CoD.CCTVHud.LongLineWidth + f3_local4)
	f3_local9:setTopBottom(false, false, -CoD.CCTVHud.LongLineHeight / 2, CoD.CCTVHud.LongLineHeight / 2)
	f3_local9:setImage(f3_local1)
	f3_local9:setAlpha(CoD.CCTVHud.BracketAlpha)
	f3_local9:setZRot(180)
	f3_arg0:addElement(f3_local9)
	local f3_local10 = LUI.UIImage.new()
	f3_local10:setLeftRight(true, false, 0, CoD.CCTVHud.ArrowSize)
	f3_local10:setTopBottom(false, false, -CoD.CCTVHud.ArrowSize / 2, CoD.CCTVHud.ArrowSize / 2)
	f3_local10:setImage(f3_local0)
	f3_local10:setZRot(90)
	f3_arg0:addElement(f3_local10)
	local f3_local11 = LUI.UIImage.new()
	f3_local11:setLeftRight(false, true, -CoD.CCTVHud.LongLineWidth - f3_local4, -f3_local4)
	f3_local11:setTopBottom(false, false, -CoD.CCTVHud.LongLineHeight / 2, CoD.CCTVHud.LongLineHeight / 2)
	f3_local11:setImage(f3_local1)
	f3_local11:setAlpha(CoD.CCTVHud.BracketAlpha)
	f3_arg0:addElement(f3_local11)
	local f3_local12 = LUI.UIImage.new()
	f3_local12:setLeftRight(false, true, -CoD.CCTVHud.ArrowSize, 0)
	f3_local12:setTopBottom(false, false, -CoD.CCTVHud.ArrowSize / 2, CoD.CCTVHud.ArrowSize / 2)
	f3_local12:setImage(f3_local0)
	f3_local12:setZRot(-90)
	f3_arg0:addElement(f3_local12)
end

CoD.CCTVHud.AddBlackBox = function ()
	local f4_local0 = LUI.UIImage.new()
	f4_local0:setLeftRight(true, true, 0, 0)
	f4_local0:setTopBottom(true, true, 0, 0)
	f4_local0:setRGB(0, 0, 0)
	f4_local0:setAlpha(0.5)
	return f4_local0
end

CoD.CCTVHud.AddBlackBoxes = function (f5_arg0)
	local f5_local0 = CoD.fonts.Condensed
	local f5_local1 = CoD.fonts.Big
	local f5_local2 = CoD.textSize.Condensed
	local f5_local3 = CoD.textSize.Big
	local f5_local4 = 30
	local f5_local5 = 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 300)
	Widget:setTopBottom(true, false, f5_local4, 35 + f5_local4)
	f5_arg0:addElement(Widget)
	Widget:addElement(CoD.CCTVHud.AddBlackBox())
	local f5_local7 = LUI.UIText.new()
	f5_local7:setLeftRight(true, true, 0, -10)
	f5_local7:setTopBottom(false, false, -f5_local2 / 2, f5_local2 / 2)
	f5_local7:setFont(f5_local0)
	f5_local7:setAlignment(LUI.Alignment.Right)
	f5_local7:setAlpha(CoD.CCTVHud.FontAlpha)
	Widget:addElement(f5_local7)
	f5_local7:setText(Engine.Localize("MENU_CAMERA_STATUS_CAPS") .. " : " .. Engine.Localize("MENU_ONLINE_CAPS"))
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -300, 0)
	Widget:setTopBottom(true, false, f5_local4, 35 + f5_local4)
	f5_arg0:addElement(Widget)
	Widget:addElement(CoD.CCTVHud.AddBlackBox())
	local f5_local9 = LUI.UIText.new()
	f5_local9:setLeftRight(true, true, 10, 0)
	f5_local9:setTopBottom(false, false, -f5_local2 / 2, f5_local2 / 2)
	f5_local9:setFont(f5_local0)
	f5_local9:setAlignment(LUI.Alignment.Left)
	f5_local9:setAlpha(CoD.CCTVHud.FontAlpha)
	Widget:addElement(f5_local9)
	f5_local9:setText("C2710")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 350)
	Widget:setTopBottom(false, true, -100 - f5_local5, -f5_local5)
	f5_arg0:addElement(Widget)
	Widget:addElement(CoD.CCTVHud.AddBlackBox())
	local f5_local11 = 75
	local f5_local12 = 20
	local f5_local13 = LUI.UIImage.new()
	f5_local13:setLeftRight(true, false, f5_local12, f5_local11 + f5_local12)
	f5_local13:setTopBottom(false, false, -f5_local11 / 2, f5_local11 / 2)
	local f5_local14 = f5_local11 + f5_local12 + 20
	local f5_local15 = CoD.textSize.Default
	local f5_local16 = CoD.fonts.Default
	local f5_local17 = 10
	local f5_local18 = LUI.UIText.new()
	f5_local18:setLeftRight(true, true, f5_local14, 0)
	f5_local18:setTopBottom(true, false, f5_local17, f5_local15 + f5_local17)
	f5_local18:setFont(f5_local16)
	f5_local18:setAlignment(LUI.Alignment.Left)
	f5_local18:setAlpha(CoD.CCTVHud.FontAlpha)
	Widget:addElement(f5_local18)
	f5_local18:setText(Engine.Localize("MENU_NETLINK_CAPS") .. " : " .. Engine.Localize("MENU_ACTIVE_CAPS"))
	local f5_local19 = f5_local17 + f5_local15
	local f5_local20 = LUI.UIText.new()
	f5_local20:setLeftRight(true, true, f5_local14, 0)
	f5_local20:setTopBottom(true, false, f5_local19, f5_local15 + f5_local19)
	f5_local20:setFont(f5_local16)
	f5_local20:setAlignment(LUI.Alignment.Left)
	f5_local20:setAlpha(CoD.CCTVHud.FontAlpha)
	Widget:addElement(f5_local20)
	f5_local20:setText(Engine.Localize("MENU_INFRARED_CAPS") .. " : " .. Engine.Localize("MENU_DISABLED_CAPS"))
	local f5_local21 = f5_local19 + f5_local15
	local f5_local22 = LUI.UIText.new()
	f5_local22:setLeftRight(true, true, f5_local14, 0)
	f5_local22:setTopBottom(true, false, f5_local21, f5_local15 + f5_local21)
	f5_local22:setFont(f5_local16)
	f5_local22:setAlignment(LUI.Alignment.Left)
	f5_local22:setAlpha(CoD.CCTVHud.FontAlpha)
	Widget:addElement(f5_local22)
	f5_local22:setText(Engine.Localize("MENU_MILLIBAR_CAPS") .. " : " .. Engine.Localize("MENU_DISABLED_CAPS"))
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -400, 0)
	Widget:setTopBottom(false, true, -50 - f5_local5, -f5_local5)
	f5_arg0:addElement(Widget)
	Widget:addElement(CoD.CCTVHud.AddBlackBox())
	local f5_local24 = LUI.UIText.new()
	f5_local24:setLeftRight(true, true, 10, 0)
	f5_local24:setTopBottom(false, false, -f5_local3 / 2, f5_local3 / 2)
	f5_local24:setFont(f5_local1)
	f5_local24:setAlignment(LUI.Alignment.Left)
	f5_local24:setAlpha(CoD.CCTVHud.FontAlpha)
	Widget:addElement(f5_local24)
	CoD.CountupTimer.Setup(f5_local24, true)
	local f5_local25 = 1000
	local f5_local26 = f5_local25 * 60
	f5_local24:setTimeStart(2 * f5_local26 * 60 + 59 * f5_local26 + 57 * f5_local25)
end

CoD.CCTVHud.UpdateVisibility = function (f6_arg0, f6_arg1)
	if UIExpression.IsVisibilityBitSet(f6_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f6_arg0.visible ~= true then
			f6_arg0:setAlpha(CoD.CCTVHud.DefaultAlpha)
			f6_arg0.visible = true
		end
	elseif f6_arg0.visible == true then
		f6_arg0:setAlpha(0)
		f6_arg0.visible = nil
	end
	f6_arg0:dispatchEventToChildren(f6_arg1)
end

