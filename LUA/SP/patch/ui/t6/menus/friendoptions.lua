require("T6.Menus.FBPopup")
CoD.FriendOptions = {}
CoD.FriendOptions.LiveVisible = true
CoD.FriendOptions.FBVisible = true
CoD.FriendOptions.EliteVisible = true
CoD.FriendOptions.ShowAllFriends = function (f1_arg0)
	CoD.FriendOptions.LiveVisible = true
	CoD.FriendOptions.FBVisible = true
	CoD.FriendOptions.EliteVisible = true
	Engine.Exec(f1_arg0, "friendsShowLive 1")
	Engine.Exec(f1_arg0, "friendsShowFacebook 1")
	Engine.Exec(f1_arg0, "friendsShowElite 1")
end

local f0_local0 = function (f2_arg0)
	local f2_local0 = f2_arg0.parentSelectorButton:getParent()
	local f2_local1 = f2_local0:getParent()
	if f2_arg0.value == 1 then
		CoD.FriendOptions.LiveVisible = true
		Engine.Exec(f2_local1.m_ownerController, "friendsShowLive 1")
	else
		CoD.FriendOptions.LiveVisible = false
		Engine.Exec(f2_local1.m_ownerController, "friendsShowLive 0")
	end
end

local f0_local1 = function (f3_arg0)
	local f3_local0 = f3_arg0.parentSelectorButton:getParent()
	local f3_local1 = f3_local0:getParent()
	if f3_arg0.value == 1 then
		CoD.FriendOptions.FBVisible = true
		Engine.Exec(f3_local1.m_ownerController, "friendsShowFacebook 1")
	else
		CoD.FriendOptions.FBVisible = false
		Engine.Exec(f3_local1.m_ownerController, "friendsShowFacebook 0")
	end
end

local f0_local2 = function (f4_arg0)
	local f4_local0 = f4_arg0.parentSelectorButton:getParent()
	local f4_local1 = f4_local0:getParent()
	if f4_arg0.value == 1 then
		CoD.FriendOptions.EliteVisible = true
		Engine.Exec(f4_local1.m_ownerController, "friendsShowElite 1")
	else
		CoD.FriendOptions.EliteVisible = false
		Engine.Exec(f4_local1.m_ownerController, "friendsShowElite 0")
	end
end

local f0_local3 = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	if f5_arg3 == true then
		f5_arg1.strings = {
			"MENU_SHOW_CAPS",
			"MENU_HIDE_CAPS"
		}
		f5_arg1.values = {
			1,
			0
		}
	else
		f5_arg1.strings = {
			"MENU_HIDE_CAPS",
			"MENU_SHOW_CAPS"
		}
		f5_arg1.values = {
			0,
			1
		}
	end
	for f5_local0 = 1, #f5_arg1.strings, 1 do
		f5_arg1:addChoice(f5_arg0, Engine.Localize(f5_arg1.strings[f5_local0]), f5_arg1.values[f5_local0], nil, f5_arg2)
	end
end

local f0_local4 = function (f6_arg0, f6_arg1)
	Engine.Exec(f6_arg1.controller, "fbUnregister")
end

local f0_local5 = function (f7_arg0, f7_arg1)
	f7_arg0:openPopup("FBPopup", f7_arg1.controller)
end

local f0_local6 = function (f8_arg0, f8_arg1)
	if UIExpression.IsFacebookLinked(controller) == 1 then
		f8_arg0:setLabel(Engine.Localize("MENU_UNLINKFACEBOOK_CAPS"))
		f8_arg0:setActionEventName("unlink_fb")
	else
		f8_arg0:setLabel(Engine.Localize("MENU_LINKFACEBOOK_CAPS"))
		f8_arg0:setActionEventName("link_fb")
	end
end

LUI.createMenu.FriendOptions = function (f9_arg0)
	local f9_local0 = CoD.Menu.NewSmallPopup("FriendsListOptionsPopup")
	f9_local0.m_ownerController = f9_arg0
	f9_local0:addBackButton()
	local f9_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = 5,
		bottom = 0
	})
	f9_local0:addElement(f9_local1)
	local f9_local2 = f9_local1:addDvarLeftRightSelector(f9_arg0, Engine.Localize("XBOXLIVE_FRIENDS_CAPS"), nil)
	f0_local3(f9_arg0, f9_local2, f0_local0, CoD.FriendOptions.LiveVisible)
	f0_local3(f9_arg0, f9_local1:addDvarLeftRightSelector(f9_arg0, Engine.Localize("MENU_ELITE_FRIENDS_CAPS"), nil), f0_local2, CoD.FriendOptions.EliteVisible)
	f9_local1:addSpacer(CoD.CoD9Button.Height)
	if CoD.useController then
		f9_local2:processEvent({
			name = "gain_focus"
		})
	end
	return f9_local0
end

