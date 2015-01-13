#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

/datum/reagent/clf3
	name = "Chlorine Trifluoride"
	id = "clf3"
	description = "Makes a temporary 3x3 fireball when it comes into existence, so be careful when mixing. ClF3 applied to a surface burns things that wouldn't otherwise burn, sometimes through the very floors of the station and exposing it to the vacuum of space."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132


/datum/reagent/clf3/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	..()
	return

/datum/chemical_reaction/clf3
	name = "Chlorine Trifluoride"
	id = "clf3"
	result = "clf3"
	required_reagents = list("chlorine" = 1, "fluorine" = 3)
	result_amount = 4
	required_temp = 424

/datum/chemical_reaction/clf3/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/turf/simulated/T = get_turf(holder.my_atom)
	for(var/turf/simulated/turf in orange(1,T))
		var/datum/gas_mixture/napalm = new
		var/datum/gas/volatile_fuel/fuel = new
		fuel.moles = created_volume
		napalm.trace_gases += fuel

		napalm.temperature = 400+T0C
		napalm.update_values()

		turf.assume_air(napalm)
		spawn (0) turf.hotspot_expose(700, 400,surfaces=1)
	return

/datum/reagent/clf3/reaction_turf(var/turf/simulated/T, var/volume)
	if(istype(T, /turf/simulated/floor/))
		var/turf/simulated/floor/F = T
		if(prob(66))
			F.make_plating()
		if(prob(11))
			F.ChangeTurf(/turf/space)
	return

/datum/reagent/clf3/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return
	if(method == TOUCH)
		M.adjust_fire_stacks(20)
		return

/datum/reagent/sorium
	name = "Sorium"
	id = "sorium"
	description = "Sends everything flying from the detonation point."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

/datum/chemical_reaction/sorium
	name = "Sorium"
	id = "sorium"
	result = "sorium"
	required_reagents = list("mercury" = 1, "oxygen" = 1, "nitrogen" = 1, "carbon" = 1)
	result_amount = 4
	required_temp = 474

/datum/reagent/sorium/reaction_turf(var/turf/simulated/T, var/volume)
	if(istype(T, /turf/simulated/floor/))
		goonchem_vortex(T, 1, 5, 3)
		return

/datum/reagent/sorium/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return
	if(method == TOUCH)
		var/turf/simulated/T = get_turf(M)
		goonchem_vortex(T, 1, 5, 3)
		return

/datum/chemical_reaction/sorium/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/turf/simulated/T = get_turf(holder.my_atom)
	goonchem_vortex(T, 1, 5, 6)
	return

/datum/reagent/liquid_dark_matter
	name = "Liquid Dark Matter"
	id = "liquid_dark_matter"
	description = "Sucks everything into the detonation point."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

/datum/chemical_reaction/liquid_dark_matter
	name = "Liquid Dark Matter"
	id = "liquid_dark_matter"
	result = "liquid_dark_matter"
	required_reagents = list("stable_plasma" = 1, "radium" = 1, "carbon" = 1)
	result_amount = 3
	required_temp = 474

/datum/reagent/liquid_dark_matter/reaction_turf(var/turf/simulated/T, var/volume)
	if(istype(T, /turf/simulated/floor/))
		goonchem_vortex(T, 0, 5, 3)
		return

/datum/reagent/liquid_dark_matter/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return
	if(method == TOUCH)
		var/turf/simulated/T = get_turf(M)
		goonchem_vortex(T, 0, 5, 3)
		return

/datum/chemical_reaction/liquid_dark_matter/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/turf/simulated/T = get_turf(holder.my_atom)
	goonchem_vortex(T, 0, 5, 6)
	return

proc/goonchem_vortex(var/turf/simulated/T, var/setting_type, var/range, var/pull_times)
	for(var/atom/movable/X in orange(range, T))
		if(istype(X, /atom/movable))
			if((X))
				if(setting_type)
					for(var/i = 0, i < pull_times, i++)
						step_towards(X,T)
				else
					X.throw_at(T)