if CoD == nil then
	CoD = {}
end
CoD.Ticker = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = 1
	local f1_local1 = f1_arg0.verticalList:getFirstChild()
	while f1_local1 ~= nil do
		if f1_local0 == 1 then
			f1_local1.categoryItem:animateToState("default")
			f1_local1.textItem:animateToState("default")
		elseif f1_local0 == 2 then
			f1_local1.categoryItem:animateToState("fading", f1_arg1)
			f1_local1.textItem:animateToState("fading", f1_arg1)
		else
			f1_local1.categoryItem:animateToState("faded", f1_arg1)
			f1_local1.textItem:animateToState("faded", f1_arg1)
		end
		f1_local0 = f1_local0 + 1
		f1_local1 = f1_local1:getNextSibling()
	end
end

local f0_local1 = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.verticalList:getLastChild()
	while f2_local0.disposable do
		f2_local0:close()
		f2_local0 = f2_arg0.verticalList:getLastChild()
	end
	f2_local0:close()
	f2_local0:setPriority(-10000)
	f2_arg0.verticalList:addElement(f2_local0)
	f2_local0:setPriority(nil)
	f2_arg0:scrollY(-f2_arg0.itemHeight, 0)
	f2_arg0:scrollY(0, 1000, true, true)
	f2_arg0:reset(1000)
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = f3_arg0.itemHeight
	local f3_local1 = CoD.fonts.Condensed
	local f3_local2 = 130
	local f3_local3 = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = f3_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f3_arg0.verticalList:addElement(f3_local3)
	f3_local3.categoryItem = LUI.UIText.new({
		left = 0,
		top = 0,
		bottom = f3_local0,
		right = f3_local2,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f3_local1,
		red = CoD.orange.r,
		green = CoD.orange.g,
		blue = CoD.orange.b,
		alpha = 1
	})
	f3_local3:addElement(f3_local3.categoryItem)
	f3_local3.categoryItem:setText(f3_arg1)
	f3_local3.categoryItem:registerAnimationState("fading", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.25
	})
	f3_local3.categoryItem:registerAnimationState("faded", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.05
	})
	f3_local3.textItem = LUI.UIText.new({
		left = 0,
		top = 0,
		bottom = f3_local0,
		right = 10000,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f3_local1,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f3_local3:addElement(f3_local3.textItem)
	f3_local3.textItem:setText(f3_arg2)
	f3_local3.textItem:registerAnimationState("fading", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.25
	})
	f3_local3.textItem:registerAnimationState("faded", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.05
	})
	if f3_arg3 then
		f3_arg0.timer:reset()
		f0_local1(f3_arg0)
		f3_local3.disposable = true
	end
end

CoD.Ticker.new = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = LUI.UIScrollable.new(f4_arg0, 10000, 10000)
	f4_local0.itemHeight = f4_arg1
	f4_local0.verticalList = LUI.UIVerticalList.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 10000,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false
	})
	f4_local0:addElement(f4_local0.verticalList)
	f4_local0.timer = LUI.UITimer.new(f4_arg2, "ticker_tick")
	LUI.UIElement.addElement(f4_local0, f4_local0.timer)
	f4_local0:registerEventHandler("ticker_tick", f0_local1)
	f4_local0.addMessage = f0_local2
	f4_local0.reset = f0_local0
	return f4_local0
end

