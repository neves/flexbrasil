package flexbrasil.air.nativeProcessUtil
{
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;

	[Event(name="exit", type="flash.events.NativeProcessExitEvent")]
	public class Assassin extends EventDispatcher
	{
		public static var TASKKILL_PATH:String = "app:/taskkill.exe";
		[Bindable] public var name:String = "";

		protected var process:Process;

		public function Assassin()
		{
			setupProcess();
		}

		public function kill(processName:String = null):void
		{
			if (processName) name = processName;
			process.args = [name];
			process.cmd = TASKKILL_PATH;
			process.start();
		}

		protected function setupProcess():void
		{
			process = new Process();
			process.defaultArgs = ["/T", "/F", "/IM"];
			process.addEventListener(NativeProcessExitEvent.EXIT, function(e:NativeProcessExitEvent):void {
				dispatchEvent(e);
			});
		}

	}
}