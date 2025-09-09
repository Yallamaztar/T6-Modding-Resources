CoD.Unlockables = {}
local f0_local0 = 16
local f0_local1 = 24
local f0_local2 = 29
local f0_local3 = 30
local f0_local4, f0_local5, f0_local6, f0_local7, f0_local8, f0_local9, f0_local10, f0_local11, f0_local12, f0_local13, f0_local14, f0_local15, f0_local16, f0_local17, f0_local18, f0_local19 = nil
function basen(f1_arg0, f1_arg1)
	f1_arg0 = math.floor(f1_arg0)
	if not f1_arg1 or f1_arg1 == 10 then
		return tostring(f1_arg0)
	end
	local f1_local0 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local f1_local1 = {}
	local f1_local2 = ""
	if f1_arg0 < 0 then
		f1_local2 = "-"
		f1_arg0 = -f1_arg0
		repeat
			local f1_local3 = f1_arg0 % f1_arg1 + 1
			f1_arg0 = math.floor(f1_arg0 / f1_arg1)
			table.insert(f1_local1, 1, f1_local0:sub(f1_local3, f1_local3))
		until f1_arg0 == 0
		return f1_local2 .. table.concat(f1_local1, "")
	end
	local f1_local3 = f1_arg0 % f1_arg1 + 1
	f1_arg0 = math.floor(f1_arg0 / f1_arg1)
	table.insert(f1_local1, 1, f1_local0:sub(f1_local3, f1_local3))
end

f0_local6 = function (f2_arg0)
	if f0_local1 < f2_arg0 then
		DebugPrint("LUI WARNING: camoIndex of " .. f2_arg0 .. " is invalid since max supported camos is " .. f0_local1)
		return false
	else
		return true
	end
end

f0_local7 = function (f3_arg0)
	if f0_local3 < f3_arg0 then
		DebugPrint("LUI WARNING: attachmentIndex of " .. f3_arg0 .. " is invalid since max supported attachments is " .. f0_local3)
		return false
	else
		return true
	end
end

f0_local16 = function (f4_arg0)
	Engine.SetProfileVar(controller, "ui_menuCamoUnlocks", tostring(f4_arg0))
	Engine.Exec(controller, "updategamerprofile")
end

f0_local15 = function ()
	return UIExpression.ProfileString(UIExpression.GetPrimaryController(), "ui_menuCamoUnlocks")
end

f0_local19 = function (f6_arg0)
	Engine.SetProfileVar(controller, "ui_menuAttachUnlocks", tostring(f6_arg0))
	Engine.Exec(controller, "updategamerprofile")
end

f0_local18 = function ()
	return UIExpression.ProfileString(UIExpression.GetPrimaryController(), "ui_menuAttachUnlocks")
end

f0_local8 = function (f8_arg0)
	return basen(tonumber(f8_arg0, 32), 2)
end

f0_local9 = function (f9_arg0)
	return basen(tonumber(f9_arg0, 2), 32)
end

f0_local10 = function ()
	if f0_local4 == nil then
		local f10_local0 = f0_local8(f0_local15())
		UPVAL0 = {}
		for f10_local1 = 1, string.len(f10_local0), 1 do
			f0_local4[f10_local1] = tonumber(string.sub(f10_local0, -f10_local1, -f10_local1))
		end
		for f10_local1 = 1, 24, 1 do
			if f0_local4[f10_local1] == nil then
				f0_local4[f10_local1] = 0
			end
		end
	end
	return f0_local4
end

f0_local11 = function (f11_arg0)
	UPVAL0 = f11_arg0
end

f0_local14 = function ()
	if f0_local4 ~= nil then
		f0_local16(f0_local9(string.reverse(table.concat(f0_local4, ""))))
	end
	UPVAL0 = nil
end

f0_local12 = function ()
	if f0_local5 == nil then
		local f13_local0 = f0_local18()
		local f13_local1 = f13_local0
		local f13_local2 = ""
		for f13_local3 = string.len(f13_local0), 5, 1 do
			local f13_local6 = f13_local3
			f13_local1 = 0 .. f13_local1
		end
		f13_local2 = f0_local8(string.sub(f13_local1, -3, -1))
		for f13_local3 = string.len(f13_local2), 14, 1 do
			local f13_local6 = f13_local3
			f13_local2 = 0 .. f13_local2
		end
		f13_local2 = f0_local8(string.sub(f13_local1, -6, -4)) .. f13_local2
		for f13_local3 = string.len(f13_local2), 29, 1 do
			local f13_local6 = f13_local3
			f13_local2 = 0 .. f13_local2
		end
		UPVAL0 = {}
		for f13_local3 = 1, string.len(f13_local2), 1 do
			f0_local5[f13_local3] = tonumber(string.sub(f13_local2, -f13_local3, -f13_local3))
		end
	end
	return f0_local5
end

f0_local13 = function (f14_arg0)
	UPVAL0 = f14_arg0
end

f0_local17 = function ()
	if f0_local5 ~= nil then
		local f15_local0 = string.reverse(table.concat(f0_local5, ""))
		f0_local19(f0_local9(string.sub(f15_local0, -30, -16)) .. f0_local9(string.sub(f15_local0, -15, -1)))
	end
	UPVAL0 = nil
end

CoD.Unlockables.IsAttachmentUnlocked = function (f16_arg0, f16_arg1)
	local f16_local0 = tonumber(UIExpression.TableLookup(UIExpression.GetPrimaryController(), CoD.AARUtility.AttachmentTable, 3, Engine.GetAttachmentName(f16_arg0, f16_arg1), 0))
	if not f0_local7(f16_local0) then
		return false
	else
		local f16_local1 = f0_local12()
		return f16_local1[f16_local0] == 1
	end
end

function SetAttachmentUnlocked(f17_arg0, f17_arg1, f17_arg2)
	if not f0_local7(f17_arg0) then
		return false
	end
	local f17_local0 = f0_local12()
	if f17_arg1 then
		f17_local0[f17_arg0] = 1
	else
		f17_local0[f17_arg0] = 0
	end
	f0_local13(f17_local0)
	if f17_arg2 ~= nil and f17_arg2 then
		f0_local17()
	end
	return true
end

CoD.Unlockables.SetAttachmentUnlocked = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	return SetAttachmentUnlocked(tonumber(UIExpression.TableLookup(UIExpression.GetPrimaryController(), CoD.AARUtility.AttachmentTable, 3, Engine.GetAttachmentName(f18_arg0, f18_arg1), 0)), f18_arg2, f18_arg3)
end

CoD.Unlockables.IsCamoUnlocked = function (f19_arg0)
	if not f0_local6(f19_arg0) then
		return false
	else
		local f19_local0 = f0_local10()
		return f19_local0[f19_arg0] == 1
	end
end

CoD.Unlockables.SetCamoUnlocked = function (f20_arg0, f20_arg1, f20_arg2)
	if f20_arg0 == 0 then
		return true
	elseif not f0_local6(f20_arg0) then
		return false
	end
	local f20_local0 = f0_local10()
	if f20_arg1 then
		f20_local0[f20_arg0] = 1
	else
		f20_local0[f20_arg0] = 0
	end
	f0_local11(f20_local0)
	if f20_arg2 ~= nil and f20_arg2 then
		f0_local14()
	end
	return true
end

CoD.Unlockables.AddLevelUnlockables = function (f21_arg0, f21_arg1)
	if f21_arg1 == nil then
		f21_arg1 = true
	end
	local f21_local0 = Engine.GetNumWeaponOptions(CoD.CACUtility.weaponGroupNames.camo)
	local f21_local1 = UIExpression.GetPrimaryController()
	local f21_local2 = tonumber(UIExpression.TableLookup(f21_local1, CoD.AARUtility.LevelTable, 1, f21_arg0, 16, "1", 11))
	local f21_local3 = tonumber(UIExpression.TableLookup(f21_local1, CoD.AARUtility.LevelTable, 0, f21_local2, 11))
	if f21_local2 == -1 then
		f21_local3 = UIExpression.TableLookup(f21_local1, CoD.AARUtility.LevelTable, 1, f21_arg0, 2)
	end
	for f21_local4 = 1, f21_local0, 1 do
		local f21_local7 = UIExpression.TableLookup(f21_local1, CoD.AARUtility.AttachmentTable, 0, f21_local4 .. "", 1, "camo", 13)
		local f21_local8 = tonumber(UIExpression.TableLookup(f21_local1, CoD.AARUtility.LevelTable, 2, f21_local7, 11))
		if f21_local2 == -1 and f21_local3 == f21_local7 then
			if tonumber(UIExpression.GetDStat(f21_local1, "PlayerCareerStats", "storypoints", "SO_" .. string.upper(f21_local3) .. "_SUCCESS")) > 0 then
				CoD.Unlockables.SetCamoUnlocked(f21_local4, f21_arg1, false)
			end
		end
		if f21_local3 == f21_local8 then
			CoD.Unlockables.SetCamoUnlocked(f21_local4, f21_arg1, false)
		end
	end
	f0_local14()
	for f21_local4 = 1, f0_local3, 1 do
		local f21_local7 = UIExpression.TableLookup(f21_local1, CoD.AARUtility.AttachmentTable, 0, f21_local4 .. "", 2, "attachment", 3)
		local f21_local8 = UIExpression.TableLookup(f21_local1, CoD.AARUtility.AttachmentTable, 0, f21_local4 .. "", 2, "attachment", 13)
		local f21_local9 = tonumber(UIExpression.TableLookup(f21_local1, CoD.AARUtility.LevelTable, 2, f21_local8, 11))
		if f21_local2 == -1 and f21_local3 == f21_local8 then
			if tonumber(UIExpression.GetDStat(f21_local1, "PlayerCareerStats", "storypoints", "SO_" .. string.upper(f21_local3) .. "_SUCCESS")) > 0 then
				CoD.Unlockables.SetCamoUnlocked(f21_local4, f21_arg1, false)
			end
		end
		if f21_local3 == f21_local9 then
			SetAttachmentUnlocked(f21_local4, f21_arg1, false)
		end
	end
	f0_local17()
end

CoD.Unlockables.RollbackToLevel = function (f22_arg0)
	local f22_local0 = UIExpression.GetPrimaryController()
	local f22_local1 = {}
	local f22_local2 = UIExpression.GetDStat(f22_local0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue")
	for f22_local3 = tonumber(UIExpression.TableLookup(f22_local0, CoD.AARUtility.LevelTable, 1, f22_arg0, 0)), f22_local2, 1 do
		local f22_local6 = UIExpression.TableLookup(f22_local0, CoD.AARUtility.LevelTable, 0, f22_local3, 16, "1", 1)
		if f22_local6 ~= nil and f22_local6 ~= "" then
			CoD.Unlockables.AddLevelUnlockables(f22_local6, false)
		end
	end
end

CoD.Unlockables.ClearLevelUnlockables = function ()
	f0_local16("0")
	f0_local19("0")
	UPVAL2 = nil
	UPVAL3 = nil
	local f23_local0 = Engine.GetNumWeaponOptions(CoD.CACUtility.weaponGroupNames.camo)
	local f23_local1 = UIExpression.GetPrimaryController()
	for f23_local2 = 1, f23_local0, 1 do
		local f23_local5 = tonumber(UIExpression.TableLookup(f23_local1, CoD.AARUtility.LevelTable, 2, UIExpression.TableLookup(f23_local1, CoD.AARUtility.AttachmentTable, 0, f23_local2 .. "", 1, "camo", 13), 11))
		if f23_local5 == "" or f23_local5 == nil then
			CoD.Unlockables.SetCamoUnlocked(f23_local2, true, false)
		end
	end
	for f23_local2 = 1, f0_local3, 1 do
		local f23_local6 = UIExpression.TableLookup(f23_local1, CoD.AARUtility.AttachmentTable, 0, f23_local2 .. "", 2, "attachment", 13)
		local f23_local5 = tonumber(UIExpression.TableLookup(f23_local1, CoD.AARUtility.LevelTable, 2, f23_local6, 11))
		if f23_local6 == nil or f23_local6 == "" or f23_local5 == "" or f23_local5 == nil then
			SetAttachmentUnlocked(f23_local2, true, false)
		end
	end
	f0_local14()
	f0_local17()
end

