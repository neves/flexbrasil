function init() {
	if (air.NativeProcess.isSupported && air.NativeApplication.supportsSystemTrayIcon)
	{
		setup()
	}else{
		alert("NativeProcess ou SystemTrayIcon Não Suportado!")
	}
}

function setup() {
	//air.NativeApplication.nativeApplication.startAtLogin = true
	air.NativeApplication.nativeApplication.icon.tooltip = "WampBR"
	air.NativeApplication.nativeApplication.autoExit = false
	loadIcon()
	createMenu()
}

function loadIcon() {
	var iconLoad = new air.Loader()
	iconLoad.load(new air.URLRequest("icones/apache_mysql_16x16.png"))
	iconLoad.contentLoaderInfo.addEventListener(air.Event.COMPLETE, function(){
		app.icon.bitmaps = [iconLoad.content.bitmapData]
	})
}

function createMenu() {
	trayMenu = new air.NativeMenu()
	app.icon.menu = trayMenu
	trayMenu.addItem(createMenuApacheStart())
	trayMenu.addItem(separator())
	trayMenu.addItem(createMenuMysqlStart())
	trayMenu.addItem(separator())
	trayMenu.addItem(createMenuStartAtLogon())
	trayMenu.addItem(createMenuSair())
}

function createMenuSair() {
	var sair = new air.NativeMenuItem("sair")
	sair.addEventListener(air.Event.SELECT, function() {
		app.exit()
	})
	return sair
}

function separator() {
	return new air.NativeMenuItem("", true);
}

function createMenuApacheStart() {
	var menu = new air.NativeMenuItem("start apache")
	menu.name = "apache_start"
	menu.addEventListener(air.Event.SELECT, function() {
		Apache.start()
	})
	return menu
}

function createMenuMysqlStart() {
	var menu = new air.NativeMenuItem("start mysql")
	menu.name = "mysql_start"
	return menu
}

function createMenuStartAtLogon() {
	var menu = new air.NativeMenuItem("autostart")
	menu.name = "autostart";
	menu.checked = air.NativeApplication.nativeApplication.startAtLogin
	menu.addEventListener(air.Event.SELECT, function() {
		menu.checked = ! menu.checked;
		try {
			air.NativeApplication.nativeApplication.startAtLogin = menu.checked
		}catch(e){}
	})
	return menu
}

var Apache = {
	start: function() {
		
	}
}

