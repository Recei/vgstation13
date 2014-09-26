/*
	These defines specificy screen locations.  For more information, see the byond documentation on the screen_loc var.

	The short version:

	Everything is encoded as strings because apparently that's how Byond rolls.

	"1,1" is the bottom left square of the user's screen.  This aligns perfectly with the turf grid.
	"1:2,3:4" is the square (1,3) with pixel offsets (+2, +4); slightly right and slightly above the turf grid.
	Pixel offsets are used so you don't perfectly hide the turf under them, that would be crappy.

	The size of the user's screen is defined by client.view (indirectly by world.view), in our case "15x15".
	Therefore, the top right corner (except during admin shenanigans) is at "15,15"
*/

//Upper left action buttons, displayed when you pick up an item that has this enabled.
#define ui_action_slot1 "1:6,14:26"
#define ui_action_slot2 "2:8,14:26"
#define ui_action_slot3 "3:10,14:26"
#define ui_action_slot4 "4:12,14:26"
#define ui_action_slot5 "5:14,14:26"

//Lower left, persistant menu
#define ui_inventory "SOUTH,4"

//Lower center, persistant menu
#define ui_sstore1 "SOUTH+1,4"
#define ui_id "SOUTH-1,1"
#define ui_belt "SOUTH-1,3"
#define ui_back "SOUTH+1,3"
#define ui_rhand "SOUTH,1"
#define ui_lhand "SOUTH,3"
#define ui_swaphand2 "8:16,2:5"
#define ui_storage1 "SOUTH-1,4"
#define ui_storage2 "SOUTH-1,5"

#define ui_alien_head "4:12,1:5"	//aliens
#define ui_alien_oclothing "5:14,1:5"	//aliens
/*
#define ui_inv1 "6:16,1:5"			//borgs
#define ui_inv2 "7:16,1:5"			//borgs
#define ui_inv3 "8:16,1:5"			//borgs
#define ui_borg_store "9:16,1:5"	//borgs
*/
#define ui_monkey_mask "SOUTH+1,1"	//monkey
#define ui_monkey_back "SOUTH+1,3"	//monkey

//Lower right, persistant menu
#define ui_swaphand "SOUTH-1,6"
#define ui_dropbutton "SOUTH-1,7"
#define ui_drop_throw "SOUTH-1,8"
#define ui_equip "SOUTH-1,9"
#define ui_pull "SOUTH-1,10"
#define ui_resist "EAST+1,SOUTH-1"
#define ui_acti "SOUTH-1,12"
#define ui_movi "SOUTH-1,14"
#define ui_zonesel "EAST+1, NORTH"
#define ui_acti_alt "14:28,1:5" //alternative intent switcher for when the interface is hidden (F12)

#define ui_borg_pull "EAST,SOUTH-1"
#define ui_borg_module "13:26,2:7"
#define ui_borg_panel "14:28,2:7"

//Gun buttons
#define ui_gun1 "9, SOUTH"
#define ui_gun2 "10, SOUTH"
#define ui_gun3 "11, SOUTH"
#define ui_gun_select "10, SOUTH-1"

//Upper-middle right (damage indicators)
#define ui_toxin "EAST+1, NORTH-5"
#define ui_fire "EAST+1, NORTH-6"
#define ui_oxygen "EAST+1, NORTH-4"
#define ui_pressure "EAST+1, NORTH-7"

#define ui_alien_toxin "14:28,13:25"
#define ui_alien_fire "14:28,12:25"
#define ui_alien_oxygen "14:28,11:25"

//Middle right (status indicators)
#define ui_nutrition "EAST+1, NORTH-11"
#define ui_hydration "EAST+1, NORTH-12"
#define ui_temp "EAST+1, NORTH-8"
#define ui_health "EAST+1, NORTH-10"
#define ui_internal "EAST+1, NORTH-2"
									//borgs
#define ui_borg_health "EAST+1, NORTH-11" //borgs have the health display where humans have the pressure damage indicator.
#define ui_alien_health "EAST+1, NORTH-11" //aliens have the health display where humans have the pressure damage indicator.

#define ui_construct_health "15:00,7:15" //same height as humans, hugging the right border
#define ui_construct_fire "14:16,8:13" //above health, slightly to the left
#define ui_construct_pull "14:28,2:10" //above the zone_sel icon
//Pop-up inventory
#define ui_shoes "SOUTH,4"

#define ui_iclothing "SOUTH-1,2"
#define ui_oclothing "SOUTH,2"
#define ui_gloves "SOUTH,5"

#define ui_glasses "SOUTH,7"
#define ui_mask "SOUTH+1,1"
#define ui_ears "SOUTH,6"

#define ui_head "SOUTH+1,2"

//Intent small buttons
#define ui_help_small "12:8,1:1"
#define ui_disarm_small "12:15,1:18"
#define ui_grab_small "12:32,1:18"
#define ui_harm_small "12:39,1:1"

//#define ui_swapbutton "6:-16,1:5" //Unused

//#define ui_headset "SOUTH,8"
#define ui_hstore1 "5,5"
#define ui_sleep "EAST+1, NORTH-13"
#define ui_rest "EAST+1, NORTH-14"


#define ui_iarrowleft "SOUTH-1,11"
#define ui_iarrowright "SOUTH-1,13"