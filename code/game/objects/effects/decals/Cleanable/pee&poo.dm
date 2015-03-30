/obj/effect/decal/cleanable/poo
	name = "poo"
	desc = "It's a poo stain..."
	gender = PLURAL
	density = 0
	anchored = 1
	layer = 2
	icon = 'icons/effects/pooeffect.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7", "floor8")
	var/list/viruses = list()
	blood_DNA = list()
	var/list/datum/disease2/disease/virus2 = list()
	var/amount = 5

/obj/effect/decal/cleanable/poo/cultify()
	return

/obj/effect/decal/cleanable/poo/New()
	..()
	if(src.type == /obj/effect/decal/cleanable/poo)
		if(src.loc && isturf(src.loc))
			for(var/obj/effect/decal/cleanable/poo/P in src.loc)
				if(P != src)
					src.amount += P.amount
					if (P.blood_DNA)
						blood_DNA |= P.blood_DNA.Copy()
					del(P)
	spawn(400)
		src.dry()

/obj/effect/decal/cleanable/poo/Destroy()
	for(var/datum/disease/D in viruses)
		D.cure(0)
		D.holder = null
	..()

/obj/effect/decal/cleanable/poo/proc/dry()
	name = "dried [src.name]"
	desc = "It's dry and crusty. Someone is not doing their job."
	color = adjust_brightness(color, -50)
	amount = 0


/obj/effect/decal/cleanable/poo/Crossed(mob/living/carbon/M)
	if (!istype(M))
		return
	if(amount < 1)
		return

	if(ishuman(M))
		var/mob/living/carbon/human/perp = M
		if(perp.shoes)
			perp.shoes:track_poo = max(amount,perp.shoes:track_poo)
			perp.shoes.add_poo()                //Adding poo shoes
			if(!perp.shoes.poo_overlay)
				perp.shoes.generate_poo_overlay()
			if(!perp.shoes.blood_DNA)
				perp.shoes.blood_DNA = list()
			perp.shoes.overlays += perp.shoes.poo_overlay
			perp.shoes.blood_DNA |= blood_DNA.Copy()
			perp.update_inv_shoes(1)
			if(istype(perp.shoes, /obj/item/clothing/shoes/galoshes))
				return
		else
			perp.track_poo = max(amount,perp.track_poo)                                //Or feet
			if(!perp.feet_blood_DNA)
				perp.feet_blood_DNA = list()
			perp.feet_blood_DNA |= blood_DNA.Copy()

		amount--

	if(M.m_intent == "walk")
		return

	M.pulling = null
	M << "\blue You slipped on the wet poo stain!"
//	M.achievement_give("Oh Shit!", 68)
	playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
	M.stunned = 6
	M.weakened = 5

/obj/effect/decal/cleanable/poo/proc/streak(var/list/directions)
	spawn (0)
		var/direction = pick(directions)
		for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
			sleep(3)
			if (i > 0)
				var/obj/effect/decal/cleanable/poo/p = new /obj/effect/decal/cleanable/poo(src.loc)
				p.update_icon()
				for(var/datum/disease/D in src.viruses)
					var/datum/disease/ND = D.Copy(1)
					p.viruses += ND
					ND.holder = p

			if (step_to(src, get_step(src, direction), 0))
				break



/obj/effect/decal/cleanable/poo/drip
	name = "drips of poo"
	desc = "It's brown."
	icon_state = "drip1"
	random_icon_states = list("drip1", "drip2", "drip3", "drip4", "drip5")


/obj/item/weapon/reagent_containers/food/snacks/poo // Dis is not a effect but whatever
	name = "poo"
	desc = "It's a poo..."
	icon = 'icons/obj/poop.dmi'
	icon_state = "poop2"
	item_state = "poop"
	var/list/random_icon_states = list("poop1", "poop2", "poop3", "poop4", "poop5", "poop6", "poop7")
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/poo/New()
	..()
	reagents.add_reagent("poo", 10)

/obj/item/weapon/reagent_containers/food/snacks/poo/proc/poo_splat(atom/target)
	if(reagents.total_volume)
		if(ismob(target))
			src.reagents.reaction(target, TOUCH)
		if(isturf(target))
			src.reagents.reaction(get_turf(target))
		if(isobj(target))
			src.reagents.reaction(target, TOUCH)
	spawn(5) src.reagents.clear_reagents()
	playsound(src.loc, "squish.ogg", 40, 1)
	del(src)

/obj/item/weapon/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom)
	..()
	poo_splat(hit_atom)

/obj/effect/decal/cleanable/urine
	name = "Urine puddle"
	desc = "Someone couldn't hold it.."
	gender = PLURAL
	density = 0
	anchored = 1
	layer = 2
	icon = 'icons/effects/pooeffect.dmi'
	icon_state = "pee1"
	random_icon_states = list("pee1", "pee2", "pee3")
	var/list/viruses = list()
	blood_DNA = list()
	var/list/datum/disease2/disease/virus2 = list()
	var/amount = 5

/obj/effect/decal/cleanable/urine/New()
	..()
	update_icon()
	if(src.loc && isturf(src.loc))
		for(var/obj/effect/decal/cleanable/urine/U in src.loc)
			if(U != src)
				src.amount += U.amount
				if (U.blood_DNA)
					blood_DNA |= U.blood_DNA.Copy()
				del(U)

/obj/effect/decal/cleanable/urine/Crossed(mob/living/carbon/M)
	if (!istype(M))
		return
	if(amount < 1)
		return

	if(ishuman(M))
		var/mob/living/carbon/human/perp = M
		if(perp.shoes)
			if(!perp.shoes.blood_DNA)
				perp.shoes.blood_DNA = list()
			perp.shoes.blood_DNA |= blood_DNA.Copy()
			if(istype(perp.shoes, /obj/item/clothing/shoes/galoshes))
				return
		else
			if(!perp.feet_blood_DNA)
				perp.feet_blood_DNA = list()
			perp.feet_blood_DNA |= blood_DNA.Copy()

		amount--

	if(M.m_intent == "walk")
		return

	M.pulling = null
	M << "\blue You slipped in the urine puddle!"
//	M.achievement_give("Pissed!", 69)
	playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
	M.stunned = 8
	M.weakened = 5

/obj/effect/decal/cleanable/urine/New()
	..()
	spawn(800)
		del(src)

/obj/effect/decal/cleanable/urine/Destroy()
	for(var/datum/disease/D in viruses)
		D.cure(0)
	..()