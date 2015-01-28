/obj/item/weapon/reagent_containers/blood
	name = "BloodPack"
	desc = "Contains blood used for transfusion."
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "iv_bag0"
	volume = 200
	flags = FPRINT

	var/blood_type = null

/obj/item/weapon/reagent_containers/blood/New()
	..()
	if(blood_type != null)
		name = "BloodPack [blood_type]"
		reagents.add_reagent("blood", 200, list("donor"=null,"viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null))
		update_icon()


/obj/item/weapon/reagent_containers/blood/on_reagent_change()
	update_icon()


/obj/item/weapon/reagent_containers/blood/update_icon()
	overlays.Cut()

	if(!icon_state)
		icon_state = "iv_bag0"
	if(reagents.total_volume)
		if (src.icon_state == "iv_bag0")
			var/filler_icon_state = null

			var/percent = round((reagents.total_volume / volume) * 100)
			switch(percent)
				if(0 to 9)			filler_icon_state = null
				if(10 to 50) 		filler_icon_state = "half"
				if(51 to INFINITY)	filler_icon_state = "full"

			var/image/filling = image('icons/obj/bloodpack.dmi', src, filler_icon_state)
			filling.icon += mix_color_from_reagents(reagents.reagent_list)
			src.overlays += filling


/obj/item/weapon/reagent_containers/blood/attack_self()
	..()
	if (is_open_container())
		usr << "<span class = 'notice'>You sealed \the [src].</span>"
		flags ^= OPENCONTAINER
	else
		usr << "<span class = 'notice'>You unsealed \the [src].</span>"
		flags |= OPENCONTAINER


/obj/item/weapon/reagent_containers/blood/examine()
	..()
	if (!is_open_container())
		usr << "<span class = 'notice'>[src.reagents.total_volume] units of liquid.</span>" //A bit hacky
		usr << "<span class = 'notice'>It's sealed completely.</span>"
	else
		usr << "<span class = 'notice'>It's unsealed</span>"


/obj/item/weapon/reagent_containers/blood/APlus
	blood_type = "A+"

/obj/item/weapon/reagent_containers/blood/AMinus
	blood_type = "A-"

/obj/item/weapon/reagent_containers/blood/BPlus
	blood_type = "B+"

/obj/item/weapon/reagent_containers/blood/BMinus
	blood_type = "B-"

/obj/item/weapon/reagent_containers/blood/OPlus
	blood_type = "O+"

/obj/item/weapon/reagent_containers/blood/OMinus
	blood_type = "O-"

/obj/item/weapon/reagent_containers/blood/empty
	name = "Empty BloodPack"
	desc = "Seems pretty useless... Maybe if there were a way to fill it?"
	icon_state = "iv_bag0"

/obj/item/weapon/reagent_containers/blood/chemo
	name = "Phalanximine IV kit"
	desc = "IV kit for chemotherapy."

/obj/item/weapon/reagent_containers/blood/chemo/New()
	..()
	reagents.add_reagent("phalanximine", 200)
	update_icon()

/obj/item/weapon/reagent_containers/blood/salglu_solution
	name = "Saline-Glucose IV kit"
	desc = "IV kit with saline and glucose solution in it."

/obj/item/weapon/reagent_containers/blood/salglu_solution/New()
	..()
	reagents.add_reagent("salglu_solution", 200)
	update_icon()