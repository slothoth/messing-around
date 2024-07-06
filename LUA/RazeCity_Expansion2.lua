-- Copyright 2018, Firaxis Games
include("RazeCity");

-- ===========================================================================
--	OVERRIDES
-- ===========================================================================

-- ===========================================================================
function OnOpen()
	local localPlayerID = Game.GetLocalPlayer();
	local localPlayer = Players[localPlayerID];
	if (localPlayer == nil) then
		return;
	end

	g_pSelectedCity = localPlayer:GetCities():GetNextCapturedCity();

	Controls.PanelHeader:LocalizeAndSetText("LOC_RAZE_CITY_HEADER");
    Controls.CityHeader:LocalizeAndSetText("LOC_RAZE_CITY_NAME_LABEL");
    Controls.CityName:LocalizeAndSetText(g_pSelectedCity:GetName());
    Controls.CityPopulation:LocalizeAndSetText("LOC_RAZE_CITY_POPULATION_LABEL");
    Controls.NumPeople:SetText(tostring(g_pSelectedCity:GetPopulation()));
    Controls.CityDistricts:LocalizeAndSetText("LOC_RAZE_CITY_DISTRICTS_LABEL");
	local iNumDistricts = g_pSelectedCity:GetDistricts():GetNumZonedDistrictsRequiringPopulation();
    Controls.NumDistricts:SetText(tostring(iNumDistricts));

	local szWarmongerString;
	local eOriginalOwner = g_pSelectedCity:GetOriginalOwner();
	local originalOwnerPlayer = Players[eOriginalOwner];
	local eOwnerBeforeOccupation = g_pSelectedCity:GetOwnerBeforeOccupation();
	local eConqueredFrom = g_pSelectedCity:GetJustConqueredFrom();
	local bWipedOut = (originalOwnerPlayer:GetCities():GetCount() < 1);
	local eLastTransferType = g_pSelectedCity:GetLastTransferType();
	local iFavorForLiberation = GlobalParameters.FAVOR_FOR_LIBERATE_PLAYER_CITY;
	local pPlayerConfig = PlayerConfigurations[eOriginalOwner];
	local isMinorCiv = pPlayerConfig:GetCivilizationLevelTypeID() ~= CivilizationLevelTypes.CIVILIZATION_LEVEL_FULL_CIV;
	print('New changes exist');
	if (isMinorCiv) then
		iFavorForLiberation = GlobalParameters.FAVOR_FOR_LIBERATE_CITY_STATE;
	end
	local cities = originalOwnerPlayer:GetCities();
	if (not isMinorCiv and cities:GetCount() == 0 and not localPlayer:GetStats():GetHasRevivedPlayer(eOriginalOwner)) then
		iFavorForLiberation = iFavorForLiberation + GlobalParameters.FAVOR_FOR_REVIVE_PLAYER;
	end

	print('is Original Owner different than owner before occupation:')
	print(eOriginalOwner ~= eOwnerBeforeOccupation)
	print('Is the CanLiberate true:')
	print(localPlayer:GetDiplomacy():CanLiberateCityTo(eOriginalOwner))
	print('Is OriginalOwner different than conquered from?:')
	print(eOriginalOwner ~= eConqueredFrom)
	-- local warlordModifier = GameInfo.Modifiers['GOV_PRODUCTION_BOOST_FROM_CAPTURE'].Index
	local warlordModifier = GameInfo.Modifiers['TRAIT_TOQUI_UNIT_EXPERIENCE_FROM_GOVERNOR_NOT_FOUNDED'].Index
	local modifiers = GameEffects.GetModifiers();

	for i, v in ipairs(modifiers) do
		local owner = GameEffects.GetModifierOwner(v);
		print('Modifier Owner object is:');
		print(owner);
		print('Modifier Owner name is:');
		owner_name = Locale.Lookup(GameEffects.GetObjectName(owner))
		print(owner_name)
		print('Capturing player is:');
		print(localPlayer);
		if owner_name then
			print('modifier found')
			print(v)			-- v is not index of modifier.
			print('what we want to find')
			print(warlordModifier)
			local mod_name = Locale.Lookup(GameEffects.GetObjectName(v) or "Unknown");
			print(mod_name)
			if v == warlordModifier then
				print('Found match')
				break
			end
		end
	end

	if (eOriginalOwner ~= eOwnerBeforeOccupation) then
		print('new change, liberate right');
		Controls.Button1:LocalizeAndSetText("LOC_RAZE_CITY_LIBERATE_FOUNDER_BUTTON_LABEL", PlayerConfigurations[eOriginalOwner]:GetCivilizationShortDescription());
		szWarmongerString = Locale.Lookup("LOC_XP2_RAZE_CITY_LIBERATE_WARMONGER_EXPLANATION", iFavorForLiberation);
		Controls.Button1:LocalizeAndSetToolTip("LOC_RAZE_CITY_LIBERATE_EXPLANATION", szWarmongerString);
		Controls.Button1:SetHide(false);
	else
		Controls.Button1:SetHide(true);
	end

	if (localPlayer:GetDiplomacy():CanLiberateCityTo(eOwnerBeforeOccupation) and eOwnerBeforeOccupation ~= eConqueredFrom) then
		print('unchanged, liberate prewar');
		Controls.Button2:LocalizeAndSetText("LOC_RAZE_CITY_LIBERATE_PREWAR_OWNER_BUTTON_LABEL", PlayerConfigurations[eOwnerBeforeOccupation]:GetCivilizationShortDescription());
		szWarmongerString = Locale.Lookup("LOC_XP2_RAZE_CITY_LIBERATE_WARMONGER_EXPLANATION", iFavorForLiberation);
		Controls.Button2:LocalizeAndSetToolTip("LOC_RAZE_CITY_LIBERATE_EXPLANATION", szWarmongerString);
		Controls.Button2:SetHide(false);
	else
		Controls.Button2:SetHide(true);
	end

	Controls.Button3:LocalizeAndSetText("LOC_RAZE_CITY_KEEP_BUTTON_LABEL");
	if (eLastTransferType == CityTransferTypes.BY_GIFT) then
		print('unchanged, no clue');
		szWarmongerString = Locale.Lookup("LOC_RAZE_CITY_KEEP_EXPLANATION_TRADED");
		Controls.Button3:LocalizeAndSetToolTip(szWarmongerString);
	elseif (Players[eConqueredFrom]:IsFreeCities()) then
		print('unchanged, free city');
		Controls.Button3:LocalizeAndSetToolTip("LOC_XP2_RAZE_CITY_KEEP_FREE_CITY_EXPLANATION");
	elseif (bWipedOut ~= true) then
		local iWarmongerPoints = localPlayer:GetDiplomacy():ComputeCityWarmongerPoints(g_pSelectedCity, eConqueredFrom, false);
		szWarmongerString = Locale.Lookup("LOC_XP2_RAZE_CITY_KEEP_WARMONGER_EXPLANATION", iWarmongerPoints);
		Controls.Button3:LocalizeAndSetToolTip("LOC_RAZE_CITY_KEEP_EXPLANATION", szWarmongerString);
	else
		print('unchanged, last city');
		local iWarmongerPoints = localPlayer:GetDiplomacy():ComputeCityWarmongerPoints(g_pSelectedCity, eConqueredFrom, false);
		iWarmongerPoints = (iWarmongerPoints * GlobalParameters.WARMONGER_FINAL_MAJOR_CITY_MULTIPLIER) / 100;
		szWarmongerString = Locale.Lookup("LOC_XP2_RAZE_CITY_KEEP_LAST_CITY_EXPLANATION", iWarmongerPoints);
		Controls.Button3:LocalizeAndSetToolTip(szWarmongerString);
	end

	Controls.Button4:LocalizeAndSetText("LOC_RAZE_CITY_RAZE_BUTTON_LABEL");
	if (g_pSelectedCity:CanRaze()) then
		if (Players[eConqueredFrom]:IsFreeCities()) then
			print('unchanged, free city raze');
			Controls.Button4:LocalizeAndSetToolTip("LOC_XP2_RAZE_CITY_RAZE_FREE_CITY_EXPLANATION");
		elseif (bWipedOut ~= true) then
			print('unchanged, warmonger raze when original civ still exists');
			local iWarmongerPoints = localPlayer:GetDiplomacy():ComputeCityWarmongerPoints(g_pSelectedCity, eConqueredFrom, true);
			szWarmongerString = Locale.Lookup("LOC_XP2_RAZE_CITY_RAZE_WARMONGER_EXPLANATION", iWarmongerPoints);
			Controls.Button4:LocalizeAndSetToolTip("LOC_RAZE_CITY_RAZE_EXPLANATION", szWarmongerString);
		else
			print('unchanged, warmonger raze when original civ doesnt exist');
			local iWarmongerPoints = localPlayer:GetDiplomacy():ComputeCityWarmongerPoints(g_pSelectedCity, eConqueredFrom, true);
			szWarmongerString = Locale.Lookup("LOC_XP2_RAZE_CITY_RAZE_LAST_CITY_EXPLANATION", iWarmongerPoints);
			Controls.Button4:LocalizeAndSetToolTip(szWarmongerString);
		end
		Controls.Button4:SetDisabled(false);
	else
		Controls.Button4:LocalizeAndSetToolTip("LOC_RAZE_CITY_RAZE_DISABLED_EXPLANATION");
		Controls.Button4:SetDisabled(true);

	end

	Controls.PopupStack:CalculateSize();

	UIManager:QueuePopup(ContextPtr, PopupPriority.Medium);

	Controls.PopupAlphaIn:SetToBeginning();
	Controls.PopupAlphaIn:Play();
	Controls.PopupSlideIn:SetToBeginning();
	Controls.PopupSlideIn:Play();
end
