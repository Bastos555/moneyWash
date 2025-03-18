Config = {}


Config.Ped = {
    Type = "a_m_m_hasjew_01",
    PedLocation = vector4(341.986816, -1187.815430, 29.330444, 184.251968) --Cordenadas do PED
}

Config.Job = {
    Needjob = false, --Deixar em false se nao for necessario ter um job
    jobs = { "taxi" }
}


Config.Target = {
    InteractText = "Lavar Dinheiro",
}


Config.Money = {
    max = 100000,
    min = 1000,
    percentagem = 0,10
}

Config.Dialog = {
    Name = "Dealer",
    label = "Quantidade",
    description = "Quanto dinheiro deseja lavar?",
    default = 1000,
}
