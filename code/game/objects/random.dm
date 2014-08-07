/obj/random
	name = "Random Object"
	desc = "This item type is used to spawn random objects at round-start"
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything


// creates a new object and deletes itself
/obj/random/New()
	..()
	if (!prob(spawn_nothing_percentage))
		spawn_item()
	del src


// this function should return a specific item to spawn
/obj/random/proc/item_to_spawn()
	return 0


// creates the random item
/obj/random/proc/spawn_item()
	var/build_path = item_to_spawn()
	return (new build_path(src.loc))


/obj/random/tool
	name = "Random Tool"
	desc = "This is a random tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	item_to_spawn()
		return pick(/obj/item/weapon/screwdriver,\
					/obj/item/weapon/wirecutters,\
					/obj/item/weapon/weldingtool,\
					/obj/item/weapon/crowbar,\
					/obj/item/weapon/wrench,\
					/obj/item/device/flashlight)


/obj/random/technology_scanner
	name = "Random Scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/device.dmi'
	icon_state = "atmos"
	item_to_spawn()
		return pick(prob(5);/obj/item/device/t_scanner,\
					prob(2);/obj/item/device/radio/intercom,\
					prob(5);/obj/item/device/analyzer)


/obj/random/powercell
	name = "Random Powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_to_spawn()
		return pick(prob(10);/obj/item/weapon/cell/crap,\
					prob(40);/obj/item/weapon/cell,\
					prob(40);/obj/item/weapon/cell/high,\
					prob(9);/obj/item/weapon/cell/super,\
					prob(1);/obj/item/weapon/cell/hyper)


/obj/random/bomb_supply
	name = "Bomb Supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"
	item_to_spawn()
		return pick(/obj/item/device/assembly/igniter,\
					/obj/item/device/assembly/prox_sensor,\
					/obj/item/device/assembly/signaler)


/obj/random/toolbox
	name = "Random Toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_to_spawn()
		return pick(prob(3);/obj/item/weapon/storage/toolbox/mechanical,\
					prob(2);/obj/item/weapon/storage/toolbox/electrical,\
					prob(1);/obj/item/weapon/storage/toolbox/emergency)


/obj/random/tech_supply
	name = "Random Tech Supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(3);/obj/random/powercell,\
					prob(2);/obj/random/technology_scanner,\
					prob(1);/obj/item/weapon/packageWrap,\
					prob(2);/obj/random/bomb_supply,\
					prob(1);/obj/item/weapon/extinguisher,\
					prob(1);/obj/item/clothing/gloves/fyellow,\
					prob(3);/obj/item/weapon/cable_coil,\
					prob(2);/obj/random/toolbox,\
					prob(2);/obj/item/weapon/storage/belt/utility,\
					prob(5);/obj/random/tool)

/obj/random/tools
	name = "Random Tools"
	desc = "A random tools"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	item_to_spawn()
		return pick(/obj/random/tech_supply,\
					/obj/random/toolbox,\
					/obj/random/bomb_supply,\
					/obj/random/powercell,\
					/obj/random/tool)

/obj/random/chem
	name = "Random Chemicals"
	desc = "A random chemicals"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle16"
	item_to_spawn()
		return pick(/obj/item/weapon/reagent_containers/glass/bottle/antitoxin,\
					/obj/item/weapon/reagent_containers/glass/bottle/charcoal,\
					/obj/item/weapon/reagent_containers/glass/bottle/tricordrazine,\
					/obj/item/weapon/reagent_containers/glass/bottle/stoxin,\
					/obj/item/weapon/reagent_containers/glass/bottle/kelotane,\
					/obj/item/weapon/reagent_containers/glass/bottle/spaceacillin,\
					/obj/item/weapon/reagent_containers/glass/bottle/dexalin,\
					/obj/item/weapon/reagent_containers/glass/bottle/toxin,\
					/obj/item/weapon/reagent_containers/glass/bottle/inaprovaline)
			//obj/item/weapon/reagent_containers/glass/bottle/hemoline,\
			//obj/item/weapon/reagent_containers/glass/bottle/heparin,\
			//obj/item/weapon/reagent_containers/glass/bottle/chloromydride)

/obj/random/medicaltools
	name = "Random Medical Tools"
	desc = "A random medical tools"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "saw"
	item_to_spawn()
		return pick(/obj/item/weapon/storage/firstaid/regular,\
					/obj/item/weapon/storage/firstaid/fire,\
					/obj/item/weapon/storage/firstaid/o2,\
					/obj/item/weapon/storage/box/syringes,\
					/obj/item/weapon/storage/box/pillbottles,\
					/obj/item/weapon/storage/belt/medical,\
					/obj/item/weapon/storage/box/beakers,\
					/obj/item/device/healthanalyzer,\
					/obj/item/weapon/scalpel,\
					/obj/item/weapon/retractor,\
					/obj/item/weapon/hemostat,\
					/obj/item/weapon/cautery,\
					/obj/item/weapon/surgicaldrill,\
					/obj/item/weapon/circular_saw)
//			"/obj/item/weapon/storage/testtubebox",
//			"/obj/item/weapon/surgicaltube")

//r&d storage shits --soyuz

/*proc/antimeta_rnd()
	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "a-rnd")
			var/antimeta_rnd = pick("/obj/item/weapon/ore/Elerium",	//MATERIALS OUTTA THE ASS
			"/obj/item/weapon/ore/cerenkite",
			"/obj/item/stack/sheet/glass/m50",
			"/obj/item/weapon/ore/uranium",
			"/obj/item/weapon/ore/erebite",
			"/obj/item/weapon/storage/firstaid/regular",
			"/obj/item/weapon/storage/firstaid/fire", //we ARE dealing with toxins here after all
			"/obj/item/stack/sheet/diamond",
			"/obj/item/stack/sheet/gold",
			"/obj/item/stack/sheet/silver",
			"/obj/item/stack/sheet/plasma",
			"/obj/item/weapon/ore/slag",
			"/obj/item/weapon/ore/mauxite",
			"/obj/item/weapon/ore/char",
			"/obj/item/weapon/ore/pharosium",
			"/obj/item/weapon/ore/molitz",
			"/obj/item/weapon/ore/cobryl",
			"/obj/item/weapon/ore/claretine",
			"/obj/item/weapon/ore/syreline",
			"/obj/item/stack/sheet/metal/m50",
			"/obj/item/weapon/ore/bohrum",)
			new antimeta_rnd(C.loc)*/ //
