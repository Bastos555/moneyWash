ESX = exports["es_extended"]:getSharedObject()



RegisterServerEvent('bastos-moneywash:checkmoney')
AddEventHandler('bastos-moneywash:checkmoney',function (amount)
    local _source = source -- Id do joogador que ativou o evento
    local xPlayer = ESX.GetPlayerFromId(_source) -- Dados do Jogador
    local black = xPlayer.getAccount('black_money').money
    if black >= amount then
        TriggerClientEvent('bastos-moneywash:confirm', _source, true, amount)
    else
        TriggerClientEvent('bastos-moneywash:confirm', _source, false,0)
    end
end)


RegisterServerEvent('bastos-moneywash:lavar')
AddEventHandler('bastos-moneywash:lavar',function (amount)
    local _source = source -- Id do joogador que ativou o evento
    local xPlayer = ESX.GetPlayerFromId(_source) -- Dados do Jogador
    local black = xPlayer.getAccount('black_money').money

    if black >= amount then
        local percent = amount * Config.Money.percentagem
        local dinheiroReceber = amount - percent
        xPlayer.removeAccountMoney('black_money', amount)
        xPlayer.addAccountMoney('money', dinheiroReceber)
        TriggerClientEvent('bastos-moneywash:last',_source,true)
    else
        TriggerClientEvent('bastos-moneywash:last',_source,false,0)
    end
end)