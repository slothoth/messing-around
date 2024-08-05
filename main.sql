INSERT INTO Modifiers(ModifierId, ModifierType) VALUES ('SLTH_TEST', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION');

INSERT INTO ModifierArguments(ModifierId, Name, "Value") VALUES
('SLTH_TEST', 'Amount', '0.1'),
('SLTH_TEST', 'YieldType', 'YIELD_GOLD');

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES ('BUILDING_MONUMENT', 'SLTH_TEST');
