ESX = exports["es_extended"]:getSharedObject()

addCommas = function(n)
	return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
								  :gsub(",(%-?)$","%1"):reverse()
end

CreateBlip = function(coords, sprite, colour, text, scale)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

AddEventHandler('straw_sellshop:sellItem', function(data)
    local data = data
    local input = lib.inputDialog('How many would you like to sell?', {'Quantity'})
    if input then
        data.quantity = math.floor(tonumber(input[1]))
        if data.quantity < 1 then
            lib.notify({
                title = 'Error',
                description = 'Please enter a valid amount!',
                type = 'error'
            })
        else
            local done = lib.callback.await('straw_sellshop:sellItem', 100, data)
            if not done then
                lib.notify({
                    title = 'Error',
                    description = 'You have no requested items to sell!',
                    type = 'error'
                })
            else
                lib.notify({
                    title = 'Success',
                    description = 'You sold your goods for $'..addCommas(done),
                    type = 'success'
                })
            end
        end
    else
        lib.notify({
            title = 'Error',
            description = 'Please enter a valid amount!',
            type = 'error'
        })
    end
end)

AddEventHandler('straw_sellshop:interact', function(data)
    local storeData = data.store
    local items = storeData.items
    local Options = {}
    for i=1, #items do
        table.insert(Options, {
            title = items[i].label,
            description = 'Sale price: $'..items[i].price,
            event = 'straw_sellshop:sellItem',
            args = { item = items[i].item, price = items[i].price, currency = items[i].currency }
        })
    end
    lib.registerContext({
        id = 'storeInteract',
        title = storeData.label,
        options = Options
    })
    lib.showContext('storeInteract')
end)

-- Blips/Targets
CreateThread(function()
    for i=1, #Config.SellShops do
        exports.qtarget:AddBoxZone(i.."_sell_shop", Config.SellShops[i].coords, 1.0, 1.0, {
            name=i.."_sell_shop",
            heading=Config.SellShops[i].blip.heading,
            debugPoly=false,
            minZ=Config.SellShops[i].coords.z-1.5,
            maxZ=Config.SellShops[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'straw_sellshop:interact',
                    icon = 'fas fa-hand-paper',
                    label = 'Market',
                    store = Config.SellShops[i]
                }
            },
            job = 'all',
            distance = 1.5
        })
        if Config.SellShops[i].blip.enabled then
            CreateBlip(Config.SellShops[i].coords, Config.SellShops[i].blip.sprite, Config.SellShops[i].blip.color, Config.SellShops[i].label, Config.SellShops[i].blip.scale)
        end
    end
end)
