CoD.ServerListButton = {}
CoD.ServerListButton.Height = 30
CoD.ServerListButton.TextOffset = 5
CoD.ServerListButton.TextHeight = CoD.textSize.Default
CoD.ServerListButton.Font = CoD.fonts.Default
CoD.ServerListButton.BackgroundColor = {
	r = 1,
	g = 1,
	b = 1,
	a = 0
}
local ServerListButtonGainFocus = function (self, ClientInstance)
	Engine.PlaySound("uin_navigation_click")
end

CoD.ServerListButton.new = function (ServerIndex, Server, MenuInstance, f2_arg3)
	local ServerListButton = LUI.UIButton.new(MenuInstance, f2_arg3)
	ServerListButton.id = "ServerListButton." .. Server.hostname
	ServerListButton.serverIndex = Server.serverIndex
	local ButtonColumns = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.ServerList.ColumnSpacing
	})
	local Hostname = LUI.UIText.new({
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[1],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	})
	local Mapname = LUI.UIText.new({
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[2],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	})
	local ClientCount = LUI.UIText.new({
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[3],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	})
	local Gametype = LUI.UIText.new({
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[4],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	})
	local Status = LUI.UIText.new({
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[5],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	})
	Hostname:setText(Server.hostname)
	Mapname:setText(Server.mapname)
	ClientCount:setText(Server.clients)
	Gametype:setText(Server.gametype)
	if Server.isInGame == "1" then
		Status:setText(Engine.Localize("MENU_PLAYING"))
		Hostname:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		Mapname:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		ClientCount:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		Gametype:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		Status:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	else
		Status:setText(Engine.Localize("MENU_LOBBY"))
	end
	ButtonColumns:addSpacer(CoD.ServerListButton.TextOffset)
	ButtonColumns:addElement(Hostname)
	ButtonColumns:addElement(Mapname)
	ButtonColumns:addElement(ClientCount)
	ButtonColumns:addElement(Gametype)
	ButtonColumns:addElement(Status)
	ServerListButton:addElement(ButtonColumns)
	local Border = CoD.Border.new(2)
	Border:hide()
	Border:registerEventHandler("button_over", Border.show)
	Border:registerEventHandler("button_up", Border.hide)
	ServerListButton:addElement(Border)
	local Widget = LUI.UIElement.new()
	ServerListButton:addElement(Widget)
	Widget:registerEventHandler("gain_focus", ServerListButtonGainFocus)
	return ServerListButton
end

