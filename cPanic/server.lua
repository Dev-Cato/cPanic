--════════════════════════════════════════< esx import >════════════════════════════════════════--
local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--════════════════════════════════════════< locals >════════════════════════════════════════--
local _T = Translation[Config.Locale]

--════════════════════════════════════════< script >════════════════════════════════════════--
ESX.RegisterServerCallback('cPanic:getJob', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	local xJob = xPlayer.job
	cb(xJob)
end)

ESX.RegisterServerCallback('cPanic:hasItem', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Item = xPlayer.getInventoryItem(Config.RequiredItem)
	
	cb(Item)
end)

RegisterServerEvent('cPanic:sendServer')
AddEventHandler('cPanic:sendServer', function(player, officerPed, coords, street)
	local msg = _T['panicMsg']
	msg = string.gsub(msg, '_officer_', player)
	msg = string.gsub(msg, '_street_', street)
	TriggerClientEvent('cPanic:panic', -1, coords, msg, officerPed)
end)
