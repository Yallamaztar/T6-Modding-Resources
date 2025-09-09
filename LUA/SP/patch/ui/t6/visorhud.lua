CoD.VisorHud = {}
CoD.VisorHud.VisorDefaultAlpha = 0.7
CoD.VisorHud.VisorTextDefaultAlpha = 0.25
CoD.VisorHud.FontName = "Big"
CoD.VisorHud.Margin = 20
CoD.VisorHud.new = function ()
	local f1_local0 = RegisterMaterial("menu_visor_grid_top")
	local f1_local1 = RegisterMaterial("menu_visor_grid_bottom")
	local f1_local2 = RegisterMaterial("menu_visor_grid_left")
	local f1_local3 = RegisterMaterial("menu_visor_grid_right")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.id = Widget.id .. ".VisorHud"
	local f1_local5 = 1280 + 2 * CoD.VisorHud.Margin
	local f1_local6 = 159 + CoD.VisorHud.Margin
	local f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(false, false, -f1_local5 / 2, f1_local5 / 2)
	f1_local7:setTopBottom(true, false, -CoD.VisorHud.Margin, -CoD.VisorHud.Margin + f1_local6)
	f1_local7:setImage(f1_local0)
	f1_local7:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
	f1_local7.id = f1_local7.id .. ".VisorImageTop"
	Widget:addElement(f1_local7)
	local f1_local8 = LUI.UIImage.new()
	f1_local8:setLeftRight(false, false, -f1_local5 / 2, f1_local5 / 2)
	f1_local8:setTopBottom(false, true, CoD.VisorHud.Margin - f1_local6, CoD.VisorHud.Margin)
	f1_local8:setImage(f1_local1)
	f1_local8:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
	f1_local8.id = f1_local8.id .. ".VisorImageBottom"
	Widget:addElement(f1_local8)
	local f1_local9 = 107 + CoD.VisorHud.Margin
	local f1_local10 = 402
	local f1_local11 = LUI.UIImage.new()
	f1_local11:setLeftRight(true, false, -CoD.VisorHud.Margin, -CoD.VisorHud.Margin + f1_local9)
	f1_local11:setTopBottom(false, false, -f1_local10 / 2, f1_local10 / 2)
	f1_local11:setImage(f1_local2)
	f1_local11:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
	f1_local11.id = f1_local11.id .. ".VisorImageLeft"
	Widget:addElement(f1_local11)
	local f1_local12 = LUI.UIImage.new()
	f1_local12:setLeftRight(false, true, CoD.VisorHud.Margin - f1_local9, CoD.VisorHud.Margin)
	f1_local12:setTopBottom(false, false, -f1_local10 / 2, f1_local10 / 2)
	f1_local12:setImage(f1_local3)
	f1_local12:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
	f1_local12.id = f1_local12.id .. ".VisorImageRight"
	Widget:addElement(f1_local12)
	local f1_local13 = LUI.UIText.new()
	f1_local13:setLeftRight(true, true, 0, 0)
	f1_local13:setTopBottom(true, false, 0, CoD.textSize[CoD.VisorHud.FontName])
	f1_local13:setAlpha(CoD.VisorHud.VisorTextDefaultAlpha)
	f1_local13:setFont(CoD.fonts[CoD.VisorHud.FontName])
	f1_local13.id = f1_local13.id .. ".VisorText"
	Widget:addElement(f1_local13)
	Widget.setVisorText = CoD.VisorHud.SetVisorText
	Widget:registerEventHandler("bootup_init", CoD.VisorHud.BootupInit)
	Widget:registerEventHandler("bootup_saving", CoD.VisorHud.BootupSaving)
	Widget:registerEventHandler("bootup_end", CoD.VisorHud.BootupEnd)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.VisorHud.BootupSwitchToHud)
	Widget.visorImageTop = f1_local7
	Widget.visorImageBottom = f1_local8
	Widget.visorImageLeft = f1_local11
	Widget.visorImageRight = f1_local12
	Widget.visorText = f1_local13
	return Widget
end

CoD.VisorHud.SetVisorText = function (f2_arg0, f2_arg1)
	f2_arg0.visorText.textValue = f2_arg1
	if f2_arg1 == "" then
		f2_arg0.visorText:setText("")
		return 
	else
		f2_arg0.visorText:setText("/// " .. f2_arg1 .. " ///")
	end
end

CoD.VisorHud.BootupInit = function (f3_arg0, f3_arg1)
	f3_arg0:setVisorText(Engine.Localize("MENU_INITIALIZING_CAPS"))
end

CoD.VisorHud.BootupSaving = function (f4_arg0, f4_arg1)
	f4_arg0:setVisorText(Engine.Localize("MENU_SAVING_CAPS"))
end

CoD.VisorHud.BootupEnd = function (f5_arg0, f5_arg1)
	f5_arg0:setVisorText("")
end

CoD.VisorHud.BootupSwitchToHud = function (f6_arg0, f6_arg1)
	f6_arg0:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
end

