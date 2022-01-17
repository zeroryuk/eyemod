-- This information tells other players more about the mod
name = "Enhanced Eye mask and Shield of Terror"
description =  [[
    This mod makes Eye Mask and Shield of Terror easier to use.
    Adds a config for Eye Mask and Shield of Terror.
    Makes them not disappear at 0% and also not work. (Can be disabled in the config)
    Repairs faster like a bone armor. (Can be disabled in the config)
            ]]
author = "ZeroRyuk"
version = "1.0.0" -- This is the version of the template. Change it to your own number.

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"item",
}

local function Title(title)
    return {
        name=title,
        hover = "",
        options={{description = "", data = 0}},
        default = 0,
        }
end



configuration_options = {
    Title("Faster Animation"),
    {
		name = "custom_eye_feed", 
		label = "Faster Feeding Animation",
		options = 
		{
			{description = "True (Default)", data = true},
			{description = "False", data = false},
		},
		default = true,
	},
    Title("Won't break at 0%"),
    {
		name = "custom_eye_ubreakable", 
		label = "Doesn't break like Bone Armor",
		hover = "Eye Mask and Shield of Terror won't break on 0",
		options = 
		{
			{description = "True (Default)", data = true},
			{description = "False", data = false},
		},
		default = true,
	},
    Title("Durability (HP)"),
	{
		name = "custom_eye_m_dur", 
		label = "Eye Mask Durability (HP)",
		hover = "DEFAULT = No change",
		options = 
		{
			{description = "DEFAULT", data = 0},
			{description = "150", data = 150},
            {description = "200", data = 200},
			{description = "300", data = 300},
            {description = "400", data = 400},
            {description = "500", data = 500},
            {description = "600", data = 600},
            {description = "700", data = 700},
            {description = "800", data = 800},
            {description = "900", data = 900},
            {description = "1000", data = 1000},
			{description = "INFINITE", data = 9999},
		},
		default = 0,
	},
    {
		name = "custom_eye_s_dur", 
		label = "Shield of Terror Durability (HP)",
		hover = "DEFAULT = No change",
		options = 
		{
			{description = "DEFAULT", data = 0},
			{description = "150", data = 150},
            {description = "200", data = 200},
			{description = "300", data = 300},
            {description = "400", data = 400},
            {description = "500", data = 500},
            {description = "600", data = 600},
            {description = "700", data = 700},
            {description = "800", data = 800},
            {description = "900", data = 900},
            {description = "1000", data = 1000},
			{description = "INFINITE", data = 9999},
		},
		default = 0,
	},
    Title("Damage Absorbed/Blocked"),
	{
		name = "custom_eye_m_abs", 
		label = "Eye Mask Absorbed",
		hover = "How much damage it blocks",
        options =		
        {
			{description = "0%", data = 0},
			{description = "10%", data = 10},
            {description = "20%", data = 20},
			{description = "30%", data = 30},
            {description = "40%", data = 40},
            {description = "50%", data = 50},
            {description = "60%", data = 60},
            {description = "70%", data = 70},
            {description = "80%", data = 80},
            {description = "90%", data = 90},
            {description = "100%", data = 100},
		},
		default = 80,
	},
    {
		name = "custom_eye_s_abs", 
		label = "Shield of Terror Absorbed",
		hover = "How much damage it blocks",
        options =		
        {
			{description = "0%", data = 0},
			{description = "10%", data = 10},
            {description = "20%", data = 20},
			{description = "30%", data = 30},
            {description = "40%", data = 40},
            {description = "50%", data = 50},
            {description = "60%", data = 60},
            {description = "70%", data = 70},
            {description = "80%", data = 80},
            {description = "90%", data = 90},
            {description = "100%", data = 100},
		},
		default = 80,
	},
    Title("Attack Damage"),
    {
        name = "custom_eye_s_dmg",
        label = "Shield of Terror DMG",
        options =
        {
            {description = "17", data = 17},
            {description = "34", data = 34 , hover = "Same with Spear"},
            {description = "51 (Default)", data = 51, hover = "Same with Tentacle Spike"},
            {description = "68", data = 68, hover = "Same with Dark Sword"},
            {description = "102", data = 102},
        },
        default = 51,
    },
}
