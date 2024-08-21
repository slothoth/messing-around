INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
('SLTH_TEST_ATTACH', 'MODIFIER_ALL_DISTRICTS_ATTACH_MODIFIER', NULL, NULL),
('SLTH_TEST', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', NULL, 'SLTH_REQ_SET');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('SLTH_TEST', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('SLTH_TEST', 'Amount', 'ARGTYPE_IDENTITY', '25'),
('SLTH_TEST_ATTACH', 'ModifierId', 'ARGTYPE_IDENTITY', 'SLTH_TEST');

INSERT INTO GameModifiers(ModifierId) VALUES
('SLTH_TEST_ATTACH');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('SLTH_REQ_SET', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('SLTH_REQ_SET', 'SLTH_REQUIREMENT'),
('SLTH_REQ_SET', 'REQUIRES_DISTRICT_IS_CITY_CENTER');

INSERT INTO Requirements(RequirementId, RequirementType) VALUES
('SLTH_REQUIREMENT', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
('SLTH_REQUIREMENT', 'PropertyName','vault_level'),
('SLTH_REQUIREMENT', 'PropertyMinimum','1');
