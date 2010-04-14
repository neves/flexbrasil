package util
{
	import flash.desktop.SystemTrayIcon;
	import flash.display.BitmapData;

	public class IconChooser
	{
		[Embed(source="icons/apache_mysql_16x16.png")]
		private var IconeApacheMysql:Class;

		[Embed(source="icons/apache_16x16.png")]
		private var IconeApache:Class;

		[Embed(source="icons/mysql_16x16.png")]
		private var IconeMysql:Class;

		[Embed(source="icons/none_16x16.png")]
		private var IconeNone:Class;

		private var icones:Array = [new IconeNone().bitmapData,
			new IconeApache().bitmapData,
			new IconeMysql().bitmapData,
			new IconeApacheMysql().bitmapData];

		private var _sysTray:SystemTrayIcon;
		private var _apache:Boolean = false;
		private var _mysql:Boolean = false;

		public function set apache(b:Boolean):void
		{
			_apache = b;
			updateIcons();
		}

		public function set mysql(b:Boolean):void
		{
			_mysql = b;
			updateIcons();
		}

		public function set sysTray(t:SystemTrayIcon):void
		{
			_sysTray = t;
			updateIcons();
		}

		private function updateIcons():void
		{
			if (!_sysTray) return;
			var icon:BitmapData = icones[0];
			if (_apache && _mysql) icon = icones[3];
			else if (_apache) icon = icones[1];
			else if (_mysql) icon = icones[2];
			_sysTray.bitmaps = [icon];
		}
	}
}