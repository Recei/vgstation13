// converyor diverter
// extendable arm that can be switched so items on the conveyer are diverted sideways
// situate in same turf as conveyor
// only works if belts is running proper direction
//
//
/obj/machinery/diverter
	icon = 'recycling.dmi'
	icon_state = "diverter0"
	name = "diverter"
	desc = "A diverter arm for a conveyor belt."
	anchored = 1
	layer = FLY_LAYER
	var/obj/machinery/conveyor/conv // the conveyor this diverter works on
	var/deployed = 0	// true if diverter arm is extended
	var/operating = 0	// true if arm is extending/contracting
	var/divert_to	// the dir that diverted items will be moved
	var/divert_from // the dir items must be moving to divert


// create a diverter
// set up divert_to and divert_from directions depending on dir state
/obj/machinery/diverter/New()

	..()

	switch(dir)
		if(NORTH)
			divert_to = WEST			// stuff will be moved to the west
			divert_from = NORTH			// if entering from the north
		if(SOUTH)
			divert_to = EAST
			divert_from = NORTH
		if(EAST)
			divert_to = EAST
			divert_from = SOUTH
		if(WEST)
			divert_to = WEST
			divert_from = SOUTH
		if(NORTHEAST)
			divert_to = NORTH
			divert_from = EAST
		if(NORTHWEST)
			divert_to = NORTH
			divert_from = WEST
		if(SOUTHEAST)
			divert_to = SOUTH
			divert_from = EAST
		if(SOUTHWEST)
			divert_to = SOUTH
			divert_from = WEST
	spawn(2)
		// wait for map load then find the conveyor in this turf
		conv = locate() in src.loc
		if(conv)	// divert_from dir must match possible conveyor movement
			if(conv.forwards != divert_from && conv.forwards != turn(divert_from,180) )
				del(src)	// if no dir match, then delete self
		set_divert()
		update()

// update the icon state depending on whether the diverter is extended
/obj/machinery/diverter/proc/update()
	icon_state = "diverter[deployed]"

// call to set the diversion vars of underlying conveyor
/obj/machinery/diverter/proc/set_divert()
	if(conv)
		if(deployed)
			conv.divert = divert_to
			conv.divdir = divert_from
		else
			conv.divert= 0


// *** TESTING click to toggle
/obj/machinery/diverter/Click()
	toggle()


// toggle between arm deployed and not deployed, showing animation
//
/obj/machinery/diverter/proc/toggle()
	if( stat & (NOPOWER|BROKEN))
		return

	if(operating)
		return

	use_power(50)
	operating = 1
	if(deployed)
		flick("diverter10",src)
		icon_state = "diverter0"
		sleep(10)
		deployed = 0
	else
		flick("diverter01",src)
		icon_state = "diverter1"
		sleep(10)
		deployed = 1
	operating = 0
	update()
	set_divert()

// don't allow movement into the 'backwards' direction if deployed
/obj/machinery/diverter/CanPass(atom/movable/O, var/turf/target)
	var/direct = get_dir(O, target)
	if(direct == divert_to)	// prevent movement through body of diverter
		return 0
	if(!deployed)
		return 1
	return(direct != turn(divert_from,180))

// don't allow movement through the arm if deployed
/obj/machinery/diverter/CheckExit(atom/movable/O, var/turf/target)
	var/direct = get_dir(O, target)
	if(direct == turn(divert_to,180))	// prevent movement through body of diverter
		return 0
	if(!deployed)
		return 1
	return(direct != divert_from)