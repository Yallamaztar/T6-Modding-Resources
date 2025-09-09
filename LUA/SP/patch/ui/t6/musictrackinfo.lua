require("T6.CoDBase")
CoD.MusicTrackInfo = {}
CoD.MusicTrackInfo.new = function ()
	local Widget = LUI.UIElement.new({
		left = -CoD.SDSafeWidth / 2 + 64,
		right = CoD.SDSafeWidth / 2,
		top = -CoD.SDSafeHeight / 2 + 22,
		bottom = -CoD.SDSafeHeight / 2 + 20 + 22,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 0
	})
	Widget:registerAnimationState("visible", {
		alpha = 0.5
	})
	Widget:registerAnimationState("hidden", {
		alpha = 0
	})
	Widget:registerEventHandler("show_track_info", CoD.MusicTrackInfo.ShowTrackInfo)
	Widget:registerEventHandler("hide_track_info", CoD.MusicTrackInfo.HideTrackInfo)
	Widget.background = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		alpha = 1,
		material = RegisterMaterial("white")
	})
	Widget:addElement(Widget.background)
	Widget.musicTrackInfo = LUI.UIText.new({
		left = 36,
		right = 0,
		top = 2,
		bottom = -2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.8,
		font = CoD.fonts.SmallItalic,
		alignment = LUI.Alignment.Left
	})
	Widget:addElement(Widget.musicTrackInfo)
	return Widget
end

CoD.MusicTrackInfo.ShowTrackInfo = function (f2_arg0, f2_arg1)
	f2_arg0.musicTrackInfo:setText(Engine.GetIString(f2_arg1.data[1], "CS_LOCALIZED_STRINGS"))
	f2_arg0:animateToState("visible", 200)
end

CoD.MusicTrackInfo.HideTrackInfo = function (f3_arg0, f3_arg1)
	f3_arg0:animateToState("hidden", 200)
end

