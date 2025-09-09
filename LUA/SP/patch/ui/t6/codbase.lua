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
	CoD.fonts.Italic = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/italicFont")
	CoD.fonts.SmallItalic = CoD.fonts.Italic
else
	CoD.fonts.Default = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/smallFont")
	CoD.fonts.Condensed = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/normalFont")
	CoD.fonts.Italic = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/italicFont")
	CoD.fonts.Big = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/bigFont")
	CoD.fonts.Morris = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/extraBigFont")
	CoD.fonts.ExtraSmall = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/extraSmallFont")
	CoD.fonts.SmallItalic = RegisterFont("fonts/" .. UIExpression.DvarInt(nil, "r_fontResolution") .. "/smallItalicFont")
end
CoD.fonts.Dist = RegisterFont("fonts/distFont")
LUI.DefaultFont = CoD.fonts.Default
CoD.textSize = {}
if CoD.LANGUAGE_RUSSIAN == Dvar.loc_language:get() then
	CoD.textSize.ExtraSmall = 20
	CoD.textSize.SmallItalic = 20
	CoD.textSize.Default = 21
	CoD.textSize.Italic = 21
	CoD.textSize.Condensed = 24
	CoD.textSize.Big = 36
	CoD.textSize.Morris = 42
elseif CoD.LANGUAGE_POLISH == Dvar.loc_language:get() then
	CoD.textSize.ExtraSmall = 16
	CoD.textSize.SmallItalic = 16
	CoD.textSize.Default = 19
	CoD.textSize.Italic = 21
	CoD.textSize.Condensed = 21
	CoD.textSize.Big = 32
	CoD.textSize.Morris = 42
elseif CoD.LANGUAGE_JAPANESE == Dvar.loc_language:get() or CoD.LANGUAGE_FULLJAPANESE == Dvar.loc_language:get() then
	CoD.textSize.ExtraSmall = 15
	CoD.textSize.SmallItalic = 15
	CoD.textSize.Default = 17
	CoD.textSize.Italic = 17
	CoD.textSize.Condensed = 22
	CoD.textSize.Big = 40
	CoD.textSize.Morris = 52
else
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
CoD.TEAM_INDICATOR_FULL = 0
CoD.TEAM_INDICATOR_ABBREVIATED = 1
CoD.TEAM_INDICATOR_ICON = 2
CoD.UI_SCREENSHOT_TYPE_SCREENSHOT = 0
CoD.UI_SCREENSHOT_TYPE_THUMBNAIL = 1
CoD.UI_SCREENSHOT_TYPE_MOTD = 2
CoD.UI_SCREENSHOT_TYPE_EMBLEM = 3
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

CoD.getClanTag = function (ClanTag)
	if ClanTag == nil then
		return ""
	elseif Engine.CanViewContent() == false then
		return ""
	else
		return ClanTag
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
	local IsRanked
	if CoD.isOnlineGame() == true then
		IsRanked = not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH)
	else
		IsRanked = false
	end
	return IsRanked
end

CoD.isHost = function ()
	return UIExpression.DvarBool(nil, "sv_running") == 1
end

CoD.canLeaveGame = function (LocalClientIndex)
	if CoD.isZombie == true then
		if CoD.InGameMenu.m_unpauseDisabled[LocalClientIndex + 1] ~= nil and CoD.InGameMenu.m_unpauseDisabled[LocalClientIndex + 1] > 0 then
			return false
		elseif CoD.isRankedGame() and CoD.isHost() and UIExpression.HostMigrationWaitingForPlayers(LocalClientIndex) ~= 0 and 1 ~= UIExpression.DvarInt(nil, "g_gameEnded") then
			return false
		end
	end
	local CanLeaveGame
	if UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_ROUND_END_KILLCAM) ~= 0 or UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_FINAL_KILLCAM) ~= 0 then
		CanLeaveGame = false
	else
		CanLeaveGame = true
	end
	return CanLeaveGame
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
	local IsPartyHost
	if UIExpression.PrivatePartyHost() ~= 1 and UIExpression.InPrivateParty() ~= 0 then
		IsPartyHost = false
	else
		IsPartyHost = true
	end
	return IsPartyHost
end

CoD.isXuidPrivatePartyHost = function (XUID)
	local IsPrivatePartyHost
	if UIExpression.InPrivateParty() ~= 1 or Engine.IsXuidPrivatePartyHost(XUID) ~= true then
		IsPrivatePartyHost = false
	else
		IsPrivatePartyHost = true
	end
	return IsPrivatePartyHost
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
	if tonumber(UIExpression.GetStatByName(f22_arg0, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) - 1 or tonumber(UIExpression.GetStatByName(f22_arg0, "RANK")) ~= tonumber(CoD.MAX_RANK) then
		f22_local0 = false
	else
		f22_local0 = true
	end
	return f22_local0
end

CoD.PrestigeFinish = function (f23_arg0)
	return tonumber(UIExpression.GetStatByName(f23_arg0, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) - 1
end

CoD.CanRankUp = function (f24_arg0)
	local f24_local0 = UIExpression.GetStatByName(f24_arg0, "RANK")
	local f24_local1 = UIExpression.GetStatByName(f24_arg0, "PLEVEL")
	local f24_local2
	if not (tonumber(f24_local0) < tonumber(CoD.MAX_RANK) or tonumber(f24_local1) < tonumber(CoD.MAX_PRESTIGE) - 1) or tonumber(f24_local1) >= tonumber(CoD.MAX_PRESTIGE) then
		f24_local2 = false
	else
		f24_local2 = true
	end
	return f24_local2
end

CoD.SetupButtonLock = function (f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4)
	local f25_local0 = UIExpression.GetItemIndex(f25_arg1, f25_arg2)
	local f25_local1 = false
	if f25_arg1 == nil then
		if UIExpression.IsItemLockedForAll(f25_arg1, f25_local0) == 1 then
			f25_local1 = true
		end
	elseif UIExpression.IsItemLocked(f25_arg1, f25_local0) == 1 then
		f25_local1 = true
	end
	if f25_local1 == true then
		f25_arg0:lock()
		f25_arg0.hintText = CoD.GetUnlockLevelString(f25_arg1, f25_arg2)
	else
		f25_arg0.hintText = Engine.Localize(f25_arg3)
		f25_arg0:registerEventHandler("button_action", f25_arg4)
	end
	f25_arg0.itemName = f25_arg2
end

CoD.CheckButtonLock = function (f26_arg0, f26_arg1)
	if f26_arg0.itemName == nil then
		return false
	end
	local f26_local0 = UIExpression.GetItemIndex(f26_arg1, f26_arg0.itemName)
	local f26_local1 = false
	if f26_arg1 == nil then
		if UIExpression.IsItemLockedForAll(f26_arg1, f26_local0) == 1 then
			f26_local1 = true
		end
	elseif UIExpression.IsItemLocked(f26_arg1, f26_local0) == 1 then
		f26_local1 = true
	end
	return f26_local1
end

CoD.canInviteToGame = function (f27_arg0, f27_arg1)
	if false then
		return false
	end
	local f27_local0 = UIExpression.IsPlayerInvitable(f27_arg0, f27_arg1) == 1
	local f27_local1 = UIExpression.InLobby(f27_arg0) == 1
	local f27_local2 = UIExpression.InPrivateParty(f27_arg0) == 1
	local f27_local3
	if f27_local0 == 0 then
		f27_local3 = f27_local0
	elseif f27_local1 ~= 0 then
		f27_local3 = f27_local1
	else
		f27_local3 = f27_local2
	end
	return f27_local3
end

CoD.canJoinSession = function (f28_arg0, f28_arg1)
	if false then
		return false
	elseif Engine.IsMemberInParty(f28_arg0, f28_arg1) then
		return false
	else
		return UIExpression.IsPlayerJoinable(f28_arg0, f28_arg1) == CoD.FRIEND_JOINABLE
	end
end

CoD.isInTitle = function (f29_arg0, f29_arg1)
	return UIExpression.IsPlayerInTitle(f29_arg0, f29_arg1) == 1
end

CoD.canAutoJoinSession = function (f30_arg0, f30_arg1)
	return UIExpression.IsPlayerJoinable(f30_arg0, f30_arg1) == CoD.FRIEND_AUTOJOINABLE
end

CoD.canMutePlayer = function (f31_arg0, f31_arg1)
	local f31_local0 = UIExpression.GetXUID(f31_arg0) == f31_arg1
	local f31_local1 = Engine.IsPlayerInCurrentSession(f31_arg0, f31_arg1)
	f31_local1 = f31_local1.inCurrentSession
	if f31_local0 then
		return false
	elseif not f31_local1 then
		return false
	else
		return true
	end
end

CoD.isPlayerMuted = function (f32_arg0, f32_arg1)
	return UIExpression.GetMutedStatus(f32_arg0, f32_arg1) == 1
end

CoD.canSendFriendRequest = function (f33_arg0, f33_arg1)
	if CoD.isPC then
		return false
	elseif Engine.IsGuestByXuid(f33_arg1) == true then
		return false
	else
		local f33_local0
		if UIExpression.GetXUID(f33_arg0) == f33_arg1 or UIExpression.IsFriendFromXUID(f33_arg0, f33_arg1) ~= 0 then
			f33_local0 = false
		else
			f33_local0 = true
		end
	end
	return f33_local0
end

CoD.canKickPlayer = function (f34_arg0, f34_arg1)
	if Engine.IsGuestByXuid(f34_arg1) == true then
		return false
	end
	local f34_local0 = UIExpression.InLobby(f34_arg0) == 1
	local f34_local1 = UIExpression.IsInGame() == 1
	if Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) ~= true and Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) ~= true then
		local f34_local2 = false
	else
		local f34_local2 = true
	end
	local f34_local3 = UIExpression.PrivatePartyHost() == 1
	local f34_local4 = Engine.IsMemberInParty(f34_arg0, f34_arg1) == true
	if UIExpression.GetXUID(f34_arg0) == f34_arg1 then
		return false
	elseif f34_local0 then
		return false
	elseif f34_local1 then
		return false
	elseif not f34_local4 then
		return false
	end
	return true
end

CoD.invitePlayer = function (f35_arg0, f35_arg1, f35_arg2)
	if CoD.canInviteToGame(f35_arg0, f35_arg1) then
		if CoD.isXBOX then
			Engine.Exec(f35_arg0, "xsendinvite " .. f35_arg1)
		elseif CoD.isPS3 or CoD.isWIIU or CoD.isPC then
			if f35_arg2 == CoD.playerListType.friend then
				Engine.Exec(f35_arg0, "sendInvite " .. f35_arg1 .. " 0")
			else
				Engine.Exec(f35_arg0, "sendInvite " .. f35_arg1 .. " 1")
			end
		end
	else
		DebugPrint("^1LUI: ^2cannot send invite.")
	end
end

CoD.joinPlayer = function (f36_arg0, f36_arg1)
	if CoD.canJoinSession(f36_arg0, f36_arg1) then
		Engine.Exec(f36_arg0, "joinplayersessionbyxuid " .. f36_arg1)
	end
end

CoD.sendFriendRequest = function (f37_arg0, f37_arg1)
	if CoD.canSendFriendRequest(f37_arg0, f37_arg1) then
		if CoD.isXBOX then
			Engine.Exec(f37_arg0, "xaddfriend " .. f37_arg1)
		elseif CoD.isPS3 or CoD.isWIIU then
			Engine.Exec(f37_arg0, "xaddfriend " .. f37_arg1)
		end
	end
end

CoD.inviteAccepted = function (f38_arg0, f38_arg1)
	Engine.Exec(f38_arg1.controller, "disableallclients")
	Engine.Exec(f38_arg1.controller, "setclientbeingusedandprimary")
	Engine.ExecNow(f38_arg1.controller, "initiatedemonwareconnect")
	local f38_local0 = f38_arg0:openPopup("popup_connectingdw", f38_arg1.controller)
	f38_local0.inviteAccepted = true
	f38_local0.callingMenu = f38_arg0
end

CoD.viewGamerCard = function (f39_arg0, f39_arg1, f39_arg2, f39_arg3)
	if CoD.isXBOX or CoD.isPC then
		Engine.Exec(f39_arg0, "xshowgamercard " .. f39_arg2)
	elseif CoD.isPS3 then
		if f39_arg3 == CoD.playerListType.friend then
			Engine.Exec(f39_arg0, "xshowgamercard " .. f39_arg2)
		elseif f39_arg3 == CoD.playerListType.recentPlayer then
			Engine.Exec(f39_arg0, "xshowrecentplayersgamercard " .. f39_arg2)
		else
			Engine.Exec(f39_arg0, "xshowgamercardbyname " .. f39_arg1)
		end
	end
end

CoD.acceptGameInvite = function (f40_arg0, f40_arg1)
	if CoD.isWIIU or CoD.isPC then
		Engine.Exec(f40_arg0, "acceptgameinvite " .. f40_arg1)
	end
end

CoD.acceptFriendRequest = function (f41_arg0, f41_arg1, f41_arg2)
	if CoD.isWIIU then
		Engine.Exec(f41_arg0, "acceptfriendrequest " .. f41_arg1 .. " " .. f41_arg2)
	end
end

CoD.slotContainerAlpha = 0.04
CoD.nullSpecialtyName = "PERKS_NONE"
CoD.AddClassItemData = function (f42_arg0, f42_arg1, f42_arg2, f42_arg3)
	if f42_arg1 ~= nil and f42_arg1 > 0 then
		local f42_local0 = UIExpression.GetItemAllocationCost(nil, f42_arg1)
		if f42_local0 >= 0 then
			local f42_local1 = {
				name = UIExpression.GetItemName(nil, f42_arg1),
				description = UIExpression.GetItemDesc(nil, f42_arg1)
			}
			local f42_local2 = UIExpression.GetItemImage(nil, f42_arg1)
			if CoD.IsWeapon(f42_arg1) then
				f42_local2 = f42_local2 .. "_big"
			end
			f42_local1.material = RegisterMaterial(f42_local2)
			f42_local1.ref = UIExpression.GetItemRef(nil, f42_arg1)
			f42_local1.cost = f42_local0
			f42_local1.momentumCost = UIExpression.GetItemMomentumCost(nil, f42_arg1)
			f42_local1.itemIndex = f42_arg1
			f42_local1.count = f42_arg2
			f42_local1.loadoutSlot = f42_arg3
			table.insert(f42_arg0, f42_local1)
		end
	end
end

CoD.AddClassAttachmentData = function (f43_arg0, f43_arg1, f43_arg2)
	if f43_arg1 ~= nil and f43_arg1 > 0 and f43_arg2 ~= nil and f43_arg2 > 0 then
		local f43_local0 = Engine.GetAttachmentAllocationCost(f43_arg1, f43_arg2)
		if f43_local0 >= 0 then
			table.insert(f43_arg0, {
				name = Engine.GetAttachmentName(f43_arg1, f43_arg2),
				description = Engine.GetAttachmentDesc(f43_arg1, f43_arg2),
				material = RegisterMaterial(Engine.GetAttachmentImage(f43_arg1, f43_arg2)),
				cost = f43_local0,
				weaponIndex = f43_arg1,
				attachmentIndex = f43_arg2,
				count = 1
			})
		end
	end
end

CoD.GetMaxQuantity = function (f44_arg0)
	if CoD.IsWeapon(f44_arg0) == true then
		return 1
	else
		return Engine.GetMaxAmmoForItem(f44_arg0)
	end
end

CoD.GetAttachments = function (f45_arg0)
	local f45_local0 = Engine.GetNumAttachments(f45_arg0)
	if f45_local0 == nil then
		return nil
	end
	local f45_local1 = {}
	for f45_local2 = 1, f45_local0 - 1, 1 do
		table.insert(f45_local1, {
			weaponItemIndex = f45_arg0,
			attachmentIndex = f45_local2
		})
	end
	return f45_local1
end

CoD.GetLoadoutSlotForAttachment = function (f46_arg0, f46_arg1, f46_arg2)
	local f46_local0 = Engine.GetAttachmentAttachPoint(f46_arg1, f46_arg2)
	if f46_local0 ~= nil then
		return f46_arg0 .. "attachment" .. f46_local0
	else

	end
end

CoD.GetClassItem = function (f47_arg0, f47_arg1, f47_arg2)
	return Engine.GetClassItem(f47_arg0, f47_arg1, f47_arg2)
end

CoD.SetClassItem = function (f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4)
	Engine.SetClassItem(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
	if f48_arg4 ~= nil then
		Engine.SetClassItem(f48_arg0, f48_arg1, f48_arg2 .. "count", f48_arg4)
	end
end

CoD.RemoveItemFromClass = function (f49_arg0, f49_arg1, f49_arg2)
	for f49_local3, f49_local4 in pairs(CoD.CACUtility.loadoutSlotNames) do
		if f49_arg2 == CoD.GetClassItem(f49_arg0, f49_arg1, f49_local4) then
			CoD.SetClassItem(f49_arg0, f49_arg1, f49_local4, 0)
		end
	end
end

CoD.HowManyInClassSlot = function (f50_arg0, f50_arg1)
	for f50_local3, f50_local4 in pairs(f50_arg1) do
		if f50_local4.itemIndex == f50_arg0 then
			if f50_local4.count == nil then
				return 1
			end
			return f50_local4.count
		end
	end
	return 0
end

CoD.IsWeapon = function (f51_arg0)
	local f51_local0 = Engine.GetLoadoutSlotForItem(f51_arg0)
	local f51_local1 = CoD.CACUtility.loadoutSlotNames
	if f51_local0 and (f51_local0 == f51_local1.primaryWeapon or f51_local0 == f51_local1.secondaryWeapon) then
		return true
	else
		return false
	end
end

CoD.IsPrimaryWeapon = function (f52_arg0)
	local f52_local0 = Engine.GetLoadoutSlotForItem(f52_arg0)
	if f52_local0 and f52_local0 == CoD.CACUtility.loadoutSlotNames.primaryWeapon then
		return true
	else
		return false
	end
end

CoD.IsSecondaryWeapon = function (f53_arg0)
	local f53_local0 = Engine.GetLoadoutSlotForItem(f53_arg0)
	if f53_local0 and f53_local0 == CoD.CACUtility.loadoutSlotNames.secondaryWeapon then
		return true
	else
		return false
	end
end

CoD.IsPerk = function (f54_arg0)
	local f54_local0 = Engine.GetLoadoutSlotForItem(f54_arg0)
	if f54_local0 and string.find(f54_local0, "specialty") == 1 then
		return true
	else
		return false
	end
end

CoD.IsReward = function (f55_arg0)
	local f55_local0 = Engine.GetLoadoutSlotForItem(f55_arg0)
	if f55_local0 and string.find(f55_local0, "killstreak") == 1 then
		return true
	else
		return false
	end
end

CoD.IsGrenade = function (f56_arg0)
	local f56_local0 = Engine.GetLoadoutSlotForItem(f56_arg0)
	local f56_local1 = CoD.CACUtility.loadoutSlotNames
	if f56_local0 and (f56_local0 == f56_local1.primaryGrenade or f56_local0 == f56_local1.specialGrenade) then
		return true
	else
		return false
	end
end

CoD.IsLethalGrenade = function (f57_arg0)
	local f57_local0 = Engine.GetLoadoutSlotForItem(f57_arg0)
	if f57_local0 and f57_local0 == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
		return true
	else
		return false
	end
end

CoD.IsTacticalGrenade = function (f58_arg0)
	local f58_local0 = Engine.GetLoadoutSlotForItem(f58_arg0)
	if f58_local0 and f58_local0 == CoD.CACUtility.loadoutSlotNames.specialGrenade then
		return true
	else
		return false
	end
end

CoD.IsWeaponAttachment = function (f59_arg0, f59_arg1)
	if Engine.GetAttachmentAttachPoint(f59_arg1, f59_arg0) ~= nil then
		return true
	else
		return false
	end
end

CoD.IsBonusCard = function (f60_arg0)
	local f60_local0 = UIExpression.GetItemGroup(nil, f60_arg0)
	if f60_local0 and string.find(f60_local0, "bonuscard") == 1 then
		return true
	else
		return false
	end
end

CoD.GetItemMaterialNameWidthAndHeight = function (f61_arg0, f61_arg1)
	local f61_local0 = UIExpression.GetItemImage(nil, f61_arg0)
	local f61_local1 = 128
	local f61_local2 = 128
	if CoD.IsWeapon(f61_arg0) then
		f61_local1 = f61_local2 * 2
		if f61_arg1 == true then
			f61_local0 = f61_local0 .. "_big"
		end
	elseif CoD.IsBonusCard(f61_arg0) then
		f61_local1 = f61_local2 * 2
	elseif CoD.IsReward(f61_arg0) then
		if f61_arg1 == true then
			f61_local0 = f61_local0 .. "_menu"
		end
	elseif f61_arg1 == true then
		f61_local0 = f61_local0 .. "_256"
	end
	return f61_local0, f61_local1, f61_local2
end

CoD.IsWeaponSlotEquippedAndModifiable = function (f62_arg0, f62_arg1, f62_arg2)
	local f62_local0 = CoD.GetClassItem(f62_arg0, f62_arg1, f62_arg2)
	if f62_local0 ~= nil and f62_local0 > 0 then
		local f62_local1 = CoD.GetAttachments(f62_local0)
		if f62_local1 == nil or #f62_local1 == 0 then
			return false
		else
			return true
		end
	else
		return false
	end
end

CoD.SumClassItemCosts = function (f63_arg0)
	local f63_local0 = 0
	for f63_local5, f63_local6 in pairs(f63_arg0) do
		local f63_local4 = 1
		if f63_local6.count ~= nil then
			f63_local4 = f63_local6.count
		end
		f63_local0 = f63_local0 + f63_local6.cost * f63_local4
	end
	return f63_local0
end

CoD.PopulateClassLabels = function (f64_arg0, f64_arg1)
	if f64_arg0 ~= nil and f64_arg1 ~= nil then
		for f64_local3, f64_local4 in pairs(f64_arg1) do
			f64_local4:setText("")
		end
		for f64_local3, f64_local4 in pairs(f64_arg0) do
			local f64_local5 = f64_arg1[f64_local3]
			if f64_local5 ~= nil then
				f64_local5:setText(UIExpression.ToUpper(nil, Engine.Localize(f64_local4.name)))
			end
		end
	end
end

CoD.PopulateClassImages = function (f65_arg0, f65_arg1)
	if f65_arg0 ~= nil and f65_arg1 ~= nil then
		for f65_local3, f65_local4 in pairs(f65_arg1) do
			f65_local4:beginAnimation("material_change")
			f65_local4:setImage(nil)
			f65_local4:setAlpha(0)
		end
		for f65_local3, f65_local4 in pairs(f65_arg0) do
			local f65_local5 = f65_arg1[f65_local3]
			if f65_local5 ~= nil then
				f65_local5:beginAnimation("material_change")
				f65_local5:setImage(f65_local4.material)
				f65_local5:setAlpha(1)
			end
		end
	end
end

CoD.PopulateClassBGImages = function (f66_arg0, f66_arg1, f66_arg2, f66_arg3, f66_arg4, f66_arg5)
	if f66_arg5 == nil then
		f66_arg5 = 0
	end
	if f66_arg5 > CoD.CACUtility.maxAttachments then
		f66_arg5 = CoD.CACUtility.maxAttachments
	end
	if f66_arg0.itemLabelTabs[f66_arg2] ~= nil then
		f66_arg0.itemLabelTabs[f66_arg2]:beginAnimation("material_change")
		f66_arg0.itemLabelTabs[f66_arg2]:setAlpha(0)
		if f66_arg1[1] ~= nil then
			f66_arg0.itemLabelTabs[f66_arg2]:beginAnimation("material_change")
			f66_arg0.itemLabelTabs[f66_arg2]:setAlpha(0.2)
		end
	end
	if f66_arg4 ~= nil then
		for f66_local3, f66_local4 in pairs(f66_arg4) do
			f66_local4:beginAnimation("material_change")
			f66_local4:setAlpha(0)
		end
		for f66_local0 = 1, f66_arg5, 1 do
			f66_local4 = f66_arg4[f66_local0]
			if f66_local4 ~= nil then
				f66_local4:beginAnimation("material_change")
				f66_local4:setAlpha(0.05)
			end
		end
	end
	if f66_arg0.verticalLines[f66_arg2] ~= nil and f66_arg0.horizontalLines[f66_arg2] ~= nil then
		local f66_local0 = 0
		if f66_arg3 ~= nil then
			f66_local0 = #f66_arg3
		end
		f66_arg0.verticalLines[f66_arg2]:animateToState("attachment_state_" .. f66_local0, 200)
		f66_arg0.horizontalLines[f66_arg2]:animateToState("attachment_state_" .. f66_arg5)
	end
end

CoD.PopulateCamoImage = function (f67_arg0, f67_arg1, f67_arg2, f67_arg3)
	if f67_arg3 == nil then
		f67_arg3 = 0
	end
	if f67_arg3 > CoD.CACUtility.maxAttachments then
		f67_arg3 = CoD.CACUtility.maxAttachments
	end
	if f67_arg0.camoImageContainers[f67_arg2] ~= nil then
		f67_arg0.camoImageContainers[f67_arg2]:animateToState("attachment_state_" .. f67_arg3)
	end
end

CoD.PopulateGrenadeLabel = function (f68_arg0, f68_arg1)
	local f68_local0 = {}
	local f68_local1 = nil
	if f68_arg1 ~= nil then
		f68_arg1:setText("")
		if f68_arg0 ~= nil and f68_arg1 ~= nil then
			for f68_local5, f68_local6 in pairs(f68_arg0) do
				if f68_local6.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
					f68_local0[1] = UIExpression.ToUpper(nil, Engine.Localize(f68_local6.name))
				end
				if f68_local6.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
					f68_local0[2] = UIExpression.ToUpper(nil, Engine.Localize(f68_local6.name))
				end
			end
		end
		if f68_local0[1] ~= nil then
			f68_local1 = f68_local0[1]
		end
		if f68_local0[2] ~= nil then
			if f68_local1 ~= nil then
				f68_local1 = f68_local1 .. " & " .. f68_local0[2]
			else
				f68_local1 = f68_local0[2]
			end
		end
		if f68_local1 ~= nil then
			f68_arg1:setText(f68_local1)
		end
	end
end

CoD.PopulateGrenadeImages = function (f69_arg0, f69_arg1, f69_arg2)
	if f69_arg0 ~= nil and f69_arg1 ~= nil then
		for f69_local3, f69_local4 in pairs(f69_arg1) do
			f69_local4:beginAnimation("material_change")
			f69_local4:setImage(nil)
			f69_local4:setAlpha(0)
		end
		for f69_local3, f69_local4 in pairs(f69_arg0) do
			local f69_local5 = nil
			if f69_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
				f69_local5 = f69_arg1[1]
			elseif f69_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
				f69_local5 = f69_arg1[2]
			end
			if f69_local5 ~= nil then
				f69_local5:beginAnimation("material_change")
				f69_local5:setImage(f69_local4.material)
				f69_local5:setAlpha(1)
			end
		end
		if f69_arg2 ~= nil then
			for f69_local3, f69_local4 in pairs(f69_arg2) do
				f69_local4:beginAnimation("material_change")
				f69_local4:setAlpha(0)
			end
			for f69_local3, f69_local4 in pairs(f69_arg0) do
				local f69_local5 = nil
				if f69_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
					f69_local5 = f69_arg2[1]
				elseif f69_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
					f69_local5 = f69_arg2[2]
				end
				if f69_local5 ~= nil then
					f69_local5:beginAnimation("material_change")
					f69_local5:setAlpha(0.05)
				end
			end
		end
	end
end

CoD.PopulateClassCountLabels = function (f70_arg0, f70_arg1)
	if f70_arg0 ~= nil and f70_arg1 ~= nil then
		for f70_local3, f70_local4 in pairs(f70_arg1) do
			f70_local4:setText("")
		end
		for f70_local3, f70_local4 in pairs(f70_arg0) do
			local f70_local5 = f70_arg1[f70_local3]
			if f70_local5 ~= nil and f70_local4.count ~= nil and f70_local4.count > 1 then
				f70_local5:setText(Engine.Localize("MENU_MULTIPLIER_X", f70_local4.count))
			end
		end
	end
end

CoD.PopulateGrenadeCountLabels = function (f71_arg0, f71_arg1)
	if f71_arg0 ~= nil and f71_arg1 ~= nil then
		for f71_local3, f71_local4 in pairs(f71_arg1) do
			f71_local4:setText("")
		end
		for f71_local3, f71_local4 in pairs(f71_arg0) do
			local f71_local5 = nil
			if f71_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.specialGrenade then
				f71_local5 = f71_arg1[1]
			elseif f71_local4.loadoutSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
				f71_local5 = f71_arg1[2]
			end
			if f71_local5 ~= nil and f71_local4.count ~= nil and f71_local4.count > 1 then
				f71_local5:setText(Engine.Localize("MENU_MULTIPLIER_X", f71_local4.count))
			end
		end
	end
end

CoD.PopulateWeaponInfo = function (f72_arg0, f72_arg1, f72_arg2)
	local f72_local0 = f72_arg0[1]
	if f72_local0 ~= nil then
		if f72_arg1 ~= nil then
			f72_arg1:setText(UIExpression.ToUpper(nil, Engine.Localize(f72_local0.name)))
		end
		if f72_arg2 ~= nil then
			f72_arg2:beginAnimation("material_change", 500)
			f72_arg2:setImage(f72_local0.material)
			f72_arg2:setAlpha(1)
		end
	else
		if f72_arg1 ~= nil then
			f72_arg1:setText("")
		end
		if f72_arg2 ~= nil then
			f72_arg2:beginAnimation("material_change", 500)
			f72_arg2:setImage(nil)
			f72_arg2:setAlpha(0)
		end
	end
end

CoD.PopulateWeaponAttachmentInfo = function (f73_arg0, f73_arg1)
	if f73_arg0 ~= nil and f73_arg1 ~= nil then
		for f73_local3, f73_local4 in pairs(f73_arg1) do
			f73_local4:setText("")
		end
		for f73_local3, f73_local4 in pairs(f73_arg0) do
			local f73_local5 = f73_arg1[f73_local3]
			if f73_local5 ~= nil then
				f73_local5:setText(UIExpression.ToUpper(nil, Engine.Localize(f73_local4.name)))
			end
		end
	end
end

CoD.PopulatePerksInfo = function (f74_arg0, f74_arg1)
	if f74_arg0 ~= nil and f74_arg1 ~= nil then
		for f74_local3, f74_local4 in pairs(f74_arg1) do
			f74_local4:setText("")
		end
		for f74_local3, f74_local4 in pairs(f74_arg0) do
			local f74_local5 = f74_arg1[f74_local3]
		end
	end
end

CoD.CACItemComparisonFunction = function (f75_arg0, f75_arg1)
	return UIExpression.GetItemAllocationCost(nil, f75_arg0) < UIExpression.GetItemAllocationCost(nil, f75_arg1)
end

CoD.CACAttachmentComparisonFunction = function (f76_arg0, f76_arg1)
	return Engine.GetAttachmentAllocationCost(f76_arg0.weaponItemIndex, f76_arg0.attachmentIndex) < Engine.GetAttachmentAllocationCost(f76_arg1.weaponItemIndex, f76_arg1.attachmentIndex)
end

CoD.CACRewardComparisonFunction = function (f77_arg0, f77_arg1)
	local f77_local0 = UIExpression.GetItemAllocationCost(nil, f77_arg0)
	local f77_local1 = UIExpression.GetItemAllocationCost(nil, f77_arg1)
	if f77_local0 == f77_local1 then
		return UIExpression.GetItemMomentumCost(nil, f77_arg0) < UIExpression.GetItemMomentumCost(nil, f77_arg1)
	else
		return f77_local0 < f77_local1
	end
end

CoD.CACGetWeaponAvailableAttachments = function (f78_arg0, f78_arg1)
	local f78_local0 = 0
	if f78_arg0[1] ~= nil then
		f78_local0 = UIExpression.GetNumItemAttachmentsWithAttachPoint(f78_arg1, f78_arg0[1].itemIndex, 0) - 1
	end
	return f78_local0
end

CoD.UsingAltColorScheme = function (f79_arg0)
	if UIExpression.ProfileInt(f79_arg0, "colorblind_assist") ~= 0 then
		return true
	else
		return false
	end
end

CoD.GetFactionColor = function (f80_arg0, f80_arg1)
	return CoD.factionColor[f80_arg0][f80_arg1]
end

CoD.GetFaction = function ()
	return "seals"
end

CoD.GetTeamColor = function (f82_arg0, f82_arg1)
	if CoD.isMultiplayer == true then
		if f82_arg0 == CoD.TEAM_SPECTATOR then
			return CoD.teamColor[f82_arg0]
		end
		local f82_local0, f82_local1, f82_local2 = Engine.GetFactionColor(Engine.GetFactionForTeam(f82_arg0))
		if f82_local0 == nil or f82_local1 == nil or f82_local2 == nil then
			local f82_local3, f82_local4, f82_local5 = Engine.GetFactionColor(Engine.GetFactionForTeam(CoD.TEAM_FREE))
			f82_local2 = f82_local5
			f82_local1 = f82_local4
			f82_local0 = f82_local3
		end
		return {
			r = f82_local0,
			g = f82_local1,
			b = f82_local2
		}
	elseif f82_arg0 == CoD.TEAM_ALLIES or f82_arg0 == CoD.TEAM_AXIS then
		return CoD.GetFactionColor(f82_arg1, f82_arg0)
	else
		return CoD.teamColor[f82_arg0]
	end
end

CoD.GetTeamName = function (f83_arg0)
	if CoD.isMultiplayer == true then
		if f83_arg0 == CoD.TEAM_SPECTATOR then
			return CoD.teamName[CoD.TEAM_SPECTATOR]
		elseif f83_arg0 == CoD.TEAM_FREE then
			return CoD.teamName[CoD.TEAM_FREE]
		elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			if f83_arg0 == CoD.TEAM_ALLIES and Dvar.g_customTeamName_Allies:get() ~= "" then
				return Dvar.g_customTeamName_Allies:get()
			elseif f83_arg0 == CoD.TEAM_AXIS and Dvar.g_customTeamName_Axis:get() ~= "" then
				return Dvar.g_customTeamName_Axis:get()
			end
		end
		return Engine.GetFactionForTeam(f83_arg0)
	elseif f83_arg0 == CoD.TEAM_ALLIES then
		return Engine.Localize(Dvar.g_TeamName_Allies:get())
	elseif f83_arg0 == CoD.TEAM_AXIS then
		return Engine.Localize(Dvar.g_TeamName_Axis:get())
	elseif f83_arg0 == CoD.TEAM_THREE then
		if CoD.isZombie == true then
			return Engine.Localize(Dvar.g_TeamName_Three:get())
		else
			return CoD.teamName[CoD.TEAM_THREE]
		end
	elseif f83_arg0 == CoD.TEAM_SPECTATOR then
		return CoD.teamName[CoD.TEAM_SPECTATOR]
	else
		return CoD.teamName[f83_arg0]
	end
end

CoD.GetTeamNameCaps = function (f84_arg0)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		if f84_arg0 == CoD.TEAM_ALLIES and Dvar.g_customTeamName_Allies:get() ~= "" then
			return UIExpression.ToUpper(nil, Dvar.g_customTeamName_Allies:get())
		elseif f84_arg0 == CoD.TEAM_AXIS and Dvar.g_customTeamName_Axis:get() ~= "" then
			return UIExpression.ToUpper(nil, Dvar.g_customTeamName_Axis:get())
		end
	end
	local f84_local0 = "MPUI_" .. CoD.GetTeamName(f84_arg0) .. "_SHORT_CAPS"
	if f84_arg0 == CoD.TEAM_SPECTATOR then
		f84_local0 = "MPUI_SHOUTCASTER_SHORT_CAPS"
	end
	return Engine.Localize(f84_local0)
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
	local f87_local0 = Dvar.ui_gametype:get()
	if f87_local0 == CoD.lastGametype then
		return CoD.gametypeTeamBased
	else
		local f87_local1 = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f87_local0, 8)
		CoD.lastGametype = f87_local0
		if UIExpression.ToUpper(nil, f87_local1) == "NO" then
			CoD.gametypeTeamBased = false
			return false
		else
			CoD.gametypeTeamBased = true
			return true
		end
	end
end

CoD.GetAnimationStateForUserSafeArea = function (f88_arg0)
	local f88_local0, f88_local1 = Engine.GetUserSafeArea()
	return {
		leftAnchor = false,
		rightAnchor = false,
		left = -f88_local0 / 2,
		right = f88_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f88_local1 / 2,
		bottom = f88_local1 / 2
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

CoD.AddDebugBackground = function (f90_arg0, f90_arg1)
	local f90_local0 = 1
	local f90_local1 = 1
	local f90_local2 = 1
	local f90_local3 = 0.25
	if f90_arg1 ~= nil then
		f90_local0 = f90_arg1.r
		f90_local1 = f90_arg1.g
		f90_local2 = f90_arg1.b
		f90_local3 = f90_arg1.a
	end
	f90_arg0:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		red = f90_local0,
		green = f90_local1,
		blue = f90_local2,
		alpha = f90_local3
	}))
end

CoD.SetPreviousAllocation = function (f91_arg0)
	local f91_local0 = Engine.GetCustomClass(f91_arg0, CoD.perController[f91_arg0].classNum)
	CoD.previousAllocationAmount = f91_local0.allocationSpent
end

CoD.SetupBarracksLock = function (f92_arg0)
	f92_arg0.hintText = Engine.Localize(CoD.MPZM("MPUI_BARRACKS_DESC", "ZMUI_LEADERBOARDS_DESC"))
end

CoD.SetupBarracksNew = function (f93_arg0)
	f93_arg0:registerEventHandler("barracks_closed", CoD.SetupBarracksNew)
	f93_arg0:showNewIcon(Engine.IsAnyEmblemIconNew(UIExpression.GetPrimaryController()))
end

CoD.SetupMatchmakingLock = function (f94_arg0)
	f94_arg0.hintText = Engine.Localize(CoD.MPZM("MPUI_PLAYER_MATCH_DESC", "ZMUI_PLAYER_MATCH_DESC"))
end

CoD.SetupCustomGamesLock = function (f95_arg0)
	if Engine.IsBetaBuild() then
		f95_arg0:lock()
		f95_arg0.hintText = Engine.Localize("FEATURE_CUSTOM_GAMES_LOCKED")
	else
		f95_arg0.hintText = Engine.Localize(CoD.MPZM("MPUI_CUSTOM_MATCH_DESC", "ZMUI_CUSTOM_MATCH_DESC"))
	end
end

CoD.IsShoutcaster = function (f96_arg0)
	if Engine.IsShoutcaster(f96_arg0) or Engine.IsDemoShoutcaster() then
		return true
	else
		return false
	end
end

CoD.ExeProfileVarBool = function (f97_arg0, f97_arg1)
	local f97_local0 = Engine.GetPlayerExeGamerProfile(f97_arg0)
	if f97_local0[f97_arg1] ~= nil and f97_local0[f97_arg1]:get() == 1 then
		return true
	else
		return false
	end
end

CoD.IsInOvertime = function (f98_arg0)
	if CoD.BIT_OVERTIME and UIExpression.IsVisibilityBitSet(f98_arg0, CoD.BIT_OVERTIME) == 1 then
		return true
	else
		return false
	end
end

CoD.MPZM = function (f99_arg0, f99_arg1)
	if CoD.isZombie == true then
		return f99_arg1
	else
		return f99_arg0
	end
end

CoD.SPMPZM = function (f100_arg0, f100_arg1, f100_arg2)
	if CoD.isSinglePlayer == true then
		return f100_arg0
	elseif CoD.isZombie == true then
		return f100_arg2
	elseif CoD.isMultiplayer == true then
		return f100_arg1
	else
		return nil
	end
end

CoD.pairsByKeys = function (f101_arg0, f101_arg1)
	local f101_local0 = {}
	for f101_local4, f101_local5 in pairs(f101_arg0) do
		table.insert(f101_local0, f101_local4)
	end
	table.sort(f101_local0, f101_arg1)
	f101_local1 = 0
	return function ()
		UPVAL0 = f101_local1 + 1
		if f101_local0[f101_local1] == nil then
			return nil
		else
			return f101_local0[f101_local1], f101_arg0[f101_local0[f101_local1]]
		end
	end

end

CoD.UnlockablesComparisonFunction = function (f102_arg0, f102_arg1)
	local f102_local0 = Engine.GetItemSortKey(f102_arg0)
	local f102_local1 = Engine.GetItemSortKey(f102_arg1)
	if f102_local0 == f102_local1 then
		return f102_arg0 < f102_arg1
	else
		return f102_local0 < f102_local1
	end
end

CoD.GetUnlockablesByGroupName = function (f103_arg0)
	local f103_local0 = Engine.GetUnlockablesByGroupName(f103_arg0)
	table.sort(f103_local0, CoD.UnlockablesComparisonFunction)
	return f103_local0
end

CoD.GetUnlockablesBySlotName = function (f104_arg0)
	local f104_local0 = Engine.GetUnlockablesBySlotName(f104_arg0)
	table.sort(f104_local0, CoD.UnlockablesComparisonFunction)
	return f104_local0
end

CoD.ShouldShowWeaponLevel = function ()
	return not Engine.AreAllItemsFree()
end

CoD.GetCenteredImage = function (f106_arg0, f106_arg1, f106_arg2, f106_arg3)
	local f106_local0 = nil
	if f106_arg3 then
		f106_local0 = LUI.UIStreamedImage.new(nil, nil, true)
	else
		f106_local0 = LUI.UIImage.new()
	end
	f106_local0:setLeftRight(false, false, -f106_arg0 / 2, f106_arg0 / 2)
	f106_local0:setTopBottom(false, false, -f106_arg1 / 2, f106_arg1 / 2)
	if f106_arg2 then
		f106_local0:setImage(RegisterMaterial(f106_arg2))
	end
	return f106_local0
end

CoD.GetStretchedImage = function (f107_arg0, f107_arg1)
	local f107_local0 = nil
	if f107_arg1 then
		f107_local0 = LUI.UIStreamedImage.new(nil, nil, true)
	else
		f107_local0 = LUI.UIImage.new()
	end
	f107_local0:setLeftRight(true, true, 0, 0)
	f107_local0:setTopBottom(true, true, 0, 0)
	if f107_arg0 then
		f107_local0:setImage(RegisterMaterial(f107_arg0))
	end
	return f107_local0
end

CoD.GetTextElem = function (f108_arg0, f108_arg1, f108_arg2, f108_arg3, f108_arg4)
	local f108_local0 = "Default"
	local f108_local1 = LUI.Alignment.Center
	local f108_local2 = 0
	if f108_arg1 then
		f108_local1 = LUI.Alignment[f108_arg1]
	end
	if f108_arg0 then
		f108_local0 = f108_arg0
	end
	if f108_arg4 then
		f108_local2 = f108_arg4
	end
	local f108_local3 = CoD.fonts[f108_local0]
	local f108_local4 = CoD.textSize[f108_local0]
	local f108_local5 = LUI.UIText.new()
	f108_local5:setLeftRight(true, true, 0, 0)
	f108_local5:setTopBottom(true, false, f108_local2, f108_local2 + f108_local4)
	f108_local5:setFont(f108_local3)
	f108_local5:setAlignment(f108_local1)
	if f108_arg2 then
		f108_local5:setText(f108_arg2)
	end
	if f108_arg3 then
		f108_local5:setRGB(f108_arg3.r, f108_arg3.g, f108_arg3.b)
	end
	return f108_local5
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

CoD.ModifyTextForReadability = function (f110_arg0)
	if f110_arg0 == nil then
		return f110_arg0
	elseif Dvar.loc_language:get() ~= CoD.LANGUAGE_JAPANESE and Dvar.loc_language:get() ~= CoD.LANGUAGE_FULLJAPANESE then
		f110_arg0 = string.gsub(string.gsub(f110_arg0, "0", "^BFONT_NUMBER_ZERO^"), "I", "^BFONT_CAPITAL_I^")
	end
	return f110_arg0
end

CoD.GetSpinnerWaitingOnEvent = function (f111_arg0, f111_arg1)
	local f111_local0 = 64
	if f111_arg1 then
		f111_local0 = f111_arg1
	end
	local f111_local1 = CoD.GetCenteredImage(f111_local0, f111_local0, "lui_loader")
	f111_local1:registerEventHandler(f111_arg0, function (f113_arg0, f113_arg1)
		f113_arg0:close()
	end)
	return f111_local1
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
