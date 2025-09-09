if CoD == nil then
	CoD = {}
end
CoD.EdgeShadow = {}
CoD.EdgeShadow.Size = 10
CoD.EdgeShadow.Alpha = 0.15
CoD.EdgeShadow.LeftShadowMaterial = RegisterMaterial("lui_leftshadow")
CoD.EdgeShadow.RightShadowMaterial = RegisterMaterial("lui_rightshadow")
CoD.EdgeShadow.TopShadowMaterial = RegisterMaterial("lui_topshadow")
CoD.EdgeShadow.BottomShadowMaterial = RegisterMaterial("lui_bottomshadow")
CoD.EdgeShadow.new = function (f1_arg0, f1_arg1)
	local f1_local0 = nil
	if f1_arg1 == nil then
		f1_arg1 = false
	end
	if f1_arg0 == "top" then
		if f1_arg1 == true then
			f1_local0 = {
				left = 0,
				top = 0,
				right = 0,
				bottom = CoD.EdgeShadow.Size,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = false,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.TopShadowMaterial
			}
		else
			f1_local0 = {
				left = 0,
				top = -CoD.EdgeShadow.Size,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = false,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.BottomShadowMaterial
			}
		end
	elseif f1_arg0 == "bottom" then
		if f1_arg1 == true then
			f1_local0 = {
				left = 0,
				top = -CoD.EdgeShadow.Size,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = true,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.BottomShadowMaterial
			}
		else
			f1_local0 = {
				left = 0,
				top = 0,
				right = 0,
				bottom = CoD.EdgeShadow.Size,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = true,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.TopShadowMaterial
			}
		end
	elseif f1_arg0 == "left" then
		if f1_arg1 == true then
			f1_local0 = {
				left = 0,
				top = 0,
				right = CoD.EdgeShadow.Size,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = true,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.LeftShadowMaterial
			}
		else
			f1_local0 = {
				left = -CoD.EdgeShadow.Size,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = true,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.RightShadowMaterial
			}
		end
	elseif f1_arg0 == "right" then
		if f1_arg1 == true then
			f1_local0 = {
				left = -CoD.EdgeShadow.Size,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = false,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.RightShadowMaterial
			}
		else
			f1_local0 = {
				left = 0,
				top = 0,
				right = CoD.EdgeShadow.Size,
				bottom = 0,
				leftAnchor = false,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true,
				alpha = CoD.EdgeShadow.Alpha,
				material = CoD.EdgeShadow.LeftShadowMaterial
			}
		end
	else
		return nil
	end
	return LUI.UIImage.new(f1_local0)
end

