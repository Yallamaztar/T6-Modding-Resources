LUI.UIImage = InheritFrom(LUI.UIElement)
LUI.UIImage.addElement = function (self, newChildElement)
	DebugPrint("WARNING: An element is being added to a UIImage element. This will cause undesired behavior!")
	LUI.UIElement.addElement(self, newChildElement)
end

LUI.UIImage.addElementBefore = function (self, newChildElement)
	DebugPrint("WARNING: An element is being added to a UIImage element. This will cause undesired behavior!")
	LUI.UIElement.addElementBefore(self, newChildElement)
end

LUI.UIImage.addElementAfter = function (self, newChildElement)
	DebugPrint("WARNING: An element is being added to a UIImage element. This will cause undesired behavior!")
	LUI.UIElement.addElementAfter(self, newChildElement)
end

LUI.UIImage.new = function (defaultAnimationState)
	local image = LUI.UIElement.new(defaultAnimationState)
	image:setClass(LUI.UIImage)
	image:setupUIImage()
	return image
end

LUI.UIImage.id = "LUIImage"
