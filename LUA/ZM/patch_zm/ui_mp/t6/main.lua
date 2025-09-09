require("T6.CoDBase")
require("T6.BonusCardButton")
require("T6.LiveNotification")
require("T6.SwitchLobbies")
require("T6.MainMenu")
require("T6.NumbersBackground")
require("T6.Options")
require("T6.Menus.Barracks")
require("T6.Menus.ClanTag")
require("T6.Menus.ConfirmLeavePopup")
require("T6.Menus.PrivateLocalGameLobby")
require("T6.Menus.PublicGameLobby")
require("T6.Menus.PrivateOnlineGameLobby")
require("T6.Menus.SplitscreenGameLobby")
require("T6.Menus.TheaterLobby")
require("T6.PlayerMatchPartyLobby")
require("T6.GameLobby")
require("T6.matchmaking")
if CoD.isZombie == true then
	require("T6.Zombie.BaseZombie")
	require("T6.Zombie.GameGlobeZombie")
	require("T6.Zombie.GameMapZombie")
	require("T6.Zombie.GameMoonZombie")
	require("T6.Zombie.GameRockZombie")
	require("T6.Zombie.NoLeavePopupZombie")
	require("T6.Zombie.SelectDifficultyLevelPopupZombie")
	require("T6.Zombie.SelectStartLocZombie")
	require("T6.Zombie.SelectMapZombie")
else
	require("T6.Menus.CAC")
	require("T6.Menus.CACChooseClass")
	require("T6.Menus.CACCamoMenu")
	require("T6.Menus.CACEditClass")
	require("T6.Menus.CACGrenadesAndEquipment")
	require("T6.Menus.CACKnifeMenu")
	require("T6.Menus.CACPerks")
	require("T6.Menus.CACRemoveItem")
	require("T6.Menus.CACReticles")
	require("T6.Menus.CACRewardsPopup")
	require("T6.Menus.CACSelectClass")
	require("T6.Menus.CACWeapons")
	require("T6.Menus.ChangeGameModePopup")
	require("T6.Menus.ChangeMapPopup")
	require("T6.Menus.LeagueGameLobby")
	require("T6.Menus.LeaguePlayPartyLobby")
	require("T6.Menus.ConfirmPurchasePopup")
	require("T6.Menus.ConfirmPrestigeUnlock")
	require("T6.Menus.ConfirmWeaponPrestige")
	require("T6.Menus.RemoveReward")
	require("T6.CACAttachmentsButton")
	require("T6.CACGridSelectionMenu")
	require("T6.CACPerksButton")
	require("T6.CACWeaponButton")
	require("T6.ClassButton")
	require("T6.Menus.CACAttachmentsMenu")
	require("T6.Menus.CACGrenades")
	require("T6.Menus.CACUtility")
	require("T6.Menus.CheckClasses")
end
if (CoD.isWIIU or CoD.isPC) and CoD.isWIIU then
	require("T6.Drc.DrcBase")
	require("T6.Drc.DrcPopup")
	require("T6.Drc.DrcMakePrimaryPopup")
	require("T6.WiiUSystemServices")
end
local f0_local0 = function (f1_arg0, f1_arg1)
	profiler.stop()
	DebugPrint("Profiler stopped.")
end

local f0_local1 = function (f2_arg0, f2_arg1)
	if f2_arg1.key == 115 then
		if f2_arg0.safeAreaOverlay.toggled then
			f2_arg0.safeAreaOverlay.toggled = false
			f2_arg0.safeAreaOverlay:close()
		else
			f2_arg0.safeAreaOverlay.toggled = true
			f2_arg0:addElement(f2_arg0.safeAreaOverlay)
		end
	elseif f2_arg1.key == 116 then
		f2_arg0:addElement(LUI.UITimer.new(1000, "profiler_stop", true))
		DebugPrint("Profiler started.")
		profiler.start("test.prof")
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	local f3_local0 = 500
	if CoD.isZombie == true then
		f3_local0 = 1
	end
	Engine.PlaySound("cac_globe_draw")
	f3_arg0:beginAnimation("wireframe_in", f3_local0)
	f3_arg0:setShaderVector(0, 1, 0, 0, 0)
end

local f0_local3 = function (f4_arg0, f4_arg1)
	local f4_local0 = 1000
	if CoD.isZombie == true then
		f4_local0 = 1
	end
	f4_arg0:beginAnimation("map_in", f4_local0)
	f4_arg0:setShaderVector(0, 2, 2, 0, 0)
end

function ShowGlobe()
	if not CoD.globe then
		return 
	elseif not CoD.globe.shown then
		CoD.globe.shown = true
		CoD.globe:beginAnimation("globe_ready", 1)
	end
end

function HideGlobe()
	if not CoD.globe then
		return 
	elseif CoD.globe.shown then
		CoD.globe.shown = nil
		if CoD.isZombie == true then
			CoD.GameGlobeZombie.MoveToOrigin()
		else
			CoD.globe:setShaderVector(0, 0, 0, 0, 0)
		end
	end
end

CoD.InviteAccepted = function (f7_arg0, f7_arg1)
	Engine.Exec(f7_arg1.controller, "setclientbeingusedandprimary")
	Engine.ExecNow(f7_arg1.controller, "initiatedemonwareconnect")
	local f7_local0 = f7_arg0:openPopup("popup_connectingdw", f7_arg1.controller)
	f7_local0.inviteAccepted = true
	f7_local0.callingMenu = f7_arg0
end

local f0_local4 = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = f8_arg1 .. "_preload"
	f8_arg0[f8_local0] = LUI.UITimer.new(250, f8_local0, false)
	f8_arg0:addElement(f8_arg0[f8_local0])
	f8_arg0:registerEventHandler(f8_local0, function (f11_arg0, f11_arg1)
		local f11_local0 = f8_arg1 .. "_preload"
		local f11_local1 = f8_arg2 .. "_preload"
		if f11_arg0[f11_local1] == nil then
			f11_arg0[f11_local1] = LUI.UIStreamedImage.new()
			f11_arg0[f11_local1]:setAlpha(0)
			f11_arg0:addElement(f11_arg0[f11_local1])
			f11_arg0[f11_local1]:registerEventHandler("streamed_image_ready", function (Sender, Event)
				if f8_arg3 ~= nil then
					f8_arg3(Sender, Event)
				end
				f8_arg0[f8_local0]:close()
			end)
			f11_arg0[f11_local0] = LUI.UIStreamedImage.new()
			f11_arg0[f11_local0]:setAlpha(0)
			f11_arg0:addElement(f11_arg0[f11_local0])
		end
		f11_arg0[f11_local1]:setImage(RegisterMaterial(f8_arg2))
		f11_arg0[f11_local1]:setupUIStreamedImage(0)
		f11_arg0[f11_local0]:setImage(RegisterMaterial(f8_arg1))
		f11_arg0[f11_local0]:setupUIStreamedImage(0)
	end)
	f8_arg0:processEvent({
		name = f8_local0
	})
end

LUI.createMenu.main = function ()
	local f9_local0 = UIExpression.GetMaxControllerCount()
	for Widget = 0, f9_local0 - 1, 1 do
		Engine.LockInput(Widget, true)
		Engine.SetUIActive(Widget, true)
	end
	LUI.roots.UIRootFull:addElement(CoD.SetupSafeAreaOverlay())
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget.name = "Main"
	if CoD.useMouse == true then
		CoD.Mouse.RegisterMaterials()
	end
	if not CoD.isZombie then
		local f9_local2 = 1280
		local f9_local3 = 400
		local f9_local4 = LUI.UIImage.new()
		f9_local4:setLeftRight(false, false, -f9_local2, f9_local2)
		f9_local4:setTopBottom(false, false, f9_local3 - f9_local2, f9_local3 + f9_local2)
		f9_local4:setXRot(-80)
		f9_local4:setImage(RegisterMaterial("ui_holotable_grid"))
		Widget:addElement(f9_local4)
		local f9_local5 = LUI.UIImage.new()
		f9_local5:setLeftRight(false, false, -f9_local2, f9_local2)
		f9_local5:setTopBottom(false, false, f9_local3 - f9_local2, f9_local3 + f9_local2)
		f9_local5:setXRot(-80)
		f9_local5:setImage(RegisterMaterial("ui_holotable_grid3"))
		f9_local5:setRGB(0.5, 0.5, 0.5)
		Widget:addElement(f9_local5)
		local f9_local6 = -32
		local f9_local7 = LUI.UIImage.new()
		f9_local7:setLeftRight(false, false, -f9_local2, f9_local2)
		f9_local7:setTopBottom(false, false, f9_local3 - f9_local2 + f9_local6, f9_local3 + f9_local2 + f9_local6)
		f9_local7:setXRot(-80)
		f9_local7:setImage(RegisterMaterial("ui_holotable_grid2"))
		Widget:addElement(f9_local7)
	end
	f9_local2 = nil
	if CoD.isZombie == true then
		f9_local2 = RegisterMaterial("lui_bkg_zm")
	else
		f9_local2 = RegisterMaterial("lui_bkg")
	end
	f9_local3 = nil
	if CoD.isZombie == true then
		Widget:addElement(LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			alpha = 1,
			red = 0,
			green = 0,
			blue = 0
		}))
		f9_local3 = LUI.UIStreamedImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			material = f9_local2
		})
		f9_local3:setupUIStreamedImage(0)
		if not CoD.isPC then
			f0_local4(Widget, "menu_zm_nuked_map", "menu_zm_nuked_map_blur", function (f13_arg0, f13_arg1)
				CoD.GameMapZombie.BlurredImages.menu_zm_nuked_map_blur = true
			end)
			f0_local4(Widget, "menu_zm_highrise_map", "menu_zm_highrise_map_blur", function (f14_arg0, f14_arg1)
				CoD.GameMapZombie.BlurredImages.menu_zm_highrise_map_blur = true
			end)
			f0_local4(Widget, "menu_zm_prison_map", "menu_zm_prison_map_blur", function (f15_arg0, f15_arg1)
				CoD.GameMapZombie.BlurredImages.menu_zm_prison_map_blur = true
			end)
			f0_local4(Widget, "menu_zm_buried_map", "menu_zm_buried_map_blur", function (f16_arg0, f16_arg1)
				CoD.GameMapZombie.BlurredImages.menu_zm_buried_map_blur = true
			end)
		end
	else
		f9_local3 = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			material = f9_local2
		})
	end
	Widget:addElement(f9_local3)
	local f9_local4 = -810
	local f9_local5 = 460
	local f9_local6 = 720
	local f9_local7 = nil
	if CoD.isZombie == true then
		f9_local7 = RegisterMaterial("ui_globe_zm")
	else
		f9_local7 = RegisterMaterial("ui_globe")
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, f9_local4, f9_local4 + f9_local6)
	Widget:setTopBottom(false, false, f9_local5 - f9_local6, f9_local5)
	Widget:setImage(f9_local7)
	Widget:setAlpha(1)
	Widget:setShaderVector(0, 0, 0, 0, 0)
	Widget:setupGlobe()
	Widget:registerEventHandler("transition_complete_globe_ready", f0_local2)
	Widget:registerEventHandler("transition_complete_wireframe_in", f0_local3)
	CoD.globe = Widget
	local Widget, f9_local10 = nil
	if CoD.isZombie == true then
		Widget = LUI.UIElement.new()
		Widget:addElement(Widget)
		f9_local10 = LUI.UIImage.new()
		Widget:addElement(f9_local10)
	end
	Widget:addElement(Widget)
	if CoD.isZombie == true then
		CoD.GameGlobeZombie.Init(Widget)
		CoD.GameMapZombie.Init(f9_local3, f9_local2)
		local Widget = LUI.UIElement.new()
		Widget:addElement(Widget)
		local Widget = LUI.UIElement.new()
		Widget:addElement(Widget)
		CoD.GameRockZombie.Init(Widget, Widget)
		local f9_local13 = LUI.UIImage.new()
		Widget:addElement(f9_local13)
		CoD.GameMoonZombie.Init(f9_local13, Widget, f9_local10)
		local Widget = LUI.UIElement.new()
		Widget:addElement(Widget)
		CoD.Fog.Init(Widget)
	end
	if CoD.isMultiplayer then
		local Widget = LUI.UIImage.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setRGB(0, 0, 0)
		Widget:setAlpha(0.15)
		Widget:addElement(Widget)
	end
	Widget:addElement(LUI.createMenu.BlackMenu())
	Widget:registerEventHandler("keydown", f0_local1)
	Widget:registerEventHandler("profiler_stop", f0_local0)
	Widget:registerEventHandler("live_notification", CoD.LiveNotifications.NotifyMessage)
	Engine.PlayMenuMusic("mus_mp_frontend")
	Engine.Exec(nil, "checkforinvites")
	return Widget
end

LUI.createMenu.BlackMenu = function (f10_arg0)
	local f10_local0 = CoD.Menu.New("BlackMenu")
	local f10_local1 = LUI.UIImage.new()
	f10_local1:setLeftRight(false, false, -640, 640)
	f10_local1:setTopBottom(false, false, -360, 360)
	f10_local1:setRGB(0, 0, 0)
	f10_local0:addElement(f10_local1)
	f10_local0:registerEventHandler("open_menu", CoD.Lobby.OpenMenu)
	f10_local0:registerEventHandler("invite_accepted", CoD.inviteAccepted)
	return f10_local0
end

DisableGlobals()
Engine.StopEditingPresetClass()
