CoD.NotificationDoubleXP = {}
CoD.NotificationDoubleXP.Height = 40
CoD.NotificationDoubleXP.Width = 80
CoD.NotificationDoubleXP.Delay = 400
CoD.NotificationDoubleXP.InTime = 150
CoD.NotificationDoubleXP.New = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setAlpha(0)
	Widget:registerEventHandler("inState", CoD.NotificationDoubleXP.In)
	Widget:registerEventHandler("transition_complete_in", CoD.NotificationDoubleXP.InComplete)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, 0, 0)
	f1_local1:setImage(RegisterMaterial("menu_x2_xp_notify"))
	f1_local1:setAlpha(1)
	Widget.image = f1_local1
	Widget:addElement(f1_local1)
	Widget.top = f1_arg0
	if f1_arg1 == nil then
		f1_arg1 = CoD.NotificationDoubleXP.Delay
	end
	if f1_arg2 == nil then
		f1_arg2 = CoD.NotificationDoubleXP.InTime
	end
	Widget.inTime = f1_arg2
	Widget:addElement(LUI.UITimer.new(f1_arg1, "inState", true, Widget))
	return Widget
end

CoD.NotificationDoubleXP.In = function (f2_arg0, f2_arg1)
	f2_arg0:beginAnimation("in", f2_arg0.inTime, true, false)
	f2_arg0:setLeftRight(false, false, -CoD.NotificationDoubleXP.Width / 2, CoD.NotificationDoubleXP.Width / 2)
	f2_arg0:setTopBottom(true, false, f2_arg0.top, f2_arg0.top + CoD.NotificationDoubleXP.Height)
	f2_arg0:setAlpha(1)
	Engine.PlaySound("uin_lau_doublexp")
end

CoD.NotificationDoubleXP.InComplete = function (f3_arg0, f3_arg1)
	f3_arg0.image:setupBitchinFX(RegisterMaterial("bitchin_glint"))
	f3_arg0.image:playBitchinFX(600)
end

