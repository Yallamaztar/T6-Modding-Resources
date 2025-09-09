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
function InheritFrom(f1_arg0)
	if not f1_arg0 then
		error("LUI Error: Did not specify bsae class in InheritFrom!")
	end
	local f1_local0 = {
		super = f1_arg0
	}
	setmetatable(f1_local0, {
		__index = f1_arg0
	})
	f1_local0.m_eventHandlers = {}
	setmetatable(f1_local0.m_eventHandlers, {
		__index = f1_arg0.m_eventHandlers
	})
	return f1_local0
end

LUI.ShallowCopy = function (f2_arg0)
	local f2_local0 = {}
	for f2_local4, f2_local5 in pairs(f2_arg0) do
		f2_local0[f2_local4] = f2_local5
	end
	return f2_local0
end

LUI.ConcatenateToTable = function (f3_arg0, f3_arg1)
	if f3_arg1 == nil then
		return 
	end
	for f3_local3, f3_local4 in pairs(f3_arg1) do
		table.insert(f3_arg0, f3_local4)
	end
end

LUI.clamp = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0 <= f4_arg1 then
		return f4_arg1
	elseif f4_arg2 <= f4_arg0 then
		return f4_arg2
	else
		return f4_arg0
	end
end

LUI.startswith = function (f5_arg0, f5_arg1)
	return string.sub(f5_arg0, 1, string.len(f5_arg1)) == f5_arg1
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
	for f6_local3, f6_local4 in pairs(LUI.roots) do
		f6_local4.debugReload = true
	end
end

LargestElements = {}
LargestElementsSize = {}
LargestElementsCount = {}
function CountFieldsHelper(f7_arg0, f7_arg1)
	if f7_arg1[f7_arg0] then
		return 
	end
	f7_arg1[f7_arg0] = true
	local f7_local0 = 0
	for f7_local4, f7_local5 in pairs(f7_arg0) do
		if type(f7_local4) == "table" then
			f7_local0 = f7_local0 + CountFieldsHelper(f7_local4, f7_arg1)
		end
		f7_local0 = f7_local0 + 1
	end
	return f7_local0
end

function CountFields(f8_arg0)
	return CountFieldsHelper(f8_arg0, {})
end

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
	local f11_local0 = getmetatable(_G)
	if not f11_local0 then
		f11_local0 = {}
		setmetatable(_G, f11_local0)
	end
	f11_local0.__newindex = function (f12_arg0, f12_arg1, f12_arg2)
		error("LUI Error: Tried to create global variable " .. f12_arg1, 2)
	end

end

