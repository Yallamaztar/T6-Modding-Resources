require("T6.CoD9Button")
if CoD == nil then
	CoD = {}
end
CoD.ButtonPrompt = {}
CoD.ButtonPrompt.FontName = "ExtraSmall"
CoD.ButtonPrompt.Height = 25
CoD.ButtonPrompt.TextHeight = CoD.textSize[CoD.ButtonPrompt.FontName]
CoD.ButtonPrompt.ButtonToTextSpacing = 3
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.disabled = nil
	f1_arg0:animateToState("enabled")
	f1_arg0:dispatchEventToChildren(f1_arg1)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0.disabled = true
	f2_arg0:animateToState("disabled")
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.ButtonPrompt.Enable = function (f3_arg0)
	f3_arg0:processEvent({
		name = "enable"
	})
end

CoD.ButtonPrompt.Disable = function (f4_arg0)
	f4_arg0:processEvent({
		name = "disable"
	})
end

CoD.ButtonPrompt.SetupElement = function (f5_arg0)
	f5_arg0:registerEventHandler("enable", f0_local0)
	f5_arg0:registerEventHandler("disable", f0_local1)
end

CoD.ButtonPrompt.new = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	local f6_local0 = CoD.ButtonPrompt.Height
	local f6_local1 = CoD.ButtonPrompt.TextHeight
	local f6_local2 = CoD.fonts[CoD.ButtonPrompt.FontName]
	local Widget = LUI.UIElement.new()
	Widget:setTopBottom(false, false, -f6_local0 / 2, f6_local0 / 2)
	Widget.button = f6_arg0
	Widget.enable = CoD.ButtonPrompt.Enable
	Widget.disable = CoD.ButtonPrompt.Disable
	Widget.setNew = CoD.ButtonPrompt.SetNew
	Widget.setText = CoD.ButtonPrompt.SetText
	CoD.ButtonPrompt.SetupElement(Widget)
	Widget:registerAnimationState("enabled", {
		alpha = 1
	})
	Widget:registerAnimationState("disabled", {
		alpha = 1
	})
	if f6_arg8 then
		Widget.m_shortcut = true
	end
	if f6_arg2 ~= nil and f6_arg3 ~= nil then
		Widget:registerEventHandler("gamepad_button", function (f13_arg0, f13_arg1)
			if not f13_arg0.disabled and f13_arg1.down == true then
				if f13_arg1.button == f6_arg0 and (f6_arg5 == nil or f13_arg1.qualifier == f6_arg5) then
					if not f13_arg0.m_shortcut or Engine.LastInput_Gamepad() then
						f6_arg2:processEvent({
							name = f6_arg3,
							controller = f13_arg1.controller
						})
						return true
					end
				elseif CoD.isPC and f13_arg1.button == "key_shortcut" and (f13_arg1.key == f6_arg8 or f13_arg1.bind1 == f6_arg9) then
					f6_arg2:processEvent({
						name = f6_arg3,
						controller = f13_arg1.controller
					})
					return true
				end
			end
		end)
	end
	local f6_local4 = LUI.UIText.new()
	f6_local4:setTopBottom(false, false, -f6_local1 / 2, f6_local1 / 2)
	f6_local4:setFont(f6_local2)
	f6_local4:setAlpha(1)
	f6_local4:registerAnimationState("enabled", {
		alpha = 1
	})
	f6_local4:registerAnimationState("disabled", {
		alpha = 0.5
	})
	CoD.ButtonPrompt.SetupElement(f6_local4)
	Widget:addElement(f6_local4)
	f6_local4:setText(f6_arg1)
	Widget.label = f6_local4
	Widget.labelText = f6_arg1
	local f6_local5 = nil
	if not f6_arg4 then
		f6_local5 = LUI.UIText.new()
		f6_local5:setTopBottom(false, false, -f6_local0 / 2, f6_local0 / 2)
		f6_local5:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
		f6_local5:setFont(f6_local2)
		f6_local5:setAlpha(1)
		if f6_local5 ~= nil then
			if CoD.isPC then
				if f6_arg8 ~= nil then
					f6_local5.shortcutKey = f6_arg8
				end
				if f6_arg7 ~= nil then
					f6_local5.buttonStringShortCut = f6_arg7
				else
					f6_local5.buttonStringShortCut = f6_arg0
				end
			end
			local f6_local6 = nil
			if CoD.useController and Engine.LastInput_Gamepad() then
				f6_local6 = CoD.buttonStrings[f6_arg0]
			elseif CoD.isPC then
				if f6_arg8 then
					f6_local6 = f6_arg8
				elseif string.sub(CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 1, 1) == "+" then
					f6_local6 = Engine.GetKeyBindingLocalizedString(0, CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 0)
				elseif string.sub(CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 1, 1) == "@" then
					f6_local6 = Engine.Localize(string.sub(CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 2))
				else
					f6_local6 = CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut]
				end
			end
			f6_local5:setText(f6_local6)
			Widget.prompt = f6_local6
			f6_local5:registerAnimationState("enabled", {
				alpha = 1
			})
			f6_local5:registerAnimationState("disabled", {
				alpha = 0.25
			})
			CoD.ButtonPrompt.SetupElement(f6_local5)
			Widget.buttonImage = f6_local5
			Widget:addElement(f6_local5)
		end
	end
	if CoD.useMouse and (f6_local5 ~= nil or f6_arg1 ~= "") then
		local f6_local6 = LUI.UIButton.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		})
		if f6_local5 ~= nil and isDualButton then
			f6_local5:addElement(f6_local6)
		else
			Widget:addElement(f6_local6)
		end
		if f6_arg2 ~= nil and f6_arg3 ~= nil then
			f6_local6:registerEventHandler("button_action", function (f14_arg0, f14_arg1)
				f6_arg2:processEvent({
					name = f6_arg3,
					controller = f14_arg1.controller
				})
				return true
			end)
		end
		f6_local6:setHandleMouseMove(false)
		Widget:setHandleMouseMove(true)
		Widget:registerEventHandler("mouseenter", CoD.ButtonPrompt.MouseEnter)
		Widget:registerEventHandler("mouseleave", CoD.ButtonPrompt.MouseLeave)
		Widget:registerEventHandler("input_source_changed", CoD.ButtonPrompt.InputSourceChanged)
	end
	CoD.ButtonPrompt.ResizeButtonPrompt(Widget)
	return Widget
end

CoD.ButtonPrompt.ResizeButtonPrompt = function (f7_arg0)
	local f7_local0 = CoD.ButtonPrompt.ButtonToTextSpacing
	local f7_local1 = CoD.ButtonPrompt.Height
	local f7_local2 = CoD.ButtonPrompt.TextHeight
	local f7_local3 = CoD.fonts[CoD.ButtonPrompt.FontName]
	local f7_local4 = {}
	f7_local4 = GetTextDimensions(f7_arg0.labelText, f7_local3, f7_local2)
	local f7_local5 = f7_local4[3] - f7_local4[1]
	f7_arg0.label:setLeftRight(false, true, -f7_local5, 0)
	f7_local0 = f7_local0 + f7_local5
	if f7_arg0.prompt ~= nil then
		local f7_local6 = nil
		if string.sub(f7_arg0.prompt, 1, 2) == "^B" and not f7_arg0.forceMeasureButtonWidth then
			f7_local6 = CoD.ButtonPrompt.Height
		else
			local f7_local7 = {}
			f7_local7 = GetTextDimensions(f7_arg0.prompt, f7_local3, f7_local1)
			f7_local6 = f7_local7[3] - f7_local7[1]
		end
		f7_arg0.buttonImage:setLeftRight(true, false, 0, f7_local6)
		f7_local0 = f7_local0 + f7_local6
	end
	if f7_arg0.newIcon then
		local f7_local6 = 5
		f7_local0 = f7_local0 + f7_local6
		f7_arg0.newIcon:setLeftRight(true, false, f7_local0, f7_local0 + CoD.CACUtility.ButtonGridNewImageWidth)
		f7_arg0.label:setLeftRight(false, true, -f7_local5 - CoD.CACUtility.ButtonGridNewImageRightAlignWidth - f7_local6, -CoD.CACUtility.ButtonGridNewImageRightAlignWidth - f7_local6)
		f7_local0 = f7_local0 + CoD.CACUtility.ButtonGridNewImageRightAlignWidth
	end
	f7_arg0:setLeftRight(true, false, 0, f7_local0)
end

CoD.ButtonPrompt.InputSourceChanged = function (f8_arg0, f8_arg1)
	if f8_arg0.buttonImage == nil then
		return 
	elseif CoD.useMouse then
		if CoD.useController and f8_arg1.source == 0 then
			f8_arg0.prompt = CoD.buttonStrings[f8_arg0.button]
			f8_arg0.buttonImage:setText(f8_arg0.prompt)
		else
			if f8_arg0.buttonImage.shortcutKey then
				f8_arg0.prompt = f8_arg0.buttonImage.shortcutKey
			elseif string.sub(CoD.buttonStringsShortCut[f8_arg0.buttonImage.buttonStringShortCut], 1, 1) == "+" then
				f8_arg0.prompt = Engine.GetKeyBindingLocalizedString(0, CoD.buttonStringsShortCut[f8_arg0.buttonImage.buttonStringShortCut], 0)
			elseif string.sub(CoD.buttonStringsShortCut[f8_arg0.buttonImage.buttonStringShortCut], 1, 1) == "@" then
				f8_arg0.prompt = Engine.Localize(string.sub(CoD.buttonStringsShortCut[f8_arg0.buttonImage.buttonStringShortCut], 2))
			else
				f8_arg0.prompt = CoD.buttonStringsShortCut[f8_arg0.buttonImage.buttonStringShortCut]
			end
			f8_arg0.buttonImage:setText(f8_arg0.prompt)
		end
		CoD.ButtonPrompt.ResizeButtonPrompt(f8_arg0)
	end
end

CoD.ButtonPrompt.SetNew = function (f9_arg0, f9_arg1)
	if f9_arg1 then
		if not f9_arg0.newIcon then
			local newIcon = LUI.UIImage.new()
			newIcon:setLeftRight(true, false, 0, CoD.CACUtility.ButtonGridNewImageWidth)
			newIcon:setTopBottom(false, false, -CoD.CACUtility.ButtonGridNewImageHeight / 2, CoD.CACUtility.ButtonGridNewImageHeight / 2)
			newIcon:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
			f9_arg0:addElement(newIcon)
			f9_arg0.newIcon = newIcon
			
		end
	elseif f9_arg0.newIcon then
		f9_arg0.newIcon:close()
		f9_arg0.newIcon = nil
	end
	CoD.ButtonPrompt.ResizeButtonPrompt(f9_arg0)
end

CoD.ButtonPrompt.SetText = function (f10_arg0, f10_arg1)
	f10_arg0.label:setText(f10_arg1)
	f10_arg0.labelText = f10_arg1
	CoD.ButtonPrompt.ResizeButtonPrompt(f10_arg0)
end

CoD.ButtonPrompt.MouseEnter = function (f11_arg0, f11_arg1)
	if f11_arg0.buttonImage == nil then
		return 
	else
		f11_arg0.buttonImage:beginAnimation("pop", 50)
		f11_arg0.buttonImage:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	end
end

CoD.ButtonPrompt.MouseLeave = function (f12_arg0, f12_arg1)
	if f12_arg0.buttonImage == nil then
		return 
	else
		local f12_local0 = CoD.ButtonPrompt.TextHeight
		f12_arg0.buttonImage:beginAnimation("default", 50)
		f12_arg0.buttonImage:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	end
end

