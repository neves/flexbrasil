package flexbrasil
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	public class EventDebugger
	{
		private var instance:EventDispatcher;
		public function EventDebugger(instance:EventDispatcher)
		{
			this.instance = instance;
			var xml:XML = describeType(instance);
			for each(var event:XML in xml.metadata.(@name == "Event").arg.(@key == "name").@value)
				instance.addEventListener(event, debug);
		}

		protected function debug(e:Event):void
		{
			trace(getQualifiedClassName(instance) + " => " + getQualifiedClassName(e) + "." + e.type);
		}
	}
}