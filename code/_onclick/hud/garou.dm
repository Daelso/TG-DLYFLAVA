/datum/hud/garou
	ui_style = 'icons/hud/screen_ghost.dmi'

//fancy animations
/atom/movable/screen/garou/MouseEntered()
	flick(icon_state + "_anim", src)


/atom/movable/screen/garou/crinos
	name = "Crinos"
	icon_state = "orbit"

/atom/movable/screen/garou/orbit/Click()
	usr >> 'meme'


/datum/hud/garou/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/garou/crinos()
	using.screen_loc = ui_ghost_jumptomob //idc where it goes for now
	using.hud = src
	static_inventory += using

