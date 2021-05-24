# qb-shower
Shower For QB-Core
Made by Mickey#4910 (Mickeystix)

To add additional showers, simply edit the config.lua.
In Config.Locations, add additional location, like so.
Config.Locations = {
    [1] = {
        ["label"] = "Shower",
        ["coords"] = {
            ["x"] = 273.6893,
            ["y"] = -637.8904,
            ["z"] = 13.17408,
        }
    },
    -------------------------------------------Between these is what a new shower addition looks like
    [2] = {
        ["label"] = "Shower #2",
        ["coords"] = {
            ["x"] = 273.6893,
            ["y"] = -639.8904,
            ["z"] = 13.17408,
        }
    },
    -------------------------------------------Between these is what a new shower addition looks like, just copy, paste, change label, and coordinates!
}

Installation:
-Drop qb-shower somewhere in your resources folder.
-Add 'ensure qb-shower' in your resources.cfg
-Restart server