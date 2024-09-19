ESX = exports["es_extended"]:getSharedObject()

function GetCompassDirectionFromHeading(heading)
    if (heading >= 337.5 or heading < 22.5) then
        return "N"
    elseif (heading >= 22.5 and heading < 67.5) then
        return "NE"
    elseif (heading >= 67.5 and heading < 112.5) then
        return "E"
    elseif (heading >= 112.5 and heading < 157.5) then
        return "SE"
    elseif (heading >= 157.5 and heading < 202.5) then
        return "S"
    elseif (heading >= 202.5 and heading < 247.5) then
        return "SW"
    elseif (heading >= 247.5 and heading < 292.5) then
        return "W"
    elseif (heading >= 292.5 and heading < 337.5) then
        return "NW"
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
    Citizen.CreateThread(function ()
        while true do
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local road = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))

            TriggerEvent('esx_status:getStatus', 'hunger', function(hungerstatus)
                TriggerEvent('esx_status:getStatus', 'thirst', function(thirststatus)
                    hunger = hungerstatus.getPercent()
                    thirst = thirststatus.getPercent()
                end)
            end)

            if IsPedSwimmingUnderWater(playerPed) then
                local remainingOxygenTime = GetPlayerUnderwaterTimeRemaining(PlayerId())
                oxygen = (remainingOxygenTime / 10.0) * 100
            else
                oxygen = 100
            end

            local heading = GetEntityHeading(playerPed)
            local compassDirection = GetCompassDirectionFromHeading(heading)

            local inVeh = IsPedInAnyVehicle(playerPed, false)
            local speed = 0

            if inVeh then
                local vehicle = GetVehiclePedIsIn(playerPed, false) 
                speed = GetEntitySpeed(vehicle) * 2.23694
            end

            -- PMAVOICE
            local proximity = LocalPlayer.state['proximity']
            local isTalking = NetworkIsPlayerTalking(playerPed)

            SendNUIMessage({
                action = 'updateHud',
                health = GetEntityHealth(playerPed) - 100,
                hunger = hunger,
                thirst = thirst,
                oxygen = oxygen,
                voiceMode = proximity.distance * 16,
                talking = isTalking,

                inVeh = inVeh,
                compass = compassDirection,
                speed = speed,
                road = road,
                hide = hide
            })

            if not inVeh then
                SendNUIMessage({
                    action = 'hideVehHud'
                })
            end

            Citizen.Wait(100)
        end
    end)
end)
