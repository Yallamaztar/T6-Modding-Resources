require("T6.PartyLobby")
require("T6.MapInfoImage")
CoD.PlayerMatchPartyLobby = {}
CoD.PlayerMatchPartyLobby.UpdateLivestreamCamera = function (f1_arg0, f1_arg1)
	if not f1_arg0.livestreamCam then
		return 
	elseif Engine.IsLivestreamEnabled() and Engine.WebM_camera_IsAvailable() and Engine.WebM_camera_IsEnabled() then
		f1_arg0.livestreamCam:setAlpha(1)
	else
		f1_arg0.livestreamCam:setAlpha(0)
	end
end

LUI.createMenu.PlayerMatchPartyLobby = function (f2_arg0)
	local f2_local0 = CoD.PartyLobby.new(f2_arg0, "PlayerMatchPartyLobby", Engine.Localize("MENU_MATCHMAKING_CAPS"))
	f2_local0:addTitle(Engine.Localize("MENU_MATCHMAKING_CAPS"))
	f2_local0:setPlaylistFilter("playermatch")
	f2_local0.lobbyPane.body.lobbyList:setSplitscreenSignInAllowed(true)
	local f2_local1 = 6
	local f2_local2 = CoD.MapInfoImage.MapImageBottom
	f2_local0.livestreamCam = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local1,
		right = f2_local1 + CoD.MapInfoImage.MapImageWidth,
		topAnchor = false,
		bottomAnchor = true,
		top = f2_local2 - CoD.MapInfoImage.MapImageHeight,
		bottom = f2_local2,
		material = RegisterMaterial("livestream_cam"),
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0
	})
	f2_local0:addElement(f2_local0.livestreamCam)
	f2_local0:registerEventHandler("update_livestream_camera", CoD.PlayerMatchPartyLobby.UpdateLivestreamCamera)
	CoD.PlayerMatchPartyLobby.UpdateLivestreamCamera(f2_local0)
	return f2_local0
end

