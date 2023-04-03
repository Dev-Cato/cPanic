fx_version 'adamant'
games {'gta5'}
lua54 'yes'


author 'CΛTO ssdasd'
name ''
description 'FiveM Panicbutton'
version '1.0.2'

shared_script {
	'config.lua'
}
client_scripts {
	'client.lua'
}
server_scripts {
	'server.lua',
	'updater.lua',
}

dependencies {
	'es_extended',
}
