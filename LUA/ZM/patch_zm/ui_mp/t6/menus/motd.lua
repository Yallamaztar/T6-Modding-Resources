CoD.MOTD = {}
CoD.MOTD.MessageTop = 80
CoD.MOTD.MessageWidth = 450
CoD.MOTD.MessageHeight = 310
CoD.MOTD.ImagePadding = 130
CoD.MOTD.DownloadCheckInterval = 200
CoD.MOTD.PopulateActionText = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = CoD.ButtonPrompt.new
	local f1_local1 = "alt1"
	local f1_local2 = Engine.Localize(f1_arg1)
	local f1_local3 = f1_arg3
	local f1_local4 = f1_arg2
	local f1_local5, f1_local6 = false
	local f1_local7, f1_local8 = false
	f1_arg0:addElement(f1_local0(f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, "P"))
end

CoD.MOTD.GetImageFileID = function (f2_arg0)
	if f2_arg0 ~= nil and f2_arg0 ~= "" then
		return Engine.GetMOTDImageFileID(f2_arg0)
	else
		return "0"
	end
end

CoD.MOTD.AddAction = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0, f3_local1 = nil
	if f3_arg2 ~= nil then
		if f3_arg2 == "buyfrommotdcontext" then
			f3_local0 = "motd_buy_now"
			if f3_arg4 ~= nil then
				f3_local1 = f3_arg4
			else
				f3_local1 = "MENU_BUY_NOW"
			end
		end
		if f3_arg2 == "buyfrombannercontext" then
			f3_local0 = "banner_buy_now"
			if f3_arg4 ~= nil then
				f3_local1 = f3_arg4
			else
				f3_local1 = "MENU_PURCHASE_SEASON_PASS"
			end
		end
		if f3_arg2 == "playmoviefrombannercontext" then
			f3_local0 = "banner_play_movie_now"
			if f3_arg4 ~= nil then
				f3_local1 = f3_arg4
			else
				f3_local1 = "MENU_WATCH_VIDEO"
			end
			Engine.Url_Load_Init()
			Engine.Url_Load_MeasureDownloadBandwidth("akamai://rand.bin")
			f3_arg0:registerEventHandler("download_check", CoD.MOTD.VideoDownloadCheck)
			f3_arg0.downloadTimer = LUI.UITimer.new(CoD.MOTD.DownloadCheckInterval, "download_check", true, f3_arg0)
			f3_arg0:addElement(f3_arg0.downloadTimer)
			local f3_local2 = 10
			f3_arg0.spinner = LUI.UIImage.new()
			f3_arg0.spinner:setLeftRight(false, true, -64 - f3_local2, -f3_local2)
			f3_arg0.spinner:setTopBottom(false, false, -32, 32)
			f3_arg0.spinner:setImage(RegisterMaterial("lui_loader"))
			f3_arg0.spinner:setShaderVector(0, 0, 0, 0, 0)
			f3_arg0.bannerContainer:addElement(f3_arg0.spinner)
		end
	end
	if f3_local0 ~= nil and f3_local1 ~= nil then
		CoD.MOTD.PopulateActionText(f3_arg1, f3_local1, f3_local0, f3_arg0)
	else
		f3_arg1:setAlpha(0)
	end
end

CoD.MOTD.Accept = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "resetThumbnailViewer")
	if f4_arg0.m_version == nil then
		f4_arg0.m_version = 0
	end
	if Dvar.tu13_recordContentAvailable:get() == true then
		Engine.RecordContentAvailable(f4_arg1.controller)
	end
	Engine.ExecNow(f4_arg1.controller, "setMOTDViewed " .. f4_arg0.m_version)
	Engine.Url_Load_Destroy()
	f4_arg0:goBack()
	f4_arg0.occludedMenu:processEvent({
		name = "motd_popup_closed",
		controller = f4_arg1.controller
	})
end

CoD.MOTD.SignedOut = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0:getRoot()
	f5_arg0:goBack(f5_arg1.controller)
	f5_local0:processEvent({
		name = "open_popup",
		popupName = "signed_out",
		controller = f5_arg1.controller
	})
end

CoD.MOTD.ButtonPromptBack = function (f6_arg0, f6_arg1)
	Engine.Url_Load_Destroy()
	CoD.Menu.ButtonPromptBack(f6_arg0, f6_arg1)
end

CoD.MOTD.VideoDownloadCheck = function (f7_arg0, f7_arg1)
	if f7_arg0.downloadTimer then
		f7_arg0.downloadTimer:close()
		f7_arg0.downloadTimer = nil
	end
	if Engine.Url_Load_MeasureDownloadBandwidth("akamai://rand.bin") ~= -1 then
		f7_arg0.spinner:setAlpha(0)
	else
		f7_arg0.downloadTimer = LUI.UITimer.new(CoD.MOTD.DownloadCheckInterval, "download_check", true)
		f7_arg0:addElement(f7_arg0.downloadTimer)
	end
end

CoD.MOTD.BuyFromMOTDContext = function (f8_arg0, f8_arg1)

end

CoD.MOTD.BuyFromBannerContext = function (f9_arg0, f9_arg1)
	if CoD.isPS3 then
		f9_arg0:goBack(f9_arg1.controller)
		CoD.MainLobby.OpenStore(f9_arg0.occludedMenu, f9_arg1)
	elseif CoD.isXBOX then
		if f9_arg0.bannerActionContext ~= nil and f9_arg0.bannerActionContext ~= "" then
			local f9_local0 = {}
			local f9_local1 = 1
			for f9_local5 in string.gmatch(f9_arg0.bannerActionContext, "[^%s]+") do
				f9_local0[f9_local1] = f9_local5
				f9_local1 = f9_local1 + 1
			end
			Engine.ExecNow(f9_arg1.controller, "buyOfferFromMOTD " .. f9_local0[1] .. " " .. f9_local0[2])
		else
			f9_arg0:goBack(f9_arg1.controller)
			CoD.MainLobby.OpenStore(f9_arg0.occludedMenu, f9_arg1)
		end
	elseif CoD.isPC then
		Engine.ShowSteamStore(f9_arg0.bannerActionContext)
	end
end

CoD.MOTD.PlayMovieFromBannerContext = function (f10_arg0, f10_arg1)
	if f10_arg0.bannerActionContext and f10_arg0.bannerActionContext ~= "" then
		f10_arg0.url = f10_arg0.bannerActionContext
		f10_arg0.url = f10_arg0.url .. "_" .. Engine.GetLangAbbr()
		local f10_local0 = Engine.Url_Load_MeasureDownloadBandwidth("akamai://rand.bin")
		if string.sub(f10_arg0.url, -2, -2) == "_" or f10_local0 ~= -1 then
			CoD.Codtv.VideoCardClearPlayback()
			local f10_local1 = f10_arg0.url .. "_low.webm"
			local f10_local2 = "ps3"
			if CoD.isXBOX then
				f10_local2 = "xbox"
			end
			if f10_local0 > 524288 then
				f10_local1 = f10_arg0.url .. "_" .. f10_local2 .. "_4.webm"
			elseif f10_local0 > 393216 then
				f10_local1 = f10_arg0.url .. "_" .. f10_local2 .. "_3.webm"
			elseif f10_local0 > 262144 then
				f10_local1 = f10_arg0.url .. "_" .. f10_local2 .. "_2.webm"
			elseif f10_local0 > 131072 then
				f10_local1 = f10_arg0.url .. "_" .. f10_local2 .. "_1.webm"
			end
			if string.sub(f10_arg0.url, -2, -2) == "_" then
				f10_local1 = f10_arg0.url .. ".webm"
			end
			CoD.Codtv.WebMPlayback = Engine.WebM_Open(f10_local1, CoD.Codtv.WebMPlaybackMaterial)
			CoD.perController[f10_arg1.controller].url = f10_local1
			CoD.Codtv.VideoCardPlay(f10_arg0:openPopup("Video_Player", f10_arg1.controller))
		end
	end
end

CoD.MOTD.DescriptorsDone = function (f11_arg0, f11_arg1)
	if f11_arg0.image ~= nil and f11_arg0.imageID ~= nil then
		f11_arg0.image:setAlpha(1)
		f11_arg0.image:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, CoD.MOTD.GetImageFileID(f11_arg0.imageID))
		Engine.Exec(f11_arg1.controller, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_MOTD .. " " .. CoD.MOTD.GetImageFileID(f11_arg0.imageID) .. " 1")
	end
	if f11_arg0.bannerImage ~= nil and f11_arg0.bannerImageID ~= nil then
		f11_arg0.bannerImage:setAlpha(1)
		f11_arg0.bannerImage:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, CoD.MOTD.GetImageFileID(f11_arg0.bannerImageID))
		Engine.Exec(f11_arg1.controller, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_MOTD .. " " .. CoD.MOTD.GetImageFileID(f11_arg0.bannerImageID) .. " 1")
	end
end

LUI.createMenu.MOTD = function (f12_arg0)
	local f12_local0 = CoD.Menu.New("MOTD")
	f12_local0:addLargePopupBackground()
	if not CoD.isZombie then
		f12_local0:addTitle(Engine.Localize("MENU_MESSAGE_OF_THE_DAY"))
	end
	local f12_local1 = "MENU_MOTD_ACCEPT"
	if CoD.isZombie then
		f12_local1 = "MENU_ACCEPT"
	end
	local f12_local2 = Engine.GetMOTD()
	if f12_local2.isValid == true then
		f12_local0.m_version = f12_local2.motdVersion
		f12_local0.m_actionContext = f12_local2.actionContext
		local f12_local3 = CoD.MOTD.MessageTop
		local f12_local4 = LUI.UIText.new()
		f12_local4:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
		f12_local4:setTopBottom(true, false, f12_local3, f12_local3 + CoD.textSize.Big)
		f12_local4:setFont(CoD.fonts.Big)
		f12_local4:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f12_local4:setText(f12_local2.title)
		f12_local0:addElement(f12_local4)
		f12_local3 = f12_local3 + CoD.textSize.Big + 10
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
		Widget:setTopBottom(true, false, f12_local3, f12_local3 + CoD.MOTD.MessageHeight)
		f12_local0:addElement(Widget)
		local f12_local6 = LUI.UIText.new(nil, true)
		f12_local6:setLeftRight(true, true, 0, 0)
		f12_local6:setTopBottom(true, false, 0, CoD.textSize.ExtraSmall)
		f12_local6:setFont(CoD.fonts.ExtraSmall)
		f12_local6:setText(f12_local2.message)
		f12_local6:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f12_local6:setAlignment(LUI.Alignment.Left)
		Widget:addElement(f12_local6)
		f12_local3 = f12_local3 + CoD.MOTD.MessageHeight
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
		Widget:setTopBottom(true, false, f12_local3, f12_local3 + CoD.textSize.Condensed)
		Widget:addElement(CoD.Border.new(1, 0.5, 0.5, 0.5, 0.2, -3))
		f12_local0:addElement(Widget)
		local f12_local8 = LUI.UIImage.new()
		f12_local8:setLeftRight(true, true, 2, -2)
		f12_local8:setTopBottom(true, false, 2, CoD.textSize.Condensed * 0.6)
		f12_local8:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f12_local8:setAlpha(0.1)
		Widget:addElement(f12_local8)
		CoD.MOTD.AddAction(f12_local0, Widget, f12_local2.action, f12_local2.actionContext, f12_local2.actionString)
		local f12_local9 = LUI.UIImage.new()
		f12_local9:setLeftRight(true, false, CoD.MOTD.ImagePadding + CoD.MOTD.MessageWidth, CoD.MOTD.MessageWidth + CoD.MOTD.ImagePadding + 256)
		f12_local9:setTopBottom(true, false, CoD.MOTD.MessageTop + 50, CoD.MOTD.MessageTop + 50 + 256)
		f12_local9:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, CoD.MOTD.GetImageFileID(f12_local2.image))
		f12_local9:setAlpha(0)
		f12_local0:addElement(f12_local9)
		f12_local0.imageID = f12_local2.image
		f12_local0.image = f12_local9
		if f12_local2.bannerImage ~= "" then
			local f12_local10 = "Default"
			local f12_local11 = CoD.fonts[f12_local10]
			local f12_local12 = CoD.textSize[f12_local10]
			local f12_local13 = 2
			local f12_local14 = f12_local12 * 3 + f12_local13
			local f12_local15 = CoD.Menu.Width - 10 * 2
			local f12_local16 = CoD.ButtonPrompt.Height + 20
			local f12_local17 = 4
			
			local bannerContainer = LUI.UIElement.new()
			bannerContainer:setLeftRight(false, false, -(f12_local15 / 2), f12_local15 / 2)
			bannerContainer:setTopBottom(false, true, -f12_local16 - f12_local14, -f12_local16)
			f12_local0:addElement(bannerContainer)
			f12_local0.bannerContainer = bannerContainer
			
			local f12_local19 = LUI.UIImage.new()
			f12_local19:setLeftRight(true, true, 1, -1)
			f12_local19:setTopBottom(true, true, 1, -1)
			f12_local19:setRGB(0, 0, 0)
			f12_local19:setAlpha(0.6)
			bannerContainer:addElement(f12_local19)
			local f12_local20 = 6
			local f12_local21 = f12_local14 - f12_local20 * 2
			local f12_local22 = f12_local21 * 4
			
			local bannerImage = LUI.UIImage.new()
			bannerImage:setLeftRight(true, false, f12_local20, f12_local20 + f12_local22)
			bannerImage:setTopBottom(false, false, -(f12_local21 / 2), f12_local21 / 2)
			bannerImage:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, CoD.MOTD.GetImageFileID(f12_local2.bannerImage))
			bannerImage:setAlpha(0)
			bannerContainer:addElement(bannerImage)
			f12_local0.bannerImage = bannerImage
			
			f12_local0.bannerImageID = f12_local2.bannerImage
			local f12_local24 = LUI.UIImage.new()
			f12_local24:setLeftRight(true, true, f12_local17, -f12_local17)
			f12_local24:setTopBottom(true, false, f12_local17, f12_local14 * 0.6)
			f12_local24:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
			f12_local24:setAlpha(0.1)
			bannerContainer:addElement(f12_local24)
			bannerContainer.border = CoD.Border.new(1, 1, 1, 1, 0.1)
			bannerContainer:addElement(bannerContainer.border)
			local f12_local25 = f12_local20 + f12_local22 + 2 * f12_local20
			local f12_local26 = LUI.UIText.new()
			f12_local26:setLeftRight(true, true, f12_local25, 0)
			f12_local26:setTopBottom(false, false, f12_local13 - f12_local12 - 5, f12_local13 - 5)
			f12_local26:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
			f12_local26:setFont(f12_local11)
			f12_local26:setText(f12_local2.bannerTitle)
			f12_local26:setAlignment(LUI.Alignment.Left)
			bannerContainer:addElement(f12_local26)
			local Widget = LUI.UIElement.new()
			Widget:setLeftRight(true, true, f12_local25, 0)
			Widget:setTopBottom(false, false, -f12_local13 + 5, -f12_local13 + 5 + f12_local12)
			Widget:setAlignment(LUI.Alignment.Left)
			bannerContainer:addElement(Widget)
			f12_local0.bannerAction = f12_local2.bannerAction
			f12_local0.bannerActionContext = f12_local2.bannerActionContext
			f12_local0.bannerActionString = f12_local2.bannerActionString
			CoD.MOTD.AddAction(f12_local0, Widget, f12_local0.bannerAction, f12_local0.bannerActionContext, f12_local0.bannerActionString)
		end
	end
	f12_local0:addLeftButtonPrompt(CoD.ButtonPrompt.new("primary", Engine.Localize(f12_local1), f12_local0, "motd_accept"))
	f12_local0:addBackButton()
	f12_local0:registerEventHandler("motd_accept", CoD.MOTD.Accept)
	f12_local0:registerEventHandler("motd_buy_now", CoD.MOTD.BuyFromMOTDContext)
	f12_local0:registerEventHandler("banner_buy_now", CoD.MOTD.BuyFromBannerContext)
	f12_local0:registerEventHandler("banner_play_movie_now", CoD.MOTD.PlayMovieFromBannerContext)
	f12_local0:registerEventHandler("signed_out", CoD.MOTD.SignedOut)
	f12_local0:registerEventHandler("motd_image_descriptors_done", CoD.MOTD.DescriptorsDone)
	f12_local0:registerEventHandler("button_prompt_back", CoD.MOTD.ButtonPromptBack)
	Engine.Exec(f12_arg0, "resetThumbnailViewer")
	Engine.Exec(f12_arg0, "motdGetImageDescriptors")
	return f12_local0
end

function MOTD_ShowDefaultMsg(f13_arg0)
	return true
end

function MOTD_ShowTrialDLC1Msg(f14_arg0, f14_arg1)
	if not Engine.IsContentAvailableByPakName("dlc1") then
		return true
	else
		return false
	end
end

