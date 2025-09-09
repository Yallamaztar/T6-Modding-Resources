require("T6.SPBinaryChoice")
CoD.ConfirmLeaveCampaign = {}
LUI.createMenu.ConfirmLeaveCampaign = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("ConfirmLeaveCampaign")
	f1_local0:registerEventHandler("leave_campaign2", CoD.ConfirmLeaveCampaign.LeaveCampaign2)
	Dvar.ui_campaignstate:set(0)
	Dvar.ui_aarmapname:set("")
	Engine.SendMenuResponse(f1_arg0, "campaign_state", "stop")
	Engine.SendMenuResponse(f1_arg0, "luisystem", "modal_stop")
	return f1_local0
end

CoD.ConfirmLeaveCampaign.LeaveCampaign2 = function (f2_arg0, f2_arg1)
	CoD.Menu.newStrikeForceAvailable = false
	f2_arg0:openMenu("CampaignMenu", f2_arg1.controller)
	f2_arg0:close()
end

