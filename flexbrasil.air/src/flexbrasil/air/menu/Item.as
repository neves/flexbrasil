package flexbrasil.air.menu
{
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	[DefaultProperty("items")]
	public class Item extends NativeMenuItem
	{
		[Bindable] public var toggle:Boolean = false;

		public function Item(label:String="", isSeparator:Boolean=false)
		{
			super(label, isSeparator);
			addEventListener(Event.SELECT, function(e:Event):void {
				if (toggle) checked = ! checked;
			})
		}

		public function set items(menus:Array):void
		{
			if (submenu == null) submenu = new Menu();
			submenu.items = menus;
		}
	}
}