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
	overdose_threshold = 35
	addiction_threshold = 30

datum/reagent/nicotine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/smoke_message = pick("You can just feel your lungs dying!", "You feel relaxed.", "You feel calmed.", "You feel the lung cancer forming.", "You feel the money you wasted.", "You feel like a space cowboy.", "You feel rugged.")
	if(prob(5))
		M << "<span class='notice'>[smoke_message]</span>"
	M.AdjustStunned(-1)
	M.adjustHalLoss(-1)
	..()
	return

datum/reagent/nicotine/overdose_process(var/mob/living/M as mob)
	if(prob(20))
		M << "You feel like you smoked too much."
	M.adjustToxLoss(1*REM)
	M.adjustOxyLoss(1*REM)
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
		M << "<span class='notice'>[high_message]</span>"
	if(prob(25))
		M.adjustToxLoss(1*REM)
		M.adjustBrainLoss(1*REM)
	M.Dizzy(1)
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
	description = "A legal chemical compound used as a drug. Gotta go fast, huh?"
	reagent_state = LIQUID
	color = "#71D8EB" // rgb: 113, 216, 235  BrBa meth color
	overdose_threshold = 20
	addiction_threshold = 10

datum/reagent/crank/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
	if(prob(5))
		M << "<span class='notice'>[high_message]</span>"
	M.AdjustParalysis(-2)
	M.AdjustStunned(-2)
	M.AdjustWeakened(-2)
	..()
	return

/datum/reagent/crank/overdose_process(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,10)*REM)
	M.adjustToxLoss(rand(1,10)*REM)
	M.adjustBruteLoss(rand(1,10)*REM)
	..()
	return

/datum/reagent/crank/addiction_act_stage1(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,10)*REM)
	..()
	return
/datum/reagent/crank/addiction_act_stage2(var/mob/living/M as mob)
	M.adjustToxLoss(rand(1,10)*REM)
	..()
	return
/datum/reagent/crank/addiction_act_stage3(var/mob/living/M as mob)
	M.adjustBruteLoss(rand(1,10)*REM)
	..()
	return
/datum/reagent/crank/addiction_act_stage4(var/mob/living/M as mob)
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

/datum/chemical_reaction/crank/on_reaction(var/datum/reagents/holder, var/created_volume)
	send_admin_alert(holder, reaction_name="crank mixing")
	var/datum/effect/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/20, 1), holder.my_atom, 0, 0)
	e.holder_damage(holder.my_atom)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat!=DEAD)
			e.amount *= 0.5
	e.start()
	return

/datum/reagent/krokodil
	name = "Krokodil"
	id = "krokodil"
	description = "A legal chemical compound used as a drug.Hail to the kotowasiy."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 20
	addiction_threshold = 15


/datum/reagent/krokodil/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	var/high_message = pick("You feel calm.", "You feel collected.", "You feel like you need to relax.")
	M.druggy = max(M.druggy, 15)
	if(prob(5))
		M << "<span class='notice'>[high_message]</span>"
	..()
	return

/datum/reagent/krokodil/overdose_process(var/mob/living/M as mob)
	if(prob(10))
		M.adjustBrainLoss(rand(1,5)*REM)
		M.adjustToxLoss(rand(1,5)*REM)
	..()
	return

/datum/reagent/krokodil/addiction_act_stage1(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,5)*REM)
	M.adjustToxLoss(rand(1,5)*REM)
	..()
	return

/datum/reagent/krokodil/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(25))
		M << "<span class='danger'>Your skin feels loose...</span>"
	..()
	return

/datum/reagent/krokodil/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(25))
		M << "<span class='danger'>Your skin starts to peel away...</span>"
	M.adjustBruteLoss(3*REM)
	..()
	return

/datum/reagent/krokodil/addiction_act_stage4(var/mob/living/carbon/human/M as mob)
	if(!(M_HUSK in M.mutations))
		M << "<span class='userdanger'>Your skin falls off! Holy shit!</span>"
		M.adjustBruteLoss(rand(50,80)*REM) // holy shit your skin just FELL THE FUCK OFF
		if(ishuman(M))
			var/mob/living/carbon/human/junkie = M
			junkie.ChangeToHusk()
	else
		M.adjustBruteLoss(5*REM)
	..()
	return

/datum/chemical_reaction/krokodil
	name = "Krokodil"
	id = "krokodil"
	result = "krokodil"
	required_reagents = list("diphenhydramine" = 1, "morphine" = 1, "cleaner" = 1, "potassium" = 1, "phosphorus" = 1, "fuel" = 1)
	result_amount = 6
	mix_message = "The mixture dries into a pale blue powder."
	required_temp = 380


/datum/reagent/methamphetamine
	name = "Methampetamine"
	id = "methamphetamine"
	description = "A rather powerful drug derived from 'drines."
	reagent_state = LIQUID
	color = "#000067" // rgb: 0, 0, 103
	overdose_threshold = 20
	addiction_threshold = 10

/datum/reagent/methamphetamine/on_mob_life(var/mob/living/carbon/M as mob)
	if(!M) M = holder.my_atom
	M.status_flags |= GOTTAGOFAST
	M.AdjustParalysis(-3)
	M.AdjustStunned(-3)
	M.AdjustWeakened(-3)
	M.hallucination += 5
	M.jitteriness = max(M.jitteriness-5,0)
	if(prob(90)) M.adjustBrainLoss(1*REM)
	holder.remove_reagent(src.id, REAGENTS_METABOLISM)
	if(isturf(M.loc) && !istype(M.loc, /turf/space))
		if(M.canmove)
			if(prob(10)) step(M, pick(cardinal))
	..()
	return

/datum/reagent/methamphetamine/addiction_act_stage1(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,5)*REM)
	..()
	return
/datum/reagent/methamphetamine/addiction_act_stage2(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,5)*REM)
	M.hallucination += rand(1,10)*REM
	..()
	return
/datum/reagent/methamphetamine/addiction_act_stage3(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,10)*REM)
	M.hallucination += rand(5,15)*REM
	..()
	return
/datum/reagent/methamphetamine/addiction_act_stage4(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,10)*REM)
	M.adjustToxLoss(rand(1,10)*REM)
	M.hallucination += rand(5,15)*REM
	..()
	return

/datum/chemical_reaction/methamphetamine
	name = "Methampetamine"
	id = "methamphetamine"
	result = "methamphetamine"
	required_reagents = list("ephedrine" = 1, "hydrogen" = 1, "phosphorous" = 1, "iodine" = 1)
	result_amount = 4
	mix_message = "The mixture violently reacts, leaving behind a few crystalline shards."
	required_temp = 374


/datum/reagent/bathsalts // not even stolen from goon tho
	name = "Bath salts"
	id = "bathsalts"
	description = "A horrible drug from the depths of the space slums. Practice caution when consuming!"
	color = "#FFFFFF" // rgb: 255, 255, 255
	overdose_threshold = 20
	addiction_threshold = 10

/datum/reagent/bathsalts/on_mob_life(var/mob/living/M as mob)
	M.AdjustParalysis(-4)
	M.AdjustStunned(-4)
	M.AdjustWeakened(-4)
	M.Dizzy(10)
	M.Jitter(10)
	M.hallucination += 10
	holder.remove_reagent(src.id, REAGENTS_METABOLISM)
	if(prob(80)) M.adjustBrainLoss(2*REM)
	if(isturf(M.loc) && !istype(M.loc, /turf/space))
		if(M.canmove)
			if(prob(20)) step(M, pick(cardinal))
	..()
	return

datum/reagent/bathsalts/overdose_process(var/mob/living/M as mob)
	M.adjustToxLoss(1*REM)
	for(var/mob/living/target in range(1,get_turf(M)))
		if(prob(20) && target != M)
			playsound(get_turf(M), pick(punch_sound), 80, 1)
			M.visible_message("\red <B>[M] has punched [target]!</B>", 1)
			target.adjustBruteLoss(rand(1,4))
	..()
	return

/datum/reagent/bathsalts/addiction_act_stage1(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,5)*REM)
	..()
	return
/datum/reagent/bathsalts/addiction_act_stage2(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,5)*REM)
	M.hallucination += rand(1,10)*REM
	..()
	return
/datum/reagent/bathsalts/addiction_act_stage3(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,10)*REM)
	M.hallucination += rand(5,15)*REM
	..()
	return
/datum/reagent/bathsalts/addiction_act_stage4(var/mob/living/M as mob)
	M.adjustBrainLoss(rand(1,10)*REM)
	M.adjustToxLoss(rand(1,10)*REM)
	M.hallucination += rand(5,15)*REM
	..()
	return


/datum/chemical_reaction/bathsalts
	name = "Bath salts"
	id = "bathsalts"
	result = "bathsalts"
	required_reagents = list("????" = 1, "mercury" = 1, "cleaner" = 1, "enzyme" = 1)
	result_amount = 4
	mix_message = "The mixture violently reacts, leaving behind a few crystalline shards."
	required_temp = 374
