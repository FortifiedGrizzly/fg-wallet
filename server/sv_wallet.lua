local QBCore = exports[Config.Framework.CoreName]:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.WalletItem, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('client:wallet', source, item.info.walletid)
end)