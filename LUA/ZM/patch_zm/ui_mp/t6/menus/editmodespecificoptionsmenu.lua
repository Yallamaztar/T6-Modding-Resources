require("T6.GameOptions")
LUI.createMenu.EditModeSpecificOptions = function (f1_arg0)
	local f1_local0 = CoD.GameOptionsMenu.New(f1_arg0, "EditModeSpecificOptions")
	local f1_local1 = Dvar.ui_gametype:get()
	f1_local0:addTitle(Engine.Localize("MPUI_GAME_MODE_SETTINGS_CAPS", Engine.Localize(UIExpression.TableLookup(f1_arg0, CoD.gametypesTable, 0, 0, 1, f1_local1, 2))))
	for f1_local5, f1_local6 in ipairs(CoD.GameOptions.SubLevelGametypeSettings[f1_local1]) do
		f1_local0:addGametypeSetting(f1_arg0, f1_local6)
	end
	if not f1_local0.buttonList:restoreState() then
		f1_local0.buttonList:processEvent({
			name = "gain_focus"
		})
	end
	return f1_local0
end

