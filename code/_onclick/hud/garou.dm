/datum/hud/garou
	ui_style = 'icons/hud/screen_ghost.dmi'

//fancy animations
/atom/movable/screen/garou/MouseEntered()
	flick(icon_state + "_anim", src)



/atom/movable/screen/garou/crinos
	icon_state = "orbit"
	// Name and description get given their proper values on Initialize()
	name = "Produce Node Blob (ERROR)"
	desc = "Produces a node blob for ERROR resources.<br>Node blobs will expand and activate nearby resource and factory blobs."

/atom/movable/screen/garou/crinos/Initialize()
	. = ..()
	name = "Crinos"
	desc = "Chimp out!"


/atom/movable/screen/garou/crinos/Click()
	to_chat(src, "Henlo")


/datum/hud/garou/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/garou/crinos()
	using.screen_loc = ui_ghost_jumptomob //idc where it goes for now
	using.hud = src
	static_inventory += using

