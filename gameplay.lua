-- 7 levels:
-- Empty (<50): -2 amenities
-- Low (50 - 100): -1 amenities
-- Normal (100 - 149): nothing
-- Stocked (150 - 199): +1 Amenity
-- Abundant (200 - 299): 10% prod, +2 Amenity
-- Full (300 - 499): 25% prod, +2 Amenity
-- Overflowing (499+): 40% prod, +3 Amenity, +25% GPP
ranges = {{min = 0, max = 49, category = 0},
          { min = 50, max = 99, category = 1 },
          { min = 100, max = 149, category = 2 },
          { min = 150, max = 199, category = 3 },
          { min = 200, max = 299, category = 4 },
          { min = 300, max = 499, category = 5 },
          { min = 501, max = 99999, category = 6 } }

function RecalculateVaults(playerID)
    local pPlayer = Players[playerID]
    if not pPlayer:IsMajor() then return; end;
    local pPlayerConfig = PlayerConfigurations[pPlayer]
    local sCivName = pPlayerConfig:GetCivilizationTypeName()
    print(sCivName)
    --if sCivName == 'SLTH_CIVILIZATION_KHAZAD' then return end;
    local pPlayerCities = pPlayer:GetCities()
    if not pPlayerCities then return; end;
    local iCityCount = pPlayerCities:GetCount()
    local iCurrentGold = pPlayerCities:GetTreasury():GetGoldBalance()
    local fVaultGold =  iCurrentGold / iCityCount;
    local iVaultLevel = 2
    for _, range in ipairs(ranges) do
        if fVaultGold >= range.min and fVaultGold <= range.max then
            iVaultLevel =  range.category
        end
    end
    for idx, pCity in pPlayerCities:Members() do
        pCity:SetProperty('vault_level', iVaultLevel)
    end
end

GameEvents.PlayerTurnStarted.Add(RecalculateVaults);
local bKhazadPresent = false
for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
	if bKhazadPresent == false then
		local sCivType = PlayerConfigurations[v]:GetCivilizationTypeName()
        if sCivType == 'SLTH_CIVILIZATION_KHAZAD' then
            bKhazadPresent = true
            GameEvents.PlayerTurnStarted.Add(RecalculateVaults);
        end
	end
end

--function VaultGoldChange(playerID, yield , balance) end

--function VaultSettleChange() end

-- function VaultConquerChange(newPlayerID, oldPlayerID, newCityID, cityX, cityY) end

-- GameEvents.TreasuryChanged.Add(VaultGoldChange);
-- GameEvents.CityBuilt.Add(RecalculateCityCount);
-- GameEvents.CityConquered.Add(RecalcCities);
-- CityInitialized?