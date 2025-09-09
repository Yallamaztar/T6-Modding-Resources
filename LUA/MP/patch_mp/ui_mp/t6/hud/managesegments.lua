CoD.ManageSegments = {}
CoD.ManageSegments.SegmentButtonWidth = 140
CoD.ManageSegments.SegmentButtonHeight = 80
CoD.ManageSegments.SegmentButtonSpacing = 15
CoD.ManageSegments.MaxSegments = 20
CoD.ManageSegments.MaxSegmentsPerRow = 4
CoD.ManageSegments.MaxSegmentsButtonTopOffset = -20
CoD.ManageSegments.NumRows = CoD.ManageSegments.MaxSegments / CoD.ManageSegments.MaxSegmentsPerRow
CoD.ManageSegments.TotalWidth = CoD.ManageSegments.MaxSegmentsPerRow * CoD.ManageSegments.SegmentButtonWidth + (CoD.ManageSegments.MaxSegmentsPerRow - 1) * CoD.ManageSegments.SegmentButtonSpacing
CoD.ManageSegments.TotalHeight = CoD.ManageSegments.SegmentButtonHeight * CoD.ManageSegments.NumRows + CoD.ManageSegments.SegmentButtonSpacing * (CoD.ManageSegments.NumRows - 1)
CoD.ManageSegments.TimelineHeight = 8
CoD.ManageSegments.TimelineToButtonGridSpacing = 25
CoD.ManageSegments.TimelineBlockSpacing = 3
CoD.ManageSegments.TimelineTop = CoD.ManageSegments.TotalHeight / 2 + CoD.ManageSegments.TimelineToButtonGridSpacing - CoD.ManageSegments.TimelineHeight
CoD.ManageSegments.TimelineMarkerWidth = 1
CoD.ManageSegments.TimelineMarkerHeight = 20
CoD.ManageSegments.InformationDisplayWidth = 250
CoD.ManageSegments.InformationDisplayToGridSpacing = 30
CoD.ManageSegments.SelectedSegmentIndex = nil
CoD.ManageSegments.FocussedSegmentIndex = nil
CoD.ManageSegments.MaxStars = 5
CoD.ManageSegments.StarRatingIconSize = 20
CoD.ManageSegments.Open = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg0:openPopup("Demo_Manage_Segments", f1_arg1.controller)
	if Engine.IsDemoShoutcaster() == true and f1_arg0.SpectateHUD ~= nil then
		f1_arg0.SpectateHUD:processEvent({
			name = "spectate_ingame_menu_opened",
			controller = f1_arg1.controller
		})
	end
	if nil ~= CoD.ManageSegments.SelectedSegmentIndex then
		local f1_local1 = CoD.ManageSegments.SelectedSegmentIndex
		CoD.ManageSegments.SelectedSegmentIndex = nil
		f1_local0.manageSegmentsGrid[f1_local1 + 1]:processEvent({
			name = "gain_focus",
			controller = f1_arg1.controller
		})
		ManageSegments_RefreshButtonPrompts(f1_local0, true)
	end
	f1_local0.directlyOnHUD = true
end

local f0_local0 = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.ManageSegments.SelectedSegmentIndex
	if f2_arg1.name == "button_prompt_back" and f2_local0 ~= nil then
		CoD.ManageSegments.SelectedSegmentIndex = nil
		f2_arg0:processEvent({
			name = "manage_segments_refresh",
			controller = controller
		})
	elseif f2_arg1.name == "preview_clip" or f2_arg1.name == "preview_segment" then
		f2_arg0:setPreviousMenu(nil)
		CoD.InGameMenu.BackButtonPressed(f2_arg0, f2_arg1)
	elseif f2_arg0.directlyOnHUD == true then
		CoD.ManageSegments.SelectedSegmentIndex = nil
		local f2_local1 = f2_arg0:openMenu("Demo_InGame", f2_arg1.controller)
		f2_local1:setPreviousMenu(nil)
		f2_arg0:close()
	else
		CoD.ManageSegments.SelectedSegmentIndex = nil
		CoD.InGameMenu.BackButtonPressed(f2_arg0, f2_arg1)
	end
	if f2_local0 == nil then
		Engine.Exec(f2_arg1.controller, "resetThumbnailViewer")
	end
end

local f0_local1 = function (f3_arg0, f3_arg1)
	f0_local0(f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "demo_previewclip")
end

local f0_local2 = function (f4_arg0, f4_arg1)
	f4_arg0:openPopup("ClipOptions", f4_arg1.controller)
end

function ManageSegments_RefreshButtonPrompts(f5_arg0, f5_arg1)
	f5_arg0.rightBottomButtonBar.selectButton:close()
	f5_arg0.rightBottomButtonBar.previewButton:close()
	f5_arg0.rightBottomButtonBar.clipOptionsButton:close()
	f5_arg0.rightBottomButtonBar.placeSegmentButton:close()
	f5_arg0.rightBottomButtonBar.moveSegmentButton:close()
	if UIExpression.GetDemoSegmentCount() > 0 and f5_arg1 then
		if CoD.ManageSegments.SelectedSegmentIndex == nil then
			f5_arg0.rightBottomButtonBar:addElement(f5_arg0.rightBottomButtonBar.selectButton)
			f5_arg0.rightBottomButtonBar:addElement(f5_arg0.rightBottomButtonBar.previewButton)
			f5_arg0.rightBottomButtonBar:addElement(f5_arg0.rightBottomButtonBar.clipOptionsButton)
		else
			f5_arg0.rightBottomButtonBar:addElement(f5_arg0.rightBottomButtonBar.placeSegmentButton)
			f5_arg0.rightBottomButtonBar:addElement(f5_arg0.rightBottomButtonBar.moveSegmentButton)
		end
	end
end

local f0_local3 = function (f6_arg0)
	f6_arg0.rightBottomButtonBar = LUI.UIHorizontalList.new({
		left = 250,
		top = -CoD.ButtonPrompt.Height,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = 15,
		alignment = LUI.Alignment.Left
	})
	f6_arg0:addElement(f6_arg0.rightBottomButtonBar)
	f6_arg0.rightBottomButtonBar.selectButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_SELECT_SEGMENT"), f6_arg0)
	f6_arg0.rightBottomButtonBar:addElement(f6_arg0.rightBottomButtonBar.selectButton)
	local f6_local0 = f6_arg0.rightBottomButtonBar
	local f6_local1 = CoD.ButtonPrompt.new
	local f6_local2 = "alt1"
	local f6_local3 = Engine.Localize("MENU_PREVIEW_CLIP")
	local f6_local4 = f6_arg0
	local f6_local5 = "preview_clip"
	local f6_local6, f6_local7 = false
	local f6_local8, f6_local9 = false
	f6_local0.previewButton = f6_local1(f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7, f6_local8, f6_local9, "P")
	f6_arg0.rightBottomButtonBar:addElement(f6_arg0.rightBottomButtonBar.previewButton)
	f6_local0 = f6_arg0.rightBottomButtonBar
	f6_local1 = CoD.ButtonPrompt.new
	f6_local2 = "alt2"
	f6_local3 = Engine.Localize("MENU_CLIP_OPTIONS")
	f6_local4 = f6_arg0
	f6_local5 = "open_clip_options"
	f6_local6, f6_local7 = false
	f6_local8, f6_local9 = false
	f6_local0.clipOptionsButton = f6_local1(f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7, f6_local8, f6_local9, "O")
	f6_arg0.rightBottomButtonBar:addElement(f6_arg0.rightBottomButtonBar.clipOptionsButton)
	f6_arg0.rightBottomButtonBar.placeSegmentButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_PLACE_SEGMENT"), f6_arg0)
	f6_arg0.rightBottomButtonBar.moveSegmentButton = CoD.ButtonPrompt.new("dpad_all", Engine.Localize("MENU_MOVE_SEGMENT"), f6_arg0)
end

local f0_local4 = function (f7_arg0)
	local f7_local0 = UIExpression.GetDemoSegmentCount()
	local f7_local1 = UIExpression.GetDemoSegmentInformation(f7_arg0:getOwner(), 0, "totalClipDuration")
	local f7_local2 = CoD.ManageSegments.TotalWidth - CoD.ManageSegments.TimelineBlockSpacing * (f7_local0 - 1)
	local f7_local3 = f7_local2 / f7_local0
	local f7_local4 = CoD.ManageSegments.TimelineTop
	if f7_local0 <= 0 then
		return 
	end
	f7_arg0.timelineContainer = LUI.UIContainer.new()
	f7_arg0:addElement(f7_arg0.timelineContainer)
	local f7_local5 = LUI.UIImage.new()
	f7_local5:setLeftRight(true, false, 0, CoD.ManageSegments.TimelineMarkerWidth)
	f7_local5:setTopBottom(false, false, f7_local4 + CoD.ManageSegments.TimelineHeight - CoD.ManageSegments.TimelineMarkerHeight / 2, f7_local4 + CoD.ManageSegments.TimelineHeight + CoD.ManageSegments.TimelineMarkerHeight / 2)
	f7_local5:setRGB(1, 1, 1)
	f7_local5:setAlpha(1)
	f7_arg0.timelineContainer:addElement(f7_local5)
	local f7_local6 = "00:00"
	local f7_local7 = LUI.UIText.new()
	f7_local7:setLeftRight(true, false, -15, 100)
	f7_local7:setTopBottom(false, false, f7_local4 + CoD.ManageSegments.TimelineHeight + 8, f7_local4 + CoD.ManageSegments.TimelineHeight + 8 + CoD.textSize.ExtraSmall)
	f7_local7:setRGB(1, 1, 1)
	f7_local7:setAlpha(1)
	f7_local7:setFont(CoD.fonts.ExtraSmall)
	f7_local7:setText(f7_local6)
	f7_arg0.timelineContainer:addElement(f7_local7)
	local f7_local8 = LUI.UIImage.new()
	f7_local8:setLeftRight(true, false, CoD.ManageSegments.TotalWidth, CoD.ManageSegments.TotalWidth + CoD.ManageSegments.TimelineMarkerWidth)
	f7_local8:setTopBottom(false, false, f7_local4 + CoD.ManageSegments.TimelineHeight - CoD.ManageSegments.TimelineMarkerHeight / 2, f7_local4 + CoD.ManageSegments.TimelineHeight + CoD.ManageSegments.TimelineMarkerHeight / 2)
	f7_local8:setRGB(1, 1, 1)
	f7_local8:setAlpha(1)
	f7_arg0.timelineContainer:addElement(f7_local8)
	local f7_local9 = LUI.UIText.new()
	f7_local9:setLeftRight(true, false, CoD.ManageSegments.TotalWidth - 15, CoD.ManageSegments.TotalWidth + 100)
	f7_local9:setTopBottom(false, false, f7_local4 + CoD.ManageSegments.TimelineHeight + 8, f7_local4 + CoD.ManageSegments.TimelineHeight + 8 + CoD.textSize.ExtraSmall)
	f7_local9:setRGB(1, 1, 1)
	f7_local9:setAlpha(1)
	f7_local9:setFont(CoD.fonts.ExtraSmall)
	f7_local9:setText(UIExpression.GetDemoSegmentInformation(f7_arg0:getOwner(), 0, "totalClipDurationTimeDisplay"))
	f7_arg0.timelineContainer:addElement(f7_local9)
	f7_arg0.timelineContainer.timeline = LUI.UIHorizontalList.new()
	f7_arg0.timelineContainer.timeline:setLeftRight(true, false, 0, CoD.ManageSegments.TotalWidth)
	f7_arg0.timelineContainer.timeline:setTopBottom(false, false, f7_local4, f7_local4 + CoD.ManageSegments.TimelineHeight)
	f7_arg0.timelineContainer.timeline:setSpacing(CoD.ManageSegments.TimelineBlockSpacing)
	f7_arg0.timelineContainer:addElement(f7_arg0.timelineContainer.timeline)
	local f7_local10 = 2
	for f7_local11 = 1, f7_local0, 1 do
		local f7_local14 = UIExpression.GetDemoSegmentInformation(f7_arg0:getOwner(), f7_local11 - 1, "duration") / f7_local1 * f7_local2
		local f7_local15 = LUI.UIContainer.new()
		f7_local15:setLeftRight(true, false, 0, f7_local14)
		f7_local15:setTopBottom(true, false, 0, CoD.ManageSegments.TimelineHeight)
		f7_local15.image = LUI.UIImage.new()
		f7_local15.image:setLeftRight(true, true, f7_local10 / 2, -f7_local10 / 2)
		f7_local15.image:setTopBottom(true, true, f7_local10 / 2, -f7_local10 / 2)
		f7_local15.image:setRGB(1, 1, 1)
		f7_local15.image:setAlpha(1)
		f7_local15:addElement(f7_local15.image)
		f7_local15.border = CoD.Border.new(f7_local10, 0.9, 0.5, 0.1)
		f7_local15:addElement(f7_local15.border)
		f7_arg0.timelineContainer.timeline[f7_local11] = f7_local15
		f7_arg0.timelineContainer.timeline:addElement(f7_local15)
	end
end

local f0_local5 = function (f8_arg0)
	if f8_arg0.segmentInformationDisplay.segmentIndex == nil or f8_arg0.segmentInformationDisplay.segmentIndex < 0 then
		f8_arg0.segmentInformationDisplay.segmentNameText:setAlpha(0)
		f8_arg0.segmentInformationDisplay.segmentDurationText:setAlpha(0)
		f8_arg0.segmentInformationDisplay.segmentTransitionText:setAlpha(0)
		if UIExpression.IsDemoHighlightReelMode() == 1 then
			for f8_local0 = 1, CoD.ManageSegments.MaxStars, 1 do
				f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local0]:setAlpha(0)
				f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local0]:setAlpha(0)
			end
		end
	elseif nil ~= CoD.ManageSegments.SelectedSegmentIndex then
		local f8_local0 = UIExpression.GetDemoSegmentInformation(f8_arg0:getOwner(), CoD.ManageSegments.SelectedSegmentIndex, "name")
		if f8_arg0.segmentInformationDisplay.segmentIndex == CoD.ManageSegments.SelectedSegmentIndex then
			f8_arg0.segmentInformationDisplay.segmentNameText:setText(Engine.Localize("MENU_MOVING_SEGMENT_SELECT_NEW_SPOT", f8_local0))
		elseif f8_arg0.manageSegmentsGrid[f8_arg0.segmentInformationDisplay.segmentIndex + 1].filled then
			f8_arg0.segmentInformationDisplay.segmentNameText:setText(Engine.Localize("MENU_PLACE_SEGMENT_AT_TIMELINE_POSITION", f8_local0, f8_arg0.segmentInformationDisplay.segmentIndex + 1))
		else
			f8_arg0.segmentInformationDisplay.segmentNameText:setText(Engine.Localize("MENU_CANNOT_PLACE_SEGMENT_IN_TIMELINE", f8_local0))
		end
		f8_arg0.segmentInformationDisplay.segmentNameText:setAlpha(1)
		f8_arg0.segmentInformationDisplay.segmentDurationText:setAlpha(0)
		f8_arg0.segmentInformationDisplay.segmentTransitionText:setAlpha(0)
		if UIExpression.IsDemoHighlightReelMode() == 1 then
			for f8_local1 = 1, CoD.ManageSegments.MaxStars, 1 do
				f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local1]:setAlpha(0)
				f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local1]:setAlpha(0)
			end
		end
	elseif f8_arg0.manageSegmentsGrid[f8_arg0.segmentInformationDisplay.segmentIndex + 1].filled then
		f8_arg0.segmentInformationDisplay.segmentNameText:setText(UIExpression.GetDemoSegmentInformation(f8_arg0:getOwner(), f8_arg0.segmentInformationDisplay.segmentIndex, "name"))
		f8_arg0.segmentInformationDisplay.segmentNameText:setAlpha(1)
		f8_arg0.segmentInformationDisplay.segmentDurationText:setText(UIExpression.GetDemoSegmentInformation(f8_arg0:getOwner(), f8_arg0.segmentInformationDisplay.segmentIndex, "durationLocString"))
		f8_arg0.segmentInformationDisplay.segmentDurationText:setAlpha(1)
		local f8_local2 = UIExpression.GetDemoSegmentCount()
		if f8_arg0.segmentInformationDisplay.segmentIndex ~= UIExpression.GetDemoSegmentCount() - 1 then
			f8_arg0.segmentInformationDisplay.segmentTransitionText:setText(Engine.Localize("MENU_TRANSITION") .. UIExpression.GetDemoSegmentInformation(f8_arg0:getOwner(), f8_arg0.segmentInformationDisplay.segmentIndex, "transition"))
			f8_arg0.segmentInformationDisplay.segmentTransitionText:setAlpha(1)
		else
			f8_arg0.segmentInformationDisplay.segmentTransitionText:setAlpha(0)
		end
		if UIExpression.IsDemoHighlightReelMode() == 1 then
			local f8_local3 = tonumber(UIExpression.GetDemoSegmentInformation(f8_arg0:getOwner(), f8_arg0.segmentInformationDisplay.segmentIndex, "score"))
			if f8_local3 ~= nil and f8_local3 > 0 then
				local f8_local4 = tonumber(UIExpression.GetDemoSegmentInformation(f8_arg0:getOwner(), f8_arg0.segmentInformationDisplay.segmentIndex, "stars"))
				if f8_local4 ~= nil and f8_local4 > 0 then
					for f8_local5 = 1, CoD.ManageSegments.MaxStars, 1 do
						if f8_local5 <= f8_local4 then
							f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local5]:setImage(RegisterMaterial("menu_mp_star_rating"))
							f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local5]:setAlpha(1)
							f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local5]:setAlpha(0)
						end
						if f8_local4 < f8_local5 and f8_local5 <= f8_local4 + 0.5 then
							f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local5]:setImage(RegisterMaterial("menu_mp_star_rating_half"))
							f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local5]:setAlpha(1)
							f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local5]:setAlpha(1)
						else
							f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local5]:setAlpha(0)
							f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local5]:setAlpha(1)
						end
					end
				end
			else
				for f8_local4 = 1, CoD.ManageSegments.MaxStars, 1 do
					f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local4]:setAlpha(0)
					f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local4]:setAlpha(0)
				end
			end
		end
	else
		f8_arg0.segmentInformationDisplay.segmentNameText:setAlpha(0)
		f8_arg0.segmentInformationDisplay.segmentDurationText:setAlpha(0)
		f8_arg0.segmentInformationDisplay.segmentTransitionText:setAlpha(0)
		if UIExpression.IsDemoHighlightReelMode() == 1 then
			for f8_local0 = 1, CoD.ManageSegments.MaxStars, 1 do
				f8_arg0.segmentInformationDisplay.starsContainerOverlay[f8_local0]:setAlpha(0)
				f8_arg0.segmentInformationDisplay.starsContainerUnderlay[f8_local0]:setAlpha(0)
			end
		end
	end
end

local f0_local6 = function (f9_arg0)
	local segmentInformationDisplay = LUI.UIVerticalList.new()
	segmentInformationDisplay:setLeftRight(true, false, CoD.ManageSegments.TotalWidth + CoD.ManageSegments.InformationDisplayToGridSpacing, CoD.ManageSegments.TotalWidth + CoD.ManageSegments.InformationDisplayToGridSpacing + CoD.ManageSegments.InformationDisplayWidth)
	segmentInformationDisplay:setTopBottom(false, false, -CoD.ManageSegments.TotalHeight / 2, CoD.ManageSegments.TotalHeight / 2)
	segmentInformationDisplay:setSpacing(5)
	segmentInformationDisplay.segmentNameText = LUI.UIText.new()
	segmentInformationDisplay.segmentNameText:setLeftRight(true, false, 0, CoD.ManageSegments.InformationDisplayWidth)
	segmentInformationDisplay.segmentNameText:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	segmentInformationDisplay.segmentNameText:setFont(CoD.fonts.Default)
	segmentInformationDisplay.segmentNameText:setAlignment(LUI.Alignment.Left)
	segmentInformationDisplay:addElement(segmentInformationDisplay.segmentNameText)
	segmentInformationDisplay.segmentDurationText = LUI.UIText.new()
	segmentInformationDisplay.segmentDurationText:setLeftRight(true, false, 0, CoD.ManageSegments.InformationDisplayWidth)
	segmentInformationDisplay.segmentDurationText:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	segmentInformationDisplay.segmentDurationText:setFont(CoD.fonts.Default)
	segmentInformationDisplay:addElement(segmentInformationDisplay.segmentDurationText)
	if UIExpression.IsDemoHighlightReelMode() == 1 then
		segmentInformationDisplay.starsContainer = LUI.UIContainer.new()
		segmentInformationDisplay.starsContainer:setLeftRight(true, false, 0, CoD.ManageSegments.InformationDisplayWidth)
		segmentInformationDisplay.starsContainer:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
		segmentInformationDisplay:addElement(segmentInformationDisplay.starsContainer)
		segmentInformationDisplay.starsContainerUnderlay = LUI.UIHorizontalList.new()
		segmentInformationDisplay.starsContainerUnderlay:setLeftRight(true, true, 0, 0)
		segmentInformationDisplay.starsContainerUnderlay:setTopBottom(true, true, 0, 0)
		segmentInformationDisplay.starsContainerUnderlay:setSpacing(5)
		for f9_local1 = 1, CoD.ManageSegments.MaxStars, 1 do
			segmentInformationDisplay.starsContainerUnderlay[f9_local1] = LUI.UIImage.new()
			segmentInformationDisplay.starsContainerUnderlay[f9_local1]:setLeftRight(true, false, 0, CoD.ManageSegments.StarRatingIconSize)
			segmentInformationDisplay.starsContainerUnderlay[f9_local1]:setTopBottom(false, false, -CoD.ManageSegments.StarRatingIconSize / 2, CoD.ManageSegments.StarRatingIconSize / 2)
			segmentInformationDisplay.starsContainerUnderlay[f9_local1]:setImage(RegisterMaterial("menu_mp_star_rating_empty"))
			segmentInformationDisplay.starsContainerUnderlay[f9_local1]:setRGB(0.3, 0.3, 0.3)
			segmentInformationDisplay.starsContainerUnderlay[f9_local1]:setAlpha(0)
			segmentInformationDisplay.starsContainerUnderlay:addElement(segmentInformationDisplay.starsContainerUnderlay[f9_local1])
		end
		segmentInformationDisplay.starsContainer:addElement(segmentInformationDisplay.starsContainerUnderlay)
		segmentInformationDisplay.starsContainerOverlay = LUI.UIHorizontalList.new()
		segmentInformationDisplay.starsContainerOverlay:setLeftRight(true, true, 0, 0)
		segmentInformationDisplay.starsContainerOverlay:setTopBottom(true, true, 0, 0)
		segmentInformationDisplay.starsContainerOverlay:setSpacing(5)
		for f9_local1 = 1, CoD.ManageSegments.MaxStars, 1 do
			segmentInformationDisplay.starsContainerOverlay[f9_local1] = LUI.UIImage.new()
			segmentInformationDisplay.starsContainerOverlay[f9_local1]:setLeftRight(true, false, 0, CoD.ManageSegments.StarRatingIconSize)
			segmentInformationDisplay.starsContainerOverlay[f9_local1]:setTopBottom(false, false, -CoD.ManageSegments.StarRatingIconSize / 2, CoD.ManageSegments.StarRatingIconSize / 2)
			segmentInformationDisplay.starsContainerOverlay[f9_local1]:setRGB(1, 1, 0)
			segmentInformationDisplay.starsContainerOverlay[f9_local1]:setAlpha(0)
			segmentInformationDisplay.starsContainerOverlay:addElement(segmentInformationDisplay.starsContainerOverlay[f9_local1])
		end
		segmentInformationDisplay.starsContainer:addElement(segmentInformationDisplay.starsContainerOverlay)
	end
	segmentInformationDisplay.segmentTransitionText = LUI.UIText.new()
	segmentInformationDisplay.segmentTransitionText:setLeftRight(true, false, 0, CoD.ManageSegments.InformationDisplayWidth)
	segmentInformationDisplay.segmentTransitionText:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	segmentInformationDisplay.segmentTransitionText:setFont(CoD.fonts.Default)
	segmentInformationDisplay:addElement(segmentInformationDisplay.segmentTransitionText)
	f9_arg0.segmentInformationDisplay = segmentInformationDisplay
	
	f9_arg0:addElement(segmentInformationDisplay)
end

local f0_local7 = function (f10_arg0, f10_arg1)
	if not f10_arg1 then
		if f10_arg0.segmentIndex == CoD.ManageSegments.SelectedSegmentIndex then
			f10_arg0.bgImage:setRGB(0.9, 0.5, 0.1)
			f10_arg0.bgImage:setAlpha(0.2)
			f10_arg0.buttonTextBackground:setRGB(0, 0, 0)
			f10_arg0.buttonTextBackground:setAlpha(0.7)
			f10_arg0.buttonText:setRGB(1, 1, 1)
			f10_arg0.buttonText:setAlpha(1)
		elseif f10_arg0.filled then
			f10_arg0.border:setAlpha(0)
			f10_arg0.bgImage:setRGB(1, 1, 1)
			f10_arg0.bgImage:setAlpha(0.5)
			f10_arg0.buttonTextBackground:setRGB(0, 0, 0)
			f10_arg0.buttonTextBackground:setAlpha(0.7)
			f10_arg0.buttonText:setRGB(1, 1, 1)
			f10_arg0.buttonText:setAlpha(1)
			if f10_arg0.menu.timelineContainer ~= nil then
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].border:setAlpha(0)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].image:setRGB(1, 1, 1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].image:setAlpha(1)
			end
		else
			f10_arg0.border:setRGB(1, 1, 1)
			f10_arg0.border:setAlpha(0.3)
			f10_arg0.bgImage:setAlpha(0)
			f10_arg0.buttonTextBackground:setAlpha(0)
			f10_arg0.buttonText:setRGB(1, 1, 1)
			f10_arg0.buttonText:setAlpha(0.3)
		end
		f10_arg0.focussed = false
	else
		if f10_arg0.segmentIndex == CoD.ManageSegments.SelectedSegmentIndex then
			f10_arg0.bgImage:setRGB(0.9, 0.5, 0.1)
			f10_arg0.bgImage:setAlpha(0.2)
			f10_arg0.buttonTextBackground:setRGB(0, 0, 0)
			f10_arg0.buttonTextBackground:setAlpha(0.7)
			f10_arg0.buttonText:setRGB(1, 1, 1)
			f10_arg0.buttonText:setAlpha(1)
			if f10_arg0.menu.timelineContainer ~= nil then
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].border:setRGB(0.9, 0.5, 0.1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].border:setAlpha(1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].image:setRGB(0.9, 0.5, 0.1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].image:setAlpha(1)
			end
			f10_arg0.menu.segmentInformationDisplay.segmentIndex = f10_arg0.segmentIndex
			f0_local5(f10_arg0.menu)
		elseif f10_arg0.filled then
			f10_arg0.border:setRGB(0.9, 0.5, 0.1)
			f10_arg0.border:setAlpha(1)
			f10_arg0.bgImage:setRGB(1, 1, 1)
			f10_arg0.bgImage:setAlpha(1)
			f10_arg0.buttonTextBackground:setRGB(0, 0, 0)
			f10_arg0.buttonTextBackground:setAlpha(0.7)
			f10_arg0.buttonText:setRGB(0.9, 0.5, 0.1)
			f10_arg0.buttonText:setAlpha(1)
			if f10_arg0.menu.timelineContainer ~= nil then
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].border:setRGB(0.9, 0.5, 0.1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].border:setAlpha(1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].image:setRGB(1, 1, 1)
				f10_arg0.menu.timelineContainer.timeline[f10_arg0.segmentIndex + 1].image:setAlpha(1)
			end
			f10_arg0.menu.segmentInformationDisplay.segmentIndex = f10_arg0.segmentIndex
			f0_local5(f10_arg0.menu)
		else
			f10_arg0.border:setRGB(0.9, 0.5, 0.1)
			f10_arg0.border:setAlpha(0.8)
			f10_arg0.bgImage:setAlpha(0)
			f10_arg0.buttonTextBackground:setAlpha(0)
			f10_arg0.buttonText:setRGB(0.9, 0.5, 0.1)
			f10_arg0.buttonText:setAlpha(1)
			f10_arg0.menu.segmentInformationDisplay.segmentIndex = f10_arg0.segmentIndex
			f0_local5(f10_arg0.menu)
		end
		f10_arg0.focussed = true
	end
end

local f0_local8 = function (f11_arg0, f11_arg1)
	f0_local7(f11_arg0, true)
	LUI.UIButton.gainFocus(f11_arg0, f11_arg1)
end

local f0_local9 = function (f12_arg0, f12_arg1)
	f0_local7(f12_arg0, false)
	LUI.UIButton.loseFocus(f12_arg0, f12_arg1)
end

local f0_local10 = function (f13_arg0)
	if f13_arg0.timelineContainer ~= nil then
		f13_arg0.timelineContainer:close()
	end
	f0_local4(f13_arg0)
end

local f0_local11 = function (f14_arg0, f14_arg1)
	local f14_local0, f14_local1 = nil
	local f14_local2 = f14_arg0:getParent()
	local f14_local3 = f14_local2.m_ownerController
	local f14_local4 = UIExpression.GetDemoSegmentCount()
	for f14_local5 = 1, f14_local4, 1 do
		if f14_arg0[f14_local5].focussed then
			f14_local0 = f14_arg0[f14_local5]
		end
	end
	if f14_local0 == nil then
		return 
	end
	f14_local1 = f14_local0.segmentIndex
	if nil == CoD.ManageSegments.SelectedSegmentIndex then
		f14_local2:openPopup("SegmentOptions", f14_local3, {
			segmentIndex = f14_local1
		})
		ManageSegments_RefreshButtonPrompts(f14_local2, false)
	else
		local f14_local5 = CoD.ManageSegments.SelectedSegmentIndex
		CoD.ManageSegments.SelectedSegmentIndex = nil
		if f14_local5 ~= f14_local1 then
			f0_local9(f14_arg0[f14_local5 + 1], f14_arg1)
			Engine.ExecNow(f14_local2:getOwner(), "demo_movesegment " .. f14_local5 .. " " .. f14_local1)
		end
		f14_local2:processEvent({
			name = "manage_segments_refresh",
			controller = f14_local3
		})
	end
end

local f0_local12 = function (f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = UIExpression.GetDemoSegmentCount()
	local f15_local1 = LUI.UIButton.new({
		left = 0,
		right = CoD.ManageSegments.SegmentButtonWidth,
		leftAnchor = true,
		rightAnchor = false,
		top = 0,
		bottom = CoD.ManageSegments.SegmentButtonHeight,
		topAnchor = true,
		bottomAnchor = false
	}, "segment_button_select")
	f15_local1.id = "Manage_Segments_Button" .. f15_arg1
	f15_local1.segmentIndex = (f15_arg2 - 1) * CoD.ManageSegments.MaxSegmentsPerRow + f15_arg1 - 1
	f15_local1.menu = f15_arg0
	if f15_local1.segmentIndex < f15_local0 then
		f15_local1.filled = true
	else
		f15_local1.filled = false
	end
	f15_local1.border = CoD.Border.new(2, 1, 1, 1)
	f15_local1:addElement(f15_local1.border)
	f15_local1.bgImage = LUI.UIImage.new()
	f15_local1.bgImage:setLeftRight(true, true, 2, -2)
	f15_local1.bgImage:setTopBottom(true, true, 2, -2)
	f15_local1.bgImage:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_THUMBNAIL, tostring(f15_local1.segmentIndex + 1))
	f15_local1:addElement(f15_local1.bgImage)
	local f15_local2 = f15_local1.segmentIndex + 1
	local f15_local3 = {}
	f15_local3 = GetTextDimensions(f15_local2, CoD.fonts.Default, CoD.textSize.Default)
	local f15_local4 = f15_local3[3]
	local f15_local5 = CoD.textSize.Default
	local f15_local6 = LUI.UIContainer.new()
	f15_local6:setLeftRight(true, false, 2, 2 + CoD.textSize.Default)
	f15_local6:setTopBottom(true, false, 2, 2 + CoD.textSize.Default)
	f15_local1:addElement(f15_local6)
	f15_local1.buttonTextBackground = LUI.UIImage.new()
	f15_local1.buttonTextBackground:setLeftRight(true, true, 0, 0)
	f15_local1.buttonTextBackground:setTopBottom(true, true, 0, 0)
	f15_local6:addElement(f15_local1.buttonTextBackground)
	f15_local1.buttonText = LUI.UIText.new()
	f15_local1.buttonText:setLeftRight(false, false, -f15_local4 / 2, f15_local4 / 2)
	f15_local1.buttonText:setTopBottom(false, false, -CoD.textSize.Default / 2 - 1, CoD.textSize.Default / 2 - 1)
	f15_local1.buttonText:setFont(CoD.fonts.Default)
	f15_local1.buttonText:setText(f15_local2)
	f15_local6:addElement(f15_local1.buttonText)
	f15_local1:registerEventHandler("gain_focus", f0_local8)
	f15_local1:registerEventHandler("lose_focus", f0_local9)
	f15_local1:registerEventHandler("segment_button_select", f0_local11)
	return f15_local1
end

local f0_local13 = function (f16_arg0)
	local f16_local0 = CoD.ManageSegments.NumRows
	local f16_local1 = LUI.UIGridList.new({
		left = 0,
		right = CoD.ManageSegments.TotalWidth,
		leftAnchor = true,
		rightAnchor = false,
		top = -CoD.ManageSegments.TotalHeight / 2 + CoD.ManageSegments.MaxSegmentsButtonTopOffset,
		bottom = CoD.ManageSegments.TotalHeight / 2 + CoD.ManageSegments.MaxSegmentsButtonTopOffset,
		topAnchor = false,
		bottomAnchor = false
	}, f16_local0, CoD.ManageSegments.MaxSegmentsPerRow)
	f16_local1:setSpacing(CoD.ManageSegments.SegmentButtonSpacing)
	f16_local1:setGridRowHeight(CoD.ManageSegments.SegmentButtonHeight)
	f16_local1.chainRows = true
	f16_arg0.manageSegmentsGrid = f16_local1
	for f16_local2 = 1, f16_local0, 1 do
		for f16_local5 = 1, CoD.ManageSegments.MaxSegmentsPerRow, 1 do
			local f16_local8 = f0_local12(f16_arg0, f16_local5, f16_local2)
			f16_local1[f16_local8.segmentIndex + 1] = f16_local8
			f16_local1:addElementToRow(f16_local8, f16_local2)
		end
	end
	if CoD.ManageSegments.SelectedSegmentIndex == nil then
		f16_local1:processEvent({
			name = "gain_focus"
		})
	end
	f16_local1:registerEventHandler("segment_button_select", f0_local11)
	f16_arg0:addElement(f16_local1)
end

local f0_local14 = function (f17_arg0, f17_arg1)
	local f17_local0 = UIExpression.GetDemoSegmentCount()
	if CoD.ManageSegments.SelectedSegmentIndex ~= nil and f17_local0 <= CoD.ManageSegments.SelectedSegmentIndex then
		CoD.ManageSegments.SelectedSegmentIndex = nil
	end
	f0_local10(f17_arg0)
	for f17_local1 = 1, CoD.ManageSegments.MaxSegments, 1 do
		local f17_local4 = f17_arg0.manageSegmentsGrid[f17_local1]
		if f17_local4.segmentIndex < f17_local0 then
			f17_local4.filled = true
		else
			f17_local4.filled = false
		end
		f0_local7(f17_local4, f17_local4.focussed)
	end
	ManageSegments_RefreshButtonPrompts(f17_arg0, true)
end

LUI.createMenu.Demo_Manage_Segments = function (f18_arg0)
	local f18_local0 = CoD.InGameMenu.New("Demo_Manage_Segments", f18_arg0, UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_MANAGE_SEGMENTS")))
	f18_local0:addBackButton()
	f18_local0:registerEventHandler("button_prompt_back", f0_local0)
	f18_local0:registerEventHandler("button_prompt_start", f0_local0)
	f18_local0:registerEventHandler("preview_clip", f0_local1)
	f18_local0:registerEventHandler("open_clip_options", f0_local2)
	f18_local0:registerEventHandler("manage_segments_refresh", f0_local14)
	f0_local4(f18_local0)
	f0_local6(f18_local0)
	f0_local13(f18_local0)
	f0_local3(f18_local0)
	f18_local0:processEvent({
		name = "manage_segments_refresh",
		controller = f18_arg0
	})
	Engine.Exec(f18_arg0, "setupThumbnailsForManageSegments")
	return f18_local0
end

CoD.SegmentsOptionsPopupHeight = 256
CoD.SegmentsOptionsPopupHeightOffset = 40
local f0_local15 = function (f19_arg0, f19_arg1)
	Engine.ExecNow(f19_arg1.controller, "demo_deletesegment " .. f19_arg0.userData.segmentIndex)
	f19_arg0:setPreviousMenu(nil)
	f19_arg0:goBack(f19_arg1.controller)
	f19_arg0.occludedMenu:processEvent({
		name = "manage_segments_refresh",
		controller = f19_arg1.controller
	})
end

LUI.createMenu.DeleteSegment = function (f20_arg0, f20_arg1)
	local f20_local0 = CoD.Popup.SetupPopupChoice("DeleteSegment", f20_arg0)
	f20_local0:setTopBottom(false, false, (-CoD.SegmentsOptionsPopupHeight - CoD.SegmentsOptionsPopupHeightOffset) / 2, (CoD.SegmentsOptionsPopupHeight + CoD.SegmentsOptionsPopupHeightOffset) / 2)
	f20_local0.smallPopupBackground:setTopBottom(false, false, -CoD.SegmentsOptionsPopupHeight / 2 - CoD.SegmentsOptionsPopupHeightOffset - 10, CoD.SegmentsOptionsPopupHeight / 2 + 10)
	f20_local0.userData = f20_arg1
	f20_local0.title:setText(Engine.Localize("MENU_WARNING"))
	f20_local0.msg:setText(Engine.Localize("MENU_DELETE_SEGMENT_CONFIRMATION"))
	f20_local0:addBackButton()
	f20_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f20_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f20_local0.choiceA:setActionEventName("delete_segment_accept")
	f20_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f20_local0:registerEventHandler("delete_segment_accept", f0_local15)
	return f20_local0
end

CoD.DEMO_CLIP_TRANSITION_NONE = 0
CoD.DEMO_CLIP_TRANSITION_FADE = 1
local f0_local16 = function (f21_arg0, f21_arg1)
	f21_arg0:goBack(f21_arg1.controller)
	f21_arg0.occludedMenu:processEvent({
		name = "manage_segments_refresh",
		controller = f21_arg1.controller
	})
end

local f0_local17 = function (f22_arg0, f22_arg1)
	CoD.ManageSegments.SelectedSegmentIndex = f22_arg0.userData.segmentIndex
	f22_arg0:goBack(f22_arg1.controller)
	f0_local0(f22_arg0.occludedMenu, f22_arg1)
	Engine.Exec(f22_arg1.controller, "demo_previewsegment " .. CoD.ManageSegments.SelectedSegmentIndex)
end

local f0_local18 = function (f23_arg0)
	Engine.ExecNow(f23_arg0.controller, "demo_switchtransition " .. f23_arg0.segmentIndex .. " " .. f23_arg0.value)
	local f23_local0 = f23_arg0.parentButton:getParent()
	local f23_local1 = f23_local0:getParent()
	if f23_local1.occludedMenu ~= nil then
		f23_local1.occludedMenu:processEvent({
			name = "manage_segments_refresh",
			controller = f23_arg0.controller
		})
	end
end

local f0_local19 = function (f24_arg0, f24_arg1)
	f24_arg0.occludedMenu:processEvent({
		name = "manage_segments_refresh",
		controller = f24_arg1.controller
	})
end

local f0_local20 = function (f25_arg0, f25_arg1)
	Engine.Exec(f25_arg1.controller, "demo_keyboard segmentName " .. f25_arg0.userData.segmentIndex)
end

local f0_local21 = function (f26_arg0, f26_arg1)
	f26_arg0:openMenu("DeleteSegment", f26_arg1.controller, f26_arg0.userData)
	f26_arg0:close()
end

local f0_local22 = function (f27_arg0, f27_arg1)
	CoD.ManageSegments.SelectedSegmentIndex = f27_arg0.userData.segmentIndex
	f0_local16(f27_arg0, f27_arg1)
end

LUI.createMenu.SegmentOptions = function (f28_arg0, f28_arg1)
	local f28_local0 = CoD.Popup.SetupPopup("SegmentOptions", f28_arg0)
	f28_local0:setTopBottom(false, false, (-CoD.SegmentsOptionsPopupHeight - CoD.SegmentsOptionsPopupHeightOffset) / 2, (CoD.SegmentsOptionsPopupHeight + CoD.SegmentsOptionsPopupHeightOffset) / 2)
	f28_local0.smallPopupBackground:setTopBottom(false, false, -CoD.SegmentsOptionsPopupHeight / 2 - CoD.SegmentsOptionsPopupHeightOffset - 10, CoD.SegmentsOptionsPopupHeight / 2 + 10)
	f28_local0.userData = f28_arg1
	f28_local0:addSelectButton()
	f28_local0:addBackButton()
	f28_local0:registerEventHandler("button_prompt_back", f0_local16)
	f28_local0:registerEventHandler("delete_segment_confirmation", f0_local21)
	f28_local0:registerEventHandler("preview_segment", f0_local17)
	f28_local0:registerEventHandler("rename_segment", f0_local20)
	f28_local0:registerEventHandler("demo_keyboard_complete", f0_local19)
	f28_local0:registerEventHandler("setup_move_segment", f0_local22)
	f28_local0.title:setText(Engine.Localize("MENU_SEGMENT_OPTIONS"))
	f28_local0.msg:setText(Engine.Localize("MENU_SEGMENT_OPTIONS_DESC"))
	local f28_local1 = f28_arg1.segmentIndex == UIExpression.GetDemoSegmentCount() - 1
	local f28_local2 = CoD.ButtonList.new({})
	f28_local2:setLeftRight(true, true, 0, 0)
	if f28_local1 then
		f28_local2:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 4 - 20, 0)
	else
		f28_local2:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 5 - 20, 0)
	end
	f28_local2:setSpacing(0)
	f28_local0:addElement(f28_local2)
	local f28_local3 = f28_local2:addButton(Engine.Localize("MPUI_PREVIEW"))
	f28_local3:setActionEventName("preview_segment")
	f28_local3:processEvent({
		name = "gain_focus"
	})
	local f28_local4 = f28_local2:addButton(Engine.Localize("MENU_MOVE"))
	f28_local4:setActionEventName("setup_move_segment")
	if not f28_local1 then
		local f28_local5 = f28_local2:addLeftRightSelector(Engine.Localize("MENU_CHANGE_TRANSITION"), tonumber(UIExpression.GetDemoSegmentInformation(f28_arg0, f28_arg1.segmentIndex, "transitionValue")))
		local f28_local6 = {}
		local f28_local7 = Engine.Localize("MENU_DEMO_TRANSITION_CUT")
		local f28_local8 = Engine.Localize("MENU_DEMO_TRANSITION_FADE")
		f28_local5.strings = f28_local7
		f28_local5.values = {
			CoD.DEMO_CLIP_TRANSITION_NONE,
			CoD.DEMO_CLIP_TRANSITION_FADE
		}
		for f28_local6 = 1, #f28_local5.strings, 1 do
			f28_local5:addChoice(Engine.Localize(f28_local5.strings[f28_local6]), f0_local18, {
				value = f28_local5.values[f28_local6],
				controller = f28_arg0,
				parentButton = f28_local5,
				segmentIndex = f28_arg1.segmentIndex
			})
		end
	end
	local f28_local9 = f28_local2:addButton(Engine.Localize("MENU_RENAME"))
	f28_local9:setActionEventName("rename_segment")
	local f28_local5 = f28_local2:addButton(Engine.Localize("MENU_DELETE"))
	f28_local5:setActionEventName("delete_segment_confirmation")
	return f28_local0
end

local f0_local23 = function (f29_arg0, f29_arg1)
	Engine.ExecNow(f29_arg1.controller, "demo_mergesegments")
	f29_arg0:setPreviousMenu(nil)
	f29_arg0:goBack(f29_arg1.controller)
	f29_arg0.occludedMenu:processEvent({
		name = "manage_segments_refresh",
		controller = f29_arg1.controller
	})
end

LUI.createMenu.MergeAllSegments = function (f30_arg0)
	local f30_local0 = CoD.Popup.SetupPopupChoice("MergeAllSegments", f30_arg0)
	f30_local0.title:setText(Engine.Localize("MENU_WARNING"))
	f30_local0.msg:setText(Engine.Localize("MENU_MERGE_ALL_SEGMENTS_CONFIRMATION"))
	f30_local0:addBackButton()
	f30_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f30_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f30_local0.choiceA:setActionEventName("merge_all_segments_accept")
	f30_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f30_local0:registerEventHandler("merge_all_segments_accept", f0_local23)
	return f30_local0
end

local f0_local24 = function (f31_arg0, f31_arg1)
	Engine.ExecNow(f31_arg1.controller, "demo_deleteclip")
	f31_arg0:setPreviousMenu(nil)
	f31_arg0:goBack(f31_arg1.controller)
	f31_arg0.occludedMenu:processEvent({
		name = "manage_segments_refresh",
		controller = f31_arg1.controller
	})
end

LUI.createMenu.DeleteAllSegments = function (f32_arg0)
	local f32_local0 = CoD.Popup.SetupPopupChoice("DeleteAllSegments", f32_arg0)
	f32_local0.title:setText(Engine.Localize("MENU_WARNING"))
	f32_local0.msg:setText(Engine.Localize("MENU_DELETE_ALL_SEGMENTS_CONFIRMATION"))
	f32_local0:addBackButton()
	f32_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f32_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f32_local0.choiceA:setActionEventName("delete_all_segments_accept")
	f32_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f32_local0:registerEventHandler("delete_all_segments_accept", f0_local24)
	return f32_local0
end

local f0_local25 = function (f33_arg0, f33_arg1)
	f33_arg0:openMenu("MergeAllSegments", f33_arg1.controller)
	f33_arg0:close()
end

local f0_local26 = function (f34_arg0, f34_arg1)
	f34_arg0:openMenu("DeleteAllSegments", f34_arg1.controller)
	f34_arg0:close()
end

LUI.createMenu.ClipOptions = function (f35_arg0)
	local f35_local0 = CoD.Menu.NewSmallPopup("ClipOptions")
	f35_local0:setOwner(f35_arg0)
	f35_local0:addSelectButton()
	f35_local0:addBackButton()
	f35_local0:registerEventHandler("merge_all_segments_confirmation", f0_local25)
	f35_local0:registerEventHandler("delete_all_segments_confirmation", f0_local26)
	local f35_local1 = 5
	local f35_local2 = LUI.UIText.new()
	f35_local2:setLeftRight(true, true, 0, 0)
	f35_local2:setTopBottom(true, false, f35_local1, f35_local1 + CoD.textSize.Big)
	f35_local2:setFont(CoD.fonts.Big)
	f35_local2:setAlignment(LUI.Alignment.Left)
	f35_local2:setText(Engine.Localize("MENU_CLIP_OPTIONS"))
	f35_local0:addElement(f35_local2)
	local f35_local3 = CoD.ButtonList.new({})
	f35_local3:setLeftRight(true, true, 0, 0)
	f35_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
	f35_local0:addElement(f35_local3)
	local f35_local4 = f35_local3:addButton(Engine.Localize("MENU_MERGE_ALL_SEGMENTS"))
	f35_local4:setActionEventName("merge_all_segments_confirmation")
	f35_local4:processEvent({
		name = "gain_focus"
	})
	if UIExpression.GetDemoSegmentCount() <= 1 then
		f35_local4:disable()
	end
	local f35_local5 = f35_local3:addButton(Engine.Localize("MENU_DELETE_ALL_SEGMENTS"))
	f35_local5:setActionEventName("delete_all_segments_confirmation")
	return f35_local0
end

