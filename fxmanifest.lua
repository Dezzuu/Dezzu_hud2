fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'dezzu'
description 'siup'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
}
client_script 'client.lua'
server_script {
    '@oxmysql/lib/MySQL.lua'
}
ui_page 'index.html'

files {
    'index.html',
    'style.css',
    'script.js',
}
