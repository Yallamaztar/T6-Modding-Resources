CoD.TexturePackPopup = {}
CoD.TexturePackPopup.SetupTexturePack = function (f1_arg0, f1_arg1)
	Engine.ExecNow(f1_arg1.controller, "buyOfferFromMOTD 0x90930800 0")
	f1_arg0:goBack()
end

CoD.TexturePackPopup.AddButton = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg0.buttonList:addButton(f2_arg1)
	f2_local0:setActionEventName(f2_arg2)
end

LUI.createMenu.TexturePackConfirmationPopup = function (f3_arg0)
	local f3_local0 = CoD.Menu.NewSmallPopup("TexturePackConfirmationPopup")
	f3_local0.anyControllerAllowed = true
	f3_local0:addSelectButton()
	f3_local0:addBackButton()
	f3_local0:registerEventHandler("setup_texture_pack", CoD.TexturePackPopup.SetupTexturePack)
	f3_local0:registerEventHandler("open_texture_pack_confirmation_popup", CoD.NullFunction)
	local f3_local1 = 5
	local f3_local2 = LUI.UIText.new()
	f3_local2:setLeftRight(true, true, 0, 0)
	f3_local2:setTopBottom(true, false, f3_local1, f3_local1 + CoD.textSize.Big)
	f3_local2:setFont(CoD.fonts.Big)
	f3_local2:setAlignment(LUI.Alignment.Left)
	f3_local2:setText(Engine.Localize("MENU_TEXTURE_PACK_CONFIRMATION_TITLE"))
	f3_local0:addElement(f3_local2)
	f3_local1 = f3_local1 + CoD.textSize.Big + 10
	local f3_local3 = LUI.UIText.new()
	f3_local3:setLeftRight(true, true, 0, 0)
	f3_local3:setTopBottom(true, false, f3_local1, f3_local1 + CoD.textSize.Default)
	f3_local3:setFont(CoD.fonts.Default)
	f3_local3:setAlignment(LUI.Alignment.Left)
	f3_local3:setText(Engine.Localize("MENU_TEXTURE_PACK_CONFIRMATION_MESSAGE"))
	f3_local0:addElement(f3_local3)
	f3_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f3_local0:addElement(f3_local0.buttonList)
	CoD.TexturePackPopup.AddButton(f3_local0, Engine.Localize("MENU_ACCEPT"), "setup_texture_pack")
	CoD.TexturePackPopup.AddButton(f3_local0, Engine.Localize("MENU_CANCEL"), "button_prompt_back")
	f3_local0.buttonList:processEvent({
		name = "gain_focus"
	})
	return f3_local0
end

