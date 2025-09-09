require("T6.ListBox")
CoD.LeaderboardMP = {}
CoD.LBFilter = {}
CoD.LeaderboardMP.WIDTH = 863
CoD.LeaderboardMP.PADDING = 5
CoD.LeaderboardMP.LBTOP = 90
CoD.LeaderboardMP.NUMFIXEDCOLS = CoD.MPZM(3, 6)
CoD.LeaderboardMP.NUMDATACOLS = 5
CoD.LeaderboardMP.LBRANK_XLEFT = 0
CoD.LeaderboardMP.LBRANK_XRIGHT = 96
CoD.LeaderboardMP.RANK_XLEFT = CoD.LeaderboardMP.LBRANK_XRIGHT
CoD.LeaderboardMP.RANK_XRIGHT = CoD.LeaderboardMP.RANK_XLEFT + 65
CoD.LeaderboardMP.NAME_XLEFT = CoD.LeaderboardMP.RANK_XRIGHT
CoD.LeaderboardMP.NAME_XRIGHT = CoD.LeaderboardMP.NAME_XLEFT + 100
CoD.LeaderboardMP.DATACOLS_XLEFT = CoD.LeaderboardMP.NAME_XRIGHT
CoD.LeaderboardMP.DATACOLS_XRIGHT = CoD.LeaderboardMP.WIDTH
CoD.LeaderboardMP.DATA_COL_WIDTH = (CoD.LeaderboardMP.DATACOLS_XRIGHT - CoD.LeaderboardMP.DATACOLS_XLEFT) / CoD.LeaderboardMP.NUMDATACOLS
CoD.LeaderboardMP.DATA_COL_WIDTHS = {}
CoD.LeaderboardMP.LB_GAMEMODE = 1
CoD.LeaderboardMP.LB_ICON = 2
CoD.LeaderboardMP.LB_CARD_TEXT = 3
CoD.LeaderboardMP.LB_NAME_CORE = 4
CoD.LeaderboardMP.LB_LIST_CORE = 5
CoD.LeaderboardMP.LB_NAME_HARDCORE = 6
CoD.LeaderboardMP.LB_LIST_HARDCORE = 7
CoD.LeaderboardMP.Leaderboards = {
	{
		"",
		"playlist_tdm",
		"MENU_LB_CARD_TEXT_CAREER",
		"MPUI_LB_CAREER_CAPS",
		{
			"LB_MP_GB_SCORE",
			"LB_MP_GB_SCORE",
			"LB_MP_GB_SCORE"
		},
		"",
		nil
	},
	{
		"tdm",
		"playlist_tdm",
		"MENU_LB_CARD_TEXT_TDM",
		"MPUI_TDM_CAPS",
		{
			"LB_MP_GM_TDM",
			"LB_MP_GM_TDM",
			"LB_MP_GM_TDM"
		},
		"MPUI_HCTDM_CAPS",
		{
			"LB_MP_GM_TDM_HC",
			"LB_MP_GM_TDM_HC",
			"LB_MP_GM_TDM_HC"
		}
	},
	{
		"dm",
		"playlist_ffa",
		"MENU_LB_CARD_TEXT_DM",
		"MPUI_DM_CAPS",
		{
			"LB_MP_GM_DM",
			"LB_MP_GM_DM",
			"LB_MP_GM_DM"
		},
		"",
		nil
	},
	{
		"dom",
		"playlist_domination",
		"MENU_LB_CARD_TEXT_DOM",
		"MPUI_DOM_CAPS",
		{
			"LB_MP_GM_DOM",
			"LB_MP_GM_DOM",
			"LB_MP_GM_DOM"
		},
		"",
		nil
	},
	{
		"sd",
		"playlist_search_destroy",
		"MENU_LB_CARD_TEXT_SD",
		"MPUI_SD_CAPS",
		{
			"LB_MP_GM_SD",
			"LB_MP_GM_SD",
			"LB_MP_GM_SD"
		},
		"MPUI_HCSD_CAPS",
		{
			"LB_MP_GM_SD_HC",
			"LB_MP_GM_SD_HC",
			"LB_MP_GM_SD_HC"
		}
	},
	{
		"ctf",
		"playlist_ctf",
		"MENU_LB_CARD_TEXT_CTF",
		"MPUI_CTF_CAPS",
		{
			"LB_MP_GM_CTF",
			"LB_MP_GM_CTF",
			"LB_MP_GM_CTF"
		},
		"",
		nil
	},
	{
		"hq",
		"playlist_headquarters",
		"MENU_LB_CARD_TEXT_HQ",
		"MPUI_HQ_CAPS",
		{
			"LB_MP_GM_HQ",
			"LB_MP_GM_HQ",
			"LB_MP_GM_HQ"
		},
		"",
		nil
	},
	{
		"dem",
		"playlist_demolition",
		"MENU_LB_CARD_TEXT_DEM",
		"MPUI_DEM_CAPS",
		{
			"LB_MP_GM_DEM",
			"LB_MP_GM_DEM",
			"LB_MP_GM_DEM"
		},
		"",
		nil
	},
	{
		"koth",
		"playlist_koth",
		"MENU_LB_CARD_TEXT_KOTH",
		"MPUI_KOTH_CAPS",
		{
			"LB_MP_GM_KOTH",
			"LB_MP_GM_KOTH",
			"LB_MP_GM_KOTH"
		},
		"",
		nil
	},
	{
		"conf",
		"playlist_kill_confirm",
		"MENU_LB_CARD_TEXT_CONF",
		"MPUI_CONF_CAPS",
		{
			"LB_MP_GM_CONF",
			"LB_MP_GM_CONF",
			"LB_MP_GM_CONF"
		},
		"",
		nil
	},
	{
		"oneflag",
		"playlist_single_ctf",
		"MENU_LB_CARD_TEXT_ONEFLAG",
		"MPUI_ONE_FLAG_CAPS",
		{
			"LB_MP_GM_ONEFLAG",
			"LB_MP_GM_ONEFLAG",
			"LB_MP_GM_ONEFLAG"
		},
		"",
		nil
	},
	{
		"gun",
		"playlist_gungame",
		"MENU_LB_CARD_TEXT_GUN",
		"MPUI_GUN_CAPS",
		{
			"LB_MP_GM_GUN",
			"LB_MP_GM_GUN",
			"LB_MP_GM_GUN"
		},
		"",
		nil
	},
	{
		"oic",
		"playlist_one_chamber",
		"MENU_LB_CARD_TEXT_OIC",
		"MPUI_OIC_CAPS",
		{
			"LB_MP_GM_OIC",
			"LB_MP_GM_OIC",
			"LB_MP_GM_OIC"
		},
		"",
		nil
	},
	{
		"shrp",
		"playlist_sharpshooter",
		"MENU_LB_CARD_TEXT_SHRP",
		"MPUI_SHRP_CAPS",
		{
			"LB_MP_GM_SHRP",
			"LB_MP_GM_SHRP",
			"LB_MP_GM_SHRP"
		},
		"",
		nil
	},
	{
		"sas",
		"playlist_sticks_and_stones",
		"MENU_LB_CARD_TEXT_SAS",
		"MPUI_SAS_CAPS",
		{
			"LB_MP_GM_SAS",
			"LB_MP_GM_SAS",
			"LB_MP_GM_SAS"
		},
		"",
		nil
	}
}
CoD.LeaderboardMP.FILTER_PLAYER_NONE = 1
CoD.LeaderboardMP.FILTER_PLAYER_FRIENDS = 2
CoD.LeaderboardMP.FILTER_PLAYER_LOBBY = 3
CoD.LeaderboardMP.FILTER_PLAYER_VALUE = {
	CoD.LeaderboardMP.FILTER_PLAYER_NONE,
	CoD.LeaderboardMP.FILTER_PLAYER_FRIENDS
}
local f0_local0 = CoD.LeaderboardMP
local f0_local1 = {}
local f0_local2 = Engine.Localize("MENU_LB_PFILTER_ALL")
local f0_local3 = Engine.Localize("MENU_LB_PFILTER_FRIENDS")
f0_local0.FILTER_PLAYER_TEXT = f0_local2
CoD.LeaderboardMP.FILTER_DURATION_ALLTIME = 1
CoD.LeaderboardMP.FILTER_DURATION_MONTHLY = 2
CoD.LeaderboardMP.FILTER_DURATION_WEEKLY = 3
CoD.LeaderboardMP.FILTER_DURATION_TRK = {
	"TRK_ALLTIME",
	"TRK_MONTHLY",
	"TRK_WEEKLY"
}
CoD.LeaderboardMP.FILTER_DURATION_VALUE = {
	CoD.LeaderboardMP.FILTER_DURATION_ALLTIME,
	CoD.LeaderboardMP.FILTER_DURATION_MONTHLY,
	CoD.LeaderboardMP.FILTER_DURATION_WEEKLY
}
f0_local0 = CoD.LeaderboardMP
f0_local1 = {}
f0_local2 = Engine.Localize("MENU_LB_DFILTER_ALL_TIME")
f0_local3 = Engine.Localize("MENU_LB_DFILTER_MONTHLY")
local f0_local4 = Engine.Localize("MENU_LB_DFILTER_WEEKLY")
f0_local0.FILTER_DURATION_TEXT = f0_local2
CoD.LeaderboardMP.FILTER_PLAYLIST_CORE = 1
CoD.LeaderboardMP.FILTER_PLAYLIST_HARDCORE = 2
CoD.LeaderboardMP.FILTER_PLAYLIST_VALUE = {
	CoD.LeaderboardMP.FILTER_PLAYLIST_CORE,
	CoD.LeaderboardMP.FILTER_PLAYLIST_HARDCORE
}
f0_local0 = CoD.LeaderboardMP
f0_local1 = {}
f0_local2 = Engine.Localize("MENU_LB_PSFILTER_CORE")
f0_local3 = Engine.Localize("MENU_LB_PSFILTER_HARDCORE")
f0_local0.FILTER_PLAYLIST_TEXT = f0_local2
CoD.LeaderboardMP.CURR_XUID = 0
CoD.LeaderboardMP.CURR_LB_INDEX = 1
CoD.LeaderboardMP.CURR_FILTER_PLAYER = CoD.LeaderboardMP.FILTER_PLAYER_FRIENDS
CoD.LeaderboardMP.CURR_FILTER_DURATION = CoD.LeaderboardMP.FILTER_DURATION_ALLTIME
CoD.LeaderboardMP.CURR_FILTER_PLAYLIST = CoD.LeaderboardMP.FILTER_PLAYLIST_CORE
CoD.LeaderboardMP.CACHE_EMPTY = 1
CoD.LeaderboardMP.CACHE_FOUND = 2
CoD.LeaderboardMP.CACHE_NOT_FOUND = 3
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 1
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A = CoD.LeaderboardMP.CACHE_EMPTY
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B = CoD.LeaderboardMP.CACHE_EMPTY
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C = CoD.LeaderboardMP.CACHE_EMPTY
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A_DATA = {}
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B_DATA = {}
CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C_DATA = {}
CoD.LeaderboardMP.AddUIText = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, f1_arg10)
	local f1_local0 = LUI.UIText.new()
	f1_local0:setLeftRight(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	f1_local0:setTopBottom(f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	f1_local0:setAlignment(f1_arg8)
	if f1_arg9 ~= nil then
		f1_local0:setFont(f1_arg9)
	end
	if f1_arg10 ~= nil then
		f1_local0:setAlpha(f1_arg10)
	end
	return f1_local0
end

CoD.LeaderboardMP.AddUIImage = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9, f2_arg10, f2_arg11)
	if f2_arg8 == nil then
		f2_arg8 = 1
	end
	if f2_arg9 == nil then
		f2_arg9 = 1
	end
	if f2_arg10 == nil then
		f2_arg10 = 1
	end
	local f2_local0 = LUI.UIImage.new()
	f2_local0:setLeftRight(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	f2_local0:setTopBottom(f2_arg4, f2_arg5, f2_arg6, f2_arg7)
	f2_local0:setRGB(f2_arg8, f2_arg9, f2_arg10)
	if f2_arg11 ~= nil then
		f2_local0:setAlpha(f2_arg11)
	end
	return f2_local0
end

CoD.LeaderboardMP.AddUIElement = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	Widget:setTopBottom(f3_arg4, f3_arg5, f3_arg6, f3_arg7)
	return Widget
end

CoD.LeaderboardMP.GetNumDataCols = function (f4_arg0)
	if f4_arg0 == nil or f4_arg0.lbheaders == nil or f4_arg0.lbheaders.count == nil then
		return 0
	else
		local f4_local0 = f4_arg0.lbheaders.count - CoD.LeaderboardMP.NUMFIXEDCOLS
		if f4_local0 > CoD.LeaderboardMP.NUMDATACOLS then
			return CoD.LeaderboardMP.NUMDATACOLS
		elseif f4_local0 == nil or f4_local0 < 0 then
			return 0
		else
			return f4_local0
		end
	end
end

CoD.LeaderboardMP.ButtonCreator = function (f5_arg0, f5_arg1)
	local f5_local0 = LUI.UIImage.new()
	f5_local0:setLeftRight(true, true, 0, 0)
	f5_local0:setTopBottom(true, true, 0, 0)
	f5_local0:setAlpha(0.3)
	f5_local0:setRGB(0, 0, 0)
	f5_arg1:addElement(f5_local0)
	f5_arg1.loading = CoD.LeaderboardMP.AddUIText(false, false, 0, 0, false, false, -(CoD.textSize.Default * 0.9 / 2), CoD.textSize.Default * 0.9 / 2, LUI.Alignment.Center)
	f5_arg1:addElement(f5_arg1.loading)
	f5_arg1.lbrank = CoD.LeaderboardMP.AddUIText(true, false, CoD.LeaderboardMP.LBRANK_XLEFT + CoD.LeaderboardMP.PADDING, CoD.LeaderboardMP.LBRANK_XRIGHT - CoD.LeaderboardMP.PADDING, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Right)
	f5_arg1:addElement(f5_arg1.lbrank)
	f5_arg1.rankIcon = CoD.LeaderboardMP.AddUIImage(true, false, CoD.LeaderboardMP.RANK_XLEFT + CoD.LeaderboardMP.PADDING, CoD.LeaderboardMP.RANK_XLEFT + CoD.LeaderboardMP.PADDING + 25, true, false, 0, 25)
	f5_arg1:addElement(f5_arg1.rankIcon)
	f5_arg1.rank = CoD.LeaderboardMP.AddUIText(true, false, CoD.LeaderboardMP.RANK_XRIGHT - CoD.LeaderboardMP.PADDING - 25, CoD.LeaderboardMP.RANK_XRIGHT - CoD.LeaderboardMP.PADDING, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left)
	f5_arg1:addElement(f5_arg1.rank)
	f5_arg1.name = CoD.LeaderboardMP.AddUIText(true, false, CoD.LeaderboardMP.NAME_XLEFT + CoD.LeaderboardMP.PADDING, CoD.LeaderboardMP.NAME_XLEFT - CoD.LeaderboardMP.PADDING, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left)
	f5_arg1:addElement(f5_arg1.name)
	local f5_local1 = Engine.GetLeaderboardHeaders(f5_arg0)
	if f5_local1 ~= nil and f5_local1.lbheaders ~= nil then
		f5_arg1.dataColCount = CoD.LeaderboardMP.GetNumDataCols(f5_local1)
		f5_arg1.dataCols = {}
		local f5_local2 = CoD.LeaderboardMP.NUMDATACOLS - f5_arg1.dataColCount
		local f5_local3 = f5_arg1.dataColCount
		local f5_local4 = CoD.LeaderboardMP.DATACOLS_XRIGHT
		for f5_local5 = 1, f5_arg1.dataColCount, 1 do
			f5_arg1.dataCols[f5_local3] = CoD.LeaderboardMP.AddUIText(true, false, f5_local4 - CoD.LeaderboardMP.DATA_COL_WIDTHS[f5_local5], f5_local4, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Center)
			f5_arg1:addElement(f5_arg1.dataCols[f5_local3])
			f5_local4 = f5_local4 - CoD.LeaderboardMP.DATA_COL_WIDTHS[f5_local5]
			f5_local3 = f5_local3 - 1
		end
	end
end

CoD.LeaderboardMP.LButtonData = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = Engine.GetLeaderboardRow(f6_arg0, f6_arg1)
	f6_arg2.xuid = nil
	if f6_local0 == nil or f6_local0.lbrow == nil or f6_local0.lbrow[1] == 0 then
		f6_arg2.loading:setText(Engine.Localize("MENU_LB_LOADING"))
		f6_arg2.lbrank:setText("")
		f6_arg2.name:setText("")
		f6_arg2.rank:setText("")
		f6_arg2.rankIcon:setAlpha(0)
		if f6_arg2.dataColCount ~= nil and f6_arg2.dataColCount > 0 then
			for f6_local1 = 1, f6_arg2.dataColCount, 1 do
				f6_arg2.dataCols[f6_local1]:setText("")
			end
		end
	else
		local f6_local1 = 4
		f6_arg2.loading:setText("")
		f6_arg2.xuid = f6_local0.lbrow.xuid
		f6_arg2.prestige = f6_local0.lbrow.prestige
		f6_arg2.gamertag = f6_local0.lbrow[4]
		local f6_local2 = CoD.white
		if f6_arg2.xuid == CoD.LeaderboardMP.CURR_XUID then
			f6_local2 = CoD.yellowGlow
		end
		f6_arg2.rankText = nil
		if f6_arg2.prestige and f6_arg2.prestige == tonumber(CoD.MAX_PRESTIGE) then
			f6_arg2.rankText = ""
		else
			f6_arg2.rankText = f6_local0.lbrow[3]
		end
		f6_arg2.lbrank:setText(f6_local0.lbrow[1])
		f6_arg2.rankIcon:setAlpha(1)
		f6_arg2.rank:setText(f6_arg2.rankText)
		f6_arg2.rankIcon:setImage(RegisterMaterial(f6_local0.lbrow[2]))
		f6_arg2.name:setText(f6_local0.lbrow[4])
		f6_arg2.lbrank:setRGB(f6_local2.r, f6_local2.g, f6_local2.b)
		f6_arg2.rank:setRGB(f6_local2.r, f6_local2.g, f6_local2.b)
		f6_arg2.name:setRGB(f6_local2.r, f6_local2.g, f6_local2.b)
		if f6_arg2.dataColCount ~= nil and f6_arg2.dataColCount > 0 then
			for f6_local3 = 1, f6_arg2.dataColCount, 1 do
				if f6_local0.lbrow[f6_local3 + f6_local1] ~= nil then
					f6_arg2.dataCols[f6_local3]:setText(f6_local0.lbrow[f6_local3 + f6_local1])
					f6_arg2.dataCols[f6_local3]:setRGB(f6_local2.r, f6_local2.g, f6_local2.b)
				end
				if f6_arg2.dataCols[f6_local3] ~= nil then
					f6_arg2.dataCols[f6_local3]:setText("")
				end
			end
		end
	end
end

CoD.LeaderboardMP.ShowHeaders = function (f7_arg0, f7_arg1)
	local f7_local0 = Engine.GetLeaderboardHeaders(f7_arg0.m_ownerController)
	local f7_local1 = CoD.textSize.Default * 0.9
	if f7_arg0.headerRow ~= nil then
		f7_arg0.headerRow:removeAllChildren()
		f7_arg0.headerRow = nil
	end
	local f7_local2 = 0.4
	f7_arg0.headerRow = CoD.LeaderboardMP.AddUIElement(true, true, 0, 0, true, true, CoD.LeaderboardMP.LBTOP, 0)
	local f7_local3 = CoD.LeaderboardMP.AddUIText(true, false, CoD.LeaderboardMP.LBRANK_XLEFT, CoD.LeaderboardMP.LBRANK_XRIGHT, true, false, 0, f7_local1, LUI.Alignment.Center)
	f7_local3:setFont(CoD.fonts.Default)
	f7_local3:setAlpha(f7_local2)
	f7_local3:setText(Engine.Localize("MENU_LB_RANK"))
	f7_arg0.headerRow:addElement(f7_local3)
	local f7_local4 = CoD.LeaderboardMP.AddUIText(true, false, CoD.LeaderboardMP.RANK_XLEFT, CoD.LeaderboardMP.RANK_XRIGHT, true, false, 0, f7_local1, LUI.Alignment.Center, CoD.fonts.Default, f7_local2)
	f7_local4:setText(Engine.Localize("MENU_LB_LEVEL"))
	f7_arg0.headerRow:addElement(f7_local4)
	local f7_local5 = CoD.LeaderboardMP.AddUIText(true, false, CoD.LeaderboardMP.NAME_XLEFT, CoD.LeaderboardMP.NAME_XRIGHT, true, false, 0, f7_local1, LUI.Alignment.Center, CoD.fonts.Default, f7_local2)
	f7_local5:setText(Engine.Localize("XBOXLIVE_PLAYER"))
	f7_arg0.headerRow:addElement(f7_local5)
	CoD.LeaderboardMP.DATA_COL_WIDTHS = {}
	if f7_local0 ~= nil and f7_local0.lbheaders ~= nil then
		local f7_local6 = CoD.LeaderboardMP.GetNumDataCols(f7_local0)
		local f7_local7 = CoD.LeaderboardMP.NUMDATACOLS - f7_local6
		local f7_local8 = 2
		local f7_local9 = f7_local6
		local f7_local10 = CoD.LeaderboardMP.DATACOLS_XRIGHT
		if f7_local6 > 0 then
			for f7_local11 = 1, f7_local6, 1 do
				local f7_local14 = f7_local0.lbheaders[f7_local9 + f7_local8]
				local f7_local15 = {}
				f7_local15 = GetTextDimensions(f7_local14, CoD.fonts.Default, f7_local1)
				CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11] = f7_local15[3]
				local f7_local16 = 0
				local f7_local17 = f7_local1
				if CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11] < 75 then
					CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11] = 75
				else
					CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11] = CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11] + 40
				end
				local f7_local18 = nil
				local f7_local19 = CoD.LeaderboardMP.AddUIText(true, false, f7_local10 - CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11], f7_local10, true, false, f7_local16, f7_local17, LUI.Alignment.Center, CoD.fonts.Default, f7_local2)
				f7_local19:setText(f7_local14)
				f7_arg0.headerRow:addElement(f7_local19)
				f7_local10 = f7_local10 - CoD.LeaderboardMP.DATA_COL_WIDTHS[f7_local11]
				f7_local9 = f7_local9 - 1
			end
		end
	end
	f7_arg0:addElement(f7_arg0.headerRow)
end

CoD.LeaderboardMP.ResultAvailable = function (f8_arg0, f8_arg1)
	if f8_arg1 ~= nil and f8_arg1.error == true then
		f8_arg0.listBox:showError(Engine.Localize("MPUI_LB_ERROR"))
		return 
	elseif f8_arg0.m_initialLoad == false then
		CoD.LeaderboardMP.ShowHeaders(f8_arg0, f8_arg1.pivot)
		f8_arg0.pivotIndex = f8_arg1.pivot
		f8_arg0.listBox:setTotalItems(f8_arg1.totalresults, f8_arg1.pivot)
		f8_arg0.listBox:clearError()
		f8_arg0.m_initialLoad = true
	else
		f8_arg0.listBox:refresh()
	end
end

CoD.LeaderboardMP.UpdateFilterText = function (f9_arg0)
	local f9_local0 = Engine.Localize("MENU_LB_PFILTER_LOBBY")
	if CoD.LeaderboardMP.CURR_FILTER_PLAYER ~= CoD.LeaderboardMP.FILTER_PLAYER_LOBBY then
		f9_local0 = CoD.LeaderboardMP.FILTER_PLAYER_TEXT[CoD.LeaderboardMP.CURR_FILTER_PLAYER]
	end
	local f9_local1 = f9_local0 .. " / " .. CoD.LeaderboardMP.FILTER_DURATION_TEXT[CoD.LeaderboardMP.CURR_FILTER_DURATION]
	local f9_local2, f9_local3, f9_local4, f9_local5 = GetTextDimensions(f9_local1, CoD.fonts.Default, CoD.textSize.Default)
	f9_arg0.filterText:setLeftRight(true, false, 0, 600)
	f9_arg0.filterText:setTopBottom(true, false, CoD.textSize.Big, CoD.textSize.Big + f9_local3)
	f9_arg0.filterText:setText(f9_local1)
end

CoD.LeaderboardMP.LeaderboardAddFilter = function (f10_arg0)
	local f10_local0 = CoD.LeaderboardMP.AddUIText(true, false, 0, 600, true, false, 0, 0, LUI.Alignment.Left, CoD.fonts.Default, 1)
	f10_local0:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f10_arg0.filterText = f10_local0
	f10_arg0:addElement(f10_arg0.filterText)
	CoD.LeaderboardMP.UpdateFilterText(f10_arg0)
end

CoD.LeaderboardMP.LoadNew = function (f11_arg0, f11_arg1)
	if f11_arg0 == nil or f11_arg1 == nil then
		return 
	end
	f11_arg0.m_initialLoad = false
	CoD.LeaderboardMP.CURR_LB_INDEX = 1
	if f11_arg1.lbIndex ~= nil then
		CoD.LeaderboardMP.CURR_LB_INDEX = f11_arg1.lbIndex
	elseif f11_arg1.lbGameMode ~= nil then
		for f11_local0 = 1, #CoD.LeaderboardMP.Leaderboards, 1 do
			if CoD.LeaderboardMP.Leaderboards[f11_local0][CoD.LeaderboardMP.LB_GAMEMODE] == f11_arg1.lbGameMode then
				CoD.LeaderboardMP.CURR_LB_INDEX = f11_local0
			end
		end
	else
		return 
	end
	if f11_arg1.lobbyFilters ~= nil and f11_arg1.lobbyFilters == true then
		CoD.LeaderboardMP.CURR_FILTER_PLAYER = CoD.LeaderboardMP.FILTER_PLAYER_LOBBY
	end
	local f11_local0 = CoD.LeaderboardMP.Leaderboards[CoD.LeaderboardMP.CURR_LB_INDEX]
	local f11_local1 = f11_local0[CoD.LeaderboardMP.LB_NAME_CORE]
	local f11_local2 = f11_local0[CoD.LeaderboardMP.LB_NAME_HARDCORE]
	local f11_local3 = f11_local0[CoD.LeaderboardMP.LB_LIST_CORE]
	local f11_local4 = f11_local0[CoD.LeaderboardMP.LB_LIST_HARDCORE]
	if f11_local4 == nil then
		CoD.LeaderboardMP.CURR_FILTER_PLAYLIST = CoD.LeaderboardMP.FILTER_PLAYLIST_CORE
	end
	local f11_local5 = f11_local1
	local f11_local6 = f11_local3
	if CoD.LeaderboardMP.CURR_FILTER_PLAYLIST == CoD.LeaderboardMP.FILTER_PLAYLIST_HARDCORE then
		f11_local5 = f11_local2
		f11_local6 = f11_local4
	end
	f11_arg0.title:setText(Engine.Localize(f11_local5))
	CoD.LeaderboardMP.UpdateFilterText(f11_arg0)
	local f11_local7 = CoD.LeaderboardMP.FILTER_DURATION_TRK[CoD.LeaderboardMP.CURR_FILTER_DURATION]
	if f11_local6[CoD.LeaderboardMP.CURR_FILTER_DURATION] ~= "" then
		f11_arg0.lbname = f11_local6[CoD.LeaderboardMP.CURR_FILTER_DURATION]
		Engine.LoadLeaderboard(f11_arg0.lbname, f11_local7)
		Engine.RequestLeaderboardData(f11_arg1.controller, CoD.LeaderboardMP.CURR_FILTER_PLAYER - 1)
	end
	if f11_arg0.pivotRow ~= nil then
		f11_arg0:removeElement(f11_arg0.pivotRow)
		f11_arg0.pivotRow = nil
	end
	if f11_arg0.headerRow ~= nil then
		f11_arg0:removeElement(f11_arg0.headerRow)
		f11_arg0.headerRow = nil
	end
	f11_arg0.listBox:showMessage(Engine.Localize("MENU_LB_LOADING"))
end

CoD.LeaderboardMP.JumpToTop = function (f12_arg0, f12_arg1)
	if f12_arg0 ~= nil and f12_arg0.listBox ~= nil then
		f12_arg0.listBox:jumpToTop()
	end
end

CoD.LeaderboardMP.PageUp = function (f13_arg0, f13_arg1)
	if f13_arg0 ~= nil and f13_arg0.listBox ~= nil then
		f13_arg0.listBox:pageUp()
	end
end

CoD.LeaderboardMP.PageDown = function (f14_arg0, f14_arg1)
	if f14_arg0 ~= nil and f14_arg0.listBox ~= nil then
		f14_arg0.listBox:pageDown()
	end
end

CoD.LeaderboardMP.OpenFilter = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0:openPopup("LBFilter", f15_arg1.controller)
	f15_local0:createSelectors(f15_arg1.controller, f15_arg0)
end

CoD.LeaderboardMP.FilterChanged = function (f16_arg0, f16_arg1)
	CoD.LeaderboardMP.UpdateFilterText(f16_arg0)
	f16_arg0:processEvent({
		name = "leaderboard_loadnew",
		controller = f16_arg0.m_ownerController,
		lbIndex = CoD.LeaderboardMP.CURR_LB_INDEX
	})
end

CoD.LeaderboardMP.ButtonClicked = function (f17_arg0, f17_arg1)
	if f17_arg1.mutables and f17_arg1.mutables.xuid then
		CoD.FriendPopup.SelectedPlayerXuid = f17_arg1.mutables.xuid
		CoD.FriendPopup.SelectedPlayerName = f17_arg1.mutables.gamertag
		CoD.FriendPopup.SelectedPlayerRank = f17_arg1.mutables.rankText
		Dvar.selectedPlayerXuid:set(CoD.FriendPopup.SelectedPlayerXuid)
		CoD.FriendsListPopup.Mode = CoD.playerListType.leaderboard
		f17_arg0:openPopup("FriendPopup", f17_arg1.controller)
	end
end

CoD.LeaderboardMP.InputSourceChanged = function (f18_arg0, f18_arg1)
	if f18_arg1.source == 0 then
		f18_arg0.buttonPageUpDown:setAlpha(1)
	else
		f18_arg0.buttonPageUpDown:setAlpha(0)
	end
	f18_arg0:dispatchEventToChildren(f18_arg1)
end

LUI.createMenu.LeaderboardMP = function (f19_arg0)
	if CoD.LeaderboardMP.CURR_FILTER_PLAYER == nil or CoD.LeaderboardMP.CURR_FILTER_PLAYER == CoD.LeaderboardMP.FILTER_PLAYER_LOBBY then
		CoD.LeaderboardMP.CURR_FILTER_PLAYER = CoD.LeaderboardMP.FILTER_PLAYER_FRIENDS
	end
	if CoD.LeaderboardMP.CURR_FILTER_DURATION == nil then
		CoD.LeaderboardMP.CURR_FILTER_DURATION = CoD.LeaderboardMP.FILTER_DURATION_ALLTIME
	end
	if CoD.LeaderboardMP.CURR_FILTER_PLAYLIST == nil then
		CoD.LeaderboardMP.CURR_FILTER_PLAYLIST = CoD.LeaderboardMP.FILTER_PLAYLIST_CORE
	end
	local f19_local0 = CoD.Menu.New("LeaderboardMP")
	f19_local0:addLargePopupBackground()
	f19_local0.m_ownerController = f19_arg0
	CoD.LeaderboardMP.CURR_XUID = UIExpression.GetXUID(f19_arg0)
	f19_local0.m_initialLoad = false
	f19_local0:addSelectButton()
	f19_local0:addBackButton()
	if f19_local0.selectButton then
		f19_local0.selectButton:setText(Engine.Localize("MENU_LB_VIEW_PLAYER_CARD"))
	end
	local f19_local1 = CoD.ButtonPrompt.new
	local f19_local2 = "alt1"
	local f19_local3 = Engine.Localize("MENU_LB_TOP_OF_LIST")
	local f19_local4 = f19_local0
	local f19_local5 = "leaderboard_jumpToTop"
	local f19_local6, f19_local7 = false
	local f19_local8, f19_local9 = false
	f19_local1 = f19_local1(f19_local2, f19_local3, f19_local4, f19_local5, f19_local6, f19_local7, f19_local8, f19_local9, "T")
	f19_local2 = CoD.ButtonPrompt.new
	f19_local3 = "alt2"
	f19_local4 = Engine.Localize("MENU_LB_CHANGE_FILTER")
	f19_local5 = f19_local0
	f19_local6 = "leaderboard_openFilter"
	f19_local7, f19_local8 = false
	local f19_local9, f19_local10 = false
	f19_local0:addRightButtonPrompt(f19_local2(f19_local3, f19_local4, f19_local5, f19_local6, f19_local7, f19_local8, f19_local9, f19_local10, "F"))
	f19_local0:addRightButtonPrompt(f19_local1)
	f19_local3 = CoD.ButtonPrompt.new("dpad_ud", Engine.Localize("MENU_LB_PAGEUP_PAGE_DOWN"))
	f19_local0.buttonPageUpDown = f19_local3
	f19_local0:addRightButtonPrompt(f19_local3)
	f19_local4 = CoD.ButtonPrompt.new("up", "", f19_local0, "button_prompt_pageup", true, "dpad")
	f19_local5 = CoD.ButtonPrompt.new("down", "", f19_local0, "button_prompt_pagedown", true, "dpad")
	f19_local0:addRightButtonPrompt(f19_local4)
	f19_local0:addRightButtonPrompt(f19_local5)
	f19_local0:registerEventHandler("button_prompt_pageup", CoD.LeaderboardMP.PageUp)
	f19_local0:registerEventHandler("button_prompt_pagedown", CoD.LeaderboardMP.PageDown)
	f19_local6 = {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.LeaderboardMP.LBTOP + 23,
		bottom = -CoD.ButtonPrompt.Height - 16
	}
	f19_local7 = Engine.GetLeaderboardToolTipText(f19_arg0)
	f19_local8 = 15
	if f19_local7 ~= "" then
		f19_local8 = 13
		f19_local9 = CoD.HintText.Height - 8
		f19_local10 = -5
		local f19_local11 = CoD.LeaderboardMP.AddUIElement(true, false, 10, 500, false, true, -60 - CoD.textSize.Default * 0.9, -40)
		f19_local11.hintArrow = CoD.LeaderboardMP.AddUIImage(true, false, f19_local10, f19_local10 + f19_local9, false, false, -f19_local9 / 2 - 10, f19_local9 / 2 - 10)
		f19_local11.hintArrow:setImage(RegisterMaterial(CoD.HintText.ArrowMaterialName))
		f19_local11:addElement(f19_local11.hintArrow)
		f19_local11.hint = CoD.LeaderboardMP.AddUIText(true, false, f19_local10 + f19_local9 + 10, 900, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left)
		f19_local11.hint:setText(f19_local7)
		f19_local11:addElement(f19_local11.hint)
		f19_local0:addElement(f19_local11)
	end
	f19_local0.listBox = CoD.ListBox.new(f19_local6, f19_arg0, f19_local8, CoD.CoD9Button.Height, CoD.LeaderboardMP.WIDTH, CoD.LeaderboardMP.ButtonCreator, CoD.LeaderboardMP.LButtonData, 0)
	f19_local0.listBox:addScrollBar(30, 2)
	f19_local0.listBox.m_positionTextString = "MENU_LB_LISTBOX_POSITION_TEXT"
	f19_local0.listBox.m_pageArrowsOn = true
	f19_local0:addElement(f19_local0.listBox)
	f19_local9 = LUI.UIText.new()
	f19_local9:setLeftRight(true, false, 0, 0)
	f19_local9:setTopBottom(true, false, 0, CoD.textSize.Big)
	f19_local9:setFont(CoD.fonts.Big)
	f19_local0.title = f19_local9
	f19_local0:addElement(f19_local0.title)
	CoD.LeaderboardMP.LeaderboardAddFilter(f19_local0)
	f19_local0:registerEventHandler("leaderboardlist_update", CoD.LeaderboardMP.ResultAvailable)
	f19_local0:registerEventHandler("leaderboard_loadnew", CoD.LeaderboardMP.LoadNew)
	f19_local0:registerEventHandler("leaderboard_jumpToTop", CoD.LeaderboardMP.JumpToTop)
	f19_local0:registerEventHandler("leaderboard_openFilter", CoD.LeaderboardMP.OpenFilter)
	f19_local0:registerEventHandler("leaderboard_filterChanged", CoD.LeaderboardMP.FilterChanged)
	f19_local0:registerEventHandler("click", CoD.LeaderboardMP.ButtonClicked)
	if CoD.isPC then
		f19_local0:registerEventHandler("input_source_changed", CoD.LeaderboardMP.InputSourceChanged)
		if not Engine.LastInput_Gamepad() then
			f19_local0.buttonPageUpDown:setAlpha(0)
		end
	end
	return f19_local0
end

CoD.LBFilter.Apply = function (f20_arg0, f20_arg1)
	if CoD.LeaderboardMP.CURR_FILTER_PLAYER ~= f20_arg0.playerBackup or CoD.LeaderboardMP.CURR_FILTER_DURATION ~= f20_arg0.durationBackup or CoD.LeaderboardMP.CURR_FILTER_PLAYLIST ~= f20_arg0.playlistBackup then
		local f20_local0 = f20_arg0:getParent()
		f20_local0:processEvent({
			name = "leaderboard_filterChanged"
		})
	end
	f20_arg0:goBack(f20_arg1.controller)
end

CoD.LBFilter.Back = function (f21_arg0, f21_arg1)
	CoD.LeaderboardMP.CURR_FILTER_DURATION = f21_arg0.durationBackup
	CoD.LeaderboardMP.CURR_FILTER_PLAYER = f21_arg0.playerBackup
	CoD.LeaderboardMP.CURR_FILTER_PLAYLIST = f21_arg0.playlistBackup
	f21_arg0:goBack(f21_arg1.controller)
end

CoD.LBFilter.FiltersPlayerSelectionChanged = function (f22_arg0)
	CoD.LeaderboardMP.CURR_FILTER_PLAYER = f22_arg0.value
end

CoD.LBFilter.FiltersDurationSelectionChanged = function (f23_arg0)
	CoD.LeaderboardMP.CURR_FILTER_DURATION = f23_arg0.value
end

CoD.LBFilter.FiltersPlaylistSelectionChanged = function (f24_arg0)
	CoD.LeaderboardMP.CURR_FILTER_PLAYLIST = f24_arg0.value
end

CoD.LBFilter.CreateSelectors = function (f25_arg0, f25_arg1, f25_arg2)
	f25_arg0.playerBackup = CoD.LeaderboardMP.CURR_FILTER_PLAYER
	f25_arg0.durationBackup = CoD.LeaderboardMP.CURR_FILTER_DURATION
	f25_arg0.playlistBackup = CoD.LeaderboardMP.CURR_FILTER_PLAYLIST
	local f25_local0 = CoD.LeaderboardMP.Leaderboards[CoD.LeaderboardMP.CURR_LB_INDEX]
	local f25_local1 = f25_local0[CoD.LeaderboardMP.LB_LIST_CORE]
	local f25_local2 = f25_local0[CoD.LeaderboardMP.LB_LIST_HARDCORE]
	local f25_local3 = CoD.ButtonList.new()
	f25_local3:setLeftRight(true, false, 10, 400)
	f25_local3:setTopBottom(true, true, 75, 0)
	f25_arg0:addElement(f25_local3)
	local f25_local4, f25_local5, f25_local6 = nil
	local f25_local7 = 0
	if CoD.LeaderboardMP.CURR_FILTER_PLAYER ~= CoD.LeaderboardMP.FILTER_PLAYER_LOBBY then
		f25_local4 = f25_local3:addDvarLeftRightSelector(f25_arg1, Engine.Localize("MENU_LB_FILTER_PLAYERS"), nil, nil, 125)
		f25_local4.strings = CoD.LeaderboardMP.FILTER_PLAYER_TEXT
		f25_local4.values = CoD.LeaderboardMP.FILTER_PLAYER_VALUE
		local f25_local8 = CoD.LeaderboardMP.CURR_FILTER_PLAYER
		for f25_local9 = 1, #f25_local4.values, 1 do
			local f25_local12 = f25_local9
			if #f25_local4.values < f25_local8 then
				f25_local8 = 1
			end
			f25_local4:addChoice(f25_arg1, Engine.Localize(f25_local4.strings[f25_local8]), f25_local4.values[f25_local8], nil, CoD.LBFilter.FiltersPlayerSelectionChanged)
			f25_local8 = f25_local8 + 1
		end
	end
	f25_local5 = f25_local3:addDvarLeftRightSelector(f25_arg1, Engine.Localize("MENU_LB_FILTER_DURATION"), nil, nil, 125)
	f25_local5.strings = CoD.LeaderboardMP.FILTER_DURATION_TEXT
	f25_local5.values = CoD.LeaderboardMP.FILTER_DURATION_VALUE
	f25_local7 = CoD.LeaderboardMP.CURR_FILTER_DURATION
	for f25_local8 = 1, #f25_local5.values, 1 do
		local f25_local11 = f25_local8
		if #f25_local5.values < f25_local7 then
			f25_local7 = 1
		end
		f25_local5:addChoice(f25_arg1, Engine.Localize(f25_local5.strings[f25_local7]), f25_local5.values[f25_local7], nil, CoD.LBFilter.FiltersDurationSelectionChanged)
		f25_local7 = f25_local7 + 1
	end
	if f25_local2 ~= nil then
		local f25_local8 = f25_local3:addDvarLeftRightSelector(f25_arg1, Engine.Localize("MENU_LB_FILTER_PLAYLIST"), nil, nil, 125)
		f25_local8.strings = CoD.LeaderboardMP.FILTER_PLAYLIST_TEXT
		f25_local8.values = CoD.LeaderboardMP.FILTER_PLAYLIST_VALUE
		f25_local7 = CoD.LeaderboardMP.CURR_FILTER_PLAYLIST
		for f25_local9 = 1, #f25_local8.values, 1 do
			local f25_local12 = f25_local9
			if #f25_local8.values < f25_local7 then
				f25_local7 = 1
			end
			f25_local8:addChoice(f25_arg1, Engine.Localize(f25_local8.strings[f25_local7]), f25_local8.values[f25_local7], nil, CoD.LBFilter.FiltersPlaylistSelectionChanged)
			f25_local7 = f25_local7 + 1
		end
	end
	if f25_local4 ~= nil then
		f25_local4:processEvent({
			name = "gain_focus"
		})
	elseif f25_local5 ~= nil then
		f25_local5:processEvent({
			name = "gain_focus"
		})
	elseif f25_local6 ~= nil then
		f25_local6:processEvent({
			name = "gain_focus"
		})
	end
	if CoD.useController and #f25_local5.strings > 0 then

	else

	end
end

LUI.createMenu.LBFilter = function (f26_arg0)
	local f26_local0 = CoD.Popup.SetupPopup("LBFilter", f26_arg0)
	f26_local0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_LB_CHANGE_FILTER")))
	f26_local0.msg = nil
	local f26_local1 = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_LB_APPLY_FILTER"), f26_local0, "lbfilter_apply")
	local f26_local2 = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), f26_local0, "lbfilter_back")
	f26_local0.createSelectors = CoD.LBFilter.CreateSelectors
	f26_local0:registerEventHandler("lbfilter_apply", CoD.LBFilter.Apply)
	f26_local0:registerEventHandler("lbfilter_back", CoD.LBFilter.Back)
	f26_local0:addLeftButtonPrompt(f26_local1)
	f26_local0:addLeftButtonPrompt(f26_local2)
	Engine.PlaySound("cac_loadout_edit_sel")
	return f26_local0
end

