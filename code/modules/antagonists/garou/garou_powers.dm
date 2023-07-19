/datum/action/garou
	name = "Crinos Test"
	background_icon_state = "bg_changeling"
	icon_icon = 'icons/mob/actions/actions_changeling.dmi'
	var/needs_button = TRUE//for passive abilities like hivemind that dont need a button
	var/helptext = "" // Details
	///Maximum stat before the ability is blocked. For example, `UNCONSCIOUS` prevents it from being used when in hard crit or dead, while `DEAD` allows the ability to be used on any stat values.
	var/req_stat = CONSCIOUS
	var/active = FALSE//used by a few powers that toggle

/datum/action/garou/proc/on_receive(src)
	Grant(src)



/datum/action/garou/crinos
	name = "Crinos Form"
	desc = "Tap into your rage and unleash the War Form!"
	button_icon_state = "fake_death"
