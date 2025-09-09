CoD.WeaponLevel = {}
CoD.WeaponLevel.FontName = "Default"
CoD.WeaponLevel.Font = CoD.fonts[CoD.WeaponLevel.FontName]
CoD.WeaponLevel.FontHeight = CoD.textSize[CoD.WeaponLevel.FontName]
CoD.WeaponLevel.FontAlpha = 0.4
CoD.WeaponLevel.FillInset = 2
CoD.WeaponLevel.FillTime = 150
CoD.WeaponLevel.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	Widget.width = InstanceRef
	Widget.update = CoD.WeaponLevel.Update
	local f1_local1 = LUI.UIText.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, false, 0, CoD.WeaponLevel.FontHeight)
	f1_local1:setAlpha(CoD.WeaponLevel.FontAlpha)
	f1_local1:setAlignment(LUI.Alignment.Left)
	f1_local1:setFont(CoD.WeaponLevel.Font)
	f1_local1:setText(Engine.Localize("MPUI_WEAPON_LEVEL_PROGRESS"))
	Widget:addElement(f1_local1)
	local f1_local2 = CoD.WeaponLevel.FontHeight + 2
	local f1_local3 = CoD.WeaponLevel.FontHeight
	Widget.barContainer = LUI.UIElement.new()
	Widget.barContainer:setLeftRight(true, true, 0, 0)
	Widget.barContainer:setTopBottom(true, false, f1_local2, f1_local2 + f1_local3)
	Widget:addElement(Widget.barContainer)
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(true, true, 1, -1)
	f1_local4:setTopBottom(true, true, 1, -1)
	f1_local4:setRGB(0, 0, 0)
	f1_local4:setAlpha(0.4)
	Widget.barContainer:addElement(f1_local4)
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(true, true, CoD.WeaponLevel.FillInset, -CoD.WeaponLevel.FillInset)
	f1_local5:setTopBottom(true, false, CoD.WeaponLevel.FillInset, 12)
	f1_local5:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f1_local5:setAlpha(0.1)
	Widget.barContainer:addElement(f1_local5)
	Widget.barContainer:addElement(CoD.Border.new(1, 1, 1, 1, 0.05))
	Widget.fill = LUI.UIElement.new()
	Widget.fill:setLeftRight(true, false, CoD.WeaponLevel.FillInset, -CoD.WeaponLevel.FillInset)
	Widget.fill:setTopBottom(true, true, CoD.WeaponLevel.FillInset, -CoD.WeaponLevel.FillInset)
	Widget.barContainer:addElement(Widget.fill)
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(true, true, 0, 0)
	f1_local6:setTopBottom(true, true, 0, 0)
	f1_local6:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget.fill:addElement(f1_local6)
	local f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(true, true, 0, 0)
	f1_local7:setTopBottom(true, false, 0, 12)
	f1_local7:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f1_local7:setAlpha(0.4)
	Widget.fill:addElement(f1_local7)
	local f1_local8 = -3
	Widget.currentLabel = LUI.UIText.new()
	Widget.currentLabel:setLeftRight(true, false, f1_local8 - 1, f1_local8)
	Widget.currentLabel:setTopBottom(true, false, 0, CoD.WeaponLevel.FontHeight)
	Widget.currentLabel:setAlpha(CoD.WeaponLevel.FontAlpha)
	Widget.currentLabel:setAlignment(LUI.Alignment.Right)
	Widget.currentLabel:setFont(CoD.WeaponLevel.Font)
	Widget.barContainer:addElement(Widget.currentLabel)
	local f1_local9 = -f1_local8 + 1
	Widget.nextLabel = LUI.UIText.new()
	Widget.nextLabel:setLeftRight(false, true, f1_local9, f1_local9 + 1)
	Widget.nextLabel:setTopBottom(true, false, 0, CoD.WeaponLevel.FontHeight)
	Widget.nextLabel:setAlpha(CoD.WeaponLevel.FontAlpha)
	Widget.nextLabel:setAlignment(LUI.Alignment.Left)
	Widget.nextLabel:setFont(CoD.WeaponLevel.Font)
	Widget.barContainer:addElement(Widget.nextLabel)
	local f1_local10 = (f1_local3 + 2) * 2
	local f1_local11 = f1_local10
	local f1_local12 = f1_local3
	local f1_local13 = f1_local11
	local f1_local14 = -6
	Widget.maxLevelContainer = LUI.UIElement.new()
	Widget.maxLevelContainer:setLeftRight(true, false, f1_local14, f1_local14 + f1_local13)
	Widget.maxLevelContainer:setTopBottom(true, false, f1_local2, f1_local2 + f1_local12)
	Widget.maxLevelContainer:setAlpha(0)
	Widget:addElement(Widget.maxLevelContainer)
	local f1_local15 = LUI.UIImage.new()
	f1_local15:setLeftRight(true, false, 0, f1_local11)
	f1_local15:setTopBottom(false, true, -f1_local10, 0)
	f1_local15:setImage(RegisterMaterial("menu_mp_weapon_lvl_loc"))
	Widget.maxLevelContainer:addElement(f1_local15)
	local f1_local16 = LUI.UIText.new()
	f1_local16:setLeftRight(true, true, 0, 0)
	f1_local16:setTopBottom(false, true, -CoD.WeaponLevel.FontHeight, 0)
	f1_local16:setRGB(0, 0, 0)
	f1_local16:setAlignment(LUI.Alignment.Center)
	f1_local16:setText(Engine.Localize("MPUI_MAX_CAPS"))
	Widget.maxLevelContainer:addElement(f1_local16)
	local f1_local17 = 0
	local f1_local18 = -6
	local f1_local19 = f1_local10 / 4
	Widget.prestige1Star = LUI.UIImage.new()
	Widget.prestige1Star:setLeftRight(false, true, f1_local18, f1_local18 + f1_local19)
	Widget.prestige1Star:setTopBottom(true, false, f1_local17, f1_local17 + f1_local19)
	Widget.prestige1Star:setImage(RegisterMaterial("menu_mp_weapon_lvl_star"))
	Widget.prestige1Star:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget.prestige1Star:setAlpha(0)
	Widget.maxLevelContainer:addElement(Widget.prestige1Star)
	f1_local17 = f1_local17 + f1_local19
	Widget.prestige2Star = LUI.UIImage.new()
	Widget.prestige2Star:setLeftRight(false, true, f1_local18, f1_local18 + f1_local19)
	Widget.prestige2Star:setTopBottom(true, false, f1_local17, f1_local17 + f1_local19)
	Widget.prestige2Star:setImage(RegisterMaterial("menu_mp_weapon_lvl_star"))
	Widget.prestige2Star:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget.prestige2Star:setAlpha(0)
	Widget.maxLevelContainer:addElement(Widget.prestige2Star)
	local f1_local20 = f1_local11 + f1_local18 + f1_local19 - 5
	local f1_local21 = f1_local2 + 1
	Widget.promptContainer = LUI.UIElement.new()
	Widget.promptContainer:setLeftRight(true, false, f1_local20, f1_local20 + 300)
	Widget.promptContainer:setTopBottom(true, false, f1_local21, f1_local21 + f1_local12)
	Widget:addElement(Widget.promptContainer)
	local f1_local22 = f1_local2 + f1_local3
	Widget.prestigeLabel = LUI.UIText.new()
	Widget.prestigeLabel:setLeftRight(true, true, 0, 0)
	Widget.prestigeLabel:setTopBottom(true, false, f1_local22, f1_local22 + CoD.WeaponLevel.FontHeight)
	Widget.prestigeLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget.prestigeLabel:setAlignment(LUI.Alignment.Left)
	Widget.prestigeLabel:setFont(CoD.WeaponLevel.Font)
	Widget:addElement(Widget.prestigeLabel)
	Widget:registerEventHandler("weapon_prestige", CoD.WeaponLevel.WeaponPrestige)
	return Widget
end

CoD.WeaponLevel.WeaponPrestige = function (f2_arg0, f2_arg1)
	f2_arg0:dispatchEventToParent(f2_arg1)
end

CoD.WeaponLevel.GetWeaponLevel = function (f3_arg0, f3_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) ~= true and UIExpression.SessionMode_IsSystemlinkGame() ~= 1 then
		local f3_local0 = Engine.GetGunCurrentRank(f3_arg0, f3_arg1)
		if f3_local0 > 0 and f3_local0 == Engine.GetGunNextRank(f3_arg0, f3_arg1) and Engine.GetGunCurrentRankXP(f3_arg0, f3_arg1) <= UIExpression.GetDStat(f3_arg0, "itemstats", f3_arg1, "xp") then
			return f3_local0
		end
	end
end

CoD.WeaponLevel.GetWeaponPLevel = function (f4_arg0, f4_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) ~= true and UIExpression.SessionMode_IsSystemlinkGame() ~= 1 then
		local f4_local0 = Engine.GetPlayerStats(f4_arg0)
		return f4_local0.itemStats[f4_arg1].pLevel:get()
	else

	end
end

CoD.WeaponLevel.Update = function (f5_arg0, f5_arg1, f5_arg2)
	if f5_arg2 == nil then
		f5_arg0:beginAnimation("hide")
		f5_arg0:setAlpha(0)
		return 
	end
	local f5_local0 = Engine.GetGunCurrentRank(f5_arg1, f5_arg2)
	local f5_local1 = Engine.GetGunNextRank(f5_arg1, f5_arg2)
	local f5_local2 = 0
	local f5_local3 = UIExpression.GetDStat(f5_arg1, "itemstats", f5_arg2, "xp")
	local f5_local4 = Engine.GetGunCurrentRankXP(f5_arg1, f5_arg2)
	local f5_local5 = CoD.WeaponLevel.GetWeaponPLevel(f5_arg1, f5_arg2)
	if f5_local0 == f5_local1 and f5_local4 <= f5_local3 then
		if f5_local1 == 0 then
			f5_arg0:beginAnimation("hide")
			f5_arg0:setAlpha(0)
		else
			f5_arg0:beginAnimation("show")
			f5_arg0:setAlpha(1)
		end
		f5_arg0.currentLabel:setText("")
		f5_arg0.nextLabel:setText("")
		f5_arg0.barContainer:beginAnimation("hide")
		f5_arg0.barContainer:setAlpha(0)
		if f5_local0 then
			f5_arg0.maxLevelContainer:beginAnimation("show")
			f5_arg0.maxLevelContainer:setAlpha(1)
			if f5_local5 and f5_local5 < CoD.MAX_WEAPON_PRESTIGE and UIExpression.IsItemPurchased(f5_arg1, f5_arg2) ~= 0 then
				if f5_arg0.prestigeButton == nil then
					local f5_local6 = CoD.ButtonPrompt.new
					local f5_local7 = "alt2"
					local f5_local8 = Engine.Localize("MPUI_PRESTIGE_WEAPON_CAPS")
					local f5_local9 = f5_arg0
					local f5_local10 = "weapon_prestige"
					local f5_local11, f5_local12 = false
					local f5_local13, f5_local14 = false
					f5_local6 = f5_local6(f5_local7, f5_local8, f5_local9, f5_local10, f5_local11, f5_local12, f5_local13, f5_local14, "P")
					f5_local6:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
					f5_arg0.promptContainer:addElement(f5_local6)
					f5_arg0.prestigeButton = f5_local6
				end
			elseif f5_arg0.prestigeButton then
				f5_arg0.prestigeButton:close()
				f5_arg0.prestigeButton = nil
			end
		end
	else
		f5_arg0:beginAnimation("show")
		f5_arg0:setAlpha(1)
		local f5_local6 = ""
		f5_arg0.currentLabel:setText(f5_local0 + 1)
		f5_arg0.nextLabel:setText(f5_local0 + 2)
		f5_arg0.barContainer:beginAnimation("show")
		f5_arg0.barContainer:setAlpha(1)
		local f5_local7 = Engine.GetGunPrevRankXP(f5_arg1, f5_arg2)
		local f5_local9 = Engine.GetGunCurrentRankXP(f5_arg1, f5_arg2) - f5_local7
		local f5_local10 = f5_local3 - f5_local7
		if f5_local9 ~= 0 then
			f5_local2 = f5_local10 / f5_local9
		end
		f5_arg0.maxLevelContainer:beginAnimation("hide")
		f5_arg0.maxLevelContainer:setAlpha(0)
		if f5_arg0.prestigeButton then
			f5_arg0.prestigeButton:close()
			f5_arg0.prestigeButton = nil
		end
	end
	if f5_local5 and f5_local5 > 0 then
		f5_arg0.prestigeLabel:setText(Engine.Localize("MPUI_WEAPON_PRESTIGE", f5_local5))
		if f5_local5 >= 1 then
			f5_arg0.prestige1Star:beginAnimation("show")
			f5_arg0.prestige1Star:setAlpha(1)
		end
		if f5_local5 >= 2 then
			f5_arg0.prestige2Star:beginAnimation("show")
			f5_arg0.prestige2Star:setAlpha(1)
		else
			f5_arg0.prestige2Star:beginAnimation("hide")
			f5_arg0.prestige2Star:setAlpha(0)
		end
	else
		f5_arg0.prestigeLabel:setText("")
		f5_arg0.prestige1Star:beginAnimation("hide")
		f5_arg0.prestige1Star:setAlpha(0)
		f5_arg0.prestige2Star:beginAnimation("hide")
		f5_arg0.prestige2Star:setAlpha(0)
	end
	local f5_local6 = (f5_arg0.width - CoD.WeaponLevel.FillInset * 2) * f5_local2
	f5_arg0.fill:beginAnimation("fill", CoD.WeaponLevel.FillTime)
	f5_arg0.fill:setLeftRight(true, false, CoD.WeaponLevel.FillInset, f5_local6)
end

CoD.WeaponLevel.WeaponLevelIconUpdate = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = Engine.GetGunCurrentRank(f6_arg1, f6_arg2)
	local f6_local1 = Engine.GetGunNextRank(f6_arg1, f6_arg2)
	local f6_local2 = UIExpression.GetDStat(f6_arg1, "itemstats", f6_arg2, "xp")
	local f6_local3 = Engine.GetGunCurrentRankXP(f6_arg1, f6_arg2)
	local f6_local4 = ""
	local f6_local5 = CoD.WeaponLevel.GetWeaponPLevel(f6_arg1, f6_arg2)
	if f6_local0 == f6_local1 and f6_local3 <= f6_local2 then
		if f6_local1 == 0 then
			f6_arg0:hide()
			return 
		end
		f6_local4 = Engine.Localize("MPUI_MAX_CAPS")
	else
		f6_local4 = f6_local0 + 1
	end
	if f6_local5 and f6_local5 > 0 then
		if f6_local5 >= 1 then
			f6_arg0.prestige1Star:beginAnimation("show")
			f6_arg0.prestige1Star:setAlpha(1)
		end
		if f6_local5 >= 2 then
			f6_arg0.prestige2Star:beginAnimation("show")
			f6_arg0.prestige2Star:setAlpha(1)
		else
			f6_arg0.prestige2Star:beginAnimation("hide")
			f6_arg0.prestige2Star:setAlpha(0)
		end
	else
		f6_arg0.prestige1Star:beginAnimation("hide")
		f6_arg0.prestige1Star:setAlpha(0)
		f6_arg0.prestige2Star:beginAnimation("hide")
		f6_arg0.prestige2Star:setAlpha(0)
	end
	f6_arg0.gunLevel:setText(f6_local4)
	f6_arg0:show()
end

CoD.WeaponLevel.GetWeaponLevelIcon = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5)
	local f7_local0 = 64
	local f7_local1 = 64
	local f7_local2 = 0
	local f7_local3 = 0
	if f7_arg0 then
		f7_local0 = f7_arg0
	end
	if f7_arg1 then
		f7_local1 = f7_arg1
	end
	if f7_arg4 then
		f7_local3 = f7_arg4
	end
	if f7_arg5 then
		f7_local2 = f7_arg5
	end
	local f7_local4 = 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f7_local4 - f7_local0, -f7_local4)
	Widget:setTopBottom(false, true, -f7_local4 - f7_local1, -f7_local4)
	Widget.update = CoD.WeaponLevel.WeaponLevelIconUpdate
	local gunLevelBg = LUI.UIImage.new()
	gunLevelBg:setLeftRight(true, true, 0, 0)
	gunLevelBg:setTopBottom(true, true, 0, 0)
	if Engine.GetLanguage() == "english" then
		gunLevelBg:setImage(RegisterMaterial("menu_mp_weapon_lvl"))
	else
		gunLevelBg:setImage(RegisterMaterial("menu_mp_weapon_lvl_loc"))
	end
	Widget:addElement(gunLevelBg)
	Widget.gunLevelBg = gunLevelBg
	
	local f7_local7 = 2
	if f7_arg3 then
		f7_local7 = f7_arg3
	end
	local f7_local8 = "Default"
	if f7_arg2 then
		f7_local8 = f7_arg2
	end
	local f7_local9 = CoD.textSize[f7_local8]
	
	local gunLevel = LUI.UIText.new()
	gunLevel:setLeftRight(true, true, 0, 0)
	gunLevel:setTopBottom(false, true, -f7_local7 - f7_local9, -f7_local7)
	gunLevel:setRGB(0, 0, 0)
	Widget:addElement(gunLevel)
	Widget.gunLevel = gunLevel
	
	local f7_local11 = -6 + f7_local3
	local f7_local12 = f7_local1 / 4
	local f7_local13 = -f7_local12 + f7_local2
	Widget.prestige1Star = LUI.UIImage.new()
	Widget.prestige1Star:setLeftRight(false, true, f7_local11, f7_local11 + f7_local12)
	Widget.prestige1Star:setTopBottom(false, true, f7_local13 - f7_local12, f7_local13)
	Widget.prestige1Star:setImage(RegisterMaterial("menu_mp_weapon_lvl_star"))
	Widget.prestige1Star:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	Widget.prestige1Star:setAlpha(0)
	Widget:addElement(Widget.prestige1Star)
	f7_local13 = f7_local13 + f7_local12
	Widget.prestige2Star = LUI.UIImage.new()
	Widget.prestige2Star:setLeftRight(false, true, f7_local11, f7_local11 + f7_local12)
	Widget.prestige2Star:setTopBottom(false, true, f7_local13 - f7_local12, f7_local13)
	Widget.prestige2Star:setImage(RegisterMaterial("menu_mp_weapon_lvl_star"))
	Widget.prestige2Star:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget.prestige2Star:setAlpha(0)
	Widget:addElement(Widget.prestige2Star)
	return Widget
end

