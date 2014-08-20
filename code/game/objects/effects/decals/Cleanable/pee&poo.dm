/obj/effect/decal/cleanable/poo
	name = "poo"
	desc = "It's a poo stain..."
	density = 0
	anchored = 1
	layer = 2
	icon = 'icons/effects/pooeffect.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7", "floor8")
//	var/datum/disease/virus = null
	var/dried = 0
	decaltype = "poo"
//	blood_DNA = null
//	blood_type = null

/obj/effect/decal/cleanable/poo/New()
	src.icon = 'pooeffect.dmi'
	src.icon_state = pick(src.random_icon_states)
//	spawn(5) src.reagents.add_reagent("poo",5)
	spawn(400)
		src.dried = 1

/obj/effect/decal/cleanable/poo/tracks
	icon_state = "tracks"
	random_icon_states = null

/obj/effect/decal/cleanable/poo/drip
	name = "drips of poo"
	desc = "It's brown."
	density = 0
	anchored = 1
	layer = 2
	icon = 'pooeffect.dmi'
	icon_state = "drip1"
	random_icon_states = list("drip1", "drip2", "drip3", "drip4", "drip5")
//	blood_DNA = null
//	blood_type = null

/obj/effect/decal/cleanable/poo/proc/streak(var/list/directions)
	spawn (0)
		var/direction = pick(directions)
		for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
			sleep(3)
			//if (i > 0)
			//	var/obj/effect/decal/cleanable/poo/b = new /obj/effect/decal/cleanable/poo(src.loc)
			//	if (src.virus)
			//		b.virus = src.virus
			if (step_to(src, get_step(src, direction), 0))
				break

/obj/effect/decal/cleanable/poo/Crossed(AM as mob|obj)
	if (istype(AM, /mob/living/carbon) && src.dried == 0)
		var/mob/M =	AM
		if ((istype(M, /mob/living/carbon/human) && istype(M:shoes, /obj/item/clothing/shoes/galoshes)) || M.m_intent == "walk")
			return

		M.pulling = null
		M << "\blue You slipped on the wet poo stain!"
//		M.achievement_give("Oh Shit!", 68)
		playsound(src.loc, 'slip.ogg', 50, 1, -3)
		M.stunned = 6
		M.weakened = 5


/obj/item/weapon/reagent_containers/food/snacks/poo // Dis is not a effect but whatever
	name = "poo"
	desc = "It's a poo..."
	icon = 'icons/obj/poop.dmi'
	icon_state = "poop2"
	item_state = "poop"
	random_icon_states = list("poop1", "poop2", "poop3", "poop4", "poop5", "poop6", "poop7")
	New()
		..()
		icon_state = pick(random_icon_states)
		reagents.add_reagent("poo", 10)
		bitesize = 3

	proc/poo_splat(atom/target)
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

/obj/effect/decal/cleanable/urine
	name = "Urine puddle"
	desc = "Someone couldn't hold it.."
	density = 0
	anchored = 1
	layer = 2
	icon = 'pooeffect.dmi'
	icon_state = "pee1"
	random_icon_states = list("pee1", "pee2", "pee3")
//	var/datum/disease/virus = null
	decaltype = "urine"
//	blood_DNA = null
//	blood_type = null

/obj/effect/decal/cleanable/urine/Crossed(AM as mob|obj)
	if (istype(AM, /mob/living/carbon))
		var/mob/M =	AM
		if ((istype(M, /mob/living/carbon/human) && istype(M:shoes, /obj/item/clothing/shoes/galoshes)) || M.m_intent == "walk")
			return

		M.pulling = null
		M << "\blue You slipped in the urine puddle!"
//		M.achievement_give("Pissed!", 69)
		playsound(src.loc, 'slip.ogg', 50, 1, -3)
		M.stunned = 8
		M.weakened = 5

/obj/effect/decal/cleanable/urine/New()
	src.icon_state = pick(src.random_icon_states)
//	spawn(10) src.reagents.add_reagent("urine",5)
//	..()
	spawn(800)
		del(src)