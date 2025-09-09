CoD.SystemInfo = {}
LUI.createMenu.SystemInfo = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("SystemInfo")
	f1_local0:setOwner(f1_arg0)
	f1_local0:addTitle(Engine.Localize("MENU_SYSTEM_INFO_CAPS"))
	f1_local0:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
	if CoD.isMultiplayer then
		f1_local0:addLargePopupBackground()
	end
	f1_local0:addBackButton()
	local f1_local1 = CoD.Menu.TitleHeight + 30
	local f1_local2 = 5
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
	f1_local3:setFont(CoD.fonts.Default)
	f1_local3:setAlignment(LUI.Alignment.Left)
	f1_local3:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_VERSION_NUMBER))
	f1_local0:addElement(f1_local3)
	if CoD.isPC and CoD.isSinglePlayer then
		return f1_local0
	end
	f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
	local f1_local4 = LUI.UIText.new()
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
	f1_local4:setFont(CoD.fonts.Default)
	f1_local4:setAlignment(LUI.Alignment.Left)
	f1_local4:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_CONNECTIVITY_INFO))
	f1_local0:addElement(f1_local4)
	f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
	local f1_local5 = LUI.UIText.new()
	f1_local5:setLeftRight(true, true, 0, 0)
	f1_local5:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
	f1_local5:setFont(CoD.fonts.Default)
	f1_local5:setAlignment(LUI.Alignment.Left)
	f1_local5:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_NAT_TYPE))
	f1_local0:addElement(f1_local5)
	f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
	local f1_local6 = LUI.UIText.new()
	f1_local6:setLeftRight(true, true, 0, 0)
	f1_local6:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
	f1_local6:setFont(CoD.fonts.Default)
	f1_local6:setAlignment(LUI.Alignment.Left)
	f1_local6:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_BANDWIDTH))
	f1_local0:addElement(f1_local6)
	f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
	local f1_local7 = LUI.UIText.new()
	f1_local7:setLeftRight(true, true, 0, 0)
	f1_local7:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
	f1_local7:setFont(CoD.fonts.Default)
	f1_local7:setAlignment(LUI.Alignment.Left)
	f1_local7:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_IP_ADDRESS))
	f1_local0:addElement(f1_local7)
	if CoD.isXBOX or CoD.isPS3 then
		f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
		local f1_local8 = LUI.UIText.new()
		f1_local8:setLeftRight(true, true, 0, 0)
		f1_local8:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
		f1_local8:setFont(CoD.fonts.Default)
		f1_local8:setAlignment(LUI.Alignment.Left)
		f1_local8:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_GEOGRAPHICAL_REGION))
		f1_local0:addElement(f1_local8)
	end
	f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
	local f1_local8 = LUI.UIText.new()
	f1_local8:setLeftRight(true, true, 0, 0)
	f1_local8:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
	f1_local8:setFont(CoD.fonts.Default)
	f1_local8:setAlignment(LUI.Alignment.Left)
	f1_local8:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_CUSTOMER_SUPPORT_LINK))
	f1_local0:addElement(f1_local8)
	if UIExpression.IsSuperUser() == true then
		f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
		local f1_local9 = LUI.UIText.new()
		f1_local9:setLeftRight(true, true, 0, 0)
		f1_local9:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
		f1_local9:setFont(CoD.fonts.Default)
		f1_local9:setAlignment(LUI.Alignment.Left)
		f1_local9:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_Q))
		f1_local0:addElement(f1_local9)
	end
	if not CoD.isPC then
		f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2 + CoD.textSize.Default + f1_local2 + CoD.textSize.Default + f1_local2 + CoD.textSize.Default + f1_local2
		local f1_local9 = LUI.UIText.new()
		f1_local9:setLeftRight(true, true, 0, 0)
		f1_local9:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
		f1_local9:setRGB(CoD.yellow.r, CoD.yellow.g, CoD.yellow.b)
		f1_local9:setFont(CoD.fonts.Default)
		f1_local9:setAlignment(LUI.Alignment.Left)
		f1_local9:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_CONSOLE_ID))
		f1_local0:addElement(f1_local9)
		f1_local1 = f1_local1 + CoD.textSize.Default + f1_local2
		local f1_local10 = LUI.UIText.new()
		f1_local10:setLeftRight(true, true, 0, 0)
		f1_local10:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Default)
		f1_local10:setRGB(CoD.yellow.r, CoD.yellow.g, CoD.yellow.b)
		f1_local10:setFont(CoD.fonts.Default)
		f1_local10:setAlignment(LUI.Alignment.Left)
		f1_local10:setText(UIExpression.GetSystemInfo(f1_arg0, CoD.SYSINFO_MAC_ADDRESS))
		f1_local0:addElement(f1_local10)
	end
	return f1_local0
end

