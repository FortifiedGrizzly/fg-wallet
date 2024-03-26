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
local function AddToStash(stashId, slot, otherslot, itemName, amount, info, created)
    amount = tonumber(amount) or 1
    local ItemData = QBCore.Shared.Items[itemName]
    local Player = QBCore.Functions.GetPlayer(source)
    if string.lower(string.sub(stashId, 1, 6)) == "wallet" then
        local itemInfo = QBCore.Shared.Items[itemName:lower()]
        local wallet_allowed_items = {
            'car_licence',
            'motorcycle_licence',
            'truck_licence',
            'boat_licence',
            'plane_licence',
            'helicopter_licence',
            'firearms_licence',
            'id_card',
            'health_insurance',
            'car_registration',
            'insurance',
            'cash',
            'pawnshop_receipt',
            'pawnshop_order',
            'freegift',
            'usedgift',
            'mec_registration',
        }
        local itemFound = false
        for _, item in ipairs(wallet_allowed_items) do
            if string.match(itemInfo["name"], item) then
                itemFound = true
                -- Check if the item already exists in the stash
                local found = false
                for _, stashItem in pairs(Stashes[stashId].items) do
                    if stashItem.name == itemName then
                        found = true
                        break
                    end
                end
                if not found then
                    -- Item is not already in the stash, so add it
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
                    return
                end
            end
        end
        if not itemFound then
			Player.Functions.AddItem(itemName, amount, false, info)
            for stashSlot, stashItem in pairs(Stashes[stashId].items) do
                if stashItem.name == itemName then
                    RemoveFromStash(stashId, stashSlot, itemName, amount)  -- Remove the specific item from the stash
                return
                end
            end
            -- Notify the player about the prohibited item
            TriggerClientEvent('QBCore:Notify', source, "You cannot put that item here!", "error", 3500)
            return
        end
    end
```



