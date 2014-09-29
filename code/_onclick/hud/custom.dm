/datum/hud/proc/get_special_ui_style(var/uistyle = mymob.client.prefs.UI_style)
	if(uistyle in list("Midnight","old","Luna"))
		return /datum/hud_special/oldlike


/datum/hud_special/oldlike
	locations = list(
	"inventory" = "SOUTH,4",
	"sstore1" = "SOUTH+1,4",
	"id" = "SOUTH-1,1",
	"belt" = "SOUTH-1,3",
	"back" = "SOUTH+1,3",
	"rhand" = "SOUTH,1",
	"lhand" = "SOUTH,3",
	"swaphand2" = "8:16,2:5",
	"storage1" = "SOUTH-1,4",
	"storage2" = "SOUTH-1,5",
	"swaphand" = "SOUTH-1,6",
	"dropbutton" = "SOUTH-1,7",
	"drop_throw" = "SOUTH-1,8",
	"pull" = "SOUTH-1,10",
	"resist" = "EAST+1,SOUTH-1",
	"acti" =  "SOUTH-1,12",
	"movi" = "SOUTH-1,14",
	"zonesel" = "EAST+1, NORTH",
	"acti_alt" = "14:28,1:5" ,
	"toxin" = "EAST+1, NORTH-5",
	"fire" = "EAST+1, NORTH-6",
	"oxygen" = "EAST+1, NORTH-4",
	"pressure" = "EAST+1, NORTH-7",
	"nutrition" = "EAST+1, NORTH-11",
	"hydration" = "EAST+1, NORTH-12",
	"temp" = "EAST+1, NORTH-8",
	"health" = "EAST+1, NORTH-10",
	"internal" = "EAST+1, NORTH-2",
	"shoes" = "SOUTH,4",
	"iclothing" = "SOUTH-1,2",
	"oclothing" = "SOUTH,2",
	"gloves" = "SOUTH,5",
	"glasses" = "SOUTH,7",
	"mask" = "SOUTH+1,1",
	"ears" = "SOUTH,6",
	"r_ear" = "SOUTH+1,6",
	"head" = "SOUTH+1,2",
	"att_int" = "SOUTH-1,9",
	"hstore1" = "5,5",
	"sleep" = "EAST+1, NORTH-13",
	"rest" = "EAST+1, NORTH-14",
	"iarrowleft" = "SOUTH-1,11",
	"iarrowright" = "SOUTH-1,13",
	"filler" = "WEST,SOUTH-1 to EAST,SOUTH-1",
	"filler2" = "EAST+1,SOUTH to EAST+1,NORTH",
	"corner" = "EAST+1,SOUTH-1")

	hideable = list(
	"sstore1" = 1, "shoes" = 1,
	"gloves" = 1, "ears" = 1,
	"glasses" = 1)

	hidden_inventory_update()
		if(ishuman(myhud.mymob))
			var/mob/living/carbon/human/H = myhud.mymob
			if(myhud.inventory_shown && myhud.hud_shown)
				if(H.shoes)		H.shoes.screen_loc = locations["shoes"]
				if(H.gloves)	H.gloves.screen_loc = locations["gloves"]
				if(H.ears)		H.ears.screen_loc = locations["ears"]
				if(H.glasses)	H.glasses.screen_loc = locations["glasses"]
				if(H.s_store)	H.s_store.screen_loc = locations["sstore1"]
			else
				if(H.shoes)		H.shoes.screen_loc = null
				if(H.gloves)	H.gloves.screen_loc = null
				if(H.ears)		H.ears.screen_loc = null
				if(H.glasses)	H.glasses.screen_loc = null
				if(H.s_store)	H.s_store.screen_loc = null
		return 1

	persistant_inventory_update()
		if(ishuman(myhud.mymob))
			var/mob/living/carbon/human/H = myhud.mymob
			if(myhud.hud_shown)
				if(H.wear_id)	H.wear_id.screen_loc = locations["id"]
				if(H.belt)		H.belt.screen_loc = locations["belt"]
				if(H.back)		H.back.screen_loc = locations["back"]
				if(H.l_store)	H.l_store.screen_loc = locations["storage1"]
				if(H.r_store)	H.r_store.screen_loc = locations["storage2"]
				if(H.w_uniform)	H.w_uniform.screen_loc = locations["iclothing"]
				if(H.wear_suit)	H.wear_suit.screen_loc = locations["oclothing"]
				if(H.wear_mask)	H.wear_mask.screen_loc = locations["mask"]
				if(H.head)		H.head.screen_loc = locations["head"]
			else
				if(H.wear_id)	H.wear_id.screen_loc = null
				if(H.belt)		H.belt.screen_loc = null
				if(H.back)		H.back.screen_loc = null
				if(H.l_store)	H.l_store.screen_loc = null
				if(H.r_store)	H.r_store.screen_loc = null
				if(H.w_uniform)	H.w_uniform.screen_loc = null
				if(H.wear_suit)	H.wear_suit.screen_loc = null
				if(H.wear_mask)	H.wear_mask.screen_loc = null
				if(H.head)		H.head.screen_loc = null



/datum/hud/proc/custom_hud(var/ui_style='icons/mob/screen1_Luna.dmi', var/specialtype = /datum/hud_special/oldlike)

	src.adding = list()
	src.other = list()
	src.hotkeybuttons = list() //These can be disabled for hotkey usersx
	src.special = new specialtype(src)

	var/obj/screen/using
	var/obj/screen/inventory/inv_box

	using = new /obj/screen()
	using.name = "help"
	using.icon = ui_style
	using.icon_state = "help_m"
	using.screen_loc = special.locations["iarrowleft"]
	using.layer = 21
	adding += using

	using = new /obj/screen()
	using.name = "grab"
	using.icon = ui_style
	using.icon_state = "grab_m"
	using.screen_loc = special.locations["iarrowleft"]
	using.layer = 21
	adding += using


	using = new /obj/screen()
	using.name = "disarm"
	using.icon = ui_style
	using.icon_state = "disarm_m"
	using.screen_loc = special.locations["iarrowright"]
	using.layer = 21
	adding += using

	using = new /obj/screen()
	using.name = "harm"
	using.icon = ui_style
	using.icon_state = "harm_m"
	using.screen_loc = special.locations["iarrowright"]
	using.layer = 21
	adding += using

	using = new /obj/screen() //Corner Button
	using.dir = NORTHWEST
	using.icon = ui_style
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 18
	adding += using


	using = new /obj/screen()
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = "intent_"+mymob.a_intent
	using.screen_loc = special.locations["acti"]
	using.layer = 20
	adding += using
	src.action_intent = using

	using = new /obj/screen()
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = special.locations["movi"]
	using.layer = 20

	src.adding += using
	move_intent = using

	using = new /obj/screen()
	using.name = "drop"
	using.icon = ui_style
	using.icon_state = "act_drop"
	using.screen_loc = special.locations["dropbutton"]
	using.layer = 19
	src.hotkeybuttons += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "i_clothing"
	inv_box.dir = SOUTH
	inv_box.icon = ui_style
	inv_box.slot_id = slot_w_uniform
	inv_box.icon_state = "center"
	inv_box.screen_loc = special.locations["iclothing"]
	inv_box.layer = 19
	if(special.hideable["iclothing"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "o_clothing"
	inv_box.dir = SOUTH
	inv_box.icon = ui_style
	inv_box.slot_id = slot_wear_suit
	inv_box.icon_state = "equip"
	inv_box.screen_loc = special.locations["oclothing"]
	inv_box.layer = 19
	src.adding += inv_box
	if(special.hideable["oclothing"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "r_hand"
	inv_box.dir = WEST
	inv_box.icon = ui_style
	inv_box.icon_state = "hand_inactive"
	if(mymob && !mymob.hand)	//This being 0 or null means the right hand is in use
		inv_box.icon_state = "hand_active"
	inv_box.screen_loc = special.locations["rhand"]
	inv_box.slot_id = slot_r_hand
	inv_box.layer = 19

	src.r_hand_hud_object = inv_box
	src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "l_hand"
	inv_box.dir = EAST
	inv_box.icon = ui_style
	inv_box.icon_state = "hand_inactive"
	if(mymob && mymob.hand)	//This being 1 means the left hand is in use
		inv_box.icon_state = "hand_active"
	inv_box.screen_loc = special.locations["lhand"]
	inv_box.slot_id = slot_l_hand
	inv_box.layer = 19
	src.l_hand_hud_object = inv_box
	src.adding += inv_box

	using = new /obj/screen/inventory()
	using.name = "hand"
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "hand"
	using.screen_loc = special.locations["swaphand"]
	using.layer = 19
	src.swaphands_hud_object = using
	src.adding += using

	using = new /obj/screen()
	using.name = "equip"
	using.icon = ui_style
	using.icon_state = "act_equip"
	using.screen_loc = special.locations["equip"]
	using.layer = 20
	src.adding += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "id"
	inv_box.dir = NORTH
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.screen_loc = special.locations["id"]
	inv_box.slot_id = slot_wear_id
	inv_box.layer = 19
	if(special.hideable["id"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "mask"
	inv_box.dir = NORTH
	inv_box.icon = ui_style
	inv_box.icon_state = "equip"
	inv_box.screen_loc = special.locations["mask"]
	inv_box.slot_id = slot_wear_mask
	inv_box.layer = 19
	if(special.hideable["mask"])
		src.other += inv_box
	else
		src.adding += inv_box


	inv_box = new /obj/screen/inventory()
	inv_box.name = "back"
	inv_box.dir = NORTH
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = special.locations["back"]
	inv_box.slot_id = slot_back
	inv_box.layer = 19
	if(special.hideable["back"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "storage1"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = special.locations["storage1"]
	inv_box.slot_id = slot_l_store
	inv_box.layer = 19
	if(special.hideable["storage1"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "storage2"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = special.locations["storage2"]
	inv_box.slot_id = slot_r_store
	inv_box.layer = 19
	if(special.hideable["storage2"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.dir = 8 //The sprite at dir=8 has the background whereas the others don't.
	inv_box.icon_state = "belt"
	inv_box.screen_loc = special.locations["sstore1"]
	inv_box.slot_id = slot_s_store
	inv_box.layer = 19
	if(special.hideable["sstore1"])
		src.other += inv_box
	else
		src.adding += inv_box

	using = new /obj/screen()
	using.name = "resist"
	using.icon = ui_style
	using.icon_state = "act_resist"
	using.screen_loc = special.locations["resist"]
	using.layer = 19
	src.hotkeybuttons += using

	using = new /obj/screen()
	using.name = "toggle"
	using.icon = ui_style
	using.icon_state = "other"
	using.screen_loc = special.locations["inventory"]
	using.layer = 20


	src.adding += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = special.locations["gloves"]
	inv_box.slot_id = slot_gloves
	inv_box.layer = 19
	if(special.hideable["gloves"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = special.locations["glasses"]
	inv_box.slot_id = slot_glasses
	inv_box.layer = 19
	if(special.hideable["glasses"])
		src.other += inv_box
	else
		src.adding += inv_box


	inv_box = new /obj/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = special.locations["ears"]
	inv_box.slot_id = slot_ears
	inv_box.layer = 19
	if(special.hideable["ears"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "hair"
	inv_box.screen_loc = special.locations["head"]
	inv_box.slot_id = slot_head
	inv_box.layer = 19
	if(special.hideable["head"])
		src.other += inv_box
	else
		src.adding += inv_box


	inv_box = new /obj/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = special.locations["shoes"]
	inv_box.slot_id = slot_shoes
	inv_box.layer = 19
	if(special.hideable["shoes"])
		src.other += inv_box
	else
		src.adding += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
	inv_box.screen_loc = special.locations["belt"]
	inv_box.slot_id = slot_belt
	inv_box.layer = 19
	if(special.hideable["belt"])
		src.other += inv_box
	else
		src.adding += inv_box

	mymob.throw_icon = new /obj/screen()
	mymob.throw_icon.icon = ui_style
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = special.locations["drop_throw"]
	src.hotkeybuttons += mymob.throw_icon

	mymob.oxygen = new /obj/screen()
	mymob.oxygen.icon = ui_style
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = special.locations["oxygen"]

	mymob.pressure = new /obj/screen()
	mymob.pressure.icon = ui_style
	mymob.pressure.icon_state = "pressure0"
	mymob.pressure.name = "pressure"
	mymob.pressure.screen_loc = special.locations["pressure"]

	mymob.toxin = new /obj/screen()
	mymob.toxin.icon = ui_style
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = special.locations["toxin"]

	mymob.internals = new /obj/screen()
	mymob.internals.icon = ui_style
	mymob.internals.icon_state = "internal0"
	mymob.internals.name = "internal"
	mymob.internals.screen_loc = special.locations["internal"]


	mymob.fire = new /obj/screen()
	mymob.fire.icon = ui_style
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = special.locations["fire"]

	mymob.bodytemp = new /obj/screen()
	mymob.bodytemp.icon = ui_style
	mymob.bodytemp.icon_state = "temp1"
	mymob.bodytemp.name = "body temperature"
	mymob.bodytemp.screen_loc = special.locations["temp"]

	mymob.healths = new /obj/screen()
	mymob.healths.icon = ui_style
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = special.locations["health"]

	mymob.nutrition_icon = new /obj/screen()
	mymob.nutrition_icon.icon = ui_style
	mymob.nutrition_icon.icon_state = "nutrition0"
	mymob.nutrition_icon.name = "nutrition"
	mymob.nutrition_icon.screen_loc = special.locations["nutrition"]

	mymob.hydration_icon = new /obj/screen()
	mymob.hydration_icon.icon = ui_style
	mymob.hydration_icon.icon_state = "hydration0"
	mymob.hydration_icon.name = "hydration"
	mymob.hydration_icon.screen_loc = special.locations["hydration"]

	mymob.pullin = new /obj/screen()
	mymob.pullin.icon = ui_style
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = special.locations["pull"]
	src.hotkeybuttons += mymob.pullin

	mymob.blind = new /obj/screen()
	mymob.blind.icon = 'icons/mob/screen1_full.dmi'
	mymob.blind.icon_state = "blackimageoverlay"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1"
	mymob.blind.mouse_opacity = 0
	mymob.blind.layer = 0

	mymob.damageoverlay = new /obj/screen()
	mymob.damageoverlay.icon = 'icons/mob/screen1_full.dmi'
	mymob.damageoverlay.icon_state = "oxydamageoverlay0"
	mymob.damageoverlay.name = "dmg"
	mymob.damageoverlay.screen_loc = "1,1"
	mymob.damageoverlay.mouse_opacity = 0
	mymob.damageoverlay.layer = 18.1 //The black screen overlay sets layer to 18 to display it, this one has to be just on top.

	mymob.flash = new /obj/screen()
	mymob.flash.icon = ui_style
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.pain = new /obj/screen( null )

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.icon = ui_style
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")


	using = new /obj/screen()
	using.icon = ui_style
	using.screen_loc = special.locations["filler"]
	using.layer = 17
	using.dir = EAST
	src.adding += using

	using = new /obj/screen()
	using.icon = ui_style
	using.screen_loc = special.locations["filler2"]
	using.layer = 17
	src.adding += using

	using = new /obj/screen() //Corner Button
	using.dir = NORTHWEST
	using.icon = ui_style
	using.screen_loc = special.locations["corner"]
	using.layer = 18
	adding += using

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.icon = ui_style
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.screen_loc = special.locations["zonesel"]
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")

	mymob.client.screen = null
	mymob.client.screen += src.adding + src.hotkeybuttons
	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.pressure, mymob.toxin, mymob.bodytemp, mymob.internals, mymob.fire, mymob.healths, mymob.nutrition_icon, mymob.hydration_icon, mymob.rest, mymob.pullin, mymob.hands, mymob.blind, mymob.flash, mymob.damageoverlay)
	inventory_shown = 0

	return

