require("T6.BorderDipLarge")
CoD.MissionBriefingCharacterPanel = {}
local f0_local0 = nil
CoD.MissionBriefingCharacterPanel.CharacterInfoText = function (f1_arg0)
	local f1_local0 = "ExtraSmall"
	local f1_local1 = LUI.UIText.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, false, 0, CoD.textSize[f1_local0])
	f1_local1:setFont(CoD.fonts[f1_local0])
	f1_local1:setAlignment(LUI.Alignment.Left)
	f1_local1:setRGB(CoD.visorBlue1.r, CoD.visorBlue1.g, CoD.visorBlue1.b)
	f1_local1:setText(f1_arg0)
	return f1_local1
end

f0_local0 = function ()
	local f2_local0 = RegisterMaterial("menu_vis_thumbprint")
	local f2_local1 = 1
	local f2_local2 = 100
	local f2_local3 = f2_local2 * f2_local1
	local f2_local4 = LUI.UIImage.new()
	f2_local4:setLeftRight(false, true, -f2_local3 - 10, -10)
	f2_local4:setTopBottom(false, false, -f2_local2 / 2, f2_local2 / 2)
	f2_local4:setImage(f2_local0)
	f2_local4:setAlpha(0.35)
	return f2_local4
end

CoD.MissionBriefingCharacterPanel.new = function (f3_arg0)
	local f3_local0 = -116
	local f3_local1 = 175
	local f3_local2 = 400
	local f3_local3 = 180
	local Widget = LUI.UIElement.new()
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setLeftRight(true, true, 0, 0)
	local f3_local5 = -f3_local2 * 0.8
	local f3_local6 = f3_local2 * 0.8
	local f3_local7 = -f3_local1 - f3_local0 - 60
	local f3_local8 = 50 - f3_local0
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f3_local2 / 2 - 30, f3_local2 / 2 + 36)
	Widget:setTopBottom(false, true, -f3_local0 - f3_local1 - 5, -f3_local0 - 5)
	Widget:addElement(Widget)
	local f3_local10 = 1
	local f3_local11 = f3_local1 - 20
	local f3_local12 = f3_local11 * f3_local10
	local f3_local13 = 10
	local f3_local14 = LUI.UIImage.new()
	f3_local14:setLeftRight(true, false, f3_local13, f3_local13 + f3_local12)
	f3_local14:setTopBottom(false, false, -f3_local11 / 2, f3_local11 / 2)
	f3_local14:setImage(CoD.Campaign.Characters[f3_arg0].characterImage)
	Widget:addElement(f3_local14)
	local f3_local15 = 10
	local f3_local16 = LUI.UIImage.new()
	f3_local16:setLeftRight(true, false, f3_local15 + f3_local12, f3_local15 + f3_local12 + f3_local12)
	f3_local16:setTopBottom(false, false, -f3_local11 / 2, f3_local11 / 2)
	f3_local16:setImage(CoD.Campaign.Characters[f3_arg0].characterImageSide)
	Widget:addElement(f3_local16)
	local f3_local17 = 100
	local f3_local18 = 20
	local f3_local19 = 0
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f3_local3 + f3_local18, f3_local18)
	Widget:setTopBottom(false, false, -(f3_local17 / 2) + f3_local19, f3_local17 / 2 + f3_local19)
	Widget:addElement(Widget)
	Widget:addElement(CoD.BorderDipLarge.new(2, 2, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -2, 0))
	Widget:addElement(f0_local0())
	local f3_local21 = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget:addElement(f3_local21)
	local f3_local22 = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_CHARACTER_NAME") .. ": " .. Engine.Localize("SPUI_" .. f3_arg0 .. "_NAME"))
	local f3_local23 = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_ID_NUMBER") .. ": " .. CoD.Campaign.Characters[f3_arg0].characterID)
	local f3_local24 = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_HEIGHT_CAPS") .. ": " .. Engine.Localize("SPUI_" .. f3_arg0 .. "_HEIGHT"))
	local f3_local25 = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_WEIGHT_CAPS") .. ": " .. Engine.Localize("SPUI_" .. f3_arg0 .. "_WEIGHT"))
	f3_local21:addElement(f3_local22)
	f3_local21:addElement(f3_local23)
	f3_local21:addElement(f3_local24)
	f3_local21:addElement(f3_local25)
	return Widget
end

