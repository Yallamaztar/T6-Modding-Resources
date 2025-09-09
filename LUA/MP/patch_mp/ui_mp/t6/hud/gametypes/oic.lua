local f0_local0 = nil
LUI.createMenu.gametype_oic = function (f1_arg0)
	local f1_local0 = CoD.GametypeBase.new("gametype_oic", f1_arg0)
	local f1_local1 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local1:setLeftRight(true, false, 0, 0)
	f1_local1:setTopBottom(true, false, 0, 0)
	f1_local0:addElement(f1_local1)
	local f1_local2 = CoD.GametypeBase.GametypeInfoTopOffset
	if Engine.IsSplitscreen() == true then
		f1_local2 = f1_local2 - 45
	end
	f1_local0.livesLeftText = LUI.UIText.new()
	f1_local0.livesLeftText:setLeftRight(true, false, CoD.GametypeBase.GametypeInfoLeftOffset, CoD.GametypeBase.GametypeInfoLeftOffset)
	f1_local0.livesLeftText:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize.ExtraSmall)
	f1_local0.livesLeftText:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.livesLeftText:setFont(CoD.fonts.ExtraSmall)
	f1_local1:addElement(f1_local0.livesLeftText)
	f1_local0:registerEventHandler("hud_update_refresh", f0_local0)
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1)
	CoD.GametypeBase.Refresh(f2_arg0, f2_arg1)
	local f2_local0 = UIExpression.GetNumLives(f2_arg1.controller)
	if f2_local0 > 1 then
		f2_arg0.livesLeftText:setText(Engine.Localize("MPUI_LIVES_LEFT", f2_local0))
	else
		f2_arg0.livesLeftText:setText(Engine.Localize("MPUI_ONE_LIFE_LEFT"))
	end
end

