require("T6.Zombie.CraftableItemTombDisplay")
require("T6.Zombie.QuestItemTombDisplay")
require("T6.Zombie.PersistentItemTombDisplay")
require("T6.Zombie.CaptureZoneWheelTombDisplay")
CoD.ScoreboardCraftablesTombZombie = {}
CoD.ScoreboardCraftablesTombZombie.FontName = "ExtraSmall"
CoD.ScoreboardCraftablesTombZombie.BackgroundOffset = 4
CoD.ScoreboardCraftablesTombZombie.ContainerHeight = CoD.QuestItemTombDisplay.IconSize + CoD.textSize[CoD.QuestItemTombDisplay.FontName] + 10
CoD.ScoreboardCraftablesTombZombie.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		Widget:setLeftRight(true, true, 0, 0)
	else
		Widget:setLeftRight(true, true, -InstanceRef / 4 - 10, 0)
	end
	Widget:setTopBottom(true, false, -150, -20)
	HudRef:addElement(Widget)
	local f1_local1 = CoD.textSize[CoD.ScoreboardCraftablesTombZombie.FontName] + 12
	local f1_local2 = CoD.QuestItemTombDisplay.ContainerSize / 4
	local f1_local3 = true
	local f1_local4 = CoD.ScoreboardCraftablesTombZombie.BackgroundOffset
	local f1_local5 = f1_local1 + 10
	local f1_local6 = 0
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local6 = 22
	end
	local f1_local7 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local7 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer(Widget, 0, f1_local1, Engine.Localize("ZMUI_PERSISTENT_ITEMS"))
	end
	local f1_local8 = LUI.UIHorizontalList.new()
	f1_local8:setLeftRight(true, true, f1_local4, 0)
	f1_local8:setTopBottom(true, false, f1_local5, f1_local5 + CoD.ScoreboardCraftablesTombZombie.ContainerHeight)
	HudRef.persistentItemDisplay = CoD.PersistentItemTombDisplay.new(f1_local8)
	HudRef.persistentItemDisplay:registerEventHandler("update_persistent_item_display_scoreboard", CoD.PersistentItemTombDisplay.ScoreboardUpdate)
	Widget:addElement(HudRef.persistentItemDisplay)
	local f1_local9 = CoD.PersistentItemTombDisplay.AddPersistentStatusDisplay(HudRef.persistentItemDisplay, f1_local2, f1_local3, f1_local4, f1_local6)
	if f1_local7 then
		f1_local7:setLeftRight(true, false, 0, f1_local9 - 10)
	end
	local f1_local10 = f1_local9 + 5
	local f1_local11 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local11 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer(Widget, f1_local10, f1_local1, Engine.Localize("ZMUI_QUEST_ITEMS"))
	end
	local f1_local12 = LUI.UIHorizontalList.new()
	f1_local12:setLeftRight(true, true, f1_local4 + f1_local10, 0)
	f1_local12:setTopBottom(true, false, f1_local5, f1_local5 + CoD.ScoreboardCraftablesTombZombie.ContainerHeight)
	HudRef.questItemDisplay = CoD.QuestItemTombDisplay.new(f1_local12)
	HudRef.questItemDisplay:registerEventHandler("update_quest_item_display_scoreboard", CoD.QuestItemTombDisplay.ScoreboardUpdate)
	Widget:addElement(HudRef.questItemDisplay)
	local f1_local13 = CoD.QuestItemTombDisplay.AddQuestStatusDisplay(HudRef.questItemDisplay, f1_local2, f1_local3, f1_local4, f1_local6)
	HudRef.questItemDisplay.questStatusContainer:setAlpha(1)
	HudRef.questItemDisplay.showPlayerHighlight = true
	if f1_local11 then
		f1_local11:setLeftRight(true, false, f1_local10, f1_local10 + f1_local13 - 10)
	end
	local f1_local14 = f1_local10 + f1_local13 + 5
	local f1_local15 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local15 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer(Widget, f1_local14, f1_local1, Engine.Localize("ZMUI_RECIPES"))
	end
	local f1_local16 = LUI.UIHorizontalList.new()
	f1_local16:setLeftRight(true, true, f1_local4 + f1_local14, 0)
	f1_local16:setTopBottom(true, false, f1_local5, f1_local5 + CoD.ScoreboardCraftablesTombZombie.ContainerHeight)
	local f1_local17 = 0
	local f1_local18 = CoD.CraftableItemTombDisplay.ContainerSize / 4
	HudRef.craftableItemDisplay = CoD.CraftableItemTombDisplay.new(f1_local16)
	f1_local17 = CoD.CraftableItemTombDisplay.AddDisplayContainer(HudRef.craftableItemDisplay, f1_local18, f1_local3, f1_local4, f1_local6)
	HudRef.craftableItemDisplay:registerEventHandler("update_craftable_item_display_scoreboard", CoD.CraftableItemTombDisplay.ScoreboardUpdate)
	Widget:addElement(HudRef.craftableItemDisplay)
	if f1_local15 then
		f1_local15:setLeftRight(true, false, f1_local14, f1_local14 + f1_local17 - f1_local18)
	end
	local f1_local19 = f1_local14 + f1_local17 - 4
	local f1_local20 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local20 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer(Widget, f1_local19, f1_local1, Engine.Localize("ZMUI_CAPTURES"))
	end
	local f1_local21 = f1_local14 + f1_local17
	local f1_local22 = 50
	local f1_local23 = 95
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f1_local21, f1_local23 + f1_local21)
	Widget:setTopBottom(true, false, f1_local5, f1_local23 + f1_local5)
	local f1_local25 = 0
	HudRef.captureZoneWheelDisplay = CoD.CaptureZoneWheelTombDisplay.new(Widget)
	f1_local25 = CoD.CaptureZoneWheelTombDisplay.AddCaptureZoneWheel(HudRef.captureZoneWheelDisplay, f1_local23, f1_local3, f1_local4)
	HudRef.captureZoneWheelDisplay:registerEventHandler("update_capture_zone_wheel_display_scoreboard", CoD.CaptureZoneWheelTombDisplay.ScoreboardUpdate)
	Widget:addElement(HudRef.captureZoneWheelDisplay)
	if f1_local20 then
		f1_local20:setLeftRight(true, false, f1_local19, f1_local19 + f1_local25)
	end
	return HudRef
end

CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = CoD.ScoreboardCraftablesTombZombie.BackgroundOffset
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f2_arg1, 0)
	Widget:setTopBottom(true, false, 0, f2_arg2)
	f2_arg0:addElement(Widget)
	local f2_local2 = LUI.UIImage.new()
	f2_local2:setLeftRight(true, true, 0, 0)
	f2_local2:setTopBottom(true, true, 0, 0)
	f2_local2:setRGB(0, 0, 0)
	f2_local2:setAlpha(0.7)
	Widget:addElement(f2_local2)
	local f2_local3 = LUI.UIImage.new()
	f2_local3:setLeftRight(true, true, 2, -2)
	f2_local3:setTopBottom(true, false, 2, 7)
	f2_local3:setImage(RegisterMaterial("white"))
	f2_local3:setAlpha(0.06)
	Widget:addElement(f2_local3)
	local f2_local4 = CoD.textSize[CoD.ScoreboardCraftablesTombZombie.FontName]
	local f2_local5 = LUI.UIText.new()
	f2_local5:setLeftRight(true, true, f2_local0, 0)
	f2_local5:setTopBottom(false, false, -f2_local4 / 2, f2_local4 / 2)
	f2_local5:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_local5:setAlpha(0.5)
	f2_local5:setFont(CoD.fonts[CoD.ScoreboardCraftablesTombZombie.FontName])
	f2_local5:setAlignment(LUI.Alignment.Left)
	f2_local5:setText(f2_arg3)
	Widget:addElement(f2_local5)
	return Widget
end

