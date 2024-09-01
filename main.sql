INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAJANS_COLUMN_TRAIT', 'SLTH_VOLCANO_YIELD_SCIENCE_1'),
('TRAJANS_COLUMN_TRAIT', 'SLTH_VOLCANO_YIELD_SCIENCE_2'),
('TRAJANS_COLUMN_TRAIT', 'SLTH_VOLCANO_YIELD_SCIENCE_4'),
('TRAJANS_COLUMN_TRAIT', 'SLTH_VOLCANO_YIELD_SCIENCE_8');

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('SLTH_VOLCANO_YIELD_SCIENCE_1', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'SLTH_VOLCANO_YIELD_PROPERTY_1'),
('SLTH_VOLCANO_YIELD_SCIENCE_2', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'SLTH_VOLCANO_YIELD_PROPERTY_2'),
('SLTH_VOLCANO_YIELD_SCIENCE_4', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'SLTH_VOLCANO_YIELD_PROPERTY_4'),
('SLTH_VOLCANO_YIELD_SCIENCE_8', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'SLTH_VOLCANO_YIELD_PROPERTY_8');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value) VALUES
('SLTH_VOLCANO_YIELD_SCIENCE_1', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_SCIENCE'),
('SLTH_VOLCANO_YIELD_SCIENCE_2', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_SCIENCE'),
('SLTH_VOLCANO_YIELD_SCIENCE_4', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_SCIENCE'),
('SLTH_VOLCANO_YIELD_SCIENCE_8', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_SCIENCE');
('SLTH_VOLCANO_YIELD_SCIENCE_1', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('SLTH_VOLCANO_YIELD_SCIENCE_2', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('SLTH_VOLCANO_YIELD_SCIENCE_4', 'Amount', 'ARGTYPE_IDENTITY', '4'),
('SLTH_VOLCANO_YIELD_SCIENCE_8', 'Amount', 'ARGTYPE_IDENTITY', '8');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('SLTH_VOLCANO_YIELD_PROPERTY_1', 'REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_1'),
('SLTH_VOLCANO_YIELD_PROPERTY_2', 'REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_2'),
('SLTH_VOLCANO_YIELD_PROPERTY_4', 'REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_4'),
('SLTH_VOLCANO_YIELD_PROPERTY_8', 'REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_8');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_1', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_2', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_4', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_8', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Type, Value) VALUES
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_1', 'PropertyName', 'ARGTYPE_IDENTITY', 'SLTH_VOLCANO_YIELD_1'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_2', 'PropertyName', 'ARGTYPE_IDENTITY', 'SLTH_VOLCANO_YIELD_2'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_4', 'PropertyName', 'ARGTYPE_IDENTITY', 'SLTH_VOLCANO_YIELD_4'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_8', 'PropertyName', 'ARGTYPE_IDENTITY', 'SLTH_VOLCANO_YIELD_8'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_1', 'PropertyMinimum', 'ARGTYPE_IDENTITY', '1'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_2', 'PropertyMinimum', 'ARGTYPE_IDENTITY', '1'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_4', 'PropertyMinimum', 'ARGTYPE_IDENTITY', '1'),
('REQUIRE_SLTH_VOLCANO_YIELD_PROPERTY_8', 'PropertyMinimum', 'ARGTYPE_IDENTITY', '1');


INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('SLTH_VOLCANO_YIELD_PROPERTY_1', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_VOLCANO_YIELD_PROPERTY_2', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_VOLCANO_YIELD_PROPERTY_4', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_VOLCANO_YIELD_PROPERTY_8', 'REQUIREMENTSET_TEST_ALL');