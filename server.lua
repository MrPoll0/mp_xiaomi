ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mp:xiaomi')
AddEventHandler('mp:xiaomi', function()
	local player = ESX.GetPlayerFromId(source)

	if player then 
		local item = player.getInventoryItem('ticket_xiaomi')
		if item.count >= 1 then 
			TriggerClientEvent('esx:showNotification',source, "Ya tienes un boleto.")
		else
			local sql = [[UPDATE users SET isDonator = @number WHERE identifier = @identifier]]

			MySQL.Async.execute(sql, {
				["@identifier"] = player.identifier,
				["@number"] = 1,
			}, function(rowsChanged)
				if rowsChanged > 0 then 
					player.addInventoryItem('ticket_xiaomi', 1)
				else
					TriggerClientEvent('esx:showNotification', source, "Ha ocurrido un error con la base de datos.")
				end
			end)
		end
	end
end)