-- Original Author: Flactine --
-- Altered by: Slothoth --
--------------------------------------------------------------
function SummonFunction(iAndyPlayer, iUnit, unit_summoned, iX, iY)
	local pUnit = UnitManager.GetUnit(iAndyPlayer, iUnit);
	local player = pUnit:GetOwner();
	local playerReal = Players[player];
	local playerUnits = playerReal:GetUnits();
	playerUnits:Create(unit_summoned, iX, iY);
end

function Initialize()
	if ExposedMembers.ExtraHeroes == nil then
		ExposedMembers.ExtraHeroes = {}
	end
	ExposedMembers.ExtraHeroes.SummonFunction = SummonFunction;
end
Initialize();