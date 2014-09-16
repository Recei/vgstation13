
//Not to be confused with /obj/item/weapon/reagent_containers/food/drinks/bottle

/obj/item/weapon/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle0"
	item_state = "atoxinbottle"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30)
	flags = FPRINT | TABLEPASS | OPENCONTAINER
	volume = 30
	g_amt=1000 // Half of a circuit board

	var/icon/bottlec

	on_reagent_change()
		if(reagents.total_volume)
			if (src.icon_state == "bottle0" || src.icon_state == "bottlecolor")
				src.overlays -= bottlec
				src.icon_state = "bottlecolor"
				src.main_reagent = src.reagents.get_master_reagent_reference()
				bottlec = new/icon("icon" = 'icons/obj/chemical.dmi', "icon_state" = "bottlecolormod")
				bottlec.Blend(src.main_reagent:color, ICON_ADD)//, src.main_reagent:color_g, src.main_reagent:color_b)
				src.overlays += bottlec
				src.main_reagent = ""
		else
			src.main_reagent = ""
			src.overlays = null
			icon_state = "bottle0"
	New()
		..()
		if(!icon_state)
			icon_state = "bottle0"

	update_icon()
		overlays.Cut()
		src.overlays += bottlec

		if (!is_open_container())
			var/image/lid = image(icon, src, "lid_bottle")
			overlays += lid

/obj/item/weapon/reagent_containers/glass/bottle/inaprovaline
	name = "inaprovaline bottle"
	desc = "A small bottle. Contains inaprovaline - used to stabilize patients."

	New()
		..()
		reagents.add_reagent("inaprovaline", 30)

/obj/item/weapon/reagent_containers/glass/bottle/kelotane
	name = "Kelotane bottle"
	desc = "A small bottle. Contains Kelotane."
	New()
		..()
		reagents.add_reagent("kelotane", 30)

/obj/item/weapon/reagent_containers/glass/bottle/tricordrazine
	name = "Tricordrazine bottle"
	desc = "A small bottle. Contains Tricordrazine."
	New()
		..()
		reagents.add_reagent("tricordrazine", 30)

/obj/item/weapon/reagent_containers/glass/bottle/spaceacillin
	name = "Spaceacillin bottle"
	desc = "A small bottle. Contains Spaceacillin."
	amount_per_transfer_from_this = 5

	New()
		..()
		reagents.add_reagent("spaceacillin", 30)

/obj/item/weapon/reagent_containers/glass/bottle/dexalin
	name = "Dexalin bottle"
	desc = "A small bottle. Contains Dexalin."
	amount_per_transfer_from_this = 5

	New()
		..()
		reagents.add_reagent("dexalin", 30)

/obj/item/weapon/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins. Do not drink, it is poisonous."

	New()
		..()
		reagents.add_reagent("toxin", 30)

/obj/item/weapon/reagent_containers/glass/bottle/charcoal
	name = "activated charcoal bottle"
	desc = "A small bottle of activated charcoal. Used for treatment of overdoses."

	New()
		..()
		reagents.add_reagent("charcoal", 30)

/obj/item/weapon/reagent_containers/glass/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"

	New()
		..()
		reagents.add_reagent("cyanide", 30)

/obj/item/weapon/reagent_containers/glass/bottle/stoxin
	name = "sleep-toxin bottle"
	desc = "A small bottle of sleep toxins. Just the fumes make you sleepy."

	New()
		..()
		reagents.add_reagent("stoxin", 30)

/obj/item/weapon/reagent_containers/glass/bottle/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A small bottle of Choral Hydrate. Mickey's Favorite!"

	New()
		..()
		reagents.add_reagent("chloralhydrate", 15)		//Intentionally low since it is so strong. Still enough to knock someone out.

/obj/item/weapon/reagent_containers/glass/bottle/antitoxin
	name = "anti-toxin bottle"
	desc = "A small bottle of Anti-toxins. Counters poisons, and repairs damage, a wonder drug."

	New()
		..()
		reagents.add_reagent("anti_toxin", 30)

/obj/item/weapon/reagent_containers/glass/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."

	New()
		..()
		reagents.add_reagent("mutagen", 30)

/obj/item/weapon/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle."

	New()
		..()
		reagents.add_reagent("ammonia", 30)

/obj/item/weapon/reagent_containers/glass/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle."

	New()
		..()
		reagents.add_reagent("diethylamine", 30)

/obj/item/weapon/reagent_containers/glass/bottle/flu_virion
	name = "Flu virion culture bottle"
	desc = "A small bottle. Contains H13N1 flu virion culture in synthblood medium."

	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/flu(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/epiglottis_virion
	name = "Epiglottis virion culture bottle"
	desc = "A small bottle. Contains Epiglottis virion culture in synthblood medium."
	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/voice_change(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/liver_enhance_virion
	name = "Liver enhancement virion culture bottle"
	desc = "A small bottle. Contains liver enhancement virion culture in synthblood medium."
	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/heal(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/hullucigen_virion
	name = "Hullucigen virion culture bottle"
	desc = "A small bottle. Contains hullucigen virion culture in synthblood medium."
	New()
		..()
		var/datum/disease/F = new /datum/disease/advance/hullucigen(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/pierrot_throat
	name = "Pierrot's Throat culture bottle"
	desc = "A small bottle. Contains H0NI<42 virion culture in synthblood medium."
	New()
		..()
		var/datum/disease/F = new /datum/disease/pierrot_throat(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/cold
	name = "Rhinovirus culture bottle"
	desc = "A small bottle. Contains XY-rhinovirus culture in synthblood medium."
	New()
		..()
		var/datum/disease/advance/F = new /datum/disease/advance/cold(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/random
	name = "Random culture bottle"
	desc = "A small bottle. Contains a random disease."
	New()
		..()
		var/datum/disease/advance/F = new(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/retrovirus
	name = "Retrovirus culture bottle"
	desc = "A small bottle. Contains a retrovirus culture in a synthblood medium."
	New()
		..()
		var/datum/disease/F = new /datum/disease/dna_retrovirus(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)


/obj/item/weapon/reagent_containers/glass/bottle/gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS+ culture in synthblood medium."//Or simply - General BullShit
	amount_per_transfer_from_this = 5

	New()
		var/datum/reagents/R = new/datum/reagents(20)
		reagents = R
		R.my_atom = src
		var/datum/disease/F = new /datum/disease/gbs
		var/list/data = list("virus"= F)
		R.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/fake_gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS- culture in synthblood medium."//Or simply - General BullShit
	New()
		..()
		var/datum/disease/F = new /datum/disease/fake_gbs(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)
/*
/obj/item/weapon/reagent_containers/glass/bottle/rhumba_beat
	name = "Rhumba Beat culture bottle"
	desc = "A small bottle. Contains The Rhumba Beat culture in synthblood medium."//Or simply - General BullShit
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle3"
	amount_per_transfer_from_this = 5

	New()
		var/datum/reagents/R = new/datum/reagents(20)
		reagents = R
		R.my_atom = src
		var/datum/disease/F = new /datum/disease/rhumba_beat
		var/list/data = list("virus"= F)
		R.add_reagent("blood", 20, data)
*/

/obj/item/weapon/reagent_containers/glass/bottle/brainrot
	name = "Brainrot culture bottle"
	desc = "A small bottle. Contains Cryptococcus Cosmosis culture in synthblood medium."
	New()
		..()
		var/datum/disease/F = new /datum/disease/brainrot(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/magnitis
	name = "Magnitis culture bottle"
	desc = "A small bottle. Contains a small dosage of Fukkos Miracos."
	New()
		..()
		var/datum/disease/F = new /datum/disease/magnitis(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)


/obj/item/weapon/reagent_containers/glass/bottle/wizarditis
	name = "Wizarditis culture bottle"
	desc = "A small bottle. Contains a sample of Rincewindus Vulgaris."
	New()
		..()
		var/datum/disease/F = new /datum/disease/wizarditis(0)
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent("blood", 20, data)

/obj/item/weapon/reagent_containers/glass/bottle/pacid
	name = "Polytrinic Acid Bottle"
	desc = "A small bottle. Contains a small amount of Polytrinic Acid"
	New()
		..()
		reagents.add_reagent("pacid", 30)

/obj/item/weapon/reagent_containers/glass/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	New()
		..()
		reagents.add_reagent("adminordrazine", 30)

/obj/item/weapon/reagent_containers/glass/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	New()
		..()
		reagents.add_reagent("capsaicin", 30)

/obj/item/weapon/reagent_containers/glass/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	New()
		..()
		reagents.add_reagent("frostoil", 30)