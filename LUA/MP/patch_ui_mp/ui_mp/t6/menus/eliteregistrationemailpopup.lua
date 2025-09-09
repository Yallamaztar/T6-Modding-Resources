require("T6.Menus.EliteRegistrationSuccessPopups")
CoD.EliteRegistrationEmailPopup = {}
CoD.EliteRegistrationEmailPopup.UCDAccountUpdate = false
CoD.EliteRegistrationEmailPopup.NO_DATA_REF = ""
CoD.EliteRegistrationEmailPopup.processing_type = 0
CoD.EliteRegistrationEmailPopup.CanCheckFields = false
CoD.EliteRegistrationEmailPopup.GlobalButtonWidth = CoD.ButtonList.DefaultWidth - 30
CoD.EliteRegistrationEmailPopup.first_name_text = ""
CoD.EliteRegistrationEmailPopup.last_name_text = ""
CoD.EliteRegistrationEmailPopup.zip_text = ""
CoD.EliteRegistrationEmailPopup.account_name_text = ""
CoD.EliteRegistrationEmailPopup.email_address_text = ""
CoD.EliteRegistrationEmailPopup.password_text = ""
CoD.EliteRegistrationEmailPopup.confirm_password_text = ""
CoD.EliteRegistrationEmailPopup.first_name_button = {}
CoD.EliteRegistrationEmailPopup.last_name_button = {}
CoD.EliteRegistrationEmailPopup.zip_button = nil
CoD.EliteRegistrationEmailPopup.zip_spacer = nil
CoD.EliteRegistrationEmailPopup.account_name_button = {}
CoD.EliteRegistrationEmailPopup.email_address_button = {}
CoD.EliteRegistrationEmailPopup.password_button = {}
CoD.EliteRegistrationEmailPopup.confirm_password_button = {}
CoD.EliteRegistrationEmailPopup.buttonSubmit = {}
CoD.EliteRegistrationEmailPopup.HorizontalGap = 100
CoD.EliteRegistrationEmailPopup.Country = {}
CoD.EliteRegistrationEmailPopup.DOB_MM = {}
CoD.EliteRegistrationEmailPopup.DOB_DD = {}
CoD.EliteRegistrationEmailPopup.DOB_YYYY = {}
CoD.EliteRegistrationEmailPopup.Subscribe = nil
CoD.EliteRegistrationEmailPopup.Subscribe_spacer = nil
CoD.EliteRegistrationEmailPopup.country_val = 0
CoD.EliteRegistrationEmailPopup.dob_mm_val = 0
CoD.EliteRegistrationEmailPopup.dob_dd_val = 0
CoD.EliteRegistrationEmailPopup.dob_yyyy_val = 0
CoD.EliteRegistrationEmailPopup.subscribe_val = 0
CoD.EliteRegistrationEmailPopup.keyboard = "ui_keyboard_new "
CoD.EliteRegistrationEmailPopup.SignedOut = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg0:getRoot()
	f1_arg0:goBack(f1_arg1.controller)
	f1_local0:processEvent({
		name = "open_popup",
		popupName = "signed_out",
		controller = f1_arg1.controller
	})
end

CoD.EliteRegistrationEmailPopup.EliteRegistrationEmailPopupRequested = function (f2_arg0, f2_arg1)
	if Engine.UCDSupportsAutoFill(f2_arg1.controller) then
		local f2_local0 = f2_arg0:openPopup("EliteRegistrationAutoFillPopup", f2_arg1.controller, {
			hasUCDAccount = true
		})
	elseif Engine.PlatformSupportsAutoFill(f2_arg1.controller) then
		local f2_local0 = f2_arg0:openPopup("EliteRegistrationAutoFillPopup", f2_arg1.controller)
	else
		local f2_local0 = f2_arg0:openPopup("EliteRegistrationEmailPopup", f2_arg1.controller)
	end
end

CoD.EliteRegistrationEmailPopup.AutoFillPopup_Closed = function (f3_arg0, f3_arg1)
	if f3_arg1.fail ~= nil then
		local f3_local0 = f3_arg0:openPopup("EliteRegistrationSuccessPopup", f3_arg1.controller, {
			fail = true
		})
	elseif f3_arg1.password ~= nil then
		local f3_local0 = f3_arg0:openPopup("EliteRegistrationEmailPopup", f3_arg1.controller, f3_arg1.password)
	else
		local f3_local0 = f3_arg0:openPopup("EliteRegistrationEmailPopup", f3_arg1.controller)
	end
end

local f0_local0 = function (f4_arg0, f4_arg1)
	if CoD.EliteRegistrationEmailPopup.password_text == "" or CoD.EliteRegistrationEmailPopup.password_text == nil or CoD.EliteRegistrationEmailPopup.password_text ~= CoD.EliteRegistrationEmailPopup.confirm_password_text then
		CoD.EliteRegistrationEmailPopup.confirm_password_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.confirm_password_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_MATCH_ERROR")
		if not f4_arg1 then
			CoD.EliteRegistrationEmailPopup.confirm_password_button:processEvent({
				name = "gain_focus"
			})
		end
		f4_arg1 = true
	else
		CoD.EliteRegistrationEmailPopup.confirm_password_button:showRestrictedIcon(false)
		CoD.EliteRegistrationEmailPopup.confirm_password_button.hintText = Engine.Localize("MPUI_HINTTEXT_CONFIRMPASSWORD")
	end
	return f4_arg1
end

local f0_local1 = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = false
	if CoD.EliteRegistrationEmailPopup.CanCheckFields then
		if f5_arg1 == "" or f5_arg1 == 0 then
			f5_local0 = true
		end
		if f5_local0 then
			f5_arg2:showRestrictedIcon(true)
		else
			f5_arg2:showRestrictedIcon(false)
		end
	end
	return f5_local0
end

local f0_local2 = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = false
	strLength = string.len(f6_arg1)
	if f6_arg2 ~= nil and strLength < f6_arg2 then
		f6_local0 = true
	end
	if not f6_local0 and f6_arg3 ~= nil and strLength < f6_arg3 then
		f6_local0 = true
	end
	if f6_local0 then
		button:showRestrictedIcon(true)
	else
		button:showRestrictedIcon(false)
	end
	return f6_local0
end

function GetDisplayedText(f7_arg0)
	local f7_local0 = nil
	if f7_arg0 == "" or f7_arg0 == nil then
		f7_local0 = Engine.Localize(CoD.EliteRegistrationEmailPopup.NO_DATA_REF)
	else
		f7_local0 = f7_arg0
		local f7_local1 = string.len(f7_local0)
		if f7_local1 > 15 then
			for f7_local2 = f7_local1, 16, -1 do
				local f7_local5 = {}
				f7_local5 = GetTextDimensions(f7_local0, CoD.fonts.Default, CoD.textSize.Default)
				if f7_local5[3] >= CoD.EliteRegistrationEmailPopup.GlobalButtonWidth - CoD.textSize.Default then
					f7_local0 = string.sub(f7_arg0, 0, f7_local2 - 1)
				end
			end
		end
	end
	return f7_local0
end

function GetDisplayedPassword(f8_arg0)
	local f8_local0 = ""
	local f8_local1 = string.len(f8_arg0)
	if f8_local1 == 0 then
		f8_local0 = GetDisplayedText(f8_arg0)
	else
		for f8_local2 = 1, f8_local1, 1 do
			local f8_local5 = f8_local2
			f8_local0 = "*" .. f8_local0
		end
		f8_local0 = string.sub(f8_local0, 0, 29)
	end
	return f8_local0
end

local f0_local3 = function ()
	if CoD.EliteRegistrationEmailPopup.dob_mm_val > 0 and CoD.EliteRegistrationEmailPopup.dob_dd_val > 0 and CoD.EliteRegistrationEmailPopup.dob_yyyy_val > 0 then
		CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = Engine.Localize("MPUI_HINTTEXT_MM")
		CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = Engine.Localize("MPUI_HINTTEXT_DD")
		CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = Engine.Localize("MPUI_HINTTEXT_YYYY")
		CoD.EliteRegistrationEmailPopup.DOB_DD:showRestrictedIcon(false)
		CoD.EliteRegistrationEmailPopup.DOB_MM:showRestrictedIcon(false)
		CoD.EliteRegistrationEmailPopup.DOB_YYYY:showRestrictedIcon(false)
	end
end

local f0_local4 = function (f10_arg0)
	CoD.EliteRegistrationEmailPopup.subscribe_val = f10_arg0.value
end

local f0_local5 = function (f11_arg0)
	if CoD.EliteRegistrationEmailPopup.country_val > 0 and CoD.EliteRegistrationEmailPopup.dob_mm_val > 0 and CoD.EliteRegistrationEmailPopup.dob_dd_val > 0 and CoD.EliteRegistrationEmailPopup.dob_yyyy_val > 0 and Engine.IsPlayerEliteEnrollNotificationAgeOK(CoD.EliteRegistrationEmailPopup.country_val, CoD.EliteRegistrationEmailPopup.dob_mm_val, CoD.EliteRegistrationEmailPopup.dob_dd_val, CoD.EliteRegistrationEmailPopup.dob_yyyy_val) then
		if CoD.EliteRegistrationEmailPopup.Subscribe == nil then
			CoD.EliteRegistrationEmailPopup.Subscribe = CoD.EliteRegistrationEmailPopup.popup.buttonList:addLeftRightSelector("", 0, -9, nil, 12, "Default")
			CoD.EliteRegistrationEmailPopup.Subscribe.hintText = Engine.Localize("MPUI_HINTTEXT_SUBSCRIBE")
			CoD.EliteRegistrationEmailPopup.Subscribe:addChoice(Engine.Localize("MPUI_ELITE_NO"), f0_local4, {
				self = newPopup,
				value = 0,
				parentButton = CoD.EliteRegistrationEmailPopup.Subscribe
			})
			CoD.EliteRegistrationEmailPopup.Subscribe:addChoice(Engine.Localize("MPUI_ELITE_YES"), f0_local4, {
				self = newPopup,
				value = 1,
				parentButton = CoD.EliteRegistrationEmailPopup.Subscribe
			})
			CoD.EliteRegistrationEmailPopup.popup:addElement(CoD.EliteRegistrationEmailPopup.popup.li_subscribe)
		end
		if CoD.EliteRegistrationEmailPopup.Subscribe_spacer then
			CoD.EliteRegistrationEmailPopup.Subscribe_spacer:close()
			CoD.EliteRegistrationEmailPopup.Subscribe_spacer = nil
		end
		CoD.EliteRegistrationEmailPopup.Subscribe:setChoice(1)
	else
		if CoD.EliteRegistrationEmailPopup.Subscribe then
			CoD.EliteRegistrationEmailPopup.Subscribe:close()
			CoD.EliteRegistrationEmailPopup.Subscribe = nil
			CoD.EliteRegistrationEmailPopup.popup.li_subscribe:close()
		end
		if CoD.EliteRegistrationEmailPopup.Subscribe_spacer == nil then
			CoD.EliteRegistrationEmailPopup.Subscribe_spacer = CoD.EliteRegistrationEmailPopup.popup.buttonList:addSpacer(CoD.textSize.Default, 12)
		end
		CoD.EliteRegistrationEmailPopup.subscribe_val = 0
	end
end

local f0_local6 = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	if f0_local1(nil, f12_arg3, f12_arg1) then
		f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Password")
		if not f12_arg0 then
			f12_arg1:processEvent({
				name = "gain_focus"
			})
		end
		f12_arg0 = true
	else
		CoD.EliteRegistrationEmailPopup.password_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASSWORD")
	end
	if f12_arg1.starIcon == nil then
		local f12_local0 = Engine.CheckPasswordForEliteAccount(f12_arg2, f12_arg3)
		if f12_local0 == 0 then
			f12_arg1.hintText = Engine.Localize(f12_arg4)
			f12_arg1:showRestrictedIcon(false)
		else
			if f12_local0 == 1 then
				f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_LENGTH_ERROR")
			elseif f12_local0 == 2 then
				f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_EMAIL_ERROR")
			elseif f12_local0 == 3 then
				f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_CHAR_ERROR")
			elseif f12_local0 == 4 then
				f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_LETTERNUMBER_ERROR")
			elseif f12_local0 == 5 then
				f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_REPEAT_ERROR")
			elseif f12_local0 == 6 then
				f12_arg1.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_PASS_SEQUENTIAL_ERROR")
			end
			f12_arg1:showRestrictedIcon(true)
			if not f12_arg0 then
				f12_arg1:processEvent({
					name = "gain_focus"
				})
			end
			f12_arg0 = true
		end
	end
	return f12_arg0
end

local f0_local7 = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4)
	if f0_local1(nil, f13_arg1, f13_arg2) then
		f13_arg2.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "AccountName")
		if not f13_arg0 then
			f13_arg2:processEvent({
				name = "gain_focus"
			})
		end
		f13_arg0 = true
	elseif not Engine.CheckAccountNameForEliteAccount(f13_arg1) then
		f13_arg2.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage(f13_arg3)
		f13_arg2:showRestrictedIcon(true)
		if not f13_arg0 then
			f13_arg2:processEvent({
				name = "gain_focus"
			})
		end
		f13_arg0 = true
	else
		f13_arg2:showRestrictedIcon(false)
		f13_arg2.hintText = Engine.Localize(f13_arg4)
	end
	return f13_arg0
end

local f0_local8 = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
	if f0_local1(nil, f14_arg1, f14_arg2) then
		f14_arg2.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Name")
		if not f14_arg0 then
			f14_arg2:processEvent({
				name = "gain_focus"
			})
		end
		f14_arg0 = true
	elseif not Engine.CheckNameForEliteAccount(f14_arg1) then
		f14_arg2.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage(f14_arg3)
		f14_arg2:showRestrictedIcon(true)
		if not f14_arg0 then
			f14_arg2:processEvent({
				name = "gain_focus"
			})
		end
		f14_arg0 = true
	else
		f14_arg2:showRestrictedIcon(false)
		f14_arg2.hintText = Engine.Localize(f14_arg4)
	end
	return f14_arg0
end

CoD.EliteRegistrationEmailPopup.CheckFields = function (f15_arg0, f15_arg1)
	local f15_local0 = false
	local f15_local1 = false
	if CoD.EliteRegistrationEmailPopup.CanCheckFields then
		f15_local0 = f0_local8(f0_local8(f15_local0, CoD.EliteRegistrationEmailPopup.first_name_text, CoD.EliteRegistrationEmailPopup.first_name_button, "MPUI_HINTTEXT_FIRSTNAME_ERROR", "MPUI_HINTTEXT_FIRSTNAME"), CoD.EliteRegistrationEmailPopup.last_name_text, CoD.EliteRegistrationEmailPopup.last_name_button, "MPUI_HINTTEXT_LASTNAME_ERROR", "MPUI_HINTTEXT_LASTNAME")
		if f0_local1(f15_arg0, CoD.EliteRegistrationEmailPopup.country_val, CoD.EliteRegistrationEmailPopup.Country) then
			CoD.EliteRegistrationEmailPopup.Country.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Country")
			if not f15_local0 then
				CoD.EliteRegistrationEmailPopup.Country:processEvent({
					name = "gain_focus"
				})
			end
			f15_local0 = true
		else
			CoD.EliteRegistrationEmailPopup.Country.hintText = Engine.Localize("MPUI_HINTTEXT_COUNTRY")
		end
		if CoD.EliteRegistrationEmailPopup.country_val == 1 then
			if f0_local1(f15_arg0, CoD.EliteRegistrationEmailPopup.zip_text, CoD.EliteRegistrationEmailPopup.zip_button) then
				CoD.EliteRegistrationEmailPopup.zip_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Email")
				if not f15_local0 then
					CoD.EliteRegistrationEmailPopup.zip_button:processEvent({
						name = "gain_focus"
					})
				end
				f15_local0 = true
			else
				CoD.EliteRegistrationEmailPopup.zip_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_ZIP")
			end
		end
		if f0_local1(f15_arg0, CoD.EliteRegistrationEmailPopup.dob_mm_val, CoD.EliteRegistrationEmailPopup.DOB_MM) then
			CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "DOBM")
			if not f15_local0 then
				CoD.EliteRegistrationEmailPopup.DOB_MM:processEvent({
					name = "gain_focus"
				})
			end
			f15_local0 = true
		else
			CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_MM")
		end
		if f0_local1(f15_arg0, CoD.EliteRegistrationEmailPopup.dob_dd_val, CoD.EliteRegistrationEmailPopup.DOB_DD) then
			CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "DOBD")
			if not f15_local0 then
				CoD.EliteRegistrationEmailPopup.DOB_DD:processEvent({
					name = "gain_focus"
				})
			end
			f15_local0 = true
		else
			CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_DD")
		end
		if f0_local1(f15_arg0, CoD.EliteRegistrationEmailPopup.dob_yyyy_val, CoD.EliteRegistrationEmailPopup.DOB_YYYY) then
			CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "DOBY")
			if not f15_local0 then
				CoD.EliteRegistrationEmailPopup.DOB_YYYY:processEvent({
					name = "gain_focus"
				})
			end
			f15_local0 = true
		else
			CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_YYYY")
		end
		if CoD.EliteRegistrationEmailPopup.DOB_DD.starIcon == nil and CoD.EliteRegistrationEmailPopup.DOB_MM.starIcon == nil and CoD.EliteRegistrationEmailPopup.DOB_YYYY.starIcon == nil then
			if not Engine.IsPlayerEliteRegistrationAgeOK(CoD.EliteRegistrationEmailPopup.country_val, CoD.EliteRegistrationEmailPopup.dob_mm_val, CoD.EliteRegistrationEmailPopup.dob_dd_val, CoD.EliteRegistrationEmailPopup.dob_yyyy_val) then
				CoD.EliteRegistrationEmailPopup.DOB_DD:showRestrictedIcon(true)
				CoD.EliteRegistrationEmailPopup.DOB_MM:showRestrictedIcon(true)
				CoD.EliteRegistrationEmailPopup.DOB_YYYY:showRestrictedIcon(true)
				CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_UNDERAGE_REGISTRATION")
				CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = Engine.Localize("MPUI_UNDERAGE_REGISTRATION")
				CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = Engine.Localize("MPUI_UNDERAGE_REGISTRATION")
				if not f15_local0 then
					CoD.EliteRegistrationEmailPopup.DOB_MM:processEvent({
						name = "gain_focus"
					})
				end
				f15_local0 = true
			else
				CoD.EliteRegistrationEmailPopup.DOB_DD:showRestrictedIcon(false)
				CoD.EliteRegistrationEmailPopup.DOB_MM:showRestrictedIcon(false)
				CoD.EliteRegistrationEmailPopup.DOB_YYYY:showRestrictedIcon(false)
				CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_DD")
				CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_MM")
				CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_YYYY")
			end
		end
		f15_local0 = f0_local7(f15_local0, CoD.EliteRegistrationEmailPopup.account_name_text, CoD.EliteRegistrationEmailPopup.account_name_button, "MPUI_HINTTEXT_UCD_ACCOUNT_NAME_ERROR", "MPUI_HINTTEXT_UCD_ACCOUNT_NAME")
		if f0_local1(f15_arg0, CoD.EliteRegistrationEmailPopup.email_address_text, CoD.EliteRegistrationEmailPopup.email_address_button) then
			CoD.EliteRegistrationEmailPopup.email_address_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Email")
			if not f15_local0 then
				CoD.EliteRegistrationEmailPopup.email_address_button:processEvent({
					name = "gain_focus"
				})
			end
			f15_local0 = true
		else
			CoD.EliteRegistrationEmailPopup.email_address_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_EMAIL")
		end
		f15_local0 = f0_local6(f0_local6(f15_local0, CoD.EliteRegistrationEmailPopup.password_button, CoD.EliteRegistrationEmailPopup.email_address_text, CoD.EliteRegistrationEmailPopup.password_text, "MPUI_HINTTEXT_PASSWORD"), CoD.EliteRegistrationEmailPopup.confirm_password_button, CoD.EliteRegistrationEmailPopup.email_address_text, CoD.EliteRegistrationEmailPopup.confirm_password_text, "MPUI_HINTTEXT_CONFIRMPASSWORD")
		if CoD.EliteRegistrationEmailPopup.password_button.starIcon == nil and CoD.EliteRegistrationEmailPopup.confirm_password_button.starIcon == nil then
			f15_local0 = f0_local0(f15_arg0, f15_local0)
		end
	end
	return f15_local0
end

local f0_local9 = function ()
	if CoD.EliteRegistrationEmailPopup.country_val == 1 then
		if CoD.EliteRegistrationEmailPopup.zip_button == nil then
			CoD.EliteRegistrationEmailPopup.zip_button = CoD.EliteRegistrationEmailPopup.AddButton(CoD.EliteRegistrationEmailPopup.popup, GetDisplayedText(CoD.EliteRegistrationEmailPopup.zip_text), "zip_button_pressed", 4)
			CoD.EliteRegistrationEmailPopup.zip_button.hintText = Engine.Localize("MPUI_HINTTEXT_ZIP")
			CoD.EliteRegistrationEmailPopup.popup:addElement(CoD.EliteRegistrationEmailPopup.popup.pi_zip)
		end
		if CoD.EliteRegistrationEmailPopup.zip_spacer then
			CoD.EliteRegistrationEmailPopup.zip_spacer:close()
			CoD.EliteRegistrationEmailPopup.zip_spacer = nil
		end
		CoD.EliteRegistrationEmailPopup.zip_button:showRestrictedIcon(false)
		CoD.EliteRegistrationEmailPopup.zip_button.hintText = Engine.Localize("MPUI_HINTTEXT_ZIP")
		CoD.EliteRegistrationEmailPopup.zip_button:processEvent({
			name = "enable"
		})
	else
		CoD.EliteRegistrationEmailPopup.zip_text = ""
		if CoD.EliteRegistrationEmailPopup.zip_button then
			CoD.EliteRegistrationEmailPopup.zip_button:close()
			CoD.EliteRegistrationEmailPopup.zip_button = nil
			CoD.EliteRegistrationEmailPopup.popup.pi_zip:close()
		end
		if CoD.EliteRegistrationEmailPopup.zip_spacer == nil then
			CoD.EliteRegistrationEmailPopup.zip_spacer = CoD.EliteRegistrationEmailPopup.popup.buttonList:addSpacer(CoD.CoD9Button.Height, 4)
		end
	end
end

local f0_local10 = function (f17_arg0)
	CoD.EliteRegistrationEmailPopup.country_val = f17_arg0.value
	if CoD.EliteRegistrationEmailPopup.CanCheckFields then
		if f0_local1(f17_arg0.self, f17_arg0.value, CoD.EliteRegistrationEmailPopup.Country) then
			CoD.EliteRegistrationEmailPopup.Country.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Country")
		else
			CoD.EliteRegistrationEmailPopup.Country.hintText = Engine.Localize("MPUI_HINTTEXT_COUNTRY")
		end
		CoD.EliteRegistrationEmailPopup.Country:processEvent({
			name = "gain_focus"
		})
		f0_local9()
		f0_local5(nil)
	end
end

local f0_local11 = function (f18_arg0)
	CoD.EliteRegistrationEmailPopup.dob_mm_val = f18_arg0.value
	if CoD.EliteRegistrationEmailPopup.CanCheckFields then
		if f0_local1(f18_arg0.self, f18_arg0.value, CoD.EliteRegistrationEmailPopup.DOB_MM) then
			CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "DOBM")
		else
			CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = Engine.Localize("MPUI_HINTTEXT_MM")
			f0_local3()
		end
		CoD.EliteRegistrationEmailPopup.DOB_MM:processEvent({
			name = "gain_focus"
		})
		f0_local5(nil)
	end
end

local f0_local12 = function (f19_arg0)
	CoD.EliteRegistrationEmailPopup.dob_dd_val = f19_arg0.value
	if CoD.EliteRegistrationEmailPopup.CanCheckFields then
		if f0_local1(f19_arg0.self, f19_arg0.value, CoD.EliteRegistrationEmailPopup.DOB_DD) then
			CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "DOBD")
		else
			CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = Engine.Localize("MPUI_HINTTEXT_DD")
			f0_local3()
		end
		CoD.EliteRegistrationEmailPopup.DOB_DD:processEvent({
			name = "gain_focus"
		})
		f0_local5(nil)
	end
end

local f0_local13 = function (f20_arg0)
	CoD.EliteRegistrationEmailPopup.dob_yyyy_val = f20_arg0.value
	if CoD.EliteRegistrationEmailPopup.CanCheckFields then
		if f0_local1(f20_arg0.self, f20_arg0.value, CoD.EliteRegistrationEmailPopup.DOB_YYYY) then
			CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "DOBY")
		else
			CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = Engine.Localize("MPUI_HINTTEXT_YYYY")
			f0_local3()
		end
		CoD.EliteRegistrationEmailPopup.DOB_YYYY:processEvent({
			name = "gain_focus"
		})
		f0_local5(nil)
	end
end

function KeyboardExec(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4, f21_arg5)
	local f21_local0 = nil
	if f21_arg2 ~= "" and f21_arg2 ~= nil then
		f21_local0 = f21_arg2
	else
		f21_local0 = "n/a"
	end
	Engine.Exec(f21_arg0, "ui_keyboard_new " .. f21_arg4 .. " " .. f21_arg1 .. " " .. f21_local0 .. " " .. f21_arg3 .. " " .. f21_arg5)
end

CoD.EliteRegistrationEmailPopup.AddButton = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3)
	local f22_local0 = f22_arg0.buttonList:addButton(f22_arg1, "", f22_arg3)
	f22_local0:setActionEventName(f22_arg2)
	return f22_local0
end

CoD.EliteRegistrationEmailPopup.AddNonRegistrationButton = function (f23_arg0, f23_arg1, f23_arg2, f23_arg3)
	local f23_local0 = CoD.ButtonList.AddButton(f23_arg0.buttonList, f23_arg1, "", f23_arg3)
	f23_local0:setActionEventName(f23_arg2)
	return f23_local0
end

CoD.EliteRegistrationEmailPopup.first_name_button_pressed = function (f24_arg0, f24_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 1
	KeyboardExec(f24_arg1.controller, "MPUI_ENTER_FIRST_NAME", CoD.EliteRegistrationEmailPopup.first_name_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_ACCENTS, 0)
end

CoD.EliteRegistrationEmailPopup.last_name_button_pressed = function (f25_arg0, f25_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 2
	KeyboardExec(f25_arg1.controller, "MPUI_ENTER_LAST_NAME", CoD.EliteRegistrationEmailPopup.last_name_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_ACCENTS, 0)
end

CoD.EliteRegistrationEmailPopup.zip_button_pressed = function (f26_arg0, f26_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 3
	KeyboardExec(f26_arg1.controller, "MPUI_ENTER_ZIP_CODE", CoD.EliteRegistrationEmailPopup.zip_text, 6, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_NUMERIC, 0)
end

CoD.EliteRegistrationEmailPopup.account_name_button_pressed = function (f27_arg0, f27_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 0
	KeyboardExec(f27_arg1.controller, "MPUI_ENTER_UCD_ACCOUNT_NAME", CoD.EliteRegistrationEmailPopup.account_name_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_ACCOUNTNAME, 0)
end

CoD.EliteRegistrationEmailPopup.email_address_button_pressed = function (f28_arg0, f28_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 4
	if CoD.EliteRegistrationEmailPopup.email_address_text ~= "" then
		Engine.SetDvar("ui_email_address", CoD.EliteRegistrationEmailPopup.email_address_text)
	else
		Engine.SetDvar("ui_email_address", "")
	end
	Engine.Exec(f28_arg1.controller, "ui_keyboard_emailentry")
end

CoD.EliteRegistrationEmailPopup.password_button_pressed = function (f29_arg0, f29_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 5
	KeyboardExec(f29_arg1.controller, "MPUI_ENTER_PASSWORD", CoD.EliteRegistrationEmailPopup.password_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_PASSWORD, 1)
end

CoD.EliteRegistrationEmailPopup.confirm_password_button_pressed = function (f30_arg0, f30_arg1)
	CoD.EliteRegistrationEmailPopup.processing_type = 6
	KeyboardExec(f30_arg1.controller, "MPUI_CONFIRM_PASSWORD", CoD.EliteRegistrationEmailPopup.confirm_password_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_PASSWORD, 1)
end

CoD.EliteRegistrationEmailPopup.ObtainedKeyboardInput = function (f31_arg0, f31_arg1)
	local f31_local0 = f31_arg0.m_ownerController
	local f31_local1 = ""
	if f31_arg1.input ~= nil then
		if CoD.EliteRegistrationEmailPopup.processing_type == 0 then
			CoD.EliteRegistrationEmailPopup.account_name_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.account_name_button:setLabel(GetDisplayedText(f31_arg1.input))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.account_name_button) then
				CoD.EliteRegistrationEmailPopup.account_name_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "AccountName")
			else
				CoD.EliteRegistrationEmailPopup.account_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_UCD_ACCOUNT_NAME")
			end
			CoD.EliteRegistrationEmailPopup.account_name_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationEmailPopup.processing_type == 1 then
			CoD.EliteRegistrationEmailPopup.first_name_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.first_name_button:setLabel(GetDisplayedText(f31_arg1.input))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.first_name_button) then
				CoD.EliteRegistrationEmailPopup.first_name_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "FirstName")
			else
				CoD.EliteRegistrationEmailPopup.first_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_FIRSTNAME")
			end
			CoD.EliteRegistrationEmailPopup.first_name_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationEmailPopup.processing_type == 2 then
			CoD.EliteRegistrationEmailPopup.last_name_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.last_name_button:setLabel(GetDisplayedText(f31_arg1.input))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.last_name_button) then
				CoD.EliteRegistrationEmailPopup.last_name_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "LastName")
			else
				CoD.EliteRegistrationEmailPopup.last_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_LASTNAME")
			end
			CoD.EliteRegistrationEmailPopup.last_name_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationEmailPopup.processing_type == 3 then
			CoD.EliteRegistrationEmailPopup.zip_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.zip_button:setLabel(GetDisplayedText(f31_arg1.input))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.zip_button) then
				CoD.EliteRegistrationEmailPopup.zip_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "ZIP")
			else
				CoD.EliteRegistrationEmailPopup.zip_button.hintText = Engine.Localize("MPUI_HINTTEXT_ZIP")
			end
			CoD.EliteRegistrationEmailPopup.zip_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationEmailPopup.processing_type == 4 then
			CoD.EliteRegistrationEmailPopup.email_address_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.email_address_button:setLabel(GetDisplayedText(f31_arg1.input))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.email_address_button) then
				CoD.EliteRegistrationEmailPopup.email_address_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Email")
			else
				CoD.EliteRegistrationEmailPopup.email_address_button.hintText = Engine.Localize("MPUI_HINTTEXT_EMAIL")
			end
			CoD.EliteRegistrationEmailPopup.email_address_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationEmailPopup.processing_type == 5 then
			CoD.EliteRegistrationEmailPopup.password_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.password_button:setLabel(GetDisplayedPassword(CoD.EliteRegistrationEmailPopup.password_text))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.password_button) then
				CoD.EliteRegistrationEmailPopup.password_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "Password")
			else
				CoD.EliteRegistrationEmailPopup.password_button.hintText = Engine.Localize("MPUI_HINTTEXT_PASSWORD")
			end
			CoD.EliteRegistrationEmailPopup.password_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationEmailPopup.processing_type == 6 then
			CoD.EliteRegistrationEmailPopup.confirm_password_text = f31_arg1.input
			CoD.EliteRegistrationEmailPopup.confirm_password_button:setLabel(GetDisplayedPassword(CoD.EliteRegistrationEmailPopup.confirm_password_text))
			if f0_local1(f31_arg0, f31_arg1.input, CoD.EliteRegistrationEmailPopup.confirm_password_button) then
				CoD.EliteRegistrationEmailPopup.confirm_password_button.hintText = CoD.EliteRegistrationEmailPopup.SetErrorMessage("MPUI_HINTTEXT_NODATA_ERROR", "ConfirmPassword")
			else
				CoD.EliteRegistrationEmailPopup.confirm_password_button.hintText = Engine.Localize("MPUI_HINTTEXT_CONFIRMPASSWORD")
			end
			CoD.EliteRegistrationEmailPopup.confirm_password_button:processEvent({
				name = "gain_focus"
			})
		end
	end
end

CoD.EliteRegistrationEmailPopup.OpenPopup_Error = function (f32_arg0, f32_arg1)
	local f32_local0 = f32_arg0:openPopup("EliteRegistrationEmailErrorPopup", f32_arg1.controller, {
		ageError = f32_arg1.ageError
	})
end

CoD.EliteRegistrationEmailPopup.submit_pressed = function (f33_arg0, f33_arg1)
	local f33_local0 = nil
	if not CoD.EliteRegistrationEmailPopup.CheckFields(f33_arg0, f33_arg1) then
		playerData = {
			firstName = CoD.EliteRegistrationEmailPopup.first_name_text,
			lastName = CoD.EliteRegistrationEmailPopup.last_name_text,
			country = CoD.EliteRegistrationEmailPopup.country_val,
			zip = CoD.EliteRegistrationEmailPopup.zip_text,
			dob_mm = CoD.EliteRegistrationEmailPopup.dob_mm_val,
			dob_dd = CoD.EliteRegistrationEmailPopup.dob_dd_val,
			dob_yyyy = CoD.EliteRegistrationEmailPopup.dob_yyyy_val,
			accountName = CoD.EliteRegistrationEmailPopup.account_name_text,
			email = CoD.EliteRegistrationEmailPopup.email_address_text,
			password = CoD.EliteRegistrationEmailPopup.password_text,
			marketingOptIn = CoD.EliteRegistrationEmailPopup.subscribe_val
		}
		local f33_local1 = f33_arg0:openPopup("EliteRegistrationSuccessEmailConfirmationPopup", f33_arg1.controller, {
			playerData = playerData,
			UCDAccountUpdate = CoD.EliteRegistrationEmailPopup.UCDAccountUpdate,
			buttonSubmit = CoD.EliteRegistrationEmailPopup.buttonSubmit
		})
	else
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	end
end

CoD.EliteRegistrationEmailPopup.check_email_address_popup_closed = function (f34_arg0, f34_arg1)
	local f34_local0 = f34_arg0:openPopup("EliteRegistrationScrollingTOS", f34_arg1.controller)
end

CoD.EliteRegistrationEmailPopup.obtained_UCD_create_or_update_account_results = function (f35_arg0, f35_arg1)
	if f35_arg1.success ~= nil then
		local f35_local0 = f35_arg0:openPopup("EliteRegistrationSuccessPopup", f35_arg1.controller, {
			success = true
		})
		return 
	elseif f35_arg1.alreadyRegistered ~= nil then
		CoD.EliteRegistrationEmailPopup.account_name_button.hintText = Engine.Localize("MPUI_UCD_ERROR_ALREADYREGISTERED")
		CoD.EliteRegistrationEmailPopup.account_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.email_address_button.hintText = Engine.Localize("MPUI_UCD_ERROR_ALREADYREGISTERED")
		CoD.EliteRegistrationEmailPopup.email_address_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.account_name_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.invalid ~= nil then
		CoD.EliteRegistrationEmailPopup.first_name_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.first_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.last_name_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.last_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.Country.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.Country:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.zip_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.zip_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.DOB_MM:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.DOB_DD:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.DOB_YYYY:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.account_name_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.account_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.email_address_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.email_address_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.password_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.password_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.confirm_password_button.hintText = Engine.Localize("MPUI_UCD_ERROR_INVALID")
		CoD.EliteRegistrationEmailPopup.confirm_password_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.first_name_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.firstName ~= nil then
		CoD.EliteRegistrationEmailPopup.first_name_button.hintText = Engine.Localize("MPUI_UCD_ERROR_FIRSTNAME")
		CoD.EliteRegistrationEmailPopup.first_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.first_name_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.lastName ~= nil then
		CoD.EliteRegistrationEmailPopup.last_name_button.hintText = Engine.Localize("MPUI_UCD_ERROR_LASTNAME")
		CoD.EliteRegistrationEmailPopup.last_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.last_name_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.dob ~= nil then
		CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = Engine.Localize("MPUI_UCD_ERROR_DOB")
		CoD.EliteRegistrationEmailPopup.DOB_MM:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = Engine.Localize("MPUI_UCD_ERROR_DOB")
		CoD.EliteRegistrationEmailPopup.DOB_DD:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = Engine.Localize("MPUI_UCD_ERROR_DOB")
		CoD.EliteRegistrationEmailPopup.DOB_YYYY:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.DOB_MM:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.email ~= nil then
		CoD.EliteRegistrationEmailPopup.email_address_button.hintText = Engine.Localize("MPUI_UCD_ERROR_EMAIL")
		CoD.EliteRegistrationEmailPopup.email_address_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.email_address_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.country ~= nil then
		CoD.EliteRegistrationEmailPopup.Country.hintText = Engine.Localize("MPUI_UCD_ERROR_COUNTRY")
		CoD.EliteRegistrationEmailPopup.Country:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.Country:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	elseif f35_arg1.zip ~= nil then
		CoD.EliteRegistrationEmailPopup.zip_button.hintText = Engine.Localize("MPUI_UCD_ERROR_ZIP")
		CoD.EliteRegistrationEmailPopup.zip_button:showRestrictedIcon(true)
		CoD.EliteRegistrationEmailPopup.zip_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "lose_focus"
		})
	else
		local f35_local0 = f35_arg0:openPopup("EliteRegistrationSuccessPopup", f35_arg1.controller, {
			fail = true
		})
	end
end

CoD.EliteRegistrationEmailPopup.SetErrorMessage = function (f36_arg0, f36_arg1)
	local f36_local0 = Engine.Localize(f36_arg0)
	if f36_arg1 then
		f36_arg0 = f36_arg0 .. f36_arg1
	end
	Engine.AddToErrorString(f36_arg0 .. ",")
	return f36_local0
end

CoD.EliteRegistrationEmailPopup.SendRecordEvent = function (f37_arg0, f37_arg1)
	local f37_local0 = Engine.GetErrorString()
	if f37_local0 and f37_arg1.controller and UIExpression.DvarBool(nil, "enableERegErrorRecording") ~= 0 then
		Engine.SendRecordEvent(f37_arg1.controller, CoD.RECORD_EVENT_DW_EREG_ENTRY_ERROR, f37_local0)
	end
	Engine.ClearErrorString()
end

CoD.EliteRegistrationEmailPopup.Back = function (f38_arg0, f38_arg1)
	Engine.AddToErrorString("Back,")
	CoD.EliteRegistrationEmailPopup.SendRecordEvent(f38_arg0, f38_arg1)
	f38_arg0:goBack()
end

CoD.EliteRegistrationEmailPopup.registration_success_popup_closed = function (f39_arg0, f39_arg1)
	Engine.AddToErrorString("Success,")
	CoD.EliteRegistrationEmailPopup.Back(f39_arg0, f39_arg1)
	f39_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f39_arg1.controller
	})
end

LUI.createMenu.EliteRegistrationEmailPopup = function (f40_arg0, f40_arg1)
	CoD.EliteRegistrationEmailPopup.CanCheckFields = false
	Engine.ClearErrorString()
	local f40_local0 = Engine.GetPlayerExeGamerProfile(f40_arg0)
	Engine.AddToErrorString(f40_local0.eliteRegistrationPopupTimesShown:get() .. ",")
	local f40_local1 = 0
	local f40_local2 = 20
	local f40_local3 = -650
	local f40_local4 = 10
	local f40_local5 = CoD.CoD9Button.Height + 10
	local f40_local6 = CoD.Menu.New("EliteRegistrationEmailPopup")
	f40_local6:setOwner(f40_arg0)
	f40_local6:addTitle(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_TITLE"))
	CoD.EliteRegistrationEmailPopup.popup = f40_local6
	f40_local6:addLargePopupBackground()
	f40_local6:addSelectButton()
	f40_local6:addBackButton()
	CoD.EliteRegistrationEmailPopup.account_name_text = ""
	CoD.EliteRegistrationEmailPopup.first_name_text = ""
	CoD.EliteRegistrationEmailPopup.last_name_text = ""
	CoD.EliteRegistrationEmailPopup.zip_text = ""
	CoD.EliteRegistrationEmailPopup.email_address_text = ""
	CoD.EliteRegistrationEmailPopup.password_text = ""
	CoD.EliteRegistrationEmailPopup.confirm_password_text = ""
	CoD.EliteRegistrationEmailPopup.country_val = 0
	CoD.EliteRegistrationEmailPopup.dob_mm_val = 0
	CoD.EliteRegistrationEmailPopup.dob_dd_val = 0
	CoD.EliteRegistrationEmailPopup.dob_yyyy_val = 0
	CoD.EliteRegistrationEmailPopup.subscribe_val = 0
	if CoD.EliteRegistrationEmailPopup.zip_button then
		CoD.EliteRegistrationEmailPopup.zip_button:close()
		CoD.EliteRegistrationEmailPopup.zip_button = nil
	end
	if CoD.EliteRegistrationEmailPopup.zip_spacer then
		CoD.EliteRegistrationEmailPopup.zip_spacer:close()
		CoD.EliteRegistrationEmailPopup.zip_spacer = nil
	end
	if CoD.EliteRegistrationEmailPopup.Subscribe then
		CoD.EliteRegistrationEmailPopup.Subscribe:close()
		CoD.EliteRegistrationEmailPopup.Subscribe = nil
	end
	if CoD.EliteRegistrationEmailPopup.Subscribe_spacer then
		CoD.EliteRegistrationEmailPopup.Subscribe_spacer:close()
		CoD.EliteRegistrationEmailPopup.Subscribe_spacer = nil
	end
	local f40_local7 = Engine.ProcessingAutoFill(f40_arg0)
	if f40_local7 ~= nil then
		for f40_local11, f40_local12 in pairs(f40_local7) do
			if f40_local12.firstName ~= nil then
				CoD.EliteRegistrationEmailPopup.first_name_text = f40_local12.firstName
				CoD.EliteRegistrationEmailPopup.first_name_text = string.gsub(CoD.EliteRegistrationEmailPopup.first_name_text, " ", "_")
			end
			if f40_local12.lastName ~= nil then
				CoD.EliteRegistrationEmailPopup.last_name_text = f40_local12.lastName
				CoD.EliteRegistrationEmailPopup.last_name_text = string.gsub(CoD.EliteRegistrationEmailPopup.last_name_text, " ", "_")
			end
			if f40_local12.postalCode ~= nil then
				CoD.EliteRegistrationEmailPopup.zip_text = f40_local12.postalCode
			end
			if f40_local12.month ~= nil then
				CoD.EliteRegistrationEmailPopup.dob_mm_val = f40_local12.month
			end
			if f40_local12.day ~= nil then
				CoD.EliteRegistrationEmailPopup.dob_dd_val = f40_local12.day
			end
			if f40_local12.year ~= nil then
				CoD.EliteRegistrationEmailPopup.dob_yyyy_val = f40_local12.year
			end
			if f40_local12.emailAddress ~= nil then
				CoD.EliteRegistrationEmailPopup.email_address_text = f40_local12.emailAddress
			end
			if f40_local12.countryID ~= nil then
				CoD.EliteRegistrationEmailPopup.country_val = f40_local12.countryID
			end
			if f40_local12.accountName ~= nil then
				CoD.EliteRegistrationEmailPopup.account_name_text = f40_local12.accountName
			end
		end
	end
	CoD.EliteRegistrationEmailPopup.UCDAccountUpdate = false
	if f40_arg1 ~= nil then
		CoD.EliteRegistrationEmailPopup.password_text = f40_arg1
		CoD.EliteRegistrationEmailPopup.confirm_password_text = f40_arg1
		CoD.EliteRegistrationEmailPopup.UCDAccountUpdate = true
	end
	f40_local6:registerEventHandler("ui_keyboard_input", CoD.EliteRegistrationEmailPopup.ObtainedKeyboardInput)
	f40_local6:registerEventHandler("account_name_button_pressed", CoD.EliteRegistrationEmailPopup.account_name_button_pressed)
	f40_local6:registerEventHandler("first_name_button_pressed", CoD.EliteRegistrationEmailPopup.first_name_button_pressed)
	f40_local6:registerEventHandler("last_name_button_pressed", CoD.EliteRegistrationEmailPopup.last_name_button_pressed)
	f40_local6:registerEventHandler("zip_button_pressed", CoD.EliteRegistrationEmailPopup.zip_button_pressed)
	f40_local6:registerEventHandler("email_address_button_pressed", CoD.EliteRegistrationEmailPopup.email_address_button_pressed)
	f40_local6:registerEventHandler("password_button_pressed", CoD.EliteRegistrationEmailPopup.password_button_pressed)
	f40_local6:registerEventHandler("confirm_password_button_pressed", CoD.EliteRegistrationEmailPopup.confirm_password_button_pressed)
	f40_local6:registerEventHandler("submit_pressed", CoD.EliteRegistrationEmailPopup.submit_pressed)
	f40_local6:registerEventHandler("check_email_address_popup_closed", CoD.EliteRegistrationEmailPopup.check_email_address_popup_closed)
	f40_local6:registerEventHandler("obtained_UCD_create_or_update_account_results", CoD.EliteRegistrationEmailPopup.obtained_UCD_create_or_update_account_results)
	f40_local6:registerEventHandler("registration_success_popup_closed", CoD.EliteRegistrationEmailPopup.registration_success_popup_closed)
	f40_local6:registerEventHandler("button_prompt_back", CoD.EliteRegistrationEmailPopup.Back)
	f40_local6:registerEventHandler("signed_out", CoD.EliteRegistrationEmailPopup.SignedOut)
	f40_local6.hintText = CoD.HintText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 530,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 73,
		bottom = CoD.HintText.Height
	})
	f40_local6.hintText.hintArrow:setTopBottom(true, false, 0, CoD.HintText.Height)
	f40_local6.hintText.hint:setLeftRight(true, true, CoD.HintText.Height - 13, 0)
	f40_local6:addElement(f40_local6.hintText)
	local f40_local10 = 200
	f40_local6.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f40_local10,
		right = f40_local10 + CoD.EliteRegistrationEmailPopup.GlobalButtonWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = f40_local2 + f40_local4 + f40_local5,
		bottom = 0
	}, 10, nil, f40_local6.hintText)
	f40_local6.buttonList.addButton = CoD.ButtonList.AddRegistrationButton
	f40_local6:addElement(f40_local6.buttonList)
	CoD.EliteRegistrationEmailPopup.first_name_button = CoD.EliteRegistrationEmailPopup.AddButton(f40_local6, GetDisplayedText(CoD.EliteRegistrationEmailPopup.first_name_text), "first_name_button_pressed", 1)
	CoD.EliteRegistrationEmailPopup.first_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_FIRSTNAME")
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.first_name_button:processEvent({
			name = "disable"
		})
	end
	CoD.EliteRegistrationEmailPopup.last_name_button = CoD.EliteRegistrationEmailPopup.AddButton(f40_local6, GetDisplayedText(CoD.EliteRegistrationEmailPopup.last_name_text), "last_name_button_pressed", 2)
	CoD.EliteRegistrationEmailPopup.last_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_LASTNAME")
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.last_name_button:processEvent({
			name = "disable"
		})
	end
	CoD.EliteRegistrationEmailPopup.Country = f40_local6.buttonList:addLeftRightSelector("", CoD.EliteRegistrationEmailPopup.country_val, -9, nil, 3, "Default")
	CoD.EliteRegistrationEmailPopup.Country.hintText = Engine.Localize("MPUI_HINTTEXT_COUNTRY")
	CoD.EliteRegistrationEmailPopup.Country.nameTable = Engine.GetCountryNames()
	CoD.EliteRegistrationEmailPopup.Country:addChoice("---", f0_local10, {
		self = f40_local6,
		value = 0,
		controller = f40_arg0,
		parentButton = CoD.EliteRegistrationEmailPopup.Country
	})
	for f40_local14, f40_local15 in pairs(CoD.EliteRegistrationEmailPopup.Country.nameTable) do
		if f40_local15.name ~= nil then
			CoD.EliteRegistrationEmailPopup.Country:addChoice(Engine.Localize(f40_local15.name), f0_local10, {
				self = f40_local6,
				value = f40_local14,
				controller = f40_arg0,
				parentButton = CoD.EliteRegistrationEmailPopup.Country
			})
		end
	end
	CoD.EliteRegistrationEmailPopup.zip_spacer = CoD.EliteRegistrationEmailPopup.popup.buttonList:addSpacer(CoD.CoD9Button.Height, 4)
	CoD.EliteRegistrationEmailPopup.DOB_MM = f40_local6.buttonList:addLeftRightSelector("", CoD.EliteRegistrationEmailPopup.dob_mm_val, -9, nil, 5, "Default")
	CoD.EliteRegistrationEmailPopup.DOB_MM.hintText = Engine.Localize("MPUI_HINTTEXT_MM")
	CoD.EliteRegistrationEmailPopup.DOB_MM:addChoice(Engine.Localize("MPUI_ELITE_MONTH"), f0_local11, {
		self = f40_local6,
		value = 0,
		controller = f40_arg0,
		parentButton = CoD.EliteRegistrationEmailPopup.DOB_MM
	})
	for f40_local11 = 1, 12, 1 do
		CoD.EliteRegistrationEmailPopup.DOB_MM:addChoice(f40_local11, f0_local11, {
			self = f40_local6,
			value = f40_local11,
			controller = f40_arg0,
			parentButton = CoD.EliteRegistrationEmailPopup.DOB_MM
		})
	end
	CoD.EliteRegistrationEmailPopup.DOB_DD = f40_local6.buttonList:addLeftRightSelector("", CoD.EliteRegistrationEmailPopup.dob_dd_val, -9, nil, 6, "Default")
	CoD.EliteRegistrationEmailPopup.DOB_DD.hintText = Engine.Localize("MPUI_HINTTEXT_DD")
	CoD.EliteRegistrationEmailPopup.DOB_DD:addChoice(Engine.Localize("MPUI_ELITE_DAY"), f0_local12, {
		self = f40_local6,
		value = 0,
		controller = f40_arg0,
		parentButton = CoD.EliteRegistrationEmailPopup.DOB_DD
	})
	for f40_local11 = 1, 31, 1 do
		CoD.EliteRegistrationEmailPopup.DOB_DD:addChoice(f40_local11, f0_local12, {
			self = f40_local6,
			value = f40_local11,
			controller = f40_arg0,
			parentButton = CoD.EliteRegistrationEmailPopup.DOB_DD
		})
	end
	CoD.EliteRegistrationEmailPopup.DOB_YYYY = f40_local6.buttonList:addLeftRightSelector("", CoD.EliteRegistrationEmailPopup.dob_yyyy_val, -9, nil, 7, "Default")
	CoD.EliteRegistrationEmailPopup.DOB_YYYY.hintText = Engine.Localize("MPUI_HINTTEXT_YYYY")
	CoD.EliteRegistrationEmailPopup.DOB_YYYY:addChoice(Engine.Localize("MPUI_ELITE_YEAR"), f0_local13, {
		self = f40_local6,
		value = 0,
		controller = f40_arg0,
		parentButton = CoD.EliteRegistrationEmailPopup.DOB_YYYY
	})
	for f40_local11 = 1900, Engine.GetCurrentYearForElite(), 1 do
		CoD.EliteRegistrationEmailPopup.DOB_YYYY:addChoice(f40_local11, f0_local13, {
			self = f40_local6,
			value = f40_local11,
			controller = f40_arg0,
			parentButton = CoD.EliteRegistrationEmailPopup.DOB_YYYY
		})
	end
	CoD.EliteRegistrationEmailPopup.account_name_button = CoD.EliteRegistrationEmailPopup.AddButton(f40_local6, GetDisplayedText(CoD.EliteRegistrationEmailPopup.account_name_text), "account_name_button_pressed", 8)
	CoD.EliteRegistrationEmailPopup.account_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_UCD_ACCOUNT_NAME")
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.account_name_button:processEvent({
			name = "disable"
		})
	end
	CoD.EliteRegistrationEmailPopup.email_address_button = CoD.EliteRegistrationEmailPopup.AddButton(f40_local6, GetDisplayedText(CoD.EliteRegistrationEmailPopup.email_address_text), "email_address_button_pressed", 9)
	CoD.EliteRegistrationEmailPopup.email_address_button.hintText = Engine.Localize("MPUI_HINTTEXT_EMAIL")
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.email_address_button:processEvent({
			name = "disable"
		})
	end
	CoD.EliteRegistrationEmailPopup.password_button = CoD.EliteRegistrationEmailPopup.AddButton(f40_local6, GetDisplayedPassword(CoD.EliteRegistrationEmailPopup.password_text), "password_button_pressed", 10)
	CoD.EliteRegistrationEmailPopup.password_button.hintText = Engine.Localize("MPUI_HINTTEXT_PASSWORD")
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.password_button:processEvent({
			name = "disable"
		})
	end
	CoD.EliteRegistrationEmailPopup.confirm_password_button = CoD.EliteRegistrationEmailPopup.AddButton(f40_local6, GetDisplayedPassword(CoD.EliteRegistrationEmailPopup.confirm_password_text), "confirm_password_button_pressed", 11)
	CoD.EliteRegistrationEmailPopup.confirm_password_button.hintText = Engine.Localize("MPUI_HINTTEXT_CONFIRMPASSWORD")
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.confirm_password_button:processEvent({
			name = "disable"
		})
	end
	CoD.EliteRegistrationEmailPopup.Subscribe_spacer = CoD.EliteRegistrationEmailPopup.popup.buttonList:addSpacer(CoD.textSize.Default, 12)
	CoD.EliteRegistrationEmailPopup.buttonSubmit = CoD.EliteRegistrationEmailPopup.AddNonRegistrationButton(f40_local6, Engine.Localize("MPUI_CONFIRM_INFO"), "submit_pressed", 13)
	if CoD.EliteRegistrationEmailPopup.UCDAccountUpdate then
		CoD.EliteRegistrationEmailPopup.buttonSubmit:processEvent({
			name = "gain_focus"
		})
	else
		CoD.EliteRegistrationEmailPopup.first_name_button:processEvent({
			name = "gain_focus"
		})
	end
	f40_local11 = 0
	f40_local12 = 0.4
	f40_local13 = LUI.Alignment.Left
	f40_local14 = CoD.CoD9Button.Height - CoD.textSize.Default
	f40_local4 = f40_local4 + f40_local5
	f40_local6.pi_firstname = LUI.UIText.new()
	f40_local6.pi_firstname:setLeftRight(true, true, 0, f40_local11)
	f40_local6.pi_firstname:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.pi_firstname:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.pi_firstname:setAlignment(f40_local13)
	f40_local6.pi_firstname:setFont(CoD.fonts.Default)
	f40_local6.pi_firstname:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_FIRST_NAME"))
	f40_local6.pi_firstname:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.pi_firstname)
	f40_local4 = f40_local4 + f40_local5
	f40_local6.pi_lastname = LUI.UIText.new()
	f40_local6.pi_lastname:setLeftRight(true, true, 0, f40_local11)
	f40_local6.pi_lastname:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.pi_lastname:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.pi_lastname:setAlignment(f40_local13)
	f40_local6.pi_lastname:setFont(CoD.fonts.Default)
	f40_local6.pi_lastname:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_LAST_NAME"))
	f40_local6.pi_lastname:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.pi_lastname)
	f40_local4 = f40_local4 + f40_local5
	f40_local6.pi_country = LUI.UIText.new()
	f40_local6.pi_country:setLeftRight(true, true, 0, f40_local11)
	f40_local6.pi_country:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.pi_country:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.pi_country:setAlignment(f40_local13)
	f40_local6.pi_country:setFont(CoD.fonts.Default)
	f40_local6.pi_country:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_COUNTRY"))
	f40_local6.pi_country:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.pi_country)
	f40_local4 = f40_local4 - f40_local14 + f40_local5
	f40_local6.pi_zip = LUI.UIText.new()
	f40_local6.pi_zip:setLeftRight(true, true, 0, f40_local11)
	f40_local6.pi_zip:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.pi_zip:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.pi_zip:setAlignment(f40_local13)
	f40_local6.pi_zip:setFont(CoD.fonts.Default)
	f40_local6.pi_zip:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_ZIPCODE"))
	f40_local6.pi_zip:setAlpha(f40_local12)
	f0_local9()
	f40_local4 = f40_local4 + f40_local5
	f40_local6.pi_dob = LUI.UIText.new()
	f40_local6.pi_dob:setLeftRight(true, true, 0, f40_local11)
	f40_local6.pi_dob:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.pi_dob:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.pi_dob:setAlignment(f40_local13)
	f40_local6.pi_dob:setFont(CoD.fonts.Default)
	f40_local6.pi_dob:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_DOB"))
	f40_local6.pi_dob:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.pi_dob)
	f40_local4 = f40_local4 - f40_local14 + f40_local5 * 2 - f40_local14 * 2 + f40_local5
	f40_local6.li_account = LUI.UIText.new()
	f40_local6.li_account:setLeftRight(true, true, 0, f40_local11)
	f40_local6.li_account:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.li_account:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.li_account:setAlignment(f40_local13)
	f40_local6.li_account:setFont(CoD.fonts.Default)
	f40_local6.li_account:setText(Engine.Localize("MPUI_REGISTRATION_UCD_ACCOUNT_NAME"))
	f40_local6.li_account:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.li_account)
	f40_local4 = f40_local4 + f40_local5
	f40_local6.li_email = LUI.UIText.new()
	f40_local6.li_email:setLeftRight(true, true, 0, f40_local11)
	f40_local6.li_email:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.li_email:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.li_email:setAlignment(f40_local13)
	f40_local6.li_email:setFont(CoD.fonts.Default)
	f40_local6.li_email:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_EMAIL_ADDRESS"))
	f40_local6.li_email:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.li_email)
	f40_local4 = f40_local4 + f40_local5
	f40_local6.li_password = LUI.UIText.new()
	f40_local6.li_password:setLeftRight(true, true, 0, f40_local11)
	f40_local6.li_password:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.li_password:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.li_password:setAlignment(f40_local13)
	f40_local6.li_password:setFont(CoD.fonts.Default)
	f40_local6.li_password:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_PASSWORD"))
	f40_local6.li_password:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.li_password)
	f40_local4 = f40_local4 + f40_local5
	f40_local6.li_confirm_password = LUI.UIText.new()
	f40_local6.li_confirm_password:setLeftRight(true, true, 0, f40_local11)
	f40_local6.li_confirm_password:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.li_confirm_password:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.li_confirm_password:setAlignment(f40_local13)
	f40_local6.li_confirm_password:setFont(CoD.fonts.Default)
	f40_local6.li_confirm_password:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_CONFIRM_PASSWORD"))
	f40_local6.li_confirm_password:setAlpha(f40_local12)
	f40_local6:addElement(f40_local6.li_confirm_password)
	f40_local4 = f40_local4 + f40_local5
	f40_local6.li_subscribe = LUI.UIText.new()
	f40_local6.li_subscribe:setLeftRight(true, true, 0, f40_local11)
	f40_local6.li_subscribe:setTopBottom(true, false, f40_local2 + f40_local4, f40_local2 + f40_local4 + CoD.textSize.Default)
	f40_local6.li_subscribe:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.li_subscribe:setAlignment(f40_local13)
	f40_local6.li_subscribe:setFont(CoD.fonts.Default)
	f40_local6.li_subscribe:setText(Engine.Localize("MPUI_ELITE_SUBSCRIBE"))
	f40_local6.li_subscribe:setAlpha(f40_local12)
	f0_local5()
	f40_local6.legalText = LUI.UIText.new()
	f40_local6.legalText:setLeftRight(true, true, 540, 0)
	f40_local6.legalText:setTopBottom(true, false, 510, 510 + CoD.textSize.ExtraSmall)
	f40_local6.legalText:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	f40_local6.legalText:setAlignment(LUI.Alignment.Left)
	f40_local6.legalText:setFont(CoD.fonts.ExtraSmall)
	f40_local6.legalText:setText(Engine.Localize("MPUI_ELITE_BENEFITS_2"))
	f40_local6.legalText:setAlpha(0.2)
	f40_local6:addElement(f40_local6.legalText)
	CoD.EliteRegistrationEmailPopup.CanCheckFields = true
	f40_local6.leftRepeater = LUI.UIButtonRepeater.new("left", {
		name = "gamepad_button",
		button = "left",
		down = true
	})
	f40_local6.rightRepeater = LUI.UIButtonRepeater.new("right", {
		name = "gamepad_button",
		button = "right",
		down = true
	})
	f40_local6:addElement(f40_local6.leftRepeater)
	f40_local6:addElement(f40_local6.rightRepeater)
	return f40_local6
end

