fx_version'cerulean'
game 'gta5'
author 'Bastos'
lua54 'yes'


shared_scripts {'@ox_lib/init.lua', 'config.lua' }

server_scripts {
    'server/*.lua',
}

client_scripts {
    'client/*.lua'
}

shared_script '@es_extended/imports.lua'


