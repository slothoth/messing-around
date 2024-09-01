function preCalcBinaryMap(iMax, mapMap)
    for var=0,15 do
        mapMap[var] = NumberToBinaryTable(var, iMax)
    end
    return mapMap
end

function SetBinaryProperty(pObject, sPropertyTemplate, iNum)
    local tBinaryMap = g_tBinaryMapSet[iNum]
    for iBitVal, iBit in pairs(tBinaryMap) do
        local sProperty = string.format(sPropertyTemplate, iBitVal)
        print(sProperty, iBit)
        pObject:SetProperty(sProperty, iBit)
    end
end

function NumberToBinaryTable(iNum, iMax)                                -- taken from Suktritact al Andaluz
    assert(iNum >= 0, "number must be positive value")
    assert(iMax >= 0, "maximum must be positive value")

    iNum = math.floor(iNum) -- integers only!
    iNum = math.min(iNum, iMax)

    local iNumDigits = math.floor(math.log(iMax)/math.log(2)) + 1
    local tBinaryMap 	= {}
    for i = iNumDigits-1, 0, -1 do tBinaryMap[2^(i)] = 0 end
    local iCurPow		= 0
    ---------------------------
    repeat
        local iBitNum	= iNum % 2
        iNum			= (iNum - iBitNum)/2

        tBinaryMap[2^(iCurPow)] = iBitNum
        iCurPow = iCurPow + 1
    until (iNum == 0)
    ---------------------------
    return tBinaryMap
end

function AddYields (type, severity, plotx, ploty, mitigationLevel, randomEventID, gameCorePlaybackEventID)
    print('Disaster! of type');
    print(type)
    if type ~= 2 then return end          -- check if correct diaster, volcano
    local iBonus = severity + 0
    for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do     -- shamelessly stolen from LeeS
        local pAdjacentPlot = Map.GetAdjacentPlot(plotx, ploty, direction)
        if pAdjacentPlot then
            SetBinaryProperty(pPlot, 'SLTH_VOLCANO_', iBonus)
        end
    end
end

local bBillCivPresent
local sCivType
for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if not bBillCivPresent then
		sCivType = PlayerConfigurations[v]:GetCivilizationTypeName()
        if sCivType == 'CIVILIZATION_ROME' then
            bBillCivPresent = true
            g_tBinaryMapSet = {}
            g_tBinaryMapSet = preCalcBinaryMap(iMax, tBinaryMapSet)
            Events.RandomEventOccurred.Add(AddYields);
        end
	end
end
