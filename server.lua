ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dinero_suiza:deposit')
AddEventHandler('dinero_suiza:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > xPlayer.getBMoney() then
            amount = xPlayer.getBMoney()
        end
        xPlayer.removeBMoney(amount)
        xPlayer.addAccountMoney('bmoney', tonumber(amount))
    end
end)

RegisterServerEvent('dinero_suiza:withdraw')
AddEventHandler('dinero_suiza:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bmoney').money
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bmoney', amount)
        xPlayer.addBMoney(amount)
    end
end)

RegisterServerEvent('dinero_suiza:balance')
AddEventHandler('dinero_suiza:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bmoney').money
    TriggerClientEvent('currentbalance1', _source, balance)

end)

--[[
RegisterServerEvent('dinero_suiza:transfer')
AddEventHandler('dinero_suiza:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        balance = xPlayer.getAccount('bmoney').money
        zbalance = zPlayer.getAccount('bmoney').money
        if tonumber(_source) == tonumber(to) then
            -- advanced notification with bank icon
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Banco',
                               'Transferencia',
                               'No puedes transferirte dinero a ti mismo',
                               'CHAR_BANK_MAZE', 9)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Banco', 'Transferencia',
                                   'No tienes tanto dinero para transferir',
                                   'CHAR_BANK_MAZE', 9)
            else
                xPlayer.removeAccountMoney('bmoney', tonumber(amountt))
                zPlayer.addAccountMoney('bmoney', tonumber(amountt))
                -- advanced notification with bank icon
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Banco', 'Transferencia',
                                   'Has transferido ~r~$' .. amountt ..
                                       '~s~ a ~r~' .. to .. ' .',
                                   'CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'Banco',
                                   'Transferencia', 'Has recicibido ~r~$' ..
                                       amountt .. '~s~ a ~r~' .. _source ..
                                       ' .', 'CHAR_BANK_MAZE', 9)
            end

        end
    end

end)
]]