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
	for Index = 0, 3, 1 do
		CoD.perController[Index] = {}
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

CoD.separateNumberWithCommas = function (Number)
	local NumberString = tostring(Number)
	local SeparatedNumber = nil
	for StringEnd = string.len(NumberString), 1, -3 do
		local StringStart = StringEnd - 2
		if StringStart < 1 then
			StringStart = 1
		end
		if SeparatedNumber == nil then
			SeparatedNumber = string.sub(NumberString, StringStart, StringEnd)
		else
			SeparatedNumber = string.sub(NumberString, StringStart, StringEnd) .. "," .. SeparatedNumber
		end
	end
	return SeparatedNumber
end

CoD.GetLocalizedTierText = function (f17_arg0, f17_arg1, f17_arg2)
	local TierText = ""
	if f17_arg1 ~= nil and f17_arg2 ~= nil then
		local f17_local1 = false
		local f17_local3 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_arg1, f17_arg2, 1))
		if f17_local3 > 0 or tonumber(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_arg1, f17_arg2 + 1, 1)) == 1 then
			f17_local1 = true
		end
		if f17_local1 == true then
			TierText = Engine.Localize("CHALLENGE_TIER_" .. f17_local3)
		end
	end
	return TierText
end

CoD.IsTieredChallenge = function (f18_arg0, f18_arg1, f18_arg2)
	if f18_arg1 ~= nil and f18_arg2 ~= nil then
		if tonumber(UIExpression.TableLookupGetColumnValueForRow(f18_arg0, f18_arg1, f18_arg2, 1)) > 0 or tonumber(UIExpression.TableLookupGetColumnValueForRow(f18_arg0, f18_arg1, f18_arg2 + 1, 1)) == 1 then
			return true
		end
	end
	return false
end

CoD.GetUnlockStringForItemIndex = function (LocalClientIndex, f19_arg1)
	if not Engine.HasDLCForItem(LocalClientIndex, f19_arg1) then
		local f19_local0 = Engine.GetDLCNameForItem(f19_arg1)
		if f19_local0 then
			return Engine.Localize("MENU_" .. f19_local0 .. "_REQUIRED_HINT")
		end
	end
	local f19_local0 = UIExpression.GetItemUnlockLevel(LocalClientIndex, f19_arg1)
	return Engine.Localize("MENU_UNLOCKED_AT", Engine.GetRankName(f19_local0), f19_local0 + 1)
end

CoD.GetUnlockLevelString = function (f20_arg0, f20_arg1)
	return CoD.GetUnlockStringForItemIndex(f20_arg0, UIExpression.GetItemIndex(f20_arg0, f20_arg1))
end

CoD.PrestigeAvail = function (LocalClientIndex)
	local PrestigeAvailable
	if tonumber(UIExpression.GetStatByName(LocalClientIndex, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) - 1 or tonumber(UIExpression.GetStatByName(LocalClientIndex, "RANKXP")) < CoD.MAX_RANKXP then
		PrestigeAvailable = false
	else
		PrestigeAvailable = true
	end
	return PrestigeAvailable
end

CoD.PrestigeNext = function (LocalClientIndex)
	local PrestigeNext = true
	if tonumber(UIExpression.GetStatByName(LocalClientIndex, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) or tonumber(UIExpression.GetStatByName(LocalClientIndex, "RANK")) ~= tonumber(CoD.MAX_RANK) then
		PrestigeNext = false
	end
	return PrestigeNext
end

CoD.PrestigeNextLevelText = function (LocalClientIndex)
	local PrestigeNextLevelText = 1
	if tonumber(CoD.MAX_PRESTIGE) - 1 <= tonumber(UIExpression.GetStatByName(LocalClientIndex, "PLEVEL")) then
		PrestigeNextLevelText = ""
	end
	return PrestigeNextLevelText
end

CoD.PrestigeFinish = function (LocalClientIndex)
	return tonumber(UIExpression.GetStatByName(LocalClientIndex, "PLEVEL")) >= tonumber(CoD.MAX_PRESTIGE) - 1
end

CoD.CanRankUp = function (LocalClientIndex)
	local PlayerPrestigeLevel = tonumber(UIExpression.GetStatByName(LocalClientIndex, "PLEVEL"))
	local MaxPrestige = tonumber(CoD.MAX_PRESTIGE)
	local CanRankUp = true
	if not (tonumber(UIExpression.GetStatByName(LocalClientIndex, "RANK")) < tonumber(CoD.MAX_RANK) or PlayerPrestigeLevel < MaxPrestige) or MaxPrestige <= PlayerPrestigeLevel then
		CanRankUp = false
	end
	return CanRankUp
end

CoD.SetupButtonLock = function (f26_arg0, Item, ItemName, ItemHintText, f26_arg4)
	local ItemIndex = UIExpression.GetItemIndex(Item, ItemName)
	local IsItemLocked = false
	if Item == nil then
		if UIExpression.IsItemLockedForAll(Item, ItemIndex) == 1 then
			IsItemLocked = true
		end
	elseif UIExpression.IsItemLocked(Item, ItemIndex) == 1 then
		IsItemLocked = true
	end
	if IsItemLocked == true then
		f26_arg0:lock()
		f26_arg0.hintText = CoD.GetUnlockLevelString(Item, ItemName)
	else
		f26_arg0.hintText = Engine.Localize(ItemHintText)
		f26_arg0:registerEventHandler("button_action", f26_arg4)
	end
	f26_arg0.itemName = ItemName
end

CoD.CheckButtonLock = function (f27_arg0, Item)
	if f27_arg0.itemName == nil then
		return false
	end
	local ItemIndex = UIExpression.GetItemIndex(Item, f27_arg0.itemName)
	local ButtonIsLocked = false
	if Item == nil then
		if UIExpression.IsItemLockedForAll(Item, ItemIndex) == 1 then
			ButtonIsLocked = true
		end
	elseif UIExpression.IsItemLocked(Item, ItemIndex) == 1 then
		ButtonIsLocked = true
	end
	return ButtonIsLocked
end

CoD.canInviteToGame = function (LocalClientIndex, f28_arg1)
	if false then
		return false
	end
	local PlayerIsInvitable = UIExpression.IsPlayerInvitable(LocalClientIndex, f28_arg1) == 1
	local InPrivateParty = UIExpression.InPrivateParty(LocalClientIndex) == 1
	local CanInviteToGame = false
	if PlayerIsInvitable == 0 then
		CanInviteToGame = PlayerIsInvitable
	elseif not (UIExpression.InLobby(LocalClientIndex) == 1) and InPrivateParty == 0 then
		CanInviteToGame = InPrivateParty
	else
		CanInviteToGame = Engine.PartyGetPlayerCount() < Engine.GetMaxUserPlayerCount(LocalClientIndex)
	end
	return CanInviteToGame
end

CoD.canJoinSession = function (LocalClientIndex, Player)
	if false then
		return false
	elseif Engine.IsMemberInParty(LocalClientIndex, Player) then
		return false
	else
		return UIExpression.IsPlayerJoinable(LocalClientIndex, Player) == CoD.FRIEND_JOINABLE
	end
end

CoD.isInTitle = function (LocalClientIndex, f30_arg1)
	return UIExpression.IsPlayerInTitle(LocalClientIndex, f30_arg1) == 1
end

CoD.canAutoJoinSession = function (LocalClientIndex, f31_arg1)
	return UIExpression.IsPlayerJoinable(LocalClientIndex, f31_arg1) == CoD.FRIEND_AUTOJOINABLE
end

CoD.canMutePlayer = function (LocalClientIndex, PlayerXUID)
	local CurrentSessionTable = Engine.IsPlayerInCurrentSession(LocalClientIndex, PlayerXUID)
	CurrentSessionTable = CurrentSessionTable.inCurrentSession
	if UIExpression.GetXUID(LocalClientIndex) == PlayerXUID then
		return false
	elseif not CurrentSessionTable then
		return false
	else
		return true
	end
end

CoD.isPlayerMuted = function (LocalClientIndex, f33_arg1)
	return UIExpression.GetMutedStatus(LocalClientIndex, f33_arg1) == 1
end

CoD.canSendFriendRequest = function (LocalClientIndex, PlayerXUID)
	if CoD.isPC then
		return false
	elseif Engine.IsGuestByXuid(PlayerXUID) == true then
		return false
	else
		local CanSendFriendRequest = true
		if UIExpression.GetXUID(LocalClientIndex) == PlayerXUID or UIExpression.IsFriendFromXUID(LocalClientIndex, PlayerXUID) ~= 0 then
			CanSendFriendRequest = false
		end
		return CanSendFriendRequest
	end
end

CoD.isPlayerInLobby = function (PlayerXUID)
	for PlayerKey, Player in pairs(Engine.GetPlayersInLobby()) do
		if Player.xuid == PlayerXUID then
			return true
		end
	end
	return false
end

CoD.canKickPlayer = function (LocalClientIndex, PlayerXUID)
	if Engine.IsGuestByXuid(PlayerXUID) == true then
		return false
	elseif UIExpression.GetXUID(LocalClientIndex) == PlayerXUID then
		return false
	end
	local IsInLobby = UIExpression.InLobby(LocalClientIndex) == 1
	local KickAllowedInGamemodeType = true
	if Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) ~= true and Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) ~= true then
		KickAllowedInGamemodeType = false
	end
	if UIExpression.IsInGame() == 1 then
		return false
	elseif not CoD.isPlayerInLobby(PlayerXUID) then
		return false
	elseif IsInLobby and not KickAllowedInGamemodeType then
		return false
	elseif IsInLobby and UIExpression.GameHost(LocalClientIndex) == 1 and KickAllowedInGamemodeType then
		return true
	elseif not UIExpression.PrivatePartyHost() == 1 then
		return false
	elseif not Engine.IsMemberInParty(LocalClientIndex, PlayerXUID) == true then
		return false
	end
	return true
end

CoD.invitePlayer = function (LocalClientIndex, Player, Friend)
	if CoD.canInviteToGame(LocalClientIndex, Player) then
		if CoD.isXBOX then
			Engine.Exec(LocalClientIndex, "xsendinvite " .. Player)
		elseif CoD.isPS3 or CoD.isWIIU or CoD.isPC then
			if Friend == CoD.playerListType.friend then
				Engine.Exec(LocalClientIndex, "sendInvite " .. Player .. " 0")
			else
				Engine.Exec(LocalClientIndex, "sendInvite " .. Player .. " 1")
			end
		end
	end
end

CoD.joinPlayer = function (LocalClientIndex, Player)
	if CoD.canJoinSession(LocalClientIndex, Player) then
		Engine.Exec(LocalClientIndex, "joinplayersessionbyxuid " .. Player)
	end
end

CoD.sendFriendRequest = function (LocalClientIndex, f39_arg1)
	if CoD.canSendFriendRequest(LocalClientIndex, f39_arg1) then
		if CoD.isXBOX then
			Engine.Exec(LocalClientIndex, "xaddfriend " .. f39_arg1)
		elseif CoD.isPS3 or CoD.isWIIU then
			Engine.Exec(LocalClientIndex, "xaddfriend " .. f39_arg1)
		end
	end
end

CoD.inviteAccepted = function (CallingMenu, ClientInstance)
	Engine.Exec(ClientInstance.controller, "disableallclients")
	Engine.Exec(ClientInstance.controller, "setclientbeingusedandprimary")
	Engine.ExecNow(ClientInstance.controller, "initiatedemonwareconnect")
	local PopupConnecting = CallingMenu:openPopup("popup_connectingdw", ClientInstance.controller)
	PopupConnecting.inviteAccepted = true
	PopupConnecting.callingMenu = CallingMenu
end

CoD.viewGamerCard = function (LocalClientIndex, f41_arg1, f41_arg2, PlayerListType)
	if CoD.isXBOX or CoD.isPC then
		Engine.Exec(LocalClientIndex, "xshowgamercard " .. f41_arg2)
	elseif CoD.isPS3 then
		if PlayerListType == CoD.playerListType.friend then
			Engine.Exec(LocalClientIndex, "xshowgamercard " .. f41_arg2)
		elseif PlayerListType == CoD.playerListType.recentPlayer then
			Engine.Exec(LocalClientIndex, "xshowrecentplayersgamercard " .. f41_arg2)
		else
			Engine.Exec(LocalClientIndex, "xshowgamercardbyname " .. f41_arg1)
		end
	end
end

CoD.acceptGameInvite = function (LocalClientIndex, f42_arg1)
	if CoD.isWIIU or CoD.isPC then
		Engine.Exec(LocalClientIndex, "acceptgameinvite " .. f42_arg1)
	end
end

CoD.acceptFriendRequest = function (LocalClientIndex, f43_arg1, f43_arg2)
	if CoD.isWIIU then
		Engine.Exec(LocalClientIndex, "acceptfriendrequest " .. f43_arg1 .. " " .. f43_arg2)
	end
end

CoD.slotContainerAlpha = 0.04
CoD.nullSpecialtyName = "PERKS_NONE"
CoD.AddClassItemData = function (ClassDataTable, Item, f44_arg2, ClassLoadoutSlot)
	if Item ~= nil and Item > 0 then
		local AllocationCost = UIExpression.GetItemAllocationCost(nil, Item)
		if AllocationCost >= 0 then
			local ClassItemData = {
				name = UIExpression.GetItemName(nil, Item),
				description = UIExpression.GetItemDesc(nil, Item)
			}
			local ItemImage = UIExpression.GetItemImage(nil, Item)
			if CoD.IsWeapon(Item) then
				ItemImage = ItemImage .. "_big"
			end
			ClassItemData.material = RegisterMaterial(ItemImage)
			ClassItemData.ref = UIExpression.GetItemRef(nil, Item)
			ClassItemData.cost = AllocationCost
			ClassItemData.momentumCost = UIExpression.GetItemMomentumCost(nil, Item)
			ClassItemData.itemIndex = Item
			ClassItemData.count = f44_arg2
			ClassItemData.loadoutSlot = ClassLoadoutSlot
			table.insert(ClassDataTable, ClassItemData)
		end
	end
end

CoD.AddClassAttachmentData = function (f45_arg0, AttachmentIndex, f45_arg2)
	if AttachmentIndex ~= nil and AttachmentIndex > 0 and f45_arg2 ~= nil and f45_arg2 > 0 then
		local AttachmentAllocationCost = Engine.GetAttachmentAllocationCost(AttachmentIndex, f45_arg2)
		if AttachmentAllocationCost >= 0 then
			table.insert(f45_arg0, {
				name = Engine.GetAttachmentName(AttachmentIndex, f45_arg2),
				description = Engine.GetAttachmentDesc(AttachmentIndex, f45_arg2),
				material = RegisterMaterial(Engine.GetAttachmentImage(AttachmentIndex, f45_arg2)),
				cost = AttachmentAllocationCost,
				weaponIndex = AttachmentIndex,
				attachmentIndex = f45_arg2,
				count = 1
			})
		end
	end
end

CoD.GetMaxQuantity = function (Item)
	if CoD.IsWeapon(Item) == true then
		return 1
	else
		return Engine.GetMaxAmmoForItem(Item)
	end
end

CoD.GetAttachments = function (WeaponIndex)
	local WeaponAttachmentsCount = Engine.GetNumAttachments(WeaponIndex)
	if WeaponAttachmentsCount == nil then
		return nil
	end
	local AttachmentTable = {}
	for AttachmentIndex = 1, WeaponAttachmentsCount - 1, 1 do
		table.insert(AttachmentTable, {
			weaponItemIndex = WeaponIndex,
			attachmentIndex = AttachmentIndex
		})
	end
	return AttachmentTable
end

CoD.GetLoadoutSlotForAttachment = function (WeaponSlot, WeaponIndex, AttachmentIndex)
	local f48_local0 = Engine.GetAttachmentAttachPoint(WeaponIndex, AttachmentIndex)
	if f48_local0 ~= nil then
		return WeaponSlot .. "attachment" .. f48_local0
	end
	return nil
end

CoD.GetClassItem = function (LocalClientIndex, ClassIndex, WeaponSlot)
	return Engine.GetClassItem(LocalClientIndex, ClassIndex, WeaponSlot)
end

CoD.SetClassItem = function (LocalClientIndex, ClassIndex, ItemName, ItemIndex, f50_arg4)
	Engine.SetClassItem(LocalClientIndex, ClassIndex, ItemName, ItemIndex)
	if f50_arg4 ~= nil then
		Engine.SetClassItem(LocalClientIndex, ClassIndex, ItemName .. "count", f50_arg4)
	end
end

CoD.RemoveItemFromClass = function (LocalClientIndex, ClassIndex, ItemToRemove)
	for Key, WeaponSlot in pairs(CoD.CACUtility.loadoutSlotNames) do
		if ItemToRemove == CoD.GetClassItem(LocalClientIndex, ClassIndex, WeaponSlot) then
			CoD.SetClassItem(LocalClientIndex, ClassIndex, WeaponSlot, 0)
		end
	end
end

CoD.HowManyInClassSlot = function (f52_arg0, ClassData)
	for Key, f52_local4 in pairs(ClassData) do
		if f52_local4.itemIndex == f52_arg0 then
			if f52_local4.count == nil then
				return 1
			end
			return f52_local4.count
		end
	end
	return 0
end

CoD.IsWeapon = function (Item)
	local WeaponData = Engine.GetLoadoutSlotForItem(Item)
	if WeaponData and (WeaponData == CoD.CACUtility.loadoutSlotNames.primaryWeapon or WeaponData == CoD.CACUtility.loadoutSlotNames.secondaryWeapon) then
		return true
	else
		return false
	end
end

CoD.IsPrimaryWeapon = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and LoadoutSlotName == CoD.CACUtility.loadoutSlotNames.primaryWeapon then
		return true
	else
		return false
	end
end

CoD.IsSecondaryWeapon = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and LoadoutSlotName == CoD.CACUtility.loadoutSlotNames.secondaryWeapon then
		return true
	else
		return false
	end
end

CoD.IsPerk = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and string.find(LoadoutSlotName, "specialty") == 1 then
		return true
	else
		return false
	end
end

CoD.IsReward = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and string.find(LoadoutSlotName, "killstreak") == 1 then
		return true
	else
		return false
	end
end

CoD.IsGrenade = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and (LoadoutSlotName == CoD.CACUtility.loadoutSlotNames.primaryGrenade or LoadoutSlotName == CoD.CACUtility.loadoutSlotNames.specialGrenade) then
		return true
	else
		return false
	end
end

CoD.IsLethalGrenade = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and LoadoutSlotName == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
		return true
	else
		return false
	end
end

CoD.IsTacticalGrenade = function (Item)
	local LoadoutSlotName = Engine.GetLoadoutSlotForItem(Item)
	if LoadoutSlotName and LoadoutSlotName == CoD.CACUtility.loadoutSlotNames.specialGrenade then
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

CoD.IsBonusCard = function (Item)
	local ItemGroupName = UIExpression.GetItemGroup(nil, Item)
	if ItemGroupName and string.find(ItemGroupName, "bonuscard") == 1 then
		return true
	else
		return false
	end
end

CoD.GetItemMaterialNameWidthAndHeight = function (Item, IsBig)
	local ItemImageName = UIExpression.GetItemImage(nil, Item)
	local HorizontalOffset = 128
	local VerticalOffset = 128
	if CoD.IsWeapon(Item) then
		HorizontalOffset = VerticalOffset * 2
		if IsBig == true then
			ItemImageName = ItemImageName .. "_big"
		end
	elseif CoD.IsBonusCard(Item) then
		HorizontalOffset = VerticalOffset * 2
	elseif CoD.IsReward(Item) then
		if IsBig == true then
			ItemImageName = ItemImageName .. "_menu"
		end
	elseif IsBig == true then
		ItemImageName = ItemImageName .. "_256"
	end
	return ItemImageName, HorizontalOffset, VerticalOffset
end

CoD.IsWeaponSlotEquippedAndModifiable = function (LocalClientIndex, ClassIndex, WeaponSlot)
	local ItemIndex = CoD.GetClassItem(LocalClientIndex, ClassIndex, WeaponSlot)
	if ItemIndex ~= nil and ItemIndex > 0 then
		local NumAttachments = CoD.GetAttachments(ItemIndex)
		if NumAttachments == nil or #NumAttachments == 0 then
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
			if f68_arg4[f68_local0] ~= nil then
				f68_arg4[f68_local0]:beginAnimation("material_change")
				f68_arg4[f68_local0]:setAlpha(0.05)
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

CoD.PopulateWeaponAttachmentInfo = function (Attachments, Weapons)
	if Attachments ~= nil and Weapons ~= nil then
		for Index, Weapon in pairs(Weapons) do
			Weapon:setText("")
		end
		for Index, Attachment in pairs(Attachments) do
			local f75_local5 = Weapons[Index]
			if f75_local5 ~= nil then
				f75_local5:setText(UIExpression.ToUpper(nil, Engine.Localize(Attachment.name)))
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

CoD.CACItemComparisonFunction = function (Item1, Item2)
	return UIExpression.GetItemAllocationCost(nil, Item1) < UIExpression.GetItemAllocationCost(nil, Item2)
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

CoD.UsingAltColorScheme = function (LocalClientIndex)
	if UIExpression.ProfileInt(LocalClientIndex, "colorblind_assist") ~= 0 then
		return true
	else
		return false
	end
end

CoD.GetFactionColor = function (Faction, TeamIndex)
	return CoD.factionColor[Faction][TeamIndex]
end

CoD.GetFaction = function ()
	return "seals"
end

CoD.GetTeamColor = function (TeamIndex, Faction)
	if CoD.isMultiplayer == true then
		if TeamIndex == CoD.TEAM_SPECTATOR then
			return CoD.teamColor[TeamIndex]
		end
		local FactionRed, FactionGreen, FactionBlue = Engine.GetFactionColor(Engine.GetFactionForTeam(TeamIndex))
		if FactionRed == nil or FactionGreen == nil or FactionBlue == nil then
			local FactionFreeRed, FactionFreeGreen, FactionFreeBlue = Engine.GetFactionColor(Engine.GetFactionForTeam(CoD.TEAM_FREE))
			FactionBlue = FactionFreeBlue
			FactionGreen = FactionFreeGreen
			FactionRed = FactionFreeRed
		end
		return {
			r = FactionRed,
			g = FactionGreen,
			b = FactionBlue
		}
	elseif TeamIndex == CoD.TEAM_ALLIES or TeamIndex == CoD.TEAM_AXIS then
		return CoD.GetFactionColor(Faction, TeamIndex)
	else
		return CoD.teamColor[TeamIndex]
	end
end

CoD.GetTeamName = function (TeamIndex)
	if CoD.isMultiplayer == true then
		if TeamIndex == CoD.TEAM_SPECTATOR then
			return CoD.teamName[CoD.TEAM_SPECTATOR]
		elseif TeamIndex == CoD.TEAM_FREE then
			return CoD.teamName[CoD.TEAM_FREE]
		elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			if TeamIndex == CoD.TEAM_ALLIES and Dvar.g_customTeamName_Allies:get() ~= "" then
				return Dvar.g_customTeamName_Allies:get()
			elseif TeamIndex == CoD.TEAM_AXIS and Dvar.g_customTeamName_Axis:get() ~= "" then
				return Dvar.g_customTeamName_Axis:get()
			end
		end
		return Engine.GetFactionForTeam(TeamIndex)
	elseif TeamIndex == CoD.TEAM_ALLIES then
		return Engine.Localize(Dvar.g_TeamName_Allies:get())
	elseif TeamIndex == CoD.TEAM_AXIS then
		return Engine.Localize(Dvar.g_TeamName_Axis:get())
	elseif TeamIndex == CoD.TEAM_THREE then
		if CoD.isZombie == true then
			return Engine.Localize(Dvar.g_TeamName_Three:get())
		else
			return CoD.teamName[CoD.TEAM_THREE]
		end
	elseif TeamIndex == CoD.TEAM_SPECTATOR then
		return CoD.teamName[CoD.TEAM_SPECTATOR]
	else
		return CoD.teamName[TeamIndex]
	end
end

CoD.GetTeamNameCaps = function (TeamIndex)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		if TeamIndex == CoD.TEAM_ALLIES and Dvar.g_customTeamName_Allies:get() ~= "" then
			return UIExpression.ToUpper(nil, Dvar.g_customTeamName_Allies:get())
		elseif TeamIndex == CoD.TEAM_AXIS and Dvar.g_customTeamName_Axis:get() ~= "" then
			return UIExpression.ToUpper(nil, Dvar.g_customTeamName_Axis:get())
		end
	end
	local TeamNameCaps = "MPUI_" .. CoD.GetTeamName(TeamIndex) .. "_SHORT_CAPS"
	if TeamIndex == CoD.TEAM_SPECTATOR then
		TeamNameCaps = "MPUI_SHOUTCASTER_SHORT_CAPS"
	end
	return Engine.Localize(TeamNameCaps)
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
	local Gametype = Dvar.ui_gametype:get()
	if Gametype == CoD.lastGametype then
		return CoD.gametypeTeamBased
	else
		local IsTeamBased = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, Gametype, 8)
		CoD.lastGametype = Gametype
		if UIExpression.ToUpper(nil, IsTeamBased) == "NO" then
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
	local CustomClassData = Engine.GetCustomClass(f93_arg0, CoD.perController[f93_arg0].classNum)
	CoD.previousAllocationAmount = CustomClassData.allocationSpent
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

CoD.IsShoutcaster = function (LocalClientIndex)
	if Engine.IsShoutcaster(LocalClientIndex) or Engine.IsDemoShoutcaster() then
		return true
	else
		return false
	end
end

CoD.ExeProfileVarBool = function (LocalClientIndex, Var)
	local ProfileVars = Engine.GetPlayerExeGamerProfile(LocalClientIndex)
	if ProfileVars[Var] ~= nil and ProfileVars[Var]:get() == 1 then
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

CoD.MPZM = function (MPValue, ZMValue)
	if CoD.isZombie == true then
		return ZMValue
	else
		return MPValue
	end
end

CoD.SPMPZM = function (SPValue, MPValue, ZMValue)
	if CoD.isSinglePlayer == true then
		return SPValue
	elseif CoD.isZombie == true then
		return ZMValue
	elseif CoD.isMultiplayer == true then
		return MPValue
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
	local f103_local1 = 0
	if f103_local0[f103_local1] == nil then
		return nil
	else
		return f103_local0[f103_local1], f103_arg0[f103_local0[f103_local1]]
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

CoD.ModifyTextForReadability = function (String)
	if String == nil then
		return String
	elseif Dvar.loc_language:get() ~= CoD.LANGUAGE_JAPANESE and Dvar.loc_language:get() ~= CoD.LANGUAGE_FULLJAPANESE then
		String = string.gsub(string.gsub(String, "0", "^BFONT_NUMBER_ZERO^"), "I", "^BFONT_CAPITAL_I^")
	end
	return String
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

CoD.GetZombieGameTypeName = function (Gametype, f114_arg1)
	if CoD.isZombie then
		local GametypeScreenName = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, Gametype, 7)
		local f114_local1 = Engine.Localize(GametypeScreenName)
		if f114_arg1 ~= nil then
			GametypeScreenName = GametypeScreenName .. "_" .. f114_arg1
			local f114_local2 = Engine.Localize(GametypeScreenName)
			if string.match(f114_local2, GametypeScreenName) == nil then
				f114_local1 = f114_local2
			end
		end
		return f114_local1
	end
end

CoD.GetZombieGameTypeDescription = function (Gametype, f115_arg1)
	if CoD.isZombie then
		local GametypeScreenName = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, Gametype, 2)
		local f115_local1 = Engine.Localize(GametypeScreenName)
		if f115_arg1 ~= nil then
			GametypeScreenName = string.gsub(GametypeScreenName, "_CAPS", "") .. "_" .. f115_arg1 .. "_CAPS"
			local f115_local2 = Engine.Localize(GametypeScreenName)
			if string.match(f115_local2, GametypeScreenName) == nil then
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
		local UsePCMatchmaking = Dvar.tu7_usePCmatchmaking:get()
		if UsePCMatchmaking then
			UsePCMatchmaking = Dvar.tu7_usePingSlider:get()
		end
		return UsePCMatchmaking
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
