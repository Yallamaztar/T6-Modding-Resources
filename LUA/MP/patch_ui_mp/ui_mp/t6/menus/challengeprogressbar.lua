CoD.ChallengeProgressBar = {}
CoD.ChallengeProgressBar.FontName = "Default"
CoD.ChallengeProgressBar.Font = CoD.fonts[CoD.ChallengeProgressBar.FontName]
CoD.ChallengeProgressBar.FontHeight = CoD.textSize[CoD.ChallengeProgressBar.FontName]
CoD.ChallengeProgressBar.FontAlpha = 0.4
CoD.ChallengeProgressBar.FillInset = 2
CoD.ChallengeProgressBar.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	Widget.width = InstanceRef
	Widget.update = CoD.ChallengeProgressBar.Update
	local f1_local1 = LUI.UIText.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, false, 0, CoD.ChallengeProgressBar.FontHeight)
	f1_local1:setAlpha(CoD.ChallengeProgressBar.FontAlpha)
	f1_local1:setAlignment(LUI.Alignment.Left)
	f1_local1:setFont(CoD.ChallengeProgressBar.Font)
	f1_local1:setText(Engine.Localize("MPUI_PROGRESS"))
	Widget:addElement(f1_local1)
	local f1_local2 = CoD.ChallengeProgressBar.FontHeight + 2
	Widget.barContainer = LUI.UIElement.new()
	Widget.barContainer:setLeftRight(true, true, 0, 0)
	Widget.barContainer:setTopBottom(true, false, f1_local2, f1_local2 + CoD.ChallengeProgressBar.FontHeight)
	Widget:addElement(Widget.barContainer)
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight(true, true, 1, -1)
	f1_local3:setTopBottom(true, true, 1, -1)
	f1_local3:setRGB(0, 0, 0)
	f1_local3:setAlpha(0.4)
	Widget.barContainer:addElement(f1_local3)
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(true, true, CoD.ChallengeProgressBar.FillInset, -CoD.ChallengeProgressBar.FillInset)
	f1_local4:setTopBottom(true, false, CoD.ChallengeProgressBar.FillInset, 12)
	f1_local4:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f1_local4:setAlpha(0.1)
	Widget.barContainer:addElement(f1_local4)
	Widget.barContainer:addElement(CoD.Border.new(1, 1, 1, 1, 0.05))
	Widget.fill = LUI.UIElement.new()
	Widget.fill:setLeftRight(true, false, CoD.ChallengeProgressBar.FillInset, -CoD.ChallengeProgressBar.FillInset)
	Widget.fill:setTopBottom(true, true, CoD.ChallengeProgressBar.FillInset, -CoD.ChallengeProgressBar.FillInset)
	Widget.barContainer:addElement(Widget.fill)
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(true, true, 0, 0)
	f1_local5:setTopBottom(true, true, 0, 0)
	f1_local5:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget.fill:addElement(f1_local5)
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(true, true, 0, 0)
	f1_local6:setTopBottom(true, false, 0, 12)
	f1_local6:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f1_local6:setAlpha(0.4)
	Widget.fill:addElement(f1_local6)
	Widget.nextLabel = LUI.UIText.new()
	Widget.nextLabel:setLeftRight(false, true, -50, 0)
	Widget.nextLabel:setTopBottom(true, false, -CoD.ChallengeProgressBar.FontHeight, 0)
	Widget.nextLabel:setAlpha(CoD.ChallengeProgressBar.FontAlpha)
	Widget.nextLabel:setAlignment(LUI.Alignment.Right)
	Widget.nextLabel:setFont(CoD.ChallengeProgressBar.Font)
	Widget.barContainer:addElement(Widget.nextLabel)
	return Widget
end

CoD.ChallengeProgressBar.Update = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = 0
	if f2_arg2 ~= nil then
		local f2_local1 = 0
		if f2_arg1 then
			f2_local1 = f2_arg1
		end
		f2_arg0.nextLabel:setText(Engine.Localize("MPUI_X_SLASH_Y", f2_local1, f2_arg2))
		local f2_local2 = (f2_arg0.width - CoD.ChallengeProgressBar.FillInset * 2) * f2_local1 / f2_arg2
		f2_arg0.fill:beginAnimation("fill")
		f2_arg0.fill:setLeftRight(true, false, CoD.ChallengeProgressBar.FillInset, f2_local2)
	end
end

