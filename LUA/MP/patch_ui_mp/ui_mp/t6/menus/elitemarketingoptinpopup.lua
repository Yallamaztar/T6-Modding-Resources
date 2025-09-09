CoD.EliteMarketingOptInPopup = {}
local f0_local0 = 230
local f0_local1 = 90
local f0_local2 = nil
local f0_local3 = f0_local0 * 1.5
local f0_local4 = 120
local f0_local5 = -60
local f0_local6 = "elite_member.png"
local f0_local7 = "elite_founder.png"
local f0_local8 = 0
local f0_local9 = "Default"
local f0_local10 = CoD.fonts[f0_local9]
local f0_local11 = CoD.textSize[f0_local9] * 2 + 2
local f0_local12 = 10
local f0_local13 = CoD.Menu.Width - f0_local12 * 2
local f0_local14 = CoD.ButtonPrompt.Height + 20
local f0_local15 = 4
local f0_local16 = "Default"
local f0_local17 = CoD.fonts[f0_local16]
local f0_local18 = CoD.textSize[f0_local16]
local f0_local19 = 350
local f0_local20 = f0_local18 + 8
local f0_local21 = f0_local14 + f0_local11 + 15
CoD.EliteMarketingOptInPopup.CreateHeader = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.textSize.Big + 30
	f1_arg0.headerLabel = LUI.UIText.new()
	f1_arg0.headerLabel:setLeftRight(true, true, 0, 0)
	f1_arg0.headerLabel:setTopBottom(true, false, f1_local0, f1_local0 + CoD.textSize.Big)
	f1_arg0.headerLabel:setAlpha(CoD.textAlpha)
	f1_arg0.headerLabel:setAlignment(LUI.Alignment.Left)
	f1_arg0.headerLabel:setFont(CoD.fonts.Condensed)
	f1_arg0.headerLabel:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f1_arg0.headerLabel:setText(Engine.Localize(f1_arg1))
	f1_arg0:addElement(f1_arg0.headerLabel)
end

CoD.EliteMarketingOptInPopup.CreateMessage = function (f2_arg0)
	local f2_local0 = 130
	f2_arg0.messageLabel = LUI.UIText.new()
	f2_arg0.messageLabel:setLeftRight(true, false, 0, 530)
	f2_arg0.messageLabel:setTopBottom(true, false, CoD.textSize.Big + f2_local0, CoD.textSize.Big + CoD.textSize.Condensed + f2_local0)
	f2_arg0.messageLabel:setAlignment(LUI.Alignment.Left)
	f2_arg0.messageLabel:setFont(CoD.fonts.Condensed)
	f2_arg0.messageLabel:setText(Engine.Localize("MPUI_ELITE_VERIFY_MSG2"))
	f2_arg0:addElement(f2_arg0.messageLabel)
end

CoD.EliteMarketingOptInPopup.CreateButton = function (f3_arg0, f3_arg1, f3_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f0_local12, f0_local12 + f0_local19)
	Widget:setTopBottom(false, true, -f0_local21 - f0_local20 + f3_arg2, -f0_local21 + f3_arg2)
	f3_arg0:addElement(Widget)
	local f3_local1 = LUI.UIImage.new()
	f3_local1:setLeftRight(true, true, 1, -1)
	f3_local1:setTopBottom(true, true, 1, -1)
	f3_local1:setRGB(0, 0, 0)
	f3_local1:setAlpha(0.6)
	Widget:addElement(f3_local1)
	local f3_local2 = LUI.UIImage.new()
	f3_local2:setLeftRight(true, true, f0_local15, -f0_local15)
	f3_local2:setTopBottom(true, false, f0_local15, f0_local11 * 0.6)
	f3_local2:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f3_local2:setAlpha(0.1)
	Widget:addElement(f3_local2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 8, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	Widget:addElement(f3_arg1)
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
end

CoD.EliteMarketingOptInPopup.CreateLogoContainer = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f0_local0, 0)
	Widget:setTopBottom(false, false, -(f0_local0 / 2) - f0_local1, f0_local0 / 2 - f0_local1)
	return Widget
end

CoD.EliteMarketingOptInPopup.AddLargeLogo = function (f5_arg0)
	local f5_local0 = LUI.UIImage.new()
	f5_local0:setLeftRight(true, true, 0, 0)
	f5_local0:setTopBottom(true, true, 0, 0)
	f5_local0:setImage(RegisterMaterial("motd_elite_logo"))
	f5_arg0:addElement(f5_local0)
end

CoD.EliteMarketingOptInPopup.AddSmallLogo = function (f6_arg0, f6_arg1, f6_arg2)
	UPVAL0 = LUI.UIImage.new()
	f0_local2:setLeftRight(true, false, f0_local5, f0_local5 + f0_local3)
	f0_local2:setTopBottom(true, false, f0_local4, f0_local4 + f0_local3)
	f6_arg1:addElement(f0_local2)
	f0_local2:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, 0)
end

CoD.EliteMarketingOptInPopup.CloseWindow = function (f7_arg0, f7_arg1)
	Engine.SetDvar("tu10_eliteMarketingOptInPopupEnabled", 0)
	f7_arg0:goBack(f7_arg1.controller)
	f7_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f7_arg1.controller
	})
end

CoD.EliteMarketingOptInPopup.AcceptButtonPressed = function (f8_arg0, f8_arg1)
	Engine.EMarketingOptInPopup_UpdateOptIn(f8_arg1.controller, true)
	f8_arg0:goBack(f8_arg1.controller)
	f8_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f8_arg1.controller
	})
end

CoD.EliteMarketingOptInPopup.DeclineButtonPressed = function (f9_arg0, f9_arg1)
	Engine.EMarketingOptInPopup_UpdateOptIn(f9_arg1.controller, false)
	f9_arg0:goBack(f9_arg1.controller)
	f9_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f9_arg1.controller
	})
end

CoD.EliteMarketingOptInPopup.DescriptorsDone = function (f10_arg0, f10_arg1)
	local f10_local0 = nil
	if Engine.IsPlayerEliteFounder(f10_arg1.controller) then
		f10_local0 = f0_local7
	else
		f10_local0 = f0_local6
	end
	UPVAL2 = Engine.GetMOTDImageFileID(f10_local0)
	if f0_local8 ~= nil and f0_local8 ~= "0" then
		f0_local2:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, f0_local8)
		Engine.Exec(controller, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_MOTD .. " " .. f0_local8 .. " 1")
	else
		f0_local2:hide()
	end
end

LUI.createMenu.EliteMarketingOptInPopup = function (f11_arg0)
	local f11_local0 = CoD.Menu.New("EliteMarketingOptInPopup")
	f11_local0:setOwner(f11_arg0)
	f11_local0:addLargePopupBackground()
	f11_local0:addTitle(Engine.Localize("MENU_MESSAGE_OF_THE_DAY"))
	f11_local0.activateButton = CoD.ButtonPrompt.new("alt1", Engine.Localize("MPUI_ELITE_ENLIST2_YES"), f11_local0, "EliteMarketingOptInPopup_AcceptButtonPressed")
	f11_local0.declineButton = CoD.ButtonPrompt.new("alt2", Engine.Localize("MPUI_ELITE_NO"), f11_local0, "EliteMarketingOptInPopup_DeclineButtonPressed")
	f11_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_MOTD_ACCEPT"), f11_local0, "EliteMarketingOptInPopup_Close")
	f11_local0:addLeftButtonPrompt(f11_local0.acceptButton)
	f11_local0:addBackButton()
	f11_local0:registerEventHandler("EliteMarketingOptInPopup_Close", CoD.EliteMarketingOptInPopup.CloseWindow)
	f11_local0:registerEventHandler("EliteMarketingOptInPopup_AcceptButtonPressed", CoD.EliteMarketingOptInPopup.AcceptButtonPressed)
	f11_local0:registerEventHandler("EliteMarketingOptInPopup_DeclineButtonPressed", CoD.EliteMarketingOptInPopup.DeclineButtonPressed)
	f11_local0:registerEventHandler("motd_image_descriptors_done", CoD.EliteMarketingOptInPopup.DescriptorsDone)
	Engine.Exec(f11_arg0, "resetThumbnailViewer")
	Engine.Exec(f11_arg0, "motdGetImageDescriptors")
	CoD.EliteMarketingOptInPopup.CreateHeader(f11_local0, "MPUI_COD_ELITE_CAPS")
	CoD.EliteMarketingOptInPopup.CreateMessage(f11_local0)
	local f11_local1 = CoD.EliteMarketingOptInPopup.CreateLogoContainer()
	CoD.EliteMarketingOptInPopup.AddLargeLogo(f11_local1)
	CoD.EliteMarketingOptInPopup.AddSmallLogo(f11_local0, f11_local1, f11_arg0)
	f11_local0:addElement(f11_local1)
	CoD.EliteMarketingOptInPopup.CreateButton(f11_local0, f11_local0.activateButton, 0)
	CoD.EliteMarketingOptInPopup.CreateButton(f11_local0, f11_local0.declineButton, 40)
	return f11_local0
end

