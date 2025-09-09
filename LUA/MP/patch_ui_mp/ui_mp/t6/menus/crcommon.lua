CoD.CRCommon = {}
CoD.CRCommon.SortTypes = {}
CoD.CRCommon.SortTypes.GAMEMODES = 0
CoD.CRCommon.SortTypes.WEAPONS = 1
CoD.CRCommon.SortTypes.EQUIPMENT = 2
CoD.CRCommon.SortTypes.SCORESTREAKS = 3
CoD.CRCommon.SortTypes.MEDALS = 4
CoD.CRCommon.MedalCategories = {}
CoD.CRCommon.MedalCategories.CATEGORY_NONE = 0
CoD.CRCommon.MedalCategories.CATEGORY_COMBAT = 1
CoD.CRCommon.MedalCategories.CATEGORY_SCORESTREAKS = 2
CoD.CRCommon.MedalCategories.CATEGORY_ANTISCORESTREAKS = 3
CoD.CRCommon.MedalCategories.CATEGORY_GAMEMODES = 4
CoD.CRCommon.MAX_BACKINGS = 3
CoD.CRCommon.BackingHeight = 75
CoD.CRCommon.BackingWidth = CoD.CRCommon.BackingHeight * 4
CoD.CRCommon.GameTypeImageNames = {
	tdm = "playlist_tdm",
	dm = "playlist_ffa",
	dom = "playlist_domination",
	sd = "playlist_search_destroy",
	ctf = "playlist_ctf",
	hq = "playlist_headquarters",
	dem = "playlist_demolition",
	koth = "playlist_koth",
	conf = "playlist_kill_confirm",
	shrp = "playlist_sharpshooter",
	sas = "playlist_sticks_and_stones",
	oic = "playlist_one_chamber",
	gun = "playlist_gungame",
	hckr = "playlist_hacker",
	oneflag = "playlist_single_ctf",
	hctdm = "playlist_tdm",
	hcdm = "playlist_ffa",
	hcdom = "playlist_domination",
	hcsd = "playlist_search_destroy",
	hcctf = "playlist_ctf",
	hchq = "playlist_headquarters",
	hcdem = "playlist_demolition",
	hckoth = "playlist_koth",
	hcconf = "playlist_kill_confirm",
	hconeflag = "playlist_single_ctf"
}
CoD.CRCommon.GetStats = function (f1_arg0, f1_arg1)
	local f1_local0 = Engine.GetPlayerStats(f1_arg0)
	if f1_arg1 then
		f1_local0 = Engine.GetPlayerStats(f1_arg0, CoD.STATS_LOCATION_OTHERPLAYER)
	end
	return f1_local0
end

CoD.CRCommon.GetStatContainer = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	
	local statContainerBackground = LUI.UIImage.new()
	statContainerBackground:setLeftRight(true, true, 1, -1)
	statContainerBackground:setTopBottom(true, true, 1, -1)
	statContainerBackground:setRGB(0, 0, 0)
	statContainerBackground:setAlpha(0.4)
	Widget:addElement(statContainerBackground)
	Widget.statContainerBackground = statContainerBackground
	
	local statContainerBackgroundGrad = LUI.UIImage.new()
	statContainerBackgroundGrad:setLeftRight(true, true, 3, -3)
	statContainerBackgroundGrad:setTopBottom(true, true, 3, -3)
	statContainerBackgroundGrad:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	statContainerBackgroundGrad:setAlpha(0.1)
	Widget:addElement(statContainerBackgroundGrad)
	Widget.statContainerBackgroundGrad = statContainerBackgroundGrad
	
	local imageContainer = LUI.UIElement.new()
	imageContainer:setLeftRight(true, true, 3, -3)
	imageContainer:setTopBottom(true, true, 3, -3)
	Widget:addElement(imageContainer)
	Widget.imageContainer = imageContainer
	
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
	return Widget
end

CoD.CRCommon.GetTextElem = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = "Default"
	local f3_local1 = LUI.Alignment.Center
	local f3_local2 = 0
	if f3_arg1 then
		f3_local1 = LUI.Alignment[f3_arg1]
	end
	if f3_arg0 then
		f3_local0 = f3_arg0
	end
	if f3_arg4 then
		f3_local2 = f3_arg4
	end
	local f3_local3 = CoD.fonts[f3_local0]
	local f3_local4 = CoD.textSize[f3_local0]
	local f3_local5 = LUI.UIText.new()
	f3_local5:setLeftRight(true, true, 0, 0)
	f3_local5:setTopBottom(true, false, f3_local2, f3_local2 + f3_local4)
	f3_local5:setFont(f3_local3)
	f3_local5:setAlignment(f3_local1)
	if f3_arg2 then
		f3_local5:setText(f3_arg2)
	end
	if f3_arg3 then
		f3_local5:setRGB(f3_arg3.r, f3_arg3.g, f3_arg3.b)
	end
	return f3_local5
end

CoD.CRCommon.GetCenteredImage = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = nil
	if f4_arg3 then
		f4_local0 = LUI.UIStreamedImage.new(nil, nil, true)
	else
		f4_local0 = LUI.UIImage.new()
	end
	f4_local0:setLeftRight(false, false, -f4_arg0 / 2, f4_arg0 / 2)
	f4_local0:setTopBottom(false, false, -f4_arg1 / 2, f4_arg1 / 2)
	if f4_arg2 then
		f4_local0:setImage(RegisterMaterial(f4_arg2))
	end
	return f4_local0
end

CoD.CRCommon.GetStretchedImage = function (f5_arg0, f5_arg1)
	local f5_local0 = nil
	if f5_arg1 then
		f5_local0 = LUI.UIStreamedImage.new(nil, nil, true)
	else
		f5_local0 = LUI.UIImage.new()
	end
	f5_local0:setLeftRight(true, true, 0, 0)
	f5_local0:setTopBottom(true, true, 0, 0)
	if f5_arg0 then
		f5_local0:setImage(RegisterMaterial(f5_arg0))
	end
	return f5_local0
end

CoD.CRCommon.GetIndividualStatBox = function (f6_arg0)
	local f6_local0 = 50
	local f6_local1 = CoD.CRCommon.GetStatContainer()
	f6_local1:setLeftRight(true, false, 0, f6_arg0)
	f6_local1:setTopBottom(true, true, 0, 0)
	local f6_local2 = LUI.UIVerticalList.new()
	f6_local2:setLeftRight(true, true, 0, 0)
	f6_local2:setTopBottom(true, true, f6_local0, 0)
	
	local label = CoD.CRCommon.GetTextElem("ExtraSmall", "Center", "", CoD.gray)
	f6_local2:addElement(label)
	f6_local1.label = label
	
	f6_local2:addSpacer(5)
	
	local value = CoD.CRCommon.GetTextElem("Big", "Center", "")
	f6_local2:addElement(value)
	f6_local1.value = value
	
	f6_local2:addSpacer(5)
	local f6_local5 = CoD.CRCommon.GetTextElem("Big", "Center", "")
	f6_local2:addElement(f6_local5)
	f6_local5:setRGB(CoD.lightBlue.r, CoD.lightBlue.g, CoD.lightBlue.b)
	f6_local1.comparisonValue = f6_local5
	f6_local1:addElement(f6_local2)
	return f6_local1
end

CoD.CRCommon.UpdateGenericStatsInfoBoxValues = function (f7_arg0, f7_arg1, f7_arg2)
	if not f7_arg1 or #f7_arg1 == 0 then
		return 
	end
	local f7_local0 = f7_arg0.image
	f7_local0:hide()
	if f7_arg2 then
		f7_local0:setImage(RegisterMaterial(f7_arg2))
		f7_local0:show()
	end
	for f7_local5, f7_local6 in ipairs(f7_arg1) do
		if f7_arg0.statBoxes and f7_local5 <= #f7_arg0.statBoxes and f7_arg0.statBoxes[f7_local5] then
			local f7_local4 = f7_arg0.statBoxes[f7_local5]
			if f7_local6.baseValue then
				f7_local4.value:setText(f7_local6.baseValue)
			end
			if f7_local6.comparisonValue then
				f7_local4.comparisonValue:setText(f7_local6.comparisonValue)
			end
		end
	end
end

CoD.CRCommon.SetGenericStatsInfoBoxLabels = function (f8_arg0, f8_arg1)
	if not f8_arg1 or #f8_arg1 == 0 then
		return 
	end
	for f8_local4, f8_local5 in ipairs(f8_arg1) do
		if f8_arg0.statBoxes and f8_local4 <= #f8_arg0.statBoxes and f8_arg0.statBoxes[f8_local4] then
			local f8_local3 = f8_arg0.statBoxes[f8_local4]
			if f8_local5 then
				f8_local3.label:setText(f8_local5)
			end
		end
	end
end

CoD.CRCommon.GetGenericStatsInfoBox = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = LUI.UIHorizontalList.new()
	f9_local0:setLeftRight(true, true, 0, 0)
	f9_local0:setTopBottom(true, true, 0, 0)
	f9_local0.update = CoD.CRCommon.UpdateGenericStatsInfoBoxValues
	f9_local0.setLabels = CoD.CRCommon.SetGenericStatsInfoBoxLabels
	local f9_local1 = 300
	local f9_local2 = CoD.CRCommon.GetStatContainer()
	f9_local2:setLeftRight(true, false, 0, f9_local1)
	
	local image = CoD.CRCommon.GetCenteredImage(f9_arg1, f9_arg2)
	image:hide()
	f9_local2:addElement(image)
	f9_local0.image = image
	
	f9_local0:addElement(f9_local2)
	f9_local1 = 150
	if f9_arg3 then
		f9_local1 = f9_arg3
	end
	f9_local0.statBoxes = {}
	for f9_local4 = 1, f9_arg0, 1 do
		local f9_local7 = f9_local4
		local f9_local8 = CoD.CRCommon.GetIndividualStatBox(f9_local1)
		f9_local0:addElement(f9_local8)
		table.insert(f9_local0.statBoxes, f9_local8)
	end
	return f9_local0
end

CoD.CRCommon.ListBoxButtonCreator = function (f10_arg0, f10_arg1)
	local f10_local0 = "Default"
	local f10_local1 = CoD.fonts[f10_local0]
	local f10_local2 = CoD.textSize[f10_local0]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 8, -8)
	Widget:setTopBottom(false, false, -f10_local2 / 2, f10_local2 / 2)
	local f10_local4 = CoD.CRCommon.GetTextElem("Default", "Left")
	Widget:addElement(f10_local4)
	local f10_local5 = CoD.CRCommon.GetTextElem("Default", "Right")
	Widget:addElement(f10_local5)
	f10_arg1.itemName = f10_local4
	f10_arg1.itemValue = f10_local5
	f10_arg1:addElement(Widget)
end

CoD.CRCommon.GetGenericListBox = function (f11_arg0, f11_arg1, f11_arg2)
	local f11_local0 = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, f11_arg0, 5, 45, f11_arg1, CoD.CRCommon.ListBoxButtonCreator, f11_arg2, 0)
	f11_local0:addScrollBar()
	f11_local0.m_pageArrowsOn = true
	return f11_local0
end

CoD.CRCommon.UpdateBackings = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = {}
	if f12_arg2 and 0 < #f12_arg2 then
		for f12_local4, f12_local5 in ipairs(f12_arg2) do
			if 0 < f12_local5 then
				table.insert(f12_local0, f12_local5)
			end
		end
	end
	for f12_local4, f12_local5 in ipairs(f12_arg0.containers) do
		f12_local5:hide()
		if f12_local0 and 0 < #f12_local0 then
			local f12_local6 = f12_local0[f12_local4]
			if f12_local6 and 0 < f12_local6 then
				f12_local5.backingImage:setupDrawBackgroundById(f12_local6)
				local f12_local7 = CoD.EmblemBackgroundSelector.GetChallengeInformation(f12_arg1, f12_local6)
				if f12_local7 and f12_local7.challengeName then
					f12_local5.challengeName:setText(f12_local7.challengeName)
					f12_local5:show()
				end
			end
		end
	end
end

CoD.CRCommon.GetGenericBackingsContainer = function ()
	local f13_local0 = LUI.UIVerticalList.new()
	f13_local0:setLeftRight(true, false, 0, CoD.CRCommon.BackingWidth)
	f13_local0:setTopBottom(true, true, 0, 0)
	f13_local0.updateBackings = CoD.CRCommon.UpdateBackings
	f13_local0.containers = {}
	for f13_local1 = 1, CoD.CRCommon.MAX_BACKINGS, 1 do
		local f13_local4 = f13_local1
		local f13_local5 = CoD.CRCommon.GetStatContainer()
		f13_local5:setTopBottom(true, false, 0, CoD.CRCommon.BackingHeight)
		f13_local5:hide()
		f13_local5.backingImage = CoD.CRCommon.GetStretchedImage()
		f13_local5.imageContainer:addElement(f13_local5.backingImage)
		table.insert(f13_local0.containers, f13_local5)
		local f13_local6 = "Default"
		f13_local5.challengeName = CoD.CRCommon.GetTextElem("Default", "Left")
		f13_local5.challengeName:setLeftRight(true, true, 5, 0)
		f13_local5.challengeName:setTopBottom(false, true, -5 - CoD.textSize[f13_local6], -5)
		f13_local5:addElement(f13_local5.challengeName)
		f13_local0:addElement(f13_local5)
		f13_local0:addSpacer(5)
	end
	return f13_local0
end

CoD.CRCommon.UpdateComparisonContainer = function (f14_arg0, f14_arg1)
	if CoD.CRCommon.ComparisonModeOn == true then
		local f14_local0 = CoD.CRCommon.ComparedXuid
		local f14_local1 = CoD.CRCommon.ComparedPlayerName
		if CoD.CRCommon.OtherPlayerCRMode then
			f14_local0 = UIExpression.GetXUID(f14_arg1)
			f14_local1 = UIExpression.GetSelfGamertag(f14_arg1)
		end
		if f14_local0 and f14_local1 then
			f14_arg0.comparisonEmblem:setupPlayerEmblemByXUID(f14_local0)
			f14_arg0.comparingLabel:setText(Engine.Localize("MENU_COMPARING_COLON"))
			f14_arg0.comparedPlayerNameTextElem:setText(f14_local1)
			f14_arg0:show()
		end
	else
		f14_arg0:hide()
	end
end

CoD.CRCommon.GetComparisonContainer = function ()
	local f15_local0 = 250
	local f15_local1 = 10
	local f15_local2 = 300
	local f15_local3 = f15_local2 / 4
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f15_local0, f15_local0 + f15_local2)
	Widget:setTopBottom(true, false, 0, f15_local3)
	local f15_local5 = 48
	local f15_local6 = CoD.CRCommon.GetCenteredImage(f15_local5, f15_local5)
	f15_local6:setLeftRight(true, false, 5, 5 + f15_local5)
	f15_local0 = f15_local5 + 10
	local f15_local7 = CoD.CRCommon.GetTextElem("Default", "Left", nil, nil, f15_local1)
	f15_local7:setLeftRight(true, true, f15_local0, 0)
	local f15_local8 = CoD.CRCommon.GetTextElem("Default", "Left", "", CoD.lightBlue, f15_local1 + CoD.textSize.Default)
	f15_local8:setLeftRight(true, true, f15_local0, 0)
	Widget:addElement(f15_local6)
	Widget:addElement(f15_local7)
	Widget:addElement(f15_local8)
	Widget.comparisonEmblem = f15_local6
	Widget.comparingLabel = f15_local7
	Widget.comparedPlayerNameTextElem = f15_local8
	Widget.update = CoD.CRCommon.UpdateComparisonContainer
	Widget:update()
	return Widget
end

