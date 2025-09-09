require("T6.LeaderboardList")
CoD.LeaderboardPopup = {}
CoD.LeaderboardPopup.Open = function (f1_arg0, f1_arg1)
	CoD.PlayercardPopup.Close(f1_arg0)
	local f1_local0 = CoD.MFPopup.new(f1_arg0, nil, nil, Engine.Localize("MENU_LEADERBOARDS_CAPS"))
	f1_local0:registerEventHandler("button_prompt_back", CoD.LeaderboardPopup.buttonPressedBack)
	f1_local0.parent = f1_arg0
	LeaderboardPopup_AddPanelElements(f1_local0, f1_arg1)
	f1_local0:openPopup(nil, true)
end

CoD.LeaderboardPopup.buttonPressedBack = function (f2_arg0, f2_arg1)
	f2_arg0:closePopup(nil, true, nil, true)
	CoD.PlayercardPopup.Open(f2_arg0.parent.parent, f2_arg1.controller)
end

function LeaderboardPopup_AddPanelElements(f3_arg0, f3_arg1)
	Engine.LoadLeaderboard("LB_MP_GB_TOTALXP_AT", "TRK_ALLTIME")
	f3_arg0:addBackButton()
	f3_arg0.m_ownerController = f3_arg1
	local f3_local0 = CoD.CoD9Button.Height * 2
	local f3_local1 = CoD.MFPopup.Height - f3_local0
	local f3_local2 = 0.05
	local f3_local3 = LUI.UIHorizontalList.new({
		left = CoD.CoD9Button.Height,
		top = CoD.CoD9Button.Height,
		right = 0,
		bottom = CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = CoD.LeaderboardList.ColumnSpacing
	})
	local f3_local4 = CoD.LeaderboardList.new(f3_arg1, {
		left = CoD.CoD9Button.Height,
		top = f3_local0,
		right = -CoD.CoD9Button.Height,
		bottom = -CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, 10)
	local f3_local5 = LUI.UIHorizontalList.new({
		left = CoD.CoD9Button.Height,
		top = f3_local0,
		right = 0,
		bottom = f3_local1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = CoD.LeaderboardList.ColumnSpacing,
		alpha = f3_local2
	})
	local f3_local6 = {}
	for f3_local7 = 1, #CoD.LeaderboardList.ColumnWidth, 1 do
		f3_local6[f3_local7] = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = CoD.LeaderboardList.ColumnWidth[f3_local7],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		})
		f3_local5:addElement(f3_local6[f3_local7])
	end
	local f3_local7 = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.LeaderboardList.ColumnWidth[1],
		bottom = CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	local f3_local8 = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.LeaderboardList.ColumnWidth[2],
		bottom = CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	local f3_local9 = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.LeaderboardList.ColumnWidth[3],
		bottom = CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	local f3_local10 = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.LeaderboardList.ColumnWidth[3] + CoD.LeaderboardList.ColumnWidth[4],
		bottom = CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f3_local7:setText(Engine.Localize("MPUI_RANK"))
	f3_local8:setText(Engine.Localize("MPUI_LEVEL"))
	f3_local9:setText("")
	f3_local10:setText(Engine.Localize("XBOXLIVE_PLAYER"))
	f3_local3:addElement(f3_local7)
	f3_local3:addElement(f3_local8)
	f3_local3:addElement(f3_local9)
	f3_local3:addElement(f3_local10)
	f3_arg0.body:addElement(f3_local3)
	f3_arg0.body:addElement(f3_local4)
	f3_arg0.body:addElement(f3_local5)
end

