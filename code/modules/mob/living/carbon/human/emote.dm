/mob/living/carbon/human/emote(var/act,var/m_type=1,var/message = null, var/auto)
	var/param = null
	var/toilet = get_excrement_holder()

	if (findtextEx(act, "-", 1, null))
		var/t1 = findtextEx(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	if(findtextEx(act,"s",-1) && !findtextEx(act,"_",-2))//Removes ending s's unless they are prefixed with a '_'
		act = copytext(act,1,length(act))

	var/muzzled = istype(src.wear_mask, /obj/item/clothing/mask/muzzle)
	//var/m_type = VISIBLE

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

	if(src.stat == 2.0 && (act != "deathgasp"))
		return

	if(act == "oath" && src.miming)
		src.miming = 0
		for(var/obj/effect/proc_holder/spell/aoe_turf/conjure/mime_wall/s in src.spell_list)
			del(s)
		message_admins("[src.name] ([src.ckey]) has broken their oath of silence. (<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</a>)")
		src << "\red An unsettling feeling surrounds you..."
		return

	switch(act)
		if ("airguitar")
			if (!src.restrained())
				message = "<B>[src]</B> is strumming the air and headbanging like a safari chimp."
				m_type = VISIBLE

		if ("blink")
			message = "<B>[src]</B> blinks."
			m_type = VISIBLE

		if ("blink_r")
			message = "<B>[src]</B> blinks rapidly."
			m_type = VISIBLE

		if ("bow")
			if (!src.buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (param == A.name)
							M = A
							break
				if (!M)
					param = null

				if (param)
					message = "<B>[src]</B> bows to [param]."
				else
					message = "<B>[src]</B> bows."
			m_type = VISIBLE

		if ("custom")
			var/input = copytext(sanitize(input("Choose an emote to display.") as text|null),1,MAX_MESSAGE_LEN)
			if (!input)
				return
			var/input2 = input("Is this a visible or hearable emote?") in list("Visible","Hearable")
			if (input2 == "Visible")
				m_type = VISIBLE
			else if (input2 == "Hearable")
				if (src.miming)
					return
				m_type = HEARABLE
			else
				alert("Unable to use this emote, must be either hearable or visible.")
				return
			return custom_emote(m_type, message)

		if ("me")
			if(silent)
				return
			if (src.client)
				if (client.prefs.muted & MUTE_IC)
					src << "\red You cannot send IC messages (muted)."
					return
				if (src.client.handle_spam_prevention(message,MUTE_IC))
					return
			if (stat)
				return
			if(!(message))
				return
			return custom_emote(m_type, message)

		if ("salute")
			if (!src.buckled)
				var/M = null
				if (param)
					for (var/mob/A in view(null, null))
						if (param == A.name)
							M = A
							break
				if (!M)
					param = null

				if (param)
					message = "<B>[src]</B> salutes to [param]."
				else
					message = "<B>[src]</b> salutes."
			m_type = VISIBLE

		if ("choke")
			if(miming)
				message = "<B>[src]</B> clutches his throat desperately!"
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> chokes!"
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a strong noise."
					m_type = HEARABLE

		if ("clap")
			if (!src.restrained())
				message = "<B>[src]</B> claps."
				m_type = HEARABLE
				if(miming)
					m_type = VISIBLE
		if ("flap")
			if (!src.restrained())
				message = "<B>[src]</B> flaps his wings."
				m_type = HEARABLE
				if(miming)
					m_type = VISIBLE

		if ("aflap")
			if (!src.restrained())
				message = "<B>[src]</B> flaps his wings ANGRILY!"
				m_type = HEARABLE
				if(miming)
					m_type = VISIBLE

		if ("drool")
			message = "<B>[src]</B> drools."
			m_type = VISIBLE

		if ("eyebrow")
			message = "<B>[src]</B> raises an eyebrow."
			m_type = VISIBLE

		if ("chuckle")
			if(miming)
				message = "<B>[src]</B> appears to chuckle."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> chuckles."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a noise."
					m_type = HEARABLE

		if ("twitch")
			message = "<B>[src]</B> twitches violently."
			m_type = VISIBLE

		if ("twitch_s")
			message = "<B>[src]</B> twitches."
			m_type = VISIBLE

		if ("faint")
			message = "<B>[src]</B> faints."
			if(src.sleeping)
				return //Can't faint while asleep
			src.sleeping += 10 //Short-short nap
			m_type = VISIBLE

		if ("cough")
			if(miming)
				message = "<B>[src]</B> appears to cough!"
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> coughs!"
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a strong noise."
					m_type = HEARABLE

		if ("frown")
			message = "<B>[src]</B> frowns."
			m_type = VISIBLE

		if ("nod")
			message = "<B>[src]</B> nods."
			m_type = VISIBLE

		if ("blush")
			message = "<B>[src]</B> blushes."
			m_type = VISIBLE

		if ("wave")
			message = "<B>[src]</B> waves."
			m_type = VISIBLE

		if ("gasp")
			if(miming)
				message = "<B>[src]</B> appears to be gasping!"
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> gasps!"
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a weak noise."
					m_type = HEARABLE

		if ("deathgasp")
			if(M_ELVIS in mutations)
				src.emote("fart")
				message = "<B>[src]</B> has left the building..."
			if(M_HARDCORE in mutations)
				message = "<B>[src]</B> whispers with his final breath, <i>'i told u i was hardcore..'</i>"
			else
				message = "<B>[src]</B> seizes up and falls limp, \his eyes dead and lifeless..."
			m_type = VISIBLE

		if ("giggle")
			if(miming)
				message = "<B>[src]</B> giggles silently!"
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> giggles."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a noise."
					m_type = HEARABLE

		if ("glare")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> glares at [param]."
			else
				message = "<B>[src]</B> glares."

		if ("stare")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> stares at [param]."
			else
				message = "<B>[src]</B> stares."

		if ("look")
			var/M = null
			if (param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break

			if (!M)
				param = null

			if (param)
				message = "<B>[src]</B> looks at [param]."
			else
				message = "<B>[src]</B> looks."
			m_type = VISIBLE

		if ("grin")
			message = "<B>[src]</B> grins."
			m_type = VISIBLE

		if ("cry")
			if(miming)
				message = "<B>[src]</B> cries."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> cries."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a weak noise. \He frowns."
					m_type = HEARABLE

		if ("sigh")
			if(miming)
				message = "<B>[src]</B> sighs."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> sighs."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a weak noise."
					m_type = HEARABLE

		if ("laugh")
			if(miming)
				message = "<B>[src]</B> acts out a laugh."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> laughs."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a noise."
					m_type = HEARABLE

		if ("mumble")
			message = "<B>[src]</B> mumbles!"
			m_type = HEARABLE
			if(miming)
				m_type = VISIBLE

		if ("grumble")
			if(miming)
				message = "<B>[src]</B> grumbles!"
				m_type = VISIBLE
			if (!muzzled)
				message = "<B>[src]</B> grumbles!"
				m_type = HEARABLE
			else
				message = "<B>[src]</B> makes a noise."
				m_type = HEARABLE

		if ("groan")
			if(miming)
				message = "<B>[src]</B> appears to groan!"
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> groans!"
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a loud noise."
					m_type = HEARABLE

		if ("moan")
			if(miming)
				message = "<B>[src]</B> appears to moan!"
				m_type = VISIBLE
			else
				message = "<B>[src]</B> moans!"
				m_type = HEARABLE

		if ("johnny")
			var/M
			if (param)
				M = param
			if (!M)
				param = null
			else
				if(miming)
					message = "<B>[src]</B> takes a drag from a cigarette and blows \"[M]\" out in smoke."
					m_type = VISIBLE
				else
					message = "<B>[src]</B> says, \"[M], please. He had a family.\" [src.name] takes a drag from a cigarette and blows his name out in smoke."
					m_type = HEARABLE

		if ("point")
			if (!src.restrained())
				var/atom/object_pointed = null

				if(param)
					for(var/atom/visible_object as turf | obj | mob in view())
						if(param == visible_object.name)
							object_pointed = visible_object
							break

				if(isnull(object_pointed))
					message = "<B>[src]</B> points."
				else
					pointed(object_pointed)

			m_type = VISIBLE

		if ("raise")
			if (!src.restrained())
				message = "<B>[src]</B> raises a hand."
			m_type = VISIBLE

		if("shake")
			message = "<B>[src]</B> shakes \his head."
			m_type = VISIBLE

		if ("shrug")
			message = "<B>[src]</B> shrugs."
			m_type = VISIBLE

		if ("signal")
			if (!src.restrained())
				var/t1 = round(text2num(param))
				if (isnum(t1))
					if (t1 <= 5 && (!src.r_hand || !src.l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
					else if (t1 <= 10 && (!src.r_hand && !src.l_hand))
						message = "<B>[src]</B> raises [t1] finger\s."
			m_type = VISIBLE

		if ("smile")
			message = "<B>[src]</B> smiles."
			m_type = VISIBLE

		if ("shiver")
			message = "<B>[src]</B> shivers."
			m_type = HEARABLE
			if(miming)
				m_type = VISIBLE

		if ("pale")
			message = "<B>[src]</B> goes pale for a second."
			m_type = VISIBLE

		if ("tremble")
			message = "<B>[src]</B> trembles in fear!"
			m_type = VISIBLE

		if ("sneeze")
			if (miming)
				message = "<B>[src]</B> sneezes."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> sneezes."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a strange noise."
					m_type = HEARABLE

		if ("sniff")
			message = "<B>[src]</B> sniffs."
			m_type = HEARABLE
			if(miming)
				m_type = VISIBLE

		if ("snore")
			if (miming)
				message = "<B>[src]</B> sleeps soundly."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> snores."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a noise."
					m_type = HEARABLE

		if ("whimper")
			if (miming)
				message = "<B>[src]</B> appears hurt."
				m_type = VISIBLE
			else
				if (!muzzled)
					message = "<B>[src]</B> whimpers."
					m_type = HEARABLE
				else
					message = "<B>[src]</B> makes a weak noise."
					m_type = HEARABLE

		if ("wink")
			message = "<B>[src]</B> winks."
			m_type = VISIBLE

		if ("yawn")
			if (!muzzled)
				message = "<B>[src]</B> yawns."
				m_type = HEARABLE
				if(miming)
					m_type = VISIBLE

		if ("collapse")
			Paralyse(2)
			message = "<B>[src]</B> collapses!"
			m_type = HEARABLE
			if(miming)
				m_type = VISIBLE

		if("hug")
			m_type = VISIBLE
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null

				if (M)
					message = "<B>[src]</B> hugs [M]."
				else
					message = "<B>[src]</B> hugs \himself."

		if ("handshake")
			m_type = VISIBLE
			if (!src.restrained() && !src.r_hand)
				var/mob/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (param == A.name)
							M = A
							break
				if (M == src)
					M = null

				if (M)
					if (M.canmove && !M.r_hand && !M.restrained())
						message = "<B>[src]</B> shakes hands with [M]."
					else
						message = "<B>[src]</B> holds out \his hand to [M]."

		if("dap")
			m_type = VISIBLE
			if (!src.restrained())
				var/M = null
				if (param)
					for (var/mob/A in view(1, null))
						if (param == A.name)
							M = A
							break
				if (M)
					message = "<B>[src]</B> gives daps to [M]."
				else
					message = "<B>[src]</B> sadly can't find anybody to give daps to, and daps \himself. Shameful."

		if ("scream")
			if (miming)
				message = "<B>[src]</B> acts out a scream!"
				m_type = VISIBLE
			else
				if(!stat)
					if (!muzzled)
						if (auto == 1)
							if(world.time-lastScream >= 30)//prevent scream spam with things like poly spray
								message = "<B>[src]</B> screams in agony!"
								var/list/screamSound = list('sound/misc/malescream1.ogg', 'sound/misc/malescream2.ogg', 'sound/misc/malescream3.ogg', 'sound/misc/malescream4.ogg', 'sound/misc/malescream5.ogg', 'sound/misc/wilhelm.ogg', 'sound/misc/goofy.ogg')
								if (src.gender == FEMALE) //Females have their own screams. Trannys be damned.
									screamSound = list('sound/misc/femalescream1.ogg', 'sound/misc/femalescream2.ogg', 'sound/misc/femalescream3.ogg', 'sound/misc/femalescream4.ogg', 'sound/misc/femalescream5.ogg')
								var/scream = pick(screamSound)//AUUUUHHHHHHHHOOOHOOHOOHOOOOIIIIEEEEEE
								playsound(get_turf(src), scream, 50, 0)
								m_type = HEARABLE
								lastScream = world.time
						else
							message = "<B>[src]</B> screams!"
							m_type = HEARABLE
					else
						message = "<B>[src]</B> makes a very loud noise."
						m_type = HEARABLE

		// Needed for M_TOXIC_FART
		if("fart")
			if (fail_farts >= 10 && !superfart_processing)
				emote("superfart")
				return
			if(src.op_stage.butt != 4)
				if(world.time-lastFart <  40 && !superfart_processing)//4 seconds
					usr << "<span class='warning'>You feeling like your ass cracking. Uh-oh...</span>"
					fail_farts ++
				for(var/obj/item/weapon/storage/bible/B in src.loc)//Goon's feature
					if(B)
						message = "<span class='alert'> <B>[src]</B> farts on the bible and then blows up!</span>"
						src.gib()
						var/obj/item/clothing/head/butt/Bt = new /obj/item/clothing/head/butt(src.loc)
						Bt.transfer_buttdentity(src)
				if (src.nutrition >= 250)
					for(var/mob/M in view(0))
						if(M != src && M.loc == src.loc)
							if(!miming)
								visible_message("<span class = 'warning'><b>[src]</b> farts in <b>[M]</b>'s face!</span>")
							else
								visible_message("<span class = 'warning'><b>[src]</b> silently farts in <b>[M]</b>'s face!</span>")
						else
							continue

					var/turf/location = get_turf(src)
					var/aoe_range=2 // Default
					if(M_SUPER_FART in mutations)
						aoe_range+=3 //Was 5

					// If we're wearing a suit, don't blast or gas those around us.
					var/wearing_suit=0
					var/wearing_mask=0
					if(wear_suit && wear_suit.body_parts_covered & LOWER_TORSO)
						wearing_suit=1
						if (internal != null && wear_mask && (wear_mask.flags & MASKINTERNALS))
							wearing_mask=1

					// Process toxic farts first.
					if(M_TOXIC_FARTS in mutations)
						message=""
						playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
						playsound(get_turf(src), 'sound/misc/fart.ogg', 50, 1)
						if(wearing_suit)
							src << "<span class = 'warning'>You gas yourself!</span>"
							if(!wearing_mask)
								reagents.add_reagent("jenkem", rand(10,50))
						else
							// Was /turf/, now /mob/
							for(var/mob/M in view(location,aoe_range))
								if (M.internal != null && M.wear_mask && (M.wear_mask.flags & MASKINTERNALS))
									continue
								if(!airborne_can_reach(location,get_turf(M),aoe_range))
									continue
								M.reagents.add_reagent("jenkem",rand(1,50))

					if(M_SUPER_FART in mutations)
						message=""
						playsound(get_turf(src), 'sound/effects/superfart.ogg', 50, 1)
						visible_message("<span class = 'warning'><b>[name]</b> hunches down and grits their teeth!</span>")
						if(do_after(usr,30))
							visible_message("<span class = 'warning'><b>[name]</b> unleashes a [pick("tremendous","gigantic","colossal")] fart!</span>","<span class = 'warning'>You hear a [pick("tremendous","gigantic","colossal")] fart.</span>")
							//playsound(L.loc, 'superfart.ogg', 50, 0)
							if(!wearing_suit)
								for(var/mob/living/V in view(src,aoe_range))
									shake_camera(V,10,5)
									if (V == src)
										continue
									V << "<span class = 'danger'>You're sent flying!</span>"
									V.Weaken(5) // why the hell was this set to 12 christ
									step_away(V,location,15)
									step_away(V,location,15)
									step_away(V,location,15)
						else
							usr << "<span class = 'notice'>You were interrupted and couldn't fart! Rude!</span>"
					else
						var/list/smells = list(
							"burrito filling",
							"Discount Dan's",
							"Danito Burritos",
							"The Captain's purfume",
							"George Melon's breath",
							"The Aristocrats",
							"the station's toilets",
							"a fart",
							"a yiffe-con",
							"The Chaplain's bible",
							"The Captain's old pet mouse Whiskers",
							"The Captain's cigar",
							"a chicken",
							"neckbeards",
							"Ian",
							"early 21st century internet",
							"Soylent Surprise!",
							"George Melons' perfume!",
							"atmos in here now!",
							"Tiny Turtle.",

							"medbay in here now!"
							)
						var/smell = pick(smells)
						var/list/farts = list(
							"farts",
							"passes wind",
							"toots",
							"farts [pick("lightly", "tenderly", "softly", "with care")]",
							"farts with the force of one thousand suns",
							"farts like a farting motherfucker",
							"nearly shits themself",
							"almost shit their pants",
							"flatulates",
							"lets out their anal exhaust",
							"farts a ten second long fart",
							"<span class = 'sans'>farts</span>",
							"farts like an asshole",
							"nearly fucking craps themself",
							"doesn't fart. Just kidding",
							"tries not to fart, but fails",
							"burps, the burp smells like a fart",
							"farts. Now it smells like [smell] in here",
							"lets out a girly little 'toot' from butt.",
							"farts loudly!",
							"lets one rip!",
							"farts! It sounds wet and smells like [smell].",
							"farts robustly!",
							"farted! It reminds you of your grandmother's queefs.",
							"groans and moans, farting like the world depended on it.",
							"breaks wind!",
							"expels intestinal gas through the anus.",
							"release an audible discharge of intestinal gas.",
							"suffers from flatulence!",
							"farts like a goone!",
							"farts and fondles YOUR buttocks.",
							"farts out pure plasma! <span class = 'warning'><B>FUCK!</B></span>",
							"farts out pure oxygen. What the fuck did he eat?",
							"<B>\red f \blue a \black r \red t \blue s \black</B>!",
							"laughs! It smells like [smell].",
							"farts like a pubby!"
							)

						if(miming)
							farts = list("silently farts.", "acts out a fart.", "lets out a silent but deadly fart.")

						var/fart = pick(farts)

						if(!miming)
							message = "<b>[src]</b> [fart]."
							if(mind && mind.assigned_role == "Clown")
								playsound(get_turf(src), pick('sound/items/bikehorn.ogg','sound/items/AirHorn.ogg'), 50, 1)
							else
								playsound(get_turf(src), 'sound/misc/fart.ogg', 50, 1)
						else
							message = "<b>[src]</b> [fart]"

						m_type = HEARABLE
					lastFart=world.time
			else
				message = "<b>[src]</b> strains, and nothing happens."
				m_type = VISIBLE


		if("superfart")
			if(src.op_stage.butt == 4)
				src << "\blue You don't have a butt!"
				return
			if(src.superfart_processing >= 1)
				return
			else
				if(M_SUPER_FART in mutations)
					emote("fart")
				else
					superfart_processing = 1
					for(var/i = 1, i <= 15, i++)
						emote("fart")
						sleep(1)
					anus_bombanull()

		if(("poo") || ("poop") || ("shit") || ("crap"))

			if (!wanttopoo || src.nutrition < 300)
				src.emote("fart")
				m_type = HEARABLE
			else if(toilet)
				message = "<B>[src]</B> poos in [toilet]."
				playsound(src.loc, 'sound/misc/fart.ogg', 60, 1)
				playsound(src.loc, 'sound/misc/squishy.ogg', 40, 1)
				var/obj/item/weapon/reagent_containers/food/snacks/poo/V = new/obj/item/weapon/reagent_containers/food/snacks/poo(toilet)
				if(src.reagents)
					src.reagents.trans_to(V, 10)
				src.nutrition -= 80
				wanttopoo = 0
				m_type = HEARABLE
			else
				if (src.w_uniform)
					message = "<B>[src]</B> poos in their uniform."
					src.w_uniform.add_poo(src)
					playsound(src.loc, 'sound/misc/fart.ogg', 60, 1)
					playsound(src.loc, 'sound/misc/squishy.ogg', 40, 1)
					src.nutrition -= 80
					m_type = HEARABLE
				else
					message = "<B>[src]</B> poos on the floor."
					playsound(src.loc, 'sound/misc/fart.ogg', 60, 1)
					playsound(src.loc, 'sound/misc/squishy.ogg', 40, 1)
					wanttopoo = 0

					var/obj/effect/decal/cleanable/poo/D = new/obj/effect/decal/cleanable/poo(get_turf(src))
					if(src.reagents)
						src.reagents.trans_to(D, 10)

					var/obj/item/weapon/reagent_containers/food/snacks/poo/V = new/obj/item/weapon/reagent_containers/food/snacks/poo(get_turf(src))
					if(src.reagents)
						src.reagents.trans_to(V, 10)

					src.nutrition -= 80
					m_type = HEARABLE

					// check for being in sight of a working security camera
					if(seen_by_camera(src))
						// determine the name of the perp (goes by ID if wearing one)
						var/perpname = src.name
						if(!/obj/item/device/pda && src:wear_id && src:wear_id:registered_name)
							perpname = src:wear_id:registered_name
						else
							perpname = src.name

						// find the matching security record
						for(var/datum/data/record/R in data_core.general)
							if(R.fields["name"] == perpname)
								for (var/datum/data/record/S in data_core.security)
									if (S.fields["id"] == R.fields["id"])
										// now add to rap sheet
										S.fields["criminal"] = "*Arrest*"
										S.fields["mi_crim"] = "Public defecation"
										break

		if(("pee") || ("urinate") || ("piss"))
			if(!src.reagents || src.hydration <= 300 || !wanttopee)
				message = "<B>[src]</B> attempts to urinate but nothing comes out."
			else
				if(toilet)
					message = "<B>[src]</B> urinates in [toilet]."
					src.hydration -= 80
					wanttopee = 0
					m_type = VISIBLE
				else
					var/obj/effect/decal/cleanable/urine/D = new/obj/effect/decal/cleanable/urine(get_turf(src))
					if(src.reagents)
						src.reagents.trans_to(D, 10)
					message = "<B>[src]</B> urinates on the floor."
					src.hydration -= 80
					wanttopee = 0
					m_type = VISIBLE
				// check for being in sight of a working security camera
					if(seen_by_camera(src))
						// determine the name of the perp (goes by ID if wearing one)
						var/perpname = src.name
						if(!/obj/item/device/pda && src:wear_id && src:wear_id:registered_name)
							perpname = src:wear_id:registered_name
						else
							perpname = src.name

						// find the matching security record
						for(var/datum/data/record/R in data_core.general)
							if(R.fields["name"] == perpname)
								for (var/datum/data/record/S in data_core.security)
									if (S.fields["id"] == R.fields["id"])
										// now add to rap sheet
										S.fields["criminal"] = "*Arrest*"
										S.fields["mi_crim"] = "Public urination"
										break
					for(var/mob/M in viewers(src, null))
						if(!M.stat && getBrainLoss() >= 60)
							spawn(10)
								if(prob(20))
									switch(pick(1,2,3))
										if(1)
											M.say("[M == src ? "i" : src.name] made pee pee, heeheeheeeeeeee!")
										if(2)
											M.emote("giggle")
										if(3)
											M.emote("clap")

		if(("vomit") || ("puke") || ("throwup"))
			if(!lastpuke)
				lastpuke = 1
			if(!src.reagents || src.nutrition <= 300)
				message = "<B>[src]</B> attempts to vomit but nothing comes out."
			else
				Stun(5)
				playsound(loc, 'sound/effects/splat.ogg', 50, 1)
				if(src.dizziness)
					src.dizziness -= rand(2,15)
				if(src.drowsyness)
					src.drowsyness -= rand(2,15)
				if(src.stuttering)
					src.stuttering -= rand(2,15)
				if(src.confused)
					src.confused -= rand(2,15)
				if(src.species.name != "Tajaran")
					src.nutrition -= 40
					src.hydration -= 40
					adjustToxLoss(-3)
				if(toilet)
					if(src.species.name == "Tajaran")
						message = "<b>[src]</b> hacks up a hairball into the [toilet]!"
					else
						message = "<b>[src]</b> throws up into [toilet]!"
					var/obj/effect/decal/cleanable/vomit/V = new/obj/effect/decal/cleanable/vomit(toilet)
					if(src.reagents)
						src.reagents.trans_to(V, 10)
				else
					if(src.species.name == "Tajaran")
						message = "<b>[src]</b> hacks up a hairball!"
					else
						message = "<b>[src] throws up!</b>"
					var/obj/effect/decal/cleanable/vomit/V = new/obj/effect/decal/cleanable/vomit(src.loc)
					if(src.reagents)
						src.reagents.trans_to(V, 10)
				spawn(350)	//wait 35 seconds before next volley
					lastpuke = 0
			m_type = VISIBLE


		if ("help")
			src << "blink, blink_r, blush, bow-(none)/mob, burp, choke, chuckle, clap, collapse, cough,\ncry, custom, deathgasp, drool, eyebrow, frown, gasp, giggle, groan, grumble, handshake, hug-(none)/mob, glare-(none)/mob,\ngrin, laugh, look-(none)/mob, moan, mumble, nod, pale, point-atom, raise, salute, shake, shiver, shrug,\nsigh, signal-#1-10, smile, sneeze, sniff, snore, stare-(none)/mob, tremble, twitch, twitch_s, whimper,\nwink, yawn"

		else
			src << "\blue Unusable emote '[act]'. Say *help for a list."





	if (message)
		log_emote("[name]/[key] (@[x],[y],[z]): [message]")

 //Hearing gasp and such every five seconds is not good emotes were not global for a reason.
 // Maybe some people are okay with that.

		for(var/mob/M in dead_mob_list)
			if(!M.client || istype(M, /mob/new_player))
				continue //skip monkeys, leavers and new players
			if(M.stat == DEAD && (M.client.prefs.toggles & CHAT_GHOSTSIGHT) && !(M in viewers(src,null)))
				M.show_message(message)


		if (m_type & 1)
			for (var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
		else if (m_type & 2)
			for (var/mob/O in hearers(src.loc, null))
				O.show_message(message, m_type)

/mob/living/carbon/human/verb/pose()
	set name = "Set Pose"
	set desc = "Sets a description which will be shown when someone examines you."
	set category = "IC"

	pose =  copytext(sanitize_uni(input(usr, "This is [src]. \He is...", "Pose", null)  as text), 1, MAX_MESSAGE_LEN)


/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavour Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	flavor_text =  copytext(sanitize(input(usr, "Please enter your new flavour text.", "Flavour text", null)  as text), 1)

//Emote helpers & procs
/mob/living/carbon/human/proc/anus_bombanull()
	src.op_stage.butt = 4
	src.Weaken(12)
	flick("e_flash", src.flash)
	var/obj/item/clothing/head/butt/B = new /obj/item/clothing/head/butt(src.loc)
	B.transfer_buttdentity(src)
	new /obj/effect/decal/cleanable/poo(src.loc)
	world << sound('sound/effects/superfart.ogg')
	loc << "<B>[src]</B>'s butt explodes!"
	src.Weaken(12)
	var/datum/organ/external/affecting = src.get_organ("groin")
	if(affecting)
		if(affecting.take_damage(40, 10))
			src.UpdateDamageIcon()
		src.updatehealth()
/mob/living/carbon/human/var/fail_farts = 0
/mob/living/carbon/human/var/superfart_processing = 0

/mob/living/carbon/human/proc/get_excrement_holder()
	for(var/obj/O in src.loc)
		if(istype(O, /obj/structure/toilet) && O:open || istype(O, /obj/structure/urinal) || istype(O, /obj/machinery/disposal))
			return O
	return null
