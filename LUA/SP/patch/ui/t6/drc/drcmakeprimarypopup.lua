require("T6.Drc.DrcPopup")
CoD.DrcMakePrimaryPopup = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	if CoD.isWIIU then
		Engine.AssignController(0, f1_arg1)
		Engine.SetDvar("wiiu_controller_selector_popup_open", 0)
	end
	f1_arg0:drcPopupClose()
end

LUI.createMenu.DrcMakePrimaryPopup = function ()
	local f2_local0 = CoD.DrcPopup.New("DrcMakePrimaryPopup", "Would you like to make the DRC your primary device?", "yesno")
	f2_local0:registerEventHandler("drc_popup_yes", function (f3_arg0, f3_arg1)
		f0_local0(f3_arg0, true)
	end)
	f2_local0:registerEventHandler("drc_popup_no", function (f4_arg0, f4_arg1)
		f0_local0(f4_arg0, false)
	end)
	f2_local0.init = CoD.DrcMakePrimaryPopup.Init
	return f2_local0
end

