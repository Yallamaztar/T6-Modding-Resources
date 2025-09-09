require("T6.ListBox")
require("T6.CoDBase")
require("T6.Menus.Leaderboard")
CoD.MissionLeaderboard = {}
CoD.MissionLeaderboard.NAME_XLEFT = 0
CoD.MissionLeaderboard.NAME_XRIGHT = 250
CoD.MissionLeaderboard.SCORE_XLEFT = CoD.MissionLeaderboard.NAME_XRIGHT
local f0_local0 = function (f1_arg0)
	f1_arg0:setAlpha(0)
end

local f0_local1 = function (f2_arg0)
	f2_arg0:setAlpha(1)
end

local f0_local2 = function ()
	local f3_local0 = {
		250,
		-1
	}
	local f3_local1 = {
		LUI.Alignment.Left,
		LUI.Alignment.Center
	}
	local f3_local2 = {}
	local f3_local3 = Engine.Localize("MENU_PLAYER_CAPS")
	local f3_local4 = Engine.Localize("MPUI_SCORE_CAPS")
	f3_local2 = f3_local3
	f3_local3 = CoD.fonts.Default
	f3_local4 = CoD.textSize.Default
	if CoD.isXBOX or CoD.isPS3 then
		f3_local2[1] = Engine.Localize("XBOXLIVE_PLAYER_CAPS")
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f3_local4)
	local f3_local6 = 0
	for f3_local10, f3_local11 in ipairs(f3_local0) do
		local f3_local12 = LUI.UIText.new()
		f3_local12:setFont(f3_local3)
		f3_local12:setRGB(CoD.visorBlue1.r, CoD.visorBlue1.g, CoD.visorBlue1.b)
		if f3_local11 >= 0 then
			f3_local12:setLeftRight(true, false, f3_local6, f3_local6 + f3_local11)
		else
			f3_local12:setLeftRight(true, true, f3_local6, 0)
		end
		f3_local12:setTopBottom(true, true, 0, 0)
		f3_local12:setAlignment(f3_local1[f3_local10])
		f3_local12:setText(f3_local2[f3_local10])
		Widget:addElement(f3_local12)
		f3_local6 = f3_local6 + f3_local11
	end
	return Widget
end

local f0_local3 = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = f4_arg2:getBodyUIElement()
	f4_local0.buttonBorder:close()
	f4_local0 = f4_arg2:getBodyUIElement()
	f4_local0:close()
	f4_arg2:disableZooming()
	f4_arg1.listBoxButton = f4_arg2
	f4_local0 = CoD.CoD9Button.Height
	local f4_local1 = Dvar.loc_language:get()
	if f4_local1 == CoD.LANGUAGE_FULLJAPANESE or f4_local1 == CoD.LANGUAGE_JAPANESE then
		f4_local0 = f4_local0 * 0.65
	end
	f4_arg1.name = LUI.UIText.new()
	f4_arg1.name:setLeftRight(true, false, CoD.Leaderboard.PADDING, CoD.MissionLeaderboard.NAME_XRIGHT - CoD.Leaderboard.PADDING)
	f4_arg1.name:setTopBottom(false, false, -f4_local0 / 2, f4_local0 / 2)
	f4_arg1.name:setFont(CoD.fonts.Default)
	f4_arg1.name:setAlignment(LUI.Alignment.Left)
	f4_arg1.name:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f4_arg1:addElement(f4_arg1.name)
	f4_arg1.scorebg = LUI.UIImage.new()
	f4_arg1.scorebg:setLeftRight(true, true, CoD.MissionLeaderboard.SCORE_XLEFT, 0)
	f4_arg1.scorebg:setTopBottom(true, false, 0, CoD.CoD9Button.Height)
	f4_arg1.scorebg:setRGB(1, 1, 1)
	f4_arg1.scorebg:setAlpha(0.03)
	f4_arg1:addElement(f4_arg1.scorebg)
	f4_arg1.score = LUI.UIText.new()
	f4_arg1.score:setLeftRight(true, true, CoD.MissionLeaderboard.SCORE_XLEFT + CoD.Leaderboard.PADDING, -CoD.Leaderboard.PADDING)
	f4_arg1.score:setTopBottom(false, false, -f4_local0 / 2, f4_local0 / 2)
	f4_arg1.score:setFont(CoD.fonts.Default)
	f4_arg1.score:setAlignment(LUI.Alignment.Center)
	f4_arg1.score:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f4_arg1:addElement(f4_arg1.score)
	f4_arg1.border = CoD.Border.new(1, 1, 1, 1, 0, -1)
	f4_arg1.border:setLeftRight(true, true, 0, 0)
	f4_arg1:addElement(f4_arg1.border)
	f4_arg1.border:registerEventHandler("gain_focus", f0_local1)
	f4_arg1.border:registerEventHandler("lose_focus", f0_local0)
	f4_arg1:registerEventHandler("gain_focus", CoD.Leaderboard.ButtonGainFocus)
	f4_arg1:registerEventHandler("lose_focus", CoD.Leaderboard.ButtonLoseFocus)
	f4_arg1:registerEventHandler("click", CoD.Leaderboard.ButtonClick)
	f4_arg1:registerEventHandler("unclick", CoD.Leaderboard.ButtonUnclick)
end

CoD.MissionLeaderboard.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	Widget.listBox = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 50,
		bottom = 0
	}, InstanceRef, 14, CoD.CoD9Button.Height + 1, HudRef.right, f0_local3, CoD.Leaderboard.CareerButtonData, 0)
	CoD.Leaderboard.RepeaterSetup(Widget)
	Widget.id = "MissionLeaderboard"
	Widget.getListBox = CoD.Leaderboard.GetListBox
	Widget.header = f0_local2()
	Widget:addElement(Widget.header)
	Widget:addElement(Widget.listBox)
	return Widget
end

