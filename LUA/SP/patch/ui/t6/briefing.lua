require("T6.RTSLoader")
require("T6.RTSTutorial")
CoD.Briefing = {}
CoD.Briefing.showSkipButton = true
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg0.rtsLoader then
		f1_arg0.rtsLoader:close()
		f1_arg0.rtsLoader = nil
	end
	if f1_arg0.tutorial then
		f1_arg0.tutorial:close()
		f1_arg0.tutorial = nil
	end
	f1_arg0:removeAllChildren()
	f1_arg0:close()
	Engine.SetDvar("r_loadingScreen", 0)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) and not CoD.RTSTutorial.SeenTutorial() and not CoD.RTSTutorial.Active then
		f2_arg0.tutorial = CoD.RTSTutorial.new()
		if f2_arg0.tutorial ~= nil then
			f2_arg0.rtsContainer:addElement(f2_arg0.tutorial)
			f2_arg0.tutorial:fadeOutBackground()
			CoD.RTSTutorial.AddChangePagesButton(f2_arg0.rtsContainer)
			CoD.RTSTutorial.AddSelectButton(f2_arg0.tutorial)
			return 
		end
	end
	Engine.SetDvar("ui_luiLoadingScreen", 0)
	f0_local0(f2_arg0, f2_arg1)
	Engine.Exec(nil, "playerstart")
end

local f0_local2 = function (f3_arg0)
	if Dvar.ui_singlemission:get() == 1 then
		return false
	elseif f3_arg0 == "nicaragua" then
		Engine.StartLoadingCinematic("nicaragua_frontend", false)
	elseif f3_arg0 == "panama_3" then
		Engine.StartLoadingCinematic("panama_frontend", false)
	elseif f3_arg0 == "blackout" then
		if 1 == UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "CHINA_IS_ALLY") and UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "BRIGGS_DEAD") == 0 then
			Engine.StartLoadingCinematic("blackout_frontenda", false)
		else
			Engine.StartLoadingCinematic("blackout_frontendb", false)
		end
	elseif f3_arg0 == "angola_2" or f3_arg0 == "pakistan_3" or f3_arg0 == "karma_2" or f3_arg0 == "yemen" then
		Engine.StartLoadingCinematic("vtol_outro_1_frontend", false)
	elseif f3_arg0 == "haiti" then
		local f3_local0 = UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "MENENDEZ_DEAD_IN_HAITI") == 0
		local f3_local1 = UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "MASON_SR_DEAD") == 0
		local f3_local2
		if UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "KARMA_DEAD_IN_KARMA") ~= 0 or UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "KARMA_DEAD_IN_COMMAND_CENTER") ~= 0 or UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "KARMA_CAPTURED") ~= 0 and 1 ~= UIExpression.GetDStat(controller, "PlayerCareerStats", "storypoints", "SO_WAR_SOCOTRA_SUCCESS") then
			f3_local2 = false
		else
			f3_local2 = true
		end
		if not f3_local0 then
			if not f3_local1 then
				Engine.StartLoadingCinematic("b3_revolution", false)
			else
				Engine.StartLoadingCinematic("evd;a2_vault_jr_dead;b3_revolution;evd", false)
			end
		elseif not f3_local1 then
			if f3_local2 then
				Engine.StartLoadingCinematic("b1_karma_alive2", false)
			else
				Engine.StartLoadingCinematic("b2_karma_dead2;c1_karma_dead;evn", false)
			end
		elseif f3_local2 then
			Engine.StartLoadingCinematic("evd;a2_vault_jr_dead;b1_karma_alive2;evd", false)
		else
			Engine.StartLoadingCinematic("evd;a2_vault_jr_dead;b2_karma_dead2;c1_karma_dead;evn", false)
		end
	else
		return false
	end
	return true
end

local f0_local3 = function (f4_arg0, f4_arg1)
	CoD.Briefing.showSkipButton = true
	local f4_local0 = UIExpression.GetPrimaryController()
	if f4_arg0.image then
		f4_arg0.image:setAlpha(1)
	end
	Engine.SetDvar("ui_drawSpinnerAfterMovie", 0)
	if f4_arg1.levelName == "frontend" then
		if UIExpression.DvarBool(nil, "ui_saveandquit") == 0 then
			if UIExpression.DvarInt(nil, "com_introPlayed") == 0 then
				CoD.Briefing.showSkipButton = false
				if not CoD.isWIIU then
					Engine.StartLoadingCinematic("dolby", false)
				end
				Engine.StartLoadingCinematic("treyarch", true)
				if Engine.GetProfileVarInt(f4_local0, "com_first_time") == 1 or CoD.isPC then
					Engine.StartLoadingCinematic("intro", true)
				end
			else
				if not f0_local2(f4_arg1.previousLevelName) and f4_arg1.previousLevelName ~= "" then
					Engine.StartLoadingCinematic("vtol_outro_2_frontend", false)
				end
				Engine.SetDvar("ui_drawSpinnerAfterMovie", 1)
			end
		else
			if f4_arg1.previousLevelName == "monsoon" or f4_arg1.previousLevelName == "pakistan" or f4_arg1.previousLevelName == "pakistan_2" or f4_arg1.previousLevelName == "pakistan_3" or f4_arg1.previousLevelName == "la_1" or f4_arg1.previousLevelName == "la_1b" or f4_arg1.previousLevelName == "la_2" or f4_arg1.previousLevelName == "haiti" then
				Engine.StartLoadingCinematic("vtol_outro_2_frontend", false)
			else
				Engine.StartLoadingCinematic("vtol_outro_1_frontend", false)
			end
			Engine.SetDvar("ui_drawSpinnerAfterMovie", 1)
		end
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		if f4_arg0.image then
			f4_arg0.image:setImage(nil)
			f4_arg0.image:setAlpha(0)
		end
		f4_arg0.rtsLoader = CoD.RTSLoader.new(f4_arg1.levelName)
		f4_arg0.rtsContainer:addElement(f4_arg0.rtsLoader)
		Engine.SetDvar("ui_luiLoadingScreen", 1)
	else
		if f4_arg1.levelName == "angola_2" or f4_arg1.levelName == "karma_2" or f4_arg1.levelName == "la_1b" or f4_arg1.levelName == "la_2" or f4_arg1.levelName == "pakistan_2" or f4_arg1.levelName == "pakistan_3" or f4_arg1.levelName == "panama_2" or f4_arg1.levelName == "panama_3" or f4_arg1.previousLevelName == "haiti" then
			CoD.Briefing.showSkipButton = false
		end
		if f4_arg1.previousLevelName ~= "frontend" and f4_arg1.previousLevelName ~= "so_cmp_frontend" and f4_arg1.previousLevelName ~= "" and UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, f4_arg1.previousLevelName, 0) < UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, f4_arg1.levelName, 0) then
			f0_local2(f4_arg1.previousLevelName)
		end
		local f4_local1 = ""
		if f4_arg1.levelName == "karma" then
			if UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "HARPER_SCARRED") == 1 then
				f4_local1 = f4_local1 .. "karma_load_b;"
			else
				f4_local1 = f4_local1 .. "karma_load_a;"
			end
		elseif f4_arg1.levelName == "yemen" then
			if UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "KARMA_DEAD_IN_KARMA") == 1 or UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "KARMA_CAPTURED") == 1 and UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "SO_WAR_SOCOTRA_SUCCESS") == 0 then
				f4_local1 = f4_local1 .. "yemen_load_2b;"
			else
				f4_local1 = f4_local1 .. "yemen_load_2a;"
			end
			f4_local1 = f4_local1 .. "yemen_load_3;"
		elseif f4_arg1.levelName == "blackout" then

		else
			f4_local1 = f4_local1 .. f4_arg1.levelName .. "_load;"
		end
		if f4_arg1.levelName == "blackout" then
			if UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "CHINA_IS_ALLY") == 1 then
				f4_local1 = f4_local1 .. "blackout_load_2b;"
			else
				f4_local1 = f4_local1 .. "blackout_load_2a;"
			end
			f4_local1 = f4_local1 .. "blackout_load_3;"
		elseif f4_arg1.levelName == "la_1" then
			if UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "CHINA_IS_ALLY") == 1 then
				f4_local1 = f4_local1 .. "la_1_load_2a;"
			else
				f4_local1 = f4_local1 .. "la_1_load_2b;"
			end
			f4_local1 = f4_local1 .. "la_1_load_3;"
		elseif f4_arg1.levelName == "haiti" then
			if UIExpression.GetDStat(f4_local0, "PlayerCareerStats", "storypoints", "CHINA_IS_ALLY") == 1 then
				f4_local1 = f4_local1 .. "haiti_load_2a;"
			else
				f4_local1 = f4_local1 .. "haiti_load_2b;"
			end
			f4_local1 = f4_local1 .. "haiti_load_3;"
		end
		Engine.StartLoadingCinematic(f4_local1, false)
		Engine.SetDvar("ui_drawSpinnerAfterMovie", 1)
	end
end

local f0_local4 = function (f5_arg0, f5_arg1)
	if f5_arg1.button == "left" then
		f5_arg0:processEvent({
			name = "button_action"
		})
	end
end

local f0_local5 = function (f6_arg0, f6_arg1)
	local f6_local0, f6_local1 = Engine.GetUserSafeArea()
	local f6_local2 = Dvar.ui_errorMessage:get()
	if f6_local2 ~= "" then
		f6_arg0.errorText = LUI.UIText.new({
			left = -f6_local0 / 2,
			top = 36,
			right = f6_local0 / 2,
			bottom = 36 + CoD.textSize.Condensed,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			font = CoD.fonts.Condensed,
			alignment = LUI.Alignment.Left
		})
		f6_arg0:addElement(f6_arg0.errorText)
		f6_arg0.errorText:setText(f6_local2)
		Dvar.ui_errorMessage:set("")
	end
	if CoD.Briefing.showSkipButton then
		if not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
			f6_arg0.continueButton:registerEventHandler("hide_continue_button", CoD.Briefing.HideContinueButton)
			f6_arg0.continueButton:addElement(LUI.UITimer.new(5000, "hide_continue_button", true, f6_arg0.continueButton))
		end
		f6_arg0.continueButton:beginAnimation("show", 1000)
		f6_arg0.continueButton:setAlpha(1)
	end
	LUI.UIButton.gainFocus(f6_arg0.continueButton, f6_arg1)
end

local f0_local6 = function (f7_arg0, f7_arg1)
	f7_arg0.image:setShaderVector(0, f7_arg1.xstart, f7_arg1.xend, f7_arg1.ystart, f7_arg1.yend)
end

local f0_local7 = function (f8_arg0, f8_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		f8_arg0:setImage(nil)
		f8_arg0:setAlpha(0)
	elseif UIExpression.IsCinematicWebm() == 1 then
		if not f8_arg0.iswebm then
			f8_arg0:setImage(RegisterMaterial("webm_720p"))
			f8_arg0.iswebm = true
		end
	elseif f8_arg0.iswebm then
		f8_arg0:setImage(RegisterMaterial("cinematic"))
		f8_arg0.iswebm = false
	end
end

CoD.Briefing.HideContinueButton = function (f9_arg0, f9_arg1)
	f9_arg0:beginAnimation("hide", 1000)
	f9_arg0:setAlpha(0)
end

LUI.createMenu.Briefing = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Engine.SetDvar("r_loadingScreen", 1)
	Widget.image = LUI.UIImage.new()
	Widget.image:setLeftRight(true, true, 0, 0)
	if CoD.isPC then
		local f10_local1 = (720 - 720 * Engine.GetAspectRatio() * 0.56) / 2
		Widget.image:setTopBottom(true, true, f10_local1, -f10_local1)
	elseif Dvar.wideScreen:get() == true then
		Widget.image:setTopBottom(true, true, 0, 0)
	else
		Widget.image:setTopBottom(true, true, 90, -90)
	end
	Widget.image:setImage(RegisterMaterial("cinematic"))
	Widget.image.iswebm = false
	Widget.image:setShaderVector(0, 0, 0, 0, 0)
	Widget:addElement(Widget.image)
	local f10_local2, f10_local1 = Engine.GetUserSafeArea()
	Widget.safearea = LUI.UIElement.new()
	Widget.safearea:setLeftRight(false, false, -f10_local2 / 2, f10_local2 / 2)
	Widget.safearea:setTopBottom(false, false, -f10_local1 / 2, f10_local1 / 2)
	Widget:addElement(Widget.safearea)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setupCinematicSubtitles()
	Widget.safearea:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.rtsContainer = Widget
	Widget:addElement(Widget.rtsContainer)
	local f10_local5 = {}
	f10_local5 = GetTextDimensions(Engine.Localize("PLATFORM_SKIP"), CoD.fonts.Condensed, CoD.textSize.Condensed)
	local f10_local6 = 15
	local f10_local7 = 15
	Widget.continueButton = LUI.UIButton.new()
	Widget.continueButton:setLeftRight(false, false, -f10_local2, f10_local2 / 2 - f10_local6)
	Widget.continueButton:setTopBottom(false, false, f10_local1 / 2 - CoD.textSize.Condensed - f10_local7, f10_local1 / 2 - f10_local7)
	Widget.continueButton:setAlignment(LUI.Alignment.Right)
	Widget.continueButton:setAlpha(0)
	Widget.continueButton:setActionEventName("briefing_startplay")
	Widget:addElement(Widget.continueButton)
	Widget.continueButton:addElement(CoD.ButtonPrompt.new("start", "", Widget, "briefing_startplay", true))
	Widget.continueButton.label = LUI.UIText.new()
	Widget.continueButton.label:setLeftRight(true, true, 0, 0)
	Widget.continueButton.label:setTopBottom(true, true, 0, 0)
	Widget.continueButton.label:setFont(CoD.fonts.Condensed)
	Widget.continueButton.label:setAlignment(LUI.Alignment.Right)
	Widget.continueButton:addElement(Widget.continueButton.label)
	Widget.continueButton.label:setText(Engine.Localize("PLATFORM_SKIP"))
	Widget.continueButton:setHandleMouse(false)
	Widget:registerEventHandler("mouseup", f0_local4)
	Widget:registerEventHandler("briefing_hide", f0_local0)
	Widget:registerEventHandler("briefing_displaycontinue", f0_local5)
	Widget:registerEventHandler("briefing_startplay", f0_local1)
	Widget:registerEventHandler("briefing_startcinematic", f0_local3)
	Widget:registerEventHandler("briefing_setmaturefilter", f0_local6)
	Widget.image:registerEventHandler("briefing_updateimage", f0_local7)
	Widget:addElement(LUI.UITimer.new(16, "briefing_updateimage", false, Widget.image))
	return Widget
end

