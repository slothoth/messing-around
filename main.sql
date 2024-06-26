INSERT INTO Types(Type, Kind) VALUES
('HEROCLASS_WARRIOR', 'KIND_HEROCLASS'),
('SLTH_UNIT_WARRIOR', 'KIND_UNIT'),
('SLTH_UNIT_DUMMY', 'KIND_UNIT'),
('ABILITY_SLTH_UNIT', 'KIND_ABILITY');

INSERT INTO TypeTags(Type, Tag) VALUES
('SLTH_UNIT_DUMMY', 'CLASS_MELEE'),
('SLTH_UNIT_DUMMY', 'CLASS_SLTH_UNIT'),
('ABILITY_SLTH_UNIT', 'CLASS_SLTH_UNIT'),
('SLTH_UNIT_WARRIOR', 'CLASS_MELEE');

INSERT INTO Tags(Tag, Vocabulary) VALUES
('CLASS_SLTH_UNIT', 'ABILITY_CLASS');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES
('SLTH_KILL_UNIT', 'MODIFIER_PLAYER_UNIT_ADJUST_DAMAGE', 1, 1);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('SLTH_KILL_UNIT', 'Amount', '100');

-- grant unit with experience: Fails by CTD: Maybe because not GP
/*
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES
('SLTH_GET_UNIT', 'MODIFIER_PLAYER_UNIT_GRANT_UNIT_WITH_EXPERIENCE', 1, 1);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('SLTH_GET_UNIT', 'Experience', '1'),
('SLTH_GET_UNIT', 'UnitType', 'SLTH_UNIT_WARRIOR'),

 */

-- grant unit in nearest city variant: does nothing as wrong context, goody hut
/*
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES
('SLTH_GET_UNIT', 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_NEAREST_CITY', 1, 1);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('SLTH_GET_UNIT', 'UnitType', 'SLTH_UNIT_WARRIOR'),
('SLTH_GET_UNIT', 'Amount', '1');
*/

-- grant unit in capital variant. Works, but not ideal, as not in same city
-- /*
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES
('SLTH_GET_UNIT', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 1, 1);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('SLTH_GET_UNIT', 'UnitType', 'SLTH_UNIT_WARRIOR'),
('SLTH_GET_UNIT', 'Amount', '1'),
('SLTH_GET_UNIT', 'AllowUniqueOverride', '0');
-- */

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('ABILITY_SLTH_UNIT', 'SLTH_GET_UNIT'),
('ABILITY_SLTH_UNIT', 'SLTH_KILL_UNIT');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive) VALUES
('ABILITY_SLTH_UNIT', 'LOC_ABILITY_SLTH_UNIT_NAME', 'LOC_ABABILITY_SLTH_UNIT_NAME', 1);

INSERT INTO Units(UnitType, BaseMoves, FormationClass, AllowBarbarians, Description, Name, Combat, PromotionClass, Cost, BaseSightRange, Domain, PurchaseYield) VALUES
('SLTH_UNIT_WARRIOR', '3', 'FORMATION_CLASS_LAND_COMBAT', 0, 'LOC_DESCRIPTION', 'Nightshade', 50, 'PROMOTION_CLASS_RECON', '60', '2', 'DOMAIN_LAND', 'YIELD_GOLD'),
('SLTH_UNIT_DUMMY', '3', 'FORMATION_CLASS_LAND_COMBAT', 0, 'LOC_DESCRIPTION', 'Nightshade_Dummy', 5, 'PROMOTION_CLASS_RECON', '60', '2', 'DOMAIN_LAND', 'YIELD_GOLD');

INSERT INTO HeroClasses (HeroClassType, Name, Description, UnitType, CreationProjectType, DiscoveryMinEraType) VALUES
('HEROCLASS_WARRIOR', 'LOC_UNIT_HERO_WARRIOR_NAME', 'LOC_UNIT_HERO_WARRIOR_DESCRIPTION', 'SLTH_UNIT_WARRIOR', 'PROJECT_CREATE_HERO_HERCULES', 'ERA_FUTURE');

INSERT INTO HeroClassUnitCommands (HeroClassType, UnitCommandType, Passive) VALUES
('HEROCLASS_WARRIOR', 'UNITCOMMAND_RESTORE_UNIT_MOVES', 0);

-- promotion workaround
INSERT INTO UnitPromotionModifiers(UnitPromotionType, ModifierId) VALUES
('PROMOTION_TORTOISE', 'SLTH_GET_UNIT');

-- inactive workaround
/*
INSERT INTO UnitAbilities(UnitAbilityType, Name, Description) VALUES
('ABILITY_SLTH_UNIT_ACTIVATOR', 'LOC_ABILITY_SLTH_UNIT_NAMEs', 'LOC_ABABILITY_SLTH_UNIT_sNAME');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('ABILITY_SLTH_UNIT_ACTIVATOR', 'SLTH_ABILITY_ACTIVATE');

INSERT INTO Modifiers(ModifierId, ModifierType, Permanent) VALUES
('SLTH_ABILITY_ACTIVATE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', '1');

INSERT INTO ModifierArguments(ModifierId, Name, "Value") VALUES
('SLTH_ABILITY_ACTIVATE', 'AbilityType', 'ABILITY_SLTH_UNIT');

INSERT INTO TypeTags(Type, Tag) VALUES
('ABILITY_SLTH_UNIT_ACTIVATOR', 'CLASS_SLTH_UNIT');

INSERT INTO Types(Type, Kind) VALUES
('ABILITY_SLTH_UNIT_ACTIVATOR', 'KIND_ABILITY');

 */

-- Global grant workaround
INSERT INTO GameModifiers(ModifierId) VALUES
('SLTH_GRANT_ABILITY_ATTACH_PLAYERS');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('SLTH_GRANT_ABILITY_ATTACH_PLAYERS', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER');

INSERT INTO ModifierArguments(ModifierId, Name, "Value") VALUES
('SLTH_GRANT_ABILITY_ATTACH_PLAYERS', 'ModifierId', 'SLTH_ABILITY_ACTIVATE');

INSERT INTO Modifiers(ModifierId, ModifierType, Permanent) VALUES
('SLTH_ABILITY_ACTIVATE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', '1');

INSERT INTO ModifierArguments(ModifierId, Name, "Value") VALUES
('SLTH_ABILITY_ACTIVATE', 'AbilityType', 'ABILITY_SLTH_UNIT');

/*
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
('BUILDING_PALACE', 'SLTH_GRANT_ABILITY_ATTACH_PLAYERS');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectStackLimit, OwnerStackLimit) VALUES
('SLTH_GRANT_ABILITY_ATTACH_PLAYERS', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 1, 1);

INSERT INTO ModifierArguments(ModifierId, Name, "Value") VALUES
('SLTH_GRANT_ABILITY_ATTACH_PLAYERS', 'AbilityType', 'SLTH_ABILITY_ACTIVATE');

INSERT INTO Modifiers(ModifierId, ModifierType, Permanent) VALUES
('SLTH_ABILITY_ACTIVATE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', '1');

INSERT INTO ModifierArguments(ModifierId, Name, "Value") VALUES
('SLTH_ABILITY_ACTIVATE', 'AbilityType', 'ABILITY_SLTH_UNIT');
 */
