capital = player capital x,y
find gov plaza city
gov_plaza =  gov plaza x y

player_reduction_dist = 0
player_reduction_city_count = 0

if despotism:
   player_reduction_city_count = player_reduction_city_count + 25
else if city_states:
   player_reduction_city_count = player_reduction_city_count - 25
   player_reduction_dist = player_reduction_dist - 80
else if god_king:
   player_reduction_dist = player_reduction_dist + 10
else if aristocracy:
   player_reduction_dist = player_reduction_dist - 40

playerCityList = Player:GetCities()
numCities = table.count(playerCityList)
cityCountCost = numCities X CONST
for city in playerCityList:
    city_dist_cost = 0
    city_num_cities_cost = 0
    base = 100
    if cityHasTowerOfComplacency:
        base = base - 50
    if cityHasBasilica:
        base = base - 40
    if cityHasGamblingHouse:
        base = base + 10
    if cityHasTavern or cityHasGrigoriTavern:
        base = base + 10
    if cityHasLanunHarbor:
        base = base - 10
    if cityHasCourthouse:
        base = base - 40
    else if govManor:
        base = base - 20

    reduction_dist = base - player_reduction_dist
    if reduction_dist > 0:
        city_location = get city x, y
        palace_diff = sum(capital - city_loc)
        plaza_diff = sum(gov_plaza - city_loc)
        if palace_diff > plaza_diff:
            dist_mult = CONST x palace_diff
        else:
            dist_mult = CONST x plaza_diff

        city_dist_cost = dist_mult x reduction_dist

    reduction_city = base - player_reduction_city_count
    if reduction_city > 0:
        city_num_cities_cost = cityCountCost X reduction_city


    city_cost = city_dist_cost + city_num_cities_cost
    ADJUST CITY GOLD YIELD HERE SOMEHOW


Can we only trigger event when any city is built, city builds a maintenance building, one of, or civ changes in or out of maintenance policies?
Other triggers would be when gov plaza buiLt/destroyed, or when capital lost.
Be more performant by setting existing state in setProperty?
Also seems silly to recalculate expensive distance yields on new city founded