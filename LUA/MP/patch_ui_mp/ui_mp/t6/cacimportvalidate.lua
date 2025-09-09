if CoD.isZombie == false then
	CoD.CACImportValidate = {}
	CoD.CACImportValidate.validate = function (f1_arg0, f1_arg1)
		local f1_local0 = true
		local f1_local1 = f1_arg1.controller
		local f1_local2 = Engine.GetCustomClassCount(f1_local1)
		if f1_local2 == nil then
			f1_local2 = 5
		end
		for f1_local3 = 0, f1_local2 - 1, 1 do
			if CoD.CACImportValidate.checkDualWieldPistolWithAttachments(f1_local1, f1_local3) == true then
				f1_local0 = false
				break
			end
		end
		return f1_local0
	end

end
CoD.CACImportValidate.checkDualWieldPistolWithAttachments = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.CACUtility.GetClassData(f2_arg0, f2_arg1)
	local f2_local1 = false
	if f2_local0.secondaryWeapon == nil then
		return false
	elseif #f2_local0.secondaryAttachments < 2 then
		return false
	elseif UIExpression.GetItemGroup(nil, CoD.GetClassItem(f2_arg0, f2_arg1, CoD.CACUtility.loadoutSlotNames.secondaryWeapon)) ~= "weapon_pistol" then
		return false
	end
	for f2_local5, f2_local6 in ipairs(f2_local0.secondaryAttachments) do
		if f2_local6.name == "MPUI_DW" then
			f2_local1 = true
		end
	end
	return f2_local1
end

