local FreeXPUnits = { SLTH_UNIT_ADEPT = 1, SLTH_UNIT_IMP = 1, SLTH_UNIT_SHAMAN = 1, SLTH_UNIT_ARCHMAGE = 2, SLTH_UNIT_EATER_OF_DREAMS = 2,
                      SLTH_UNIT_CORLINDALE = 2, SLTH_UNIT_DISCIPLE_OF_ACHERON = 1, SLTH_UNIT_GAELAN = 1.5, SLTH_UNIT_GIBBON = 2,
                      SLTH_UNIT_GOVANNON = 2, SLTH_UNIT_HEMAH = 2, SLTH_UNIT_LICH = 2, SLTH_UNIT_ILLUSIONIST = 1.5, SLTH_UNIT_MAGE = 1.5,
                      SLTH_UNIT_WIZARD = 1.5, SLTH_UNIT_MOBIUS_WITCH = 1.5, SLTH_UNIT_MOKKA = 1.5, SLTH_UNIT_SON_OF_THE_INFERNO = 2,
                      UNIT_SLINGER = 1.5, UNIT_SCOUT = 1}

-- last two to test
-- SLTH_UNIT_MOKKA???
function removeTest(playerID, unitID)
    print("Unit removed: " .. unitID);
end

function FreePromotionFromResource(playerID, unitID)
    local pPlayer = Players[playerID];  --Players[playerID]:GetResources():HasResource(12);
    local resources = pPlayer:GetResources()
    if not resources then return end
    local hasResource = resources:HasResource(12);
    if hasResource > 1 then
        local pUnit = pPlayer:GetUnits():FindID(unitID);
        pUnit:GetExperience():SetPromotion(1)           -- choose relevant promotion index, currently scout
    end
end

function GrantXP(playerId)
    local pPlayer = Players[playerId];
    for i, unit in pPlayer:GetUnits():Members() do
        local iUnitIndex = unit:GetType();
        local sUnitType = GameInfo.Units[iUnitIndex].UnitType
        if not sUnitType then return; end                       -- remove once table correct
        local fXP_gain = FreeXPUnits[sUnitType]
        if fXP_gain then
            if fXP_gain == math.floor(fXP_gain) then
                -- if integer, simple add xp
                unit:GetExperience():ChangeExperience(fXP_gain);
            else
                -- if float, use property to set state.
                local iXP_portion, fXP_portion = math.modf(fXP_gain);
                print('Decimal portion of xp gain is:')
                print(fXP_portion);
                local existing_xp_portion = unit:GetProperty('xp_portion');
                if not existing_xp_portion then
                    unit:SetProperty('xp_portion', fXP_portion);
                    print('No prior xp_portion');
                else
                    local new_xp_portion = existing_xp_portion + fXP_portion;
                    if new_xp_portion > 1 then
                        iXP_portion = iXP_portion + 1;
                        new_xp_portion = new_xp_portion - 1;
                    end
                    unit:SetProperty('xp_portion', new_xp_portion);
                    print('Old xp_portion: ' .. existing_xp_portion .. ' New xp_portion: ' .. new_xp_portion);
                end
                print('Adding ' .. iXP_portion .. ' to unit.')
                unit:GetExperience():ChangeExperience(iXP_portion);
            end
        end
    end
end

GameEvents.PlayerTurnStarted.Add(GrantXP);
GameEvents.UnitRemovedFromMap.Add(removeTest);
GameEvents.UnitCreated.Add(FreePromotionFromResource);