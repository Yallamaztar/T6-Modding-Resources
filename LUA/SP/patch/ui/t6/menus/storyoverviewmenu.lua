require("T6.BorderLite")
CoD.StoryOverviewMenu = {}
CoD.StoryOverviewMenu.MapHighlight = ""
CoD.StoryOverviewMenu.ForceProgress = {}
CoD.StoryOverviewMenu.ForceProgress.war_singapore = false
CoD.StoryOverviewMenu.ForceProgress.war_afghanistan = false
CoD.StoryOverviewMenu.ForceProgress.war_drone = false
CoD.StoryOverviewMenu.ForceProgress.war_socotra = false
CoD.StoryOverviewMenu.ForceProgress.war_pakistan = false
local f0_local0 = {
	angola = {
		{
			success = "SPUI_ANGOLA_STORY_SUCCESS"
		}
	},
	myanmar = {
		{
			success = "SPUI_MYANMAR_STORY_SUCCESS"
		}
	},
	afghanistan = {
		{
			success = "SPUI_AFGHANISTAN_STORY_SUCCESS",
			failure = "SPUI_AFGHANISTAN_STORY_FAILURE",
			condition = {
				"KRAVCHENKO_INTERROGATED"
			}
		}
	},
	nicaragua = {
		{
			success = "SPUI_NICARAGUA_STORY_SUCCESS",
			failure = "SPUI_NICARAGUA_STORY_FAILURE",
			condition = {
				"FOUND_NICARAGUA_EASTEREGG"
			}
		}
	},
	pakistan = {
		{
			success = "SPUI_PAKISTAN_STORY_SUCCESS",
			failure = "SPUI_PAKISTAN_STORY_FAILURE",
			condition = {
				"ALL_PAKISTAN_RECORDINGS"
			}
		},
		{
			success = "SPUI_PAKISTAN_STORY_2_SUCCESS",
			failure = "SPUI_PAKISTAN_STORY_2_FAILURE",
			neg_condition = {
				"HARPER_SCARRED"
			}
		}
	},
	karma = {
		{
			success = "SPUI_KARMA_STORY_SUCCESS",
			condition = {
				"DEFALCO_DEAD_IN_KARMA"
			},
			neg_condition = {
				"KARMA_CAPTURED",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_KARMA_STORY_2_FAILURE",
			outcome = false,
			condition = {
				"KARMA_CAPTURED"
			},
			neg_condition = {
				"DEFALCO_DEAD_IN_KARMA",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_KARMA_STORY_3_FAILURE",
			outcome = false,
			condition = {
				"KARMA_DEAD_IN_KARMA"
			},
			neg_condition = {
				"DEFALCO_DEAD_IN_KARMA",
				"KARMA_CAPTURED"
			}
		}
	},
	panama = {
		{
			success = "SPUI_PANAMA_STORY_SUCCESS",
			failure = "SPUI_PANAMA_STORY_FAILURE",
			neg_condition = {
				"MASON_SR_DEAD"
			}
		},
		{
			success = "SPUI_PANAMA_STORY_2_SUCCESS",
			failure = "SPUI_PANAMA_STORY_2_FAILURE",
			condition = {
				"SO_WAR_SINGAPORE_SUCCESS",
				"SO_WAR_DRONE_SUCCESS",
				"SO_WAR_AFGHANISTAN_SUCCESS"
			}
		}
	},
	yemen = {
		{
			success = "SPUI_YEMEN_STORY_SUCCESS",
			failure = "SPUI_YEMEN_STORY_FAILURE",
			neg_condition = {
				"FARID_DEAD_IN_YEMEN"
			}
		},
		{
			success = "SPUI_YEMEN_STORY_2_SUCCESS",
			condition = {
				"SO_WAR_PAKISTAN_SUCCESS",
				"SO_WAR_SINGAPORE_SUCCESS",
				"SO_WAR_DRONE_SUCCESS",
				"SO_WAR_AFGHANISTAN_SUCCESS"
			}
		},
		{
			success = "SPUI_YEMEN_STORY_2_FAILURE",
			outcome = false,
			condition = {
				"SO_WAR_SINGAPORE_SUCCESS",
				"SO_WAR_DRONE_SUCCESS",
				"SO_WAR_AFGHANISTAN_SUCCESS"
			},
			neg_condition = {
				"SO_WAR_PAKISTAN_SUCCESS"
			}
		}
	},
	blackout = {
		{
			success = "SPUI_BLACKOUT_STORY_SUCCESS",
			failure = "SPUI_BLACKOUT_STORY_FAILURE",
			neg_condition = {
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_2_SUCCESS",
			failure = "SPUI_BLACKOUT_STORY_2_FAILURE",
			condition = {
				"SO_WAR_PAKISTAN_SUCCESS"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_3_SUCCESS",
			condition = {
				"SO_WAR_PAKISTAN_SUCCESS"
			},
			neg_condition = {
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_3_FAILURE",
			neg_condition = {
				"SO_WAR_PAKISTAN_SUCCESS",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_4_SUCCESS",
			condition = {
				"SO_WAR_PAKISTAN_SUCCESS",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_4_FAILURE",
			condition = {
				"BRIGGS_DEAD"
			},
			neg_condition = {
				"SO_WAR_PAKISTAN_SUCCESS"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_5_FAILURE",
			condition = {
				"KARMA_CAPTURED"
			},
			neg_condition = {
				"SO_WAR_SOCOTRA_SUCCESS",
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_6_SUCCESS",
			condition = {
				"FARID_DEAD_IN_COMMAND_CENTER"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"FARID_DEAD_IN_YEMEN",
				"KARMA_DEAD_IN_KARMA",
				"KARMA_CAPTURED"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_6_SUCCESS",
			condition = {
				"KARMA_CAPTURED",
				"SO_WAR_SOCOTRA_SUCCESS",
				"FARID_DEAD_IN_COMMAND_CENTER"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"FARID_DEAD_IN_YEMEN",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_6_FAILURE",
			condition = {
				"FARID_DEAD_IN_YEMEN",
				"KARMA_DEAD_IN_COMMAND_CENTER"
			},
			neg_condition = {
				"KARMA_CAPTURED",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_6_FAILURE",
			condition = {
				"FARID_DEAD_IN_YEMEN",
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"KARMA_CAPTURED",
				"SO_WAR_SOCOTRA_SUCCESS"
			},
			neg_condition = {
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_7_SUCCESS",
			condition = {
				"SO_WAR_PAKISTAN_SUCCESS"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"KARMA_DEAD_IN_KARMA",
				"KARMA_CAPTURED",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_7_SUCCESS",
			condition = {
				"KARMA_CAPTURED",
				"SO_WAR_PAKISTAN_SUCCESS",
				"SO_WAR_SOCOTRA_SUCCESS"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"KARMA_DEAD_IN_KARMA",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_7_FAILURE",
			condition = {
				"KARMA_CAPTURED",
				"SO_WAR_SOCOTRA_SUCCESS"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"SO_WAR_PAKISTAN_SUCCESS",
				"KARMA_DEAD_IN_KARMA",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_7_FAILURE",
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"SO_WAR_PAKISTAN_SUCCESS",
				"KARMA_CAPTURED",
				"KARMA_DEAD_IN_KARMA",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_8_SUCCESS",
			condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"SO_WAR_PAKISTAN_SUCCESS"
			},
			neg_condition = {
				"BRIGGS_DEAD",
				"KARMA_CAPTURED",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_8_SUCCESS",
			condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"SO_WAR_PAKISTAN_SUCCESS",
				"KARMA_CAPTURED",
				"SO_WAR_SOCOTRA_SUCCESS"
			},
			neg_condition = {
				"BRIGGS_DEAD",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_8_FAILURE",
			condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER"
			},
			neg_condition = {
				"SO_WAR_PAKISTAN_SUCCESS",
				"KARMA_DEAD_IN_KARMA",
				"BRIGGS_DEAD",
				"KARMA_CAPTURED"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_8_FAILURE",
			condition = {
				"KARMA_CAPTURED",
				"SO_WAR_SOCOTRA_SUCCESS",
				"KARMA_DEAD_IN_COMMAND_CENTER"
			},
			neg_condition = {
				"SO_WAR_PAKISTAN_SUCCESS",
				"KARMA_DEAD_IN_KARMA",
				"BRIGGS_DEAD"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_9_SUCCESS",
			condition = {
				"BRIGGS_DEAD"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"KARMA_DEAD_IN_KARMA",
				"KARMA_CAPTURED"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_9_SUCCESS",
			condition = {
				"SO_WAR_SOCOTRA_SUCCESS",
				"KARMA_CAPTURED",
				"BRIGGS_DEAD"
			},
			neg_condition = {
				"KARMA_DEAD_IN_COMMAND_CENTER",
				"KARMA_DEAD_IN_KARMA"
			}
		},
		{
			success = "SPUI_BLACKOUT_STORY_9_FAILURE",
			condition = {
				"BRIGGS_DEAD",
				"KARMA_DEAD_IN_COMMAND_CENTER"
			},
			neg_condition = {
				"KARMA_DEAD_IN_KARMA"
			}
		}
	},
	la = {
		{
			success = "SPUI_LA_STORY_SUCCESS"
		}
	},
	haiti = {
		{
			success = "SPUI_HAITI_STORY_2_SUCCESS",
			condition = {
				"MENENDEZ_CAPTURED"
			},
			neg_condition = {
				"MASONJR_DEAD_IN_HAITI"
			}
		},
		{
			success = "SPUI_HAITI_STORY_2_FAILURE",
			outcome = false,
			condition = {
				"MENENDEZ_DEAD_IN_HAITI"
			},
			neg_condition = {
				"MASONJR_DEAD_IN_HAITI"
			}
		}
	},
	war_singapore = {
		{
			success = "SPUI_WAR_SINGAPORE_STORY_SUCCESS",
			failure = "SPUI_WAR_SINGAPORE_STORY_FAILURE",
			progress = "SPUI_WAR_SINGAPORE_STORY_PROGRESS",
			condition = {
				"SO_WAR_SINGAPORE_SUCCESS"
			}
		}
	},
	war_afghanistan = {
		{
			success = "SPUI_WAR_AFGHANISTAN_STORY_SUCCESS",
			failure = "SPUI_WAR_AFGHANISTAN_STORY_FAILURE",
			progress = "SPUI_WAR_AFGHANISTAN_STORY_PROGRESS",
			condition = {
				"SO_WAR_AFGHANISTAN_SUCCESS"
			}
		}
	},
	war_drone = {
		{
			success = "SPUI_WAR_DRONE_STORY_SUCCESS",
			failure = "SPUI_WAR_DRONE_STORY_FAILURE",
			progress = "SPUI_WAR_DRONE_STORY_PROGRESS",
			condition = {
				"SO_WAR_DRONE_SUCCESS"
			}
		}
	},
	war_socotra = {
		{
			success = "SPUI_WAR_SOCOTRA_STORY_SUCCESS",
			condition = {
				"KARMA_CAPTURED",
				"SO_WAR_SOCOTRA_SUCCESS"
			}
		},
		{
			success = "SPUI_WAR_SOCOTRA_STORY_FAILURE",
			progress = "SPUI_WAR_SOCOTRA_STORY_PROGRESS",
			outcome = false,
			condition = {
				"KARMA_CAPTURED"
			},
			neg_condition = {
				"SO_WAR_SOCOTRA_SUCCESS"
			}
		}
	},
	war_pakistan = {
		{
			success = "SPUI_WAR_PAKISTAN_STORY_SUCCESS",
			condition = {
				"SO_WAR_SINGAPORE_SUCCESS",
				"SO_WAR_DRONE_SUCCESS",
				"SO_WAR_AFGHANISTAN_SUCCESS",
				"SO_WAR_PAKISTAN_SUCCESS"
			}
		},
		{
			success = "SPUI_WAR_PAKISTAN_STORY_FAILURE",
			progress = "SPUI_WAR_PAKISTAN_STORY_PROGRESS",
			outcome = false,
			condition = {
				"SO_WAR_SINGAPORE_SUCCESS",
				"SO_WAR_DRONE_SUCCESS",
				"SO_WAR_AFGHANISTAN_SUCCESS"
			},
			neg_condition = {
				"SO_WAR_PAKISTAN_SUCCESS"
			}
		}
	}
}
local f0_local1 = CoD.fonts.Condensed
local f0_local2 = CoD.textSize.Condensed
local f0_local3 = 1
local f0_local4 = 5
local f0_local5 = 2
local f0_local6 = CoD.fonts.Default
local f0_local7 = CoD.textSize.Default
local f0_local8 = 1
local f0_local9 = 5
local f0_local10 = 2
local f0_local11 = CoD.visorBlue1
local f0_local12 = 1
local f0_local13 = f0_local2 + f0_local12 * 2
local f0_local14 = 0
local f0_local15 = f0_local13 * 14
local f0_local16 = 830
local f0_local17 = {
	220,
	f0_local16 - 220 - f0_local13,
	f0_local13
}
local f0_local18 = 60 - f0_local13
local f0_local19, f0_local20, f0_local21, f0_local22, f0_local23, f0_local24, f0_local25, f0_local26, f0_local27, f0_local28, f0_local29, f0_local30, f0_local31, f0_local32, f0_local33, f0_local34, f0_local35 = nil
CoD.StoryOverviewMenu.new = function ()
	f0_local31()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f0_local18 + f0_local13 * 2, 0)
	Widget:addElement(f0_local27())
	UPVAL4 = 0
	local f1_local1 = f0_local26()
	f1_local1.tableIndex = 0
	f1_local1.rowSelect = false
	f0_local19(f1_local1)
	f0_local20(f1_local1)
	if not f1_local1.rowSelect then
		f1_local1:processEvent({
			name = "gain_focus"
		})
	end
	if f0_local15 < f0_local14 then
		UPVAL4 = f0_local15
	end
	f1_local1:setTopBottom(true, false, 0, f0_local14)
	Widget:addElement(f1_local1)
	return Widget
end

f0_local33 = function ()
	local f2_local0 = UIExpression.GetPrimaryController()
	local f2_local1 = UIExpression.GetDStat(f2_local0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue") + 1
	local f2_local2 = LevelsTillYemen()
	local f2_local3 = f0_local32("SO_WAR_SINGAPORE_SUCCESS")
	local f2_local4 = f0_local32("SO_WAR_AFGHANISTAN_SUCCESS")
	local f2_local5 = f0_local32("SO_WAR_DRONE_SUCCESS")
	local f2_local6 = tonumber(UIExpression.TableLookup(f2_local0, CoD.AARUtility.LevelTable, 2, "war_pakistan", 14))
	local f2_local7 = f0_local32("SO_WAR_PAKISTAN_SUCCESS")
	if f2_local2 == 0 then
		local f2_local8
		if f2_local3 == 0 then
			f2_local8 = f2_local3
		elseif f2_local4 == 0 then
			f2_local8 = f2_local4
		else
			f2_local8 = f2_local5
		end
		if f2_local8 then
			local f2_local9 = f2_local6 <= f2_local1
			if f2_local7 then
				return true, true
			elseif f2_local9 then
				return true, false
			else
				return false, false
			end
		else
			return true, false
		end
	else
		return false, false
	end
end

f0_local32 = function (f3_arg0)
	return UIExpression.GetDStat(UIExpression.GetPrimaryController(), "PlayerCareerStats", "storypoints", f3_arg0) == 1
end

f0_local31 = function ()
	CoD.StoryOverviewMenu.ForceProgress.war_singapore = f0_local32("MENU_SO_WAR_SINGAPORE")
	CoD.StoryOverviewMenu.ForceProgress.war_afghanistan = f0_local32("MENU_SO_WAR_AFGHANISTAN")
	CoD.StoryOverviewMenu.ForceProgress.war_drone = f0_local32("MENU_SO_WAR_DRONE")
	CoD.StoryOverviewMenu.ForceProgress.war_socotra = f0_local32("MENU_SO_WAR_SOCOTRA")
	CoD.StoryOverviewMenu.ForceProgress.war_pakistan = f0_local32("MENU_SO_WAR_PAKISTAN")
end

f0_local27 = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f0_local16 / 2, f0_local16 / 2)
	Widget:setTopBottom(true, true, -f0_local13, 0)
	local f5_local1 = LUI.UIText.new()
	f5_local1:setLeftRight(true, false, f0_local9, f0_local17[1])
	f5_local1:setTopBottom(true, false, f0_local10, f0_local7 + f0_local10)
	f5_local1:setFont(f0_local6)
	f5_local1:setAlignment(LUI.Alignment.Left)
	f5_local1:setAlpha(f0_local8)
	f5_local1:setRGB(f0_local11.r, f0_local11.g, f0_local11.b)
	f5_local1:setText(Engine.Localize("MENU_LEVEL_NAME_CAPS"))
	Widget:addElement(f5_local1)
	local f5_local2 = LUI.UIText.new()
	f5_local2:setLeftRight(true, true, f0_local17[1], 0)
	f5_local2:setTopBottom(true, false, f0_local10, f0_local7 + f0_local10)
	f5_local2:setFont(f0_local6)
	f5_local2:setAlignment(LUI.Alignment.Left)
	f5_local2:setAlpha(f0_local8)
	f5_local2:setRGB(f0_local11.r, f0_local11.g, f0_local11.b)
	f5_local2:setText(Engine.Localize("MENU_OUTCOME_CAPS"))
	Widget:addElement(f5_local2)
	local f5_local3 = LUI.UIImage.new()
	f5_local3:setLeftRight(true, true, 0, 0)
	f5_local3:setTopBottom(true, true, 0, 0)
	f5_local3:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f5_local3:setRGB(CoD.black.r, CoD.black.g, CoD.black.b)
	f5_local3:setAlpha(0.2)
	Widget:addElement(f5_local3)
	return Widget
end

f0_local24 = function (f6_arg0, f6_arg1)
	local f6_local0 = {}
	local f6_local1 = {}
	local f6_local2 = f0_local0[f6_arg0]
	if f6_local2 ~= nil then
		for f6_local3 = 1, #f6_local2, 1 do
			local f6_local6, f6_local7 = f0_local25(f6_local2[f6_local3], f6_arg1)
			if f6_local6 ~= nil and f6_local7 ~= nil then
				table.insert(f6_local0, f6_local6)
				table.insert(f6_local1, f6_local7)
			end
		end
	end
	return f6_local0, f6_local1
end

f0_local25 = function (f7_arg0, f7_arg1)
	local f7_local0, f7_local1 = nil
	if f7_arg0 ~= nil then
		if f7_arg0.condition ~= nil then
			for f7_local2 = 1, #f7_arg0.condition, 1 do
				local f7_local5 = f0_local32(f7_arg0.condition[f7_local2])
				if f7_local5 ~= nil then
					if f7_local1 == nil then
						f7_local1 = f7_local5
					end
					if f7_local1 then
						f7_local1 = f7_local5
					end
				end
				error("PlayerStoryStat "" .. f7_arg0.condition[f7_local2] .. "" does not exist")
			end
		end
		if f7_arg0.neg_condition ~= nil then
			for f7_local2 = 1, #f7_arg0.neg_condition, 1 do
				local f7_local5 = f0_local32(f7_arg0.neg_condition[f7_local2])
				if f7_local5 ~= nil then
					if f7_local1 == nil then
						f7_local1 = not f7_local5
					end
					if f7_local1 then
						f7_local1 = not f7_local5
					end
				end
				error("PlayerStoryStat "" .. f7_arg0.neg_condition[f7_local2] .. "" does not exist")
			end
		end
	end
	if f7_local1 == nil and f7_arg0.success ~= nil then
		f7_local0 = f7_arg0.success
		f7_local1 = true
	elseif f7_local1 == nil and f7_arg0.failure ~= nil then
		f7_local0 = f7_arg0.failure
		f7_local1 = false
	elseif f7_local1 and f7_arg0.success ~= nil then
		if f7_arg1 and f7_arg0.progress then
			f7_local0 = f7_arg0.progress
		else
			f7_local0 = f7_arg0.success
		end
	elseif not f7_local1 and f7_arg0.failure ~= nil then
		if f7_arg1 and f7_arg0.progress then
			f7_local0 = f7_arg0.progress
		else
			f7_local0 = f7_arg0.failure
		end
	end
	if f7_arg0.outcome ~= nil then
		f7_local1 = f7_arg0.outcome
	end
	return f7_local0, f7_local1
end

f0_local26 = function ()
	local f8_local0 = CoD.ScrollingVerticalList.new()
	f8_local0:setLeftRight(false, false, -f0_local16 / 2, f0_local16 / 2)
	f8_local0:setTopBottom(true, true, 0, -f0_local13 * 1.5)
	f8_local0.verticalList.disableWrapping = true
	f8_local0.scrollbar:close()
	
	local scrollbar = CoD.VerticalScrollbar.new(f8_local0.verticalList, 0.2, 0.2, 0.2, 1)
	f8_local0:addElement(scrollbar)
	f8_local0.scrollbar = scrollbar
	
	return f8_local0
end

f0_local34 = function (f9_arg0)
	f9_arg0:setBorderAlpha(0)
end

f0_local35 = function (f10_arg0)
	CoD.StoryOverviewMenu.MapHighlight = f10_arg0.levelName
	f10_arg0:setBorderAlpha(1)
end

f0_local19 = function (f11_arg0)
	local f11_local0 = UIExpression.GetPrimaryController()
	local f11_local1 = UIExpression.GetDStat(f11_local0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue")
	local f11_local2 = UIExpression.TableLookup(f11_local0, CoD.AARUtility.LevelTable, 1, CoD.StoryOverviewMenu.MapHighlight, 2)
	for f11_local8, f11_local9 in ipairs(CoD.AARUtility.MapList) do
		if f11_local9.levelNum and tonumber(f11_local9.levelNum) <= f11_local1 and not f11_local9.isDevLevel and not f11_local9.isRTSMap and not f11_local9.isTutMap then
			local f11_local6, f11_local7 = f0_local24(f11_local9.alias)
			if #f11_local6 > 0 and #f11_local7 > 0 then
				f11_arg0.tableIndex = f11_arg0.tableIndex + 1
				f11_arg0:addElementToList(f0_local28(f11_local9, f11_local6, f11_local7))
				if f11_local9.name == f11_local2 or f11_local9.alias == f11_local2 then
					f11_arg0.rowSelect = true
					f11_arg0.verticalList:selectElementIndex(f11_arg0.tableIndex)
				end
			end
		end
	end
end

f0_local22 = function (f12_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f0_local13 * 2)
	UPVAL1 = f0_local14 + f0_local13 * 2
	local f12_local1 = LUI.UIText.new()
	f12_local1:setLeftRight(true, true, 0, 0)
	f12_local1:setTopBottom(false, true, -f0_local7, 0)
	f12_local1:setFont(f0_local6)
	f12_local1:setAlignment(LUI.Alignment.Left)
	f12_local1:setAlpha(f0_local8)
	f12_local1:setRGB(f0_local11.r, f0_local11.g, f0_local11.b)
	f12_local1:setText(Engine.Localize("MENU_STRIKE_FORCE_CAPS"))
	Widget:addElement(f12_local1)
	f0_local23(Widget)
	f0_local21(Widget)
	f12_arg0:addElementToList(Widget)
	return Widget
end

function LevelsTillYemen()
	local f13_local0 = UIExpression.GetPrimaryController()
	local f13_local1 = 0
	local f13_local2 = tonumber(UIExpression.GetDStat(f13_local0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue"))
	local f13_local3 = tonumber(UIExpression.TableLookup(f13_local0, CoD.AARUtility.LevelTable, 2, "yemen", 0))
	for f13_local7, f13_local8 in ipairs(CoD.AARUtility.MapList) do
		if not f13_local8.isDevLevel and not f13_local8.isTutMap and not f13_local8.isRTSMap and f13_local2 < f13_local8.levelNum and f13_local8.levelNum < f13_local3 then
			f13_local1 = f13_local1 + 1
		end
	end
	return f13_local1
end

f0_local21 = function (f14_arg0)
	local f14_local0, f14_local1 = f0_local33()
	local f14_local2 = LUI.UIText.new()
	f14_local2:setLeftRight(true, true, f0_local17[1], 0)
	f14_local2:setTopBottom(false, true, -f0_local7, 0)
	f14_local2:setFont(f0_local6)
	f14_local2:setAlignment(LUI.Alignment.Left)
	f14_local2:setAlpha(f0_local8)
	if f14_local0 then
		if f14_local1 then
			f14_local2:setText(Engine.Localize("MENU_RTS_COMPLETE_CAPS"))
			f14_local2:setRGB(CoD.RTSColors.blue.r, CoD.RTSColors.blue.g, CoD.RTSColors.blue.b)
		else
			f14_local2:setText(Engine.Localize("MENU_RTS_FAILED_CAPS"))
			f14_local2:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
		end
	end
	f14_arg0:addElement(f14_local2)
end

f0_local23 = function (f15_arg0)
	local f15_local0 = LevelsTillYemen()
	local f15_local1 = nil
	local f15_local2 = LUI.UIText.new()
	f15_local2:setLeftRight(true, true, f0_local17[1], 0)
	f15_local2:setTopBottom(false, true, -f0_local7, 0)
	f15_local2:setFont(f0_local6)
	f15_local2:setAlignment(LUI.Alignment.Left)
	f15_local2:setAlpha(f0_local8)
	if f15_local0 > 1 then
		f15_local2:setRGB(f0_local11.r, f0_local11.g, f0_local11.b)
		f15_local2:setText(Engine.Localize("MENU_STRIKE_FORCE_WARNINGS", f15_local0))
	elseif f15_local0 == 1 then
		f15_local1 = LUI.UITimer.new(30, "glow_text", false, f15_local2)
		f15_arg0:addElement(f15_local1)
		f15_local2:registerEventHandler("glow_text", f0_local29)
		f15_local2:setAlpha(0.75)
		f15_local2.alpha = 0.75
		f15_local2.maxAlpha = 1
		f15_local2.minAlpha = 0.25
		f15_local2.glowRate = 0.05
		f15_local2:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
		f15_local2:setText(Engine.Localize("MENU_STRIKE_FORCE_WARNING"))
	end
	f15_arg0.warningTimer = f15_local1
	f15_arg0.warningText = f15_local2
	f15_arg0:addElement(f15_local2)
end

f0_local29 = function (f16_arg0, f16_arg1)
	if f16_arg0.disable ~= nil and f16_arg0.disable then
		f16_arg0:setAlpha(0)
		return 
	elseif f16_arg0.glowRate == nil then
		f16_arg0.glowRate = 0
	end
	local f16_local0 = f16_arg0.alpha + f16_arg0.glowRate
	if f16_arg0.maxAlpha <= f16_local0 or f16_local0 <= f16_arg0.minAlpha then
		f16_arg0.glowRate = f16_arg0.glowRate * -1
	end
	f16_arg0.alpha = f16_local0
	f16_arg0:setAlpha(f16_local0)
end

f0_local20 = function (f17_arg0)
	local f17_local0 = Dvar.ui_mapname:get()
	local f17_local1 = UIExpression.GetPrimaryController()
	local f17_local2 = UIExpression.GetDStat(f17_local1, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue")
	local f17_local3 = false
	local f17_local4 = true
	local f17_local5 = nil
	local f17_local6 = UIExpression.TableLookup(f17_local1, CoD.AARUtility.LevelTable, 1, CoD.StoryOverviewMenu.MapHighlight, 2)
	for f17_local20, f17_local21 in ipairs(CoD.AARUtility.MapList) do
		Dvar.ui_mapname:set(f17_local21.name)
		if f17_local21.isRTSMap == true and f17_local21.rtsEnd ~= nil then
			local f17_local10 = UIExpression.GetDStat(f17_local1, "PlayerCareerStats", "storypoints", "SO_" .. f17_local21.alias .. "_INTRO") == 1
			local f17_local11 = UIExpression.GetDStat(f17_local1, "PlayerCareerStats", "storypoints", "SO_WAR_TUTORIAL_COMPLETE") == 1
			local f17_local12 = UIExpression.GetDStat(f17_local1, "PlayerCareerStats", "storypoints", "SO_" .. f17_local21.alias .. "_SUCCESS") == 1
			local f17_local13 = tonumber(f17_local21.rtsEnd) <= f17_local2 + 1
			local f17_local14 = tonumber(f17_local21.rtsStart + 1) <= f17_local2
			local f17_local15 = tonumber(f17_local21.rtsStart) <= f17_local2
			local f17_local16
			if not f17_local10 then
				f17_local16 = CoD.StoryOverviewMenu.ForceProgress[f17_local21.alias]
				if f17_local16 then

				else
					local f17_local17
					if not f17_local13 then
						if not f17_local16 and f17_local14 == 0 then
							f17_local17 = f17_local14
						else
							f17_local17 = not f17_local12
						end
					else
						f17_local17 = false
					end
					if f17_local17 then
						f17_local4 = false
					end
					if f17_local11 and (f17_local13 or f17_local14 or f17_local16) then
						if not f17_local3 then
							f17_local5 = f0_local22(f17_arg0)
							f17_local3 = true
						end
						local f17_local18, f17_local19 = f0_local24(f17_local21.alias, f17_local17)
						if #f17_local18 > 0 and #f17_local19 > 0 then
							f17_arg0.tableIndex = f17_arg0.tableIndex + 1
							f17_arg0:addElementToList(f0_local28(f17_local21, f17_local18, f17_local19))
							if f17_local21.name == f17_local6 or f17_local21.alias == f17_local6 then
								f17_arg0.rowSelect = true
								f17_arg0.verticalList:selectElementIndex(f17_arg0.tableIndex)
							end
						end
					end
				end
			end
			f17_local16 = f17_local15
		end
	end
	Dvar.ui_mapname:set(f17_local0)
	if f17_local4 and f17_local5 ~= nil and f17_local5.warningText ~= nil then
		f17_local5.warningText:close()
		if f17_local5.warningTimer ~= nil then
			f17_local5.warningTimer:close()
		end
	end
	return f17_local4
end

f0_local30 = function (f18_arg0, f18_arg1)
	f18_arg0:dispatchEventToParent({
		name = "proceed_to_mision"
	})
end

f0_local28 = function (f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = nil
	local f19_local1 = 0.5
	local f19_local2 = f0_local13
	local f19_local3 = math.floor((f19_local2 - math.floor(f19_local2 * 0.5)) / 2)
	local f19_local4 = 0
	for f19_local5 = 1, #f19_arg1, 1 do
		local f19_local8, f19_local9, f19_local10, f19_local11 = GetTextDimensions(Engine.Localize(f19_arg1[f19_local5]), f0_local1, f0_local2)
		if f0_local17[2] < f19_local10 then
			f19_local4 = f19_local4 + f0_local13 + f0_local13
		else
			f19_local4 = f19_local4 + f0_local13
		end
	end
	local f19_local5 = Engine.Localize("SPUI_" .. f19_arg0.alias .. "_MISSION_NAME")
	local f19_local6, f19_local7, f19_local12, f19_local8 = GetTextDimensions(f19_local5, f0_local1, f0_local2)
	if f0_local17[1] < f19_local12 + f0_local4 and f19_local4 == f0_local13 then
		f19_local4 = f0_local13 * 2
	end
	f19_local0 = CoD.CoD9Button.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f19_local4
	})
	f19_local0.levelName = f19_arg0.name
	f19_local0:registerEventHandler("button_action", f0_local30)
	CoD.BorderLite.new(f19_local0, 1, CoD.white.r / 3, CoD.white.g / 3, CoD.white.b / 3, 0, 0)
	f19_local0:registerEventHandler("button_up", f0_local34)
	f19_local0:registerEventHandler("button_over", f0_local35)
	local f19_local10 = LUI.UIImage.new()
	f19_local10:setLeftRight(true, true, 0, -f19_local2)
	f19_local10:setTopBottom(true, true, f0_local12, -f0_local12)
	f19_local10:setRGB(1, 1, 1)
	f19_local10:setAlpha(0.05)
	f19_local0:addElement(f19_local10)
	local f19_local11 = LUI.UIText.new()
	f19_local11:setLeftRight(true, false, f0_local4, f0_local17[1])
	f19_local11:setTopBottom(true, false, f0_local5, f0_local5 + f0_local2)
	f19_local11:setFont(f0_local1)
	f19_local11:setAlignment(LUI.Alignment.Left)
	f19_local11:setAlpha(f0_local3)
	f19_local11:setText(f19_local5)
	f19_local0:addElement(f19_local11)
	local f19_local13 = LUI.UIImage.new()
	f19_local13:setLeftRight(false, true, -f19_local2, 0)
	f19_local13:setTopBottom(true, true, f0_local12, -f0_local12)
	f19_local13:setRGB(1, 1, 1)
	f19_local13:setAlpha(0.09)
	f19_local0:addElement(f19_local13)
	local f19_local14 = 0
	for f19_local15 = 1, #f19_arg1, 1 do
		local f19_local18, f19_local19, f19_local20, f19_local21 = GetTextDimensions(Engine.Localize(f19_arg1[f19_local15]), f0_local1, f0_local2)
		if f19_local15 ~= 1 then
			f19_local14 = f19_local14 + f0_local13
		end
		UPVAL11 = f0_local14 + f0_local13
		local f19_local22 = LUI.UIText.new()
		f19_local22:setLeftRight(true, true, f0_local17[1], -f0_local17[3])
		f19_local22:setTopBottom(true, false, f19_local14 + f0_local12, f19_local14 + f0_local13 - f0_local12)
		f19_local22:setFont(f0_local1)
		f19_local22:setAlignment(LUI.Alignment.Left)
		f19_local22:setAlpha(f0_local3)
		f19_local22:setText(Engine.Localize(f19_arg1[f19_local15]))
		f19_local0:addElement(f19_local22)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -(f19_local2 - f19_local3), -f19_local3)
		Widget:setTopBottom(true, false, f19_local14 + f19_local3, f19_local14 + f0_local13 - f19_local3)
		f19_local0:addElement(Widget)
		local f19_local24 = LUI.UIImage.new()
		f19_local24:setLeftRight(true, true, 0, 0)
		f19_local24:setTopBottom(true, true, 0, 0)
		f19_local24:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		Widget:addElement(f19_local24)
		if f0_local17[2] < f19_local20 then
			f19_local14 = f19_local14 + f0_local13
			UPVAL11 = f0_local14 + f0_local13
		end
	end
	return f19_local0
end

