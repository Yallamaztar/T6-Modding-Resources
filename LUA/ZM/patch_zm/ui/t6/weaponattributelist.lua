CoD.WeaponAttributeList = {}
CoD.WeaponAttributeList.AttributeTable = "mp/attributesTable.csv"
CoD.WeaponAttributeList.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.AttributeBarList.new(f1_arg0, f1_arg1)
	if f1_arg2 == nil then
		f1_arg2 = CoD.WeaponAttributeList.AttributeTable
	end
	f1_local0.m_attributeTable = f1_arg2
	f1_local0.updateWeaponAttributes = CoD.WeaponAttributeList.UpdateWeaponAttributes
	if CoD.isMultiplayer then
		f1_local0:addAttributeBar("mobility", Engine.Localize("MPUI_FIRE_RATE_CAPS"), 0, 100)
	else
		f1_local0:addAttributeBar("mobility", Engine.Localize("MPUI_MOBILITY_CAPS"), 0, 100)
	end
	f1_local0:addAttributeBar("damage", Engine.Localize("MPUI_DAMAGE_CAPS"), 0, 100)
	f1_local0:addAttributeBar("range", Engine.Localize("MPUI_RANGE_CAPS"), 0, 100)
	f1_local0:addAttributeBar("accuracy", Engine.Localize("MPUI_ACCURACY_CAPS"), 0, 100)
	return f1_local0
end

CoD.WeaponAttributeList.GetNumOfDashes = function (f2_arg0, f2_arg1)
	if f2_arg0 ~= nil then
		return f2_arg0 / f2_arg1
	else
		return 0
	end
end

CoD.WeaponAttributeList.UpdateWeaponAttributes = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = 3
	local f3_local1 = 4
	local f3_local2 = 2
	local f3_local3 = 6
	local f3_local4 = 5
	local f3_local5 = f3_arg0.m_attributeTable
	local f3_local6 = UIExpression.GetItemRef(nil, f3_arg1)
	local f3_local7 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local6, f3_local0)), 5)
	local f3_local8 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local6, f3_local1)), 5)
	local f3_local9 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local6, f3_local2)), 5)
	local f3_local10 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local6, f3_local3)), 5)
	local f3_local11 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local6, f3_local4)), 5)
	if f3_arg2 ~= nil then
		local f3_local12 = Engine.GetAttachmentRef(f3_arg1, f3_arg2)
		local f3_local13 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local12, 9, f3_local6, f3_local0)), 5)
		local f3_local14 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local12, 9, f3_local6, f3_local1)), 5)
		local f3_local15 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local12, 9, f3_local6, f3_local2)), 5)
		local f3_local16 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local12, 9, f3_local6, f3_local3)), 5)
		local f3_local17 = CoD.WeaponAttributeList.GetNumOfDashes(tonumber(UIExpression.TableLookup(nil, f3_local5, 1, f3_local12, 9, f3_local6, f3_local4)), 5)
		f3_arg0.attributes.damage.attributeBar:setupDashes(20, f3_local7, f3_local13, 18)
		f3_arg0.attributes.range.attributeBar:setupDashes(20, f3_local8, f3_local14, 18)
		f3_arg0.attributes.accuracy.attributeBar:setupDashes(20, f3_local9, f3_local15, 18)
		f3_arg0.attributes.mobility.attributeBar:setupDashes(20, f3_local10, f3_local16, 18)
	else
		f3_arg0.attributes.damage.attributeBar:setupDashes(20, f3_local7, 0, 18)
		f3_arg0.attributes.range.attributeBar:setupDashes(20, f3_local8, 0, 18)
		f3_arg0.attributes.accuracy.attributeBar:setupDashes(20, f3_local9, 0, 18)
		f3_arg0.attributes.mobility.attributeBar:setupDashes(20, f3_local10, 0, 18)
	end
end

