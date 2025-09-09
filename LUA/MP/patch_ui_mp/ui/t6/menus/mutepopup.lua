CoD.MutePopup = {}
LUI.createMenu.Mute = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("Mute")
	f1_local0.m_ownerController = f1_arg0
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_MUTING")))
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 30,
		bottom = 0
	})
	f1_local0:addElement(f1_local1)
	local f1_local2 = f1_local1:addButton(Engine.Localize("MENU_MUTE_ALL_EXCEPT_PARTY_CAPS"), Engine.Localize("MENU_MUTE_ALL_EXCEPT_PARTY_DESC"))
	f1_local2:setActionEventName("mute_all_but_party")
	f1_local0:registerEventHandler("mute_all_but_party", CoD.MutePopup.MuteAllButParty)
	local f1_local3 = f1_local1:addButton(Engine.Localize("MENU_UNMUTE_ALL_CAPS"), Engine.Localize("MENU_UNMUTE_ALL_DESC"))
	f1_local3:setActionEventName("unmute_all")
	f1_local0:registerEventHandler("unmute_all", CoD.MutePopup.UnmuteAll)
	if CoD.useController then
		f1_local2:processEvent({
			name = "gain_focus"
		})
	end
	Engine.PlaySound("cac_loadout_edit_sel")
	return f1_local0
end

CoD.MutePopup.MuteAll = function (f2_arg0, f2_arg1)
	Engine.PartyMuteAll()
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.MutePopup.MuteAllButParty = function (f3_arg0, f3_arg1)
	Engine.PartyMuteAllButParty(f3_arg1.controller)
	f3_arg0:goBack(f3_arg1.controller)
end

CoD.MutePopup.UnmuteAll = function (f4_arg0, f4_arg1)
	Engine.PartyUnmuteAll()
	f4_arg0:goBack(f4_arg1.controller)
end

