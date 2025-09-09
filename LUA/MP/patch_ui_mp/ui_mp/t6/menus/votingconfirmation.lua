CoD.VoteConfirmation = {}
CoD.VoteConfirmation.ComicsSwapIndex = 3
CoD.VoteConfirmation.Close = function (f1_arg0, f1_arg1)
	f1_arg0:goBack()
	f1_arg0.occludedMenu:processEvent({
		name = "voting_popup_closed",
		controller = f1_arg1.controller
	})
end

CoD.VoteConfirmation.Share = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if Engine.IsFacebookLinked(f2_local0) and f2_arg0.m_vote ~= nil and f2_arg0.m_itemName ~= nil then
		Engine.FacebookPost(f2_arg1.controller, "message", Engine.Localize("MENU_FB_VOTE_MESSAGE", f2_arg0.m_itemName), "link", Dvar.fbVoteUrl:get(), "picture", Dvar.fbVoteImageUrl:get() .. "bg_home_new.jpg", "name", Engine.Localize("MENU_FB_VOTE_TITLE"), "caption", Engine.Localize("MENU_FB_VOTE_CAPTION"), "description", Engine.Localize("MENU_FB_VOTE_DESC"))
		f2_arg0:openPopup("Voting_Facebook_Post_Success", f2_local0, f2_arg0.m_itemName)
	else
		f2_arg0:openPopup("Voting_Facebook_Link_Account", f2_local0)
	end
end

CoD.VoteConfirmation.AddVoteInfo = function (f3_arg0, f3_arg1)
	table.insert(f3_arg0, {
		item = f3_arg1,
		count = Engine.GetCounterValue(f3_arg1.CounterName)
	})
end

CoD.VoteConfirmation.GetVoteString = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = 0
	local f4_local1 = UIExpression.ToUpper(nil, f4_arg0.item.VotingItemString)
	if 0 < tonumber(f4_arg2) then
		f4_local0 = tonumber(f4_arg0.count) * 100 / tonumber(f4_arg2)
	else
		f4_local0 = 25
	end
	return string.format("%.1f", f4_local0) .. "%", f4_local1
end

CoD.VoteConfirmation.Comparison = function (f5_arg0, f5_arg1)
	return tonumber(f5_arg1.count) < tonumber(f5_arg0.count)
end

CoD.VoteConfirmation.GetAnimState = function (f6_arg0)
	local f6_local0 = {}
	local f6_local1 = 0
	local f6_local2 = 0
	local f6_local3 = 0
	local f6_local4 = 380
	local f6_local5 = 280
	if f6_arg0 == "topleft" then
		f6_local1 = -f6_local4 / 2
		f6_local2 = -f6_local5 / 2
	elseif f6_arg0 == "topright" then
		f6_local1 = f6_local4 / 2
		f6_local2 = -f6_local5 / 2
	elseif f6_arg0 == "bottomleft" then
		f6_local1 = -f6_local4 / 2
		f6_local2 = f6_local5 / 2
	else
		f6_local1 = f6_local4 / 2
		f6_local2 = f6_local5 / 2
	end
	f6_local0.leftAnchor = false
	f6_local0.rightAnchor = false
	f6_local0.topAnchor = false
	f6_local0.bottomAnchor = false
	f6_local0.left = f6_local1 - CoD.VotingPopup.VotingItemWidth / 2
	f6_local0.right = f6_local1 + CoD.VotingPopup.VotingItemWidth / 2
	f6_local0.top = f6_local2 - CoD.VotingPopup.VotingItemHeight / 2 + f6_local3
	f6_local0.bottom = f6_local2 + CoD.VotingPopup.VotingItemHeight / 2 + f6_local3
	return f6_local0
end

CoD.VoteConfirmation.CreateElement = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5)
	if f7_arg1 == nil then
		return 
	else
		local Widget = LUI.UIElement.new()
		Widget:registerAnimationState("default", CoD.VoteConfirmation.GetAnimState(f7_arg4))
		Widget:animateToState("default")
		f7_arg0:addElement(Widget)
		local f7_local1, f7_local2 = CoD.VoteConfirmation.GetVoteString(f7_arg1, f7_arg2, f7_arg3)
		CoD.VotingPopup.CreateVotingItemElement(Widget, f7_arg1.item.ImageName, f7_local1, f7_local2)
		Widget:setAlpha(f7_arg5)
	end
end

CoD.VoteConfirmation.ComicsHack = function (f8_arg0)
	for f8_local0 = 1, 2, 1 do
		if f8_arg0[f8_local0].item.ImageName == "menu_motd_votecamo_4b" then
			local f8_local3 = f8_arg0[CoD.VoteConfirmation.ComicsSwapIndex].item.ImageName
			local f8_local4 = f8_arg0[CoD.VoteConfirmation.ComicsSwapIndex].item.VotingItemString
			f8_arg0[CoD.VoteConfirmation.ComicsSwapIndex].item.ImageName = f8_arg0[f8_local0].item.ImageName
			f8_arg0[CoD.VoteConfirmation.ComicsSwapIndex].item.VotingItemString = f8_arg0[f8_local0].item.VotingItemString
			f8_arg0[f8_local0].item.ImageName = f8_local3
			f8_arg0[f8_local0].item.VotingItemString = f8_local4
		end
	end
end

CoD.VoteConfirmation.Setup = function (f9_arg0)
	CoD.VotingPopup.AddTitle(f9_arg0, Engine.Localize("MENU_VOTE_SUBMITTED_TITLE", UIExpression.ToUpper(nil, f9_arg0.m_itemName)), CoD.VotingPopup.MessageTop)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f9_local1 = {}
	CoD.VoteConfirmation.AddVoteInfo(f9_local1, f9_arg0.LeftVotingItem)
	CoD.VoteConfirmation.AddVoteInfo(f9_local1, f9_arg0.RightVotingItem)
	CoD.VoteConfirmation.AddVoteInfo(f9_local1, f9_arg0.TopVotingItem)
	CoD.VoteConfirmation.AddVoteInfo(f9_local1, f9_arg0.BottomVotingItem)
	local f9_local2 = 0
	for f9_local3 = 1, 4, 1 do
		if f9_local1[f9_local3] ~= nil then
			f9_local2 = f9_local2 + f9_local1[f9_local3].count
		end
	end
	table.sort(f9_local1, CoD.VoteConfirmation.Comparison)
	CoD.VoteConfirmation.ComicsHack(f9_local1)
	CoD.VoteConfirmation.CreateElement(Widget, f9_local1[1], f9_arg0.m_vote, f9_local2, "topleft", 1)
	CoD.VoteConfirmation.CreateElement(Widget, f9_local1[2], f9_arg0.m_vote, f9_local2, "topright", 1)
	CoD.VoteConfirmation.CreateElement(Widget, f9_local1[3], f9_arg0.m_vote, f9_local2, "bottomleft", 0.3)
	CoD.VoteConfirmation.CreateElement(Widget, f9_local1[4], f9_arg0.m_vote, f9_local2, "bottomright", 0.3)
	local f9_local3 = LUI.UIImage.new()
	f9_local3:setLeftRight(true, true, 0, 0)
	f9_local3:setTopBottom(false, false, 30, 31)
	f9_local3:setRGB(0.5, 0.5, 0.5)
	f9_local3:setAlpha(0.1)
	Widget:addElement(f9_local3)
	f9_arg0:addElement(Widget)
end

LUI.createMenu.VotingConfirmation = function (f10_arg0)
	local f10_local0 = CoD.Menu.New("VotingConfirmation")
	f10_local0:addLargePopupBackground()
	local f10_local1 = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_CONTINUE"), f10_local0, "voteconf_continue")
	f10_local0:registerEventHandler("voteconf_continue", CoD.VoteConfirmation.Close)
	f10_local0:registerEventHandler("voteconf_share", CoD.VoteConfirmation.Share)
	f10_local0:addLeftButtonPrompt(f10_local1)
	if Dvar.tu11_sendVoteToFBEnabled:get() == true then
		f10_local0:addLeftButtonPrompt(CoD.ButtonPrompt.new("alt1", Engine.Localize("MENU_FB_SEND_TO_FACEBOOK"), f10_local0, "voteconf_share"))
	end
	f10_local0.setup = CoD.VoteConfirmation.Setup
	return f10_local0
end

LUI.createMenu.Voting_Facebook_Post_Success = function (f11_arg0, f11_arg1)
	local f11_local0 = CoD.Popup.SetupPopup("Voting_Facebook_Post_Success", f11_arg0)
	f11_local0.title:setText(Engine.Localize("MENU_FB_MSG_SENT"))
	f11_local0.msg:setText(Engine.Localize("MENU_FB_MSG_DESC", Engine.Localize("MENU_FB_VOTE_MESSAGE", f11_arg1)))
	f11_local0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	f11_local0:addLeftButtonPrompt(CoD.ButtonPrompt.new("secondary", "", f11_local0, "button_prompt_back", true))
	return f11_local0
end

local f0_local0 = function (f12_arg0, f12_arg1)
	Engine.ExecNow(controller, "fbLinkFacebook")
end

local f0_local1 = function (f13_arg0, f13_arg1)
	f13_arg0:goBack(f13_arg1.controller)
	f13_arg0.occludedMenu:processEvent({
		name = "voteconf_share",
		controller = f13_arg1.controller
	})
end

LUI.createMenu.Voting_Facebook_Link_Account = function (f14_arg0)
	local f14_local0 = CoD.Popup.SetupPopupChoice("Voting_Facebook_Link_Account", f14_arg0)
	f14_local0.title:setText(Engine.Localize("MENU_FACEBOOK"))
	f14_local0.msg:setText(Engine.Localize("MENU_FACEBOOK_ACCOUNT_LINK_DESC"))
	f14_local0:addBackButton()
	f14_local0.choiceA:setLabel(Engine.Localize("MENU_LINK_ACCOUNT"))
	f14_local0.choiceB:setLabel(Engine.Localize("MENU_NOT_NOW"))
	f14_local0.choiceA:setActionEventName("link_facebook")
	f14_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f14_local0:registerEventHandler("link_facebook", f0_local0)
	f14_local0:registerEventHandler("facebook_register_success", f0_local1)
	return f14_local0
end

