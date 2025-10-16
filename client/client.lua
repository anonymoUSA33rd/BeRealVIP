local QBCore = exports['qb-core']:GetCoreObject()
local uiOpen = false

-- 🟢 Command to open the Vehicle UI
RegisterCommand('openVehicleUI', function()
    if uiOpen then return end  -- prevent double-open

    QBCore.Functions.TriggerCallback('getVehicleSections', function(sections)
        if sections then
            uiOpen = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = "openUI",
                sections = sections
            })
        end
    end)
end, false)

-- Optional: add keybind for F3
RegisterKeyMapping('openVehicleUI', 'Open Vehicle UI', 'keyboard', 'F3')

-- 🚗 NUI Callback for spawning vehicle
RegisterNUICallback('spawnVehicle', function(data, cb)
    if not uiOpen then return end -- ignore if UI somehow not open
    TriggerServerEvent('spawnVehicle', data.vehicleModel, data.sectionId)
    cb('ok')
end)

-- ❌ NUI Callback for closing UI
RegisterNUICallback('closeUI', function(_, cb)
    if uiOpen then
        uiOpen = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "closeUI"
        })
    end
    cb('ok')
end)

-- 🧩 Safety: force close UI if player leaves vehicle or dies (optional)
CreateThread(function()
    while true do
        Wait(1000)
        if uiOpen then
            local ped = PlayerPedId()
            if IsEntityDead(ped) or IsPedInAnyVehicle(ped, false) then
                uiOpen = false
                SetNuiFocus(false, false)
                SendNUIMessage({ type = "closeUI" })
            end
        end
    end
end)

