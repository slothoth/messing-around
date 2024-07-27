INSERT INTO Technologies(TechnologyType, UITreeRow, EmbarkUnitType, EmbarkAll, Cost, EraType, Critical, Description, Repeatable, AdvisorType, BarbarianFree, Name) VALUES
('SLTH_TECH_AGRICULTURE', '-2', NULL, '0', '20', 'ERA_FUTURE', '0', 'LOC_SLTH_TECH_AGRICULTURE_DESCRIPTION', '0', 'ADVISOR_GENERIC', '0', 'LOC_SLTH_TECH_AGRICULTURE_NAME');

INSERT INTO TechnologyPrereqs(Technology, PrereqTech) VALUES
('SLTH_TECH_AGRICULTURE', 'TECH_FUTURE_TECH');

INSERT INTO Types(Kind, Type) VALUES
('KIND_TECH', 'SLTH_TECH_AGRICULTURE');