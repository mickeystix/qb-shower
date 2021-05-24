QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

RegisterServerEvent('qb-shower:server:washSelf')
AddEventHandler('qb-shower:server:washSelf', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    TriggerClientEvent('qb-shower:client:washSelf', src)
    TriggerClientEvent('qb-shower:client:showeranim', src)

end)
