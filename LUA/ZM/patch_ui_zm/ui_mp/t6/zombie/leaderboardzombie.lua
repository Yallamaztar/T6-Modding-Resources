require("T6.ListBox")
CoD.LeaderboardZombie = {}
CoD.LBFilter = {}
CoD.LeaderboardZombie.WIDTH = 863
CoD.LeaderboardZombie.PADDING = 5
CoD.LeaderboardZombie.LBTOP = 90
CoD.LeaderboardZombie.NUMFIXEDCOLS = 6
CoD.LeaderboardZombie.NUMDATACOLS = 5
CoD.LeaderboardZombie.LBRANK_XLEFT = 0
CoD.LeaderboardZombie.LBRANK_XRIGHT = 96
CoD.LeaderboardZombie.RANK_XLEFT = CoD.LeaderboardZombie.LBRANK_XRIGHT
CoD.LeaderboardZombie.RANK_XRIGHT = CoD.LeaderboardZombie.RANK_XLEFT + 65
CoD.LeaderboardZombie.NAME_XLEFT = CoD.LeaderboardZombie.RANK_XRIGHT
CoD.LeaderboardZombie.NAME_XRIGHT = CoD.LeaderboardZombie.NAME_XLEFT + 100
CoD.LeaderboardZombie.DATACOLS_XLEFT = CoD.LeaderboardZombie.NAME_XRIGHT
CoD.LeaderboardZombie.DATACOLS_XRIGHT = CoD.LeaderboardZombie.WIDTH
CoD.LeaderboardZombie.DATA_COL_WIDTH = (CoD.LeaderboardZombie.DATACOLS_XRIGHT - CoD.LeaderboardZombie.DATACOLS_XLEFT) / CoD.LeaderboardZombie.NUMDATACOLS
CoD.LeaderboardZombie.DATA_COL_WIDTHS = {}
CoD.LeaderboardZombie.LB_GAMEMODE = 1
CoD.LeaderboardZombie.LB_ICON = 2
CoD.LeaderboardZombie.LB_CARD_TEXT = 3
CoD.LeaderboardZombie.LB_NAME_CORE = 4
CoD.LeaderboardZombie.LB_LIST_CORE = 5
CoD.LeaderboardZombie.LB_NAME_HARDCORE = 6
CoD.LeaderboardZombie.LB_LIST_HARDCORE = 7
CoD.LeaderboardZombie.LB_CHALK_ICON_RIGHT = 8
CoD.LeaderboardZombie.LB_CHALK_ICON_LEFT = 9
CoD.LeaderboardZombie.LEADERBOARD_GROUP_GLOBAL = 1
CoD.LeaderboardZombie.LEADERBOARD_GROUP_GREENRUN = 2
CoD.LeaderboardZombie.LEADERBOARD_GROUP_NUKETOWN = 3
CoD.LeaderboardZombie.LEADERBOARD_GROUP_HIGHRISE = 4
CoD.LeaderboardZombie.LEADERBOARD_GROUP_PRISON = 5
CoD.LeaderboardZombie.LEADERBOARD_GROUP_BURIED = 6
CoD.LeaderboardZombie.LEADERBOARD_GROUP_TOMB = 7
CoD.LeaderboardZombie.Leaderboards = {
	{
		{
			"",
			"menu_zm_lobby_lb_icons_kills",
			"",
			"MENU_LB_KILLS",
			{
				"LB_ZM_GB_KILLS_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_bulletsfired",
			"",
			"MENU_LB_BULLETS_FIRED",
			{
				"LB_ZM_GB_BULLETS_FIRED_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_downs",
			"",
			"MENU_LB_DOWNS",
			{
				"LB_ZM_GB_DOWNS_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_revives",
			"",
			"MENU_LB_REVIVES",
			{
				"LB_ZM_GB_REVIVES_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_grenadekills",
			"",
			"MENU_LB_GRENADE_KILLS",
			{
				"LB_ZM_GB_GRENADE_KILLS_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_headshots",
			"",
			"MENU_LB_HEADSHOTS",
			{
				"LB_ZM_GB_HEADSHOTS_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_deaths",
			"",
			"MENU_LB_DEATHS",
			{
				"LB_ZM_GB_DEATHS_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_gibs",
			"",
			"MENU_LB_GIBS",
			{
				"LB_ZM_GB_GIBS_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_perksdrank",
			"",
			"MENU_LB_PERKS_DRANK",
			{
				"LB_ZM_GB_PERKS_DRANK_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_doorspurchased",
			"",
			"MENU_LB_DOORS_PURCHASED",
			{
				"LB_ZM_GB_DOORS_PURCHASED_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_accuracy",
			"",
			"MENU_LB_HITS",
			{
				"LB_ZM_GB_BULLETS_HIT_AT",
				"",
				""
			},
			"",
			nil
		},
		{
			"",
			"menu_zm_lobby_lb_icons_distancetraveled",
			"",
			"MENU_LB_DISTANCE_TRAVELED",
			{
				"LB_ZM_GB_DISTANCE_TRAVELED_AT",
				"",
				""
			},
			"",
			nil
		}
	},
	{
		{
			"",
			"menu_zm_transit_zclassic_transit",
			"",
			"ZMUI_CLASSIC_TRANSIT",
			{
				"LB_ZM_GM_ZCLASSIC_TRANSIT_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_transit_zclassic_transit",
			"",
			"ZMUI_CLASSIC_TRANSIT",
			{
				"LB_ZM_GM_ZCLASSIC_TRANSIT_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_transit_zclassic_transit",
			"",
			"ZMUI_CLASSIC_TRANSIT",
			{
				"LB_ZM_GM_ZCLASSIC_TRANSIT_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_transit_zclassic_transit",
			"",
			"ZMUI_CLASSIC_TRANSIT",
			{
				"LB_ZM_GM_ZCLASSIC_TRANSIT_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_transit_zsurvival_farm",
			"",
			"ZMUI_STANDARD_FARM",
			{
				"LB_ZM_GM_ZSTANDARD_FARM_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_transit_zsurvival_farm",
			"",
			"ZMUI_STANDARD_FARM",
			{
				"LB_ZM_GM_ZSTANDARD_FARM_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_transit_zsurvival_farm",
			"",
			"ZMUI_STANDARD_FARM",
			{
				"LB_ZM_GM_ZSTANDARD_FARM_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_transit_zsurvival_farm",
			"",
			"ZMUI_STANDARD_FARM",
			{
				"LB_ZM_GM_ZSTANDARD_FARM_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_transit_zsurvival_town",
			"",
			"ZMUI_STANDARD_TOWN",
			{
				"LB_ZM_GM_ZSTANDARD_TOWN_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_transit_zsurvival_town",
			"",
			"ZMUI_STANDARD_TOWN",
			{
				"LB_ZM_GM_ZSTANDARD_TOWN_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_transit_zsurvival_town",
			"",
			"ZMUI_STANDARD_TOWN",
			{
				"LB_ZM_GM_ZSTANDARD_TOWN_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_transit_zsurvival_town",
			"",
			"ZMUI_STANDARD_TOWN",
			{
				"LB_ZM_GM_ZSTANDARD_TOWN_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_transit_zsurvival_transit",
			"",
			"ZMUI_STANDARD_TRANSIT",
			{
				"LB_ZM_GM_ZSTANDARD_TRANSIT_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_transit_zsurvival_transit",
			"",
			"ZMUI_STANDARD_TRANSIT",
			{
				"LB_ZM_GM_ZSTANDARD_TRANSIT_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_transit_zsurvival_transit",
			"",
			"ZMUI_STANDARD_TRANSIT",
			{
				"LB_ZM_GM_ZSTANDARD_TRANSIT_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_transit_zsurvival_transit",
			"",
			"ZMUI_STANDARD_TRANSIT",
			{
				"LB_ZM_GM_ZSTANDARD_TRANSIT_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_transit_zencounter_farm",
			"",
			"ZMUI_GRIEF_FARM",
			{
				"LB_ZM_GM_ZGRIEF_FARM",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4",
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_transit_zencounter_town",
			"",
			"ZMUI_GRIEF_TOWN",
			{
				"LB_ZM_GM_ZGRIEF_TOWN",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4",
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_transit_zencounter_diner",
			"",
			"ZMUI_CLEANSED_DINER",
			{
				"LB_ZM_GM_ZCLEANSED_DINER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3",
			"hud_chalk_1"
		}
	},
	{
		{
			"",
			"menu_zm_nuked_zsurvival_nuked",
			"",
			"ZMUI_STANDARD_NUKED",
			{
				"LB_ZM_GM_ZSTANDARD_NUKED_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_nuked_zsurvival_nuked",
			"",
			"ZMUI_STANDARD_NUKED",
			{
				"LB_ZM_GM_ZSTANDARD_NUKED_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_nuked_zsurvival_nuked",
			"",
			"ZMUI_STANDARD_NUKED",
			{
				"LB_ZM_GM_ZSTANDARD_NUKED_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_nuked_zsurvival_nuked",
			"",
			"ZMUI_STANDARD_NUKED",
			{
				"LB_ZM_GM_ZSTANDARD_NUKED_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		}
	},
	{
		{
			"",
			"menu_zm_highrise_zclassic_rooftop",
			"",
			"ZMUI_CLASSIC_ROOFTOP",
			{
				"LB_ZM_GM_ZCLASSIC_ROOFTOP_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_highrise_zclassic_rooftop",
			"",
			"ZMUI_CLASSIC_ROOFTOP",
			{
				"LB_ZM_GM_ZCLASSIC_ROOFTOP_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_highrise_zclassic_rooftop",
			"",
			"ZMUI_CLASSIC_ROOFTOP",
			{
				"LB_ZM_GM_ZCLASSIC_ROOFTOP_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_highrise_zclassic_rooftop",
			"",
			"ZMUI_CLASSIC_ROOFTOP",
			{
				"LB_ZM_GM_ZCLASSIC_ROOFTOP_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		}
	},
	{
		{
			"",
			"menu_zm_prison_zclassic_prison",
			"",
			"ZMUI_CLASSIC_PRISON",
			{
				"LB_ZM_GM_ZCLASSIC_PRISON_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_prison_zclassic_prison",
			"",
			"ZMUI_CLASSIC_PRISON",
			{
				"LB_ZM_GM_ZCLASSIC_PRISON_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_prison_zclassic_prison",
			"",
			"ZMUI_CLASSIC_PRISON",
			{
				"LB_ZM_GM_ZCLASSIC_PRISON_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_prison_zclassic_prison",
			"",
			"ZMUI_CLASSIC_PRISON",
			{
				"LB_ZM_GM_ZCLASSIC_PRISON_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_prison_zencounter_cellblock",
			"",
			"ZMUI_GRIEF_CELLBLOCK",
			{
				"LB_ZM_GM_ZGRIEF_CELLBLOCK",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4",
			"hud_chalk_4"
		}
	},
	{
		{
			"",
			"menu_zm_buried_zclassic_processing",
			"",
			"ZMUI_CLASSIC_BURIED",
			{
				"LB_ZM_GM_ZCLASSIC_PROCESSING_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_buried_zclassic_processing",
			"",
			"ZMUI_CLASSIC_BURIED",
			{
				"LB_ZM_GM_ZCLASSIC_PROCESSING_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_buried_zclassic_processing",
			"",
			"ZMUI_CLASSIC_BURIED",
			{
				"LB_ZM_GM_ZCLASSIC_PROCESSING_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_buried_zclassic_processing",
			"",
			"ZMUI_CLASSIC_BURIED",
			{
				"LB_ZM_GM_ZCLASSIC_PROCESSING_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_buried_zencounter_street",
			"",
			"ZMUI_GRIEF_STREET",
			{
				"LB_ZM_GM_ZGRIEF_STREET",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4",
			"hud_chalk_4"
		},
		{
			"",
			"menu_zm_buried_zencounter_street",
			"",
			"ZMUI_CLEANSED_STREET",
			{
				"LB_ZM_GM_ZCLEANSED_STREET",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3",
			"hud_chalk_1"
		}
	},
	{
		{
			"",
			"menu_zm_tomb_zclassic_tomb",
			"",
			"ZMUI_CLASSIC_TOMB",
			{
				"LB_ZM_GM_ZCLASSIC_TOMB_1PLAYER",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_1"
		},
		{
			"",
			"menu_zm_tomb_zclassic_tomb",
			"",
			"ZMUI_CLASSIC_TOMB",
			{
				"LB_ZM_GM_ZCLASSIC_TOMB_2PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_2"
		},
		{
			"",
			"menu_zm_tomb_zclassic_tomb",
			"",
			"ZMUI_CLASSIC_TOMB",
			{
				"LB_ZM_GM_ZCLASSIC_TOMB_3PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_3"
		},
		{
			"",
			"menu_zm_tomb_zclassic_tomb",
			"",
			"ZMUI_CLASSIC_TOMB",
			{
				"LB_ZM_GM_ZCLASSIC_TOMB_4PLAYERS",
				"",
				""
			},
			"",
			nil,
			"hud_chalk_4"
		}
	}
}
CoD.LeaderboardZombie.FILTER_PLAYER_NONE = 1
CoD.LeaderboardZombie.FILTER_PLAYER_FRIENDS = 2
CoD.LeaderboardZombie.FILTER_PLAYER_LOBBY = 3
CoD.LeaderboardZombie.FILTER_PLAYER_VALUE = {
	CoD.LeaderboardZombie.FILTER_PLAYER_NONE,
	CoD.LeaderboardZombie.FILTER_PLAYER_FRIENDS
}
local f0_local0 = CoD.LeaderboardZombie
local f0_local1 = {}
local f0_local2 = Engine.Localize("MENU_LB_PFILTER_ALL")
local f0_local3 = Engine.Localize("MENU_LB_PFILTER_FRIENDS")
f0_local0.FILTER_PLAYER_TEXT = f0_local2
CoD.LeaderboardZombie.FILTER_DURATION_ALLTIME = 1
CoD.LeaderboardZombie.FILTER_DURATION_MONTHLY = 2
CoD.LeaderboardZombie.FILTER_DURATION_WEEKLY = 3
CoD.LeaderboardZombie.FILTER_DURATION_TRK = {
	"TRK_ALLTIME",
	"TRK_MONTHLY",
	"TRK_WEEKLY"
}
CoD.LeaderboardZombie.FILTER_DURATION_VALUE = {
	CoD.LeaderboardZombie.FILTER_DURATION_ALLTIME,
	CoD.LeaderboardZombie.FILTER_DURATION_MONTHLY,
	CoD.LeaderboardZombie.FILTER_DURATION_WEEKLY
}
f0_local0 = CoD.LeaderboardZombie
f0_local1 = {}
f0_local2 = Engine.Localize("MENU_LB_DFILTER_ALL_TIME")
f0_local3 = Engine.Localize("MENU_LB_DFILTER_MONTHLY")
local f0_local4 = Engine.Localize("MENU_LB_DFILTER_WEEKLY")
f0_local0.FILTER_DURATION_TEXT = f0_local2
CoD.LeaderboardZombie.FILTER_PLAYLIST_CORE = 1
CoD.LeaderboardZombie.FILTER_PLAYLIST_HARDCORE = 2
CoD.LeaderboardZombie.FILTER_PLAYLIST_VALUE = {
	CoD.LeaderboardZombie.FILTER_PLAYLIST_CORE,
	CoD.LeaderboardZombie.FILTER_PLAYLIST_HARDCORE
}
f0_local0 = CoD.LeaderboardZombie
f0_local1 = {}
f0_local2 = Engine.Localize("MENU_LB_PSFILTER_CORE")
f0_local3 = Engine.Localize("MENU_LB_PSFILTER_HARDCORE")
f0_local0.FILTER_PLAYLIST_TEXT = f0_local2
CoD.LeaderboardZombie.CURR_XUID = 0
CoD.LeaderboardZombie.CURR_LB_INDEX = 1
CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX = CoD.LeaderboardZombie.LEADERBOARD_GROUP_GLOBAL
CoD.LeaderboardZombie.CURR_FILTER_PLAYER = CoD.LeaderboardZombie.FILTER_PLAYER_FRIENDS
CoD.LeaderboardZombie.CURR_FILTER_DURATION = CoD.LeaderboardZombie.FILTER_DURATION_ALLTIME
CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST = CoD.LeaderboardZombie.FILTER_PLAYLIST_CORE
CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE = 1
CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A = false
CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B = false
CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A_DATA = {}
CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B_DATA = {}
CoD.LeaderboardZombie.AddUIText = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, f1_arg10)
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

CoD.LeaderboardZombie.AddUIImage = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9, f2_arg10, f2_arg11)
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

CoD.LeaderboardZombie.AddUIElement = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	Widget:setTopBottom(f3_arg4, f3_arg5, f3_arg6, f3_arg7)
	return Widget
end

CoD.LeaderboardZombie.GetNumDataCols = function (f4_arg0)
	if f4_arg0 == nil or f4_arg0.lbheaders == nil or f4_arg0.lbheaders.count == nil then
		return 0
	else
		local f4_local0 = f4_arg0.lbheaders.count - CoD.LeaderboardZombie.NUMFIXEDCOLS
		if f4_local0 > CoD.LeaderboardZombie.NUMDATACOLS then
			return CoD.LeaderboardZombie.NUMDATACOLS
		elseif f4_local0 == nil or f4_local0 < 0 then
			return 0
		else
			return f4_local0
		end
	end
end

CoD.LeaderboardZombie.ButtonCreator = function (f5_arg0, f5_arg1)
	local f5_local0 = LUI.UIImage.new()
	f5_local0:setLeftRight(true, true, 0, 0)
	f5_local0:setTopBottom(true, true, 0, 0)
	f5_local0:setAlpha(0.3)
	f5_local0:setRGB(0, 0, 0)
	f5_arg1:addElement(f5_local0)
	f5_arg1.loading = CoD.LeaderboardZombie.AddUIText(false, false, 0, 0, false, false, -(CoD.textSize.Default * 0.9 / 2), CoD.textSize.Default * 0.9 / 2, LUI.Alignment.Center)
	f5_arg1:addElement(f5_arg1.loading)
	f5_arg1.lbrank = CoD.LeaderboardZombie.AddUIText(true, false, CoD.LeaderboardZombie.LBRANK_XLEFT + CoD.LeaderboardZombie.PADDING, CoD.LeaderboardZombie.LBRANK_XRIGHT - CoD.LeaderboardZombie.PADDING, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Right)
	f5_arg1:addElement(f5_arg1.lbrank)
	f5_arg1.name = CoD.LeaderboardZombie.AddUIText(true, false, CoD.LeaderboardZombie.NAME_XLEFT + CoD.LeaderboardZombie.PADDING, CoD.LeaderboardZombie.NAME_XLEFT - CoD.LeaderboardZombie.PADDING, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left)
	f5_arg1:addElement(f5_arg1.name)
	local f5_local1 = Engine.GetLeaderboardHeaders(f5_arg0)
	if f5_local1 ~= nil and f5_local1.lbheaders ~= nil then
		f5_arg1.dataColCount = CoD.LeaderboardZombie.GetNumDataCols(f5_local1)
		f5_arg1.dataCols = {}
		local f5_local2 = CoD.LeaderboardZombie.NUMDATACOLS - f5_arg1.dataColCount
		local f5_local3 = f5_arg1.dataColCount
		local f5_local4 = CoD.LeaderboardZombie.DATACOLS_XRIGHT
		for f5_local5 = 1, f5_arg1.dataColCount, 1 do
			f5_arg1.dataCols[f5_local3] = CoD.LeaderboardZombie.AddUIText(true, false, f5_local4 - CoD.LeaderboardZombie.DATA_COL_WIDTHS[f5_local5], f5_local4, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Center)
			f5_arg1:addElement(f5_arg1.dataCols[f5_local3])
			f5_local4 = f5_local4 - CoD.LeaderboardZombie.DATA_COL_WIDTHS[f5_local5]
			f5_local3 = f5_local3 - 1
		end
	end
end

CoD.LeaderboardZombie.LButtonData = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = Engine.GetLeaderboardRow(f6_arg0, f6_arg1)
	f6_arg2.xuid = nil
	if f6_local0 == nil or f6_local0.lbrow == nil or f6_local0.lbrow[1] == 0 then
		f6_arg2.loading:setText(Engine.Localize("MENU_LB_LOADING"))
		f6_arg2.lbrank:setText("")
		f6_arg2.name:setText("")
		if f6_arg2.dataColCount ~= nil and f6_arg2.dataColCount > 0 then
			for f6_local1 = 1, f6_arg2.dataColCount, 1 do
				f6_arg2.dataCols[f6_local1]:setText("")
			end
		end
	else
		local f6_local1 = 5
		f6_arg2.loading:setText("")
		f6_arg2.xuid = f6_local0.lbrow.xuid
		f6_arg2.gamertag = f6_local0.lbrow[5]
		local f6_local2 = CoD.white
		if f6_arg2.xuid == CoD.LeaderboardZombie.CURR_XUID then
			f6_local2 = CoD.yellowGlow
		end
		f6_arg2.lbrank:setText(f6_local0.lbrow[1])
		f6_arg2.name:setText(f6_local0.lbrow[5])
		f6_arg2.lbrank:setRGB(f6_local2.r, f6_local2.g, f6_local2.b)
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

CoD.LeaderboardZombie.ShowHeaders = function (f7_arg0, f7_arg1)
	local f7_local0 = Engine.GetLeaderboardHeaders(f7_arg0.m_ownerController)
	local f7_local1 = CoD.textSize.Default * 0.9
	if f7_arg0.headerRow ~= nil then
		f7_arg0.headerRow:removeAllChildren()
		f7_arg0.headerRow = nil
	end
	local f7_local2 = 0.4
	f7_arg0.headerRow = CoD.LeaderboardZombie.AddUIElement(true, true, 0, 0, true, true, CoD.LeaderboardZombie.LBTOP, 0)
	local f7_local3 = CoD.LeaderboardZombie.AddUIText(true, false, CoD.LeaderboardZombie.LBRANK_XLEFT, CoD.LeaderboardZombie.LBRANK_XRIGHT, true, false, 0, f7_local1, LUI.Alignment.Center)
	f7_local3:setFont(CoD.fonts.Default)
	f7_local3:setAlpha(f7_local2)
	f7_local3:setText(Engine.Localize("MENU_LB_RANK"))
	f7_arg0.headerRow:addElement(f7_local3)
	local f7_local4 = CoD.LeaderboardZombie.AddUIText(true, false, CoD.LeaderboardZombie.NAME_XLEFT, CoD.LeaderboardZombie.NAME_XRIGHT, true, false, 0, f7_local1, LUI.Alignment.Center, CoD.fonts.Default, f7_local2)
	f7_local4:setText(Engine.Localize("XBOXLIVE_PLAYER"))
	f7_arg0.headerRow:addElement(f7_local4)
	CoD.LeaderboardZombie.DATA_COL_WIDTHS = {}
	if f7_local0 ~= nil and f7_local0.lbheaders ~= nil then
		local f7_local5 = CoD.LeaderboardZombie.GetNumDataCols(f7_local0)
		local f7_local6 = CoD.LeaderboardZombie.NUMDATACOLS - f7_local5
		local f7_local7 = 5
		local f7_local8 = f7_local5
		local f7_local9 = CoD.LeaderboardZombie.DATACOLS_XRIGHT
		if f7_local5 > 0 then
			for f7_local10 = 1, f7_local5, 1 do
				local f7_local13 = f7_local0.lbheaders[f7_local8 + f7_local7]
				local f7_local14 = {}
				f7_local14 = GetTextDimensions(f7_local13, CoD.fonts.Default, f7_local1)
				CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10] = f7_local14[3]
				local f7_local15 = 0
				local f7_local16 = f7_local1
				if CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10] < 75 then
					CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10] = 75
				else
					CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10] = CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10] + 40
				end
				local f7_local17 = nil
				local f7_local18 = CoD.LeaderboardZombie.AddUIText(true, false, f7_local9 - CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10], f7_local9, true, false, f7_local15, f7_local16, LUI.Alignment.Center, CoD.fonts.Default, f7_local2)
				f7_local18:setText(f7_local13)
				f7_arg0.headerRow:addElement(f7_local18)
				f7_local9 = f7_local9 - CoD.LeaderboardZombie.DATA_COL_WIDTHS[f7_local10]
				f7_local8 = f7_local8 - 1
			end
		end
	end
	f7_arg0:addElement(f7_arg0.headerRow)
end

CoD.LeaderboardZombie.ResultAvailable = function (f8_arg0, f8_arg1)
	if f8_arg1 ~= nil and f8_arg1.error == true then
		f8_arg0.listBox:showError(Engine.Localize("MPUI_LB_ERROR"))
		return 
	elseif f8_arg0.m_initialLoad == false then
		CoD.LeaderboardZombie.ShowHeaders(f8_arg0, f8_arg1.pivot)
		f8_arg0.pivotIndex = f8_arg1.pivot
		f8_arg0.listBox:setTotalItems(f8_arg1.totalresults, f8_arg1.pivot)
		f8_arg0.listBox:clearError()
		f8_arg0.m_initialLoad = true
	else
		f8_arg0.listBox:refresh()
	end
end

CoD.LeaderboardZombie.UpdateFilterText = function (f9_arg0)
	local f9_local0 = Engine.Localize("MENU_LB_PFILTER_LOBBY")
	if CoD.LeaderboardZombie.CURR_FILTER_PLAYER ~= CoD.LeaderboardZombie.FILTER_PLAYER_LOBBY then
		f9_local0 = CoD.LeaderboardZombie.FILTER_PLAYER_TEXT[CoD.LeaderboardZombie.CURR_FILTER_PLAYER]
	end
	local f9_local1 = f9_local0 .. " / " .. CoD.LeaderboardZombie.FILTER_DURATION_TEXT[CoD.LeaderboardZombie.CURR_FILTER_DURATION]
	local f9_local2, f9_local3, f9_local4, f9_local5 = GetTextDimensions(f9_local1, CoD.fonts.Default, CoD.textSize.Default)
	f9_arg0.filterText:setLeftRight(true, false, 0, 600)
	f9_arg0.filterText:setTopBottom(true, false, CoD.textSize.Big, CoD.textSize.Big + f9_local3)
	f9_arg0.filterText:setText(f9_local1)
end

CoD.LeaderboardZombie.LeaderboardAddFilter = function (f10_arg0)
	local f10_local0 = CoD.LeaderboardZombie.AddUIText(true, false, 0, 600, true, false, 0, 0, LUI.Alignment.Left, CoD.fonts.Default, 1)
	f10_local0:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f10_arg0.filterText = f10_local0
	f10_arg0:addElement(f10_arg0.filterText)
	CoD.LeaderboardZombie.UpdateFilterText(f10_arg0)
end

CoD.LeaderboardZombie.LoadNew = function (f11_arg0, f11_arg1)
	if f11_arg0 == nil or f11_arg1 == nil then
		return 
	else
		f11_arg0.m_initialLoad = false
		CoD.LeaderboardZombie.CURR_LB_INDEX = 1
		if f11_arg1.lbGroupIndex ~= nil then
			CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX = f11_arg1.lbGroupIndex
			if f11_arg1.lbIndex ~= nil then
				CoD.LeaderboardZombie.CURR_LB_INDEX = f11_arg1.lbIndex
			elseif f11_arg1.lbGameMode ~= nil then
				for f11_local0 = 1, #CoD.LeaderboardZombie.Leaderboards[f11_arg1.lbGroupIndex], 1 do
					if CoD.LeaderboardZombie.Leaderboards[f11_arg1.lbGroupIndex][f11_local0][CoD.LeaderboardZombie.LB_GAMEMODE] == f11_arg1.lbGameMode then
						CoD.LeaderboardZombie.CURR_LB_INDEX = f11_local0
					end
				end
			else
				return 
			end
			if f11_arg1.lobbyFilters ~= nil and f11_arg1.lobbyFilters == true then
				CoD.LeaderboardZombie.CURR_FILTER_PLAYER = CoD.LeaderboardZombie.FILTER_PLAYER_LOBBY
			end
			local f11_local0 = CoD.LeaderboardZombie.Leaderboards[f11_arg1.lbGroupIndex][CoD.LeaderboardZombie.CURR_LB_INDEX]
			local f11_local1 = f11_local0[CoD.LeaderboardZombie.LB_NAME_CORE]
			local f11_local2 = f11_local0[CoD.LeaderboardZombie.LB_NAME_HARDCORE]
			local f11_local3 = f11_local0[CoD.LeaderboardZombie.LB_LIST_CORE]
			local f11_local4 = f11_local0[CoD.LeaderboardZombie.LB_LIST_HARDCORE]
			if f11_local4 == nil then
				CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST = CoD.LeaderboardZombie.FILTER_PLAYLIST_CORE
			end
			local f11_local5 = f11_local1
			local f11_local6 = f11_local3
			if CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST == CoD.LeaderboardZombie.FILTER_PLAYLIST_HARDCORE then
				f11_local5 = f11_local2
				f11_local6 = f11_local4
			end
			f11_arg0.title:setText(Engine.Localize(f11_local5))
			CoD.LeaderboardZombie.UpdateFilterText(f11_arg0)
			local f11_local7 = CoD.LeaderboardZombie.FILTER_DURATION_TRK[CoD.LeaderboardZombie.CURR_FILTER_DURATION]
			if f11_local6[CoD.LeaderboardZombie.CURR_FILTER_DURATION] ~= "" then
				f11_arg0.lbname = f11_local6[CoD.LeaderboardZombie.CURR_FILTER_DURATION]
				Engine.LoadLeaderboard(f11_arg0.lbname, f11_local7)
				Engine.RequestLeaderboardData(f11_arg1.controller, CoD.LeaderboardZombie.CURR_FILTER_PLAYER - 1)
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
		else
			error("LUI Zombie LeaderBoard Error: Invalid lbGroupIndex value !")
			return 
		end
	end
end

CoD.LeaderboardZombie.JumpToTop = function (f12_arg0, f12_arg1)
	if f12_arg0 ~= nil and f12_arg0.listBox ~= nil then
		f12_arg0.listBox:jumpToTop()
	end
end

CoD.LeaderboardZombie.PageUp = function (f13_arg0, f13_arg1)
	if f13_arg0 ~= nil and f13_arg0.listBox ~= nil then
		f13_arg0.listBox:pageUp()
	end
end

CoD.LeaderboardZombie.PageDown = function (f14_arg0, f14_arg1)
	if f14_arg0 ~= nil and f14_arg0.listBox ~= nil then
		f14_arg0.listBox:pageDown()
	end
end

CoD.LeaderboardZombie.OpenFilter = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0:openPopup("LBFilter", f15_arg1.controller)
	f15_local0:createSelectors(f15_arg1.controller, f15_arg0)
end

CoD.LeaderboardZombie.FilterChanged = function (f16_arg0, f16_arg1)
	CoD.LeaderboardZombie.UpdateFilterText(f16_arg0)
	f16_arg0:processEvent({
		name = "leaderboard_loadnew",
		controller = f16_arg0.m_ownerController,
		lbIndex = CoD.LeaderboardZombie.CURR_LB_INDEX,
		lbGroupIndex = CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX
	})
end

CoD.LeaderboardZombie.ButtonClicked = function (f17_arg0, f17_arg1)
	if f17_arg1.mutables and f17_arg1.mutables.xuid then
		CoD.FriendPopup.SelectedPlayerXuid = f17_arg1.mutables.xuid
		CoD.FriendPopup.SelectedPlayerName = f17_arg1.mutables.gamertag
		Dvar.selectedPlayerXuid:set(CoD.FriendPopup.SelectedPlayerXuid)
		CoD.FriendsListPopup.Mode = CoD.playerListType.leaderboard
		f17_arg0:openPopup("FriendPopup", f17_arg1.controller)
	end
end

LUI.createMenu.LeaderboardZM = function (f18_arg0)
	if CoD.LeaderboardZombie.CURR_FILTER_PLAYER == nil or CoD.LeaderboardZombie.CURR_FILTER_PLAYER == CoD.LeaderboardZombie.FILTER_PLAYER_LOBBY then
		CoD.LeaderboardZombie.CURR_FILTER_PLAYER = CoD.LeaderboardZombie.FILTER_PLAYER_FRIENDS
	end
	if CoD.LeaderboardZombie.CURR_FILTER_DURATION == nil then
		CoD.LeaderboardZombie.CURR_FILTER_DURATION = CoD.LeaderboardZombie.FILTER_DURATION_ALLTIME
	end
	if CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST == nil then
		CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST = CoD.LeaderboardZombie.FILTER_PLAYLIST_CORE
	end
	local f18_local0 = CoD.Menu.New("LeaderboardZM")
	f18_local0:addLargePopupBackground()
	f18_local0.m_ownerController = f18_arg0
	CoD.LeaderboardZombie.CURR_XUID = UIExpression.GetXUID(f18_arg0)
	f18_local0.m_initialLoad = false
	f18_local0:addSelectButton()
	f18_local0:addBackButton()
	if f18_local0.selectButton then
		f18_local0.selectButton:setText(Engine.Localize("MENU_LB_VIEW_PLAYER_CARD"))
	end
	local f18_local1 = CoD.ButtonPrompt.new
	local f18_local2 = "alt1"
	local f18_local3 = Engine.Localize("MENU_LB_TOP_OF_LIST")
	local f18_local4 = f18_local0
	local f18_local5 = "leaderboard_jumpToTop"
	local f18_local6, f18_local7 = false
	local f18_local8, f18_local9 = false
	f18_local1 = f18_local1(f18_local2, f18_local3, f18_local4, f18_local5, f18_local6, f18_local7, f18_local8, f18_local9, "T")
	f18_local2 = CoD.ButtonPrompt.new
	f18_local3 = "alt2"
	f18_local4 = Engine.Localize("MENU_LB_CHANGE_FILTER")
	f18_local5 = f18_local0
	f18_local6 = "leaderboard_openFilter"
	f18_local7, f18_local8 = false
	local f18_local9, f18_local10 = false
	f18_local0:addRightButtonPrompt(f18_local2(f18_local3, f18_local4, f18_local5, f18_local6, f18_local7, f18_local8, f18_local9, f18_local10, "F"))
	f18_local0:addRightButtonPrompt(f18_local1)
	if CoD.isPC == false then
		f18_local0:addRightButtonPrompt(CoD.ButtonPrompt.new("dpad_ud", Engine.Localize("MENU_LB_PAGEUP_PAGE_DOWN")))
		f18_local4 = CoD.ButtonPrompt.new("up", "", f18_local0, "button_prompt_pageup", true, "dpad")
		f18_local5 = CoD.ButtonPrompt.new("down", "", f18_local0, "button_prompt_pagedown", true, "dpad")
		f18_local0:addRightButtonPrompt(f18_local4)
		f18_local0:addRightButtonPrompt(f18_local5)
		f18_local0:registerEventHandler("button_prompt_pageup", CoD.LeaderboardZombie.PageUp)
		f18_local0:registerEventHandler("button_prompt_pagedown", CoD.LeaderboardZombie.PageDown)
	end
	f18_local3 = {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.LeaderboardZombie.LBTOP + 23,
		bottom = -CoD.ButtonPrompt.Height - 16
	}
	f18_local4 = Engine.GetLeaderboardToolTipText(f18_arg0)
	f18_local5 = 15
	if f18_local4 ~= "" then
		f18_local5 = 13
		f18_local6 = CoD.HintText.Height - 8
		f18_local7 = -5
		f18_local8 = CoD.LeaderboardZombie.AddUIElement(true, false, 10, 500, false, true, -60 - CoD.textSize.Default * 0.9, -40)
		f18_local8.hintArrow = CoD.LeaderboardZombie.AddUIImage(true, false, f18_local7, f18_local7 + f18_local6, false, false, -f18_local6 / 2 - 10, f18_local6 / 2 - 10)
		f18_local8.hintArrow:setImage(RegisterMaterial(CoD.HintText.ArrowMaterialName))
		f18_local8:addElement(f18_local8.hintArrow)
		f18_local8.hint = CoD.LeaderboardZombie.AddUIText(true, false, f18_local7 + f18_local6 + 10, 825, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left)
		f18_local8.hint:setText(f18_local4)
		f18_local8:addElement(f18_local8.hint)
		f18_local0:addElement(f18_local8)
	end
	f18_local0.listBox = CoD.ListBox.new(f18_local3, f18_arg0, f18_local5, CoD.CoD9Button.Height, CoD.LeaderboardZombie.WIDTH, CoD.LeaderboardZombie.ButtonCreator, CoD.LeaderboardZombie.LButtonData, 0)
	f18_local0.listBox:addScrollBar(30, 2)
	f18_local0.listBox.m_positionTextString = "MENU_LB_LISTBOX_POSITION_TEXT"
	f18_local0.listBox.m_pageArrowsOn = true
	f18_local0:addElement(f18_local0.listBox)
	f18_local6 = LUI.UIText.new()
	f18_local6:setLeftRight(true, false, 0, 0)
	f18_local6:setTopBottom(true, false, 0, CoD.textSize.Big)
	f18_local6:setFont(CoD.fonts.Big)
	f18_local0.title = f18_local6
	f18_local0:addElement(f18_local0.title)
	CoD.LeaderboardZombie.LeaderboardAddFilter(f18_local0)
	f18_local0:registerEventHandler("leaderboardlist_update", CoD.LeaderboardZombie.ResultAvailable)
	f18_local0:registerEventHandler("leaderboard_loadnew", CoD.LeaderboardZombie.LoadNew)
	f18_local0:registerEventHandler("leaderboard_jumpToTop", CoD.LeaderboardZombie.JumpToTop)
	f18_local0:registerEventHandler("leaderboard_openFilter", CoD.LeaderboardZombie.OpenFilter)
	f18_local0:registerEventHandler("leaderboard_filterChanged", CoD.LeaderboardZombie.FilterChanged)
	f18_local0:registerEventHandler("click", CoD.LeaderboardZombie.ButtonClicked)
	return f18_local0
end

CoD.LBFilter.Apply = function (f19_arg0, f19_arg1)
	if CoD.LeaderboardZombie.CURR_FILTER_PLAYER ~= f19_arg0.playerBackup or CoD.LeaderboardZombie.CURR_FILTER_DURATION ~= f19_arg0.durationBackup or CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST ~= f19_arg0.playlistBackup then
		local f19_local0 = f19_arg0:getParent()
		f19_local0:processEvent({
			name = "leaderboard_filterChanged"
		})
	end
	f19_arg0:goBack(f19_arg1.controller)
end

CoD.LBFilter.Back = function (f20_arg0, f20_arg1)
	CoD.LeaderboardZombie.CURR_FILTER_DURATION = f20_arg0.durationBackup
	CoD.LeaderboardZombie.CURR_FILTER_PLAYER = f20_arg0.playerBackup
	CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST = f20_arg0.playlistBackup
	f20_arg0:goBack(f20_arg1.controller)
end

CoD.LBFilter.FiltersPlayerSelectionChanged = function (f21_arg0)
	CoD.LeaderboardZombie.CURR_FILTER_PLAYER = f21_arg0.value
end

CoD.LBFilter.FiltersDurationSelectionChanged = function (f22_arg0)
	CoD.LeaderboardZombie.CURR_FILTER_DURATION = f22_arg0.value
end

CoD.LBFilter.FiltersPlaylistSelectionChanged = function (f23_arg0)
	CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST = f23_arg0.value
end

CoD.LBFilter.CreateSelectors = function (f24_arg0, f24_arg1, f24_arg2)
	f24_arg0.playerBackup = CoD.LeaderboardZombie.CURR_FILTER_PLAYER
	f24_arg0.durationBackup = CoD.LeaderboardZombie.CURR_FILTER_DURATION
	f24_arg0.playlistBackup = CoD.LeaderboardZombie.CURR_FILTER_PLAYLIST
	local f24_local0 = CoD.LeaderboardZombie.Leaderboards[CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX][CoD.LeaderboardZombie.CURR_LB_INDEX]
	local f24_local1 = f24_local0[CoD.LeaderboardZombie.LB_LIST_CORE]
	local f24_local2 = f24_local0[CoD.LeaderboardZombie.LB_LIST_HARDCORE]
	local f24_local3 = CoD.ButtonList.new()
	f24_local3:setLeftRight(true, false, 10, 400)
	f24_local3:setTopBottom(true, true, 75, 0)
	f24_arg0:addElement(f24_local3)
	local f24_local4, f24_local5, f24_local6 = nil
	local f24_local7 = 0
	if CoD.LeaderboardZombie.CURR_FILTER_PLAYER ~= CoD.LeaderboardZombie.FILTER_PLAYER_LOBBY then
		f24_local4 = f24_local3:addDvarLeftRightSelector(f24_arg1, Engine.Localize("MENU_LB_FILTER_PLAYERS"), nil, nil, 125)
		f24_local4.strings = CoD.LeaderboardZombie.FILTER_PLAYER_TEXT
		f24_local4.values = CoD.LeaderboardZombie.FILTER_PLAYER_VALUE
		local f24_local8 = CoD.LeaderboardZombie.CURR_FILTER_PLAYER
		for f24_local9 = 1, #f24_local4.values, 1 do
			local f24_local12 = f24_local9
			if #f24_local4.values < f24_local8 then
				f24_local8 = 1
			end
			f24_local4:addChoice(f24_arg1, Engine.Localize(f24_local4.strings[f24_local8]), f24_local4.values[f24_local8], nil, CoD.LBFilter.FiltersPlayerSelectionChanged)
			f24_local8 = f24_local8 + 1
		end
	end
	if f24_local4 ~= nil then
		f24_local4:processEvent({
			name = "gain_focus"
		})
	elseif f24_local5 ~= nil then
		f24_local5:processEvent({
			name = "gain_focus"
		})
	elseif f24_local6 ~= nil then
		f24_local6:processEvent({
			name = "gain_focus"
		})
	end
end

LUI.createMenu.LBFilter = function (f25_arg0)
	local f25_local0 = CoD.Popup.SetupPopup("LBFilter", f25_arg0)
	f25_local0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_LB_CHANGE_FILTER")))
	f25_local0.msg = nil
	local f25_local1 = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_LB_APPLY_FILTER"), f25_local0, "lbfilter_apply")
	local f25_local2 = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), f25_local0, "lbfilter_back")
	f25_local0.createSelectors = CoD.LBFilter.CreateSelectors
	f25_local0:registerEventHandler("lbfilter_apply", CoD.LBFilter.Apply)
	f25_local0:registerEventHandler("lbfilter_back", CoD.LBFilter.Back)
	f25_local0:addLeftButtonPrompt(f25_local1)
	f25_local0:addLeftButtonPrompt(f25_local2)
	Engine.PlaySound("cac_loadout_edit_sel")
	return f25_local0
end

