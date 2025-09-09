LUI = {
	UIWidth = 960,
	UIHeight = 720,
	roots = {},
	createMenu = {},
	Alignment = {
		None = 0,
		Left = 1,
		Center = 2,
		Right = 3,
		Top = 4,
		Middle = 5,
		Bottom = 6
	},
	savedMenuStates = {}
}

if hpairs ~= nil then
	pairs = hpairs
end

function InheritFrom(UIClass)
	if not UIClass then
		error("LUI Error: Did not specify base class in InheritFrom!")
	end
	local NewUIElement = {
		super = UIClass
	}
	setmetatable(NewUIElement, {
		__index = UIClass
	})
	NewUIElement.m_eventHandlers = {}
	setmetatable(NewUIElement.m_eventHandlers, {
		__index = UIClass.m_eventHandlers
	})
	return NewUIElement
end

--No observable uses in LUI
LUI.ShallowCopy = function (UIClass)
	local NewUIElement = {}
	for Index, Item in pairs(UIClass) do
		NewUIElement[Index] = Item
	end
	return NewUIElement
end

LUI.ConcatenateToTable = function (TableToAddTo, TableToAddFrom)
	if TableToAddFrom == nil then
		return 
	end
	for Index, Item in pairs(TableToAddFrom) do
		table.insert(TableToAddTo, Item)
	end
end

LUI.clamp = function (Value1, Value2, Value3)
	if Value1 <= Value2 then
		return Value2
	elseif Value3 <= Value1 then
		return Value3
	else
		return Value1
	end
end

LUI.startswith = function (StringToCheck, StringStart)
	return string.sub(StringToCheck, 1, string.len(StringStart)) == StringStart
end

require("LUI.LUIElement")
require("LUI.LUIElementAllocator")
require("LUI.LUIRoot")
require("LUI.LUITimer")
require("LUI.LUIButtonRepeater")
require("LUI.LUIImage")
require("LUI.LUIStreamedImage")
require("LUI.LUIText")
require("LUI.LUIAnimNumber")
require("LUI.LUITightText")
require("LUI.LUIButton")
require("LUI.LUIMouseCursor")
require("LUI.LUIVerticalList")
require("LUI.LUIHorizontalList")
require("LUI.LUIGridList")
require("LUI.LUIScrollable")
require("LUI.LUIVerticalScrollbar")
require("LUI.LUISafeAreaOverlay")
require("LUI.LUITouchpadButton")
require("LUI.LUITouchpadRadioButton")

if not debug then
	debug = {}
end

debug.postdeploymentfunction = function ()
	for Index, UIElement in pairs(LUI.roots) do
		UIElement.debugReload = true
	end
end

LargestElements = {}
LargestElementsSize = {}
LargestElementsCount = {}

--No observable occurences in any file; skipped
function CountFieldsHelper(f7_arg0, FieldsTable)
	if FieldsTable[f7_arg0] then
		return 
	end
	FieldsTable[f7_arg0] = true
	local f7_local0 = 0
	for f7_local4, f7_local5 in pairs(f7_arg0) do
		if type(f7_local4) == "table" then
			f7_local0 = f7_local0 + CountFieldsHelper(f7_local4, FieldsTable)
		end
		f7_local0 = f7_local0 + 1
	end
	return f7_local0
end

--No observable occurences in any file; skipped
function CountFields(f8_arg0)
	return CountFieldsHelper(f8_arg0, {})
end

--No observable occurences in any file; skipped
function CountReferencesHelper(f9_arg0, f9_arg1)
	if f9_arg1[f9_arg0] then
		return 
	end
	f9_arg1[f9_arg0] = true
	if type(f9_arg0) == "userdata" then
		local f9_local0 = getmetatable(f9_arg0)
		if not f9_local0 then
			return 
		end
		f9_arg0 = f9_local0.__index
		if not f9_arg0 then
			return 
		elseif type(f9_arg0) == "table" and f9_arg0.id then
			local f9_local1 = CountFields(f9_arg0)
			if not LargestElementsSize[f9_arg0.id] or LargestElementsSize[f9_arg0.id] < f9_local1 then
				LargestElements[f9_arg0.id] = f9_arg0
				LargestElementsSize[f9_arg0.id] = f9_local1
			end
			if not LargestElementsCount[f9_arg0.id] then
				LargestElementsCount[f9_arg0.id] = 0
			end
			LargestElementsCount[f9_arg0.id] = LargestElementsCount[f9_arg0.id] + 1
		end
	end
	if type(f9_arg0) ~= "table" then
		return 
	end
	for f9_local3, f9_local4 in pairs(f9_arg0) do
		CountReferencesHelper(f9_local4, f9_arg1)
	end
end

--No observable occurences in any file; skipped
function CountReferences(f10_arg0)
	local f10_local0 = {
		[f10_arg0] = true
	}
	if type(f10_arg0) == "userdata" then
		local f10_local1 = getmetatable(f10_arg0)
		if not f10_local1 then
			return 0
		end
		f10_arg0 = f10_local1.__index
		if not f10_arg0 then
			return 0
		end
	end
	if type(f10_arg0) ~= "table" then
		return 0
	end
	for f10_local4, f10_local5 in pairs(f10_arg0) do
		CountReferencesHelper(f10_local5, f10_local0)
	end
	f10_local1 = 0
	for f10_local5, f10_local6 in pairs(f10_local0) do
		f10_local1 = f10_local1 + 1
	end
	return f10_local1
end

function DisableGlobals()
	local GlobalVariableMetatable = getmetatable(_G)
	if not GlobalVariableMetatable then
		GlobalVariableMetatable = {}
		setmetatable(_G, GlobalVariableMetatable)
	end
	GlobalVariableMetatable.__newindex = function (f13_arg0, GlobalVariable, f13_arg2)
		error("LUI Error: Tried to create global variable " .. GlobalVariable, 2)
	end

end

function EnableGlobals()
	local GlobalVariableMetatable = getmetatable(_G)
	if not GlobalVariableMetatable then
		GlobalVariableMetatable = {}
		setmetatable(_G, GlobalVariableMetatable)
	end
	GlobalVariableMetatable.__newindex = nil
end

