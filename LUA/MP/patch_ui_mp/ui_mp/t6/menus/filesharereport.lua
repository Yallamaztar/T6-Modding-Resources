CoD.FileshareReport = {}
CoD.FileshareReport.ReportEmblem = function (f1_arg0, f1_arg1)
	Engine.ExecNow(f1_arg1.controller, "reportUser " .. f1_arg0.m_authorXuid .. " offensive_emblem 1 1")
	if f1_arg0.m_fileID ~= nil then
		Engine.RecordOffensiveEmblem(f1_arg1.controller, f1_arg0.m_authorXuid, f1_arg0.m_fileID)
	end
	CoD.perController[f1_arg1.controller].reportData = nil
	f1_arg0:goBack(f1_arg1.controller)
end

LUI.createMenu.FileshareReport = function (f2_arg0)
	local f2_local0 = CoD.Menu.NewMediumPopup("FileshareReport")
	local f2_local1 = CoD.perController[f2_arg0].reportData
	f2_local0:setOwner(f2_arg0)
	f2_local0.m_authorXuid = f2_local1.authorXuid
	f2_local0.m_fileID = f2_local1.fileID
	f2_local0.body = LUI.UIElement.new()
	f2_local0.body:setLeftRight(true, true, 0, 0)
	f2_local0.body:setTopBottom(true, true, 0, 0)
	f2_local0:addElement(f2_local0.body)
	local f2_local2 = 0
	f2_local0.title = LUI.UIText.new()
	f2_local0.title:setLeftRight(true, true, 0, 0)
	f2_local0.title:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Big)
	f2_local0.title:setFont(CoD.fonts.Big)
	f2_local0.title:setAlignment(LUI.Alignment.Left)
	f2_local0.title:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_REPORT_EMBLEM")))
	f2_local0:addElement(f2_local0.title)
	local f2_local3 = f2_local2 + CoD.textSize.Big + 40
	local f2_local4 = CoD.ButtonList.new()
	f2_local4:setLeftRight(true, true, 0, 0)
	f2_local4:setTopBottom(true, false, f2_local3, f2_local3 + 300)
	f2_local0.choiceList = f2_local4
	f2_local0.body:addElement(f2_local4)
	local f2_local5 = f2_local4:addButton(Engine.Localize("MENU_FILESHARE_EMBLEM_IS_OFFENSIVE"))
	f2_local5:setActionEventName("report_emblem")
	f2_local5.hintText = Engine.Localize("MENU_FILESHARE_REPORT_EMBLEM_HINT")
	f2_local4:addElement(f2_local5)
	f2_local3 = f2_local3 + CoD.textSize.Default * 2 + 22
	f2_local0:registerEventHandler("report_emblem", CoD.FileshareReport.ReportEmblem)
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	f2_local3 = 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -470, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f2_local0.body:addElement(Widget)
	local f2_local7 = 250 * 9 / 16
	local f2_local8 = LUI.UIImage.new()
	f2_local8:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_EMBLEM, f2_local1.fileID)
	local f2_local9 = 128
	f2_local7 = f2_local9
	f2_local8:setLeftRight(true, false, 0, f2_local9)
	f2_local8:setTopBottom(true, false, f2_local3, f2_local3 + f2_local7)
	Widget:addElement(f2_local8)
	f2_local3 = f2_local3 + f2_local7
	local f2_local10 = LUI.UIText.new()
	f2_local10:setLeftRight(true, true, 0, 0)
	f2_local10:setTopBottom(true, false, f2_local3, f2_local3 + CoD.textSize.Condensed)
	f2_local10:setFont(CoD.fonts.Condensed)
	f2_local10:setText(f2_local1.name)
	f2_local10:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_local10:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f2_local10)
	f2_local3 = f2_local3 + CoD.textSize.Condensed
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f2_local3, f2_local3 + CoD.textSize.Default * 3)
	Widget:setUseStencil(true)
	Widget:addElement(Widget)
	local f2_local12 = LUI.UIText.new()
	f2_local12:setLeftRight(true, true, 0, 0)
	f2_local12:setTopBottom(true, false, 0, CoD.textSize.Default)
	f2_local12:setFont(CoD.fonts.Default)
	f2_local12:setText(f2_local1.description)
	f2_local12:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	f2_local12:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f2_local12)
	f2_local3 = f2_local3 + CoD.textSize.Default * 3
	local f2_local13 = LUI.UIText.new()
	f2_local13:setLeftRight(true, true, 0, 0)
	f2_local13:setTopBottom(true, false, f2_local3, f2_local3 + CoD.textSize.Default)
	f2_local13:setFont(CoD.fonts.Default)
	f2_local13:setText(f2_local1.time)
	f2_local13:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	f2_local13:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f2_local13)
	f2_local3 = f2_local3 + CoD.textSize.Default
	local f2_local14 = LUI.UIText.new()
	f2_local14:setLeftRight(true, true, 0, 0)
	f2_local14:setTopBottom(true, false, f2_local3, f2_local3 + CoD.textSize.Default)
	f2_local14:setFont(CoD.fonts.Default)
	f2_local14:setText(Engine.Localize("MENU_FILESHARE_AUTHOR") .. " " .. f2_local1.author)
	f2_local14:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_local14:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f2_local14)
	f2_local3 = f2_local3 + CoD.textSize.Default + 10
	local f2_local15 = CoD.FileshareManager.StatPanel(0, f2_local3, "views")
	f2_local15:update(f2_local1.views)
	Widget:addElement(f2_local15)
	local f2_local16 = CoD.FileshareManager.StatPanel(145, f2_local3, "likes")
	f2_local16:update(f2_local1.likes)
	Widget:addElement(f2_local16)
	local f2_local17 = CoD.FileshareManager.StatPanel(290, f2_local3, "dislikes")
	f2_local17:update(f2_local1.dislikes)
	Widget:addElement(f2_local17)
	f2_local5:processEvent({
		name = "gain_focus"
	})
	return f2_local0
end

