-- Can we only trigger event when
-- any city is built
 --city builds a maintenance building,
 --civ changes in or out of maintenance policies?
-- gov plaza buiLt/destroyed, palace built/destroyed. hopefully recapital covers palace part. gov plaza unbuilt
-- CONSTANTS
MaintenanceReductionBuildings = {BUILDING_MONUMENT=-50, BUILDING_GRANARY=20};
MaintenanceReductionPolicies = {POLICY_DISCIPLINE={City=25, Distance=50}, POLICY_GOD_KING={City=20, Distance=30}};

function MasterTax(playerId)
    local pPlayer = Players[playerId];
    if not pPlayer:IsMajor() then print('is minor'); return; end;
    -- local global_dist_reduction, global_city_reduction = CalculatePolicyReduction(pPlayer); -- currently broke as struggling to iterate over SQL table
    local global_dist_reduction, global_city_reduction = 1, 1;          -- tODO remove
    local num_cities = 0;
    local glob_dist_tax = 0.0;
    print('Player is: '.. playerId);
    print(pPlayer);
    for idx, city in pPlayer:GetCities():Members() do
        local dist_tax = city:GetProperty('distance');
        glob_dist_tax = glob_dist_tax + dist_tax;
        num_cities = num_cities + 1;
    end
    local cities_tax = num_cities * global_city_reduction;
    pPlayer:SetProperty('city_num_maintenance', cities_tax);
    local taxes = glob_dist_tax * global_dist_reduction;
    pPlayer:SetProperty('city_distance_maintenance', glob_dist_tax);
    taxes = taxes + cities_tax;
    print('Total tax cost:');
    print(-taxes);
    pPlayer:GrantYield(2, -taxes);          -- 2 is hopefully gold attempt to index a number value?

end

function BuildingTaxReductionMade(playerID, cityID, buildingID, plotID, isOriginalConstruction)
    local buildingName = GameInfo.Buildings[buildingID];
    print(buildingName);
    print(buildingName.BuildingType);
    local building_row = MaintenanceReductionBuildings[buildingName.BuildingType];        -- attempt to index a nil value
    if building_row then
        local pCity = CityManager.GetCity(playerID, cityID);
	    local tax_val = pCity:GetProperty('distance_mult');
	    tax_val = tax_val + building_row;
	    print('New tax mult on this city:');
	    print(tax_val);
	    pCity:SetProperty('distance_mult', tax_val);       -- attempt to index a number value? possibly fixed
    end
end

function InitCityTax(playerID, cityID, x, y)
    local pPlayer = Players[playerID];
    local pCity = CityManager.GetCity(playerID, cityID);
    print('pCity is:');
    print(pCity);
    local pCapital = pPlayer:GetCities():GetCapitalCity();        -- later on, do check if gov plaza closer
    if pCapital then
        local cap_x = pCapital:GetX();
        local cap_y = pCapital:GetY();
        local distance = Map.GetPlotDistance(x, y, cap_x, cap_y); -- is this manhattan or euclid
        print('Distance from capital on init:');
        print(distance);
        pCity:SetProperty('distance', distance);
    else
        print('No Capital found! Was this first city?');
        pCity:SetProperty('distance', 0);
    end
    pCity:SetProperty('distance_mult', 100);
    pCity:SetProperty('city_mult', 100);
end

function BuildingTaxPillaged(playerID, cityID, buildingID, isPillaged)
    local buildingName = GameInfo.Buildings[buildingID];
    local building_row = GameInfo.MaintenanceReductionBuildings[buildingName.BuildingType];     -- MaintenanceReductionBuildings[buildingName.BuildingType]
    if building_row then
        local pCity = CityManager.GetCity(playerID, cityID);
        local tax_val = pCity:GetProperty('distance_mult');
    	if isPillaged then
	        tax_val = tax_val - building_row;
        else
	        tax_val = tax_val + building_row;
        end
        pCity:SetProperty('distance_mult', tax_val);
    end
end

function CapitalCityRecalc(playerID, cityID)
    local pPlayer = Players[playerID];
    local pCapital = pPlayer:GetCities():GetCapitalCity(); -- assuming this is new one.
    local cap_x = pCapital:GetX();
    local cap_y = pCapital:GetY();
    local tPlayerCities = Players[playerID]:GetCities():Members();
    if #tPlayerCities == 0 then return end;
    for _, city in tPlayerCities do
        local city_x = city:GetX();
        local city_y = city:GetY();
        local distance = Map.GetPlotDistance(city_x, city_y, cap_x, cap_y);
        print('distance is'.. distance);
        city:SetProperty('distance', distance);
    end
end

function CalculatePolicyReduction(pPlayer)
    local dist_mult = 0;
    local city_mult = 0;
    local kCulture = pPlayer:GetCulture();
    local maintenance_policies = GameInfo.MaintenanceReductionPolicies; -- function expected instead of nil, brackets dont work
    for idx, row in ipairs(maintenance_policies) do
        print(row);
        local policy = GameInfo.Policies[row.PolicyType];
        if kCulture:IsPolicyActive(policy.Index) then
    	    if policy.CityReduction then
    	    	city_mult = city_mult + policy.CityReduction;
    	    end
    	    if policy.DistanceReduction then
    	    	dist_mult = dist_mult + policy.DistanceReduction;
    	    end
    	end
    end
    return dist_mult, city_mult
end


GameEvents.PlayerTurnStarted.Add(MasterTax);
GameEvents.CityBuilt.Add(InitCityTax);
GameEvents.BuildingConstructed.Add(BuildingTaxReductionMade);
GameEvents.BuildingPillageStateChanged.Add(BuildingTaxPillaged);
GameEvents.CapitalCityChanged.Add(CapitalCityRecalc);