/obj/machinery/chem_heater
	name = "chemical heater"
	density = 1
	anchored = 1
	icon = 'icons/obj/chemical.dmi'
	icon_state = "mixer0b"
	use_power = 1
	idle_power_usage = 40
	var/obj/item/weapon/reagent_containers/beaker = null
	var/temperature = 300
	var/rate = 10 //heating/cooling rate, default is 10 kelvin per tick
	var/on = FALSE

	machine_flags = SCREWTOGGLE | CROWDESTROY | WRENCHMOVE | FIXED2WORK

/obj/machinery/chem_heater/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/chem_heater(null)
	component_parts += new /obj/item/weapon/stock_parts/manipulator(null)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(null)
	RefreshParts()

/obj/machinery/chem_heater/RefreshParts()
	rate = 10
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		rate *= M.rating

/obj/machinery/chem_heater/process()
	..()
	if(stat & NOPOWER)
		return
	var/state_change = 0
	if(on)
		if(beaker)
			if(beaker.reagents.chem_temp > temperature)
				beaker.reagents.chem_temp = max(beaker.reagents.chem_temp-rate, temperature)
				state_change = 1
			else if(beaker.reagents.chem_temp < temperature)
				beaker.reagents.chem_temp = min(beaker.reagents.chem_temp+rate, temperature)
				state_change = 1
	if(state_change)
		nanomanager.update_uis(src)

/obj/machinery/chem_heater/proc/eject_beaker()
	if(beaker)
		beaker.loc = get_turf(src)
		beaker.reagents.handle_reactions()
		beaker = null
		icon_state = "mixer0b"
		nanomanager.update_uis(src)

/obj/machinery/chem_heater/power_change()
	if(powered())
		stat &= ~NOPOWER
	else
		spawn(rand(0, 15))
			stat |= NOPOWER
	nanomanager.update_uis(src)

/obj/machinery/chem_heater/togglePanelOpen(var/obj/toggleitem, mob/user)
	if(beaker)
		user << "You can't reach the maintenance panel with a beaker in the way!"
		return
	return ..()

/obj/machinery/chem_heater/attackby(var/obj/item/I as obj, var/mob/user as mob)

	if(..())
		return 1

	if(isrobot(user))
		// UNLESS MoMMI or medbutt.
		var/mob/living/silicon/robot/R=user
		if(!isMoMMI(user) && !istype(R.module,/obj/item/weapon/robot_module/medical))
			return

	if(istype(I, /obj/item/weapon/reagent_containers/glass))

		if(beaker)
			user << "<span class='notice'>A beaker is already loaded into the machine.</span>"
			return

		else if(!panel_open)
			src.beaker = I
			user.drop_item()
			I.loc = src
			user << "<span class='notice'>You add the beaker to the machine!</span>"
			icon_state = "mixer1b"
			nanomanager.update_uis(src)
			return 1

		else
			user <<"You can't add a beaker to the machine while the panel is open."
			return

/obj/machinery/chem_heater/attack_ai(mob/user as mob)
	src.add_hiddenprint(user)
	return src.attack_hand(user)

/obj/machinery/chem_heater/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/chem_heater/attack_hand(var/mob/user as mob)
	if(stat & BROKEN)
		return

	ui_interact(user)

/obj/machinery/chem_heater/Topic(href, href_list)
	if(..())
		return 0
	if(href_list["toggle_on"])
		on = !on
		. = 1
	if(href_list["adjust_temperature"])
		var/val = href_list["adjust_temperature"]
		if(isnum(val))
			temperature = Clamp(temperature+val, 0, 1000)
		else if(val == "input")
			temperature = Clamp(input("Please input the target temperature", name) as num, 0, 1000)
		else
			return 0
		. = 1
	if(href_list["eject_beaker"])
		eject_beaker()
		. = 0 //updated in eject_beaker() already

/obj/machinery/chem_heater/ui_interact(var/mob/user, ui_key = "main", var/datum/nanoui/ui = null)
	if(user.stat || user.restrained()) return
	var/data[0]
	data["targetTemp"] = temperature
	data["isActive"] = on
	data["isBeakerLoaded"] = beaker ? 1 : 0
	data["currentTemp"] = beaker ? beaker.reagents.chem_temp : null
	data["beakerCurrentVolume"] = beaker ? beaker.reagents.total_volume : null
	data["beakerMaxVolume"] = beaker ? beaker.volume : null
	//copy-pasted from chem dispenser
	var beakerContents[0]
	if(beaker)
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			beakerContents.Add(list(list("name" = R.name, "volume" = R.volume))) // list in a list because Byond merges the first list...
	data["beakerContents"] = beakerContents
	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data)
	if (!ui)
		ui = new(user, src, ui_key, "chem_heater.tmpl", "ChemHeater", 350, 270)
		ui.set_initial_data(data)
		ui.open()
