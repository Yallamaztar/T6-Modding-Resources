local f0_local0 = {
	INVALID = 0,
	PUBLIC = 1,
	LEAGUE = 2,
	LOBBY_MERGE = 3,
	DEDICATED_SERVER = 4
}
local f0_local1 = {
	NORMAL = 0,
	BEST = 1,
	ANY = 2
}
local f0_local2 = {
	mode = -1,
	stage = -1
}
local f0_local3 = function (f1_arg0)
	Dvar.searchSessionIsEmpty:set(f1_arg0)
end

local f0_local4 = function (f2_arg0)
	Dvar.searchSessionGeo1Weight:set(f2_arg0)
	Dvar.searchSessionGeo2Weight:set(f2_arg0)
	Dvar.searchSessionGeo3Weight:set(f2_arg0)
	Dvar.searchSessionGeo4Weight:set(f2_arg0)
end

local f0_local5 = function (f3_arg0)
	Dvar.searchSessionGeo4Weight:set(f3_arg0)
	Dvar.searchSessionGeo3Weight:set(f3_arg0 * 2)
	Dvar.searchSessionGeo2Weight:set(f3_arg0 * 3)
	Dvar.searchSessionGeo1Weight:set(f3_arg0 * 4)
end

local f0_local6 = function (f4_arg0)
	Dvar.searchSessionMapPackFlags:set(f4_arg0)
end

local f0_local7 = function ()
	f0_local6(65535)
end

local f0_local8 = function ()
	f0_local6(2)
end

local f0_local9 = function (f7_arg0)
	Dvar.searchSessionSkillWeight:set(f7_arg0)
end

local f0_local10 = function (f8_arg0)
	Dvar.searchSessionNextTaskDelay:set(f8_arg0 * 1000)
end

local f0_local11 = function (f9_arg0, f9_arg1)
	Dvar.qosPreferredPing:set(f9_arg0)
	Dvar.qosMaxAllowedPing:set(f9_arg1)
end

local f0_local12 = function (f10_arg0)
	Dvar.searchSessionGeoMin:set(f10_arg0)
end

local f0_local13 = function (f11_arg0)
	return Engine.GetProfileVarInt(f11_arg0, "geographicalMatchmaking")
end

local f0_local14 = function (f12_arg0)
	return Engine.GetProfileVarInt(f12_arg0, "PreferredPing")
end

function SetPreferredPing(f13_arg0, f13_arg1)
	return Engine.SetProfileVar(f13_arg0, "PreferredPing", f13_arg1)
end

function FixPreferredPing(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = f0_local14(f14_arg0)
	if f14_local0 < f14_arg1 or f14_arg2 < f14_local0 then
		local f14_local1 = f0_local13(f14_arg0)
		if f14_local1 == f0_local1.BEST then
			f14_local0 = Dvar.excellentPing:get()
		elseif f14_local1 == f0_local1.NORMAL then
			f14_local0 = Dvar.goodPing:get()
		elseif f14_local1 == f0_local1.ANY then
			f14_local0 = f14_arg2
		end
		if f14_local0 < f14_arg1 or f14_arg2 < f14_local0 then
			f14_local0 = 150
		end
		SetPreferredPing(f14_arg0, f14_local0)
		Engine.CommitProfileChanges(f14_arg0)
	end
end

local f0_local15 = function ()
	local f15_local0 = f0_local2.stage
	f0_local2.stage = f15_local0 + 1
	return f15_local0
end

local f0_local16 = function ()
	f0_local2.stage = 0
end

local f0_local17 = function (f17_arg0)
	local f17_local0 = f0_local15()
	local f17_local1 = f0_local13(f17_arg0)
	local f17_local2 = Dvar.excellentPing:get()
	local f17_local3 = Dvar.goodPing:get()
	local f17_local4 = Dvar.terriblePing:get()
	f0_local3(false)
	f0_local4(1)
	f0_local9(1)
	f0_local10(1 + f17_local0 * 3)
	f0_local7()
	if f17_local1 == f0_local1.BEST then
		f0_local11(1, f17_local2)
	elseif f17_local1 == f0_local1.NORMAL then
		f0_local11(f17_local2, f17_local3)
	else
		f0_local11(f17_local3, 999)
	end
	if Engine.SearchTime() > 45 and f17_local1 == f0_local1.NORMAL then
		f0_local11(f17_local3, f17_local4)
	end
	if f0_local2.mode == f0_local0.LOBBY_MERGE then
		if f17_local0 > 0 then
			return false
		else
			return true
		end
	elseif f0_local2.mode == f0_local0.PUBLIC then
		local f17_local5 = f17_local0 % 3
		if f17_local5 == 1 and f17_local1 == f0_local1.NORMAL then
			f0_local11(f17_local3, f17_local4)
			return true
		elseif f17_local5 == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

local f0_local18 = function (f18_arg0)
	local f18_local0 = f0_local15()
	local f18_local1 = f0_local13(f18_arg0)
	local f18_local2 = Dvar.excellentPing:get()
	local f18_local3 = Dvar.goodPing:get()
	local f18_local4 = Dvar.terriblePing:get()
	f0_local3(false)
	f0_local5(0.2)
	f0_local9(0.01)
	f0_local10(1 + f18_local0 * 3)
	f0_local7()
	if f18_local1 == f0_local1.BEST then
		f0_local11(1, f18_local2)
		f0_local12(1)
	elseif f18_local1 == f0_local1.NORMAL then
		f0_local11(f18_local2, f18_local3)
		f0_local12(1)
	else
		f0_local11(f18_local3, 999)
		f0_local12(0)
	end
	if Engine.SearchTime() > 45 and f18_local1 == f0_local1.NORMAL then
		f0_local11(f18_local3, f18_local4)
	end
	if f0_local2.mode == f0_local0.LOBBY_MERGE then
		if f18_local0 > 0 then
			return false
		else
			f0_local12(1)
			return true
		end
	elseif f0_local2.mode == f0_local0.DEDICATED_SERVER then
		if f18_local0 > 0 then
			return false
		else
			f0_local12(1)
			f0_local11(1, 100)
			f0_local3(true)
			f0_local9(0)
			return true
		end
	elseif f0_local2.mode == f0_local0.PUBLIC then
		local f18_local5 = f18_local0 % 4
		if f18_local5 == 0 then
			return true
		elseif f18_local5 == 1 then
			f0_local11(1, 100)
			f0_local3(true)
			f0_local12(1)
			f0_local9(0)
			return true
		elseif f18_local5 == 2 then
			f0_local9(0)
			return true
		else
			return false
		end
	elseif f0_local2.mode == f0_local0.LEAGUE then
		local f18_local5 = f18_local0 % 3
		if f18_local5 == 0 then
			return true
		elseif f18_local5 == 1 then
			f0_local11(1, 100)
			f0_local3(true)
			f0_local12(1)
			f0_local9(0)
			return true
		else
			return false
		end
	else
		return false
	end
end

local f0_local19 = function (f19_arg0)
	Dvar.searchSessionIgnoreMapPacks:set(f19_arg0)
end

local f0_local20 = function ()
	local f20_local0 = Engine.GetDesiredContentMapPacks()
	local f20_local1
	if f20_local0 <= 0 or f20_local0 == Engine.GetMinimumContentMapPacks() then
		f20_local1 = false
	else
		f20_local1 = true
	end
	return f20_local1
end

function SetPingRangeBounded(f21_arg0, f21_arg1, f21_arg2)
	local f21_local0 = math.min(f21_arg2, f0_local14(f21_arg0))
	f0_local11(math.min(f21_arg1, math.floor(f21_local0 / 2)), f21_local0)
end

local f0_local21 = function (f22_arg0, f22_arg1)
	local f22_local0 = f0_local15()
	local f22_local1 = Engine.SearchTime()
	local f22_local2 = Dvar.searchSessionMaxIntervalTime:get()
	local f22_local3 = Dvar.searchSessionMaxIntervalTimeBeforeUnpark:get()
	local f22_local4 = 5
	local f22_local5 = Dvar.live_dedicatedUnparkPingMax:get()
	local f22_local6 = Dvar.live_dedicatedUnparkPingExcellent:get()
	if f22_local2 < f22_local1 then
		f22_local1 = f22_local2
	end
	if f22_local1 < f22_local4 then
		f22_local1 = f22_local4
	end
	if f0_local2.mode == f0_local0.LOBBY_MERGE then
		if f22_local0 == 0 then
			f0_local10(f22_local4)
			return true
		elseif f22_local0 == 1 and f22_local2 <= f22_local1 then
			local f22_local7 = math.random()
			local f22_local8 = 0
			if f0_local20() then
				f22_local8 = Dvar.searchSessionRandom_1:get()
			end
			if f22_local8 > 0 and f22_local7 < f22_local8 then
				if Dvar.tu10_searchSessionIgnoreMapPacks:get() then
					f0_local19(true)
				else
					f0_local8()
				end
				f0_local10(f22_local4)
				return true
			end
		end
		f0_local16()
		return false
	elseif f0_local2.mode == f0_local0.DEDICATED_SERVER then
		if f22_local0 == 0 then
			f0_local9(0)
			SetPingRangeBounded(f22_arg0, f22_local6, f22_local5)
			f0_local3(true)
			f0_local10(f22_local4)
			return true
		else
			f0_local16()
			return false
		end
	elseif f0_local2.mode == f0_local0.PUBLIC then
		if f22_local0 == 0 then
			f0_local10(f22_local4)
			return true
		elseif f22_local0 == 1 then
			local f22_local7 = math.random()
			local f22_local8 = 0
			if f22_local1 < f22_local3 and f0_local20() then
				f22_local8 = Dvar.searchSessionRandom_0:get()
			end
			if f22_local8 > 0 and f22_local7 < f22_local8 then
				if Dvar.tu10_searchSessionIgnoreMapPacks:get() then
					f0_local19(true)
				else
					f0_local8()
				end
			else
				SetPingRangeBounded(f22_arg0, f22_local6, f22_local5)
				f0_local3(true)
			end
			f0_local10(f22_local1)
			return true
		else
			f0_local16()
			return false
		end
	elseif f0_local2.mode == f0_local0.LEAGUE then
		if f22_local0 == 0 then
			f0_local9(0.01)
			f0_local10(f22_local4)
			return true
		elseif f22_local0 == 1 then
			SetPingRangeBounded(f22_arg0, f22_local6, f22_local5)
			f0_local3(true)
			f0_local10(f22_local1)
			return true
		else
			f0_local16()
			return false
		end
	else
		return false
	end
end

local f0_local22 = function (f23_arg0)
	local f23_local0 = Dvar.live_minMatchMakingPing:get()
	local f23_local1 = Dvar.live_maxMatchMakingPing:get()
	local f23_local2 = Dvar.live_maxMostAwesomePing:get()
	FixPreferredPing(f23_arg0, f23_local0, f23_local1)
	SetPingRangeBounded(f23_arg0, f23_local2, f23_local1)
	f0_local3(false)
	f0_local5(0.2)
	f0_local9(0)
	f0_local7()
	f0_local19(false)
	return f0_local21(f23_arg0)
end

function SetupMatchmakingQuery(f24_arg0, f24_arg1)
	f0_local2.mode = f24_arg1
	f0_local2.stage = 0
	return true
end

function SetupMatchmakingStage(f25_arg0)
	if CoD.isZombie then
		return f0_local17(f25_arg0)
	elseif CoD.isPC and Dvar.tu7_usePCmatchmaking:get() == true then
		return f0_local22(f25_arg0)
	else
		return f0_local18(f25_arg0)
	end
end

