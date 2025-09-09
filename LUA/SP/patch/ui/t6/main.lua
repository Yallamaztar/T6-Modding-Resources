require("T6.CoDBase")
require("T6.MainMenu")
require("T6.Options")
require("T6.Menus.AARUtility")
require("T6.Menus.AfterActionReportMenu")
require("T6.Menus.CACLoadOutMenu")
require("T6.Menus.CACSelectAttachments")
require("T6.Menus.CACSelectCamo")
require("T6.Menus.CACSelectGrenade")
require("T6.Menus.CACSelectPerks")
require("T6.Menus.CACSelectWeapon")
require("T6.Menus.CareerOverviewMenu")
require("T6.Menus.CampaignMenu")
require("T6.Menus.DevSPStoryMenu")
require("T6.Menus.DifficultyMenu")
require("T6.Menus.FrontendSaveGameErrorPopup")
require("T6.Menus.LockOutMenu")
require("T6.Menus.MissionBriefing")
require("T6.Menus.CampaignMissionBriefing")
require("T6.Menus.MissionSelect")
if CoD.isWIIU then
	require("T6.LiveNotification")
end
if CoD.isZombie == false then
	require("T6.AttachmentGridButton")
	require("T6.CACAttachmentsButton")
	require("T6.CACGridSelectionMenu")
	require("T6.CACPerksButton")
	require("T6.CACWeaponGridButton")
	require("T6.ClassButton")
	require("T6.Menus.CACAttachmentsMenu")
	require("T6.Menus.CACGrenades")
	require("T6.Menus.CACUtility")
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
	local f3_local0 = f3_arg1.controller
	if f3_local0 and UIExpression.IsProfileSignedIn(f3_local0) == 1 and UIExpression.ProfileInt(f3_local0, "com_first_time") == 1 and UIExpression.DvarBool(nil, "sv_saveDeviceAvailable") == 1 then
		if CoD.isPC then
			if not CoD.Options.SupportsMatureContent() then
				Engine.ExecNow(f3_local0, "setprofile com_first_time 0")
				Engine.ExecNow(f3_local0, "updategamerprofile")
				CoD.perController[f3_arg1.controller].firstTime = nil
				f3_arg0:addElement(LUI.createMenu.MainMenu(f3_local0))
			else
				CoD.perController[f3_local0].firstTime = true
				f3_arg0:addElement(LUI.createMenu.MatureContentPopup(f3_arg1.controller))
			end
		else
			f3_arg0:addElement(LUI.createMenu.ConfigureSettingsPopup(f3_arg1.controller))
		end
	else
		f3_arg0:addElement(LUI.createMenu.MainMenu(f3_local0))
	end
end

LUI.createMenu.main = function (f4_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.menuName = "Main"
	if (CoD.ShadesHud.bootupComplete == true or 0 ~= UIExpression.DvarBool(nil, "ui_skipMainLockout")) and Dvar.sv_saveDeviceAvailable:get() then
		Engine.ExecNow(f4_arg0, "update_sv_savegameavailable")
	end
	if CoD.useMouse == true then
		CoD.Mouse.RegisterMaterials()
	end
	CoD.Menu.backOutSFX = "uin_cmn_backout"
	CoD.AARUtility.LoadMaps()
	Widget.safeAreaOverlay = LUI.UISafeAreaOverlay.new()
	Widget.safeAreaOverlay.toggled = false
	Widget:registerAnimationState("hide", {
		alpha = 0
	})
	Widget:registerAnimationState("show", {
		alpha = 1
	})
	Widget:registerEventHandler("keydown", f0_local1)
	Widget:registerEventHandler("profiler_stop", f0_local0)
	Widget:registerEventHandler("open_main_menu", f0_local2)
	if CoD.isWIIU then
		Widget:registerEventHandler("live_notification", CoD.LiveNotifications.NotifyMessage)
	end
	local f4_local1 = Dvar.ui_singlemission:get()
	Dvar.ui_singlemission:set(0)
	local f4_local2
	if 0 == Dvar.ui_saveandquit:get() or f4_local1 ~= 0 then
		f4_local2 = false
	else
		f4_local2 = true
	end
	Dvar.ui_saveandquit:set(0)
	CoD.MissionBriefing.LoadDefault = true
	local f4_local3 = string.sub(Dvar.ui_aarmapname:get(), 0, 6)
	local f4_local4 = Dvar.ui_mapname:get()
	CoD.Menu.freeRoam = false
	local f4_local5 = false
	if UIExpression.DvarBool(nil, "ui_skipMainLockout") == 1 and f4_local1 == 0 then

	else

	end
	CoD.Menu.newStrikeForceAvailable = false
	local f4_local6 = false
	if f4_local1 == 0 and f4_local4 ~= "" then
		if UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, Dvar.ui_mapname:get(), 2) == "" or UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, Dvar.ui_mapname:get(), 8) ~= "CMP" then
			f4_local6 = false
		else
			f4_local6 = true
		end
		if not f4_local6 then
			DebugPrint("^1LUI Warning: main.lua received Dvar.ui_mapname " .. f4_local4 .. " that either does not exist in levelLookup.csv column 1 OR is not marked as a CMP level. Returning to the lockout menu.")
		end
	end
	Dvar.ui_campaignstate:set(0)
	if f4_local1 ~= 0 then
		CoD.Menu.targetLandingMenu = "MissionSelectMenu"
	elseif f4_local3 == "so_rts" or f4_local5 == true then
		CoD.Menu.targetLandingMenu = "CareerOverviewMenu"
		CoD.Menu.freeRoam = true
		CoD.Menu.newStrikeForceAvailable = f4_local5
		Dvar.ui_campaignstate:set(1)
	elseif f4_local4 == "credits" then
		CoD.Menu.targetLandingMenu = "CampaignMenu"
		CoD.Menu.freeRoam = true
	elseif f4_local2 == true and f4_local1 == 0 then
		CoD.Menu.targetLandingMenu = "CampaignMenu"
	elseif f4_local6 then
		CoD.Menu.targetLandingMenu = "CareerOverviewMenu"
		Dvar.ui_campaignstate:set(1)
	else
		CoD.Menu.targetLandingMenu = "LockOutMenu"
	end
	if CoD.Menu.targetLandingMenu == "CareerOverviewMenu" then
		CoD.CareerOverviewMenu.MapHighlight = Dvar.ui_aarmapname:get()
		CoD.StoryOverviewMenu.MapHighlight = CoD.CareerOverviewMenu.MapHighlight
		CoD.Unlockables.AddLevelUnlockables(Dvar.ui_aarmapname:get())
	end
	local f4_local7 = LUI.createMenu[CoD.Menu.targetLandingMenu](f4_arg0)
	Widget:addElement(f4_local7)
	if CoD.Menu.targetLandingMenu == "CareerOverviewMenu" then
		Engine.Exec(f4_arg0, "clearKeyStates")
		f4_local7:selectStoryTab()
	end
	if CoD.Menu.targetLandingMenu ~= "LockOutMenu" then
		if f4_local4 == "credits" then
			Engine.SendMenuResponse(f4_arg0, "lockout", "start_credits")
		elseif CoD.Menu.freeRoam then
			Engine.SendMenuResponse(f4_arg0, "lockout", "skipped_freeroam")
		else
			Engine.SendMenuResponse(f4_arg0, "lockout", "skipped")
		end
	end
	return Widget
end

DisableGlobals()
