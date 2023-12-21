local QBCore = exports['qb-core']:GetCoreObject()

-------------------------------- 

function getidentifier(source)
	hex = QBCore.Functions.GetIdentifier(source, 'steam')
	return hex
end

-------------------------------- 

function checkAllowed(id)
    perm = QBCore.Functions.HasPermission(id, 'admin')
      if perm then
    return true
    else
  return false
    end
end
-------------------------------- 

function getplayer(source)
	xPlayer = QBCore.Functions.GetPlayer
	return xPlayer
end

-------------------------------- 

function nofitylao(source,text)
	 TriggerClientEvent('QBCore:Notify', source, text, "success")
end

------------------------------------------------------------------------------------

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --

------------------------------------------------------------------------------------

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if Config.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
            -------------------------------- 
        else
            MySQL.query(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
        -------------------------------- 
    elseif Config.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif Config.Mysql == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
        -------------------------------- 
    end
    while IsBusy do
        Citizen.Wait(100)
    end
    return result
end

------------------------------------------------------------------------------------

------------------------------------------------------------------------------------

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --

------------------------------------------------------------------------------------



RegisterCommand(Config.command.admin, function (source)
  local zrt = getplayer()
  local xPlayer = zrt(source)	
  if checkAllowed(source) then
    TriggerClientEvent("alpha:open:admin", source)
    local data5 = ExecuteSql("SELECT * FROM `alpha_recentpost` ORDER BY id")
    for k,v in pairs(data5) do
      TriggerClientEvent("alpha:addpost", source,v.time,v.text) 
    end
  else 
    nofitylao(source,Config.lang.noperm)
  end
end)


AddEventHandler("button:server-1")
RegisterNetEvent("button:server-1",function (text)
    local zrt = getplayer()
    local xPlayer = zrt(source)	
    local identifier = getidentifier(source)
      TriggerClientEvent("notify-1", -1,text)
end)

AddEventHandler("button:server-2")
RegisterNetEvent("button:server-2",function (text)
    local zrt = getplayer()
    local xPlayer = zrt(source)	
    local identifier = getidentifier(source)
      TriggerClientEvent("notify-2", -1,text)
end)

AddEventHandler("alpha:databasesave")
RegisterNetEvent("alpha:databasesave",function (tarih,text)
  ExecuteSql("INSERT INTO `alpha_recentpost` (`time`, `text`) VALUES ('"..tarih.."','"..text.."')")
end)

local liste = true
RegisterCommand(Config.command.player, function (source)
    addplayerpost(source)
    Citizen.Wait(100)
    addplayerpost(source)
end)

function addplayerpost(source)
  TriggerClientEvent("alpha:open:client", source)
  local data5 = ExecuteSql("SELECT * FROM `alpha_recentpost` ORDER BY id DESC")
    if liste then
      TriggerClientEvent("alpha:addpost-2-big", source,data5[1].time,data5[1].text) 
      liste = false
    else
      local data6 = ExecuteSql("SELECT * FROM `alpha_recentpost` ORDER BY id")
      for k,v in pairs(data6) do
      TriggerClientEvent("alpha:addpost-2", source,v.time,v.text) 
      end
  end
end


CreateThread(function()
  while true do
    if liste == false then
    liste = true 
  end
    Wait(7000)
end
end) 