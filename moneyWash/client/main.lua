-------------------PED---------------------------------------------------
Citizen.CreateThread(function()
    local ped_hash = GetHashKey(Config.Ped.Type)
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    NPC = CreatePed(1, ped_hash, Config.Ped.PedLocation.x, Config.Ped.PedLocation.y, Config.Ped.PedLocation.z - 1,
        Config.Ped.PedLocation.w, false, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)   --Faz com que nao reage a eventos adversos como tiros etc
    SetPedDiesWhenInjured(NPC, false)            --Defeni se ele vai morer ao sofrer dano
    SetPedCanPlayAmbientAnims(NPC, false)        -- Permite ou nao o NPC fazer animações
    SetPedCanRagdollFromPlayerImpact(NPC, false) --Remove o Impacto de Socos e etc do npc
    SetEntityInvincible(NPC, true)               --Torna o NPC Imortal
    FreezeEntityPosition(NPC, true)              --Torna  o NPC Estatico


    --OX-TARGET--
    local options = {
        {
            name = 'moneyWash',
            icon = 'fa-solid fa-sack-dollar',
            event = 'bastos-moneywash:interact',
            label = Config.Target.InteractText,
            distance = 1.5,
        }
    }
    --------------

    if Config.Job.Needjob then
        options[1].groups = Config.Job.jobs
    end

    exports.ox_target:addLocalEntity(NPC, options)
end)
-------------------------------------------------------------------------


--------------------------INTERAÇÃO LAVAR---------------------------------

RegisterNetEvent('bastos-moneywash:interact')
AddEventHandler('bastos-moneywash:interact', function()
    local amount
    input = lib.inputDialog(Config.Dialog.Name, {
        {type = 'number',
        label = Config.Dialog.label,
        description  = Config.Dialog.description,
        default = Config.Dialog.default,
        required = true,
        icon ='fa-solid fa-sack-dollar'}


    })

    if not input then
        return
    else
        amount = input[1]
    end 

    if amount <= Config.Money.max and amount >= Config.Money.min then
        TriggerServerEvent('bastos-moneywash:checkmoney',amount)
    else
        lib.notify({
            title = 'Money Wash',
            description = 'Quantidade entre '..Config.Money.min..' e '..Config.Money.max,
            type = 'error'
        })
    end
end)
--------------------------------------------------------------------------


---------------------------------LAVAR DINHEIRO--------------------------
RegisterNetEvent('bastos-moneywash:confirm')
AddEventHandler('bastos-moneywash:confirm', function(success,amount)
    if success then
        TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_CROSS_ROAD_WAIT", 0, true)
        if lib.progressCircle({
            duration = 10000,
            label = "Lavar Dinheiro",
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
                mouse = true,
            },
        }) then
            TriggerServerEvent('bastos-moneywash:lavar',amount)
            ClearPedTasks(PlayerPedId())
        else
        lib.notify({
            title = 'Money Wash',
            description = 'Quantidade entre '..Config.Money.min..' e '..Config.Money.max,
            type = 'error'
        })    end

        ClearPedTasks(PlayerPedId())

    
    else
        lib.notify({
            title = 'Money Wash',
            description = 'Não tens essa quantidade',
            type = 'error'
        })    
    end
end)


--------------------------------------------------------------------------

RegisterNetEvent('bastos-moneywash:last')
AddEventHandler('bastos-moneywash:last', function(success)
    if success then
        lib.notify({
            title = 'Money Wash',
            description = 'Dinheiro Lavado',
            type = 'success'
        })   
    end
end)