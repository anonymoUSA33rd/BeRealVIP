RegisterCommand('openVehicleUI', function()
    local src = source
    QBCore.Functions.TriggerCallback('getVehicleSections', function(sections)
        SendNUIMessage({
            type = "openUI",
            sections = sections
        })
        SetNuiFocus(true, true)
    end)
end, false)

RegisterNUICallback('spawnVehicle', function(data)
    TriggerServerEvent('spawnVehicle', data.vehicleModel, data.sectionId)
end)

-- Close NUI when escape key is pressed
RegisterNUICallback('closeUI', function()
    SetNuiFocus(false, false)
end)
