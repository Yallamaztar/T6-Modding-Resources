require("T6.ScrollingVerticalList")
require("T6.ServerListButton")
CoD.ServerList = {}
CoD.ServerList.ColumnWidth = {}
CoD.ServerList.ColumnWidth[1] = 250
CoD.ServerList.ColumnWidth[2] = 200
CoD.ServerList.ColumnWidth[3] = 100
CoD.ServerList.ColumnWidth[4] = 200
CoD.ServerList.ColumnWidth[5] = 93
CoD.ServerList.RowHeight = CoD.CoD9Button.Height
CoD.ServerList.ColumnSpacing = 5
local JoinServer = function (self, ClientInstance)
	CoD.SwitchToSystemLinkGame(ClientInstance.controller)
	Engine.ServerListJoinServer(ClientInstance.controller, self.serverIndex)
end

local ButtonPromptRefresh = function (self, ClientInstance)
	Engine.PlaySound("cac_grid_equip_item")
	Engine.ServerListRefreshServers(ClientInstance.controller)
end

local ServerListSortFunc = function (Server1, Server2)
	return string.lower(Server1.hostname) < string.lower(Server2.hostname)
end

local ServerListRefresh = function (self)
	self.verticalList:removeAllChildren()
	local Servers = Engine.ServerListGetServers()
	if Servers == nil or #Servers == 0 then
		DebugPrint("No available servers.")
		return 
	end
	table.sort(Servers, ServerListSortFunc)
	local f4_local1 = 0
	for ServerIndex, Server in ipairs(Servers) do
		if CoD.isZombie == true then
			if Server.isInGame ~= "1" then
				local ServerListButton = CoD.ServerListButton.new(ServerIndex, Server, {
					left = 0,
					top = 0,
					right = 0,
					bottom = CoD.ServerList.RowHeight,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = true,
					bottomAnchor = false,
					spacing = CoD.ServerList.ColumnSpacing
				})
				ServerListButton:registerEventHandler("button_action", JoinServer)
				self:addElementToList(ServerListButton)
				if f4_local1 == 0 then
					f4_local1 = ServerIndex
				end
				if ServerIndex == f4_local1 and CoD.useController then
					ServerListButton:processEvent({
						name = "gain_focus"
					})
				end
			end
		end
		local ServerListButton = CoD.ServerListButton.new(ServerIndex, Server, {
			left = 0,
			top = 0,
			right = 0,
			bottom = CoD.ServerList.RowHeight,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			spacing = CoD.ServerList.ColumnSpacing
		})
		ServerListButton:registerEventHandler("button_action", JoinServer)
		self:addElementToList(ServerListButton)
		if ServerIndex == 1 and CoD.useController then
			ServerListButton:processEvent({
				name = "gain_focus"
			})
		end
	end
end

CoD.ServerList.new = function (LocalClientIndex)
	local self = CoD.ScrollingVerticalList.new(LocalClientIndex)
	self.id = "ServerList"
	self:registerEventHandler("server_list_refresh", ServerListRefresh)
	self:registerEventHandler("button_prompt_refresh", ButtonPromptRefresh)
	ServerListRefresh(self)
	return self
end

