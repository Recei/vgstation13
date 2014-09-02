/proc/load_bwhitelist()
	log_admin("Loading whitelist")
	bwhitelist = list()
	var/DBConnection/dbcon1 = new()
	dbcon1.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(!dbcon1.IsConnected())
		log_admin("Failed to load bwhitelist. Error: [dbcon1.ErrorMsg()]")
		return
	var/DBQuery/query = dbcon1.NewQuery("SELECT ckey FROM bwhitelist ORDER BY ckey ASC")
	query.Execute()
	while(query.NextRow())
		bwhitelist += "[query.item[1]]"
	if (bwhitelist==list(  ))
		log_admin("Failed to load bwhitelist or its empty")
		return
	dbcon1.Disconnect()

/proc/check_bwhitelist(var/K)
	if (!bwhitelist)
		load_bwhitelist()
		if (!bwhitelist)
			return 0
	if (K in bwhitelist)
		return 1
	return 0
//////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
///////////DATABASE WHITELIST ADDING, REMOVING AND CHECKING INGAME//////////
////////////////////////////BY SMET19//////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
//Thanks to: ZLOFENIX and Relativist for helping. Messiah2011 for idea//
/////Someday i will make something like player panel, but for this/////
//////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/client/proc/add_to_bwhitelist()
	set name = "Add To Whitelist"
	set category = "Whitelist"
	var/ckeyname = input(usr,"Example: key = Randy Sandy , ckey = randysandy" ,"Enter ckey", "ckey")
	ckeyname = ckey(ckeyname)
	bwhitelist += ckeyname
	bwhitelist_save(ckeyname)

/client/proc/remove_from_bwhitelist()
	set name = "Remove From Whitelist"
	set category = "Whitelist"
	var/ckeyname = input(usr,"Example: key = Randy Sandy , ckey = randysandy" ,"Enter ckey", "ckey")
	ckeyname = ckey(ckeyname)
	bwhitelist -= ckeyname
	bwhitelist_remove(ckeyname)

/client/proc/checkwhitelist()
	set name = "Check ckey in Whitelist"
	set category = "Whitelist"
	var/ckeyname = input(usr,"Example: key = Randy Sandy , ckey = randysandy" ,"Enter ckey", "ckey")
	var/in_whitelist = check_bwhitelist(ckey(ckeyname))
	if (in_whitelist)
		alert(usr,"This user in whitelist.","Ckey check","OK")
	else
		switch(alert("This user not in whitelist or u r typing shit.Add user to whitelist?",,"Yes","No"))
			if("Yes")
				ckeyname = ckey(ckeyname)	//
				bwhitelist += ckeyname		//Because calling add_to_bwhitelist() causes inputting ckeyname again
				bwhitelist_save(ckeyname)	//
			if("No")
				return

/proc/bwhitelist_save(var/ckeyname)
	if (!bwhitelist)
		load_bwhitelist()
		if (!bwhitelist)
			return
	var/sql = "INSERT INTO bwhitelist (`ckey`) VALUES ('[ckeyname]')"
	var/DBQuery/query_insert = dbcon.NewQuery(sql)
	query_insert.Execute()
	usr << "\blue Ckey saved to database."
	message_admins("[key_name_admin(usr)] has added [ckeyname] to the whitelist.",1)


/proc/bwhitelist_remove(var/ckeyname)
	if (!bwhitelist)
		load_bwhitelist()
		if (!bwhitelist)
			return
	var/sql = "DELETE FROM bwhitelist WHERE ckey='[ckeyname]'"
	var/DBQuery/query_insert = dbcon.NewQuery(sql)
	query_insert.Execute()
	usr << "\blue Ckey removed from database."
	message_admins("[key_name_admin(usr)] has removed [ckeyname] from the whitelist.",1)
