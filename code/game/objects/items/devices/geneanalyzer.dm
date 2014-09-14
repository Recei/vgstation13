//Gene analyzer from BS12-Luna


/obj/item/device/geneticsanalyzer
	name = "Genetics Analyser"
	icon = 'device.dmi'
	icon_state = "genetics"
	w_class = 2
	origin_tech = "magnets=4;programming=2"

/obj/item/device/geneticsanalyzer/attack(mob/M as mob, mob/user as mob)
	for(var/mob/O in viewers(M, null))
		O.show_message(text("\red [] has analyzed []'s genetic code!", user, M), 1)
		//Foreach goto(67)
	user.show_message(text("\blue Analyzing Results for [M]: [M.dna.struc_enzymes]\n\t"), 1)
	user.show_message(text("\blue \t Epilepsy: [M.dna.GetSEState(HEADACHEBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Cough: [M.dna.GetSEState(COUGHBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Clumsy: [M.dna.GetSEState(CLUMSYBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Twitch: [M.dna.GetSEState(TWITCHBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Nervous: [M.dna.GetSEState(NERVOUSBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Blind: [M.dna.GetSEState(BLINDBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Deaf: [M.dna.GetSEState(DEAFBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Mute: [M.dna.GetSEState(MUTEBLOCK) ? "Yes" : "No"]"), 1)
	user.show_message(text("\blue \t Fat: [M.dna.GetSEState(FATBLOCK) ? "Yes" : "No"]"), 1)

	var/unknown_genes = 0
	var/list/unknowns = list(HULKBLOCK,
							TELEBLOCK,
							FIREBLOCK,
							XRAYBLOCK,
							NOBREATHBLOCK,
							REMOTEVIEWBLOCK,
							REGENERATEBLOCK,
							INCREASERUNBLOCK,
							REMOTETALKBLOCK,
							MORPHBLOCK,
							HALLUCINATIONBLOCK,
							NOPRINTSBLOCK,
							SHOCKIMMUNITYBLOCK,
							SMALLSIZEBLOCK,
							LOUDBLOCK,
							WHISPERBLOCK,
							DIZZYBLOCK,
							SANSBLOCK,
							SOBERBLOCK,
							PSYRESISTBLOCK,
							SHADOWBLOCK,
							CHAMELEONBLOCK,
							CRYOBLOCK,
							EATBLOCK,
							JUMPBLOCK,
							POLYMORPHBLOCK,
							EMPATHBLOCK,
							SUPERFARTBLOCK,
							RADBLOCK,
							SMILEBLOCK,
							ELVISBLOCK,
							CHAVBLOCK,
							SWEDEBLOCK,
							SCRAMBLEBLOCK,
							TOXICFARTBLOCK,
							STRONGBLOCK,
							HORNSBLOCK,
							IMMOLATEBLOCK,
							MELTBLOCK)
	for(var/unknown in unknowns)
		if(M.dna.GetSEState(unknown))
			unknown_genes += 1
	user.show_message(text("\blue \t Unknown Anomalies: [unknown_genes]"))