CoD.TypewriterText = {}
CoD.TypewriterText.new = function (f1_arg0)
	local f1_local0 = LUI.UIText.new(f1_arg0, true)
	f1_local0:registerEventHandler("typewrite", CoD.TypewriterText.Typewrite)
	f1_local0:registerEventHandler("transition_complete_typewrite", CoD.TypewriterText.TransitionComplete_Typewrite)
	return f1_local0
end

CoD.TypewriterText.Typewrite = function (f2_arg0, f2_arg1)
	if not f2_arg1.text then
		f2_arg0:animateToState("default")
		f2_arg0:setText("")
		return 
	end
	f2_arg0.duration = f2_arg1.duration
	if not f2_arg0.duration then
		if f2_arg1.perLetter then
			f2_arg0.duration = string.len(f2_arg1.text) * f2_arg1.perLetter
		else
			f2_arg0.duration = 1000
		end
	end
	f2_arg0.fullString = f2_arg1.text
	f2_arg0.timeElapsed = 0
	f2_arg0.numLetters = Engine.CountCharacters(f2_arg0.fullString)
	f2_arg0:beginAnimation("typewrite", 1)
end

CoD.TypewriterText.TransitionComplete_Typewrite = function (f3_arg0, f3_arg1)
	if not f3_arg1.interrupted then
		f3_arg0.timeElapsed = f3_arg0.timeElapsed + f3_arg1.lateness + 1
		local f3_local0 = Engine.SubstringLeft(f3_arg0.fullString, f3_arg0.numLetters * f3_arg0.timeElapsed / f3_arg0.duration)
		f3_arg0:setText(f3_local0)
		if f3_local0 ~= f3_arg0.fullString then
			f3_arg0:beginAnimation("typewrite", 1)
		end
	end
end

