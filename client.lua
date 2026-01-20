local menuOpen = false
local mapOpen = false
local disableThreadRunning = false
local lastMenuToggle = 0
local MENU_TOGGLE_COOLDOWN = 500

local function CanToggleMenu()
    local now = GetGameTimer()
    if now - lastMenuToggle < MENU_TOGGLE_COOLDOWN then
        return false
    end
    lastMenuToggle = now
    return true
end

local function SafeDisableControls()
    if disableThreadRunning then return end
    disableThreadRunning = true

    CreateThread(function()
        while menuOpen do
            for _, control in ipairs(Config.DisableControls or {}) do
                DisableControlAction(0, control, true)
            end
            Wait(0)
        end
        disableThreadRunning = false
    end)
end

function OpenPauseMenu()
    if menuOpen or mapOpen then return end
    if not CanToggleMenu() then return end
    
    menuOpen = true
    
    TriggerScreenblurFadeIn(500)
    
    SendNUIMessage({
        action = "open",
        config = Config
    })
    
    SetNuiFocus(true, true)
    SafeDisableControls()
end

function ClosePauseMenu()
    if not menuOpen then return end
    if not CanToggleMenu() then return end
    
    menuOpen = false
    
    TriggerScreenblurFadeOut(500)
    
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
end

RegisterNUICallback('close', function(_, cb)
    ClosePauseMenu()
    cb('ok')
end)

RegisterNUICallback('resume', function(_, cb)
    ClosePauseMenu()
    cb('ok')
end)

RegisterNUICallback('quit', function(_, cb)
    ClosePauseMenu()
    TriggerServerEvent('blossom_pause:disconnect')
    cb('ok')
end)

RegisterNUICallback('map', function(_, cb)
    if not menuOpen then
        cb('ok')
        return
    end
    
    menuOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
    
    Wait(150)
    
    mapOpen = true
    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_MP_PAUSE"), false, -1)
    
    CreateThread(function()
        while mapOpen do
            Wait(100)
            if not IsPauseMenuActive() then
                mapOpen = false
                TriggerScreenblurFadeOut(500)
                Wait(150)
                OpenPauseMenu()
                break
            end
        end
    end)
    
    cb('ok')
end)

RegisterNUICallback('openLink', function(data, cb)
    if data and data.url and data.url ~= '' then
        SendNUIMessage({
            action = "openExternal",
            url = data.url
        })
    end
    cb('ok')
end)

RegisterCommand('pausemenu', function()
    if menuOpen then
        ClosePauseMenu()
    else
        OpenPauseMenu()
    end
end, false)

CreateThread(function()
    local wasPauseActive = false
    
    while true do
        Wait(100)
        
        local isPauseActive = IsPauseMenuActive()
        
        if isPauseActive and not wasPauseActive and not menuOpen and not mapOpen then
            SetFrontendActive(false)
            Wait(100)
            OpenPauseMenu()
        end
        
        wasPauseActive = isPauseActive
    end
end)