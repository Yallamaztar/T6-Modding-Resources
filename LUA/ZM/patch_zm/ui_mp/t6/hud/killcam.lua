local KillcamRectHeight = 120
local KillcamR = 1
local KillcamG = 0
local KillcamB = 0
local KillcamA = 0.2
local KillcamTextA = 0.75
local KillcamTextFont = "Morris"
local FinalKillcamR = 0
local FinalKillcamG = 0
local FinalKillcamB = 0
local FinalKillcamA = 0.2
LUI.createMenu.Killcam = function (LocalClientIndex)
	local KillcamWidget = CoD.Menu.NewFromState("Killcam")
	KillcamWidget:setOwner(LocalClientIndex)
	KillcamWidget:setLeftRight(true, true, 0, 0)
	KillcamWidget:setTopBottom(true, true, 0, 0)
	local KillcamElemTop = LUI.UIElement.new()
	KillcamElemTop:setLeftRight(true, true, 0, 0)
	KillcamElemTop:setTopBottom(true, false, 0, KillcamRectHeight)
	KillcamWidget:addElement(KillcamElemTop)
	local KillcamTopRect = LUI.UIImage.new()
	KillcamTopRect:setLeftRight(true, true, 0, 0)
	KillcamTopRect:setTopBottom(true, true, 0, 0)
	KillcamElemTop:addElement(KillcamTopRect)
	local KillcamElemBottom = LUI.UIElement.new()
	KillcamElemBottom:setLeftRight(true, true, 0, 0)
	KillcamElemBottom:setTopBottom(false, true, -KillcamRectHeight, 0)
	KillcamWidget:addElement(KillcamElemBottom)
	local KillcamBottomRect = LUI.UIImage.new()
	KillcamBottomRect:setLeftRight(true, true, 0, 0)
	KillcamBottomRect:setTopBottom(true, true, 0, 0)
	KillcamElemBottom:addElement(KillcamBottomRect)
	local KillcamText = LUI.UIText.new()
	KillcamText:setLeftRight(true, true, 0, 0)
	KillcamText:setTopBottom(false, true, -CoD.textSize[KillcamTextFont], 0)
	KillcamText:setFont(CoD.fonts[KillcamTextFont])
	KillcamText:setAlpha(KillcamTextA)
	KillcamElemBottom:addElement(KillcamText)
	KillcamWidget.isFinalKillcam = UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_FINAL_KILLCAM) == 1
	KillcamWidget.isRoundEndKillcam = UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_ROUND_END_KILLCAM) == 1
	local IsNemesisKillcam = UIExpression.IsVisibilityBitSet(LocalClientIndex, CoD.BIT_NEMESIS_KILLCAM) == 1
	if KillcamWidget.isFinalKillcam or KillcamWidget.isRoundEndKillcam then
		KillcamTopRect:setRGB(FinalKillcamR, FinalKillcamG, FinalKillcamB)
		KillcamTopRect:setAlpha(FinalKillcamA)
		KillcamBottomRect:setRGB(FinalKillcamR, FinalKillcamG, FinalKillcamB)
		KillcamBottomRect:setAlpha(FinalKillcamA)
		if KillcamWidget.isFinalKillcam then
			KillcamText:setText(Engine.Localize("MP_FINAL_KILLCAM_CAPS"))
		else
			KillcamText:setText(Engine.Localize("MP_ROUND_END_KILLCAM"))
		end
	else
		KillcamTopRect:setRGB(KillcamR, KillcamG, KillcamB)
		KillcamTopRect:setAlpha(KillcamA)
		KillcamBottomRect:setRGB(KillcamR, KillcamG, KillcamB)
		KillcamBottomRect:setAlpha(KillcamA)
		if IsNemesisKillcam then
			KillcamText:setText(Engine.Localize("MP_NEMESIS_KILLCAM_CAPS"))
		else
			KillcamText:setText(Engine.Localize("MP_KILLCAM_CAPS"))
		end
	end
	local KillcamNamePlate = CoD.NamePlate.New(LocalClientIndex, Engine.GetCalloutPlayerData(LocalClientIndex, Engine.GetPredictedClientNum(LocalClientIndex)))
	KillcamNamePlate:setTopBottom(false, true, -(2 * CoD.NotificationPopups.PlayerCallout_Height), -(1 * CoD.NotificationPopups.PlayerCallout_Height))
	KillcamElemBottom:addElement(KillcamNamePlate)
	return KillcamWidget
end

