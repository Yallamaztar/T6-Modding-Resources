LUI.UIText = InheritFrom(LUI.UIElement)
LUI.UIText.addElement = function (self, newChildElement)
	DebugPrint("WARNING: An element is being added to a UIText element. This will cause undesired behavior!")
	LUI.UIElement.addElement(self, newChildElement)
end

LUI.UIText.addElementBefore = function (self, newChildElement)
	DebugPrint("WARNING: An element is being added to a UIText element. This will cause undesired behavior!")
	LUI.UIElement.addElementBefore(self, newChildElement)
end

LUI.UIText.addElementAfter = function (self, newChildElement)
	DebugPrint("WARNING: An element is being added to a UIText element. This will cause undesired behavior!")
	LUI.UIElement.addElementAfter(self, newChildElement)
end

LUI.UIText.new = function ( defaultAnimationState, isUncached )
	if defaultAnimationState == nil then
		defaultAnimationState = {
			red = CoD.DefaultTextColor.r,
			green = CoD.DefaultTextColor.g,
			blue = CoD.DefaultTextColor.b
		}
	elseif defaultAnimationState.red == nil and defaultAnimationState.green == nil and defaultAnimationState.blue == nil then
		defaultAnimationState.red = CoD.DefaultTextColor.r
		defaultAnimationState.green = CoD.DefaultTextColor.g
		defaultAnimationState.blue = CoD.DefaultTextColor.b
	end
	local text = LUI.UIElement.new( defaultAnimationState )
	text:setClass( LUI.UIText )
	if not isUncached then
		text:setupUIText()
	else
		text:setupUITextUncached()
	end
	return text
end

LUI.UIText.TransitionComplete_OutState = function ( self, event )
	self:setText( self.replaceContentData.text )
	self:registerEventHandler( "transition_complete_" .. self.replaceContentData.outState, nil )
	self:animateToState( self.replaceContentData.inState, self.replaceContentData.inDuration )
	self.replaceContentData = nil
end

LUI.UIText.setText = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5)
	if f6_arg2 ~= nil and f6_arg3 ~= nil then
		f6_arg0.replaceContentData = {}
		f6_arg0.replaceContentData.outState = f6_arg2
		f6_arg0.replaceContentData.inState = f6_arg3
		f6_arg0.replaceContentData.outDuration = f6_arg4
		f6_arg0.replaceContentData.inDuration = f6_arg5
		f6_arg0.replaceContentData.text = f6_arg1
		f6_arg0:registerEventHandler("transition_complete_" .. f6_arg2, LUI.UIText.TransitionComplete_OutState)
		f6_arg0:animateToState(f6_arg2, f6_arg4)
		return 
	else
		f6_arg0:setTextInC(f6_arg1)
	end
end

LUI.UIText.id = "LUIText"
