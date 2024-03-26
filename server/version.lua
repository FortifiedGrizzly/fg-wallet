local function Versioncheck()
        local fxmanifestUrl = "https://raw.githubusercontent.com/FortifiedGrizzly/fg-wallet/main/fxmanifest.lua"
        PerformHttpRequest(fxmanifestUrl, function(errorCode, fxmanifestContent)
            if errorCode ~= 200 then
                print("^1Failed to fetch fxmanifest content from GitHub.^7")
                return
            end
            local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
            if not currentVersion then
                print("^1Unable to retrieve current version for resource: ^7" .. GetCurrentResourceName())
                return
            end
            local fxmanifestVersion = fxmanifestContent:match("version%s+['\"]([%d%.]+)['\"]")
            if not fxmanifestVersion then
                print("^1Unable to extract version from fxmanifest.lua for resource: ^7" .. GetCurrentResourceName())
                return
            end

            if currentVersion ~= fxmanifestVersion then
                currentVersion = "^1" .. currentVersion
                fxmanifestVersion = "^2" .. fxmanifestVersion
                print("^3[info]", "^1Current Version ".. currentVersion)
                print("^3[info]", "^3Latest Version ".. fxmanifestVersion)
                print("^1You are currently running an outdated version. Please update.^7")
                print("https://github.com/FortifiedGrizzly/fg-wallet")
            else
                currentVersion = "^2" .. currentVersion .. "^2"
                fxmanifestVersion = "^2" .. fxmanifestVersion .. "^2" 
                print("^3[info]", "^4Current Version ".. currentVersion)
                -- print("^3[info]","^4Latest Version ".. fxmanifestVersion)
                print("^2You are running the latest version.^7")
            end
        end, "GET", "", {["Content-Type"] = 'application/json'})
end

Versioncheck()






