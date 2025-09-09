LUI.UIStreamedImage = InheritFrom(LUI.UIElement)
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.spinner:close()
end

LUI.UIStreamedImage.new = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local Widget = LUI.UIElement.new(f2_arg0)
	if f2_arg1 == nil then
		f2_arg1 = 0
	end
	Widget:setClass(LUI.UIStreamedImage)
	Widget:setupUIStreamedImage(f2_arg1)
	if f2_arg2 then
		local f2_local1 = 64
		if f2_arg3 then
			f2_local1 = f2_arg3
		end
		Widget.spinner = LUI.UIImage.new()
		Widget.spinner:setLeftRight(false, false, -f2_local1 / 2, f2_local1 / 2)
		Widget.spinner:setTopBottom(false, false, -f2_local1 / 2, f2_local1 / 2)
		Widget.spinner:setImage(RegisterMaterial("lui_loader"))
		Widget:addElement(Widget.spinner)
		Widget:registerEventHandler("streamed_image_ready", f0_local0)
	end
	return Widget
end

LUI.UIStreamedImage.id = "LUIStreamedImage"
