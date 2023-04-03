--════════════════════════════════════════< esx import >════════════════════════════════════════--
ESX = nil
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1)
	end
end)
--════════════════════════════════════════< locals >════════════════════════════════════════--
local _T = Translation[Config.Locale]
local b = Config.Blip

local plyJob = ''
local isPanictune = false

--════════════════════════════════════════< script >════════════════════════════════════════--

CreateThread(function()
	Wait(1000)
	while plyJob == '' do
		ESX.TriggerServerCallback('cPanic:getJob', function(xJob)
			plyJob = xJob
		end)
		Wait(2000)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	plyJob = job
end)

RegisterCommand(Config.Panictune, function(source, args)
	if isAllowed() then
		isPanictune = not isPanictune
		if isPanictune then
			Config.Notification(_T['panicJoined'])
		else
			Config.Notification(_T['panicLeaved'])
		end
	else
		Config.Notification(_T['notAllowed'])
	end
end)

RegisterCommand(Config.Panic, function(source, args)
	if isAllowed() then
		if isPanictune then
			local coords = GetEntityCoords(PlayerPedId())
			local street, cross = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
			local street = GetStreetNameFromHashKey(street)

			TriggerServerEvent('cPanic:sendServer', GetPlayerName(PlayerId()), PlayerPedId(), coords, street)
		else
			Config.Notification(_T['notPanictuned'])
		end
	else
		Config.Notification(_T['notAllowed'])
	end
end)

RegisterNetEvent('cPanic:panic')
AddEventHandler('cPanic:panic', function(coords, msg, officerPed)
	if isAllowed() then
		Config.Notification(msg)

		CreateThread(function()
			local blip = AddBlipForRadius(coords, b.radius)
			SetBlipRoute(blip, true)

			CreateThread(function()
				while blip do
					SetBlipRouteColour(blip, b.color1)
					Wait(100)
					SetBlipRouteColour(blip, b.color2)
					Wait(100)
				end
			end)

			SetBlipAlpha(blip, b.alpha)
			SetBlipColour(blip, b.color1)
			SetBlipFlashes(blip, true)
			SetBlipFlashInterval(blip, 200)

			Wait(Config.PanicTime * 1000)

			RemoveBlip(blip)
			blip = nil
		end)

	end
end)

function isAllowed()
	local allowed = false
	if Config.Require == ('job' or 'item-job') then
		for _, i in pairs(Config.RequiredJobs) do
			if i == plyJob.name then
				allowed = true
			end
		end
	end

	if Config.Require == ('item' or 'item-job') then
		ESX.TriggerServerCallback('cPanic:hasItem', function(xItem)
			print(xItem.count)
			if xItem.count > 0 then
				allowed = true
				print("allow")
			end
		end)
	end

	if Config.Require == 'none' then
		allowed = true
	end
	Wait(100)
	return allowed
end

