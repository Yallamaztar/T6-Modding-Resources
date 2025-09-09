require("T6.CACGridSelectionMenu")
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4 = nil
LUI.createMenu.CACGrenadesAndEquipment = function ()
	local f1_local0 = CoD.CACGridSelectionMenu.new()
	f1_local0:registerEventHandler("slide_activated", f0_local1)
	f1_local0:registerEventHandler("slide_deactivated", f0_local2)
	f1_local0.addGridElements = f0_local0
	f1_local0.updateUIFromClassData = f0_local3
	return f1_local0
end

f0_local0 = function (f2_arg0)
	local f2_local0 = f2_arg0.body
	local f2_local1 = f2_arg0.buttonGridItemsWide
	local f2_local2 = f2_arg0.buttonGridBorder + f2_local1 * CoD.ButtonGrid.ItemSize + (f2_local1 - 1) * CoD.ButtonGrid.Spacing
	local f2_local3 = {}
	LUI.ConcatenateToTable(f2_local3, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.primaryGrenade))
	LUI.ConcatenateToTable(f2_local3, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.specialGrenade))
	table.sort(f2_local3, CoD.CACItemComparisonFunction)
	CoD.CACGridSelectionMenu.AddItemsToButtonGrid(f2_arg0, f2_local3)
	f2_local0.buttonGrid.maxSelections = CoD.CACUtility.maxGrenades
end

f0_local1 = function (f3_arg0, f3_arg1)
	CoD.CACGridSelectionMenu.Activated(f3_arg0, f3_arg1)
end

f0_local2 = function (f4_arg0, f4_arg1)
	CoD.CACGridSelectionMenu.Deactivated(f4_arg0, f4_arg1)
end

f0_local3 = function (f5_arg0)
	CoD.CACGridSelectionMenu.UpdateUIFromClassData(f5_arg0)
end

f0_local4 = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f6_arg0.buttons
	local f6_local1 = f6_arg1.buttons
	local f6_local2 = #f6_local0
	local f6_local3 = f6_local2 - (f6_local2 + f6_arg2 - 1) % f6_arg2
	for f6_local4 = f6_local3, f6_local2, 1 do
		local f6_local7 = f6_local1[f6_local4 - f6_local3 + 1]
		if f6_local7 ~= nil then
			local f6_local8 = f6_local0[f6_local4]
			local f6_local9 = f6_local8.navigation.down
			if f6_local9 ~= nil then
				f6_local9.navigation.up = nil
			end
			local f6_local10 = f6_local7.navigation.up
			if f6_local10 ~= nil then
				f6_local10.navigation.down = nil
			end
			f6_local8.navigation.down = f6_local7
			f6_local7.navigation.up = f6_local8
		end
	end
end

