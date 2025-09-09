CoD.ConfirmSFAvailable = {}
CoD.ConfirmSFAvailable.DefaultRTSMapName = "war_singapore"
CoD.ConfirmSFAvailable.DefaultCurrentMapIndex = 5
LUI.createMenu.ConfirmSFAvailable = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmSFAvailable", true)
	f1_local0:registerEventHandler("confirm_request", CoD.ConfirmSFAvailable.ConfirmRequest)
	local f1_local1 = 0
	local f1_local2 = "Default"
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local2])
	f1_local3:setFont(CoD.fonts[f1_local2])
	f1_local3:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local3)
	f1_local3:setText(Engine.Localize("MENU_SFAVAILABLE_CAPS"))
	CoD.AARUtility.LoadMaps()
	local f1_local4 = CoD.ConfirmSFAvailable.DefaultRTSMapName
	local f1_local5 = CoD.ConfirmSFAvailable.DefaultCurrentMapIndex
	if f1_arg1 then
		if f1_arg1.mapAlias then
			f1_local4 = f1_arg1.mapAlias
		end
		if f1_arg1.curMapIndex then
			f1_local5 = f1_arg1.curMapIndex
		end
	end
	local f1_local6 = -1
	local f1_local7 = nil
	for f1_local11, f1_local12 in ipairs(CoD.AARUtility.MapList) do
		if f1_local4 == f1_local12.alias then
			f1_local7 = f1_local12.display
			f1_local6 = f1_local12.rtsEnd
			break
		end
	end
	f1_local8 = 0
	for f1_local12, f1_local13 in ipairs(CoD.AARUtility.MapList) do
		if not f1_local13.isDevLevel and not f1_local13.isTutMap and not f1_local13.isRTSMap and f1_local5 <= f1_local13.levelNum and f1_local13.levelNum < f1_local6 then
			f1_local8 = f1_local8 + 1
		end
	end
	f1_local1 = f1_local1 + CoD.textSize[f1_local2] + 15
	f1_local9 = LUI.UIText.new()
	f1_local9:setLeftRight(true, true, 0, 0)
	f1_local9:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local2])
	f1_local9:setFont(CoD.fonts[f1_local2])
	f1_local9:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local9)
	if f1_local4 == "war_pakistan" then
		f1_local9:setText(Engine.Localize("MENU_SFAVAILABLE_DESC3", f1_local7 .. "_CAPS"))
	elseif f1_local4 == "war_socotra" then
		f1_local9:setText(Engine.Localize("MENU_SFAVAILABLE_DESC2", f1_local7 .. "_CAPS"))
	else
		f1_local9:setText(Engine.Localize("MENU_SFAVAILABLE_DESC1", f1_local7 .. "_CAPS", f1_local8))
	end
	f1_local0:addSelectButton()
	f1_local10 = CoD.ButtonList.new()
	f1_local10:setLeftRight(true, true, 0, 0)
	f1_local10:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height - 21, -15)
	f1_local0:addElement(f1_local10)
	f1_local11 = f1_local10:addButton(Engine.Localize("MENU_CONFIRM_CAPS"))
	f1_local11:setActionEventName("confirm_request")
	f1_local10:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.ConfirmSFAvailable.ConfirmRequest = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
end

