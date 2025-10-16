local QBCore = exports['qb-core']:GetCoreObject()

-- 🟢 Grant Permission
QBCore.Commands.Add('grantPermission', 'Grant vehicle section access', {
    {name = "player", help = "Player ID"},
    {name = "section_id", help = "Section ID"}
}, false, function(source, args)
    local targetId = tonumber(args[1])
    local sectionId = tonumber(args[2])
    if not targetId or not sectionId then
        TriggerClientEvent('QBCore:Notify', source, 'Usage: /grantPermission [playerId] [sectionId]', 'error')
        return
    end

    local targetPlayer = QBCore.Functions.GetPlayer(targetId)
    if not targetPlayer then
        TriggerClientEvent('QBCore:Notify', source, 'Player not found.', 'error')
        return
    end

    local identifier = targetPlayer.PlayerData.license

    exports.oxmysql:execute('INSERT INTO player_permissions (player_identifier, section_id) VALUES (?, ?)', {
        identifier, sectionId
    })

    TriggerClientEvent('QBCore:Notify', source, 'Permission granted!', 'success')
end)

-- 🔴 Revoke Permission
QBCore.Commands.Add('revokePermission', 'Revoke vehicle section access', {
    {name = "player", help = "Player ID"},
    {name = "section_id", help = "Section ID"}
}, false, function(source, args)
    local targetId = tonumber(args[1])
    local sectionId = tonumber(args[2])
    if not targetId or not sectionId then
        TriggerClientEvent('QBCore:Notify', source, 'Usage: /revokePermission [playerId] [sectionId]', 'error')
        return
    end

    local targetPlayer = QBCore.Functions.GetPlayer(targetId)
    if not targetPlayer then
        TriggerClientEvent('QBCore:Notify', source, 'Player not found.', 'error')
        return
    end

    local identifier = targetPlayer.PlayerData.license

    exports.oxmysql:execute('DELETE FROM player_permissions WHERE player_identifier = ? AND section_id = ?', {
        identifier, sectionId
    })

    TriggerClientEvent('QBCore:Notify', source, 'Permission revoked!', 'success')
end)

-- 🚗 Spawn Vehicle (Server-side permission check, client spawn)
RegisterNetEvent('spawnVehicle', function(vehicleModel, sectionId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    local identifier = player.PlayerData.license

    exports.oxmysql:execute('SELECT * FROM player_permissions WHERE player_identifier = ? AND section_id = ?', {
        identifier, sectionId
    }, function(result)
        if result and #result > 0 then
            -- ✅ Has permission — trigger client to spawn the vehicle
            TriggerClientEvent('spawnVehicleClient', src, vehicleModel)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have access to this section.', 'error')
        end
    end)
end)

-- 📦 Vehicle Section Data
QBCore.Functions.CreateCallback('getVehicleSections', function(source, cb)
    exports.oxmysql:execute('SELECT * FROM vehicle_sections', {}, function(sections)
        local sectionData = {}
        for _, section in ipairs(sections) do
            table.insert(sectionData, {
                id = section.section_id,
                label = section.section_label,
                vehicles = json.decode(section.vehicle_models or '[]') -- supports multiple models
            })
        end
        cb(sectionData)
    end)
end)
