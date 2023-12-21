local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
   while QBCore == nil do
	   TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
	   Citizen.Wait(30)
   end
end)

-- -------------------------------- 

function notify(text)
  TriggerEvent('QBCore:Notify',text)
end

--------------------------------
function DrawText3D(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
 
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)

  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


AddEventHandler("alpha:open:admin")
RegisterNetEvent("alpha:open:admin", function ()
	SetNuiFocus(true, true)
    SendNUIMessage({
      action = "announceadmin"
    })
end)

AddEventHandler("alpha:open:client")
RegisterNetEvent("alpha:open:client", function ()
	SetNuiFocus(true, true)
    SendNUIMessage({
      action = "announceclient"
    })
end)


RegisterNUICallback("close", function ()
	SetNuiFocus(false,false)
end)

RegisterNUICallback("button-1", function (data)
	text = data.id 
	TriggerServerEvent("button:server-1", text)
end)

AddEventHandler("notify-1")
RegisterNetEvent("notify-1", function (text)
	SendNUIMessage({
		action = "notify-1",
		text = text,
		servername = Config.servvername
	})
	Citizen.Wait(Config.wait)
	SendNUIMessage({
		action = "notify-1-display",
	})
	Citizen.Wait(1000)
	SendNUIMessage({
		action = "notify-1-display-N",
	})
end)

RegisterNUICallback("button-2", function (data)
	text = data.id 
	TriggerServerEvent("button:server-2", text)
end)

AddEventHandler("notify-2")
RegisterNetEvent("notify-2", function (text)
	SendNUIMessage({
		action = "notify-2",
		text = text,
		servername = Config.servvername
	})
	Citizen.Wait(Config.wait)
	SendNUIMessage({
		action = "notify-2-display",
	})
	Citizen.Wait(1000)
	SendNUIMessage({
		action = "notify-2-display-N",
	})
end)

AddEventHandler("alpha:addpost")
RegisterNetEvent("alpha:addpost", function (tarih,text)
	SendNUIMessage({
		action = "addpost-1",
		servername =  Config.servvername,
		tarih = tarih,
		text = text
	})
end)

AddEventHandler("alpha:addpost-2")
RegisterNetEvent("alpha:addpost-2", function (tarih,text)
	SendNUIMessage({
		action = "addpost-2",
		servername =  Config.servvername,
		tarih = tarih,
		text = text
	})
end)

AddEventHandler("alpha:addpost-2-big")
RegisterNetEvent("alpha:addpost-2-big", function (tarih,text)
	SendNUIMessage({
		action = "addpost-2-big",
		servername =  Config.servvername,
		tarih = tarih,
		text = text
	})
end)

RegisterNUICallback("button-1", function (data)
	TriggerServerEvent("alpha:databasesave", data.tarih,data.id)
end)

RegisterNUICallback("button-2", function (data)
	TriggerServerEvent("alpha:databasesave", data.tarih,data.id)
end)

CreateThread(function()
		if Config.cooldownmessage.message then
		while true do
			Citizen.Wait(Config.cooldownmessage.wait * 60000)
			TriggerServerEvent("button:server-1", Config.cooldownmessage.text)
			Wait(7)
		end
	end
end) 