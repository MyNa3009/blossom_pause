Config = {}

-- Main menu title
Config.ServerTitle = "Pause Menu"

-- Subtitle below the main title
Config.ServerSubtitle = "Game is Paused"

-- Footer text at the bottom (version info, etc.)
Config.FooterVersion = "SERVER UI VERSION 2.1"

-- Menu buttons configuration
-- Each button can have:
-- label: Display text
-- icon: Font Awesome icon class
-- action: Callback action name (resume, map, quit, close)
-- link: External URL to open
-- isQuit: Adds spacing before button and special styling
Config.Buttons = {
    {
        label = "Continue",
        icon = "fa-solid fa-play",
        action = "resume"
    },
    {
        label = "Map",
        icon = "fa-solid fa-map-location-dot",
        action = "map"
    },
    {
        label = "Discord",
        icon = "fa-brands fa-discord",
        link = "https://discord.gg/beispiel"
    },
    {
        label = "Tebex",
        icon = "fa-solid fa-gem",
        link = "https://shop.beispiel.de"
    },
    {
        label = "Leave",
        icon = "fa-solid fa-right-from-bracket",
        action = "quit",
        isQuit = true
    }
}

-- Color customization
-- primary: Main accent color for highlights and glows
-- accent: Secondary accent color (currently unused in design)
Config.Colors = {
    primary = "#E24997"
}

-- Controls to disable while menu is open
-- Full list prevents player actions during menu usage
Config.DisableControls = {
    1, 2, 3, 4, 5, 6,
    14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
    45, 47, 55, 56, 57,
    73, 74, 75, 76,
    81, 82, 83, 84, 85, 86,
    91, 92,
    99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
    140, 141, 142, 143,
    199, 200,
    257, 263, 264
}