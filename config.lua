Config = {}

Config.checkForUpdates = true -- Preveri za posodobitve?

Config.SellShops = { 
    { 
        coords = vec3(1574.6672, 3363.9365, 47.6350), 
        heading = 177.4037, 
        ped = 's_m_y_blackops_01', -- https://docs.fivem.net/docs/game-references/ped-models/
        label = '', -- tukaj vnesi kar hočeš da piše ko odpreš shop
        blip = {
            enabled = false, 
            sprite = 11, 
            color = 11, 
            scale = 0.75 
        },
        items = {
            { item = '', label = '', price = 0, currency = 'money' }, -- item = item name, label = kaj piše v shopu in game, currency = tvoj item name example: black_money, money.
            { item = '', label = '', price = 0, currency = 'money' }, 
            { item = '', label = '', price = 0, currency = 'money' }, 
        }
    }
