/datum/reagent/questionmark // food poisoning
	name = "????"
	id = "????"
	description = "????"
	reagent_state = LIQUID
	color = "#CF3600" // rgb: 207, 54, 0
	custom_metabolism = 0.2

datum/reagent/questionmark/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(1*REM)
	..()
	return

datum/reagent/questionmark/reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return
	if(method == INGEST)
		M.Weaken(2)
		M << "<span class = 'danger'>Ugh! Eating that was a terrible idea!</span>"

datum/reagent/egg
	name = "Egg"
	id = "egg"
	description = "A runny and viscous mixture of clear and yellow fluids."
	reagent_state = LIQUID
	color = "#F0C814"

datum/reagent/egg/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(5))
		M.emote("fart")
	..()
	return

datum/reagent/triple_citrus
	name = "Triple Citrus"
	id = "triple_citrus"
	description = "A refreshing mixed drink of orange, lemon and lime juice."
	reagent_state = LIQUID
	color = "#23A046"

/datum/chemical_reaction/triple_citrus
	name = "triple_citrus"
	id = "triple_citrus"
	result = "triple_citrus"
	required_reagents = list("lemonjuice" = 1, "limejuice" = 1, "orangejuice" = 1)
	result_amount = 3
	mix_message = "The citrus juices begin to blend together."

datum/reagent/triple_citrus/reaction_mob(var/mob/living/carbon/M as mob, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living/carbon))
		return
	if(method == INGEST)
		M.adjustToxLoss(-rand(1,2))

datum/reagent/corn_starch
	name = "Corn Starch"
	id = "corn_starch"
	description = "The powdered starch of maize, derived from the kernel's endosperm. Used as a thickener for gravies and puddings."
	reagent_state = LIQUID
	color = "#C8A5DC"

/datum/chemical_reaction/corn_syrup
	name = "corn_syrup"
	id = "corn_syrup"
	result = "corn_syrup"
	required_reagents = list("corn_starch" = 1, "sacid" = 1)
	result_amount = 2
	required_temp = 374
	mix_message = "The mixture forms a viscous, clear fluid!"

datum/reagent/corn_syrup
	name = "Corn Syrup"
	id = "corn_syrup"
	description = "A sweet syrup derived from corn starch that has had its starches converted into maltose and other sugars."
	reagent_state = LIQUID
	color = "#C8A5DC"

datum/reagent/corn_syrup/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.reagents.add_reagent("sugar", 1.2)
	..()
	return

/datum/chemical_reaction/vhfcs
	name = "vhfcs"
	id = "vhfcs"
	result = "vhfcs"
	required_reagents = list("corn_syrup" = 1)
	required_catalysts = list("enzyme" = 1)
	result_amount = 1
	mix_message = "The mixture emits a sickly-sweet smell."

datum/reagent/vhfcs
	name = "Very-high-fructose corn syrup"
	id = "vhfcs"
	description = "An incredibly sweet syrup, created from corn syrup treated with enzymes to convert its sugars into fructose."
	reagent_state = LIQUID
	color = "#C8A5DC"

datum/reagent/vhfcs/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.reagents.add_reagent("sugar", 2.4)
	..()
	return


/datum/chemical_reaction/cola
	name = "cola"
	id = "cola"
	result = "cola"
	required_reagents = list("carbon" = 1, "oxygen" = 1, "water" = 1, "sugar" = 1)
	result_amount = 4
	mix_message = "The mixture begins to fizz."

/datum/reagent/honey
	name = "Honey"
	id = "honey"
	description = "A sweet substance produced by bees through partial digestion. Bee barf."
	reagent_state = LIQUID
	color = "#CFCF1F"

datum/reagent/honey/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.reagents.add_reagent("sugar", 0.8)
	..()
	return

datum/reagent/honey/reaction_turf(var/turf/T, var/volume)
	src = null
	if(volume >= 5)
		new /obj/item/weapon/reagent_containers/food/snacks/honeycomb(T)
		return

/datum/reagent/chocolate
	name = "Chocolate"
	id = "chocolate"
	description = "Chocolate is a delightful product derived from the seeds of the theobroma cacao tree."
	reagent_state = LIQUID
	color = "#2E2418"

datum/reagent/chocolate/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.reagents.add_reagent("sugar", 0.8)
	..()
	return

/datum/reagent/mugwort
	name = "Mugwort"
	id = "mugwort"
	description = "A rather bitter herb once thought to hold magical protective properties."
	reagent_state = LIQUID
	color = "#21170E"

datum/reagent/mugwort/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(istype(M, /mob/living/carbon/human) && M.mind)
		if(M.mind.special_role == "Wizard")
			M.adjustToxLoss(-1*REM)
			M.adjustOxyLoss(-1*REM)
			M.adjustBruteLoss(-1*REM)
			M.adjustFireLoss(-1*REM)
	..()
	return

/datum/reagent/porktonium
	name = "Porktonium"
	id = "porktonium"
	description = "A highly-radioactive pork byproduct first discovered in hotdogs."
	reagent_state = LIQUID
	color = "#AB5D5D"
	custom_metabolism = 0.2
	overdose_threshold = 125

datum/reagent/porktonium/overdose_process(var/mob/living/M as mob)
	if(volume > 125)
		if(prob(8))
			M.reagents.add_reagent("cyanide", 10)
			M.reagents.add_reagent("radium", 15)
	..()
	return

/datum/reagent/fungus
	name = "Space fungus"
	id = "fungus"
	description = "Scrapings of some unknown fungus found growing on the station walls."
	reagent_state = LIQUID
	color = "#C87D28"

datum/reagent/fungus/reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return
	if(method == INGEST)
		M << "<span class = 'danger'>Yuck!</span>"

/datum/reagent/chicken_soup
	name = "Chicken soup"
	id = "chicken_soup"
	description = "An old household remedy for mild illnesses."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	reagent_state = LIQUID
	color = "#B4B400"

/datum/reagent/chicken_soup/on_mob_life(var/mob/living/M as mob)
	if(!holder) return
	M.nutrition += nutriment_factor
	if (M.bodytemperature < 310)//310 is the normal bodytemp. 310.055
		M.bodytemperature = min(310, M.bodytemperature + (10 * TEMPERATURE_DAMAGE_COEFFICIENT))
	..()
	return

/datum/reagent/msg
	name = "Monosodium glutamate"
	id = "msg"
	description = "Monosodium Glutamate is a sodium salt known chiefly for its use as a controversial flavor enhancer."
	reagent_state = LIQUID
	color = "#F5F5F5"

datum/reagent/msg/reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return
	if(method == INGEST)
		M << "<span class = 'notice'>That tasted amazing!</span>"


/datum/reagent/msg/on_mob_life(var/mob/living/M as mob)
	if(prob(1))
		M.Stun(rand(4,10))
		M << "<span class='warning'>A horrible migraine overpowers you.</span>"
	..()
	return


/datum/reagent/discount
	name = "Discount Dan's Special Sauce"
	id = "discount"
	description = "You can almost feel your liver failing, just by looking at it."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/discount/on_mob_life(var/mob/living/M as mob)
	if(!holder) return
	if(!M) M = holder.my_atom
	if(!data) data = 1
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		switch(volume)
			if(1 to 20)
				if(prob(5))
					H << "<span class='warning'>You don't feel very good..</span>"
					holder.remove_reagent(src.id, 0.1 * REAGENTS_METABOLISM)
			if(20 to 35)
				if(prob(10))
					H << "<span class='warning'>You REALLY don't feel very good..</span>"
				if(prob(5))
					H.adjustToxLoss(0.1)
					H.visible_message("[H] groans.")
					holder.remove_reagent(src.id, 0.3 * REAGENTS_METABOLISM)
			if(35 to INFINITY)
				if(prob(10))
					H << "<span class='warning'>Your stomach grumbles unsettlingly..</span>"
				if(prob(5))
					H << "<span class='warning'>Something feels wrong with your body..</span>"
					var/datum/organ/internal/liver/L = H.internal_organs_by_name["liver"]
					if (istype(L))
						L.take_damage(0.1, 1)
					H.adjustToxLoss(0.13)
					holder.remove_reagent(src.id, 0.5 * REAGENTS_METABOLISM)
			else
				return

/datum/reagent/fake_cheese
	name = "Cheese substitute"
	id = "fake_cheese"
	description = "A cheese-like substance derived loosely from actual cheese."
	reagent_state = LIQUID
	color = "#B2B139"

/datum/reagent/irradiatedbeans
	name = "Irradiated Beans"
	id = "irradiatedbeans"
	description = "You can almost taste the lead sheet behind it!"
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/toxicwaste
	name = "Toxic Waste"
	id = "toxicwaste"
	description = "Yum!"
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/refriedbeans
	name = "Re-Fried Beans"
	id = "refriedbeans"
	description = "A dish made of mashed beans cooked with lard."
	reagent_state = LIQUID
	color = "#684435" // rgb: 255,255,255 //to-do

/datum/reagent/refriedbeans/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(8))
		M.emote("fart")
	..()
	return

/datum/reagent/mutatedbeans
	name = "Mutated Beans"
	id = "mutatedbeans"
	description = "Mutated flavor."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/beff
	name = "Beff"
	id = "beff"
	description = "What's beff? Find out!"
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/horsemeat
	name = "Horse Meat"
	id = "horsemeat"
	description = "Tastes excellent in lasagna."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/moonrocks
	name = "Moon Rocks"
	id = "moonrocks"
	description = "We don't know much about it, but we damn well know that it hates the human skeleton."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/offcolorcheese
	name = "Off-Color Cheese"
	id = "offcolorcheese"
	description = "American Cheese."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/bonemarrow
	name = "Bone Marrow"
	id = "bonemarrow"
	description = "Looks like a skeleton got stuck in the production line."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/greenramen
	name = "Greenish Ramen Noodles"
	id = "greenramen"
	description = "That green isn't organic."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/glowingramen
	name = "Glowing Ramen Noodles"
	id = "glowingramen"
	description = "That glow 'aint healthy."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/deepfriedramen
	name = "Deep Fried Ramen Noodles"
	id = "deepfriedramen"
	description = "Ramen, deep fried."
	reagent_state = LIQUID
	color = "#6F884F" // rgb: 255,255,255 //to-do

/datum/reagent/peptobismol
	name = "Peptobismol"
	id = "peptobismol"
	description = "Jesus juice." //You're welcome, guy in the thread that rolled a 69.
	reagent_state = LIQUID
	color = "#C8A5DC" // rgb: 200, 165, 220

/datum/reagent/peptobismol/on_mob_life(var/mob/living/M as mob)
	if(!holder) return
	if(!M) M = holder.my_atom
	M.drowsyness = max(M.drowsyness-2*REM, 0)
	if(holder.has_reagent("discount"))
		holder.remove_reagent("discount", 2*REM)
	M.hallucination = max(0, M.hallucination - 5*REM)
	M.adjustToxLoss(-2*REM)
	..()
	return