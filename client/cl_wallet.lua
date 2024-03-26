local QBCore = exports[Config.Framework.CoreName]:GetCoreObject()

local citizenid = nil
local stashname = Config.StashName

RegisterNetEvent('client:wallet', function(walletid)
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then 
        QBCore.Functions.Notify('You cannot do this while dead', "primary")
    end
    if IsPedSwimming(playerPed) then 
        QBCore.Functions.Notify('You Must be on dry land to do this!', "primary")
    end

    citizenid = QBCore.Functions.GetPlayerData().citizenid

    if Config.Stashid then
        TriggerServerEvent(Config.Framework.OpenInventory, "stash", stashname .. '_' .. walletid, {maxweight = Config.MaxWeight, slots = Config.Slots})
        TriggerEvent(Config.Framework.SetStash, stashname .. '_' .. walletid)
    else
        TriggerServerEvent(Config.Framework.OpenInventory, "stash", stashname .. '_' .. citizenid, {maxweight = Config.MaxWeight, slots = Config.Slots})
        TriggerEvent(Config.Framework.SetStash, stashname .. '_' .. citizenid)
    end
end)
