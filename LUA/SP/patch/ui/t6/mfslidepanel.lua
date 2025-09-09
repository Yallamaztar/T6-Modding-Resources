if CoD == nil then
	CoD = {}
end
CoD.MFSlidePanel = {}
CoD.MFSlidePanel.OutDuration = 150
CoD.MFSlidePanel.InDuration = 250
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg1.interrupted == true then
		return 
	end
	f1_arg0:registerEventHandler("transition_complete_" .. f1_arg0.replaceContentData.outState, nil)
	f1_arg0:removeAllChildren()
	f1_arg0:addElement(f1_arg0.replaceContentData.newContent)
	if f1_arg0.replaceContentData.callbackFunc ~= nil then
		f1_arg0.replaceContentData:callbackFunc()
	end
	f1_arg0:animateToState(f1_arg0.replaceContentData.inState, CoD.MFSlidePanel.InDuration, true, true)
	f1_arg0.replaceContentData = nil
	f1_arg0.m_inputDisabled = nil
end

local f0_local1 = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	if f2_arg0.replaceContentData ~= nil then
		error("LUI Error: Already replacing MFSlidePanel content with something else!")
	end
	f2_arg0.m_inputDisabled = true
	f2_arg0.replaceContentData = {}
	f2_arg0.replaceContentData.outState = f2_arg1
	f2_arg0.replaceContentData.inState = f2_arg2
	f2_arg0.replaceContentData.newContent = f2_arg3
	f2_arg0.replaceContentData.callbackFunc = f2_arg4
	f2_arg0:registerEventHandler("transition_complete_" .. f2_arg1, f0_local0)
	f2_arg0:animateToState(f2_arg1, CoD.MFSlidePanel.OutDuration, true, true)
	Engine.PlaySound("uin_navigation_select_submenu")
	Engine.PlaySound("uin_menu_left_right")
end

local f0_local2 = function (f3_arg0)
	f3_arg0:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.25
	}))
end

CoD.MFSlidePanel.new = function (f4_arg0)
	local Widget = LUI.UIElement.new(f4_arg0)
	Widget.id = "MFSlidePanel"
	Widget.replaceContent = f0_local1
	Widget.addDebugBackground = f0_local2
	return Widget
end

