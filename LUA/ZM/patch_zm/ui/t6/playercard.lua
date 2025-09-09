CoD.Playercard = {}
CoD.Playercard.Height = 50
CoD.Playercard.AspectRatio = 5.64
CoD.Playercard.new = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.show = CoD.Playercard.show
	Widget.hide = CoD.Playercard.hide
	Widget.refresh = CoD.Playercard.refresh
	Widget:registerEventHandler("destroy_me", CoD.Playercard.DestroyMe)
	return Widget
end

CoD.Playercard.generatePlayerInfo = function (f2_arg0)
	local f2_local0 = {}
	local f2_local1 = UIExpression.GetDStat(f2_arg0, "PlayerStatsList", "RANK", "StatValue")
	local f2_local2 = UIExpression.GetDStat(f2_arg0, "PlayerStatsList", "PLEVEL", "StatValue")
	f2_local0.name = UIExpression.GetSelfGamertag(f2_arg0)
	f2_local0.clanTag = UIExpression.GetClanName(f2_arg0)
	f2_local0.rank = UIExpression.GetDisplayLevelByXUID(f2_arg0, UIExpression.GetXUID(f2_arg0))
	f2_local0.codpoints = UIExpression.GetStatByName(f2_arg0, "CODPOINTS")
	f2_local0.rankImage = UIExpression.TableLookup(f2_arg0, CoD.rankIconTable, 0, f2_local1, f2_local2 + 1)
	f2_local0.emblemBackground = UIExpression.EmblemPlayerBackgroundMaterial(f2_arg0, UIExpression.GetXUID(f2_arg0), 0)
	if tonumber(f2_local0.rank) == nil then
		f2_local0.rank = "0"
	end
	return f2_local0
end

CoD.Playercard.show = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg2 == nil then
		f3_arg2 = CoD.Playercard.generatePlayerInfo(f3_arg0.frame.slideContainer.currentSlide.m_ownerController)
	end
	if f3_arg0.body ~= nil then
		f3_arg0:refresh(f3_arg2)
		return 
	end
	f3_arg0.body = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alphaMultiplier = 0
	})
	f3_arg0.body:registerAnimationState("fade_in", {
		alphaMultiplier = 1
	})
	f3_arg0:addElement(f3_arg0.body)
	f3_arg0.body.backgroundNone = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("emblem_bg_nocod"),
		alpha = 1
	})
	f3_arg0.body:addElement(f3_arg0.body.backgroundNone)
	f3_arg0.body.background = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial(f3_arg2.emblemBackground),
		alpha = 1
	})
	f3_arg0.body:addElement(f3_arg0.body.background)
	local f3_local0 = CoD.textSize.Default
	local f3_local1 = 50
	f3_arg0.body.gamerTag = LUI.UIText.new({
		left = f3_local1,
		top = 0,
		right = 0,
		bottom = f3_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f3_arg0.body.gamerTag:setText(f3_arg2.name)
	f3_arg0.body:addElement(f3_arg0.body.gamerTag)
	f3_arg0.body.rankItemContainer = LUI.UIContainer.new()
	f3_arg0.body.rankItemContainer:registerAnimationState("show_container", {
		alphaMultiplier = 1
	})
	f3_arg0.body.rankItemContainer:registerAnimationState("hide_container", {
		alphaMultiplier = 0
	})
	f3_arg0.body:addElement(f3_arg0.body.rankItemContainer)
	f3_arg0.body.clanTagText = LUI.UIText.new({
		left = f3_local1,
		top = -f3_local0 - 5,
		right = 0,
		bottom = -5,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	if f3_arg2.clanTag ~= nil then
		f3_arg0.body.clanTagText:setText(CoD.getClanTag(f3_arg2.clanTag))
		f3_arg0.body.rankItemContainer:addElement(f3_arg0.body.clanTagText)
	end
	local f3_local2 = f3_local1 + 80
	local f3_local3 = 20
	f3_arg0.body.playerLevelText = LUI.UIText.new({
		left = f3_local2,
		top = -f3_local0 - 5,
		right = f3_local3,
		bottom = -5,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f3_arg0.body.playerLevelText:setText(f3_arg2.rank)
	f3_arg0.body.rankItemContainer:addElement(f3_arg0.body.playerLevelText)
	local f3_local4 = f3_local2 + f3_local3
	f3_arg0.body.rankIcon = LUI.UIImage.new({
		left = f3_local4,
		top = -24 - 5,
		right = f3_local4 + 24,
		bottom = -5,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 1
	})
	f3_arg0.body.cpText = LUI.UIText.new({
		left = -80 - 5,
		top = -f3_local0 - 5,
		right = -5,
		bottom = -5,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f3_arg0.body.cpText:setText(UIExpression.LocString(nil, "MENU_POINTS", f3_arg2.codpoints))
	f3_arg0.body.rankItemContainer:addElement(f3_arg0.body.cpText)
	if tonumber(f3_arg2.rank) > 0 then
		if f3_arg2.rankImage == nil then
			f3_arg2.rankImage = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f3_arg2.rank - 1, f3_arg2.prestige + 1)
		end
		f3_arg0.body.rankIcon:registerAnimationState("change_rank_icon", {
			material = RegisterMaterial(f3_arg2.rankImage)
		})
		f3_arg0.body.rankIcon:animateToState("change_rank_icon")
		f3_arg0.body.rankItemContainer:addElement(f3_arg0.body.rankIcon)
		f3_arg0.body.rankItemContainer:animateToState("show_container")
	else
		f3_arg0.body.rankItemContainer:animateToState("hide_container")
	end
	f3_arg0.body:animateToState("fade_in", f3_arg1, false, false)
end

CoD.Playercard.refresh = function (f4_arg0, f4_arg1)
	if f4_arg0.body == nil or f4_arg1 == nil then
		return 
	end
	f4_arg0.body.background:registerAnimationState("change_background", {
		material = RegisterMaterial(f4_arg1.emblemBackground)
	})
	f4_arg0.body.background:animateToState("change_background")
	f4_arg0.body.gamerTag:setText(f4_arg1.name)
	if tonumber(f4_arg1.rank) > 0 then
		if f4_arg1.clanTag ~= nil then
			f4_arg0.body.clanTagText:setText(CoD.getClanTag(f4_arg1.clanTag))
		end
		f4_arg0.body.playerLevelText:setText(f4_arg1.rank)
		if f4_arg1.rankImage == nil then
			f4_arg1.rankImage = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f4_arg1.rank - 1, f4_arg1.prestige + 1)
		end
		f4_arg0.body.rankIcon:registerAnimationState("change_rank_icon", {
			material = RegisterMaterial(f4_arg1.rankImage)
		})
		f4_arg0.body.rankIcon:animateToState("change_rank_icon")
		f4_arg0.body.cpText:setText(UIExpression.LocString(nil, "MENU_POINTS", f4_arg1.codpoints))
		f4_arg0.body.rankItemContainer:animateToState("show_container")
	else
		f4_arg0.body.rankItemContainer:animateToState("hide_container")
	end
end

CoD.Playercard.hide = function (f5_arg0, f5_arg1)
	if f5_arg0.body == nil then
		return 
	elseif f5_arg1 ~= nil then
		f5_arg0.body:animateToState("default", f5_arg1, false, false)
		f5_arg0.body:addElement(LUI.UITimer.new(f5_arg1, "destroy_me", true, f5_arg0))
	else
		f5_arg0:processEvent({
			name = "destroy_me"
		})
	end
end

CoD.Playercard.DestroyMe = function (f6_arg0, f6_arg1)
	if f6_arg0.body == nil then
		return 
	else
		f6_arg0.body:close()
		f6_arg0.body = nil
	end
end

