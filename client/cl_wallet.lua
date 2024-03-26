local QBCore = exports[Config.Framework.CoreName]:GetCoreObject()

if Config.Wallet.Enable then
    RegisterNetEvent('client:wallet', function(walletid)
        local citizenid = nil
        local stashname = Config.Wallet.StashName
        local playerPed = PlayerPedId()
        if IsEntityDead(playerPed) then 
            QBCore.Functions.Notify('You cannot do this while dead', "primary")
            return
        end
        if IsPedSwimming(playerPed) then 
            QBCore.Functions.Notify('You Must be on dry land to do this!', "primary")
            return
        end

        citizenid = QBCore.Functions.GetPlayerData().citizenid

        if Config.Wallet.Stashid then
            TriggerServerEvent(Config.Framework.OpenInventory, "stash", stashname .. '_' .. walletid, {maxweight = Config.Wallet.MaxWeight, slots = Config.Wallet.Slots})
            TriggerEvent(Config.Framework.SetStash, stashname .. '_' .. walletid)
        else
            TriggerServerEvent(Config.Framework.OpenInventory, "stash", stashname .. '_' .. citizenid, {maxweight = Config.Wallet.MaxWeight, slots = Config.Wallet.Slots})
            TriggerEvent(Config.Framework.SetStash, stashname .. '_' .. citizenid)
        end
    end)
end
