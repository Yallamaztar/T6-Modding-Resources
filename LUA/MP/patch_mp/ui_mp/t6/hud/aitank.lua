CoD.AITank = {}
LUI.createMenu.ai_tank_drone_mp = function (f1_arg0)
	local f1_local0 = CoD.AirVehicleHUD.new("ai_tank_drone_mp", f1_arg0)
	local f1_local1 = RegisterMaterial("mp_hud_scorestreak_bracket")
	local f1_local2 = RegisterMaterial("hud_rts_mech_arrow")
	local f1_local3 = 64
	local f1_local4 = 512
	local f1_local5 = 400
	local f1_local6 = 128
	local f1_local7 = 32
	local f1_local8 = 390
	local f1_local9 = 4
	local f1_local10 = LUI.UIImage.new()
	f1_local10:setLeftRight(false, false, -f1_local5, -f1_local5 + f1_local3)
	f1_local10:setTopBottom(false, false, -f1_local4 / 2, f1_local4 / 2)
	f1_local10:setImage(f1_local1)
	f1_local10:setRGB(f1_local0.colorR, f1_local0.colorG, f1_local0.colorB)
	f1_local0:addElement(f1_local10)
	local f1_local11 = LUI.UIImage.new()
	f1_local11:setLeftRight(false, false, f1_local5, f1_local5 - f1_local3)
	f1_local11:setTopBottom(false, false, -f1_local4 / 2, f1_local4 / 2)
	f1_local11:setImage(f1_local1)
	f1_local11:setRGB(f1_local0.colorR, f1_local0.colorG, f1_local0.colorB)
	f1_local0:addElement(f1_local11)
	local f1_local12 = LUI.UIImage.new()
	f1_local12:setLeftRight(false, false, -f1_local8, -f1_local8 + f1_local6)
	f1_local12:setTopBottom(false, false, -f1_local7 / 2 - f1_local9, f1_local7 / 2 - f1_local9)
	f1_local12:setImage(f1_local2)
	f1_local0:addElement(f1_local12)
	local f1_local13 = LUI.UIImage.new()
	f1_local13:setLeftRight(false, false, f1_local8, f1_local8 - f1_local6)
	f1_local13:setTopBottom(false, false, -f1_local7 / 2 - f1_local9, f1_local7 / 2 - f1_local9)
	f1_local13:setImage(f1_local2)
	f1_local0:addElement(f1_local13)
	f1_local0:addCompass()
	if not CoD.isWIIU then
		local f1_local14 = LUI.UIImage.new()
		f1_local14:setLeftRight(false, false, -64, 64)
		f1_local14:setTopBottom(false, false, -32, 32)
		f1_local14:setImage(RegisterMaterial("mp_hud_agr_reticle"))
		f1_local0:addElement(f1_local14)
	end
	if CoD.IS_KILLCAM_OR_SPECTATE(f1_arg0) == 0 and UIExpression.IsDemoPlaying(f1_arg0) == 0 then
		local f1_local14 = LUI.UIText.new()
		f1_local14:setLeftRight(true, false, 0, 0)
		f1_local14:setTopBottom(false, true, -30 - CoD.textSize.Default, -30)
		f1_local14:setText(Engine.Localize("MP_REMOTE_EXIT"))
		f1_local14:setFont(CoD.fonts.Default)
		f1_local14:setRGB(f1_local0.colorR, f1_local0.colorG, f1_local0.colorB)
		f1_local0.leftButtonPrompts:addElement(f1_local14)
		local f1_local15 = LUI.UIText.new()
		f1_local15:setLeftRight(true, false, 0, 0)
		f1_local15:setTopBottom(false, true, -CoD.textSize.Default, 0)
		f1_local15:setText(Engine.Localize("KILLSTREAK_AI_TANK_ROCKETS"))
		f1_local15:setFont(CoD.fonts.Default)
		f1_local15:setRGB(f1_local0.colorR, f1_local0.colorG, f1_local0.colorB)
		f1_local0.leftButtonPrompts:addElement(f1_local15)
		local f1_local16 = LUI.UIText.new()
		f1_local16:setLeftRight(false, true, -1000, 0)
		f1_local16:setTopBottom(false, true, -CoD.textSize.Default, 0)
		f1_local16:setText(Engine.Localize("KILLSTREAK_AI_TANK_GUNS"))
		f1_local16:setFont(CoD.fonts.Default)
		f1_local16:setAlignment(LUI.Alignment.Right)
		f1_local16:setRGB(f1_local0.colorR, f1_local0.colorG, f1_local0.colorB)
		f1_local0.rightButtonPrompts:addElement(f1_local16)
	end
	return f1_local0
end

