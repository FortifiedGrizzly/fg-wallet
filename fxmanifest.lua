fx_version 'cerulean'
author 'Fortified Grizzly'
Description 'Wallet System'
game 'gta5'
version '1.0.2'

shared_scripts {
    'shared/config.lua'
}

server_scripts {
    'server/sv_wallet.lua',
    'server/version.lua'
}

client_scripts{
    'client/cl_wallet.lua'
}

lua54 'yes'
