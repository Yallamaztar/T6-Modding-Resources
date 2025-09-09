if CoD == nil then
	CoD = {}
end
CoD.isXBOX = false
CoD.isPS3 = false
CoD.isPC = false
CoD.isWIIU = false
CoD.LANGUAGE_ENGLISH = 0
CoD.LANGUAGE_FRENCH = 1
CoD.LANGUAGE_FRENCHCANADIAN = 2
CoD.LANGUAGE_GERMAN = 3
CoD.LANGUAGE_AUSTRIAN = 4
CoD.LANGUAGE_ITALIAN = 5
CoD.LANGUAGE_SPANISH = 6
CoD.LANGUAGE_BRITISH = 7
CoD.LANGUAGE_RUSSIAN = 8
CoD.LANGUAGE_POLISH = 9
CoD.LANGUAGE_KOREAN = 10
CoD.LANGUAGE_JAPANESE = 11
CoD.LANGUAGE_CZECH = 12
CoD.LANGUAGE_FULLJAPANESE = 13
CoD.LANGUAGE_PORTUGUESE = 14
CoD.LANGUAGE_MEXICANSPANISH = 15
CoD.XC_LOCALE_UNITED_STATES = 36
CoD.UIMENU_NONE = 0
CoD.UIMENU_MAIN = 1
CoD.UIMENU_MAINLOBBY = 2
CoD.UIMENU_INGAME = 3
CoD.UIMENU_PREGAME = 4
CoD.UIMENU_POSTGAME = 5
CoD.UIMENU_WM_QUICKMESSAGE = 6
CoD.UIMENU_SCRIPT_POPUP = 7
CoD.UIMENU_SCOREBOARD = 8
CoD.UIMENU_GAMERCARD = 9
CoD.UIMENU_MUTEERROR = 10
CoD.UIMENU_SPLITSCREENGAMESETUP = 11
CoD.UIMENU_SYSTEMLINKJOINGAME = 12
CoD.UIMENU_PARTY = 13
CoD.UIMENU_WAGER_PARTY = 14
CoD.UIMENU_LEAGUE_PARTY = 15
CoD.UIMENU_GAMELOBBY = 16
CoD.UIMENU_WAGERLOBBY = 17
CoD.UIMENU_PRIVATELOBBY = 18
CoD.UIMENU_LEAGUELOBBY = 19
if UIExpression.GetCurrentPlatform() == "xbox" then
	CoD.isXBOX = true
end
if UIExpression.GetCurrentPlatform() == "ps3" then
	CoD.isPS3 = true
end
if UIExpression.GetCurrentPlatform() == "pc" then
	CoD.isPC = true
end
if UIExpression.GetCurrentPlatform() == "wiiu" then
	CoD.isWIIU = true
end
CoD.gametypesTable = "maps/gametypestable.csv"
CoD.mapsTable = "maps/mapstable.csv"
CoD.profileKey_gametype = "gametype"
CoD.profileKey_map = "map"
CoD.rankTable = "mp/rankTable.csv"
CoD.rankIconTable = "mp/rankIconTable.csv"
CoD.factionTable = "mp/factionTable.csv"
CoD.attachmentTable = "mp/attachmentTable.csv"
CoD.didYouKnowTable = "mp/didYouKnow.csv"
CoD.isSinglePlayer = false
if UIExpression.GetCurrentExe() == "singleplayer" then
	CoD.isSinglePlayer = true
	CoD.gametypesTable = "maps/gametypestable.csv"
	CoD.mapsTable = "maps/mapstable.csv"
	CoD.gameMode = "SP"
end
CoD.isMultiplayer = false
if UIExpression.GetCurrentExe() == "multiplayer" then
	CoD.isMultiplayer = true
	CoD.gametypesTable = "mp/gametypestable.csv"
	CoD.mapsTable = "mp/mapstable.csv"
	CoD.scoreInfoTable = "mp/scoreInfo.csv"
	CoD.gameMode = "MP"
end
CoD.isZombie = false
if 1 == UIExpression.SessionMode_IsZombiesGame() then
	CoD.isZombie = true
	CoD.gametypesTable = "zm/gametypestable.csv"
	CoD.mapsTable = "zm/mapstable.csv"
	CoD.rankTable = "mp/rankTable_zm.csv"
	CoD.rankIconTable = "mp/rankIconTable_zm.csv"
	CoD.factionTable = "zm/factionTable.csv"
	CoD.profileKey_gametype = "gametype_zm"
	CoD.profileKey_map = "map_zm"
	CoD.gameMode = "ZM"
end
CoD.disableRewards = true
if CoD.perController == nil then
	CoD.perController = {}
	for f0_local0 = 0, 3, 1 do
		CoD.perController[f0_local0] = {}
	end
end
if CoD.fonts == nil then
	CoD.fonts = {}
end
if CoD.LANGUAGE_JAPANESE == Dvar.loc_language:get() or CoD.LANGUAGE_FULLJAPANESE == Dvar.loc_language:get() then
	CoD.fonts.Condensed = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/normalFont")
	CoD.fonts.Default = CoD.fonts.Condensed
	CoD.fonts.Big = CoD.fonts.Condensed
	CoD.fonts.Morris = CoD.fonts.Condensed
	CoD.fonts.ExtraSmall = CoD.fonts.Condensed
	CoD.fonts.Tiny = CoD.fonts.Condensed
	CoD.fonts.Italic = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/italicFont")
	CoD.fonts.SmallItalic = CoD.fonts.Italic
else
	CoD.fonts.Default = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/smallFont")
	CoD.fonts.Condensed = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/normalFont")
	CoD.fonts.Italic = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/italicFont")
	CoD.fonts.Big = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/bigFont")
	CoD.fonts.Morris = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/extraBigFont")
	CoD.fonts.ExtraSmall = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/extraSmallFont")
	CoD.fonts.Tiny = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/extraSmallFont")
	CoD.fonts.SmallItalic = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/smallItalicFont")
end
CoD.fonts.Dist = RegisterFont("fonts/distFont")
LUI.DefaultFont = CoD.fonts.Default
CoD.textSize = {}
if CoD.LANGUAGE_RUSSIAN == Dvar.loc_language:get() then
	CoD.textSize.Tiny = 16
	CoD.textSize.ExtraSmall = 20
	CoD.textSize.SmallItalic = 20
	CoD.textSize.Default = 21
	CoD.textSize.Italic = 21
	CoD.textSize.Condensed = 24
	CoD.textSize.Big = 36
	CoD.textSize.Morris = 42
elseif CoD.LANGUAGE_POLISH == Dvar.loc_language:get() then
	CoD.textSize.Tiny = 12
	CoD.textSize.ExtraSmall = 16
	CoD.textSize.SmallItalic = 16
	CoD.textSize.Default = 19
	CoD.textSize.Italic = 21
	CoD.textSize.Condensed = 21
	CoD.textSize.Big = 32
	CoD.textSize.Morris = 42
elseif CoD.LANGUAGE_JAPANESE == Dvar.loc_language:get() or CoD.LANGUAGE_FULLJAPANESE == Dvar.loc_language:get() then
	CoD.textSize.Tiny = 12
	CoD.textSize.ExtraSmall = 15
	CoD.textSize.SmallItalic = 15
	CoD.textSize.Default = 17
	CoD.textSize.Italic = 17
	CoD.textSize.Condensed = 22
	CoD.textSize.Big = 40
	CoD.textSize.Morris = 52
else
	CoD.textSize.Tiny = 16
	CoD.textSize.ExtraSmall = 20
	CoD.textSize.SmallItalic = 20
	CoD.textSize.Default = 25
	CoD.textSize.Italic = 25
	CoD.textSize.Condensed = 30
	CoD.textSize.Big = 48
	CoD.textSize.Morris = 60
end
CoD.buttonStrings = {}
CoD.buttonStrings.primary = "^BBUTTON_LUI_PRIMARY^"
CoD.buttonStrings.secondary = "^BBUTTON_LUI_SECONDARY^"
CoD.buttonStrings.alt1 = "^BBUTTON_LUI_ALT1^"
CoD.buttonStrings.alt2 = "^BBUTTON_LUI_ALT2^"
CoD.buttonStrings.select = "^BBUTTON_LUI_SELECT^"
CoD.buttonStrings.start = "^BBUTTON_LUI_START^"
CoD.buttonStrings.shoulderl = "^BBUTTON_LUI_SHOULDERL^"
CoD.buttonStrings.shoulderr = "^BBUTTON_LUI_SHOULDERR^"
CoD.buttonStrings.right_stick = "^BBUTTON_LUI_RIGHT_STICK^"
CoD.buttonStrings.left_stick_up = "^BBUTTON_LUI_LEFT_STICK_UP^"
CoD.buttonStrings.right_trigger = "^BBUTTON_LUI_RIGHT_TRIGGER^"
CoD.buttonStrings.left_trigger = "^BBUTTON_LUI_LEFT_TRIGGER^"
CoD.buttonStrings.dpad_all = "^BBUTTON_LUI_DPAD_ALL^"
CoD.buttonStrings.dpad_ud = "^BBUTTON_LUI_DPAD_UD^"
CoD.buttonStrings.dpad_lr = "^BBUTTON_LUI_DPAD_RL^"
CoD.buttonStrings.left = "^BBUTTON_LUI_DPAD_L^"
CoD.buttonStrings.up = "^BBUTTON_LUI_DPAD_U^"
CoD.buttonStrings.down = "^BBUTTON_LUI_DPAD_D^"
CoD.buttonStrings.emblem_move = "^BBUTTON_EMBLEM_MOVE^"
CoD.buttonStrings.emblem_scale = "^BBUTTON_EMBLEM_SCALE^"
CoD.buttonStrings.right_stick_pressed = "^BBUTTON_LUI_RIGHT_STICK^"
if CoD.isPC == true then
	CoD.buttonStrings.right = "^BBUTTON_LUI_DPAD_R^"
	CoD.buttonStringsShortCut = {}
	CoD.buttonStringsShortCut.primary = "@KEY_ENTER"
	CoD.buttonStringsShortCut.secondary = "@KEY_ESC_SHORT"
	CoD.buttonStringsShortCut.alt1 = "unnasigned_alt1"
	CoD.buttonStringsShortCut.alt2 = "unnasigned_alt2"
	CoD.buttonStringsShortCut.select = "@KEY_TAB"
	CoD.buttonStringsShortCut.start = "unnasigned_start"
	CoD.buttonStringsShortCut.shoulderl = "^BBUTTON_CYCLE_LEFT^"
	CoD.buttonStringsShortCut.shoulderr = "^BBUTTON_CYCLE_RIGHT^"
	CoD.buttonStringsShortCut.right_stick = "+lookstick"
	CoD.buttonStringsShortCut.left_stick_up = "unnasigned_lsu"
	CoD.buttonStringsShortCut.right_trigger = "unnasigned_rt"
	CoD.buttonStringsShortCut.left_trigger = "unnasigned_lt"
	CoD.buttonStringsShortCut.dpad_all = "@KEY_ARROWS"
	CoD.buttonStringsShortCut.dpad_ud = "@KEY_UP_DOWN_ARROWS"
	CoD.buttonStringsShortCut.dpad_lr = "@KEY_LEFT_RIGHT_ARROWS"
	CoD.buttonStringsShortCut.left = "@KEY_LEFTARROW"
	CoD.buttonStringsShortCut.up = "@KEY_UPARROW"
	CoD.buttonStringsShortCut.down = "@KEY_DOWNARROW"
	CoD.buttonStringsShortCut.actiondown = "+actionslot 2"
	CoD.buttonStringsShortCut.actionup = "+actionslot 1"
	CoD.buttonStringsShortCut.actionleft = "+actionslot 3"
	CoD.buttonStringsShortCut.actionright = "+actionslot 4"
	CoD.buttonStringsShortCut.mouse = "^BBUTTON_MOUSE_CLICK^"
	CoD.buttonStringsShortCut.mouse1 = "^BBUTTON_MOUSE_LEFT^"
	CoD.buttonStringsShortCut.mouse2 = "^BBUTTON_MOUSE_RIGHT^"
	CoD.buttonStringsShortCut.mouse3 = "^BBUTTON_MOUSE_MIDDLE^"
	CoD.buttonStringsShortCut.mouse_edit = "^BBUTTON_MOUSE_EDIT^"
	CoD.buttonStringsShortCut.wheelup = "^BMOUSE_WHEEL_UP^"
	CoD.buttonStringsShortCut.wheeldown = "^BMOUSE_WHEEL_DOWN^"
	CoD.buttonStringsShortCut.space = "@KEY_SPACE"
	CoD.buttonStringsShortCut.backspace = "@KEY_BACKSPACE"
	CoD.buttonStringsShortCut.emblem_move = "^BBUTTON_MOUSE_MIDDLE^"
	CoD.buttonStringsShortCut.emblem_scale = "^BBUTTON_MOUSE_MIDDLE^"
end
CoD.white = {}
CoD.white.r = 1
CoD.white.g = 1
CoD.white.b = 1
CoD.red = {}
CoD.red.r = 0.73
CoD.red.g = 0.25
CoD.red.b = 0.25
CoD.brightRed = {}
CoD.brightRed.r = 1
CoD.brightRed.g = 0.19
CoD.brightRed.b = 0.19
CoD.yellow = {}
CoD.yellow.r = 1
CoD.yellow.g = 1
CoD.yellow.b = 0.5
CoD.yellowGlow = {}
CoD.yellowGlow.r = 0.9
CoD.yellowGlow.g = 0.69
CoD.yellowGlow.b = 0.2
CoD.green = {}
CoD.green.r = 0.42
CoD.green.g = 0.68
CoD.green.b = 0.46
CoD.brightGreen = {}
CoD.brightGreen.r = 0.42
CoD.brightGreen.g = 0.9
CoD.brightGreen.b = 0.46
CoD.blue = {}
CoD.blue.r = 0.35
CoD.blue.g = 0.63
CoD.blue.b = 0.75
CoD.blueGlow = {}
CoD.blueGlow.r = 0.68
CoD.blueGlow.g = 0.86
CoD.blueGlow.b = 1
CoD.lightBlue = {}
CoD.lightBlue.r = 0.15
CoD.lightBlue.g = 0.55
CoD.lightBlue.b = 1
CoD.greenBlue = {}
CoD.greenBlue.r = 0.26
CoD.greenBlue.g = 0.59
CoD.greenBlue.b = 0.54
CoD.visorBlue = {}
CoD.visorBlue.r = 0.63
CoD.visorBlue.g = 0.79
CoD.visorBlue.b = 0.78
CoD.visorDeepBlue = {}
CoD.visorDeepBlue.r = 0.23
CoD.visorDeepBlue.g = 0.37
CoD.visorDeepBlue.b = 0.36
CoD.visorBlue1 = {}
CoD.visorBlue1.r = 0.4
CoD.visorBlue1.g = 0.55
CoD.visorBlue1.b = 0.51
CoD.visorBlue2 = {}
CoD.visorBlue2.r = 0.4
CoD.visorBlue2.g = 0.55
CoD.visorBlue2.b = 0.51
CoD.visorBlue3 = {}
CoD.visorBlue3.r = 0.94
CoD.visorBlue3.g = 1
CoD.visorBlue3.b = 1
CoD.visorBlue4 = {}
CoD.visorBlue4.r = 0.91
CoD.visorBlue4.g = 1
CoD.visorBlue4.b = 0.98
CoD.offWhite = {}
CoD.offWhite.r = 1
CoD.offWhite.g = 1
CoD.offWhite.b = 1
CoD.gray = {}
CoD.gray.r = 0.39
CoD.gray.g = 0.38
CoD.gray.b = 0.36
CoD.offGray = {}
CoD.offGray.r = 0.27
CoD.offGray.g = 0.28
CoD.offGray.b = 0.24
CoD.black = {}
CoD.black.r = 0
CoD.black.g = 0
CoD.black.b = 0
CoD.orange = {}
CoD.orange.r = 0.96
CoD.orange.g = 0.58
CoD.orange.b = 0.11
CoD.trueOrange = {}
CoD.trueOrange.r = 1
CoD.trueOrange.g = 0.5
CoD.trueOrange.b = 0
CoD.BOIIOrange = {}
CoD.BOIIOrange.r = 1
CoD.BOIIOrange.g = 0.4
CoD.BOIIOrange.b = 0
CoD.playerYellow = {}
CoD.playerYellow.r = 0.92
CoD.playerYellow.g = 0.8
CoD.playerYellow.b = 0.31
CoD.playerBlue = {}
CoD.playerBlue.r = 0.35
CoD.playerBlue.g = 0.63
CoD.playerBlue.b = 0.9
CoD.playerRed = {}
CoD.playerRed.r = 0.73
CoD.playerRed.g = 0.25
CoD.playerRed.b = 0.25
CoD.RTSColors = {}
CoD.RTSColors.red = {}
CoD.RTSColors.red.r = 0.6
CoD.RTSColors.red.g = 0
CoD.RTSColors.red.b = 0
CoD.RTSColors.blue = {}
CoD.RTSColors.blue.r = 0.23
CoD.RTSColors.blue.g = 0.86
CoD.RTSColors.blue.b = 0.85
CoD.RTSColors.magenta = {}
CoD.RTSColors.magenta.r = 0.85
CoD.RTSColors.magenta.g = 0.04
CoD.RTSColors.magenta.b = 0.36
CoD.RTSColors.yellow = {}
CoD.RTSColors.yellow.r = 0.8
CoD.RTSColors.yellow.g = 0.74
CoD.RTSColors.yellow.b = 0.21
if CoD.isSinglePlayer then
	CoD.DefaultTextColor = CoD.visorBlue4
	CoD.ButtonTextColor = CoD.visorBlue4
	CoD.DisabledTextColor = CoD.visorBlue1
	CoD.DisabledAlpha = 1
else
	CoD.DefaultTextColor = CoD.offWhite
	CoD.ButtonTextColor = CoD.offWhite
	CoD.DisabledTextColor = CoD.offWhite
	CoD.DisabledAlpha = 0.5
end
CoD.KEYBOARD_TYPE_DEMO = 1
CoD.KEYBOARD_TYPE_EMAIL = 2
CoD.KEYBOARD_TYPE_CUSTOM_CLASS = 3
CoD.KEYBOARD_TYPE_LEAGUES = 4
CoD.KEYBOARD_TYPE_TWITCH_USER = 5
CoD.KEYBOARD_TYPE_TWITCH_PASS = 6
CoD.KEYBOARD_TYPE_TEXT_MESSAGE = 7
CoD.KEYBOARD_TYPE_ADD_FRIEND = 8
CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_PASSWORD = 9
CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_ACCENTS = 10
CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_NUMERIC = 11
CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_ACCOUNTNAME = 12
CoD.KEYBOARD_TYPE_NUMERIC_FIELD = 13
CoD.KEYBOARD_TYPE_CLAN_TAG = 14
CoD.KEYBOARD_TYPE_TWITTER_USER = 15
CoD.KEYBOARD_TYPE_TWITTER_PASS = 16
CoD.KEYBOARD_TYPE_CLASS_SET = 17
CoD.TEAM_FREE = 0
CoD.TEAM_ALLIES = 1
CoD.TEAM_AXIS = 2
CoD.TEAM_THREE = 3
CoD.TEAM_FOUR = 4
CoD.TEAM_FIVE = 5
CoD.TEAM_SIX = 6
CoD.TEAM_SEVEN = 7
CoD.TEAM_EIGHT = 8
CoD.TEAM_FIRST_PLAYING_TEAM = CoD.TEAM_ALLIES
CoD.TEAM_LAST_PLAYING_TEAM = CoD.TEAM_EIGHT
if CoD.isMultiplayer then
	CoD.TEAM_SPECTATOR = 9
	CoD.TEAM_NUM_TEAMS = 10
else
	CoD.TEAM_NEUTRAL = 4
	CoD.TEAM_SPECTATOR = 5
	CoD.TEAM_DEAD = 6
	CoD.TEAM_NUM_TEAMS = 7
end
CoD.SCOREBOARD_SORT_DEFAULT = 0
CoD.SCOREBOARD_SORT_SCORE = 0
CoD.SCOREBOARD_SORT_ALPHABETICAL = 1
CoD.SCOREBOARD_SORT_CLIENTNUM = 2
CoD.teamColorFriendly = {}
local f0_local0 = CoD.teamColorFriendly
local f0_local1 = CoD.teamColorFriendly
local f0_local2 = CoD.teamColorFriendly
local f0_local3, f0_local4, f0_local5 = Dvar.g_TeamColor_MyTeam:get()
f0_local2.b = f0_local5
f0_local1.g = f0_local4
f0_local0.r = f0_local3
CoD.teamColorEnemy = {}
f0_local0 = CoD.teamColorEnemy
f0_local1 = CoD.teamColorEnemy
f0_local2 = CoD.teamColorEnemy
f0_local3, f0_local4, f0_local5 = Dvar.g_TeamColor_EnemyTeam:get()
f0_local2.b = f0_local5
f0_local1.g = f0_local4
f0_local0.r = f0_local3
CoD.teamColor = {}
CoD.teamColor[CoD.TEAM_FREE] = {}
CoD.teamColor[CoD.TEAM_FREE].r = 1
CoD.teamColor[CoD.TEAM_FREE].g = 1
CoD.teamColor[CoD.TEAM_FREE].b = 1
CoD.teamColor[CoD.TEAM_ALLIES] = {}
CoD.teamColor[CoD.TEAM_AXIS] = {}
CoD.teamColor[CoD.TEAM_THREE] = {}
CoD.teamColor[CoD.TEAM_FOUR] = {}
CoD.teamColor[CoD.TEAM_FIVE] = {}
CoD.teamColor[CoD.TEAM_SIX] = {}
CoD.teamColor[CoD.TEAM_SEVEN] = {}
CoD.teamColor[CoD.TEAM_EIGHT] = {}
if CoD.isZombie == true then
	CoD.teamColor[CoD.TEAM_ALLIES].r = 0.21
	CoD.teamColor[CoD.TEAM_ALLIES].g = 0
	CoD.teamColor[CoD.TEAM_ALLIES].b = 0
	CoD.teamColor[CoD.TEAM_AXIS].r = 0.21
	CoD.teamColor[CoD.TEAM_AXIS].g = 0
	CoD.teamColor[CoD.TEAM_AXIS].b = 0
	CoD.teamColor[CoD.TEAM_THREE].r = 0.21
	CoD.teamColor[CoD.TEAM_THREE].g = 0
	CoD.teamColor[CoD.TEAM_THREE].b = 0
else
	CoD.teamColor[CoD.TEAM_ALLIES].r = 0.4
	CoD.teamColor[CoD.TEAM_ALLIES].g = 0.4
	CoD.teamColor[CoD.TEAM_ALLIES].b = 0.4
	CoD.teamColor[CoD.TEAM_AXIS].r = 0.45
	CoD.teamColor[CoD.TEAM_AXIS].g = 0.31
	CoD.teamColor[CoD.TEAM_AXIS].b = 0.18
	CoD.teamColor[CoD.TEAM_THREE].r = 1
	CoD.teamColor[CoD.TEAM_THREE].g = 0
	CoD.teamColor[CoD.TEAM_THREE].b = 0
	CoD.teamColor[CoD.TEAM_FOUR].r = 0
	CoD.teamColor[CoD.TEAM_FOUR].g = 1
	CoD.teamColor[CoD.TEAM_FOUR].b = 0
	CoD.teamColor[CoD.TEAM_FIVE].r = 0
	CoD.teamColor[CoD.TEAM_FIVE].g = 0
	CoD.teamColor[CoD.TEAM_FIVE].b = 1
	CoD.teamColor[CoD.TEAM_SIX].r = 1
	CoD.teamColor[CoD.TEAM_SIX].g = 1
	CoD.teamColor[CoD.TEAM_SIX].b = 0
	CoD.teamColor[CoD.TEAM_SEVEN].r = 0
	CoD.teamColor[CoD.TEAM_SEVEN].g = 1
	CoD.teamColor[CoD.TEAM_SEVEN].b = 1
	CoD.teamColor[CoD.TEAM_EIGHT].r = 0.1
	CoD.teamColor[CoD.TEAM_EIGHT].g = 0.5
	CoD.teamColor[CoD.TEAM_EIGHT].b = 0.3
end
CoD.teamColor[CoD.TEAM_SPECTATOR] = {}
CoD.teamColor[CoD.TEAM_SPECTATOR].r = 0.75
CoD.teamColor[CoD.TEAM_SPECTATOR].g = 0.75
CoD.teamColor[CoD.TEAM_SPECTATOR].b = 0.75
CoD.GMLOC_ON = string.char(20)
CoD.GMLOC_OFF = string.char(21)
CoD.factionColor = {}
CoD.factionColor.seals = {}
CoD.factionColor.seals[CoD.TEAM_FREE] = CoD.teamColor[CoD.TEAM_FREE]
CoD.factionColor.seals[CoD.TEAM_ALLIES] = CoD.teamColor[CoD.TEAM_ALLIES]
CoD.factionColor.seals[CoD.TEAM_AXIS] = CoD.teamColor[CoD.TEAM_AXIS]
CoD.factionColor.seals[CoD.TEAM_THREE] = CoD.teamColor[CoD.TEAM_THREE]
CoD.factionColor.seals[CoD.TEAM_FOUR] = CoD.teamColor[CoD.TEAM_FOUR]
CoD.factionColor.seals[CoD.TEAM_FIVE] = CoD.teamColor[CoD.TEAM_FIVE]
CoD.factionColor.seals[CoD.TEAM_SIX] = CoD.teamColor[CoD.TEAM_SIX]
CoD.factionColor.seals[CoD.TEAM_SEVEN] = CoD.teamColor[CoD.TEAM_SEVEN]
CoD.factionColor.seals[CoD.TEAM_EIGHT] = CoD.teamColor[CoD.TEAM_EIGHT]
CoD.factionColor.seals[CoD.TEAM_SPECTATOR] = CoD.teamColor[CoD.TEAM_SPECTATOR]
CoD.teamName = {}
CoD.teamName[CoD.TEAM_FREE] = Engine.Localize("MPUI_AUTOASSIGN")
CoD.teamName[CoD.TEAM_THREE] = "Three"
CoD.teamName[CoD.TEAM_FOUR] = "Four"
CoD.teamName[CoD.TEAM_FIVE] = "Five"
CoD.teamName[CoD.TEAM_SIX] = "Six"
CoD.teamName[CoD.TEAM_SEVEN] = "Seven"
CoD.teamName[CoD.TEAM_EIGHT] = "Eight"
CoD.teamName[CoD.TEAM_SPECTATOR] = Engine.Localize("MPUI_SHOUTCASTER")
if not CoD.isMultiplayer then
	CoD.teamName[CoD.TEAM_NEUTRAL] = "NEUTRAL"
	CoD.teamName[CoD.TEAM_DEAD] = "DEAD"
end
CoD.textAlpha = 0.7
CoD.textAlphaBlackDark = 0.7
CoD.textAlphaBlackLight = 0.2
CoD.frameSubtitleHeight = CoD.textSize.Default
CoD.frameSubtitleFont = CoD.fonts.Default
CoD.SDSafeWidth = 864
CoD.SDSafeHeight = 648
CoD.HDSafeWidth = 1152
CoD.HDSafeHeight = CoD.SDSafeHeight
CoD.HUDBaseColor = {
	r = 1,
	g = 1,
	b = 1
}
CoD.HUDAlphaEmpty = 0.6
CoD.HUDAlphaFull = 1
CoD.LEVEL_FIRST = "angola"
CoD.LEVEL_COOP_FIRST = "maze"
CoD.THUMBSTICK_DEFAULT = 0
CoD.THUMBSTICK_SOUTHPAW = 1
CoD.THUMBSTICK_LEGACY = 2
CoD.THUMBSTICK_LEGACYSOUTHPAW = 3
CoD.BUTTONS_DEFAULT = 0
CoD.BUTTONS_EXPERIMENTAL = 1
CoD.BUTTONS_LEFTY = 2
CoD.BUTTONS_NOMAD = 3
CoD.BUTTONS_CHARLIE = 4
CoD.BUTTONS_DEFAULT_ALT = 5
CoD.BUTTONS_EXPERIMENTAL_ALT = 6
CoD.BUTTONS_LEFTY_ALT = 7
CoD.BUTTONS_NOMAD_ALT = 8
CoD.TRIGGERS_DEFAULT = 0
CoD.TRIGGERS_FLIPPED = 1
CoD.START_GAME_CAMPAIGN = 0
CoD.START_GAME_MULTIPLAYER = 1
CoD.START_GAME_ZOMBIES = 2
CoD.DEMO_CONTROLLER_CONFIG_DEFAULT = 0
CoD.DEMO_CONTROLLER_CONFIG_DIGITAL = 1
CoD.DEMO_CONTROLLER_CONFIG_BADBOT = 2
CoD.PS3_INSTALL_NOT_PRESENT = 0
CoD.PS3_INSTALL_PRESENT = 1
CoD.PS3_INSTALL_UNAVAILABLE = 2
CoD.PS3_INSTALL_CORRUPT_OR_OUTDATED = 3
CoD.SENSITIVITY_1 = 0.4
CoD.SENSITIVITY_2 = 0.6
CoD.SENSITIVITY_3 = 0.8
CoD.SENSITIVITY_4 = 1
CoD.SENSITIVITY_5 = 1.2
CoD.SENSITIVITY_6 = 1.4
CoD.SENSITIVITY_7 = 1.6
CoD.SENSITIVITY_8 = 1.8
CoD.SENSITIVITY_9 = 2
CoD.SENSITIVITY_10 = 2.25
CoD.SENSITIVITY_11 = 2.5
CoD.SENSITIVITY_12 = 3
CoD.SENSITIVITY_13 = 3.5
CoD.SENSITIVITY_14 = 4
if CoD.isWIIU then
	CoD.BIND_PLAYER = 0
	CoD.BIND_PLAYER2 = 1
	CoD.BIND_VEHICLE = 2
	CoD.BIND_TWIST = 3
else
	CoD.BIND_PLAYER = 0
	CoD.BIND_VEHICLE = 1
end
CoD.SESSIONMODE_OFFLINE = 0
CoD.SESSIONMODE_SYSTEMLINK = 1
CoD.SESSIONMODE_ONLINE = 2
CoD.SESSIONMODE_PRIVATE = 3
CoD.SESSIONMODE_ZOMBIES = 4
CoD.GAMEMODE_PUBLIC_MATCH = 0
CoD.GAMEMODE_PRIVATE_MATCH = 1
CoD.GAMEMODE_LOCAL_SPLITSCREEN = 2
CoD.GAMEMODE_WAGER_MATCH = 3
CoD.GAMEMODE_BASIC_TRAINING = 4
CoD.GAMEMODE_THEATER = 5
CoD.GAMEMODE_LEAGUE_MATCH = 6
CoD.GAMEMODE_RTS = 7
CoD.OBJECTIVESTATE_EMPTY = 0
CoD.OBJECTIVESTATE_ACTIVE = 1
CoD.OBJECTIVESTATE_INVISIBLE = 2
CoD.FRIEND_NOTJOINABLE = 0
CoD.FRIEND_JOINABLE = 1
CoD.FRIEND_AUTOJOINABLE = 2
CoD.FRIEND_AUTOJOINED = 3
CoD.MaxPlayerListRows = 19
CoD.playerListType = {
	friend = 0,
	recentPlayer = 1,
	party = 2,
	platform = 3,
	facebook = 4,
	elite = 5,
	gameInvites = 6,
	clan = 7,
	friendRequest = 8,
	leagueFriend = 9,
	leaderboard = -1
}
CoD.STATS_LOCATION_NORMAL = 0
CoD.STATS_LOCATION_FORCE_NORMAL = 1
CoD.STATS_LOCATION_BACKUP = 2
CoD.STATS_LOCATION_STABLE = 3
CoD.STATS_LOCATION_OTHERPLAYER = 4
CoD.STATS_LOCATION_BASICTRAINING = 5
CoD.MILESTONE_GLOBAL = 0
CoD.MILESTONE_WEAPON = 1
CoD.MILESTONE_GAMEMODE = 2
CoD.MILESTONE_GROUP = 3
CoD.MILESTONE_ATTACHMENTS = 4
CoD.MAX_RANK = UIExpression.TableLookup(0, CoD.rankTable, 0, "maxrank", 1)
CoD.MAX_PRESTIGE = UIExpression.TableLookup(0, CoD.rankIconTable, 0, "maxprestige", 1)
CoD.MAX_RANKXP = tonumber(UIExpression.TableLookup(0, CoD.rankTable, 0, CoD.MAX_RANK, 7))
CoD.LB_FILTER_NONE = 0
CoD.LB_FILTER_FRIENDS = 1
CoD.LB_FILTER_LOBBY_MEMBERS = 2
CoD.LB_FILTER_ELITE = 3
CoD.LB_FILTER_FACEBOOK_FRIENDS = 4
CoD.REQUEST_MULTI_LB_READ_COMBAT_RECORD_DATA = 1
CoD.REQUEST_MULTI_LB_READ_MINI_LBS = 2
CoD.MaxMomentum = 0
CoD.SplitscreenMultiplier = 2
CoD.SplitscreenNotificationMultiplier = 1.5
if not CoD.LeaguesData then
	CoD.LeaguesData = {}
	CoD.LeaguesData.CurrentTeamInfo = {}
	CoD.LeaguesData.CurrentTeamSubdivisionInfo = {}
	CoD.LeaguesData.TeamSubdivisionInfo = {}
	CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus = {}
	CoD.LeaguesData.TeamSubdivisionInfo.data = {}
end
CoD.LeaguesData.LEAGUE_OUTCOME_BASE = 0
CoD.LeaguesData.LEAGUE_OUTCOME_WINNER = 1
CoD.LeaguesData.LEAGUE_OUTCOME_LOSER = 2
CoD.LeaguesData.LEAGUE_OUTCOME_PRE_LOSER = 3
CoD.LeaguesData.LEAGUE_OUTCOME_RESET = 4
CoD.LeaguesData.LEAGUE_OUTCOME_DRAW = 5
CoD.LeaguesData.LEAGUE_STAT_FLOAT_SKILL = 0
CoD.LeaguesData.LEAGUE_STAT_FLOAT_VARIANCE = 1
CoD.LeaguesData.LEAGUE_STAT_FLOAT_PLACEMENT_SKILL = 2
CoD.LeaguesData.LEAGUE_STAT_FLOAT_COUNT = 3
CoD.LeaguesData.LEAGUE_STAT_INT_RANKPOINTS = 0
CoD.LeaguesData.LEAGUE_STAT_INT_PLAYED = 1
CoD.LeaguesData.LEAGUE_STAT_INT_WINS = 2
CoD.LeaguesData.LEAGUE_STAT_INT_LOSSES = 3
CoD.LeaguesData.LEAGUE_STAT_INT_BONUS_USED = 4
CoD.LeaguesData.LEAGUE_STAT_INT_BONUS_TIME = 5
CoD.LeaguesData.LEAGUE_STAT_INT_STREAK = 6
CoD.LeaguesData.LEAGUE_STAT_INT_CAREER_WINS = 7
CoD.LeaguesData.LEAGUE_STAT_INT_COUNT = 8
CoD.PARTYHOST_STATE_NONE = 0
CoD.PARTYHOST_STATE_EDITING_GAME_OPTIONS = 1
CoD.PARTYHOST_STATE_MODIFYING_CAC = 2
CoD.PARTYHOST_STATE_MODIFYING_REWARDS = 3
CoD.PARTYHOST_STATE_VIEWING_PLAYERCARD = 4
CoD.PARTYHOST_STATE_SELECTING_PLAYLIST = 5
CoD.PARTYHOST_STATE_SELECTING_MAP = 6
CoD.PARTYHOST_STATE_SELECTING_GAMETYPE = 7
CoD.PARTYHOST_STATE_VIEWING_COD_TV = 8
CoD.PARTYHOST_STATE_COUNTDOWN_CANCELLED = 9
CoD.partyHostStateText = {}
CoD.partyHostStateText[CoD.PARTYHOST_STATE_NONE] = ""
CoD.partyHostStateText[CoD.PARTYHOST_STATE_EDITING_GAME_OPTIONS] = Engine.Localize("MENU_EDITING_GAME_OPTIONS")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_MODIFYING_CAC] = Engine.Localize("MENU_MODIFYING_CAC")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_MODIFYING_REWARDS] = Engine.Localize("MENU_MODIFYING_REWARDS")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_VIEWING_PLAYERCARD] = Engine.Localize("MENU_VIEWING_PLAYERCARD")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_SELECTING_PLAYLIST] = Engine.Localize("MENU_VIEWING_PLAYLISTS")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_SELECTING_MAP] = Engine.Localize("MENU_SELECTING_MAP")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_SELECTING_GAMETYPE] = Engine.Localize("MENU_SELECTING_GAMETYPE")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_VIEWING_COD_TV] = Engine.Localize("MENU_VIEWING_COD_TV")
CoD.partyHostStateText[CoD.PARTYHOST_STATE_COUNTDOWN_CANCELLED] = Engine.Localize("MENU_COUNTDOWN_CANCELLED")
CoD.SESSION_REJOIN_CANCEL_JOIN_SESSION = 0
CoD.SESSION_REJOIN_CHECK_FOR_SESSION = 1
CoD.SESSION_REJOIN_JOIN_SESSION = 2
CoD.FEATURE_BAN_LIVE_MP = 1
CoD.FEATURE_BAN_LIVE_ZOMBIE = 2
CoD.FEATURE_BAN_LEADERBOARD_WRITE_MP = 3
CoD.FEATURE_BAN_LEADERBOARD_WRITE_ZOMBIE = 4
CoD.FEATURE_BAN_MP_SPLIT_SCREEN = 5
CoD.FEATURE_BAN_EMBLEM_EDITOR = 6
CoD.FEATURE_BAN_PIRACY = 7
CoD.FEATURE_BAN_PRESTIGE = 8
CoD.FEATURE_BAN_LIVE_STREAMING = 9
CoD.FEATURE_BAN_LIVE_STREAMING_CAMERA = 10
CoD.FEATURE_BAN_LEAGUES_GAMEPLAY = 11
CoD.FEATURE_BAN_HOSTING = 12
CoD.FEATURE_BAN_PRESTIGE_EXTRAS = 13
CoD.SYSINFO_VERSION_NUMBER = 0
CoD.SYSINFO_CONNECTIVITY_INFO = 1
CoD.SYSINFO_NAT_TYPE = 2
CoD.SYSINFO_CUSTOMER_SUPPORT_LINK = 3
CoD.SYSINFO_BANDWIDTH = 4
CoD.SYSINFO_IP_ADDRESS = 5
CoD.SYSINFO_GEOGRAPHICAL_REGION = 6
CoD.SYSINFO_Q = 7
CoD.SYSINFO_CONSOLE_ID = 8
CoD.SYSINFO_MAC_ADDRESS = 9
CoD.SYSINFO_NAT_TYPE_LOBBY = 10
CoD.SYSINFO_CONNECTION_TYPE = 11
CoD.SYSINFO_XUID = 12
CoD.RECORD_EVENT_DW_EREG_ENTRY_ERROR = 46
CoD.RECORD_EVENT_RATE_MATCH = 400
CoD.RECORD_EVENT_VOTE_MTX = 425
CoD.EMBLEM = 0
CoD.BACKING = 1
CoD.CONTENT_DEV_MAP_INDEX = -1
CoD.CONTENT_ORIGINAL_MAP_INDEX = 0
CoD.CONTENT_DLC0_INDEX = 1
CoD.CONTENT_DLCZM0_INDEX = 2
CoD.CONTENT_DLC1_INDEX = 3
CoD.CONTENT_DLC2_INDEX = 4
CoD.CONTENT_DLC3_INDEX = 5
CoD.CONTENT_DLC4_INDEX = 6
CoD.CONTENT_DLC5_INDEX = 7
CoD.DLC_CAMO_MENU_VIEWED = 0
CoD.DLC_BACKINGS_MENU_VIEWED = 1
CoD.DLC_RETICLES_MENU_VIEWED = 2
CoD.INGAMESTORE_MENU_VIEWED = 3
CoD.TEAM_INDICATOR_FULL = 0
CoD.TEAM_INDICATOR_ABBREVIATED = 1
CoD.TEAM_INDICATOR_ICON = 2
CoD.UI_SCREENSHOT_TYPE_SCREENSHOT = 0
CoD.UI_SCREENSHOT_TYPE_THUMBNAIL = 1
CoD.UI_SCREENSHOT_TYPE_MOTD = 2
CoD.UI_SCREENSHOT_TYPE_EMBLEM = 3
CoD.EntityType = {}
CoD.EntityType.ET_GENERAL = 0
CoD.EntityType.ET_PLAYER = 1
CoD.EntityType.ET_PLAYER_CORPSE = 2
CoD.EntityType.ET_ITEM = 3
CoD.EntityType.ET_MISSILE = 4
CoD.EntityType.ET_INVISIBLE = 5
CoD.EntityType.ET_SCRIPTMOVER = 6
CoD.EntityType.ET_SOUND_BLEND = 7
CoD.EntityType.ET_FX = 8
CoD.EntityType.ET_LOOP_FX = 9
CoD.EntityType.ET_PRIMARY_LIGHT = 10
CoD.EntityType.ET_TURRET = 11
CoD.EntityType.ET_HELICOPTER = 12
CoD.EntityType.ET_PLANE = 13
CoD.EntityType.ET_VEHICLE = 14
CoD.EntityType.ET_VEHICLE_CORPSE = 15
CoD.EntityType.ET_ACTOR = 16
CoD.EntityType.ET_ACTOR_SPAWNER = 17
CoD.EntityType.ET_ACTOR_CORPSE = 18
CoD.EntityType.ET_STREAMER_HINT = 19
CoD.EntityType.ET_ZBARRIER = 20
CoD.Wiiu = {}
CoD.Wiiu.CONTROLLER_TYPE_WIIREMOTE = 0
CoD.Wiiu.CONTROLLER_TYPE_CLASSIC = 1
CoD.Wiiu.CONTROLLER_TYPE_DRC = 2
CoD.Wiiu.CONTROLLER_TYPE_UC = 3
CoD.Wiiu.DRAG_DISABLED_AFTER = 500
CoD.Wiiu.DRAG_THRESHOLD = 15
CoD.Wiiu.DRAG_THRESHOLD_SQUARED = CoD.Wiiu.DRAG_THRESHOLD * CoD.Wiiu.DRAG_THRESHOLD
CoD.Wiiu.DRC_UI3D_WINDOW_INDEX = 6
CoD.Wiiu.OptionMenuHeight = 450
if CoD.isWIIU then
	CoD.Wiiu.VirtualCoordToDrcHorizontalUnits = 1.5
	CoD.Wiiu.VirtualCoordToDrcVerticalUnits = 1.5
else
	CoD.Wiiu.VirtualCoordToDrcHorizontalUnits = 1
	CoD.Wiiu.VirtualCoordToDrcVerticalUnits = 1
end
CoD.IsLeagueOrCustomMatch = function ()
	local f1_local0 = Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH)
	if not f1_local0 then
		f1_local0 = Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH)
	end
	return f1_local0
end

CoD.SetupSafeAreaOverlay = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setPriority(100)
	Widget:setRGB(0, 0, 1)
	Widget:setAlpha(0.5)
	if not CoD.isPC then
		Widget:setupSafeAreaBoundary()
	end
	return Widget
end

CoD.Wiiu.CreateOptionMenu = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f3_local0 = CoD.InGameMenu.New(f3_arg1, f3_arg0, Engine.Localize(f3_arg2), CoD.isSinglePlayer)
	else
		f3_local0 = CoD.Menu.New(f3_arg1)
		f3_local0:setOwner(f3_arg0)
		f3_local0:addTitle(Engine.Localize(f3_arg2))
		if CoD.isSinglePlayer == false then
			f3_local0:addLargePopupBackground()
		end
	end
	f3_local0.controller = f3_arg0
	if useBigRowHighlight == nil then
		f3_arg3 = false
	end
	if CoD.isSinglePlayer then
		local f3_local1 = CoD.Options.Width
		f3_local0.buttonList = CoD.ButtonList.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f3_local1 / 2,
			right = f3_local1 / 2,
			topAnchor = true,
			bottomAnchor = true,
			top = CoD.Menu.TitleHeight + 20,
			bottom = 0
		})
		if f3_arg3 then
			f3_local0.buttonList:setButtonBackingAnimationState({
				leftAnchor = true,
				rightAnchor = true,
				left = -5,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0,
				material = RegisterMaterial("menu_mp_big_row")
			})
		end
	else
		f3_local0.buttonList = CoD.ButtonList.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = CoD.ButtonList.DefaultWidth - 20,
			topAnchor = true,
			bottomAnchor = true,
			top = CoD.Menu.TitleHeight,
			bottom = 0
		})
	end
	f3_local0:addElement(f3_local0.buttonList)
	return f3_local0
end

CoD.getClanTag = function (f4_arg0)
	if f4_arg0 == nil then
		return ""
	elseif Engine.CanViewContent() == false then
		return ""
	else
		return f4_arg0
	end
end

CoD.getPartyHostStateText = function (f5_arg0)
	return CoD.partyHostStateText[f5_arg0]
end

CoD.NullFunction = function ()

end

f0_local0 = {
	__index = function (f7_arg0, f7_arg1)
		return CoD.NullFunction
	end
}
if UIExpression ~= nil then
	setmetatable(UIExpression, f0_local0)
end
if Engine ~= nil then
	setmetatable(Engine, f0_local0)
end
CoD.useController = true
if Engine.IsUsingCursor() == true then
	CoD.useController = false
end
CoD.useMouse = false
if CoD.isPC == true then
	CoD.useMouse = true
	CoD.useController = true
end
CoD.isOnlineGame = function ()
	if UIExpression.SessionMode_IsOnlineGame() == 1 then
		return true
	else
		return false
	end
end

CoD.isRankedGame = function ()
	local f9_local0
	if CoD.isOnlineGame() == true then
		f9_local0 = not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH)
	else
		f9_local0 = false
	end
	return f9_local0
end

CoD.isHost = function ()
	return UIExpression.DvarBool(nil, "sv_running") == 1
end

CoD.canLeaveGame = function (f11_arg0)
	if CoD.isZombie == true then
		if CoD.InGameMenu.m_unpauseDisabled and CoD.InGameMenu.m_unpauseDisabled[f11_arg0 + 1] ~= nil and CoD.InGameMenu.m_unpauseDisabled[f11_arg0 + 1] > 0 then
			return false
		elseif CoD.isRankedGame() and CoD.isHost() and UIExpression.HostMigrationWaitingForPlayers(f11_arg0) ~= 0 and 1 ~= UIExpression.DvarInt(nil, "g_gameEnded") then
			return false
		end
	end
	local f11_local0
	if UIExpression.IsVisibilityBitSet(f11_arg0, CoD.BIT_ROUND_END_KILLCAM) ~= 0 or UIExpression.IsVisibilityBitSet(f11_arg0, CoD.BIT_FINAL_KILLCAM) ~= 0 then
		f11_local0 = false
	else
		f11_local0 = true
	end
	return f11_local0
end

CoD.IsWagerMode = function ()
	return Engine.GetGametypeSetting("wagermatchhud") == 1
end

CoD.resetGameModes = function ()
	if CoD.isSinglePlayer then
		Engine.ExecNow(nil, "exec default_xboxlive_sp.cfg")
	else
		Engine.ExecNow(nil, "exec default_xboxlive.cfg")
	end
	Engine.GameModeResetModes()
	Engine.SessionModeResetModes()
	Engine.Exec(nil, "freedemomemory")
end

CoD.isPartyHost = function ()
	local f14_local0
	if UIExpression.PrivatePartyHost() ~= 1 and UIExpression.InPrivateParty() ~= 0 then
		f14_local0 = false
	else
		f14_local0 = true
	end
	return f14_local0
end

CoD.isXuidPrivatePartyHost = function (f15_arg0)
	local f15_local0
	if UIExpression.InPrivateParty() ~= 1 or Engine.IsXuidPrivatePartyHost(f15_arg0) ~= true then
		f15_local0 = false
	else
		f15_local0 = true
	end
	return f15_local0
end

CoD.separateNumberWithCommas = function (f16_arg0)
	local f16_local0 = tostring(f16_arg0)
	local f16_local1 = string.len(f16_local0)
	local f16_local2 = nil
	for f16_local3 = f16_local1, 1, -3 do
		local f16_local6 = f16_local3 - 2
		if f16_local6 < 1 then
			f16_local6 = 1
		end
		if f16_local2 == nil then
			f16_local2 = string.sub(f16_local0, f16_local6, f16_local3)
		else
			f16_local2 = string.sub(f16_local0, f16_local6, f16_local3) .. "," .. f16_local2
		end
	end
	return f16_local2
end

CoD.GetLocalizedTierText = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = ""
	if f17_arg1 ~= nil and f17_arg2 ~= nil then
		local f17_local1, f17_local2 = false
		local f17_local3 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_arg1, f17_arg2, 1))
		if f17_local3 > 0 or tonumber(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_arg1, f17_arg2 + 1, 1)) == 1 then
			f17_local1 = true
		end
		if f17_local1 == true then
			f17_local0 = Engine.Localize("CHALLENGE_TIER_" .. f17_local3)
		end
	end
	return f17_local0
end

CoD.IsTieredChallenge = function (f18_arg0, f18_arg1, f18_arg2)
	if f18_arg1 ~= nil and f18_arg2 ~= nil then
		if tonumber(UIExpression.TableLookupGetColumnValueForRow(f18_arg0, f18_arg1, f18_arg2, 1)) > 0 or tonumber(UIExpression.TableLookupGetColumnValueForRow(f18_arg0, f18_arg1, f18_arg2 + 1, 1)) == 1 then
			return true
		end
	end
	return false
end

CoD.GetUnlockStringForItemIndex = function (f19_arg0, f19_arg1)
	if not Engine.HasDLCForItem(f19_arg0, f19_arg1) then
		local f19_local0 = Engine.GetDLCNameForItem(f19_arg1)
		if f19_local0 then
			return Engine.Localize("MENU_" .. f19_local0 .. "_REQUIRED_HINT")
		end
	end
	local f19_local0 = UIExpression.GetItemUnlockLevel(f19_arg0, f19_arg1)
	return Engine.Localize("MENU_UNLOCKED_AT", Engine.GetRankName(f19_local0), f19_local0 + 1)
end

CoD.GetUnlockLevelString = function (f20_arg0, f20_arg1)
	return CoD.GetUnlockStringForItemIndex(f20_arg0, UIExpression.GetItemIndex(f20_arg0, f20_arg1))
end

CoD.PrestigeAvail = function (f21_arg0)
	local f21_local0
	if tonumber(UIExpression.GetStatByName(f21_arg0, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) - 1 or tonumber(UIExpression.GetStatByName(f21_arg0, "RANKXP")) < CoD.MAX_RANKXP then
		f21_local0 = false
	else
		f21_local0 = true
	end
	return f21_local0
end

CoD.PrestigeNext = function (f22_arg0)
	local f22_local0
	if tonumber(UIExpression.GetStatByName(f22_arg0, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) or tonumber(UIExpression.GetStatByName(f22_arg0, "RANK")) ~= tonumber(CoD.MAX_RANK) then
		f22_local0 = false
	else
		f22_local0 = true
	end
	return f22_local0
end

CoD.PrestigeNextLevelText = function (f23_arg0)
	local f23_local0 = tonumber(UIExpression.GetStatByName(f23_arg0, "PLEVEL"))
	local f23_local1 = tonumber(CoD.MAX_PRESTIGE)
	local f23_local2 = 1
	if f23_local1 - 1 <= f23_local0 then
		f23_local2 = ""
	end
	return f23_local2
end

CoD.PrestigeFinish = function (f24_arg0)
	return tonumber(UIExpression.GetStatByName(f24_arg0, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) - 1
end

CoD.CanRankUp = function (f25_arg0)
	local f25_local0 = tonumber(UIExpression.GetStatByName(f25_arg0, "RANK"))
	local f25_local1 = tonumber(CoD.MAX_RANK)
	local f25_local2 = tonumber(UIExpression.GetStatByName(f25_arg0, "PLEVEL"))
	local f25_local3 = tonumber(CoD.MAX_PRESTIGE)
	local f25_local4
	if not (f25_local0 < f25_local1 or f25_local2 < f25_local3) or f25_local3 <= f25_local2 then
		f25_local4 = false
	else
		f25_local4 = true
	end
	return f25_local4
end

CoD.SetupButtonLock = function (f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4)
	local f26_local0 = UIExpression.GetItemIndex(f26_arg1, f26_arg2)
	local f26_local1 = false
	if f26_arg1 == nil then
		if UIExpression.IsItemLockedForAll(f26_arg1, f26_local0) == 1 then
			f26_local1 = true
		end
	elseif UIExpression.IsItemLocked(f26_arg1, f26_local0) == 1 then
		f26_local1 = true
	end
	if f26_local1 == true then
		f26_arg0:lock()
		f26_arg0.hintText = CoD.GetUnlockLevelString(f26_arg1, f26_arg2)
	else
		f26_arg0.hintText = Engine.Localize(f26_arg3)
		f26_arg0:registerEventHandler("button_action", f26_arg4)
	end
	f26_arg0.itemName = f26_arg2
end

CoD.CheckButtonLock = function (f27_arg0, f27_arg1)
	if f27_arg0.itemName == nil then
		return false
	end
	local f27_local0 = UIExpression.GetItemIndex(f27_arg1, f27_arg0.itemName)
	local f27_local1 = false
	if f27_arg1 == nil then
		if UIExpression.IsItemLockedForAll(f27_arg1, f27_local0) == 1 then
			f27_local1 = true
		end
	elseif UIExpression.IsItemLocked(f27_arg1, f27_local0) == 1 then
		f27_local1 = true
	end
	return f27_local1
end

CoD.canInviteToGame = function (f28_arg0, f28_arg1)
	if false then
		return false
	end
	local f28_local0 = UIExpression.IsPlayerInvitable(f28_arg0, f28_arg1) == 1
	local f28_local1 = UIExpression.InLobby(f28_arg0) == 1
	local f28_local2 = UIExpression.InPrivateParty(f28_arg0) == 1
	local f28_local3 = Engine.GetMaxUserPlayerCount(f28_arg0)
	local f28_local4 = Engine.PartyGetPlayerCount()
	local f28_local5
	if f28_local0 == 0 then
		f28_local5 = f28_local0
	elseif not f28_local1 and f28_local2 == 0 then
		f28_local5 = f28_local2
	else
		f28_local5 = f28_local4 < f28_local3
	end
	return f28_local5
end

CoD.canJoinSession = function (f29_arg0, f29_arg1)
	if false then
		return false
	elseif Engine.IsMemberInParty(f29_arg0, f29_arg1) then
		return false
	else
		return UIExpression.IsPlayerJoinable(f29_arg0, f29_arg1) == CoD.FRIEND_JOINABLE
	end
end

CoD.isInTitle = function (f30_arg0, f30_arg1)
	return UIExpression.IsPlayerInTitle(f30_arg0, f30_arg1) == 1
end

CoD.canAutoJoinSession = function (f31_arg0, f31_arg1)
	return UIExpression.IsPlayerJoinable(f31_arg0, f31_arg1) == CoD.FRIEND_AUTOJOINABLE
end

CoD.canMutePlayer = function (f32_arg0, f32_arg1)
	local f32_local0 = UIExpression.GetXUID(f32_arg0) == f32_arg1
	local f32_local1 = Engine.IsPlayerInCurrentSession(f32_arg0, f32_arg1)
	f32_local1 = f32_local1.inCurrentSession
	if f32_local0 then
		return false
	elseif not f32_local1 then
		return false
	else
		return true
	end
end

CoD.isPlayerMuted = function (f33_arg0, f33_arg1)
	return UIExpression.GetMutedStatus(f33_arg0, f33_arg1) == 1
end

CoD.canSendFriendRequest = function (f34_arg0, f34_arg1)
	if CoD.isPC then
		return false
	elseif Engine.IsGuestByXuid(f34_arg1) == true then
		return false
	else
		local f34_local0
		if UIExpression.GetXUID(f34_arg0) == f34_arg1 or UIExpression.IsFriendFromXUID(f34_arg0, f34_arg1) ~= 0 then
			f34_local0 = false
		else
			f34_local0 = true
		end
	end
	return f34_local0
end

CoD.isPlayerInLobby = function (f35_arg0)
	local f35_local0 = {}
	for f35_local4, f35_local5 in pairs(Engine.GetPlayersInLobby()) do
		if f35_local5.xuid == f35_arg0 then
			return true
		end
	end
	return false
end

CoD.canKickPlayer = function (f36_arg0, f36_arg1)
	if Engine.IsGuestByXuid(f36_arg1) == true then
		return false
	elseif UIExpression.GetXUID(f36_arg0) == f36_arg1 then
		return false
	end
	local f36_local0 = UIExpression.InLobby(f36_arg0) == 1
	local f36_local1 = UIExpression.GameHost(f36_arg0) == 1
	local f36_local2 = UIExpression.IsInGame() == 1
	local f36_local3
	if Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) ~= true and Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) ~= true then
		f36_local3 = false
	else
		f36_local3 = true
	end
	local f36_local4 = UIExpression.PrivatePartyHost() == 1
	local f36_local5 = Engine.IsMemberInParty(f36_arg0, f36_arg1) == true
	local f36_local6 = CoD.isPlayerInLobby(f36_arg1)
	if f36_local2 then
		return false
	elseif not f36_local6 then
		return false
	elseif f36_local0 and not f36_local3 then
		return false
	elseif f36_local0 and f36_local1 and f36_local3 then
		return true
	elseif not f36_local4 then
		return false
	elseif not f36_local5 then
		return false
	end
	return true
end

CoD.invitePlayer = function (f37_arg0, f37_arg1, f37_arg2)
	if CoD.canInviteToGame(f37_arg0, f37_arg1) then
		if CoD.isXBOX then
			Engine.Exec(f37_arg0, "xsendinvite " .. f37_arg1)
		elseif CoD.isPS3 or CoD.isWIIU or CoD.isPC then
			if f37_arg2 == CoD.playerListType.friend then
				Engine.Exec(f37_arg0, "sendInvite " .. f37_arg1 .. " 0")
			else
				Engine.Exec(f37_arg0, "sendInvite " .. f37_arg1 .. " 1")
			end
		end
	else
		DebugPrint("^1LUI: ^2cannot send invite.")
	end
end

CoD.joinPlayer = function (f38_arg0, f38_arg1)
	if CoD.canJoinSession(f38_arg0, f38_arg1) then
		Engine.Exec(f38_arg0, "joinplayersessionbyxuid " .. f38_arg1)
	end
end

CoD.sendFriendRequest = function (f39_arg0, f39_arg1)
	if CoD.canSendFriendRequest(f39_arg0, f39_arg1) then
		if CoD.isXBOX then
			Engine.Exec(f39_arg0, "xaddfriend " .. f39_arg1)
		elseif CoD.isPS3 or CoD.isWIIU then
			Engine.Exec(f39_arg0, "xaddfriend " .. f39_arg1)
		end
	end
end

CoD.inviteAccepted = function (f40_arg0, f40_arg1)
	Engine.Exec(f40_arg1.controller, "disableallclients")
	Engine.Exec(f40_arg1.controller, "setclientbeingusedandprimary")
	Engine.ExecNow(f40_arg1.controller, "initiatedemonwareconnect")
	local f40_local0 = f40_arg0:openPopup("popup_connectingdw", f40_arg1.controller)
	f40_local0.inviteAccepted = true
	f40_local0.callingMenu = f40_arg0
end

CoD.viewGamerCard = function (f41_arg0, f41_arg1, f41_arg2, f41_arg3)
	if CoD.isXBOX or CoD.isPC then
		Engine.Exec(f41_arg0, "xshowgamercard " .. f41_arg2)
	elseif CoD.isPS3 then
		if f41_arg3 == CoD.playerListType.friend then
			Engine.Exec(f41_arg0, "xshowgamercard " .. f41_arg2)
		elseif f41_arg3 == CoD.playerListType.recentPlayer then
			Engine.Exec(f41_arg0, "xshowrecentplayersgamercard " .. f41_arg2)
		else
			Engine.Exec(f41_arg0, "xshowgamercardbyname " .. f41_arg1)
		end
	end
end

CoD.acceptGameInvite = function (f42_arg0, f42_arg1)
	if CoD.isWIIU or CoD.isPC then
		Engine.Exec(f42_arg0, "acceptgameinvite " .. f42_arg1)
	end
end

CoD.acceptFriendRequest = function (f43_arg0, f43_arg1, f43_arg2)
	if CoD.isWIIU then
		Engine.Exec(f43_arg0, "acceptfriendrequest " .. f43_arg1 .. " " .. f43_arg2)
	end
end

CoD.slotContainerAlpha = 0.04
CoD.nullSpecialtyName = "PERKS_NONE"
CoD.AddClassItemData = function (f44_arg0, f44_arg1, f44_arg2, f44_arg3)
	if f44_arg1 ~= nil and f44_arg1 > 0 then
		local f44_local0 = UIExpression.GetItemAllocationCost(nil, f44_arg1)
		if f44_local0 >= 0 then
			local f44_local1 = {
				name = UIExpression.GetItemName(nil, f44_arg1),
				description = UIExpression.GetItemDesc(nil, f44_arg1)
			}
			local f44_local2 = UIExpression.GetItemImage(nil, f44_arg1)
			if CoD.IsWeapon(f44_arg1) then
				f44_local2 = f44_local2 .. "_big"
			end
			f44_local1.material = RegisterMaterial(f44_local2)
			f44_local1.ref = UIExpression.GetItemRef(nil, f44_arg1)
			f44_local1.cost = f44_local0
			f44_local1.momentumCost = UIExpression.GetItemMomentumCost(nil, f44_arg1)
			f44_local1.itemIndex = f44_arg1
			f44_local1.count = f44_arg2
			f44_local1.loadoutSlot = f44_arg3
			table.insert(f44_arg0, f44_local1)
		end
	end
end

CoD.AddClassAttachmentData = function (f45_arg0, f45_arg1, f45_arg2)
	if f45_arg1 ~= nil and f45_arg1 > 0 and f45_arg2 ~= nil and f45_arg2 > 0 then
		local f45_local0 = Engine.GetAttachmentAllocationCost(f45_arg1, f45_arg2)
		if f45_local0 >= 0 then
			table.insert(f45_arg0, {
				name = Engine.GetAttachmentName(f45_arg1, f45_arg2),
				description = Engine.GetAttachmentDesc(f45_arg1, f45_arg2),
				material = RegisterMaterial(Engine.GetAttachmentImage(f45_arg1, f45_arg2)),
				cost = f45_local0,
				weaponIndex = f45_arg1,
				attachmentIndex = f45_arg2,
				count = 1
			})
		end
	end
end

CoD.GetMaxQuantity = function (f46_arg0)
	if CoD.IsWeapon(f46_arg0) == true then
		return 1
	else
		return Engine.GetMaxAmmoForItem(f46_arg0)
	end
end

CoD.GetAttachments = function (f47_arg0)
	local f47_local0 = Engine.GetNumAttachments(f47_arg0)
	if f47_local0 == nil then
		return nil
	end
	local f47_local1 = {}
	for f47_local2 = 1, f47_local0 - 1, 1 do
		table.insert(f47_local1, {
			weaponItemIndex = f47_arg0,
			attachmentIndex = f47_local2
		})
	end
	return f47_local1
end

CoD.GetLoadoutSlotForAttachment = function (f48_arg0, f48_arg1, f48_arg2)
	local f48_local0 = Engine.GetAttachmentAttachPoint(f48_arg1, f48_arg2)
	if f48_local0 ~= nil then
		return f48_arg0 .. "attachment" .. f48_local0
	else

	end
end

CoD.GetClassItem = function (f49_arg0, f49_arg1, f49_arg2)
	return Engine.GetClassItem(f49_arg0, f49_arg1, f49_arg2)
end

CoD.SetClassItem = function ( controller, classNum, slotName, itemIndex, itemCount )
    Engine.SetClassItem( controller, classNum, slotName, itemIndex )
    if itemCount ~= nil then
        Engine.SetClassItem( controller, classNum, slotName .. "count", itemCount )
    end
end

CoD.RemoveItemFromClass = function (f51_arg0, f51_arg1, f51_arg2)
	for f51_local3, f51_local4 in pairs(CoD.CACUtility.loadoutSlotNames) do
		if f51_arg2 == CoD.GetClassItem(f51_arg0, f51_arg1, f51_local4) then
			CoD.SetClassItem(f51_arg0, f51_arg1, f51_local4, 0)
		end
	end
end

CoD.HowManyInClassSlot = function (f52_arg0, f52_arg1)
	for f52_local3, f52_local4 in pairs(f52_arg1) do
		if f52_local4.itemIndex == f52_arg0 then
			if f52_local4.count == nil then
				return 1
			end
			return f52_local4.count
		end
	end
	return 0
end

CoD.IsWeapon = function (f53_arg0)
	local f53_local0 = Engine.GetLoadoutSlotForItem(f53_arg0)
	local f53_local1 = CoD.CACUtility.loadoutSlotNames
	if f53_local0 and (f53_local0 == f53_local1.primaryWeapon or f53_local0 == f53_local1.secondaryWeapon) then
		return true
	else
		return false
	end
end

CoD.IsPrimaryWeapon = function (f54_arg0)
	local f54_local0 = Engine.GetLoadoutSlotForItem(f54_arg0)
	if f54_local0 and f54_local0 == CoD.CACUtility.loadoutSlotNames.primaryWeapon then
		return true
	else
		return false
	end
end

CoD.IsSecondaryWeapon = function (f55_arg0)
	local f55_local0 = Engine.GetLoadoutSlotForItem(f55_arg0)
	if f55_local0 and f55_local0 == CoD.CACUtility.loadoutSlotNames.secondaryWeapon then
		return true
	else
		return false
	end
end

CoD.IsPerk = function (f56_arg0)
	local f56_local0 = Engine.GetLoadoutSlotForItem(f56_arg0)
	if f56_local0 and string.find(f56_local0, "specialty") == 1 then
		return true
	else
		return false
	end
end

CoD.IsReward = function (f57_arg0)
	local f57_local0 = Engine.GetLoadoutSlotForItem(f57_arg0)
	if f57_local0 and string.find(f57_local0, "killstreak") == 1 then
		return true
	else
		return false
	end
end

CoD.IsGrenade = function (f58_arg0)
	local f58_local0 = Engine.GetLoadoutSlotForItem(f58_arg0)
	local f58_local1 = CoD.CACUtility.loadoutSlotNames
	if f58_local0 and (f58_local0 == f58_local1.primaryGrenade or f58_local0 == f58_local1.specialGrenade) then
		return true
	else
		return false
	end
end

CoD.IsLethalGrenade = function (f59_arg0)
	local f59_local0 = Engine.GetLoadoutSlotForItem(f59_arg0)
	if f59_local0 and f59_local0 == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
		return true
	else
		return false
	end
end

CoD.IsTacticalGrenade = function (f60_arg0)
	local f60_local0 = Engine.GetLoadoutSlotForItem(f60_arg0)
	if f60_local0 and f60_local0 == CoD.CACUtility.loadoutSlotNames.specialGrenade then
		return true
	else
		return false
	end
end

CoD.IsWeaponAttachment = function (f61_arg0, f61_arg1)
	if Engine.GetAttachmentAttachPoint(f61_arg1, f61_arg0) ~= nil then
		return true
	else
		return false
	end
end

CoD.IsBonusCard = function (f62_arg0)
	local f62_local0 = UIExpression.GetItemGroup(nil, f62_arg0)
	if f62_local0 and string.find(f62_local0, "bonuscard") == 1 then
		return true
	else
		return false
	end
end

CoD.GetItemMaterialNameWidthAndHeight = function (f63_arg0, f63_arg1)
	local f63_local0 = UIExpression.GetItemImage(nil, f63_arg0)
	local f63_local1 = 128
	local f63_local2 = 128
	if CoD.IsWeapon(f63_arg0) then
		f63_local1 = f63_local2 * 2
		if f63_arg1 == true then
			f63_local0 = f63_local0 .. "_big"
		end
	elseif CoD.IsBonusCard(f63_arg0) then
		f63_local1 = f63_local2 * 2
	elseif CoD.IsReward(f63_arg0) then
		if f63_arg1 == true then
			f63_local0 = f63_local0 .. "_menu"
		end
	elseif f63_arg1 == true then
		f63_local0 = f63_local0 .. "_256"
	end
	return f63_local0, f63_local1, f63_local2
end

CoD.IsWeaponSlotEquippedAndModifiable = function (f64_arg0, f64_arg1, f64_arg2)
	local f64_local0 = CoD.GetClassItem(f64_arg0, f64_arg1, f64_arg2)
	if f64_local0 ~= nil and f64_local0 > 0 then
		local f64_local1 = CoD.GetAttachments(f64_local0)
		if f64_local1 == nil or #f64_local1 == 0 then
			return false
		else
			return true
		end
	else
		return false
	end
end

CoD.SumClassItemCosts = function (f65_arg0)
	local f65_local0 = 0
	for f65_local5, f65_local6 in pairs(f65_arg0) do
		local f65_local4 = 1
		if f65_local6.count ~= nil then
			f65_local4 = f65_local6.count
		end
		f65_local0 = f65_local0 + f65_local6.cost * f65_local4
	end
	return f65_local0
end

CoD.PopulateClassLabels = function (f66_arg0, f66_arg1)
	if f66_arg0 ~= nil and f66_arg1 ~= nil then
		for f66_local3, f66_local4 in pairs(f66_arg1) do
			f66_local4:setText("")
		end
		for f66_local3, f66_local4 in pairs(f66_arg0) do
			local f66_local5 = f66_arg1[f66_local3]
			if f66_local5 ~= nil then
				f66_local5:setText(UIExpression.ToUpper(nil, Engine.Localize(f66_local4.name)))
			end
		end
	end
end

CoD.PopulateClassImages = function (f67_arg0, f67_arg1)
	if f67_arg0 ~= nil and f67_arg1 ~= nil then
		for f67_local3, f67_local4 in pairs(f67_arg1) do
			f67_local4:beginAnimation("material_change")
			f67_local4:setImage(nil)
			f67_local4:setAlpha(0)
		end
		for f67_local3, f67_local4 in pairs(f67_arg0) do
			local f67_local5 = f67_arg1[f67_local3]
			if f67_local5 ~= nil then
				f67_local5:beginAnimation("material_change")
				f67_local5:setImage(f67_local4.material)
				f67_local5:setAlpha(1)
			end
		end
	end
end

CoD.PopulateClassBGImages = function (f68_arg0, f68_arg1, f68_arg2, f68_arg3, f68_arg4, f68_arg5)
	if f68_arg5 == nil then
		f68_arg5 = 0
	end
	if f68_arg5 > CoD.CACUtility.maxAttachments then
		f68_arg5 = CoD.CACUtility.maxAttachments
	end
	if f68_arg0.itemLabelTabs[f68_arg2] ~= nil then
		f68_arg0.itemLabelTabs[f68_arg2]:beginAnimation("material_change")
		f68_arg0.itemLabelTabs[f68_arg2]:setAlpha(0)
		if f68_arg1[1] ~= nil then
			f68_arg0.itemLabelTabs[f68_arg2]:beginAnimation("material_change")
			f68_arg0.itemLabelTabs[f68_arg2]:setAlpha(0.2)
		end
	end
	if f68_arg4 ~= nil then
		for f68_local3, f68_local4 in pairs(f68_arg4) do
			f68_local4:beginAnimation("material_change")
			f68_local4:setAlpha(0)
		end
		for f68_local0 = 1, f68_arg5, 1 do
			f68_local4 = f68_arg4[f68_local0]
			if f68_local4 ~= nil then
				f68_local4:beginAnimation("material_change")
				f68_local4:setAlpha(0.05)
			end
		end
	end
	if f68_arg0.verticalLines[f68_arg2] ~= nil and f68_arg0.horizontalLines[f68_arg2] ~= nil then
		local f68_local0 = 0
		if f68_arg3 ~= nil then
			f68_local0 = #f68_arg3
		end
		f68_arg0.verticalLines[f68_arg2]:animateToState("attachment_state_" .. f68_local0, 200)
		f68_arg0.horizontalLines[f68_arg2]:animateToState("attachment_state_" .. f68_arg5)
	end
end

CoD.PopulateCamoImage = function (f69_arg0, f69_arg1, f69_arg2, f69_arg3)
	if f69_arg3 == nil then
		f69_arg3 = 0
	end
	if f69_arg3 > CoD.CACUtility.maxAttachments then
		f69_arg3 = CoD.CACUtility.maxAttachments
	end
	if f69_arg0.camoImageContainers[f69_arg2] ~= nil then
		f69_arg0.camoImageContainers[f69_arg2]:animateToState("attachment_state_" .. f69_arg3)
	end
end

CoD.PopulateGrenadeLabel = function (f70_arg0, f70_arg1)
	local f70_local0 = {}
	local f70_local1 = nil
	if f70_arg1 ~= nil then
		f70_arg1:setText("")
		if f70_arg0 ~= nil and f70_arg1 ~= nil then
			for f70_local5, f70_local6 in pairs(f70_arg0) do
				if f70_local6.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
					f70_local0[1] = UIExpression.ToUpper(nil, Engine.Localize(f70_local6.name))
				end
				if f70_local6.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
					f70_local0[2] = UIExpression.ToUpper(nil, Engine.Localize(f70_local6.name))
				end
			end
		end
		if f70_local0[1] ~= nil then
			f70_local1 = f70_local0[1]
		end
		if f70_local0[2] ~= nil then
			if f70_local1 ~= nil then
				f70_local1 = f70_local1 .. " & " .. f70_local0[2]
			else
				f70_local1 = f70_local0[2]
			end
		end
		if f70_local1 ~= nil then
			f70_arg1:setText(f70_local1)
		end
	end
end

CoD.PopulateGrenadeImages = function (f71_arg0, f71_arg1, f71_arg2)
	if f71_arg0 ~= nil and f71_arg1 ~= nil then
		for f71_local3, f71_local4 in pairs(f71_arg1) do
			f71_local4:beginAnimation("material_change")
			f71_local4:setImage(nil)
			f71_local4:setAlpha(0)
		end
		for f71_local3, f71_local4 in pairs(f71_arg0) do
			local f71_local5 = nil
			if f71_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
				f71_local5 = f71_arg1[1]
			elseif f71_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
				f71_local5 = f71_arg1[2]
			end
			if f71_local5 ~= nil then
				f71_local5:beginAnimation("material_change")
				f71_local5:setImage(f71_local4.material)
				f71_local5:setAlpha(1)
			end
		end
		if f71_arg2 ~= nil then
			for f71_local3, f71_local4 in pairs(f71_arg2) do
				f71_local4:beginAnimation("material_change")
				f71_local4:setAlpha(0)
			end
			for f71_local3, f71_local4 in pairs(f71_arg0) do
				local f71_local5 = nil
				if f71_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
					f71_local5 = f71_arg2[1]
				elseif f71_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
					f71_local5 = f71_arg2[2]
				end
				if f71_local5 ~= nil then
					f71_local5:beginAnimation("material_change")
					f71_local5:setAlpha(0.05)
				end
			end
		end
	end
end

CoD.PopulateClassCountLabels = function (f72_arg0, f72_arg1)
	if f72_arg0 ~= nil and f72_arg1 ~= nil then
		for f72_local3, f72_local4 in pairs(f72_arg1) do
			f72_local4:setText("")
		end
		for f72_local3, f72_local4 in pairs(f72_arg0) do
			local f72_local5 = f72_arg1[f72_local3]
			if f72_local5 ~= nil and f72_local4.count ~= nil and f72_local4.count > 1 then
				f72_local5:setText(Engine.Localize("MENU_MULTIPLIER_X", f72_local4.count))
			end
		end
	end
end

CoD.PopulateGrenadeCountLabels = function (f73_arg0, f73_arg1)
	if f73_arg0 ~= nil and f73_arg1 ~= nil then
		for f73_local3, f73_local4 in pairs(f73_arg1) do
			f73_local4:setText("")
		end
		for f73_local3, f73_local4 in pairs(f73_arg0) do
			local f73_local5 = nil
			if f73_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
				f73_local5 = f73_arg1[1]
			elseif f73_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
				f73_local5 = f73_arg1[2]
			end
			if f73_local5 ~= nil and f73_local4.count ~= nil and f73_local4.count > 1 then
				f73_local5:setText(Engine.Localize("MENU_MULTIPLIER_X", f73_local4.count))
			end
		end
	end
end

CoD.PopulateWeaponInfo = function (f74_arg0, f74_arg1, f74_arg2)
	local f74_local0 = f74_arg0[1]
	if f74_local0 ~= nil then
		if f74_arg1 ~= nil then
			f74_arg1:setText(UIExpression.ToUpper(nil, Engine.Localize(f74_local0.name)))
		end
		if f74_arg2 ~= nil then
			f74_arg2:beginAnimation("material_change", 500)
			f74_arg2:setImage(f74_local0.material)
			f74_arg2:setAlpha(1)
		end
	else
		if f74_arg1 ~= nil then
			f74_arg1:setText("")
		end
		if f74_arg2 ~= nil then
			f74_arg2:beginAnimation("material_change", 500)
			f74_arg2:setImage(nil)
			f74_arg2:setAlpha(0)
		end
	end
end

CoD.PopulateWeaponAttachmentInfo = function (f75_arg0, f75_arg1)
	if f75_arg0 ~= nil and f75_arg1 ~= nil then
		for f75_local3, f75_local4 in pairs(f75_arg1) do
			f75_local4:setText("")
		end
		for f75_local3, f75_local4 in pairs(f75_arg0) do
			local f75_local5 = f75_arg1[f75_local3]
			if f75_local5 ~= nil then
				f75_local5:setText(UIExpression.ToUpper(nil, Engine.Localize(f75_local4.name)))
			end
		end
	end
end

CoD.PopulatePerksInfo = function (f76_arg0, f76_arg1)
	if f76_arg0 ~= nil and f76_arg1 ~= nil then
		for f76_local3, f76_local4 in pairs(f76_arg1) do
			f76_local4:setText("")
		end
		for f76_local3, f76_local4 in pairs(f76_arg0) do
			local f76_local5 = f76_arg1[f76_local3]
		end
	end
end

CoD.CACItemComparisonFunction = function (f77_arg0, f77_arg1)
	return UIExpression.GetItemAllocationCost(nil, f77_arg0) < UIExpression.GetItemAllocationCost(nil, f77_arg1)
end

CoD.CACAttachmentComparisonFunction = function (f78_arg0, f78_arg1)
	return Engine.GetAttachmentAllocationCost(f78_arg0.weaponItemIndex, f78_arg0.attachmentIndex) < Engine.GetAttachmentAllocationCost(f78_arg1.weaponItemIndex, f78_arg1.attachmentIndex)
end

CoD.CACRewardComparisonFunction = function (f79_arg0, f79_arg1)
	local f79_local0 = UIExpression.GetItemAllocationCost(nil, f79_arg0)
	local f79_local1 = UIExpression.GetItemAllocationCost(nil, f79_arg1)
	if f79_local0 == f79_local1 then
		return UIExpression.GetItemMomentumCost(nil, f79_arg0) < UIExpression.GetItemMomentumCost(nil, f79_arg1)
	else
		return f79_local0 < f79_local1
	end
end

CoD.CACGetWeaponAvailableAttachments = function (f80_arg0, f80_arg1)
	local f80_local0 = 0
	if f80_arg0[1] ~= nil then
		f80_local0 = UIExpression.GetNumItemAttachmentsWithAttachPoint(f80_arg1, f80_arg0[1].itemIndex, 0) - 1
	end
	return f80_local0
end

CoD.UsingAltColorScheme = function (f81_arg0)
	if UIExpression.ProfileInt(f81_arg0, "colorblind_assist") ~= 0 then
		return true
	else
		return false
	end
end

CoD.GetFactionColor = function (f82_arg0, f82_arg1)
	return CoD.factionColor[f82_arg0][f82_arg1]
end

CoD.GetFaction = function ()
	return "seals"
end

CoD.GetTeamColor = function (f84_arg0, f84_arg1)
	if CoD.isMultiplayer == true then
		if f84_arg0 == CoD.TEAM_SPECTATOR then
			return CoD.teamColor[f84_arg0]
		end
		local f84_local0, f84_local1, f84_local2 = Engine.GetFactionColor(Engine.GetFactionForTeam(f84_arg0))
		if f84_local0 == nil or f84_local1 == nil or f84_local2 == nil then
			local f84_local3, f84_local4, f84_local5 = Engine.GetFactionColor(Engine.GetFactionForTeam(CoD.TEAM_FREE))
			f84_local2 = f84_local5
			f84_local1 = f84_local4
			f84_local0 = f84_local3
		end
		return {
			r = f84_local0,
			g = f84_local1,
			b = f84_local2
		}
	elseif f84_arg0 == CoD.TEAM_ALLIES or f84_arg0 == CoD.TEAM_AXIS then
		return CoD.GetFactionColor(f84_arg1, f84_arg0)
	else
		return CoD.teamColor[f84_arg0]
	end
end

CoD.GetTeamName = function (f85_arg0)
	if CoD.isMultiplayer == true then
		if f85_arg0 == CoD.TEAM_SPECTATOR then
			return CoD.teamName[CoD.TEAM_SPECTATOR]
		elseif f85_arg0 == CoD.TEAM_FREE then
			return CoD.teamName[CoD.TEAM_FREE]
		elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			if f85_arg0 == CoD.TEAM_ALLIES and Dvar.g_customTeamName_Allies:get() ~= "" then
				return Dvar.g_customTeamName_Allies:get()
			elseif f85_arg0 == CoD.TEAM_AXIS and Dvar.g_customTeamName_Axis:get() ~= "" then
				return Dvar.g_customTeamName_Axis:get()
			end
		end
		return Engine.GetFactionForTeam(f85_arg0)
	elseif f85_arg0 == CoD.TEAM_ALLIES then
		return Engine.Localize(Dvar.g_TeamName_Allies:get())
	elseif f85_arg0 == CoD.TEAM_AXIS then
		return Engine.Localize(Dvar.g_TeamName_Axis:get())
	elseif f85_arg0 == CoD.TEAM_THREE then
		if CoD.isZombie == true then
			return Engine.Localize(Dvar.g_TeamName_Three:get())
		else
			return CoD.teamName[CoD.TEAM_THREE]
		end
	elseif f85_arg0 == CoD.TEAM_SPECTATOR then
		return CoD.teamName[CoD.TEAM_SPECTATOR]
	else
		return CoD.teamName[f85_arg0]
	end
end

CoD.GetTeamNameCaps = function (f86_arg0)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		if f86_arg0 == CoD.TEAM_ALLIES and Dvar.g_customTeamName_Allies:get() ~= "" then
			return UIExpression.ToUpper(nil, Dvar.g_customTeamName_Allies:get())
		elseif f86_arg0 == CoD.TEAM_AXIS and Dvar.g_customTeamName_Axis:get() ~= "" then
			return UIExpression.ToUpper(nil, Dvar.g_customTeamName_Axis:get())
		end
	end
	local f86_local0 = "MPUI_" .. CoD.GetTeamName(f86_arg0) .. "_SHORT_CAPS"
	if f86_arg0 == CoD.TEAM_SPECTATOR then
		f86_local0 = "MPUI_SHOUTCASTER_SHORT_CAPS"
	end
	return Engine.Localize(f86_local0)
end

CoD.IsSpectatingAllowed = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
		return false
	elseif Engine.GetGametypeSetting("allowSpectating") == 1 then
		return true
	else
		return false
	end
end

CoD.IsTeamChangeAllowed = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
		return false
	elseif Engine.GetGametypeSetting("allowInGameTeamChange") == 1 then
		return true
	else
		return false
	end
end

CoD.IsGametypeTeamBased = function ()
	local f89_local0 = Dvar.ui_gametype:get()
	if f89_local0 == CoD.lastGametype then
		return CoD.gametypeTeamBased
	else
		local f89_local1 = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f89_local0, 8)
		CoD.lastGametype = f89_local0
		if UIExpression.ToUpper(nil, f89_local1) == "NO" then
			CoD.gametypeTeamBased = false
			return false
		else
			CoD.gametypeTeamBased = true
			return true
		end
	end
end

CoD.GetAnimationStateForUserSafeArea = function (f90_arg0)
	local f90_local0, f90_local1 = Engine.GetUserSafeArea()
	return {
		leftAnchor = false,
		rightAnchor = false,
		left = -f90_local0 / 2,
		right = f90_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f90_local1 / 2,
		bottom = f90_local1 / 2
	}
end

CoD.GetDefaultAnimationState = function ()
	return {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}
end

CoD.AddDebugBackground = function (f92_arg0, f92_arg1)
	local f92_local0 = 1
	local f92_local1 = 1
	local f92_local2 = 1
	local f92_local3 = 0.25
	if f92_arg1 ~= nil then
		f92_local0 = f92_arg1.r
		f92_local1 = f92_arg1.g
		f92_local2 = f92_arg1.b
		f92_local3 = f92_arg1.a
	end
	f92_arg0:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		red = f92_local0,
		green = f92_local1,
		blue = f92_local2,
		alpha = f92_local3
	}))
end

CoD.SetPreviousAllocation = function (f93_arg0)
	local f93_local0 = Engine.GetCustomClass(f93_arg0, CoD.perController[f93_arg0].classNum)
	CoD.previousAllocationAmount = f93_local0.allocationSpent
end

CoD.SetupBarracksLock = function (f94_arg0)
	f94_arg0.hintText = Engine.Localize(CoD.MPZM("MPUI_BARRACKS_DESC", "ZMUI_LEADERBOARDS_DESC"))
end

CoD.SetupBarracksNew = function (f95_arg0)
	f95_arg0:registerEventHandler("barracks_closed", CoD.SetupBarracksNew)
	f95_arg0:showNewIcon(Engine.IsAnyEmblemIconNew(UIExpression.GetPrimaryController()))
end

CoD.SetupMatchmakingLock = function (f96_arg0)
	f96_arg0.hintText = Engine.Localize(CoD.MPZM("MPUI_PLAYER_MATCH_DESC", "ZMUI_PLAYER_MATCH_DESC"))
end

CoD.SetupCustomGamesLock = function (f97_arg0)
	if Engine.IsBetaBuild() then
		f97_arg0:lock()
		f97_arg0.hintText = Engine.Localize("FEATURE_CUSTOM_GAMES_LOCKED")
	else
		f97_arg0.hintText = Engine.Localize(CoD.MPZM("MPUI_CUSTOM_MATCH_DESC", "ZMUI_CUSTOM_MATCH_DESC"))
	end
end

CoD.IsShoutcaster = function (f98_arg0)
	if Engine.IsShoutcaster(f98_arg0) or Engine.IsDemoShoutcaster() then
		return true
	else
		return false
	end
end

CoD.ExeProfileVarBool = function (f99_arg0, f99_arg1)
	local f99_local0 = Engine.GetPlayerExeGamerProfile(f99_arg0)
	if f99_local0[f99_arg1] ~= nil and f99_local0[f99_arg1]:get() == 1 then
		return true
	else
		return false
	end
end

CoD.IsInOvertime = function (f100_arg0)
	if CoD.BIT_OVERTIME and UIExpression.IsVisibilityBitSet(f100_arg0, CoD.BIT_OVERTIME) == 1 then
		return true
	else
		return false
	end
end

CoD.MPZM = function (f101_arg0, f101_arg1)
	if CoD.isZombie == true then
		return f101_arg1
	else
		return f101_arg0
	end
end

CoD.SPMPZM = function (f102_arg0, f102_arg1, f102_arg2)
	if CoD.isSinglePlayer == true then
		return f102_arg0
	elseif CoD.isZombie == true then
		return f102_arg2
	elseif CoD.isMultiplayer == true then
		return f102_arg1
	else
		return nil
	end
end

CoD.pairsByKeys = function (f103_arg0, f103_arg1)
	local f103_local0 = {}
	for f103_local4, f103_local5 in pairs(f103_arg0) do
		table.insert(f103_local0, f103_local4)
	end
	table.sort(f103_local0, f103_arg1)
	f103_local1 = 0
	return function ()
		UPVAL0 = f103_local1 + 1
		if f103_local0[f103_local1] == nil then
			return nil
		else
			return f103_local0[f103_local1], f103_arg0[f103_local0[f103_local1]]
		end
	end

end

CoD.UnlockablesComparisonFunction = function (f104_arg0, f104_arg1)
	local f104_local0 = Engine.GetItemSortKey(f104_arg0)
	local f104_local1 = Engine.GetItemSortKey(f104_arg1)
	if f104_local0 == f104_local1 then
		return f104_arg0 < f104_arg1
	else
		return f104_local0 < f104_local1
	end
end

CoD.GetUnlockablesByGroupName = function (f105_arg0)
	local f105_local0 = Engine.GetUnlockablesByGroupName(f105_arg0)
	table.sort(f105_local0, CoD.UnlockablesComparisonFunction)
	return f105_local0
end

CoD.GetUnlockablesBySlotName = function (f106_arg0)
	local f106_local0 = Engine.GetUnlockablesBySlotName(f106_arg0)
	table.sort(f106_local0, CoD.UnlockablesComparisonFunction)
	return f106_local0
end

CoD.ShouldShowWeaponLevel = function ()
	return not Engine.AreAllItemsFree()
end

CoD.GetCenteredImage = function (f108_arg0, f108_arg1, f108_arg2, f108_arg3)
	local f108_local0 = nil
	if f108_arg3 then
		f108_local0 = LUI.UIStreamedImage.new(nil, nil, true)
	else
		f108_local0 = LUI.UIImage.new()
	end
	f108_local0:setLeftRight(false, false, -f108_arg0 / 2, f108_arg0 / 2)
	f108_local0:setTopBottom(false, false, -f108_arg1 / 2, f108_arg1 / 2)
	if f108_arg2 then
		f108_local0:setImage(RegisterMaterial(f108_arg2))
	end
	return f108_local0
end

CoD.GetStretchedImage = function (f109_arg0, f109_arg1)
	local f109_local0 = nil
	if f109_arg1 then
		f109_local0 = LUI.UIStreamedImage.new(nil, nil, true)
	else
		f109_local0 = LUI.UIImage.new()
	end
	f109_local0:setLeftRight(true, true, 0, 0)
	f109_local0:setTopBottom(true, true, 0, 0)
	if f109_arg0 then
		f109_local0:setImage(RegisterMaterial(f109_arg0))
	end
	return f109_local0
end

CoD.GetTextElem = function (f110_arg0, f110_arg1, f110_arg2, f110_arg3, f110_arg4)
	local f110_local0 = "Default"
	local f110_local1 = LUI.Alignment.Center
	local f110_local2 = 0
	if f110_arg1 then
		f110_local1 = LUI.Alignment[f110_arg1]
	end
	if f110_arg0 then
		f110_local0 = f110_arg0
	end
	if f110_arg4 then
		f110_local2 = f110_arg4
	end
	local f110_local3 = CoD.fonts[f110_local0]
	local f110_local4 = CoD.textSize[f110_local0]
	local f110_local5 = LUI.UIText.new()
	f110_local5:setLeftRight(true, true, 0, 0)
	f110_local5:setTopBottom(true, false, f110_local2, f110_local2 + f110_local4)
	f110_local5:setFont(f110_local3)
	f110_local5:setAlignment(f110_local1)
	if f110_arg2 then
		f110_local5:setText(f110_arg2)
	end
	if f110_arg3 then
		f110_local5:setRGB(f110_arg3.r, f110_arg3.g, f110_arg3.b)
	end
	return f110_local5
end

CoD.GetInformationContainer = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	
	local infoContainerBackground = LUI.UIImage.new()
	infoContainerBackground:setLeftRight(true, true, 1, -1)
	infoContainerBackground:setTopBottom(true, true, 1, -1)
	infoContainerBackground:setRGB(0, 0, 0)
	infoContainerBackground:setAlpha(0.4)
	Widget:addElement(infoContainerBackground)
	Widget.infoContainerBackground = infoContainerBackground
	
	local infoContainerBackgroundGrad = LUI.UIImage.new()
	infoContainerBackgroundGrad:setLeftRight(true, true, 3, -3)
	infoContainerBackgroundGrad:setTopBottom(true, true, 3, -3)
	infoContainerBackgroundGrad:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	infoContainerBackgroundGrad:setAlpha(0.1)
	Widget:addElement(infoContainerBackgroundGrad)
	Widget.infoContainerBackgroundGrad = infoContainerBackgroundGrad
	
	local imageContainer = LUI.UIElement.new()
	imageContainer:setLeftRight(true, true, 3, -3)
	imageContainer:setTopBottom(true, true, 3, -3)
	Widget:addElement(imageContainer)
	Widget.imageContainer = imageContainer
	
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
	return Widget
end

CoD.ModifyTextForReadability = function (f112_arg0)
	if f112_arg0 == nil then
		return f112_arg0
	elseif Dvar.loc_language:get() ~= CoD.LANGUAGE_JAPANESE and Dvar.loc_language:get() ~= CoD.LANGUAGE_FULLJAPANESE then
		f112_arg0 = string.gsub(string.gsub(f112_arg0, "0", "^BFONT_NUMBER_ZERO^"), "I", "^BFONT_CAPITAL_I^")
	end
	return f112_arg0
end

CoD.GetSpinnerWaitingOnEvent = function (f113_arg0, f113_arg1)
	local f113_local0 = 64
	if f113_arg1 then
		f113_local0 = f113_arg1
	end
	local f113_local1 = CoD.GetCenteredImage(f113_local0, f113_local0, "lui_loader")
	f113_local1:registerEventHandler(f113_arg0, function (f119_arg0, f119_arg1)
		f119_arg0:close()
	end)
	return f113_local1
end

CoD.GetZombieGameTypeName = function (f114_arg0, f114_arg1)
	if CoD.isZombie then
		local f114_local0 = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f114_arg0, 7)
		local f114_local1 = Engine.Localize(f114_local0)
		if f114_arg1 ~= nil then
			f114_local0 = f114_local0 .. "_" .. f114_arg1
			local f114_local2 = Engine.Localize(f114_local0)
			if string.match(f114_local2, f114_local0) == nil then
				f114_local1 = f114_local2
			end
		end
		return f114_local1
	else

	end
end

CoD.GetZombieGameTypeDescription = function (f115_arg0, f115_arg1)
	if CoD.isZombie then
		local f115_local0 = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f115_arg0, 2)
		local f115_local1 = Engine.Localize(f115_local0)
		if f115_arg1 ~= nil then
			f115_local0 = string.gsub(f115_local0, "_CAPS", "") .. "_" .. f115_arg1 .. "_CAPS"
			local f115_local2 = Engine.Localize(f115_local0)
			if string.match(f115_local2, f115_local0) == nil then
				f115_local1 = f115_local2
			end
		end
		return f115_local1
	else

	end
end

CoD.BaseN = function (f116_arg0, f116_arg1)
	local f116_local0 = math.floor(f116_arg0)
	if not f116_arg1 or f116_arg1 == 10 then
		return tostring(f116_local0)
	end
	local f116_local1 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local f116_local2 = {}
	local f116_local3 = ""
	if f116_local0 < 0 then
		f116_local3 = "-"
		f116_local0 = -f116_local0
		repeat
			local f116_local4 = f116_local0 % f116_arg1 + 1
			f116_local0 = math.floor(f116_local0 / f116_arg1)
			table.insert(f116_local2, 1, f116_local1:sub(f116_local4, f116_local4))
		until f116_local0 == 0
		return f116_local3 .. table.concat(f116_local2, "")
	end
	local f116_local4 = f116_local0 % f116_arg1 + 1
	f116_local0 = math.floor(f116_local0 / f116_arg1)
	table.insert(f116_local2, 1, f116_local1:sub(f116_local4, f116_local4))
end

CoD.usePCMatchmaking = function ()
	if CoD.isPC and not CoD.isZombie then
		local f117_local0 = Dvar.tu7_usePCmatchmaking:get()
		if f117_local0 then
			f117_local0 = Dvar.tu7_usePingSlider:get()
		end
		return f117_local0
	else
		return false
	end
end

require("T6.AccordionGroups")
require("T6.AdditiveTextOverlay")
require("T6.AllocationSubtitle")
require("T6.Border")
require("T6.BorderDip")
require("T6.ButtonGrid")
require("T6.BracketButton")
require("T6.CoDMenu")
require("T6.ContentGrid")
require("T6.ContentGridButton")
require("T6.CountdownTimer")
require("T6.CountupTimer")
require("T6.DvarLeftRightSelector")
require("T6.DvarLeftRightSlider")
require("T6.DistFieldText")
require("T6.EdgeShadow")
require("T6.GametypeSettingLeftRightSelector")
require("T6.GrowingGridButton")
require("T6.HintText")
require("T6.ImageNavButton")
require("T6.HorizontalCarousel")
require("T6.HUDShaker")
require("T6.LeftRightSelector")
require("T6.LeftRightSlider")
require("T6.MissionButton")
require("T6.NavButton")
require("T6.ProfileLeftRightSelector")
require("T6.ProfileLeftRightSlider")
require("T6.ScrollingVerticalList")
require("T6.SlotList")
require("T6.SlotListGridButton")
require("T6.SplitscreenScaler")
require("T6.TypewriterText")
require("T6.VerticalCarousel")
require("T6.VisorDataBoxes")
require("T6.VisorImage")
require("T6.VisorTimer")
require("T6.VisorLeftBracket")
require("T6.VisorRightBracket")
require("T6.WeaponAttributeList")
require("T6.NavOverlay")
require("T6.HUD.VisibilityBits")
require("T6.Menus.RefetchWADPopup")
require("T6.ErrorPopup")
require("T6.Popup")
if CoD.isWIIU then
	require("T6.Menus.WiiUControllerSelectorPopup")
	require("T6.Drc.DrcMakePrimaryPopup")
	if CoD.isMultiplayer then
		require("T6.Menus.WiiUControllerSelectorPopupMP")
		require("T6.Menus.SwitchControllersMenu")
		require("T6.Menus.SubloginMenu")
		require("T6.Menus.SubloginConnectPopup")
	end
end
if CoD.isMultiplayer == true and CoD.isZombie == false then
	require("T6.ClassPreview")
	require("T6.Menus.CACBonusCards")
	require("T6.AttachmentGridButton")
end
if CoD.isPC then
	require("T6.Mouse")
	require("T6.MouseButton")
	require("T6.MouseControlBar")
	require("T6.MouseDragListener")
	require("T6.Menus.PopupMenus")
	require("T6.Menus.KeyboardTextField")
end
