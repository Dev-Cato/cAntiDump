 --╔══════════════════════════════════════════════════╗--
---║           ©cato.dev >> dsc.gg/catodev            ║---
 --╚══════════════════════════════════════════════════╝--

fx_version 'cerulean'
games {'gta5'}

author 'cato.dev'
description ''
version '1.0.0'

client_scripts {
    'loader/loaderCL.lua',
}

server_scripts {
    'loader/loaderSV.lua',
    'config.lua',
    'server.lua',
}
--[[
ui_page ('html/index.html')
files {
	'html/*.html',
	'html/*.js',
	'html/*.css',
    'html/*.png',
    'html/*.mp3',
	'html/*.mp4',
}
]]