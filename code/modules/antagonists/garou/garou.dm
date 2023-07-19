/datum/antagonist/garou
	name = "Garou"
	antagpanel_category = "Garou"
	job_rank = ROLE_GAROU
	antag_hud_type = ANTAG_HUD_GAROU//leaving as ninja because idk about huds
	antag_hud_name = "garou"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/badass_antag
	///Whether or not this garou will obtain objectives
	var/give_objectives = TRUE

	var/rage = 3 //Start right in the middle at 3 rage
	var/min_rage = 1
	var/max_rage = 5

/datum/antagonist/garou/apply_innate_effects(mob/living/mob_override)
	var/mob/living/garou = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, garou)

/datum/antagonist/garou/remove_innate_effects(mob/living/mob_override)
	var/mob/living/garou = mob_override || owner.current
	remove_antag_hud(antag_hud_type, garou)

/**
 * Proc that adds the proper memories to the antag datum
 *
 */
/datum/antagonist/garou/proc/addMemories()
	antag_memory += "My caern has fallen, Gaia cries out for vengeance. The Wyrm-Spawn <font color='red'><B>MUST PAY</B></font>!<br>"
	antag_memory += "You're lost to hauglosk, raging down from the redwood forests you bring the vengeance of Gaia. Create a legendary ending to your tale.<br>"

/datum/antagonist/garou/proc/addObjectives()
	//Door jacks, flag will be set to complete on when the last door is hijacked
	var/datum/objective/gaias_vengeance/killobj = new /datum/objective/gaias_vengeance
	killobj.wyrm_kills = rand(5,15)
	killobj.explanation_text = "Gaia screams for revenge, rid her of [killobj.wyrm_kills] wyrm-spawn."
	objectives += killobj

	//Die for Gaia
	var/datum/objective/martyr/martyrdom = new
	martyrdom.owner = owner
	objectives += martyrdom


/datum/objective/gaias_vengeance
	var/wyrm_kills = 0



/datum/antagonist/garou/greet()
	SEND_SOUND(owner.current, sound('sound/voice/howl.ogg'))
	to_chat(owner.current, "My caern has fallen, Gaia cries out for vengeance. The Wyrm-Spawn<font color='red'><B>MUST PAY</B></font>!<br>")
	to_chat(owner.current, "You're lost to hauglosk, raging down from the redwood forests you bring the vengeance of Gaia. Create a legendary ending to your tale.<br>")
	owner.announce_objectives()

/datum/antagonist/garou/on_gain()
	addMemories()

	if(give_objectives)
		addObjectives()

	owner.current.mind.assigned_role = ROLE_GAROU
	owner.current.mind.special_role = ROLE_GAROU
	return ..()

/datum/antagonist/garou/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_GAROU
	new_owner.special_role = ROLE_GAROU
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has given [key_name_admin(new_owner)] the Garou antag role.")
	log_admin("[key_name(admin)] has given [key_name(new_owner)] the Garou antag role.")
