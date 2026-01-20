RegisterServerEvent('blossom_pause:disconnect')
AddEventHandler('blossom_pause:disconnect', function()
    local src = source
    DropPlayer(src, 'You left the server via the pause menu.')
end)