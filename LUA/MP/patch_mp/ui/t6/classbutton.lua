CoD.ClassButton = {}
CoD.ClassButton.ButtonSize = 90
CoD.ClassButton.LabelSize = CoD.textSize.Default
CoD.ClassButton.FadeTime = 100
CoD.ClassButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	local f1_local0 = LUI.UIButton.new(f1_arg3, f1_arg5)
	if f1_arg4 == nil then
		f1_arg4 = CoD.ClassButton.ButtonSize
	end
	local f1_local1 = 4
	local f1_local2 = f1_arg4 - CoD.ClassButton.LabelSize
	local f1_local3 = f1_local2 - f1_local1 * 2
	local f1_local4 = f1_local3 * 0.75
	local f1_local5 = f1_local2 / 2 - f1_arg4 / 2
	f1_local0.iconMaterial = f1_arg1
	f1_local0.icon = LUI.UIImage.new({
		left = -f1_local4 / 2,
		top = f1_local5 - f1_local4 / 2,
		right = f1_local4 / 2,
		bottom = f1_local5 + f1_local4 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		material = f1_arg1,
		alpha = 0.5
	})
	f1_local0:addElement(f1_local0.icon)
	LUI.UIButton.SetupElement(f1_local0.icon)
	f1_local0.icon:registerAnimationState("button_over", {
		left = -f1_local3 / 2,
		top = f1_local5 - f1_local3 / 2,
		right = f1_local3 / 2,
		bottom = f1_local5 + f1_local3 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 1
	})
	f1_local0.icon.upDuration = CoD.ClassButton.FadeTime
	f1_local0.icon.overDuration = CoD.ClassButton.FadeTime
	f1_local0.classNumInternal = f1_arg2
	f1_local0.label = LUI.UIText.new({
		left = 0,
		top = -f1_local1 - CoD.ClassButton.LabelSize,
		right = 0,
		bottom = -f1_local1,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.25
	})
	f1_local0:addElement(f1_local0.label)
	LUI.UIButton.SetupElement(f1_local0.label)
	f1_local0.label:registerAnimationState("button_over", {
		alpha = 1
	})
	local f1_local6 = f1_local0.label
	local f1_local7 = f1_local6
	f1_local6 = f1_local6.setText
	local f1_local8 = CoD.CACUtility.GetLoadoutNameFromIndex(f1_arg0, f1_arg2)
	f1_local6(f1_local7, f1_local8:get())
	f1_local0.label.upDuration = CoD.ClassButton.FadeTime
	f1_local0.label.overDuration = CoD.ClassButton.FadeTime
	f1_local0:registerEventHandler("button_over", CoD.ClassButton.Over)
	f1_local0:registerEventHandler("button_prompt_rename", CoD.ClassButton.Rename)
	f1_local0:registerEventHandler("button_prompt_copy", CoD.ClassButton.Copy)
	f1_local0.classData = CoD.CACUtility.GetClassData(f1_arg0, f1_arg2)
	return f1_local0
end

CoD.ClassButton.Over = function (f2_arg0, f2_arg1)
	LUI.UIButton.Over(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.navOverlay
	if f2_local0 == nil then
		return 
	end
	local f2_local1 = f2_local0.classBackground
	local f2_local2 = f2_arg0.iconMaterial
	if f2_local1 ~= nil and f2_local2 ~= nil then
		f2_local1:registerAnimationState("material_change", {
			material = f2_local2,
			alpha = 0.1
		})
		f2_local1:animateToState("material_change")
	end
	local f2_local3 = f2_arg0.classData
	if f2_local3 == nil then
		return 
	end
	CoD.UpdateUIFromClassData(f2_local3, f2_local0)
end

CoD.ClassButton.Rename = function (f3_arg0, f3_arg1)
	if f3_arg0:isInFocus() then
		f3_arg0:registerEventHandler("ui_keyboard_input", CoD.ClassButton.Renamed)
		local f3_local0 = CoD.CACUtility.GetLoadoutNameFromIndex(f3_arg1.controller, f3_arg0.classNumInternal)
		f3_local0 = f3_local0:get()
		f3_arg0.controller = f3_arg1.controller
		Engine.SetDvar("ui_custom_name", f3_local0)
		Engine.Exec(f3_arg1.controller, "ui_keyboard MENU_CUSTOMCLASS_KEYBOARD ui_custom_name")
	end
end

CoD.ClassButton.Renamed = function (f4_arg0, f4_arg1)
	f4_arg0:registerEventHandler("ui_keyboard_input", nil)
	local f4_local0 = f4_arg1.input
	if f4_local0 ~= nil then
		local f4_local1 = CoD.CACUtility.GetLoadoutNameFromIndex(f4_arg0.controller, f4_arg0.classNumInternal)
		f4_local1:set(f4_local0)
		f4_arg0.label:setText(f4_local0)
	end
	f4_arg0.controller = nil
end

CoD.ClassButton.Copy = function (f5_arg0, f5_arg1)
	if f5_arg0:isInFocus() then
		Engine.SetDvar("ui_custom_class_highlighted", f5_arg0.classNumInternal)
		f5_arg0.controller = f5_arg1.controller
		f5_arg0.navOverlay.frame:replaceOverlay(f5_arg1.controller, f5_arg0.navOverlay, "CACCopyClassNavOverlay")
	end
end

