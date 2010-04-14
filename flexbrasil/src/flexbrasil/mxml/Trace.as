package flexbrasil.mxml
{
	import mx.utils.ObjectUtil;

	public class Trace
	{
		[Bindable]public var name:String = "";
		public function set message(obj:Object):void
		{
			trace("@" + name + ":", ObjectUtil.toString(obj));
		}
	}
}