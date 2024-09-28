fx_version 'cerulean'
game 'gta5'

author 'Bleezy Mack VIP Menu'
description 'Vehicle Access Menu UI for QBCore with oxmysql'

client_scripts {
    'client/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/app.js',
    'nui/style.css',
}

dependencies {
    'oxmysql',
    'qb-core'
}
