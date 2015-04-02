/obj/effect/decal/cleanable/blood/poo
	name = "poo"
	desc = "It's a poo stain..."
	icon = 'icons/effects/pooeffect.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7", "floor8")

/obj/effect/decal/cleanable/blood/poo/addDecalFeets(mob/living/carbon/human/perp)
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
	else
		perp.track_poo = max(amount,perp.track_poo)                                //Or feet
		if(!perp.feet_blood_DNA)
			perp.feet_blood_DNA = list()
		perp.feet_blood_DNA |= blood_DNA.Copy()

/obj/effect/decal/cleanable/blood/poo/Crossed(mob/living/carbon/human/perp)
	..()
	if(perp.m_intent == "walk")
		return

	perp.pulling = null
	perp << "\blue You slipped on the wet poo stain!"
//	M.achievement_give("Oh Shit!", 68)
	playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
	perp.stunned = 6
	perp.weakened = 5

/obj/effect/decal/cleanable/blood/poo/update_icon()
	return

/obj/effect/decal/cleanable/blood/poo/drip
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
	qdel(src)

/obj/item/weapon/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom)
	..()
	poo_splat(hit_atom)

/obj/effect/decal/cleanable/blood/urine
	name = "Urine puddle"
	desc = "Someone couldn't hold it.."
	icon = 'icons/effects/pooeffect.dmi'
	icon_state = "pee1"

/obj/effect/decal/cleanable/blood/urine/addDecalFeets(mob/living/carbon/human/perp)
	if(perp.shoes)
		if(!perp.shoes.blood_DNA)
			perp.shoes.blood_DNA = list()
		perp.shoes.blood_DNA |= blood_DNA.Copy()
	else
		if(!perp.feet_blood_DNA)
			perp.feet_blood_DNA = list()
		perp.feet_blood_DNA |= blood_DNA.Copy()

/obj/effect/decal/cleanable/blood/urine/Crossed(mob/living/carbon/human/perp)
	..()
	if(perp.m_intent == "walk")
		return

	perp.pulling = null
	perp << "\blue You slipped in the urine puddle!"
//	perp.achievement_give("Pissed!", 69)
	playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
	perp.stunned = 8
	perp.weakened = 5

/obj/effect/decal/cleanable/blood/urine/New()
	..()
	spawn(800)
		returnToPool(src)

/obj/effect/decal/cleanable/blood/urine/update_icon()
	return
