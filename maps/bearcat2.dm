
//**************************************************************
// Map Datum -- Bearcat 2
//**************************************************************

/datum/map/active
	nameShort = "bearcat"
	nameLong = "Bearcat"
	map_dir = "bearcat"
	tDomeX = 127
	tDomeY = 67
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/station,
		/datum/zLevel/centcomm,
		/datum/zLevel/space{
			name = "spaceOldSat" ;
			},
		/datum/zLevel/space{
			name = "derelict" ;
			},
		/datum/zLevel/space{
			name = "spacePirateShip" ;
			},
		/datum/zLevel/mining,
		)

////////////////////////////////////////////////////////////////
#include "maps\bearcat2.dmm"