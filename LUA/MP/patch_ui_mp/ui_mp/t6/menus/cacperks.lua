require("T6.CACGridSelectionMenu")
local f0_local0 = nil
LUI.createMenu.CACPerks = function ()
	local f1_local0 = CoD.CACGridSelectionMenu.new()
	f1_local0.addGridElements = f0_local0
	return f1_local0
end

f0_local0 = function (f2_arg0)
	local f2_local0 = {}
	for f2_local1 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		LUI.ConcatenateToTable(f2_local0, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames["specialty" .. f2_local1]))
	end
	table.sort(f2_local0, CoD.CACItemComparisonFunction)
	CoD.CACGridSelectionMenu.AddItemsToButtonGrid(f2_arg0, f2_local0)
	f2_arg0.body.buttonGrid.maxSelections = CoD.CACUtility.maxPerks
end

