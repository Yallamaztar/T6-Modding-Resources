CoD.Mouse = {}
CoD.Mouse.Materials = nil
CoD.Mouse.MaterialsRegistered = false
CoD.Mouse.CURSOR_NORMAL = 0
CoD.Mouse.CURSOR_GRABOPEN = 1
CoD.Mouse.CURSOR_GRABCLOSE = 2
CoD.Mouse.CursorState = 0
CoD.Mouse.InGrabMode = false
CoD.Mouse.Reset = false
CoD.Mouse.Create = function ()

end

CoD.Mouse.RegisterMaterials = function ()
	local f2_local0 = {
		[CoD.Mouse.CURSOR_NORMAL] = RegisterMaterial("ui_cursor")
	}
	if CoD.isZombie then
		f2_local0[CoD.Mouse.CURSOR_GRABOPEN] = RegisterMaterial("mouse_grab_open_zm")
		f2_local0[CoD.Mouse.CURSOR_GRABCLOSE] = RegisterMaterial("mouse_grab_close_zm")
	else
		f2_local0[CoD.Mouse.CURSOR_GRABOPEN] = RegisterMaterial("mouse_grab_open")
		f2_local0[CoD.Mouse.CURSOR_GRABCLOSE] = RegisterMaterial("mouse_grab_close")
	end
	CoD.Mouse.Materials = f2_local0
	CoD.Mouse.MaterialsRegistered = true
end

CoD.Mouse.SetMaterial = function (f3_arg0)
	if not CoD.Mouse.MaterialsRegistered then
		return 
	end
	local f3_local0 = CoD.Mouse.Materials[f3_arg0]
	if f3_local0 then
		Engine.SetMouseCursor(f3_local0)
	end
end

CoD.Mouse.SetCursorState = function (f4_arg0)
	if CoD.Mouse.Reset then
		CoD.Mouse.Reset = false
		CoD.Mouse.InGrabMode = false
		CoD.Mouse.CursorState = CoD.Mouse.CURSOR_NORMAL
		CoD.Mouse.SetMaterial(CoD.Mouse.CURSOR_NORMAL)
		return 
	elseif not CoD.Mouse.InGrabMode then
		return 
	elseif CoD.Mouse.CursorState ~= f4_arg0 then
		CoD.Mouse.CursorState = f4_arg0
		CoD.Mouse.SetMaterial(f4_arg0)
	end
end

