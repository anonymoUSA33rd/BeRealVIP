local QBCore = exports['qb-core']:GetCoreObject()
local uiOpen = false

-- 🟢 Command to open the Vehicle UI
RegisterCommand('openVehicleUI', function()
    if uiOpen then return end -- prevent double-open

    QBCore.Functions.TriggerCallback('getVehicleSections', function(sections)
        if sections and #sections > 0 then
            uiOpen = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "openUI", -- consistent naming (use 'action' instead of 'type')
                sections = sections
            })
        else
            QBCore.Functions.Notify("No vehicle sections available.", "error")
        end
    end)
end, false)

-- Optional: add keybind for F3
RegisterKeyMapping('openVehicleUI', 'Open Vehicle UI', 'keyboard', 'F3')

-- 🚗 NUI Callback for spawning a vehicle
RegisterNUICallback('spawnVehicle', function(data, cb)
    if not uiOpen then
        cb('fail')
        return
    end

    if not data or not data.vehicleModel or not data.sectionId then
        QBCore.Functions.Notify("Invalid vehicle data.", "error")
        cb('fail')
        return
    end

    TriggerServerEvent('spawnVehicle', data.vehicleModel, data.sectionId)
    cb('ok')
end)

-- ❌ NUI Callback for closing the UI
RegisterNUICallback('closeUI', function(_, cb)
    if uiOpen then
        uiOpen = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "closeUI"
        })
    end
    cb('ok')
end)

-- 🧩 Safety: force close UI if player dies or enters a vehicle
CreateThread(function()
    while true do
        Wait(1000)
        if uiOpen then
            local ped = PlayerPedId()
            if IsEntityDead(ped) or IsPedInAnyVehicle(ped, false) then
                uiOpen = false
                SetNuiFocus(false, false)
                SendNUIMessage({ action = "closeUI" })
            end
        end
    end
end)


