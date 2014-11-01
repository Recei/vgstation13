/*
 * Holds procs designed to change one type of value, into another.
 * Contains:
 *			text2list & list2text
 *			file2list
 *			angle2dir
 *			angle2text
 *			worldtime2text
 */

//Attaches each element of a list to a single string seperated by 'seperator'.
/proc/dd_list2text(var/list/the_list, separator)
	var/total = the_list.len
	if(!total)
		return
	var/count = 2
	var/newText = "[the_list[1]]"
	while(count <= total)
		if(separator)
			newText += separator
		newText += "[the_list[count]]"
		count++
	return newText


//slower then dd_list2text, but correctly processes associative lists.
proc/tg_list2text(list/list, glue=",")
	if(!istype(list) || !list.len)
		return
	var/output
	for(var/i=1 to list.len)
		output += (i!=1? glue : null)+(!isnull(list["[list[i]]"])?"[list["[list[i]]"]]":"[list[i]]")
	return output

// HTTP GET URL query builder thing.
// list("a"="b","c"="d") -> ?a=b&c=d
/proc/buildurlquery(list/list,sep="&")
	if(!istype(list) || !list.len)
		return
	var/output
	var/i=0
	var/start
	var/qmark="?" // God damnit byond
	for(var/key in list)
		start = i ? sep : qmark
		output += "[start][key]=[list[key]]"
		i++
	return output

//Converts a text string into a list by splitting the string at each seperator found in text (discarding the seperator)
//Returns an empty list if the text cannot be split, or the split text in a list.
//Not giving a "" seperator will cause the text to be broken into a list of single letters.
/proc/text2list(text, seperator="\n")
	. = list()

	var/text_len = length(text)					//length of the input text
	var/seperator_len = length(seperator)		//length of the seperator text

	if(text_len >= seperator_len)
		var/i
		var/last_i = 1

		for(i=1,i<=(text_len+1-seperator_len),i++)
			if( cmptext(copytext(text,i,i+seperator_len), seperator) )
				if(i != last_i)
					. += copytext(text,last_i,i)
				last_i = i + seperator_len

		if(last_i <= text_len)
			. += copytext(text, last_i, 0)
	else
		. += text
	return .

//Converts a text string into a list by splitting the string at each seperator found in text (discarding the seperator)
//Returns an empty list if the text cannot be split, or the split text in a list.
//Not giving a "" seperator will cause the text to be broken into a list of single letters.
//Case Sensitive!
/proc/text2listEx(text, seperator="\n")
	. = list()

	var/text_len = length(text)					//length of the input text
	var/seperator_len = length(seperator)		//length of the seperator text

	if(text_len >= seperator_len)
		var/i
		var/last_i = 1

		for(i=1,i<=(text_len+1-seperator_len),i++)
			if( cmptextEx(copytext(text,i,i+seperator_len), seperator) )
				if(i != last_i)
					. += copytext(text,last_i,i)
				last_i = i + seperator_len

		if(last_i <= text_len)
			. += copytext(text, last_i, 0)
	else
		. += text
	return .

//Splits the text of a file at seperator and returns them in a list.
/proc/file2list(filename, seperator="\n")
	return text2list(return_file_text(filename),seperator)


//Turns a direction into text

/proc/num2dir(direction)
	switch(direction)
		if(1.0) return NORTH
		if(2.0) return SOUTH
		if(4.0) return EAST
		if(8.0) return WEST
		else
			world.log << "UNKNOWN DIRECTION: [direction]"

/proc/dir2text(direction)
	switch(direction)
		if(1.0)
			return "north"
		if(2.0)
			return "south"
		if(4.0)
			return "east"
		if(8.0)
			return "west"
		if(5.0)
			return "northeast"
		if(6.0)
			return "southeast"
		if(9.0)
			return "northwest"
		if(10.0)
			return "southwest"
		else
	return

//Turns text into proper directions
/proc/text2dir(direction)
	switch(uppertext(direction))
		if("NORTH")
			return 1
		if("SOUTH")
			return 2
		if("EAST")
			return 4
		if("WEST")
			return 8
		if("NORTHEAST")
			return 5
		if("NORTHWEST")
			return 9
		if("SOUTHEAST")
			return 6
		if("SOUTHWEST")
			return 10
		else
	return

//Converts an angle (degrees) into an ss13 direction
/proc/angle2dir(var/degree)
	degree = ((degree+22.5)%365)
	if(degree < 45)		return NORTH
	if(degree < 90)		return NORTHEAST
	if(degree < 135)	return EAST
	if(degree < 180)	return SOUTHEAST
	if(degree < 225)	return SOUTH
	if(degree < 270)	return SOUTHWEST
	if(degree < 315)	return WEST
	return NORTH|WEST

//returns the north-zero clockwise angle in degrees, given a direction

/proc/dir2angle(var/D)
	switch(D)
		if(NORTH)		return 0
		if(SOUTH)		return 180
		if(EAST)		return 90
		if(WEST)		return 270
		if(NORTHEAST)	return 45
		if(SOUTHEAST)	return 135
		if(NORTHWEST)	return 315
		if(SOUTHWEST)	return 225
		else			return null

//Returns the angle in english
/proc/angle2text(var/degree)
	return dir2text(angle2dir(degree))

//Converts a blend_mode constant to one acceptable to icon.Blend()
/proc/blendMode2iconMode(blend_mode)
	switch(blend_mode)
		if(BLEND_MULTIPLY) return ICON_MULTIPLY
		if(BLEND_ADD)      return ICON_ADD
		if(BLEND_SUBTRACT) return ICON_SUBTRACT
		else               return ICON_OVERLAY

//Converts a rights bitfield into a string
/proc/rights2text(rights,seperator="")
	if(rights & R_BUILDMODE)	. += "[seperator]+BUILDMODE"
	if(rights & R_ADMIN)		. += "[seperator]+ADMIN"
	if(rights & R_BAN)			. += "[seperator]+BAN"
	if(rights & R_FUN)			. += "[seperator]+FUN"
	if(rights & R_SERVER)		. += "[seperator]+SERVER"
	if(rights & R_DEBUG)		. += "[seperator]+DEBUG"
	if(rights & R_POSSESS)		. += "[seperator]+POSSESS"
	if(rights & R_PERMISSIONS)	. += "[seperator]+PERMISSIONS"
	if(rights & R_STEALTH)		. += "[seperator]+STEALTH"
	if(rights & R_REJUVINATE)	. += "[seperator]+REJUVINATE"
	if(rights & R_VAREDIT)		. += "[seperator]+VAREDIT"
	if(rights & R_SOUNDS)		. += "[seperator]+SOUND"
	if(rights & R_SPAWN)		. += "[seperator]+SPAWN"
	if(rights & R_MOD)			. += "[seperator]+MODERATOR"
	return .

/proc/ui_style2icon(ui_style)
	switch(ui_style)
		if("old")		return 'icons/mob/screen1_old.dmi'
		if("Luna")	return 'icons/mob/screen1_luna.dmi'
		if("Midnight_new") return 'icons/mob/screen1_Midnight_new.dmi'
		if("Orange") return 'icons/mob/screen1_Orange.dmi'
		if("White") return 'icons/mob/screen1_White.dmi'
		else			return 'icons/mob/screen1_Midnight.dmi'

/proc/num2septext(var/theNum, var/sigFig = 7,var/sep=",") // default sigFig (1,000,000)
	var/finalNum = num2text(theNum, sigFig)

	// Start from the end, or from the decimal point
	var/end = findtextEx(finalNum, ".") || length(finalNum) + 1

	// Moving towards start of string, insert comma every 3 characters
	for(var/pos = end - 3, pos > 1, pos -= 3)
		finalNum = copytext(finalNum, 1, pos) + sep + copytext(finalNum, pos)

	return finalNum