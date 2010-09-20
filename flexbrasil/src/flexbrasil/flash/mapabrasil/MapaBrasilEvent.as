package flexbrasil.flash.mapa_brasil
{
	import flash.events.Event;
	
	public class MapaBrasilEvent extends Event
	{
		public function MapaBrasilEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new MapaBrasilEvent(type, bubbles, cancelable);
		}
	}
}