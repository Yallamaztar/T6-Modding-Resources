require("T6.HUD.AmmoCounter")
require("T6.HUD.OffhandIcons")
CoD.F35AmmoCounter = {}
CoD.F35AmmoCounter.BracketWidth = CoD.AmmoCounter.BracketWidth
CoD.F35AmmoCounter.BracketHeight = CoD.AmmoCounter.BracketHeight
CoD.F35AmmoCounter.BracketMaterialName = CoD.AmmoCounter.BracketMaterialName
CoD.F35AmmoCounter.BracketLeftMaterialName = CoD.AmmoCounter.BracketLeftMaterialName
CoD.F35AmmoCounter.AmmoHexMaterial = CoD.AmmoCounter.AmmoHexMaterial
CoD.F35AmmoCounter.FullWidth = CoD.AmmoCounter.FullWidth
CoD.F35AmmoCounter.BracketAlpha = CoD.AmmoCounter.BracketAlpha
CoD.F35AmmoCounter.BracketColorValue = CoD.AmmoCounter.BracketColorValue
CoD.F35AmmoCounter.BracketOffset = CoD.AmmoCounter.BracketOffset
CoD.F35AmmoCounter.TextAlpha = CoD.AmmoCounter.TextAlpha
CoD.F35AmmoCounter.new = function ()
	local f1_local0 = -63
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = f1_local0 - CoD.F35AmmoCounter.FullWidth,
		right = f1_local0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.F35AmmoCounter.BracketHeight - CoD.OffhandIcons.Size,
		bottom = 0
	})
	Widget.id = Widget.id .. ".F35AmmoCounter"
	
	local ammoArea = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.F35AmmoCounter.BracketHeight
	})
	Widget:addElement(ammoArea)
	Widget.ammoArea = ammoArea
	
	ammoArea.hexBg = LUI.UIImage.new()
	ammoArea.hexBg:setLeftRight(true, true, 0, 0)
	ammoArea.hexBg:setTopBottom(true, true, 0, 0)
	ammoArea.hexBg:setImage(RegisterMaterial(CoD.F35AmmoCounter.AmmoHexMaterial))
	ammoArea.hexBg:setRGB(0, 0, 0)
	ammoArea.hexBg.id = ammoArea.hexBg.id .. ".HexBg"
	ammoArea:addElement(ammoArea.hexBg)
	ammoArea.bracketContainer = LUI.UIElement.new()
	ammoArea.bracketContainer:setLeftRight(true, true, 0, 0)
	ammoArea.bracketContainer:setTopBottom(true, true, 0, 0)
	ammoArea:addElement(ammoArea.bracketContainer)
	ammoArea.leftBracket = LUI.UIImage.new()
	ammoArea.leftBracket:setLeftRight(true, false, -CoD.F35AmmoCounter.BracketOffset, -CoD.F35AmmoCounter.BracketOffset + CoD.F35AmmoCounter.BracketWidth)
	ammoArea.leftBracket:setTopBottom(false, false, -CoD.F35AmmoCounter.BracketHeight / 2, CoD.F35AmmoCounter.BracketHeight / 2)
	ammoArea.leftBracket:setImage(RegisterMaterial(CoD.F35AmmoCounter.BracketLeftMaterialName))
	ammoArea.leftBracket:setRGB(CoD.F35AmmoCounter.BracketColorValue, CoD.F35AmmoCounter.BracketColorValue, CoD.F35AmmoCounter.BracketColorValue)
	ammoArea.leftBracket:setAlpha(CoD.F35AmmoCounter.BracketAlpha)
	ammoArea.leftBracket.id = ammoArea.leftBracket.id .. ".LeftBracket"
	ammoArea.bracketContainer:addElement(ammoArea.leftBracket)
	ammoArea.rightBracket = LUI.UIImage.new()
	ammoArea.rightBracket:setLeftRight(false, true, CoD.F35AmmoCounter.BracketOffset - CoD.F35AmmoCounter.BracketWidth, CoD.F35AmmoCounter.BracketOffset)
	ammoArea.rightBracket:setTopBottom(false, false, -CoD.F35AmmoCounter.BracketHeight / 2, CoD.F35AmmoCounter.BracketHeight / 2)
	ammoArea.rightBracket:setImage(RegisterMaterial(CoD.F35AmmoCounter.BracketMaterialName))
	ammoArea.rightBracket:setRGB(CoD.F35AmmoCounter.BracketColorValue, CoD.F35AmmoCounter.BracketColorValue, CoD.F35AmmoCounter.BracketColorValue)
	ammoArea.rightBracket:setAlpha(CoD.F35AmmoCounter.BracketAlpha)
	ammoArea.rightBracket.id = ammoArea.rightBracket.id .. ".RightBracket"
	ammoArea.bracketContainer:addElement(ammoArea.rightBracket)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = -CoD.OffhandIcons.BracketOffset,
		right = -CoD.OffhandIcons.BracketOffset,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.OffhandIcons.BracketHeight,
		bottom = 0
	})
	Widget:addElement(Widget)
	Widget.leftBracket = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = -CoD.OffhandIcons.BracketOffset,
		right = -CoD.OffhandIcons.BracketOffset + CoD.OffhandIcons.Size,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.OffhandIcons.Size / 2,
		bottom = CoD.OffhandIcons.Size / 2,
		material = RegisterMaterial(CoD.OffhandIcons.BracketMaterialName),
		zRot = 180,
		red = CoD.OffhandIcons.BracketColorValue,
		green = CoD.OffhandIcons.BracketColorValue,
		blue = CoD.OffhandIcons.BracketColorValue,
		alpha = CoD.AmmoCounter.BracketAlpha
	})
	Widget:addElement(Widget.leftBracket)
	Widget.rightBracket = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = CoD.OffhandIcons.BracketOffset - CoD.OffhandIcons.Size,
		right = CoD.OffhandIcons.BracketOffset,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.OffhandIcons.Size / 2,
		bottom = CoD.OffhandIcons.Size / 2,
		material = RegisterMaterial(CoD.OffhandIcons.BracketMaterialName),
		red = CoD.OffhandIcons.BracketColorValue,
		green = CoD.OffhandIcons.BracketColorValue,
		blue = CoD.OffhandIcons.BracketColorValue,
		alpha = CoD.AmmoCounter.BracketAlpha
	})
	Widget:addElement(Widget.rightBracket)
	Widget.f35Text = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		red = CoD.F35Hud.Blue.r,
		green = CoD.F35Hud.Blue.g,
		blue = CoD.F35Hud.Blue.b,
		alpha = 0
	})
	Widget:addElement(Widget.f35Text)
	Widget.f35Text:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.f35Text:registerAnimationState("show", {
		alpha = CoD.F35Hud.Blue.a
	})
	Widget.f35Text:setText("RCKT")
	Widget.f35Text:animateToState("show", 500)
	ammoArea:registerEventHandler("hud_f35_death_blossom", CoD.F35AmmoCounter.DeathBlossom)
	ammoArea:registerEventHandler("hud_weapon_heat", CoD.F35AmmoCounter.HUDWeaponHeat)
	Widget:registerEventHandler("hud_missile_fire", CoD.F35AmmoCounter.HUDMissileFire)
	return Widget
end

CoD.F35AmmoCounter.DeathBlossom = function (f2_arg0, f2_arg1)
	if not f2_arg0.deathBlossomText then
		f2_arg0.deathBlossomText = LUI.UIText.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = -CoD.textSize.Default * 2,
			bottom = -CoD.textSize.Default,
			red = CoD.F35Hud.Blue.r,
			green = CoD.F35Hud.Blue.g,
			blue = CoD.F35Hud.Blue.b,
			alpha = CoD.F35Hud.Blue.a,
			alignment = LUI.Alignment.Center
		})
		f2_arg0:addElement(f2_arg0.deathBlossomText)
		f2_arg0.deathBlossomText:registerAnimationState("highlight1", {
			alpha = 1
		})
		f2_arg0.deathBlossomText:registerAnimationState("highlight2", {
			alpha = 0.5
		})
		f2_arg0.deathBlossomText:registerEventHandler("transition_complete_highlight1", function (Sender, Event)
			if not Sender.interrupted then
				Sender:animateToState("highlight2", 500)
			end
		end)
		f2_arg0.deathBlossomText:registerEventHandler("transition_complete_highlight2", function (Sender, Event)
			if not Sender.interrupted then
				Sender:animateToState("highlight1", 500)
			end
		end)
		f2_arg0.deathBlossomText:setText(Engine.Localize("LA_2_SKY_BUSTERS_ONLINE"))
		f2_arg0.deathBlossomText:animateToState("highlight1")
	end
end

CoD.F35AmmoCounter.HUDWeaponHeat = function (f3_arg0, f3_arg1)
	local f3_local0 = 6
	local f3_local1 = 3
	if not f3_arg0.f35AmmoBoxes then
		f3_arg0.f35AmmoBoxes = {}
		local f3_local2 = 32
		local f3_local3 = 16
		local f3_local4 = 8
		local f3_local5 = -16
		local f3_local6 = -14
		local f3_local7 = RegisterMaterial("hud_f35_ammo")
		for f3_local8 = -(f3_local1 - 1) / 2, (f3_local1 - 1) / 2, 1 do
			for f3_local11 = -(f3_local0 - 1) / 2, (f3_local0 - 1) / 2, 1 do
				local f3_local14 = LUI.UIImage.new({
					leftAnchor = false,
					rightAnchor = false,
					left = f3_local5 + f3_local11 * f3_local3,
					right = f3_local5 + f3_local11 * f3_local3 + f3_local2,
					topAnchor = false,
					bottomAnchor = false,
					top = f3_local6 + f3_local8 * f3_local4,
					bottom = f3_local6 + f3_local8 * f3_local4 + f3_local2,
					alpha = 1,
					material = f3_local7
				})
				f3_arg0:addElement(f3_local14)
				f3_local14:registerAnimationState("hide", {
					alpha = 0
				})
				table.insert(f3_arg0.f35AmmoBoxes, f3_local14)
			end
		end
	end
	local f3_local2 = 0
	if f3_arg1.data then
		f3_local2 = f3_arg1.data[1]
	end
	local f3_local3 = math.floor(f3_local0 * f3_local1 * f3_local2 / 100) + 1
	for f3_local7, f3_local8 in ipairs(f3_arg0.f35AmmoBoxes) do
		if f3_local7 < f3_local3 then
			if f3_local8.hidden then
				f3_local8.hidden = nil
				f3_local8:animateToState("default")
			end
		end
		if not f3_local8.hidden then
			f3_local8.hidden = true
			f3_local8:animateToState("hide")
		end
	end
end

CoD.F35AmmoCounter.HUDMissileFire = function (f4_arg0, f4_arg1)
	if f4_arg0.f35Text then
		f4_arg0.f35Text:animateToState("hide")
		f4_arg0.f35Text:animateToState("show", 1000)
	end
end

