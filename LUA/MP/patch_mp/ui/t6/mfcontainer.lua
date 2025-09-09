local f0_local0 = 200
local f0_local1 = 200
local f0_local2 = 0.5
local f0_local3 = function (f1_arg0, f1_arg1, f1_arg2)
	f1_arg1.id = "MFSlide." .. f1_arg2
	f1_arg1.frame = f1_arg0.frame
	f1_arg1.slideContainer = f1_arg0
	if f1_arg1.largeSlide then
		f1_arg1:registerAnimationState("default", {
			left = -f1_arg0.slideWidth / 2,
			top = f1_arg0.largeSlideTopOffset + -f1_arg0.largeSlideHeight / 2,
			right = f1_arg0.slideWidth / 2,
			bottom = f1_arg0.largeSlideTopOffset + f1_arg0.largeSlideHeight / 2,
			xRot = 0,
			yRot = 0,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			alpha = 0
		})
		f1_arg1:registerAnimationState("fade_in", {
			alpha = 1
		})
		f1_arg1.height = f1_arg0.largeSlideHeight
	else
		f1_arg1:registerAnimationState("default", {
			left = -f1_arg0.slideWidth / 2,
			top = f1_arg0.largeSlideTopOffset + -f1_arg0.largeSlideHeight / 2,
			right = f1_arg0.slideWidth / 2,
			bottom = f1_arg0.largeSlideTopOffset + f1_arg0.largeSlideHeight / 2,
			xRot = 0,
			yRot = 0,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			alpha = 0
		})
		f1_arg1:registerAnimationState("fade_in", {
			alpha = 1
		})
		f1_arg1.height = f1_arg0.slideHeight
	end
	f1_arg1.width = f1_arg0.slideWidth
	f1_arg1:animateToState("default")
	f1_arg0:addElement(f1_arg1)
	if f1_arg2 ~= nil then
		if f1_arg0.slideNames == nil then
			f1_arg0.slideNames = {}
		end
		f1_arg0.slideNames[f1_arg2] = f1_arg1
		f1_arg1.name = f1_arg2
	else
		error("LUI Error: Cannot add a slide without a name.")
	end
end

local f0_local4 = function (f2_arg0)
	if f2_arg0.nextSlide ~= nil then
		f2_arg0.currentSlide = f2_arg0.nextSlide
		f2_arg0.nextSlide = nil
	end
	if f2_arg0.currentSlide ~= nil then
		f2_arg0.currentSlide:processEvent({
			name = "add_slide_elements"
		})
		f2_arg0.currentSlide:processEvent({
			name = "slide_activated"
		})
	end
	local f2_local0 = nil
	while #f2_arg0.nextSlideQueue > 0 and f2_local0 ~= true do
		local f2_local1 = f2_arg0.nextSlideQueue[1]
		table.remove(f2_arg0.nextSlideQueue, 1)
		f2_arg0.nextSlide = f2_local1.slide
		f2_arg0.scrollController = f2_local1.controller
		f2_arg0.markPrevious = f2_local1.markPrevious
		f2_local0 = f2_arg0:scroll()
	end
end

local f0_local5 = function (f3_arg0)
	if f3_arg0.m_overlayOpen == true then
		return 
	end
	local f3_local0 = f3_arg0.currentSlide
	local f3_local1 = f3_arg0.nextSlide
	local f3_local2 = f3_arg0.frame
	if f3_local1 == nil then
		return 
	elseif f3_local0 ~= nil then
		if f3_local0 == f3_local1 then
			f3_arg0.nextSlide = nil
			return 
		elseif f3_local2 ~= nil and f3_local0.title ~= f3_local1.title then
			f3_local2:fadeOutTitle(CoD.MFSlide.FadeOutTime)
		end
		f3_local0:processEvent({
			name = "slide_deactivated"
		})
		f3_local0:animateToState("default", f0_local0, true, false)
	end
	if f3_arg0.markPrevious and f3_local0 ~= nil then
		f3_local1.m_previousMenuName = f3_local0.name
	end
	if f3_local1.largeSlide ~= true and f3_arg0.scrollController ~= nil then
		f3_local1.m_ownerController = f3_arg0.scrollController
	end
	local f3_local3 = "uin_menu_trans_02"
	f3_arg0.scrollSpeed = f0_local0
	f3_local1:animateToState("fade_in", f0_local0, true, false)
	f0_local4(f3_arg0)
	Engine.PlaySound("uin_navigation_select_main")
	Engine.PlaySound(f3_local3)
	return true
end

local f0_local6 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg0.slideNames ~= nil then
		local f4_local0 = f4_arg0.slideNames[f4_arg1]
		if f4_local0 ~= nil then
			if f4_local0.isSubMenu ~= nil then
				if f4_arg0.currentSlide.m_ownerMenuName ~= nil then
					f4_local0.m_ownerMenuName = f4_arg0.currentSlide.m_ownerMenuName
				else
					f4_local0.m_ownerMenuName = f4_arg0.currentSlide.name
				end
			end
			f4_arg0.frame:processEvent({
				name = "slide_changed"
			})
			if f4_arg0.nextSlide == nil then
				f4_arg0.nextSlide = f4_local0
				f4_arg0.scrollController = f4_arg2
				f4_arg0.markPrevious = f4_arg3
				f4_arg0:scroll()
			else
				table.insert(f4_arg0.nextSlideQueue, {
					slide = f4_local0,
					controller = f4_arg2,
					markPrevious = f4_arg3
				})
			end
			return f4_local0
		end
	end
end

local f0_local7 = function (f5_arg0, f5_arg1)
	local f5_local0, f5_local1 = nil
	if f5_arg0.currentSlide ~= nil then
		f5_local0 = f5_arg0.currentSlide.isSubMenu
		f5_local1 = f5_arg0.currentSlide.m_ownerMenuName
	end
	if f5_arg0.frame.currentMenu ~= f5_arg1.menuName and (f5_local0 == nil or f5_local1 ~= f5_arg1.menuName) then
		f5_arg0:scrollToNamedSlide(f5_arg1.menuName, f5_arg1.controller)
	end
end

local f0_local8 = function (f6_arg0)
	f6_arg0.m_overlayOpen = true
	if f6_arg0.currentSlide ~= nil then
		f6_arg0.currentSlide:overlayOpened()
	end
end

local f0_local9 = function (f7_arg0)
	f7_arg0.m_overlayOpen = nil
	local f7_local0 = f7_arg0:scroll()
	if f7_arg0.currentSlide ~= nil then
		local f7_local1 = nil
		if f7_local0 ~= true then
			f7_local1 = true
		end
		f7_arg0.currentSlide:overlayClosing(f7_local1, f0_local1)
	end
	local f7_local1 = nil
	if f7_local0 ~= true then
		f7_local1 = f7_arg0.currentSlide
	end
	return f7_local0
end

local f0_local10 = function (f8_arg0)
	if f8_arg0.currentSlide ~= nil then
		local f8_local0 = nil
		if f8_arg0.nextSlide == nil then
			f8_local0 = true
		end
		f8_arg0.currentSlide:overlayClosed(f8_local0)
	end
end

LUI.createMenu.MFContainer = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = LUI.UIScrollable.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f9_arg0, f9_arg1, true)
	f9_local0:setUseStencil(false)
	f9_local0.frame = f9_arg2
	f9_arg2.slideContainer = f9_local0
	f9_local0.slideWidth = f9_arg2.width
	f9_local0.slideHeight = 600
	f9_local0.slideTopOffset = 0 - (600 - f9_local0.slideHeight) / 2
	f9_local0.largeSlideHeight = 600
	f9_local0.largeSlideTopOffset = 0 - (600 - f9_local0.largeSlideHeight) / 2
	f9_local0.nextSlideQueue = {}
	f9_local0:registerEventHandler("open_menu", f0_local7)
	f9_local0.addSlide = f0_local3
	f9_local0.scroll = f0_local5
	f9_local0.scrollToNamedSlide = f0_local6
	f9_local0.overlayOpened = f0_local8
	f9_local0.overlayClosing = f0_local9
	f9_local0.overlayClosed = f0_local10
	return f9_local0
end

