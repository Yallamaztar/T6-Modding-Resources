if CoD.isXbox then
	CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 60000
end
EnableGlobals()
function MOTD_NA_Only(f1_arg0)
	if CoD.isPS3 == false then
		return false
	elseif "BLUS31011" == Dvar.com_sku:get() then
		return true
	else
		return false
	end
end

function MOTD_ROW_Only(f2_arg0)
	if CoD.isPS3 == false then
		return false
	else
		local f2_local0 = {
			"BLES01717",
			"BLES01718",
			"BLES01719",
			"BLES01720",
			"BLUS31141",
			"BLUS31140",
			"BLJM60548",
			"BLJM60549",
			"NPUB31054",
			"NPUB31056",
			"NPUB31055",
			"NPEB01205",
			"NPEB01206",
			"NPEB01207",
			"NPEB01204"
		}
		if f2_local0[Dvar.com_sku:get()] then
			return true
		else
			return false
		end
	end
end

function MOTD_SeasonPassholder(f3_arg0)
	if Engine.IsContentAvailableByPakName("seasonpass") then
		return true
	else
		return false
	end
end

function MOTD_NA_SeasonPassholder(f4_arg0)
	if MOTD_SeasonPassholder(f4_arg0) and MOTD_NA_Only(f4_arg0) then
		return true
	else
		return false
	end
end

function MOTD_ROW_SeasonPassholder(f5_arg0)
	if MOTD_SeasonPassholder(f5_arg0) and MOTD_ROW_Only(f5_arg0) then
		return true
	else
		return false
	end
end

DisableGlobals()
