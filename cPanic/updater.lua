local autoDownload = Config.AutoUpdate
local updateConfig = Config.UpdateConfig

if autoDownload then

local mainPath = "https://raw.githubusercontent.com/Dev-Cato/cPanic/main/cPanic/"
local resourcePath = GetResourcePath(GetCurrentResourceName())
local resourceName = GetCurrentResourceName()

local newFx = nil
local newServer = nil
local newClient = nil
local newConfig = nil

Citizen.CreateThread( function()
    function checkVersion(err, responseText, headers)
        curVersion = GetResourceMetadata(resourceName, "version")
        if curVersion ~= responseText then
            print('^4['..GetCurrentResourceName()..'] ^8✘ ^7Resource is outdated!')
            -- get new files from git
            PerformHttpRequest(mainPath .. "fxmanifest.lua", GetNewFx, "GET")
            PerformHttpRequest(mainPath .. "server.lua", GetNewServer, "GET")
            PerformHttpRequest(mainPath .. "client.lua", GetNewClient, "GET")
            if updateConfig then
                PerformHttpRequest(mainPath .. "config.lua", GetNewConfig, "GET")
            end

            for i = 1, 5 do
                print('^4['..GetCurrentResourceName()..'] ^3↻ ^7Downloading Update! (' .. i * 10 .. '%)')
                Citizen.Wait(500)
            end
            -- remove old files
            os.remove(resourcePath .. "/fxmanifest.lua")
            os.remove(resourcePath .. "/server.lua")
            os.remove(resourcePath .. "/client.lua")
            if updateConfig then
                os.remove(resourcePath .. "/config.lua")
            end

            for i = 6, 10 do
                print('^4['..GetCurrentResourceName()..'] ^3↻ ^7Downloading Update! (' .. i * 10 .. '%)')
                Citizen.Wait(500)
            end
            -- create new files
            fx = io.open(resourcePath .. "/fxmanifest.lua", "w")
            fx:write(newFx)
            fx:close()
            server = io.open(resourcePath .. "/server.lua", "w")
            server:write(newServer)
            server:close()
            client = io.open(resourcePath .. "/client.lua", "w")
            client:write(newClient)
            client:close()

            if updateConfig then
                config = io.open(resourcePath .. "/config.lua", "w")
                config:write(newConfig)
                config:close()
            end

            print('^4['..GetCurrentResourceName()..'] ^2✓ ^7Resource is now updated. Please restart your Server!')
        else
            print('^4['..GetCurrentResourceName()..'] ^2✓ ^7Resource loaded')
        end
    end
    
    PerformHttpRequest(mainPath .. "versoin", checkVersion, "GET")
end)

function GetNewFx(err, responseText, headers)
    newFx = responseText
end
function GetNewServer(err, responseText, headers)
    newServer = responseText
end
function GetNewClient(err, responseText, headers)
    newClient = responseText
end
function GetNewConfig(err, responseText, headers)
    newConfig = responseText
end



else
print('^4['..GetCurrentResourceName()..'] ^2✓ ^7Resource loaded')
end