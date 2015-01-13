#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

datum/reagent/oil
	name = "Oil"
	id = "oil"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
/*

datum/reagent/compost
	name = "Compost"
	id = "compost"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/sewage
	name = "Sewage"
	id = "sewage"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

*/

datum/reagent/stable_plasma
	name = "Stable Plasma"
	id = "stable_plasma"
	description = "Non-flammable plasma locked into a liquid form that cannot ignite or become gaseous/solid."
	reagent_state = LIQUID
	color = "#E71B00"

datum/reagent/poo
	name = "poo"
	id = "poo"
	description = "It's poo."
	reagent_state = LIQUID
	color = "#402000" //rgb: 64, 32 , 0

datum/reagent/poo/on_mob_life(var/mob/living/M)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(0.1*REM)
	holder.remove_reagent(src.id, 0.2)
	..()
	return

datum/reagent/poo/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	src = null
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(method==TOUCH)
			if(H.wear_suit)	H.wear_suit.add_poo()
			if(H.w_uniform)	H.w_uniform.add_poo()
			if(H.shoes)		H.shoes.add_poo()
			if(H.gloves)	H.gloves.add_poo()
			if(H.head)		H.head.add_poo()
		if(method==INGEST)
			if(prob(20))
				H.vomit()
				H.adjustToxLoss(0.1*REM)
				holder.remove_reagent(src.id, 0.2)

datum/reagent/poo/reaction_turf(var/turf/T, var/volume)
	src = null
	if(!istype(T, /turf/space))
		new /obj/effect/decal/cleanable/poo(T)

datum/reagent/urine
	name = "urine"
	id = "urine"
	description = "It's pee."
	reagent_state = LIQUID
	hydration_factor = 10 * REAGENTS_METABOLISM
	color = "#ffff00" //rgb 255, 255, 0

datum/reagent/urine/on_mob_life(var/mob/living/M)
	if(!M) M = holder.my_atom
	M.hydration += hydration_factor*REM
	M.adjustToxLoss(0.1)
	..()
	return

datum/reagent/urine/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	src = null
	if(method==INGEST)
		if(prob(20) && ishuman(M))
			var/mob/living/carbon/human/H = M
			H.vomit()
		M.adjustToxLoss(0.1)
		M.hydration += hydration_factor*REM
		if(prob(20))
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				H.vomit()
			holder.remove_reagent(src.id, 0.2)

datum/reagent/urine/reaction_turf(var/turf/T, var/volume)
	src = null
	if(!istype(T, /turf/space))
		new /obj/effect/decal/cleanable/urine(T)



datum/reagent/iodine
	name = "Iodine"
	id = "iodine"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
/*
datum/reagent/fluorine
	name = "Fluorine"
	id = "fluorine"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
*/ //Already exist


datum/reagent/carpet
	name = "Carpet"
	id = "carpet"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/bromine
	name = "Bromine"
	id = "bromine"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/phenol
	name = "Phenol"
	id = "phenol"
	description = "A slippery solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/ash
	name = "Ash"
	id = "ash"
	description = "A burnt solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

datum/reagent/acetone
	name = "Acetone"
	id = "acetone"
	description = "A solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

/datum/chemical_reaction/acetone
	name = "acetone"
	id = "acetone"
	result = "acetone"
	required_reagents = list("oil" = 1, "fuel" = 1, "oxygen" = 1)
	result_amount = 3

/datum/chemical_reaction/carpet
	name = "carpet"
	id = "carpet"
	result = "carpet"
	required_reagents = list("space_drugs" = 1, "blood" = 1)
	result_amount = 2

/datum/chemical_reaction/oil
	name = "Oil"
	id = "oil"
	result = "oil"
	required_reagents = list("fuel" = 1, "carbon" = 1, "hydrogen" = 1)
	result_amount = 3

/datum/chemical_reaction/phenol
	name = "phenol"
	id = "phenol"
	result = "phenol"
	required_reagents = list("water" = 1, "chlorine" = 1, "oil" = 1)
	result_amount = 3

/datum/chemical_reaction/ash
	name = "Ash"
	id = "ash"
	result = "ash"
	required_reagents = list("oil" = 1)
	result_amount = 1
	required_temp = 480