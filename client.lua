ESX = nil
ESXLoaded = false
Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)

local coords = vector3(-176.41, 6383.95, 30.5)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		if Vdist(GetEntityCoords(PlayerPedId()), coords) < 20.5 then 
			DrawMarker(27,coords, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
			if Vdist(GetEntityCoords(PlayerPedId()), coords) < 1.5 then 
				ESX.ShowHelpNotification("Pulsa ~INPUT_CONTEXT~ para hablar")
				if IsControlJustPressed(0, 38) then 
					TriggerEvent("InteractSound_CL:PlayOnOne","xiaomi", 0.6)
					FreezeEntityPosition(PlayerPedId(), true)
					Citizen.Wait(23000)
					FreezeEntityPosition(PlayerPedId(), false)
					OpenMenu()
				end
			end
		end
	end
end)

OpenMenu = function()
	local elements = {}

	table.insert(elements, {
		label = "Sí",
		value = "yes"
	})

	table.insert(elements, {
		label = "No, gracias.",
		value = "no"
	})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'xiaomi_menu',
		{
			title  = '¿Quieres adquirir un boleto?',
			align    = 'right',
			elements = elements
		},
		function(data, menu)	
			if data.current.value == "yes" then 
				TriggerServerEvent('mp:xiaomi')
				TriggerEvent("InteractSound_CL:PlayOnOne","graciasportucompra", 0.6)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
		                TriggerEvent('skinchanger:change', 'torso_1', 246)
		                TriggerEvent('skinchanger:change', 'torso_2', 0)
               	 		TriggerEvent('skinchanger:change', 'tshirt_1', 57)
                		TriggerEvent('skinchanger:change', 'arms', 0)
              		end
              	end)
				ESX.UI.Menu.CloseAll()
			elseif data.current.value == "no" then
				ESX.UI.Menu.CloseAll()
			end

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end