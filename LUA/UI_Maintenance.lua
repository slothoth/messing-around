-- More ExposedMembers bindings for functions unavailable in gameplay scripts


function Initialize()
	if ExposedMembers.ExposedUnitPromotionsFunctions == nil then
		ExposedMembers.ExposedUnitPromotionsFunctions = {}
	end
	ExposedMembers.ExposedUnitPromotionsFunctions.GetPromotions = GetPromotions;
	ExposedMembers.ExposedUnitPromotionsFunctions.GivePromotion = GivePromotion;
end

Initialize();