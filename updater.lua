local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
local resourceName = "straw_sellshop"

if Config.checkForUpdates then
    CreateThread(function()
        if GetCurrentResourceName() ~= "straw_sellshop" then
            resourceName = "straw_sellshop (" .. GetCurrentResourceName() .. ")"
        end
    end)

    CreateThread(function()
        while true do
            PerformHttpRequest("https://api.github.com/repos/StrawMods/straw_sellshop/", CheckVersion, "GET")
            Wait(3600000)
        end
    end)

    CheckVersion = function(err, responseText, headers)
        local repoVersion, repoURL, repoBody = GetRepoInformations()

        CreateThread(function()
            if curVersion ~= repoVersion then
                Wait(4000)
                print("^0[^3OPOZORILO^0] " .. resourceName .. " ^1NI ^0up posodobljen!")
                print("^0[^3OPOZORILO^0] Vaša verzija: ^2" .. curVersion .. "^0")
                print("^0[^3OPOZORILO^0] Najnovejša verzija: ^2" .. repoVersion .. "^0")
                print("^0[^3OPOZORILO^0] Prenesite najnovejšo verzijo na: ^2" .. repoURL .. "^0")
                print("^0[^3OPOZORILO^0] Changelog:^0")
                print("^1" .. repoBody .. "^0")
            else
                Wait(4000)
                print("^0[^2INFO^0] " .. resourceName .. " je posodobljen! (^2" .. curVersion .. "^0)")
            end
        end)
    end

    GetRepoInformations = function()
        local repoVersion, repoURL, repoBody = nil, nil, nil

        PerformHttpRequest("https://api.github.com/repos/StrawMods/straw_sellshop/", function(err, response, headers)
            if err == 200 then
                local data = json.decode(response)

                repoVersion = data.tag_name
                repoURL = data.html_url
                repoBody = data.body
            else
                repoVersion = curVersion
                repoURL = "https://github.com/StrawMods/straw_sellshop"
            end
        end, "GET")

        repeat
            Wait(50)
        until (repoVersion and repoURL and repoBody)

        return repoVersion, repoURL, repoBody
    end
end
