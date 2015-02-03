//Magazines are loaded directly into weapons
//Unlike boxes, they have no fumbling. Simply loading a magazine is instant

/obj/item/ammo_storage/magazine
	desc = "A magazine capable of holding bullets. Can be loaded into certain weapons."
	exact = 1 //we only load the thing we want to load

/obj/item/ammo_storage/magazine/mc9mm
	name = "magazine (9mm)"
	icon_state = "9x19p"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	max_ammo = 8
	sprite_modulo = 8
	multiple_sprites = 1

/obj/item/ammo_storage/magazine/mc9mm/empty
	starting_ammo = 0

/obj/item/ammo_storage/magazine/a12mm
	name = "magazine (12mm)"
	icon_state = "12mm"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a12mm"
	max_ammo = 20
	multiple_sprites = 1
	sprite_modulo = 2


/obj/item/ammo_storage/magazine/a12mm/empty
	starting_ammo = 0

/obj/item/ammo_storage/magazine/smg9mm
	name = "magazine (9mm)"
	icon_state = "smg9mm"
	origin_tech = "combat=3"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	max_ammo = 18
	sprite_modulo = 3
	multiple_sprites = 1

/obj/item/ammo_storage/magazine/a50
	name = "magazine (.50)"
	icon_state = "50ae"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a50"
	max_ammo = 7
	multiple_sprites = 1
	sprite_modulo = 1

/obj/item/ammo_storage/magazine/a50/empty
	starting_ammo = 0

/obj/item/ammo_storage/magazine/a75
	name = "magazine (.75)"
	icon_state = "75"
	ammo_type = "/obj/item/ammo_casing/a75"
	multiple_sprites = 1
	max_ammo = 8
	sprite_modulo = 8

/obj/item/ammo_storage/magazine/a75/empty
	starting_ammo = 0

/obj/item/ammo_storage/magazine/a762
	name = "magazine (a762)"
	icon_state = "a762"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/a762"
	max_ammo = 50
	multiple_sprites = 1
	sprite_modulo = 10

/obj/item/ammo_storage/magazine/a762/empty
	starting_ammo = 0

/obj/item/ammo_storage/magazine/c45
	name = "magazine (.45)"
	icon_state = "45"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c45"
	max_ammo = 8
	multiple_sprites = 1
	sprite_modulo = 1

/obj/item/ammo_storage/magazine/uzi45 //Uzi mag
	name = "magazine (.45)"
	icon_state = "uzi45"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c45"
	max_ammo = 16
	multiple_sprites = 1
	sprite_modulo = 2

/obj/item/ammo_storage/magazine/m12g // Bulldog Mag
	name = "shotgun magazine (12g taser slugs)"
	icon_state = "m12gs"
	origin_tech = "combat=3;syndicate=1"
	ammo_type = "/obj/item/ammo_casing/shotgun/stunshell"
	max_ammo = 8

/obj/item/ammo_storage/magazine/m12g/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[Ceiling(ammo_count(0)/8)*8]"


/obj/item/ammo_storage/magazine/m12g/buckshot
	name = "shotgun magazine (12g buckshot)"
	icon_state = "m12gb"
	ammo_type = "/obj/item/ammo_casing/shotgun"

/obj/item/ammo_storage/magazine/stanag
	name = "magazine 30(5.56x45)"
	icon_state = "stanag"
	origin_tech = "combat=2"
	ammo_type = "/obj/item/ammo_casing/c556"
	max_ammo = 30
	multiple_sprites = 1
	sprite_modulo = 30

/obj/item/ammo_storage/magazine/stanag/short
	name = "magazine 20(5.56x45)"
	icon_state = "stanag_20"
	max_ammo = 20
	sprite_modulo = 20

/obj/item/ammo_storage/magazine/stanag/drum
	name = "magazine 100(5.56x45)"
	icon_state = "drum"
	ammo_type = "/obj/item/ammo_casing/c556"
	max_ammo = 100
	sprite_modulo = 100