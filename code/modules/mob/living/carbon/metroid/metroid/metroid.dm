/mob/living/carbon/slime/metroid
	name = "baby metroid"
	colour = "metroid"
	icon_state = "baby metroid"
	primarytype = /mob/living/carbon/slime/metroid
	adulttype = /mob/living/carbon/slime/adult/metroid
	pass_flags = PASSTABLE
	speak_emote = list("hums")

	coretype = /obj/item/slime_extract/metroid_core

	nutrition = 800
	cores = 3

	var/list/mctrand = list(/obj/item/slime_extract/metroid_core/t1	= 2,
							/obj/item/slime_extract/metroid_core/t2	= 2,
							/obj/item/slime_extract/metroid_core/t3	= 2,
							/obj/item/slime_extract/metroid_core/t4	= 2,
							/obj/item/slime_extract/metroid_core/t5	= 2,
							/obj/item/slime_extract/metroid_core		= 3)

/mob/living/carbon/slime/adult/metroid
	name = "adult metroid"
	icon_state = "adult metroid"

	health = 200

	nutrition = 1000 // 1200 = max
	New()
		..()
		slime_mutation[1] = /mob/living/carbon/slime/metroid
		slime_mutation[2] = /mob/living/carbon/slime/metroid
		slime_mutation[3] = /mob/living/carbon/slime/metroid
		slime_mutation[4] = /mob/living/carbon/slime/metroid