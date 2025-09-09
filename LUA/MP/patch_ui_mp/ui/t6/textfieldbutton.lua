CoD.TextFieldButton = {}
CoD.TextFieldButton.ButtonSetText = function (f1_arg0, f1_arg1)
	f1_arg0.label:setText(f1_arg1)
end

CoD.TextFieldButton.ConvertToStar = function (f2_arg0)
	if password == "" then
		password = Engine.Localize("MENU_EMPTY")
	end
	local f2_local0 = string.len(f2_arg0)
	local f2_local1 = ""
	for f2_local2 = 1, f2_local0, 1 do
		local f2_local5 = f2_local2
		f2_local1 = "*" .. f2_local1
	end
	return f2_local1
end

local f0_local0 = function (f3_arg0, f3_arg1)
	f3_arg0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f3_arg0:setAlpha(1)
end

local f0_local1 = function (f4_arg0, f4_arg1)
	f4_arg0:setRGB(1, 1, 1)
	f4_arg0:setAlpha(0.1)
end

CoD.TextFieldButton.new = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = LUI.UIButton.new({
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = 0,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	if f5_arg2 == nil then
		f5_arg2 = LUI.Alignment.Left
	end
	f5_local0.label = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 10,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = CoD.ButtonTextColor.r,
		green = CoD.ButtonTextColor.g,
		blue = CoD.ButtonTextColor.b,
		alpha = 1,
		font = CoD.CoD9Button.Font,
		alignment = f5_arg2
	})
	CoD.CoD9Button.SetupTextElement(f5_local0.label)
	f5_local0:addElement(f5_local0.label)
	local f5_local1 = LUI.UIImage.new()
	f5_local1:setLeftRight(true, true, 0, 0)
	f5_local1:setTopBottom(true, true, 0, 0)
	f5_local1:setRGB(0, 0, 0)
	f5_local1:setAlpha(0.3)
	f5_local1:setPriority(-110)
	f5_local0:addElement(f5_local1)
	f5_local0.highlight = CoD.Border.new(1, 1, 1, 1, 0.1)
	f5_local0.highlight:setPriority(100)
	f5_local0.highlight:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f5_local0.highlight:registerEventHandler("button_over", f0_local0)
	f5_local0.highlight:registerEventHandler("button_up", f0_local1)
	f5_local0:addElement(f5_local0.highlight)
	f5_local0:setActionEventName(f5_arg1)
	CoD.TextFieldButton.ButtonSetText(f5_local0, f5_arg0)
	f5_local0.setText = CoD.TextFieldButton.ButtonSetText
	return f5_local0
end

