require("T6.ServerList")
CoD.ServerBrowser = {}
CoD.ServerBrowser.DoNothing = function (self, ClientInstance)

end

CoD.ServerBrowser.JoinMatch = function (self, ClientInstance)
	Engine.ServerListStopRefresh()
	self.occludedMenu:processEvent({
		name = "rebuild_button_panel"
	})
	self:registerEventHandler("party_joined", CoD.ServerBrowser.DoNothing)
	self:registerEventHandler("button_prompt_back", CoD.ServerBrowser.DoNothing)
end

CoD.ServerBrowser.close = function (self, f3_arg1)
	Engine.ServerListStopRefresh()
	self.occludedMenu:processEvent({
		name = "rebuild_button_panel"
	})
	CoD.Menu.close(self, f3_arg1)
end

CoD.ServerBrowser.AddRefreshButton = function (self, ServerListWidget)
	self.refreshButton = CoD.ButtonPrompt.new("alt1", Engine.Localize("MENU_REFRESH"), ServerListWidget, "button_prompt_refresh", false, false, false, false, "R")
	self:addRightButtonPrompt(self.refreshButton)
end

CoD.ServerBrowser.SignedOut = function (self, ClientInstance)
	if self.m_ownerController == ClientInstance.controller then
		Engine.ServerListStopRefresh()
		CoD.Menu.SignedOut(self, ClientInstance)
	end
end

LUI.createMenu.ServerBrowser = function (LocalClientIndex)
	local self = CoD.Menu.New("ServerBrowser")
	self:addLargePopupBackground()
	self.m_ownerController = LocalClientIndex
	self:addTitle(Engine.Localize("PLATFORM_SYSTEM_LINK_GAMES_CAPS"))
	self:registerEventHandler("party_joined", CoD.ServerBrowser.JoinMatch)
	local TitleHeight = CoD.Menu.TitleHeight
	local f6_local2 = self.height - TitleHeight
	local HeaderTop = TitleHeight + CoD.CoD9Button.Height
	self.header = LUI.UIHorizontalList.new({
		left = 0,
		top = TitleHeight,
		right = 0,
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = CoD.ServerList.ColumnSpacing
	})
	self:addElement(self.header)
	self.backgroundGroup = LUI.UIHorizontalList.new({
		left = 0,
		top = HeaderTop,
		right = 0,
		bottom = -CoD.CoD9Button.Height - 10,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.ServerList.ColumnSpacing,
		alpha = 0.03
	})
	self:addElement(self.backgroundGroup)
	local BackgroundImages = {
		LUI.UIImage.new({
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[1],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}),
		LUI.UIImage.new({
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[2],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}),
		LUI.UIImage.new({
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[3],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}),
		LUI.UIImage.new({
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[4],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}),
		LUI.UIImage.new({
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[5],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		})
	}
	self.backgroundGroup:addElement(BackgroundImages[1])
	self.backgroundGroup:addElement(BackgroundImages[2])
	self.backgroundGroup:addElement(BackgroundImages[3])
	self.backgroundGroup:addElement(BackgroundImages[4])
	self.backgroundGroup:addElement(BackgroundImages[5])
	self.serverList = CoD.ServerList.new({
		left = 0,
		top = HeaderTop,
		right = 0,
		bottom = -CoD.CoD9Button.Height - 10,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = 10
	})
	self:addElement(self.serverList)
	local HostColumn = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[1],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	})
	local MapnameColumn = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[2],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	})
	local GameModeColumn = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[4],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	})
	local StatusColumn = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[5],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	})
	local NumPlayersColumn = LUI.UIText.new({
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[3],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	})
	HostColumn:setText(Engine.Localize("MENU_HOST_CAPS"))
	MapnameColumn:setText(Engine.Localize("MENU_MAP_NAME_CAPS"))
	NumPlayersColumn:setText(Engine.Localize("MENU_NUMPLAYERS_CAPS"))
	GameModeColumn:setText(Engine.Localize("MENU_GAME_MODE_CAPS"))
	StatusColumn:setText(Engine.Localize("MENU_STATUS_CAPS"))
	self.header:addSpacer(CoD.ServerListButton.TextOffset)
	self.header:addElement(HostColumn)
	self.header:addElement(MapnameColumn)
	self.header:addElement(NumPlayersColumn)
	self.header:addElement(GameModeColumn)
	self.header:addElement(StatusColumn)
	self:addSelectButton()
	self:addBackButton()
	CoD.ServerBrowser.AddRefreshButton(self, self.serverList)
	self:registerEventHandler("signed_out", CoD.ServerBrowser.SignedOut)
	return self
end

