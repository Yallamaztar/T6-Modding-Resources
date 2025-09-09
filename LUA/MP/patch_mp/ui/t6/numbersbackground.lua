CoD.NumbersBackground = {}
CoD.NumbersBackground.Width = 1500
CoD.NumbersBackground.Height = 1500
local f0_local0 = "menu_numbers_1"
local f0_local1 = "menu_numbers_2"
local f0_local2 = "menu_numbers_3"
local f0_local3 = "menu_numbers_4"
local f0_local4 = "menu_numbers_5"
if CoD.isZombie == true then
	f0_local0 = "menu_zm_numbers_1"
	f0_local1 = "menu_zm_numbers_2"
	f0_local2 = "menu_zm_numbers_3"
	f0_local3 = "menu_zm_numbers_4"
	f0_local4 = "menu_zm_numbers_5"
end
CoD.NumbersBackground.Materials = {
	{
		name = f0_local0,
		width = 2048,
		height = 32
	},
	{
		name = f0_local1,
		width = 1024,
		height = 64
	},
	{
		name = f0_local2,
		width = 2048,
		height = 64
	},
	{
		name = f0_local3,
		width = 2048,
		height = 64
	},
	{
		name = f0_local4,
		width = 1024,
		height = 128
	}
}
CoD.NumbersBackground.Numbers_Reset = function (f1_arg0, f1_arg1)
	f1_arg0:animateToState("default")
	f1_arg0:animateToState("scroll", f1_arg0.speed)
end

CoD.NumbersBackground.new = function ()
	local f2_local0 = CoD.NumbersBackground.Width
	local f2_local1 = CoD.NumbersBackground.Height
	local Widget = LUI.UIElement.new({
		left = -f2_local0 / 2,
		top = -f2_local1 / 2,
		right = f2_local0 / 2,
		bottom = f2_local1 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		zRot = 45
	})
	math.randomseed(4321)
	for f2_local3 = 1, 40, 1 do
		local f2_local6 = f2_local3
		local f2_local7 = math.random(1, #CoD.NumbersBackground.Materials)
		local f2_local8 = CoD.NumbersBackground.Materials[f2_local7]
		local f2_local9 = -f2_local8.width
		local f2_local10 = math.random(f2_local1 - f2_local8.height)
		local f2_local11 = f2_local0 + 2048
		local f2_local12 = 0.12 * (#CoD.NumbersBackground.Materials - f2_local7 + 1) / #CoD.NumbersBackground.Materials
		local f2_local13 = math.random()
		local f2_local14 = f2_local9 + f2_local13 * (f2_local11 - f2_local9)
		local f2_local15 = LUI.UIImage.new({
			left = f2_local14,
			top = f2_local10,
			right = f2_local14 + f2_local8.width,
			bottom = f2_local10 + f2_local8.height,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			material = RegisterMaterial(f2_local8.name),
			alpha = f2_local12
		})
		local f2_local16 = 1 - (f2_local7 - 1) / (#CoD.NumbersBackground.Materials - 1)
		f2_local15:setPriority(#CoD.NumbersBackground.Materials - f2_local7)
		f2_local15:registerAnimationState("default", {
			left = f2_local9,
			right = f2_local9 + f2_local8.width,
			leftAnchor = true,
			rightAnchor = false
		})
		f2_local15.speed = 50000 + 70000 * f2_local16 * f2_local16
		f2_local15:registerAnimationState("scroll", {
			left = f2_local11,
			right = f2_local11 + f2_local8.width,
			leftAnchor = true,
			rightAnchor = false
		})
		f2_local15:registerEventHandler("transition_complete_scroll", CoD.NumbersBackground.Numbers_Reset)
		f2_local15:animateToState("scroll", (1 - f2_local13) * f2_local15.speed)
		Widget:addElement(f2_local15)
	end
	return Widget
end

