--═════════════════════════════════════════< cPanic >═════════════════════════════════════════--
--════════════════════════════════════════< settings >════════════════════════════════════════--
Config = {}

Config.Panictune = 'panictune' -- panictune command
Config.Panic = 'panic' -- trigger the panic
Config.PanicTime = 30 -- seconds to blip disappear

Config.Require = 'job' -- 'job', 'item',' item-job' or 'none'
Config.RequiredJobs = {'police', 'fib', 'sheriff'} -- jobs that required to use panictune and panic commands // only if Config.Require = 'job' or 'item-job'
Config.RequiredItem = 'panic' -- item that is required to use panictune and panic commands // only if Config.Require = 'item' or 'item-job'


Config.Notification = function(msg) -- put here in your notify trigger
	ESX.ShowNotification(msg)
end

Config.Blip = { -- you can customize the blip here
	radius = 100.0,
	color1 = 1, color2 = 35,
	alpha = 60,
}

Config.Locale = 'de' -- 'de', 'en' or 'custom'
Translation = {
	['de'] = {
		['notAllowed'] = '~r~Dazu bist du nicht befugt!',
		['notPanictuned'] = '~r~Du bist nicht im Panictune!',
		['panicJoined'] = '~b~Du bist nun im Panictune',
		['panicLeaved'] = '~b~Du bist nun nicht mehr im Panictune',
		['panicMsg'] = 'Der Officer ~b~_officer_~s~, hat ein Panicbutton in der ~b~_street_~s~ gedrückt!'
	},
	['en'] = {
		['notAllowed'] = '~r~You are not authorized to do this!',
		['notPanictuned'] = '~r~You\'re not in Panictune!',
		['panicJoined'] = '~b~You are now in Panictune',
		['panicLeaved'] = '~b~You are no longer in Panictune',
		['panicMsg'] = 'Officer ~b~_officer_~s~ pressed a panic button on ~b~_street_~s~!'
	},
	['custom'] = {
		['notAllowed'] = '',
		['notPanictuned'] = '',
		['panicJoined'] = '',
		['panicLeaved'] = '',
		['panicMsg'] = ''
	},
}
