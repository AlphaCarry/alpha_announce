fx_version 'adamant'

game 'gta5'


author 'AlphaCarry'
description 'Announce menu for qbcore'
version '1.0.0'


ui_page 'html/ui.html'

client_scripts {
    'config.lua',
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua',
}

files {
	'html/ui.html',
	'html/*.css',
	'html/fonts/*.woff',
	'html/*.js',
	'html/img/*.png',
	'html/img/*.jpg',
	'html/img/*.gif',
}
lua54 'yes'
