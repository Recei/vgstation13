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
	addiction_threshold = 20 //HueHueHueHueHue --Smet19

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

/datum/reagent/stabilizer
	name = "Chemical Stabilizer"
	id = "stabilizer"
	description = "A chemical, that in contact with highly explosive materials, stabilizes them and dissolves into harmless gases."
	reagent_state = LIQUID
	color = "#00FF00"

/datum/chemical_reaction/stabilizer
	name = "Chemical Stabilizer"
	id = "stabilizer"
	result = "stabilizer"
	required_reagents = list("iron" = 1, "oxygen" = 1, "hydrogen" = 1)
	result_amount = 3

datum/reagent/colorful_reagent
	name = "Colorful Reagent"
	id = "colorful_reagent"
	description = "A solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220
	var/list/potential_colors = list("#FF0000","#0000FF","#008000","#FFFF00")

/datum/chemical_reaction/colorful_reagent
	name = "colorful_reagent"
	id = "colorful_reagent"
	result = "colorful_reagent"
	required_reagents = list("stable_plasma" = 1, "radium" = 1, "space_drugs" = 1, "cryoxadone" = 1, "triple_citrus" = 1)
	result_amount = 5

datum/reagent/colorful_reagent/reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
	if(method==INGEST)
		if(M && ishuman(M))
			var/mob/living/carbon/human/H = M
			H.species.blood_color = pick(potential_colors)
	if(method == TOUCH)
		if(M && isliving(M))
			M.color = pick(potential_colors)
	..()
	return
datum/reagent/colorful_reagent/reaction_obj(var/obj/O, var/volume)
	if(O)
		O.color = pick(potential_colors)
	..()
	return
datum/reagent/colorful_reagent/reaction_turf(var/turf/T, var/volume)
	if(T)
		T.color = pick(potential_colors)
	..()
	return


datum/reagent/triple_citrus
	name = "Triple Citrus"
	id = "triple_citrus"
	description = "A solution."
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

/datum/chemical_reaction/triple_citrus
	name = "triple_citrus"
	id = "triple_citrus"
	result = "triple_citrus"
	required_reagents = list("lemonjuice" = 1, "limejuice" = 1, "orangejuice" = 1)
	result_amount = 5

datum/reagent/emetic
	name = "Emetic"
	id = "emetic"
	description = "A vomit inducing chemical."
	reagent_state = LIQUID
	color = "#83AD50"

datum/reagent/emetic/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(5))
			H.emote("vomit")
	..()
	return


/datum/chemical_reaction/emetic
	name = "emetic"
	id = "emetic"
	result = "emetic"
	required_reagents = list("vomit" = 1, "limejuice" = 1, "orangejuice" = 1)
	result_amount = 3

/datum/reagent/potash
	name = "Potash"
	id = "potash"
	description = "A salt commonly used as fertilizer."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

/datum/chemical_reaction/potash
	name = "potash"
	id = "potash"
	result = "potash"
	required_reagents = list("sacid" = 1, "chlorine" = 1, "potassium" = 1)

/datum/reagent/saltpetre
	name = "Saltpetre"
	id = "saltpetre"
	description = "A salt commonly used as fertilizer."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

/datum/chemical_reaction/saltpetre
	name = "saltpetre"
	id = "saltpetre"
	result = "saltpetre"
	required_reagents = list("potash" = 1, "poo" = 1, "urine" = 1)
	result_amount = 3