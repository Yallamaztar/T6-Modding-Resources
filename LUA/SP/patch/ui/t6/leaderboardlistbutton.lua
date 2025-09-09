CoD.LeaderboardListButton = {}
CoD.LeaderboardListButton.Height = 30
CoD.LeaderboardListButton.TextOffset = 5
CoD.LeaderboardListButton.TextHeight = CoD.textSize.Default
CoD.LeaderboardListButton.Font = CoD.fonts.Default
CoD.LeaderboardListButton.BackgroundColor = {
	r = 1,
	g = 1,
	b = 1,
	a = 0
}
local f0_local0 = function (f1_arg0, f1_arg1)
	Engine.PlaySound("uin_navigation_click")
end

CoD.LeaderboardListButton.SetupTextElement = function (f2_arg0)
	f2_arg0:registerAnimationState("disabled", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5
	})
	f2_arg0:registerAnimationState("button_over", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f2_arg0:registerAnimationState("button_over_disabled", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5
	})
	LUI.UIButton.SetupElement(f2_arg0)
end

CoD.LeaderboardListButton.new = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = LUI.UIButton.new(f3_arg2, f3_arg3)
	f3_local0.id = "LeaderboardListButton"
	f3_local0.serverIndex = f3_arg0 - 1
	local f3_local1 = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.LeaderboardListButton.BackgroundColor.r,
		green = CoD.LeaderboardListButton.BackgroundColor.g,
		blue = CoD.LeaderboardListButton.BackgroundColor.b,
		alpha = CoD.LeaderboardListButton.BackgroundColor.a,
		material = RegisterMaterial("menu_mp_lobby_bar_name")
	})
	f3_local1:registerAnimationState("button_over", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5
	})
	LUI.UIButton.SetupElement(f3_local1)
	f3_local0.background = f3_local1
	f3_local0:addElement(f3_local1)
	local f3_local2 = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.LeaderboardList.ColumnSpacing
	})
	f3_local2:addSpacer(CoD.LeaderboardListButton.TextOffset)
	for f3_local7, f3_local8 in ipairs(f3_arg1) do
		local f3_local6 = nil
		if f3_local7 ~= 2 or true == CoD.isZombie then
			f3_local6 = LUI.UIText.new({
				left = 0,
				top = -CoD.LeaderboardListButton.TextHeight / 2,
				right = CoD.LeaderboardList.ColumnWidth[f3_local7],
				bottom = CoD.LeaderboardListButton.TextHeight / 2,
				red = 1,
				green = 1,
				blue = 1,
				alpha = 1,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = false,
				font = CoD.LeaderboardListButton.Font
			})
			f3_local6:setText(f3_local8.col)
			CoD.LeaderboardListButton.SetupTextElement(f3_local6)
		else
			f3_local6 = LUI.UIImage.new({
				left = 0,
				top = 0,
				right = CoD.LeaderboardList.ColumnWidth[f3_local7],
				bottom = CoD.LeaderboardListButton.TextHeight + 5,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false,
				alpha = 1,
				material = RegisterMaterial(f3_local8.col)
			})
		end
		f3_local2:addElement(f3_local6)
	end
	f3_local0:addElement(f3_local2)
	Widget = LUI.UIElement.new()
	f3_local0:addElement(Widget)
	Widget:registerEventHandler("gain_focus", f0_local0)
	return f3_local0
end

