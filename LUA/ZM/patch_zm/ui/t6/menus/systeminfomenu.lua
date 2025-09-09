CoD.SystemInfo = {}
CoD.SystemInfo.CopyToClipboard = function (f1_arg0)
	Engine.SetClipboard(table.concat(f1_arg0.infoTable, "\n"))
end

LUI.createMenu.SystemInfo = function (f2_arg0)
	local f2_local0 = CoD.Menu.New("SystemInfo")
	f2_local0:setOwner(f2_arg0)
	f2_local0:addTitle(Engine.Localize("MENU_SYSTEM_INFO_CAPS"))
	f2_local0:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
	f2_local0:registerEventHandler("copy_to_clipboard", CoD.SystemInfo.CopyToClipboard)
	if CoD.isMultiplayer then
		f2_local0:addLargePopupBackground()
	end
	local f2_local1 = nil
	if CoD.isPC then
		local f2_local2 = "SP"
		if CoD.isMultiplayer then
			if CoD.isZombie then
				f2_local2 = "ZM"
			else
				f2_local2 = "MP"
			end
		end
		f2_local0.infoTable = {}
		f2_local0.infoTable[#f2_local0.infoTable + 1] = "System Info for Call of Duty Black Ops 2: " .. f2_local2
	end
	f2_local0:addBackButton()
	f2_local0.CopyToClipboardButton = CoD.ButtonPrompt.new("select", Engine.Localize("PLATFORM_COPY_TO_CLIPBOARD_CAPS"), f2_local0, "copy_to_clipboard", nil, nil, nil, nil, "C")
	f2_local0:addRightButtonPrompt(f2_local0.CopyToClipboardButton)
	local f2_local2 = CoD.Menu.TitleHeight + 30
	local f2_local3 = 5
	local f2_local4 = LUI.UIText.new()
	f2_local4:setLeftRight(true, true, 0, 0)
	f2_local4:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local4:setFont(CoD.fonts.Default)
	f2_local4:setAlignment(LUI.Alignment.Left)
	f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_VERSION_NUMBER)
	f2_local4:setText(f2_local1)
	f2_local0:addElement(f2_local4)
	if CoD.isPC then
		f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
	end
	if CoD.isPC and CoD.isSinglePlayer then
		return f2_local0
	end
	f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
	local f2_local5 = LUI.UIText.new()
	f2_local5:setLeftRight(true, true, 0, 0)
	f2_local5:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local5:setFont(CoD.fonts.Default)
	f2_local5:setAlignment(LUI.Alignment.Left)
	f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_CONNECTIVITY_INFO)
	f2_local5:setText(f2_local1)
	f2_local0:addElement(f2_local5)
	if CoD.isPC then
		f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
	end
	f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
	local f2_local6 = LUI.UIText.new()
	f2_local6:setLeftRight(true, true, 0, 0)
	f2_local6:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local6:setFont(CoD.fonts.Default)
	f2_local6:setAlignment(LUI.Alignment.Left)
	f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_NAT_TYPE)
	f2_local6:setText(f2_local1)
	f2_local0:addElement(f2_local6)
	if CoD.isPC then
		f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
	end
	f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
	local f2_local7 = LUI.UIText.new()
	f2_local7:setLeftRight(true, true, 0, 0)
	f2_local7:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local7:setFont(CoD.fonts.Default)
	f2_local7:setAlignment(LUI.Alignment.Left)
	f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_BANDWIDTH)
	f2_local7:setText(f2_local1)
	f2_local0:addElement(f2_local7)
	if CoD.isPC then
		f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
	end
	f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
	local f2_local8 = LUI.UIText.new()
	f2_local8:setLeftRight(true, true, 0, 0)
	f2_local8:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local8:setFont(CoD.fonts.Default)
	f2_local8:setAlignment(LUI.Alignment.Left)
	f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_IP_ADDRESS)
	f2_local8:setText(f2_local1)
	f2_local0:addElement(f2_local8)
	if CoD.isPC then
		f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
	end
	if CoD.isXBOX or CoD.isPS3 or CoD.isPC then
		f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
		local f2_local9 = LUI.UIText.new()
		f2_local9:setLeftRight(true, true, 0, 0)
		f2_local9:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
		f2_local9:setFont(CoD.fonts.Default)
		f2_local9:setAlignment(LUI.Alignment.Left)
		f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_GEOGRAPHICAL_REGION)
		f2_local9:setText(f2_local1)
		f2_local0:addElement(f2_local9)
		if CoD.isPC then
			f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
		end
	end
	if CoD.isPC then
		f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
		local f2_local9 = LUI.UIText.new()
		f2_local9:setLeftRight(true, true, 0, 0)
		f2_local9:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
		f2_local9:setFont(CoD.fonts.Default)
		f2_local9:setAlignment(LUI.Alignment.Left)
		f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_XUID)
		f2_local9:setText(f2_local1)
		f2_local0:addElement(f2_local9)
		if CoD.isPC then
			f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
		end
	end
	f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
	local f2_local9 = LUI.UIText.new()
	f2_local9:setLeftRight(true, true, 0, 0)
	f2_local9:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local9:setFont(CoD.fonts.Default)
	f2_local9:setAlignment(LUI.Alignment.Left)
	f2_local1 = UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_CONNECTION_TYPE)
	f2_local9:setText(f2_local1)
	f2_local0:addElement(f2_local9)
	if CoD.isPC then
		f2_local0.infoTable[#f2_local0.infoTable + 1] = f2_local1
	end
	f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
	local f2_local10 = LUI.UIText.new()
	f2_local10:setLeftRight(true, true, 0, 0)
	f2_local10:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
	f2_local10:setFont(CoD.fonts.Default)
	f2_local10:setAlignment(LUI.Alignment.Left)
	f2_local10:setText(UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_CUSTOMER_SUPPORT_LINK))
	f2_local0:addElement(f2_local10)
	if UIExpression.IsSuperUser() == true then
		f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
		local f2_local11 = LUI.UIText.new()
		f2_local11:setLeftRight(true, true, 0, 0)
		f2_local11:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
		f2_local11:setFont(CoD.fonts.Default)
		f2_local11:setAlignment(LUI.Alignment.Left)
		f2_local11:setText(UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_Q))
		f2_local0:addElement(f2_local11)
	end
	if not CoD.isPC then
		f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3 + CoD.textSize.Default + f2_local3 + CoD.textSize.Default + f2_local3 + CoD.textSize.Default + f2_local3
		local f2_local11 = LUI.UIText.new()
		f2_local11:setLeftRight(true, true, 0, 0)
		f2_local11:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
		f2_local11:setRGB(CoD.yellow.r, CoD.yellow.g, CoD.yellow.b)
		f2_local11:setFont(CoD.fonts.Default)
		f2_local11:setAlignment(LUI.Alignment.Left)
		f2_local11:setText(UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_CONSOLE_ID))
		f2_local0:addElement(f2_local11)
		f2_local2 = f2_local2 + CoD.textSize.Default + f2_local3
		local f2_local12 = LUI.UIText.new()
		f2_local12:setLeftRight(true, true, 0, 0)
		f2_local12:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Default)
		f2_local12:setRGB(CoD.yellow.r, CoD.yellow.g, CoD.yellow.b)
		f2_local12:setFont(CoD.fonts.Default)
		f2_local12:setAlignment(LUI.Alignment.Left)
		f2_local12:setText(UIExpression.GetSystemInfo(f2_arg0, CoD.SYSINFO_MAC_ADDRESS))
		f2_local0:addElement(f2_local12)
	end
	return f2_local0
end

