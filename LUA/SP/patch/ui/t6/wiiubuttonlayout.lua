require("T6.Line")
require("T6.WiiUControllerSettings")
CoD.WiiUButtonLayout = {}
CoD.WiiUButtonLayout.ButtonStrings = {}
CoD.WiiUButtonLayout.TheaterButtonStrings = {}
CoD.WiiUButtonLayout.LineWidth = 2
CoD.WiiUButtonLayout.LineColor = {
	r = CoD.BOIIOrange.r,
	g = CoD.BOIIOrange.g,
	b = CoD.BOIIOrange.b,
	a = 1
}
CoD.WiiUButtonLayout.ReferenceSize = 500
CoD.WiiUButtonLayout.Labels = {
	drc = {
		BUTTON_A = {
			line = {
				x0 = 250,
				y0 = 86,
				x1 = 202,
				y1 = 63
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_B = {
			line = {
				x0 = 250,
				y0 = 168,
				x1 = 178,
				y1 = 86
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_X = {
			line = {
				x0 = 250,
				y0 = 47,
				x1 = 183,
				y1 = 44
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_Y = {
			line = {
				x0 = 250,
				y0 = 127,
				x1 = 162,
				y1 = 63
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_L = {
			line = {
				x0 = -250,
				y0 = -37,
				x1 = -212,
				y1 = -37
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_R = {
			line = {
				x0 = 250,
				y0 = -37,
				x1 = 212,
				y1 = -37
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_ZL = {
			line = {
				x0 = -250,
				y0 = -87,
				x1 = -195,
				y1 = -87
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_ZR = {
			line = {
				x0 = 250,
				y0 = -87,
				x1 = 196,
				y1 = -87
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_UP = {
			line = {
				x0 = -250,
				y0 = 47,
				x1 = -175,
				y1 = 46
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_DOWN = {
			line = {
				x0 = -250,
				y0 = 168,
				x1 = -175,
				y1 = 79
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_LEFT = {
			line = {
				x0 = -250,
				y0 = 86,
				x1 = -191,
				y1 = 62
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_RIGHT = {
			line = {
				x0 = -250,
				y0 = 129,
				x1 = -158,
				y1 = 63
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_PLUS = {
			line = {
				x0 = 250,
				y0 = 218,
				x1 = 158,
				y1 = 110
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_MINUS = {
			line = {
				x0 = 250,
				y0 = 261,
				x1 = 157,
				y1 = 135
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_L3 = {
			line = {
				x0 = -250,
				y0 = 0,
				x1 = -195,
				y1 = 8
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_R3 = {
			line = {
				x0 = 250,
				y0 = 0,
				x1 = 195,
				y1 = 8
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_DPAD = {
			line = {
				x0 = -250,
				y0 = 61,
				x1 = -200,
				y1 = 61
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		}
	},
	uc = {
		BUTTON_A = {
			line = {
				x0 = 250,
				y0 = 108,
				x1 = 129,
				y1 = 77
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_B = {
			line = {
				x0 = 250,
				y0 = 206,
				x1 = 95,
				y1 = 111
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_X = {
			line = {
				x0 = 250,
				y0 = 53,
				x1 = 98,
				y1 = 47
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_Y = {
			line = {
				x0 = 250,
				y0 = 159,
				x1 = 64,
				y1 = 77
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_L = {
			line = {
				x0 = -250,
				y0 = -68,
				x1 = -175,
				y1 = -68
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_R = {
			line = {
				x0 = 250,
				y0 = -68,
				x1 = 175,
				y1 = -68
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_ZL = {
			line = {
				x0 = -250,
				y0 = -124,
				x1 = -157,
				y1 = -124
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_ZR = {
			line = {
				x0 = 250,
				y0 = -124,
				x1 = 157,
				y1 = -124
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_UP = {
			line = {
				x0 = -250,
				y0 = 53,
				x1 = -88,
				y1 = 51
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_DOWN = {
			line = {
				x0 = -250,
				y0 = 206,
				x1 = -88,
				y1 = 102
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_LEFT = {
			line = {
				x0 = -250,
				y0 = 108,
				x1 = -113,
				y1 = 76
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_RIGHT = {
			line = {
				x0 = -250,
				y0 = 159,
				x1 = -62,
				y1 = 77
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_PLUS = {
			line = {
				x0 = 40,
				y0 = 164,
				x1 = 40,
				y1 = 21
			},
			labelJustifyH = "center",
			labelJustifyV = "top"
		},
		BUTTON_MINUS = {
			line = {
				x0 = -40,
				y0 = 200,
				x1 = -40,
				y1 = 21
			},
			labelJustifyH = "center",
			labelJustifyV = "top"
		},
		BUTTON_L3 = {
			line = {
				x0 = -250,
				y0 = 3,
				x1 = -139,
				y1 = 3
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_R3 = {
			line = {
				x0 = 250,
				y0 = 3,
				x1 = 139,
				y1 = 3
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_DPAD = {
			line = {
				x0 = -250,
				y0 = 77,
				x1 = -129,
				y1 = 77
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		}
	},
	classic = {
		BUTTON_A = {
			line = {
				x0 = 250,
				y0 = 27,
				x1 = 197,
				y1 = 12
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_B = {
			line = {
				x0 = 250,
				y0 = 123,
				x1 = 150,
				y1 = 50
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_X = {
			line = {
				x0 = 250,
				y0 = -21,
				x1 = 153,
				y1 = -21
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_Y = {
			line = {
				x0 = 250,
				y0 = 76,
				x1 = 108,
				y1 = 12
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_L = {
			line = {
				x0 = -250,
				y0 = -80,
				x1 = -161,
				y1 = -80
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_R = {
			line = {
				x0 = 250,
				y0 = -80,
				x1 = 161,
				y1 = -80
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_L_AND_R = {
			line = {
				x0 = 0,
				y0 = -131,
				x1 = -138,
				y1 = -87
			},
			line2 = {
				x0 = 0,
				y0 = -131,
				x1 = 138,
				y1 = -87
			},
			labelJustifyH = "center",
			labelJustifyV = "bottom"
		},
		BUTTON_ZL = {
			line = {
				x0 = -250,
				y0 = -142,
				x1 = -160,
				y1 = -130
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_ZR = {
			line = {
				x0 = 250,
				y0 = -142,
				x1 = 160,
				y1 = -130
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_ZL_AND_ZR = {
			line = {
				x0 = 0,
				y0 = -160,
				x1 = -114,
				y1 = -130
			},
			line2 = {
				x0 = 0,
				y0 = -160,
				x1 = 114,
				y1 = -130
			},
			labelJustifyH = "center",
			labelJustifyV = "bottom"
		},
		BUTTON_UP = {
			line = {
				x0 = -250,
				y0 = -21,
				x1 = -146,
				y1 = -21
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_DOWN = {
			line = {
				x0 = -250,
				y0 = 123,
				x1 = -144,
				y1 = 42
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_LEFT = {
			line = {
				x0 = -250,
				y0 = 27,
				x1 = -171,
				y1 = 12
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_RIGHT = {
			line = {
				x0 = -250,
				y0 = 76,
				x1 = -112,
				y1 = 12
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_PLUS = {
			line = {
				x0 = 34,
				y0 = 163,
				x1 = 34,
				y1 = 15
			},
			labelJustifyH = "center",
			labelJustifyV = "top"
		},
		BUTTON_MINUS = {
			line = {
				x0 = -33,
				y0 = 195,
				x1 = -33,
				y1 = 13
			},
			labelJustifyH = "center",
			labelJustifyV = "top"
		},
		HINT = {
			line = {
				x0 = -418,
				y0 = 260,
				x1 = 0,
				y1 = 0
			},
			labelJustifyH = "left",
			labelJustifyV = "top",
			hideLine = true
		}
	},
	remote = {
		BUTTON_A = {
			line = {
				x0 = 200,
				y0 = 10,
				x1 = 134,
				y1 = -38
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_B = {
			line = {
				x0 = 200,
				y0 = -40,
				x1 = 128,
				y1 = -61
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_C = {
			line = {
				x0 = -63,
				y0 = -137,
				x1 = -63,
				y1 = -87
			},
			labelJustifyH = "center",
			labelJustifyV = "bottom"
		},
		BUTTON_Z = {
			line = {
				x0 = -22,
				y0 = -20,
				x1 = -52,
				y1 = -52
			},
			labelJustifyH = "center",
			labelJustifyV = "top"
		},
		BUTTON_UP = {
			line = {
				x0 = 200,
				y0 = -168,
				x1 = 127,
				y1 = -104
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_DOWN = {
			line = {
				x0 = 200,
				y0 = -80,
				x1 = 128,
				y1 = -75
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_LEFT = {
			line = {
				x0 = 58,
				y0 = -89,
				x1 = 113,
				y1 = -89
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_RIGHT = {
			line = {
				x0 = 200,
				y0 = -121,
				x1 = 143,
				y1 = -89
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_LEFT_RTS = {
			line = {
				x0 = 58,
				y0 = -150,
				x1 = 113,
				y1 = -89
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_PLUS = {
			line = {
				x0 = 200,
				y0 = 59,
				x1 = 150,
				y1 = 17
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_MINUS = {
			line = {
				x0 = 58,
				y0 = 70,
				x1 = 104,
				y1 = 17
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		BUTTON_1 = {
			line = {
				x0 = 200,
				y0 = 147,
				x1 = 133,
				y1 = 104
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		BUTTON_2 = {
			line = {
				x0 = 200,
				y0 = 186,
				x1 = 133,
				y1 = 133
			},
			labelJustifyH = "left",
			labelJustifyV = "center"
		},
		GESTURE_NUNCHUK = {
			line = {
				x0 = 20,
				y0 = 130,
				x1 = 128,
				y1 = 203
			},
			labelJustifyH = "right",
			labelJustifyV = "center",
			hideLine = true
		},
		TWIST_REMOTE = {
			line = {
				x0 = 200,
				y0 = 99,
				x1 = 150,
				y1 = 17
			},
			labelJustifyH = "left",
			labelJustifyV = "center",
			hideLine = true
		},
		ANALOG_STICK = {
			line = {
				x0 = -184,
				y0 = -91,
				x1 = -145,
				y1 = -91
			},
			labelJustifyH = "right",
			labelJustifyV = "center"
		},
		HINT = {
			line = {
				x0 = -418,
				y0 = -210,
				x1 = 0,
				y1 = 0
			},
			labelJustifyH = "left",
			labelJustifyV = "top",
			hideLine = true
		}
	}
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_DEFAULT] = {
	BUTTON_A = "MENU_SWITCH_WEAPON",
	BUTTON_B = "MENU_USE_RELOAD",
	BUTTON_X = "MENU_JUMP",
	BUTTON_Y = "MENU_CROUCH_PRONE",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_R3 = "MENU_MELEE_ATTACK",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_EXPERIMENTAL] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_USE_RELOAD",
	BUTTON_X = "MENU_MELEE_ATTACK",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_R3 = "MENU_CROUCH_PRONE",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_LEFTY] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_USE_RELOAD",
	BUTTON_X = "MENU_CROUCH_PRONE",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_L = "MENU_THROW_FRAG_GRENADE",
	BUTTON_R = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_ZL = "MENU_FIRE_WEAPON",
	BUTTON_ZR = "MENU_AIM_DOWN_SIGHT",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_MELEE_ATTACK",
	BUTTON_R3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_NOMAD] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_USE_RELOAD",
	BUTTON_X = "MENU_MELEE_ATTACK",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL = "MENU_TOGGLE_AIM_DOWN_THE_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_R3 = "MENU_CROUCH_PRONE",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_CHARLIE] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_USE_RELOAD",
	BUTTON_X = "MENU_CROUCH_PRONE",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_TOGGLE_AIM_DOWN_THE_SIGHT",
	BUTTON_ZL = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_R3 = "MENU_MELEE_ATTACK",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_DELTA] = {
	BUTTON_A = "MENU_SWITCH_WEAPON",
	BUTTON_B = "MENU_CROUCH_PRONE",
	BUTTON_X = "MENU_JUMP",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_R3 = "MENU_MELEE_ATTACK",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.GAMEPAD_DEFAULT_XENON] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_JUMP",
	BUTTON_X = "MENU_SWITCH_WEAPON",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_UP = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.SPMPZM("", "MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.SPMPZM("", "MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	BUTTON_L3 = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_R3 = "MENU_MELEE_ATTACK",
	BUTTON_DPAD = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_ROMEO] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_SPRINT",
	BUTTON_X = "MENU_MELEE_ATTACK",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_L_AND_R = "",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_ROMEO_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_SIERRA] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_SPRINT",
	BUTTON_X = "MENU_MELEE_ATTACK",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_AIM_DOWN_SIGHT",
	BUTTON_R = "MENU_FIRE_WEAPON",
	BUTTON_L_AND_R = "",
	BUTTON_ZL = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_ZR = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_SIERRA_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_TANGO] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_SPRINT",
	BUTTON_X = "MENU_SWITCH_WEAPON",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_R = "MENU_THROW_FRAG_GRENADE",
	BUTTON_L_AND_R = "",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_TANGO_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_UNIFORM] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_SPRINT",
	BUTTON_X = "MENU_SWITCH_WEAPON",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_AIM_DOWN_SIGHT",
	BUTTON_R = "MENU_FIRE_WEAPON",
	BUTTON_L_AND_R = "",
	BUTTON_ZL = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_ZR = "MENU_THROW_FRAG_GRENADE",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_UNIFORM_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_VICTOR] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_JUMP",
	BUTTON_X = "MENU_SPRINT",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_R = "MENU_MELEE_ATTACK",
	BUTTON_L = "PLATFORM_MODIFIER",
	BUTTON_L_AND_R = "",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_VICTOR_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_WHISKEY] = {
	BUTTON_A = "MENU_CROUCH_PRONE",
	BUTTON_B = "MENU_JUMP",
	BUTTON_X = "MENU_SPRINT",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "MENU_AIM_DOWN_SIGHT",
	BUTTON_R = "MENU_FIRE_WEAPON",
	BUTTON_L_AND_R = "",
	BUTTON_ZR = "MENU_MELEE_ATTACK",
	BUTTON_ZL = "PLATFORM_MODIFIER",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_WHISKEY_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.CLASSIC_ZERO] = {
	BUTTON_A = "MENU_SWITCH_WEAPON",
	BUTTON_B = "MENU_JUMP",
	BUTTON_X = "MENU_SPRINT",
	BUTTON_Y = "MENU_USE_RELOAD",
	BUTTON_L = "PLATFORM_MODIFIER",
	BUTTON_R = "MENU_MELEE_ATTACK",
	BUTTON_L_AND_R = "",
	BUTTON_ZL = "MENU_AIM_DOWN_SIGHT",
	BUTTON_ZR = "MENU_FIRE_WEAPON",
	BUTTON_ZL_AND_ZR = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "MENU_CROUCH_PRONE",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "",
	BUTTON_PLUS = "MENU_OBJECTIVES_MENU",
	BUTTON_MINUS = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	HINT = "PLATFORM_ZERO_BUTTON_LAYOUT_HINT"
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_ALPHA] = {
	BUTTON_A = "PLATFORM_USE_SPRINT_CAMERALOCK",
	BUTTON_B = "PLATFORM_REMOTE_FIRE_WEAPON",
	BUTTON_C = "MENU_CROUCH_PRONE",
	BUTTON_Z = "MENU_AIM_DOWN_SIGHT",
	BUTTON_UP = "MENU_JUMP",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "MENU_THROW_FRAG_GRENADE",
	BUTTON_MINUS = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_1 = "MENU_OBJECTIVES_MENU",
	BUTTON_2 = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	GESTURE_NUNCHUK = "PLATFORM_NUNCHUK_RELOAD_TWO_LINES",
	TWIST_REMOTE = "",
	ANALOG_STICK = "MENU_MOVE",
	HINT = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_BRAVO] = {
	BUTTON_A = "PLATFORM_USE_SPRINT_CAMERALOCK",
	BUTTON_B = "PLATFORM_REMOTE_FIRE_WEAPON",
	BUTTON_C = "MENU_CROUCH_PRONE",
	BUTTON_Z = "MENU_AIM_DOWN_SIGHT",
	BUTTON_UP = "MENU_JUMP",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "MENU_THROW_FRAG_GRENADE",
	BUTTON_MINUS = "PLATFORM_RELOAD_LABEL",
	BUTTON_1 = "MENU_OBJECTIVES_MENU",
	BUTTON_2 = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	GESTURE_NUNCHUK = "",
	TWIST_REMOTE = "PLATFORM_TWIST_FOR_SPECIAL_GRENADE",
	ANALOG_STICK = "MENU_MOVE",
	HINT = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_CHARLIE] = {
	BUTTON_A = "MENU_AIM_DOWN_SIGHT",
	BUTTON_B = "PLATFORM_REMOTE_FIRE_WEAPON",
	BUTTON_C = "MENU_CROUCH_PRONE",
	BUTTON_Z = "PLATFORM_USE_SPRINT_CAMERALOCK",
	BUTTON_UP = "MENU_JUMP",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "MENU_THROW_FRAG_GRENADE",
	BUTTON_MINUS = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_1 = "MENU_OBJECTIVES_MENU",
	BUTTON_2 = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	GESTURE_NUNCHUK = "PLATFORM_NUNCHUK_RELOAD_TWO_LINES",
	TWIST_REMOTE = "",
	ANALOG_STICK = "MENU_MOVE",
	HINT = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_DELTA] = {
	BUTTON_A = "MENU_AIM_DOWN_SIGHT",
	BUTTON_B = "PLATFORM_REMOTE_FIRE_WEAPON",
	BUTTON_C = "MENU_CROUCH_PRONE",
	BUTTON_Z = "PLATFORM_USE_SPRINT_CAMERALOCK",
	BUTTON_UP = "MENU_JUMP",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "MENU_THROW_FRAG_GRENADE",
	BUTTON_MINUS = "PLATFORM_RELOAD_LABEL",
	BUTTON_1 = "MENU_OBJECTIVES_MENU",
	BUTTON_2 = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	GESTURE_NUNCHUK = "",
	TWIST_REMOTE = "PLATFORM_TWIST_FOR_SPECIAL_GRENADE",
	ANALOG_STICK = "MENU_MOVE",
	HINT = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_ECHO] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "PLATFORM_REMOTE_FIRE_WEAPON",
	BUTTON_C = "PLATFORM_USE_SPRINT_CAMERALOCK",
	BUTTON_Z = "MENU_AIM_DOWN_SIGHT",
	BUTTON_UP = "PLATFORM_RELOAD_LABEL",
	BUTTON_DOWN = "MENU_MELEE_ATTACK",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "MENU_THROW_FRAG_GRENADE",
	BUTTON_MINUS = "MENU_CROUCH_PRONE",
	BUTTON_1 = "MENU_OBJECTIVES_MENU",
	BUTTON_2 = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	GESTURE_NUNCHUK = "",
	TWIST_REMOTE = "PLATFORM_TWIST_FOR_SPECIAL_GRENADE",
	ANALOG_STICK = "MENU_MOVE",
	HINT = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_FOXTROT] = {
	BUTTON_A = "PLATFORM_USE_SPRINT_CAMERALOCK",
	BUTTON_B = "PLATFORM_REMOTE_FIRE_WEAPON",
	BUTTON_C = "MENU_CROUCH_PRONE",
	BUTTON_Z = "MENU_AIM_DOWN_SIGHT",
	BUTTON_UP = "MENU_THROW_SPECIAL_GRENADE",
	BUTTON_DOWN = "MENU_JUMP",
	BUTTON_LEFT = "MENU_INVENTORY",
	BUTTON_RIGHT = "MENU_SWITCH_WEAPON",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "PLATFORM_RELOAD_LABEL",
	BUTTON_MINUS = "MENU_MELEE_ATTACK",
	BUTTON_1 = "MENU_OBJECTIVES_MENU",
	BUTTON_2 = CoD.SPMPZM("", "MENU_SCOREBOARD", "MENU_SCOREBOARD"),
	GESTURE_NUNCHUK = "PLATFORM_NUNCHUK_FOR_FRAG",
	TWIST_REMOTE = "",
	ANALOG_STICK = "MENU_MOVE",
	HINT = ""
}
CoD.WiiUButtonLayout.ButtonStrings[CoD.WiiUControllerSettings.WIIUMOTE_CUSTOM] = {
	BUTTON_A = "",
	BUTTON_B = "",
	BUTTON_C = "",
	BUTTON_Z = "",
	BUTTON_UP = "",
	BUTTON_DOWN = "",
	BUTTON_LEFT = "",
	BUTTON_RIGHT = "",
	BUTTON_LEFT_RTS = "",
	BUTTON_PLUS = "",
	BUTTON_MINUS = "",
	BUTTON_1 = "",
	BUTTON_2 = "",
	GESTURE_NUNCHUK = "",
	TWIST_REMOTE = "",
	ANALOG_STICK = "",
	HINT = ""
}
CoD.WiiUButtonLayout.TheaterButtonStrings[CoD.DEMO_CONTROLLER_CONFIG_DIGITAL] = {
	drc = {
		BUTTON_A = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
		BUTTON_B = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_X = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_Y = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_L = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_R = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_ZL = "MENU_DEMO_CONTROLS_SLOW_MO",
		BUTTON_ZR = "MENU_DEMO_CONTROLS_FAST_MO",
		BUTTON_UP = "",
		BUTTON_DOWN = "",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_MINUS = "MENU_SCOREBOARD",
		BUTTON_L3 = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
		BUTTON_R3 = "",
		BUTTON_DPAD = ""
	},
	uc = {
		BUTTON_A = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
		BUTTON_B = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_X = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_Y = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_L = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_R = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_ZL = "MENU_DEMO_CONTROLS_SLOW_MO",
		BUTTON_ZR = "MENU_DEMO_CONTROLS_FAST_MO",
		BUTTON_UP = "",
		BUTTON_DOWN = "",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_MINUS = "MENU_SCOREBOARD",
		BUTTON_L3 = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
		BUTTON_R3 = "",
		BUTTON_DPAD = ""
	},
	classic = {
		BUTTON_A = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
		BUTTON_B = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_X = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_Y = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_L = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_R = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_L_AND_R = "",
		BUTTON_ZL = "MENU_DEMO_CONTROLS_SLOW_MO",
		BUTTON_ZR = "MENU_DEMO_CONTROLS_FAST_MO",
		BUTTON_ZL_AND_ZR = "",
		BUTTON_UP = "",
		BUTTON_DOWN = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_MINUS = "MENU_SCOREBOARD",
		HINT = ""
	},
	remote = {
		BUTTON_A = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_B = "PLATFORM_DEMO_REMOTE_CONTROLS_DIGITAL_FAST_MO",
		BUTTON_C = "PLATFORM_MODIFIER",
		BUTTON_Z = "MENU_DEMO_CONTROLS_SLOW_MO",
		BUTTON_UP = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_DOWN = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_LEFT_RTS = "",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_MINUS = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_1 = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_2 = "MENU_SCOREBOARD",
		GESTURE_NUNCHUK = "",
		TWIST_REMOTE = "",
		ANALOG_STICK = "",
		HINT = "PLATFORM_DEMO_REMOTE_CONTROLS_DIGITAL_HINT"
	}
}
CoD.WiiUButtonLayout.TheaterButtonStrings[CoD.DEMO_CONTROLLER_CONFIG_BADBOT] = {
	drc = {
		BUTTON_A = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
		BUTTON_B = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_X = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_Y = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_L = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_R = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_ZL = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_ZR = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_UP = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_DOWN = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_MINUS = "MENU_SCOREBOARD",
		BUTTON_L3 = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
		BUTTON_R3 = "",
		BUTTON_DPAD = ""
	},
	uc = {
		BUTTON_A = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
		BUTTON_B = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_X = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_Y = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_L = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_R = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_ZL = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_ZR = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_UP = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_DOWN = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_MINUS = "MENU_SCOREBOARD",
		BUTTON_L3 = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
		BUTTON_R3 = "",
		BUTTON_DPAD = ""
	},
	classic = {
		BUTTON_A = "PLATFORM_MODIFIER",
		BUTTON_B = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_X = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
		BUTTON_Y = "MENU_DEMO_CONTROLS_RECORD",
		BUTTON_L = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_R = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_L_AND_R = "",
		BUTTON_ZL = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_ZR = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
		BUTTON_ZL_AND_ZR = "",
		BUTTON_UP = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_DOWN = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_MINUS = "MENU_SCOREBOARD",
		HINT = "PLATFORM_DEMO_CCP_CONTROLS_BADBOT_HINT"
	},
	remote = {
		BUTTON_A = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
		BUTTON_B = "PLATFORM_DEMO_REMOTE_CONTROLS_BADBOT_JUMP_FORWARD",
		BUTTON_C = "PLATFORM_MODIFIER",
		BUTTON_Z = "MENU_DEMO_CONTROLS_JUMP_BACK",
		BUTTON_UP = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_DOWN = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_SMALL",
		BUTTON_LEFT = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_RIGHT = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_LARGE",
		BUTTON_LEFT_RTS = "",
		BUTTON_PLUS = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
		BUTTON_MINUS = "MENU_DEMO_CONTROLS_PREV_PLAYER",
		BUTTON_1 = "MENU_DEMO_CONTROLS_PAUSE_MENU",
		BUTTON_2 = "MENU_SCOREBOARD",
		GESTURE_NUNCHUK = "",
		TWIST_REMOTE = "",
		ANALOG_STICK = "",
		HINT = "PLATFORM_DEMO_REMOTE_CONTROLS_BADBOT_HINT"
	}
}
local f0_local0 = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.HintText.Height - 8
	local f1_local1 = f1_arg1 - 13
	local f1_local2 = f1_arg2 + 8
	
	local hintArrow = LUI.UIImage.new()
	hintArrow:setLeftRight(true, false, f1_local1, f1_local1 + f1_local0)
	hintArrow:setTopBottom(true, false, f1_local2, f1_local2 + f1_local0)
	hintArrow:setImage(RegisterMaterial(CoD.HintText.ArrowMaterialName))
	hintArrow:setAlpha(0)
	f1_arg0:addElement(hintArrow)
	f1_arg0.hintArrow = hintArrow
	
end

local f0_local1 = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	if f2_arg3 == nil then
		f2_arg3 = 1
	end
	local f2_local0 = f2_arg2.line
	local Widget = LUI.UIElement.new()
	Widget:setTopBottom(true, false, 0, 0)
	f2_arg0.buttonLines[f2_arg1] = Widget
	f2_arg0:addElement(Widget)
	local f2_local2 = CoD.Line.new({
		f2_local0.x0 * f2_arg3,
		f2_local0.y0 * f2_arg3
	}, {
		f2_local0.x1 * f2_arg3,
		f2_local0.y1 * f2_arg3
	}, CoD.ButtonLayout.LineWidth, CoD.ButtonLayout.LineColor)
	local f2_local3 = CoD.WiiUButtonLayout.LineColor
	f2_local2:setRGB(f2_local3.r, f2_local3.g, f2_local3.b)
	Widget:addElement(f2_local2)
	if f2_arg2.line2 ~= nil then
		local f2_local4 = f2_arg2.line2
		local f2_local5 = CoD.Line.new({
			f2_local4.x0 * f2_arg3,
			f2_local4.y0 * f2_arg3
		}, {
			f2_local4.x1 * f2_arg3,
			f2_local4.y1 * f2_arg3
		}, CoD.ButtonLayout.LineWidth, CoD.ButtonLayout.LineColor)
		local f2_local6 = CoD.WiiUButtonLayout.LineColor
		f2_local5:setRGB(f2_local6.r, f2_local6.g, f2_local6.b)
		Widget:addElement(f2_local5)
	end
	local f2_local4 = LUI.UIText.new()
	f2_local4.labelInfo = f2_arg2
	f2_local4:setRGB(CoD.ButtonLayout.LineColor[1], CoD.ButtonLayout.LineColor[2], CoD.ButtonLayout.LineColor[3])
	f2_local4:setFont(CoD.fonts.Default)
	if f2_arg1 == "HINT" then
		f0_local0(f2_arg0, f2_local0.x0, f2_local0.y0)
	end
	local f2_local5 = 5
	if f2_arg2.labelJustifyH == "left" then
		f2_local4:setLeftRight(true, false, (f2_local0.x0 + f2_local5) * f2_arg3, (f2_local0.x0 + f2_local5 + 1000) * f2_arg3)
		f2_local4:setAlignment(LUI.Alignment.Left)
	elseif f2_arg2.labelJustifyH == "right" then
		f2_local4:setLeftRight(false, true, (f2_local0.x0 - f2_local5 + 1000) * f2_arg3, (f2_local0.x0 - f2_local5) * f2_arg3)
		f2_local4:setAlignment(LUI.Alignment.Right)
	else
		f2_local4:setLeftRight(false, false, (f2_local0.x0 - 1000) * f2_arg3, (f2_local0.x0 + 1000) * f2_arg3)
		f2_local4:setAlignment(LUI.Alignment.Center)
	end
	local f2_local7 = f2_local0.y0 * f2_arg3 + 5
	f2_local4:setTopBottom(true, false, f2_local7, f2_local7 + CoD.textSize.Default)
	f2_arg0:addElement(f2_local4)
	f2_arg0.buttonLabels[f2_arg1] = f2_local4
end

CoD.WiiUButtonLayout.AddLinesAndLabels = function (f3_arg0, f3_arg1)
	f3_arg0.buttonLabels = {}
	f3_arg0.buttonLines = {}
	for f3_local3, f3_local4 in pairs(CoD.WiiUButtonLayout.Labels[UIExpression.GetControllerType(f3_arg1)]) do
		f0_local1(f3_arg0, f3_local3, f3_local4)
	end
end

local f0_local2 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg3 == nil then
		f4_arg3 = 1
	end
	local f4_local0 = f4_arg0.buttonLabels[f4_arg1].labelInfo
	local f4_local1 = Engine.Localize(f4_arg2)
	f4_arg0.buttonLabels[f4_arg1]:setText(f4_local1)
	if f4_arg2 ~= "" then
		if f4_local0.hideLine then
			f4_arg0.buttonLines[f4_arg1]:setAlpha(0)
		else
			f4_arg0.buttonLines[f4_arg1]:setAlpha(1)
		end
		f4_arg0.buttonLabels[f4_arg1]:setAlpha(1)
	else
		f4_arg0.buttonLines[f4_arg1]:setAlpha(0)
		f4_arg0.buttonLabels[f4_arg1]:setAlpha(0)
	end
	local f4_local2 = Engine.GetNumTextLines(f4_local1, CoD.fonts.Default, CoD.textSize.Default, 1000) * CoD.textSize.Default
	local f4_local3 = 5
	local f4_local4 = nil
	if f4_local0.labelJustifyV == "bottom" then
		f4_local4 = f4_local0.line.y0 * f4_arg3 - f4_local2 + f4_local3
	elseif f4_local0.labelJustifyV == "top" then
		f4_local4 = f4_local0.line.y0 * f4_arg3 + f4_local3
	else
		f4_local4 = f4_local0.line.y0 * f4_arg3 - f4_local2 / 2
	end
	f4_arg0.buttonLabels[f4_arg1]:setTopBottom(true, false, f4_local4, f4_local4 + CoD.textSize.Default)
	if f4_arg1 == "HINT" then
		if f4_arg2 == "" then
			f4_arg0.hintArrow:setAlpha(0)
		else
			f4_arg0.hintArrow:setAlpha(1)
		end
	end
end

CoD.WiiUButtonLayout.UpdateButtonLinesAndLabels = function (f5_arg0, f5_arg1)
	local f5_local0 = tonumber(f5_arg1)
	local f5_local1 = nil
	if UIExpression.IsDemoPlaying(f5_arg0.controller) ~= 0 then
		f5_local1 = CoD.WiiUButtonLayout.TheaterButtonStrings[f5_local0][UIExpression.GetControllerType(f5_arg0.controller)]
	else
		f5_local1 = CoD.WiiUButtonLayout.ButtonStrings[f5_local0]
	end
	for f5_local5, f5_local6 in pairs(f5_local1) do
		f0_local2(f5_arg0, f5_local5, f5_local6)
	end
end

CoD.WiiUButtonLayout.HideButtonLinesAndLabels = function (f6_arg0, f6_arg1)
	for f6_local3, f6_local4 in pairs(CoD.WiiUButtonLayout.Labels[UIExpression.GetControllerType(f6_arg1)]) do
		f6_arg0.buttonLines[f6_local3]:setAlpha(0)
		f6_arg0.buttonLabels[f6_local3]:setAlpha(0)
	end
end

CoD.WiiUButtonLayout.StickPlacement = {
	classic = {
		leftStick = {
			x = -155,
			y = 6,
			width = 160,
			height = 160
		},
		rightStick = {
			x = -4,
			y = 6,
			width = 160,
			height = 160
		},
		upperLeftText = {
			x = -75,
			y = -62,
			width = 0,
			alignment = LUI.Alignment.Center
		},
		lowerLeftText = {
			x = -192,
			y = 176,
			width = 235,
			alignment = LUI.Alignment.Center
		},
		leftText = {
			x = -395,
			y = 54,
			width = 150,
			alignment = LUI.Alignment.Right
		},
		upperRightText = {
			x = 70,
			y = -62,
			width = 0,
			alignment = LUI.Alignment.Center
		},
		lowerRightText = {
			x = -40,
			y = 176,
			width = 235,
			alignment = LUI.Alignment.Center
		},
		rightText = {
			x = 245,
			y = 54,
			width = 150,
			alignment = LUI.Alignment.Left
		}
	},
	drc = {
		leftStick = {
			x = -275,
			y = -74,
			width = 160,
			height = 160
		},
		rightStick = {
			x = 116,
			y = -74,
			width = 160,
			height = 160
		},
		upperLeftText = {
			x = -220,
			y = -114,
			width = 0,
			alignment = LUI.Alignment.Right
		},
		lowerLeftText = {
			x = -312,
			y = 200,
			width = 235,
			alignment = LUI.Alignment.Center
		},
		leftText = {
			x = -440,
			y = -26,
			width = 150,
			alignment = LUI.Alignment.Right
		},
		upperRightText = {
			x = 220,
			y = -114,
			width = 0,
			alignment = LUI.Alignment.Left
		},
		lowerRightText = {
			x = 80,
			y = 200,
			width = 235,
			alignment = LUI.Alignment.Center
		},
		rightText = {
			x = 290,
			y = -26,
			width = 150,
			alignment = LUI.Alignment.Left
		}
	},
	uc = {
		leftStick = {
			x = -219,
			y = -78,
			width = 160,
			height = 160
		},
		rightStick = {
			x = 60,
			y = -78,
			width = 160,
			height = 160
		},
		upperLeftText = {
			x = -168,
			y = -138,
			width = 0,
			alignment = LUI.Alignment.Right
		},
		lowerLeftText = {
			x = -146,
			y = 87,
			width = 0,
			alignment = LUI.Alignment.Center
		},
		leftText = {
			x = -384,
			y = -30,
			width = 150,
			alignment = LUI.Alignment.Right
		},
		upperRightText = {
			x = 168,
			y = -138,
			width = 0,
			alignment = LUI.Alignment.Left
		},
		lowerRightText = {
			x = 144,
			y = 87,
			width = 0,
			alignment = LUI.Alignment.Center
		},
		rightText = {
			x = 234,
			y = -30,
			width = 150,
			alignment = LUI.Alignment.Left
		}
	}
}
CoD.WiiUButtonLayout.PlaceStickLayoutElements = function (f7_arg0, f7_arg1)
	local f7_local0 = CoD.WiiUButtonLayout.StickPlacement[UIExpression.GetControllerType(f7_arg1)]
	f7_arg0.stickLayoutImageContainer.leftStickImage:setLeftRight(false, false, f7_local0.leftStick.x, f7_local0.leftStick.x + f7_local0.leftStick.width)
	f7_arg0.stickLayoutImageContainer.leftStickImage:setTopBottom(false, false, f7_local0.leftStick.y, f7_local0.leftStick.y + f7_local0.leftStick.height)
	f7_arg0.stickLayoutImageContainer.rightStickImage:setLeftRight(false, false, f7_local0.rightStick.x, f7_local0.rightStick.x + f7_local0.rightStick.width)
	f7_arg0.stickLayoutImageContainer.rightStickImage:setTopBottom(false, false, f7_local0.rightStick.y, f7_local0.rightStick.y + f7_local0.rightStick.height)
	local f7_local1 = CoD.textSize.Condensed
	f7_arg0.stickLayoutImageContainer.textUL:setLeftRight(false, false, f7_local0.upperLeftText.x, f7_local0.upperLeftText.x + f7_local0.upperLeftText.width)
	f7_arg0.stickLayoutImageContainer.textUL:setTopBottom(false, false, f7_local0.upperLeftText.y, f7_local0.upperLeftText.y + f7_local1)
	f7_arg0.stickLayoutImageContainer.textUL:setAlignment(f7_local0.upperLeftText.alignment)
	f7_arg0.stickLayoutImageContainer.textUL:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f7_arg0.stickLayoutImageContainer.textLL:setLeftRight(false, false, f7_local0.lowerLeftText.x, f7_local0.lowerLeftText.x + f7_local0.lowerLeftText.width)
	f7_arg0.stickLayoutImageContainer.textLL:setTopBottom(false, false, f7_local0.lowerLeftText.y, f7_local0.lowerLeftText.y + f7_local1)
	f7_arg0.stickLayoutImageContainer.textLL:setAlignment(f7_local0.lowerLeftText.alignment)
	f7_arg0.stickLayoutImageContainer.textLL:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f7_arg0.stickLayoutImageContainer.textL:setLeftRight(false, false, f7_local0.leftText.x, f7_local0.leftText.x + f7_local0.leftText.width)
	f7_arg0.stickLayoutImageContainer.textL:setTopBottom(false, false, f7_local0.leftText.y, f7_local0.leftText.y + f7_local1)
	f7_arg0.stickLayoutImageContainer.textL:setAlignment(f7_local0.leftText.alignment)
	f7_arg0.stickLayoutImageContainer.textL:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f7_arg0.stickLayoutImageContainer.textUR:setLeftRight(false, false, f7_local0.upperRightText.x, f7_local0.upperRightText.x + f7_local0.upperRightText.width)
	f7_arg0.stickLayoutImageContainer.textUR:setTopBottom(false, false, f7_local0.upperRightText.y, f7_local0.upperRightText.y + f7_local1)
	f7_arg0.stickLayoutImageContainer.textUR:setAlignment(f7_local0.upperRightText.alignment)
	f7_arg0.stickLayoutImageContainer.textUR:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f7_arg0.stickLayoutImageContainer.textLR:setLeftRight(false, false, f7_local0.lowerRightText.x, f7_local0.lowerRightText.x + f7_local0.lowerRightText.width)
	f7_arg0.stickLayoutImageContainer.textLR:setTopBottom(false, false, f7_local0.lowerRightText.y, f7_local0.lowerRightText.y + f7_local1)
	f7_arg0.stickLayoutImageContainer.textLR:setAlignment(f7_local0.lowerRightText.alignment)
	f7_arg0.stickLayoutImageContainer.textLR:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f7_arg0.stickLayoutImageContainer.textR:setLeftRight(false, false, f7_local0.rightText.x, f7_local0.rightText.x + f7_local0.rightText.width)
	f7_arg0.stickLayoutImageContainer.textR:setTopBottom(false, false, f7_local0.rightText.y, f7_local0.rightText.y + f7_local1)
	f7_arg0.stickLayoutImageContainer.textR:setAlignment(f7_local0.rightText.alignment)
	f7_arg0.stickLayoutImageContainer.textR:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
end

CoD.WiiUButtonLayout.RTSControlMenuParams = {
	remote = {
		material = "wiiu_remote_top"
	},
	classic = {
		material = "wiiu_ccp_top"
	},
	drc = {
		material = "wiiu_drc_top"
	},
	uc = {
		material = "wiiu_uc_top"
	}
}
CoD.WiiUButtonLayout.RTSCustomControlBinds = {
	throw_tacticals = {
		label = Engine.Localize("SO_RTS_ISSUE_COMMANDS_CAPS"),
		input = "PLATFORM_CURBIND_SMOKE"
	},
	inventory = {
		label = Engine.Localize("SO_RTS_SELECT_SQUADS_CAPS"),
		input = "PLATFORM_CURBIND_INVENTORY"
	},
	scoreboard = {
		label = Engine.Localize("SO_RTS_TACTICAL_VIEW_CAPS"),
		input = "PLATFORM_CURBIND_TOGGLESCORES"
	}
}
local f0_local3 = function (f8_arg0, f8_arg1)
	local f8_local0 = UIExpression.GetControllerType(controller)
	f8_arg0.controllerImage:setImage(RegisterMaterial(CoD.WiiUButtonLayout.RTSControlMenuParams[f8_local0].material))
	for f8_local4, f8_local5 in pairs(CoD.WiiUButtonLayout.RTSControlMenuParams) do
		f8_arg0.linesAndLabelsForController[f8_local4]:setAlpha(0)
	end
	f8_local1 = f8_arg0.linesAndLabelsForController[f8_local0]
	f8_local1:setAlpha(1)
	f8_local2 = CoD.WiiUButtonLayout.RTSControlMenuParams[f8_local0]
	for f8_local7, f8_local8 in pairs(CoD.WiiUButtonLayout.Labels[f8_local0]) do
		f8_local1.buttonLines[f8_local7]:setAlpha(0)
		f8_local1.buttonLabels[f8_local7]:setText("")
	end
	if f8_local1.hintArrow ~= nil then
		f8_local1.hintArrow:setAlpha(0)
	end
	f8_local4 = UIExpression.ProfileInt(f8_arg0.controller, "gpad_remoteButtonsConfig")
	if f8_local0 == "remote" and f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_CUSTOM then
		f8_arg0.controllerImage:setAlpha(0)
		f8_arg0.customBindList:setAlpha(1)
	else
		f8_arg0.controllerImage:setAlpha(1)
		if f8_local0 == "classic" then
			f8_local5 = UIExpression.ProfileInt(f8_arg0.controller, "gpad_classicButtonsConfig")
			if f8_local5 == CoD.WiiUControllerSettings.CLASSIC_ROMEO or f8_local5 == CoD.WiiUControllerSettings.CLASSIC_TANGO then
				f0_local2(f8_local1, "BUTTON_R", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			elseif f8_local5 == CoD.WiiUControllerSettings.CLASSIC_SIERRA or f8_local5 == CoD.WiiUControllerSettings.CLASSIC_UNIFORM then
				f0_local2(f8_local1, "BUTTON_L", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			elseif f8_local5 == CoD.WiiUControllerSettings.CLASSIC_VICTOR or f8_local5 == CoD.WiiUControllerSettings.CLASSIC_ZERO then
				f0_local2(f8_local1, "BUTTON_L_AND_R", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			elseif f8_local5 == CoD.WiiUControllerSettings.CLASSIC_WHISKEY then
				f0_local2(f8_local1, "BUTTON_ZL_AND_ZR", "SO_RTS_ISSUE_COMMANDS_CAPS", f8_local1.scale)
			end
			f0_local2(f8_local1, "BUTTON_MINUS", "SO_RTS_TACTICAL_VIEW_CAPS", f8_local1.scale)
			f0_local2(f8_local1, "BUTTON_LEFT", "SO_RTS_SELECT_SQUADS_TWO_LINES_CAPS", f8_local1.scale)
		elseif f8_local0 == "remote" then
			if f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_ALPHA or f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_CHARLIE then
				f0_local2(f8_local1, "BUTTON_MINUS", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			elseif f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_BRAVO or f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_DELTA or f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_ECHO then
				f0_local2(f8_local1, "BUTTON_PLUS", "SO_RTS_ISSUE_COMMANDS_TWIST_WIIU_REMOTE_CAPS", f8_local1.scale)
			elseif f8_local4 == CoD.WiiUControllerSettings.WIIUMOTE_FOXTROT then
				f0_local2(f8_local1, "BUTTON_UP", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			end
			f0_local2(f8_local1, "BUTTON_2", "SO_RTS_TACTICAL_VIEW_CAPS", f8_local1.scale)
			f0_local2(f8_local1, "BUTTON_LEFT_RTS", "SO_RTS_SELECT_SQUADS_TWO_LINES_CAPS", f8_local1.scale)
		else
			if UIExpression.ProfileInt(f8_arg0.controller, "gpad_buttonsConfig") == CoD.WiiUControllerSettings.GAMEPAD_LEFTY then
				f0_local2(f8_local1, "BUTTON_R", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			else
				f0_local2(f8_local1, "BUTTON_L", "SO_RTS_ISSUE_COMMANDS_TWO_LINES_CAPS", f8_local1.scale)
			end
			f0_local2(f8_local1, "BUTTON_MINUS", "SO_RTS_TACTICAL_VIEW_CAPS", f8_local1.scale)
			f0_local2(f8_local1, "BUTTON_DPAD", "SO_RTS_SELECT_SQUADS_TWO_LINES_CAPS", f8_local1.scale)
		end
	end
end

local f0_local4 = function (f9_arg0, f9_arg1)
	local f9_local0 = CoD.WiiUButtonLayout.RTSCustomControlBinds[f9_arg1]
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	local f9_local2 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 180,
		right = 600,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f9_local2:setText(f9_local0.label)
	Widget:addElement(f9_local2)
	local f9_local3 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 500,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = CoD.ButtonTextColor.r,
		green = CoD.ButtonTextColor.g,
		blue = CoD.ButtonTextColor.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f9_local3:setText(Engine.Localize(f9_local0.input))
	Widget:addElement(f9_local3)
	f9_arg0:addElement(Widget)
end

CoD.WiiUButtonLayout.AddRTSControlElements = function (f10_arg0)
	f10_arg0.controller = 0
	local f10_local0 = 0.5
	local f10_local1 = 0.5
	local f10_local2 = f10_arg0.width * f10_local0
	local f10_local3 = f10_arg0.height * f10_local1
	local f10_local4 = 384
	local f10_local5 = 384
	local f10_local6 = LUI.UIImage.new()
	f10_local6:setTopBottom(true, false, f10_local3 - f10_local5 / 2, f10_local3 + f10_local5 / 2)
	f10_local6:setLeftRight(true, false, f10_local2 - f10_local4 / 2, f10_local2 + f10_local4 / 2)
	f10_arg0.controllerImage = f10_local6
	f10_arg0:addElement(f10_local6)
	local f10_local7 = f10_local4 / CoD.WiiUButtonLayout.ReferenceSize
	f10_arg0.linesAndLabelsForController = {}
	for f10_local14, f10_local15 in pairs(CoD.WiiUButtonLayout.RTSControlMenuParams) do
		local Widget = LUI.UIElement.new()
		Widget.scale = f10_local7
		Widget:setTopBottom(false, false, -58, 0)
		Widget.buttonLines = {}
		Widget.buttonLabels = {}
		Widget:setAlpha(0)
		f10_arg0.linesAndLabelsForController[f10_local14] = Widget
		f10_arg0:addElement(Widget)
		for f10_local11, f10_local12 in pairs(CoD.WiiUButtonLayout.Labels[f10_local14]) do
			f0_local1(Widget, f10_local11, f10_local12, f10_local7)
		end
	end
	f10_local8 = LUI.UIVerticalList.new()
	f10_local8:setLeftRight(true, true, 0, 0)
	f10_local8:setTopBottom(true, true, 160, 0)
	f10_local8:setSpacing(CoD.ButtonList.ButtonSpacing)
	f0_local4(f10_local8, "throw_tacticals")
	f0_local4(f10_local8, "inventory")
	f0_local4(f10_local8, "scoreboard")
	f10_local8:setAlpha(0)
	f10_arg0.customBindList = f10_local8
	f10_arg0:addElement(f10_local8)
	f10_arg0:registerEventHandler("controller_changed", f0_local3)
	f10_arg0:processEvent({
		name = "controller_changed",
		controller = f10_arg0.controller
	})
end

