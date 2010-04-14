package flexbrasil.air.menu
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;

	[DefaultProperty("items")]
	public class Menu extends NativeMenu
	{
		public function Menu()
		{
			super();
		}

		public function set subItems(a:Array):void
		{
			for each (var i:NativeMenuItem in a) {
				addItem(i);
			}
		}
	}
}