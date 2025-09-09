require("T6.Menus.EmblemEditorColorsRGB")
CoD.EmblemEditorColorsSwatch = {}
CoD.EmblemEditorColorsSwatch.TotalRows = 9
CoD.EmblemEditorColorsSwatch.TotalColumns = 13
CoD.EmblemEditorColorsSwatch.ResetToLastSavedColor = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg0.colorWindow.colorSwatch
	f1_local0.selectedRow = 0
	f1_local0.selectedColumn = 0
	f1_local0.totalRows = CoD.EmblemEditorColorsSwatch.TotalRows
	f1_local0.totalColumns = CoD.EmblemEditorColorsSwatch.TotalColumns
	Engine.ExecNow(f1_arg1.controller, "emblemRevertColorChanges")
	f1_local0:setupColorSwatch(f1_local0.selectedRow, f1_local0.selectedColumn, f1_local0.totalRows, f1_local0.totalColumns)
end

CoD.EmblemEditorColorsSwatch.SetupGamepadButton = function (f2_arg0)
	f2_arg0.leftRepeater = LUI.UIButtonRepeater.new("left", {
		name = "gamepad_button",
		button = "left",
		down = true,
		qualifier = "dpad"
	})
	f2_arg0.rightRepeater = LUI.UIButtonRepeater.new("right", {
		name = "gamepad_button",
		button = "right",
		down = true,
		qualifier = "dpad"
	})
	f2_arg0:addElement(f2_arg0.leftRepeater)
	f2_arg0:addElement(f2_arg0.rightRepeater)
	f2_arg0.upRepeater = LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true,
		qualifier = "dpad"
	})
	f2_arg0.downRepeater = LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true,
		qualifier = "dpad"
	})
	f2_arg0:addElement(f2_arg0.upRepeater)
	f2_arg0:addElement(f2_arg0.downRepeater)
	f2_arg0:registerEventHandler("selection_clicked", CoD.EmblemEditorColorsSwatch.ColorSwatch_SelectionClicked)
	f2_arg0.handleGamepadButton = CoD.EmblemEditorColorsSwatch.HandleGamepadButton
end

CoD.EmblemEditorColorsSwatch.PrepareColorSwatches = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.selectedRow = 0
	Widget.selectedColumn = 0
	Widget.totalRows = CoD.EmblemEditorColorsSwatch.TotalRows
	Widget.totalColumns = CoD.EmblemEditorColorsSwatch.TotalColumns
	Widget:setupColorSwatch(Widget.selectedRow, Widget.selectedColumn, Widget.totalRows, Widget.totalColumns)
	HudRef.colorSwatch = Widget
	CoD.EmblemEditorColorsSwatch.SetupGamepadButton(Widget)
	CoD.EmblemEditorColorsSwatch.AddButtonPrompts(HudRef.emblemEditor)
	return Widget
end

CoD.EmblemEditorColorsSwatch.SetSwatchRowColumn = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg1.selectedColumn == 0 and f4_arg3 ~= 0 then
		return 
	end
	local f4_local0 = f4_arg1.selectedRow + f4_arg3
	local f4_local1 = f4_arg1.selectedColumn + f4_arg2
	if f4_arg1.totalRows - 1 < f4_local0 then
		f4_local0 = f4_local0 % f4_arg1.totalRows
	elseif f4_local0 < 0 then
		f4_local0 = f4_local0 + f4_arg1.totalRows
	end
	if f4_arg1.totalColumns < f4_local1 then
		f4_local1 = f4_local1 % (f4_arg1.totalColumns + 1)
	elseif f4_local1 < 0 then
		f4_local1 = f4_local1 + f4_arg1.totalColumns + 1
	end
	f4_arg1.selectedRow = f4_local0
	f4_arg1.selectedColumn = f4_local1
	if f4_local1 > 0 then
		Engine.ExecNow(f4_arg0, "emblemSetLayerColorFromSwatch " .. f4_local0 .. " " .. f4_local1 - 1 .. " " .. f4_arg1.totalRows .. " " .. f4_arg1.totalColumns)
	end
end

CoD.EmblemEditorColorsSwatch.ColorSwatch_SelectionClicked = function (f5_arg0, f5_arg1)
	f5_arg0.selectedRow = f5_arg1.row
	f5_arg0.selectedColumn = f5_arg1.column
	if f5_arg1.column > 0 then
		Engine.ExecNow(f5_arg1.controller, "emblemSetLayerColorFromSwatch " .. f5_arg1.row .. " " .. f5_arg1.column - 1 .. " " .. f5_arg0.totalRows .. " " .. f5_arg0.totalColumns)
	end
	f5_arg0:setupColorSwatch(f5_arg0.selectedRow, f5_arg0.selectedColumn, f5_arg0.totalRows, f5_arg0.totalColumns)
end

CoD.EmblemEditorColorsSwatch.HandleGamepadButton = function (f6_arg0, f6_arg1)
	if LUI.UIElement.handleGamepadButton(f6_arg0, f6_arg1) == true then
		return true
	elseif f6_arg1.qualifier == "mwheel" then
		return true
	end
	local f6_local0 = 0
	local f6_local1 = 0
	if f6_arg1.down == true then
		if f6_arg1.button == "right" then
			f6_local0 = 1
		elseif f6_arg1.button == "left" then
			f6_local0 = -1
		elseif f6_arg1.button == "up" then
			f6_local1 = -1
		elseif f6_arg1.button == "down" then
			f6_local1 = 1
		end
		Engine.PlaySound("cac_grid_nav")
	end
	CoD.EmblemEditorColorsSwatch.SetSwatchRowColumn(f6_arg1.controller, f6_arg0, f6_local0, f6_local1)
	f6_arg0:setupColorSwatch(f6_arg0.selectedRow, f6_arg0.selectedColumn, f6_arg0.totalRows, f6_arg0.totalColumns)
end

CoD.EmblemEditorColorsSwatch.SwitchToColorMixer = function (f7_arg0, f7_arg1)
	f7_arg0.colorWindow.swatch:close()
	if f7_arg0.colorWindow.colormixer then
		f7_arg0.colorWindow.colormixer:close()
	end
	f7_arg0.colorWindow.colormixer = CoD.EmblemEditorColorsRGB.PrepareRGBWindow(f7_arg0.colorWindow, f7_arg1.controller)
	f7_arg0.colorWindow:addElement(f7_arg0.colorWindow.colormixer)
end

CoD.EmblemEditorColorsSwatch.CreateButtonPrompts = function (f8_arg0)
	f8_arg0.chooseSwatch = CoD.ButtonPrompt.new("emblem_move", Engine.Localize("MENU_EMBLEM_CHANGE_COLOR"))
	local f8_local0 = CoD.ButtonPrompt.new
	local f8_local1 = "start"
	local f8_local2 = Engine.Localize("MENU_EMBLEM_TOGGLE_TO_COLOR_MIXER")
	local f8_local3 = f8_arg0
	local f8_local4 = "button_prompt_colormixer"
	local f8_local5, f8_local6 = false
	local f8_local7, f8_local8 = false
	f8_arg0.colormixer = f8_local0(f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7, f8_local8, "E")
	f8_arg0:registerEventHandler("button_prompt_colormixer", CoD.EmblemEditorColorsSwatch.SwitchToColorMixer)
end

CoD.EmblemEditorColorsSwatch.AddButtonPrompts = function (f9_arg0)
	f9_arg0.buttonPromptList:removeAllChildren()
	if Engine.LastInput_Gamepad() then
		f9_arg0:addButtonPrompt(f9_arg0.chooseSwatch)
		CoD.EmblemEditor.AddOpacityButtonPrompts(f9_arg0)
	end
	f9_arg0:addButtonPrompt(f9_arg0.colormixer)
	if CoD.isPC then
		CoD.EmblemEditor.RefreshPromptInputSource(f9_arg0)
	end
end

