require("T6.Menus.EmblemEditorColorsSwatch")
require("T6.Menus.EmblemEditorColorsRGB")
CoD.EmblemEditorColors = {}
CoD.EmblemEditorColors.WindowWidth = 600
CoD.EmblemEditorColors.WindowHeight = 160
CoD.EmblemEditorColors.CreateWindow = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.EmblemEditorColors.WindowWidth / 2, CoD.EmblemEditorColors.WindowWidth / 2)
	Widget:setTopBottom(false, true, -70 - CoD.EmblemEditorColors.WindowHeight, -90)
	HudRef:addElement(Widget)
	Widget.emblemEditor = HudRef
	HudRef.colorWindow = Widget
	HudRef:setTitle(Engine.Localize("MENU_EMBLEM_COLOR_PICKER_CAPS"))
	CoD.EmblemEditorColors.AddButtonPrompts(HudRef, InstanceRef)
	HudRef.colorWindow.swatch = CoD.EmblemEditorColorsSwatch.PrepareColorSwatches(HudRef.colorWindow, InstanceRef)
	HudRef.colorWindow:addElement(HudRef.colorWindow.swatch)
	Engine.ExecNow(InstanceRef, "emblemSetRGBTweakedColor")
end

CoD.EmblemEditorColors.AddButtonPrompts = function (f2_arg0, f2_arg1)
	f2_arg0.buttonPromptList:removeAllChildren()
	CoD.EmblemEditorColors.AddSelectButtonPrompt(f2_arg0)
	CoD.EmblemEditorColors.AddBackButtonPrompt(f2_arg0)
	CoD.EmblemEditorColorsSwatch.CreateButtonPrompts(f2_arg0)
	CoD.EmblemEditorColorsRGB.CreateButtonPrompts(f2_arg0)
	Engine.ExecNow(f2_arg1, "emblemEndEdit")
end

CoD.EmblemEditorColors.Back = function (f3_arg0, f3_arg1)
	local f3_local0 = Engine.GetSelectedLayerColor(f3_arg1.controller)
	Engine.ExecNow(controller, "emblemSetRecentColorRGBA " .. f3_local0.red .. " " .. f3_local0.green .. " " .. f3_local0.blue .. " " .. f3_local0.alpha)
	f3_arg0.colorWindow:close()
	f3_arg0.cardCarouselList.m_inputDisabled = nil
	f3_arg0.cardCarouselList:show()
	local f3_local1 = CoD.EmblemEditor.GetSelectedCard(f3_arg0)
	CoD.EmblemEditor.AnimateBottomLayerText(f3_arg0, f3_local1.cardIndex - 1)
	f3_arg0.buttonPromptList:removeAllChildren()
	f3_arg0.rightButtonPromptBar:removeAllChildren()
	f3_arg0.leftButtonPromptBar:removeAllChildren()
	CoD.EmblemEditor.EmblemPaneSelected(f3_arg0, true)
	CoD.EmblemEditor.AddEmblemEditorButtons(f3_arg0)
	Engine.ExecNow(f3_arg1.controller, "emblemBeginEdit")
end

CoD.EmblemEditorColors.AddBackButtonPrompt = function (f4_arg0)
	f4_arg0.colorBackButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), f4_arg0, "button_prompt_closeswatch")
	f4_arg0:registerEventHandler("button_prompt_closeswatch", CoD.EmblemEditorColors.Back)
	f4_arg0.closeColorOnYButton = CoD.ButtonPrompt.new("alt2", "", f4_arg0, "button_prompt_closeswatch", true)
	f4_arg0:addLeftButtonPrompt(f4_arg0.colorBackButton)
	f4_arg0:addLeftButtonPrompt(f4_arg0.closeColorOnYButton)
end

CoD.EmblemEditorColors.AddSelectButtonPrompt = function (f5_arg0)
	f5_arg0.confirmcolor = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_EMBLEM_CONFIRM_CHANGES"), f5_arg0, "button_prompt_confirmchanges")
	f5_arg0:registerEventHandler("button_prompt_confirmchanges", CoD.EmblemEditorColors.Back)
	f5_arg0:addLeftButtonPrompt(f5_arg0.confirmcolor)
end

