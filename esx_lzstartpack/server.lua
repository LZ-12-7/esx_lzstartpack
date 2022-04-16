local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_lzstartpack:checkStartPack')
AddEventHandler('esx_lzstartpack:checkStartPack', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)


    MySQL.Async.fetchScalar('SELECT identifier FROM startpack WHERE identifier = @identifier', { ['identifier'] = xPlayer.getIdentifier()}, function(result)
        if result then
            TriggerClientEvent('esx:showNotification', src, 'Ya has reclamado tu pack de inicio!')
        else
            MySQL.Async.execute('INSERT INTO startpack (identifier) VALUES (@identifier)', {['@identifier'] = xPlayer.getIdentifier()})
            TriggerClientEvent('esx:showNotification', src, '~b~Has recibido el ~g~pack de inicio~w~ reviselo en su ~r~inventario!')
            xPlayer.addAccountMoney('bank', 500)
            xPlayer.addInventoryItem('bread', 2)
            xPlayer.addInventoryItem('water', 2)
            xPlayer.addInventoryItem('phone', 1)

        end
    end)

end)