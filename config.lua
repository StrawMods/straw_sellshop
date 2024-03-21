Config = {}

Config.SellShops = {
{ 
    coords = vec3(116.4545, -1953.7479, 20.7513), -- if ur ped is in the air on in the groud change z coord
    heading = 44.7236, 
    ped = 'g_m_importexport_01', -- https://docs.fivem.net/docs/game-references/ped-models/
    label = 'Market',
    blip = {
        enabled = false,
        sprite = 11,
        color = 11,
        scale = 0.75
    },
    items = {
        { item = 'gold', label = 'Gold Bar', price = 100, currency = 'black_money' },
        { item = 'diamond', label = 'Diamond', price = 400, currency = 'black_money' },
     }
  },
}
