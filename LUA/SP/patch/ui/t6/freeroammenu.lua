require("T6.CoDBase")
CoD.FreeRoamMenu = {}
LUI.createMenu.FreeRoamMenu = function ()
	local f1_local0 = CoD.Menu.New("FreeRoamMenu")
	f1_local0:addGlassesToggleOnButton()
	f1_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f1_local0:registerAnimationState("show", {
		alpha = 1
	})
	f1_local0:beginAnimation("hide", 0)
	return f1_local0
end

