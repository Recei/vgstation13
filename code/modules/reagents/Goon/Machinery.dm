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
				beaker.reagents.handle_reactions()
				state_change = 1
			else if(beaker.reagents.chem_temp < temperature)
				beaker.reagents.chem_temp = min(beaker.reagents.chem_temp+rate, temperature)
				beaker.reagents.handle_reactions()
				state_change = 1
			beaker.reagents.update_total()
	if(state_change)
		src.updateUsrDialog()

/obj/machinery/chem_heater/proc/eject_beaker()
	if(beaker)
		beaker.loc = get_turf(src)
		beaker.reagents.handle_reactions()
		beaker = null
		icon_state = "mixer0b"
		src.updateUsrDialog()

/obj/machinery/chem_heater/power_change()
	if(powered())
		stat &= ~NOPOWER
	else
		spawn(rand(0, 15))
			stat |= NOPOWER
	src.updateUsrDialog()

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
			src.updateUsrDialog()
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
	user.set_machine(src)

	var/dat = ""
	if(!beaker)
		dat = "Please insert beaker.<BR>"
	else
		var/datum/reagents/R = beaker.reagents
		if(!R.total_volume)
			dat += "<BR><b>Beaker is empty.</b><BR>"
		else
			dat += "<BR><b>Current temperature </b>: [beaker.reagents.chem_temp]<BR>"
			if(!on)
				dat += "<A href='?src=\ref[src];adjust_temperature=1'>Adjust Temperature</A><BR>"
				dat += "<A href='?src=\ref[src];toggle_on=1'>Toggle On</A><BR>"
				dat += "<BR><BR><A href='?src=\ref[src];eject_beaker=1'>Eject beaker</A><BR>"
			else
				dat += "Reagents heating in progress...<BR>"
				dat += "<BR><BR><A href='?src=\ref[src];toggle_on=1'>Toggle Off</A><BR>"

	dat += "<A href='?src=\ref[src];close=1'>Close</A>"

	user << browse("<TITLE>Chemical Heater</TITLE>ChemHeater menu:<BR><BR>[dat]", "window=chem_heater;size=350x200")



/obj/machinery/chem_heater/Topic(href, href_list)
	if(..())
		return 0
	if(href_list["toggle_on"])
		on = !on
		. = 1
	if(href_list["adjust_temperature"])
		var/val = Clamp(input("Please input the target temperature", name) as num, 0, 1000)
		if(isnum(val))
			temperature = Clamp(val, 0, 1000) //WHO THE FUCK THOUGHT THAT TEMPERATURE+VAL IS NORMAL?!
		else
			return 0
		. = 1
	if(href_list["eject_beaker"])
		eject_beaker()
		. = 0 //updated in eject_beaker() already
	if(href_list["close"])
		usr << browse(null, "window=chem_heater")
		usr.unset_machine()
		return

	src.updateUsrDialog()
	return


