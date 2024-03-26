local QBCore = exports[Config.Framework.CoreName]:GetCoreObject()

if Config.Wallet.Enable then
    local Config = Config.Wallet
    QBCore.Functions.CreateUseableItem(Config.WalletItem, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('client:wallet', source, item.info.walletid)
    end)
end
