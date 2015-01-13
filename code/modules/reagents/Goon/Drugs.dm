#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

datum/reagent/nicotine
	name = "Nicotine"
	id = "nicotine"
	description = "A legal chemical compound used as a drug."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

datum/reagent/nicotine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/smoke_message = pick("You can just feel your lungs dying!", "You feel relaxed.", "You feel calmed.", "You feel the lung cancer forming.", "You feel the money you wasted.", "You feel like a space cowboy.", "You feel rugged.")
	if(prob(5))
		M << smoke_message
	M.AdjustStunned(-1)
	M.adjustHalLoss(-1)
	if(volume > 35)
		M << "You feel like you smoked too much."
		M.adjustToxLoss(1*REM)
	..()
	return

datum/reagent/jenkem
	name = "Jenkem"
	id = "jenkem"
	description = "A bathtub drug made from human excrement."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132

datum/reagent/jenkem/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	M.druggy = max(M.druggy, 10)
	if(M.canmove) step(M, pick(cardinal))
	if(prob(7)) M:emote(pick("twitch","drool","moan","giggle"))
	var/high_message = pick("You wonder why the hell you just ingested that.", "You realize you are high as fuck.", "You feel the color blue.", "You ponder the meaning of red.", "You think deeply on the color green.", "You taste a horrible mixture, and you want to throw up, but you hold it back.")
	if(prob(5))
		M << high_message
	if(prob(25))
		M.adjustToxLoss(1*REM)
		M.adjustBrainLoss(1*REM)
	M.dizziness += 1
	return

datum/reagent/jenkem/reaction_turf(var/turf/T, var/volume)
	src = null
	if(!istype(T, /turf/space))
		new /obj/effect/decal/cleanable/poo(T)

datum/reagent/jenkem/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(method==INGEST)
		if(prob(20) && ishuman(M))
			var/mob/living/carbon/human/H = M
			H.vomit()

/datum/chemical_reaction/jenkem
	name = "Jenkem"
	id = "jenkem"
	result = "jenkem"
	required_reagents = list("poo" = 1, "urine" = 1)
	result_amount = 2
	mix_message = "The mixture ferments into a filthy morass."

datum/reagent/crank
	name = "Crank"
	id = "crank"
	description = "A legal chemical compound used as a drug."
	reagent_state = LIQUID
	color = "#71D8EB" // rgb: 113, 216, 235  BrBa meth color

datum/reagent/crank/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
	if(prob(5))
		M << high_message
	M.AdjustParalysis(-2)
	M.AdjustStunned(-2)
	M.AdjustWeakened(-2)
	if(volume > 20)
		M.adjustBrainLoss(rand(1,10)*REM)
		M.adjustToxLoss(rand(1,10)*REM)
		M.adjustBruteLoss(rand(1,10)*REM)
	..()
	return

/datum/chemical_reaction/crank
	name = "Crank"
	id = "crank"
	result = "crank"
	required_reagents = list("diphenhydramine" = 1, "ammonia" = 1, "lithium" = 1, "sacid" = 1, "fuel" = 1)
	result_amount = 5
	mix_message = "The mixture violently reacts, leaving behind a few crystalline shards."
	required_temp = 390

/datum/reagent/krokodil
	name = "Krokodil"
	id = "krokodil"
	description = "A legal chemical compound used as a drug."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	var/cycle_count = 0
	var/overdosed


/datum/reagent/krokodil/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/high_message = pick("You feel calm.", "You feel collected.", "You feel like you need to relax.")
	M.druggy = max(M.druggy, 15)
	if(prob(5))
		M << high_message
	if(prob(10))
		M.adjustBrainLoss(rand(1,5)*REM)
		M.adjustToxLoss(rand(1,5)*REM)
	if(cycle_count == 10)
		M.adjustBrainLoss(rand(1,10)*REM)
		M.adjustToxLoss(rand(1,10)*REM)
	if(cycle_count == 20)
		M << "Your skin feels loose..."
	if(cycle_count == 50)
		M << "Your skin falls off!"
		M.adjustBruteLoss(rand(10,30)*REM)
		if(ishuman(M))
			var/mob/living/carbon/human/junkie = M
			junkie.ChangeToHusk()
	if(volume > 20)
		overdosed = 1
	if(overdosed)
		cycle_count++
	..()
	return

/datum/chemical_reaction/krokodil
	name = "Krokodil"
	id = "krokodil"
	result = "krokodil"
	required_reagents = list("diphenhydramine" = 1, "morphine" = 1, "cleaner" = 1, "potassium" = 1, "phosphorous" = 1, "fuel" = 1)
	result_amount = 6
	mix_message = "The mixture dries into a pale blue powder."
	required_temp = 380