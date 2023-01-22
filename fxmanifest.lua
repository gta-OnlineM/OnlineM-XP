fx_version 'cerulean'
game 'gta5'

name "[OnlineM] XP system"
description "FiveM Scaleform XP System - GTA:Online Inspired"
author "OnlineM (Mycroft)"
lua54 'yes'
version "1.0.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

dependency 'oxmysql'
