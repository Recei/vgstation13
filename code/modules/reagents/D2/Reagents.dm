// Right now has no use, will rewrite later - Smet19
		emetic
			name = "Emetic"
			id = "emetic"
			description = "A vomit inducing chemical."
			reagent_state = LIQUID
			color_r = 131
			color_g = 173
			color_b = 80
			melting_temp = 255
			boiling_temp = 355
			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				if(prob(5))
					M:emote("vomit")
				..()
				return

		polyadrenalobin //this is the only poly that works so i'm keeping this, everything else is broken
			name = "Polyadrenalobin"
			id = "polyadrenalobin"
			description = "Polyadrenalobin is designed to be a stimulant, it can aid in the revival of a patient who has died or is near death."
			medical = 1
			reagent_state = LIQUID
			color_r = 189
			color_g = 4
			color_b = 92
			medical = 1
			on_mob_life(var/mob/M)
				if(!M) M = holder.my_atom
				if(istype(M, /mob/living/carbon/human))
					var/mob/living/carbon/human/H = M
					if(H.brain_op_stage == 4.0)
						return
					for(var/A in H.organs)
						var/datum/organ/external/affecting = null
						if(!H.organs[A])    continue
						affecting = H.organs[A]
						if(!istype(affecting, /datum/organ/external))    continue
						affecting.heal_damage(1000, 1000)
					sleep(10)
					if(M.oxyloss > 0)
						M.oxyloss--
					if(M.toxloss > 50)
						M.toxloss--
					if(M.fireloss > 50)
						M.fireloss--
					if(M.bruteloss > 50)
						M.bruteloss--
					if(M.cloneloss > 50)
						M.cloneloss--
				//	if(M.cloneloss > 1)
				//		M.blood_clot--
				//	if(M.blood < 175)
				//		M.blood++
				//	M.oxyloss--
				//	M.arrhythmia = 0
				//	M.thrombosis = 0
				//	M.heartrate = 80
					M.stat = 1
					M:bleeding--
					M:brainloss += 0.1
				holder.remove_reagent(src.id, 2)

datum/reagent/synaptizine //MODIFY SYNAPTIZINE TO THIS
	name = "Synaptizine"
	id = "synaptizine"
	description = "Synaptizine is used to treat neuroleptic shock. Can be used to help remove disabling symptoms such as paralysis."
	reagent_state = LIQUID
	color = "#f20d9c" // rgb: 200, 165, 220
	custom_metabolism = 0.01

datum/reagent/synaptizine/on_mob_life(var/mob/living/M as mob)
	if(!holder) return
	if(!M) M = holder.my_atom
	if(!data) data = 1
	M.traumatic_shock -= 40
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.shock_stage -= 4
	if(holder.has_reagent("mindbreaker"))
		holder.remove_reagent("mindbreaker", 5)
	data++
	switch(data)
		if(1 to 29)
			M.drowsyness = max(M.drowsyness-5, 0)
			M.AdjustParalysis(-3)
			M.AdjustStunned(-3)
			M.AdjustWeakened(-3)
			if(prob(15))	M.adjustToxLoss(1)
		if (30 to 49)
			M.drowsyness = max(M.drowsyness-5, 0)
			M.AdjustParalysis(-4)
			M.AdjustStunned(-4)
			M.AdjustWeakened(-4)
			if(prob(60))	M.adjustToxLoss(1)
			M.jitteriness = max(M.jitteriness+3, 30)
			if(M.sleeping) M.sleeping = 0
			if(prob(1)) M.emote(pick("twitch","blink_r","shiver"))
		if (50 to 69) //slowly entering overdose levels
			M.drowsyness = max(M.drowsyness-15, 0)
			M.AdjustParalysis(-6)
			M.AdjustStunned(-6)
			M.AdjustWeakened(-6)
			M.jitteriness = max(M.jitteriness+5, 60)
			if(M.sleeping) M:sleeping = 0
			if(prob(60))	M.adjustToxLoss(2)
			if(prob(3)) M.emote(pick("twitch","blink_r","shiver"))
			if(prob(5))
				M.brainloss++
				M << "\red You feel a strange burning in your head."
		if (70 to 99) //CRASH
			var/findingoriginalvarnamesishardguys = 0
			if (!findingoriginalvarnamesishardguys)
				M << "\red You hallucinate and find yourself falling down some stairs. You seem unable to stop falling."
				findingoriginalvarnamesishardguys = 1
			M.sleeping += 1
			M.adjustToxLoss(4)
			M.adjustBruteLoss(0.1)
			M.stunned++
			M.paralysis++
		if (100 to INFINITY) //crashed harder than a jet into world trade center
			M.sleeping += 1
			M.adjustToxLoss(4)
			M.adjustBruteLoss(0.1)
			M.stunned++
			M.paralysis++
			if (prob(1) && prob(1))
				M << "\blue You are unable to handle the energy inside you and burst into treats."
				new /obj/item/weapon/reagent_containers/food/snacks/candy(get_turt(M))
				M.gib()
	..()
	return
