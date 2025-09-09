require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
CoD.AARUtility = {}
CoD.AARUtility.MapsLoaded = false
CoD.AARUtility.MapList = {}
CoD.AARUtility.AttachmentTable = "sp/attachmentTable.csv"
CoD.AARUtility.ScoreTable = "sp/scoringTable.csv"
CoD.AARUtility.ChallengeTable = "sp/challengeTable.csv"
CoD.AARUtility.LevelTable = "sp/levelLookup.csv"
CoD.AARUtility.LocalPlayerBestStatColor = {
	r = 0,
	g = 0.64,
	b = 0.91,
	a = 1
}
CoD.AARUtility.OtherPlayerStatColor = CoD.trueOrange
CoD.AARUtility.LoadMaps = function ()
	if CoD.AARUtility.MapsLoaded then
		return 
	end
	local f1_local0 = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, "map_count", 1)
	if f1_local0 == nil or tonumber(f1_local0) == nil or tonumber(f1_local0) < 0 then
		return 
	end
	f1_local0 = tonumber(f1_local0)
	local f1_local1 = 1
	while f1_local1 <= f1_local0 do
		local f1_local2 = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 8)
		if f1_local2 == "CMP" or f1_local2 == "DEV" or f1_local2 == "RTS" or f1_local2 == "TUT" then
			table.insert(CoD.AARUtility.MapList, {
				levelNum = tonumber(UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 0)),
				name = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 1),
				alias = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 2),
				display = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 9),
				isDevLevel = f1_local2 == "DEV",
				isRTSMap = f1_local2 == "RTS",
				isTutMap = f1_local2 == "TUT",
				rtsStart = tonumber(UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 13)),
				rtsEnd = tonumber(UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 14)),
				rtsLookup = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 15),
				doStats = UIExpression.TableLookup(controller, CoD.AARUtility.LevelTable, 0, f1_local1 .. "", 16)
			})
		end
		f1_local1 = f1_local1 + 1
	end
	CoD.AARUtility.MapsLoaded = true
end

CoD.AARUtility.DecorateButtonRow = function (f2_arg0)
	if not f2_arg0 then
		return 
	end
	for f2_local0 = 1, #f2_arg0, 1 do
		local f2_local3 = f2_arg0[f2_local0]
		f2_local3:setRGB(1, 1, 1)
		if f2_local0 % 2 == 0 then
			f2_local3:setAlpha(0.09)
		else
			f2_local3:setAlpha(0.05)
		end
	end
end

CoD.AARUtility.AddDebugBG = function (f3_arg0, f3_arg1)
	local f3_local0 = LUI.UIImage.new()
	f3_local0:setLeftRight(true, true, 0, 0)
	f3_local0:setTopBottom(true, true, 0, 0)
	if f3_arg1 then
		f3_local0:setRGB(f3_arg1.r, f3_arg1.g, f3_arg1.b)
		f3_local0:setAlpha(f3_arg1.a)
	else
		f3_local0:setRGB(1, 0, 0)
		f3_local0:setAlpha(0.2)
	end
	f3_arg0:addElement(f3_local0)
end

