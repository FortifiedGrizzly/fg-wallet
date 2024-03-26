# Fortified Grizzly - Small Wallet System 

## Overview
This document provides instructions for installing and configuring the Fortified Grizzly Small Wallet System.

### Install

1. **QBCore Shared/items.lua**:
   - Add the following entry to your `QBCore Shared/items.lua` file:

   ```lua
   wallet = {name = 'wallet', label = 'wallet', weight = 0,type = 'item', image = 'wallet.png', unique = true, useable = true, shouldClose = false combinable = nil,description = ''
   }
   ```

2. **QBCore Inventory server/main.lua**:
    - Locate the following section in your server/main.lua file:
    elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "Itemshop" then

    - Insert the following code snippet above it:

    ```lua
    elseif itemData.name == 'wallet' then
    local info = {
        walletid = math.random(111111,999999),
    }
    Player.Functions.AddItem('wallet', 1, nil, info, {["quality"] = 100})
    Player.Functions.RemoveMoney('bank', 50, 'Wallet Purchase')
    ```
    - Inside the giveitem command function, add the following snippet inside the if itemData then block:
   ```lua
    elseif itemData["name"] == 'wallet' then
    info.walletid = math.random(111111,999999)
   ```
4. **QBCore Inventory server/main.lua**: 
    - Update the price of the wallet item in the shop to match the purchase price set in the server/main.lua file.
    - Add the following entry to your qb-shops/config.lua file:

    ```lua
    [4] = {
    name = "wallet",
    price = 50,
    amount = 1,
    info = {},
    type = "item",
    slot = 4,
    }
    ```
5. **Restricting Items server/main.lua**:
    - In your inventory script (e.g., server/main.lua), locate the AddToStash function.
    - Add the following code snippet below the declaration of ItemData:
    - Replace wallet_allowed_items with your list of allowed items.
```lua    
    local Player = QBCore.Functions.GetPlayer(source)

    if string.lower(string.sub(stashId, 1, 6)) == "wallet" then
    local itemInfo = QBCore.Shared.Items[itemName:lower()]
    local wallet_allowed_items = {
        -- Add your allowed items here
    }
    local itemFound = false
    for _, item in ipairs(wallet_allowed_items) do
        if string.match(itemInfo["name"], item) then
            itemFound = true
            Stashes[stashId].items[slot] = {
                name = itemInfo["name"],
                amount = amount,
                info = info or "",
                label = itemInfo["label"],
                description = itemInfo["description"] or "",
                weight = itemInfo["weight"],
                type = itemInfo["type"],
                unique = itemInfo["unique"],
                useable = itemInfo["useable"],
                image = itemInfo["image"],
                created = created,
                slot = slot,
            }
            break
        end
    end

       if not itemFound then
        RemoveFromStash(stashId, otherslot, itemName, amount)
        Player.Functions.AddItem(itemName, amount, slot, info)
        TriggerClientEvent('QBCore:Notify', source, "You Cannot Put that item here!", "error", 3500)
        return
       end
   end
```



