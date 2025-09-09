require("T6.Zombie.CraftablesIcon")
CoD.CraftablesStaffIcon = {}
CoD.CraftablesStaffIcon.UPPERSTAFFBIT = 1
CoD.CraftablesStaffIcon.MIDDLESTAFFBIT = 2
CoD.CraftablesStaffIcon.LOWERSTAFFBIT = 4
CoD.CraftablesStaffIcon.BlueIce = {}
CoD.CraftablesStaffIcon.BlueIce.r = 0
CoD.CraftablesStaffIcon.BlueIce.g = 0.71
CoD.CraftablesStaffIcon.BlueIce.b = 1
CoD.CraftablesStaffIcon.YellowWind = {}
CoD.CraftablesStaffIcon.YellowWind.r = 1
CoD.CraftablesStaffIcon.YellowWind.g = 0.94
CoD.CraftablesStaffIcon.YellowWind.b = 0
CoD.CraftablesStaffIcon.RedFire = {}
CoD.CraftablesStaffIcon.RedFire.r = 1
CoD.CraftablesStaffIcon.RedFire.g = 0.24
CoD.CraftablesStaffIcon.RedFire.b = 0
CoD.CraftablesStaffIcon.PurpleLightning = {}
CoD.CraftablesStaffIcon.PurpleLightning.r = 0.4
CoD.CraftablesStaffIcon.PurpleLightning.g = 0.18
CoD.CraftablesStaffIcon.PurpleLightning.b = 0.57
CoD.CraftablesStaffIcon.PartNeedAlpha = 0.2
CoD.CraftablesStaffIcon.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	CoD.CraftablesIcon.new(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = 3
	local f1_local1 = 4
	local f1_local2 = 11
	local f1_local3 = f1_local2 * 1.1
	f1_arg0.newStaffPart = LUI.UIElement.new()
	f1_arg0.newStaffPart:setLeftRight(false, true, -f1_local0 - f1_local2, -f1_local0)
	f1_arg0.newStaffPart:setTopBottom(true, false, f1_local1, f1_local1 + f1_local3)
	f1_arg0.newStaffPart:setImage(RegisterMaterial("zm_hud_icon_staff_piece"))
	f1_arg0.newStaffPart:setupStaffPieces(3, 0, -2)
	f1_arg0:addElement(f1_arg0.newStaffPart)
end

