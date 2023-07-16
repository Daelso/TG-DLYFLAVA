/datum/antagonist/garou
	name = "Garou"
	antagpanel_category = "Garou"
	job_rank = ROLE_GAROU
	antag_hud_type = ANTAG_HUD_NINJA //leaving as ninja because idk about huds
	antag_hud_name = "space_ninja"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/focused
	///Whether or not this garou will obtain objectives
	var/give_objectives = TRUE
	///Whether or not this garou receives the standard equipment
	var/give_equipment = TRUE

/datum/antagonist/garou/apply_innate_effects(mob/living/mob_override)
	var/mob/living/garou = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, garou)

/datum/antagonist/garou/remove_innate_effects(mob/living/mob_override)
	var/mob/living/garou = mob_override || owner.current
	remove_antag_hud(antag_hud_type, garou)

/**
 * Proc that equips the space ninja outfit on a given individual.  By default this is the owner of the antagonist datum.
 *
 * Proc that equips the space ninja outfit on a given individual.  By default this is the owner of the antagonist datum.
 * Arguments:
 * * ninja - The human to receive the gear
 * * Returns a proc call on the given human which will equip them with all the gear.
 */
/datum/antagonist/garou/proc/equip_space_ninja(mob/living/carbon/human/ninja = owner.current)
	return ninja.equipOutfit(/datum/outfit/ninja)

/**
 * Proc that adds the proper memories to the antag datum
 *
 * Proc that adds the ninja starting memories to the owner of the antagonist datum.
 */
/datum/antagonist/garou/proc/addMemories()
	antag_memory += "My caern has fallen, Gaia cries out for vengeance. The Wyrm-Spawn <font color='red'><B>MUST PAY</B></font>!<br>"
	antag_memory += "You're lost to hauglosk, raging down from the redwood forests you bring the vengeance of Gaia. Create a legendary ending to your tale.<br>"

/datum/objective/gaias_vengeance
	explanation_text = "Rip apart at least 5 wyrm-spawn."


/**
 * Proc that adds all the ninja's objectives to the antag datum.
 *
 * Proc that adds all the ninja's objectives to the antag datum.  Called when the datum is gained.
 */
/datum/antagonist/garou/proc/addObjectives()

	//Door jacks, flag will be set to complete on when the last door is hijacked
	var/datum/objective/door_jack/doorobjective = new /datum/objective/door_jack()
	doorobjective.doors_required = rand(15,40)
	doorobjective.explanation_text = "Use your gloves to doorjack [doorobjective.doors_required] airlocks on the station."
	objectives += doorobjective

	//Die for Gaia
	var/datum/objective/martyr/martyrdom = new
	martyrdom.owner = owner
	objectives += martyrdom

/datum/antagonist/garou/greet()
	SEND_SOUND(owner.current, sound('sound/voice/howl.ogg'))
	to_chat(owner.current, "My caern has fallen, Gaia cries out for vengeance. The Wyrm-Spawn<font color='red'><B>MUST PAY</B></font>!<br>")
	to_chat(owner.current, "You're lost to hauglosk, raging down from the redwood forests you bring the vengeance of Gaia. Create a legendary ending to your tale.<br>")
	owner.announce_objectives()

/datum/antagonist/garou/on_gain()
	addMemories()

	if(give_objectives)
		addObjectives()

	if(give_equipment)
		equip_space_ninja(owner.current)

	owner.current.mind.assigned_role = ROLE_GAROU
	owner.current.mind.special_role = ROLE_GAROU
	return ..()

/datum/antagonist/garou/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_GAROU
	new_owner.special_role = ROLE_GAROU
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has given [key_name_admin(new_owner)] the Garou antag role.")
	log_admin("[key_name(admin)] has given [key_name(new_owner)] the Garou antag role.")
