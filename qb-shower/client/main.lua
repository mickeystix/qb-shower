QBCore = nil

-- Code

local showering = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
    end
    
    while true do
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        local PedVehicle = GetVehiclePedIsIn(PlayerPed)
        local Driver = GetPedInVehicleSeat(PedVehicle, -1)
            for k, v in pairs(Config.Locations) do
                local dist = #(PlayerPos - vector3(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"]))
                if Driver ~= PlayerPed then
                    if dist <= 2 then
                        if not showering then
                            DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], '~g~E~w~ - Shower')
                            if IsControlJustPressed(0, Keys["E"]) then
                                TriggerServerEvent('qb-shower:server:washSelf')
                            end
                        else
                            DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], 'The shower is in use ..')
                        end
                        
                    elseif dist > 2 and dist < 4 then
                        DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], 'Shower')
                    end
                    
                end
            end
        
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('qb-shower:client:washSelf')
AddEventHandler('qb-shower:client:washSelf', function()
    local PlayerPed = PlayerPedId()

    showering = true
--Here you can change progress bar time by setting a normal number in place of math.random(x,y), or just change those values to get something random in milliseconds
    QBCore.Functions.Progressbar("search_cabin", "Showering...", math.random(4000, 8000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        --This below is what clears the damage deval from player model. Want your shower to do other stuff, like, say, relieve stress? Add that below.
        ClearPedBloodDamage(PlayerPed)

        showering = false
    end, function() -- Cancel
        QBCore.Functions.Notify("Shower cancelled ..", "error")
        showering = false
    end)
end)

--Create the map blip for the shower
Citizen.CreateThread(function()
    for k, v in pairs(Config.Locations) do
        shower = AddBlipForCoord(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"])

        SetBlipSprite (shower, 197)
        SetBlipDisplay(shower, 4)
        SetBlipScale  (shower, 0.75)
        SetBlipAsShortRange(shower, true)
        SetBlipColour(shower, 3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations[k]["label"])
        EndTextCommandSetBlipName(shower)
    end
end)