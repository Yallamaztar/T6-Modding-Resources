require("T6.GameOptions")
LUI.createMenu.EditGeneralOptions = function (f1_arg0)
	local f1_local0 = CoD.GameOptionsMenu.New(f1_arg0, "EditGeneralOptions")
	f1_local0:addTitle(Engine.Localize("MPUI_GENERAL_SETTINGS_CAPS"))
	for f1_local4, f1_local5 in ipairs(CoD.GameOptions.GeneralSettings) do
		f1_local0:addGametypeSetting(f1_arg0, f1_local5)
	end
	if not f1_local0.buttonList:restoreState() then
		f1_local0.buttonList:processEvent({
			name = "gain_focus"
		})
	end
	return f1_local0
end

