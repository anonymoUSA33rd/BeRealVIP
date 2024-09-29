QBCore.Commands.Add('grantPermission', 'Grant vehicle section access', {{name = "player", help = "Player ID"}, {name = "section_id", help = "Section ID"}}, false, function(source, args)
    local playerId = args[1]
    local sectionId = tonumber(args[2])
    local identifier = GetPlayerIdentifier(playerId)
    
    exports.oxmysql:insert('INSERT INTO player_permissions (player_identifier, section_id) VALUES (?, ?)', {identifier, sectionId})
    TriggerClientEvent('QBCore:Notify', source, 'Permission granted!')
end)

QBCore.Commands.Add('revokePermission', 'Revoke vehicle section access', {{name = "player", help = "Player ID"}, {name = "section_id", help = "Section ID"}}, false, function(source, args)
    local playerId = args[1]
    local sectionId = tonumber(args[2])
    local identifier = GetPlayerIdentifier(playerId)
    
    exports.oxmysql:execute('DELETE FROM player_permissions WHERE player_identifier = ? AND section_id = ?', {identifier, sectionId})
    TriggerClientEvent('QBCore:Notify', source, 'Permission revoked!')
end)

RegisterNetEvent('spawnVehicle')
AddEventHandler('spawnVehicle', function(vehicleModel, sectionId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local identifier = GetPlayerIdentifier(src)
    
    exports.oxmysql:execute('SELECT * FROM player_permissions WHERE player_identifier = ? AND section_id = ?', {identifier, sectionId}, function(result)
        if result and #result > 0 then
            -- The player has permission, spawn the vehicle
            local coords = vector3(215.76, -791.32, 30.73) -- Set specific coordinates
            local vehicle = CreateVehicle(GetHashKey(vehicleModel), coords.x, coords.y, coords.z, 0.0, true, false)
            TaskWarpPedIntoVehicle(GetPlayerPed(src), vehicle, -1)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have access to this section.')
        end
    end)
end)

QBCore.Functions.CreateCallback('getVehicleSections', function(source, cb)
    exports.oxmysql:execute('SELECT * FROM vehicle_sections', {}, function(sections)
        local sectionData = {}
        for i, section in ipairs(sections) do
            table.insert(sectionData, {
                id = section.section_id,
                label = section.section_label,
                vehicles = {section.vehicle_model} -- Fetch the related vehicles as well
            })
        end
        cb(sectionData)
    end)
end)
