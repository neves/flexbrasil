package flexbrasil.air.menu
{
	import flash.display.NativeMenuItem;
	
	[DefaultProperty("items")]
	public class Item extends NativeMenuItem
	{
		public function Item(label:String="", isSeparator:Boolean=false)
		{
			super(label, isSeparator);
		}

		public function set items(menus:Array):void
		{
			if (submenu == null) submenu = new Menu();
			submenu.items = menus;
		}
	}
}