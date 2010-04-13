package flexbrasil.air.nativeProcessUtil
{
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	import mx.utils.ObjectUtil;

	public class Monitor extends EventDispatcher
	{
		public static var TASKLIST_PATH:String = "app:/tasklist.exe";

		[Bindable] public var name:String = "";

		protected var process:Process;
		protected var timer:Timer;
		protected var _running:Boolean = false;

		public function Monitor()
		{
			setupProcess();
			setupTimer();
		}

		public function check():void
		{
			if (!name) return;
			process.cmd = TASKLIST_PATH;
			process.args = ["imagename eq " + name];
			process.start();
		}

		public function get delay():Number
		{
			return timer.delay;
		}

		public function set delay(d:Number):void
		{
			timer.delay = d;
		}

		public function get enabled():Boolean
		{
			return timer.running;
		}

		public function set enabled(b:Boolean):void
		{
			b ? timer.start() : timer.stop();
		}

		[Bindable(event="runningPropertyChanged")]
		public function get running():Boolean
		{
			return _running;
		}

		protected function updateRunning():void
		{
			// por ser executado periodicamente, atualiza apenas se houver alteração
			var newRunning:Boolean = process.error == "";
			if (newRunning == _running) return;
			_running = newRunning;
			dispatchEvent(new FlexEvent("runningPropertyChanged"));
		}

		protected function setupProcess():void
		{
			process = new Process();
			process.defaultArgs = ["/FI"];
			process.addEventListener(NativeProcessExitEvent.EXIT, function(e:NativeProcessExitEvent):void {
				updateRunning();
			});
		}

		protected function setupTimer():void
		{
			timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				check();
			});
		}
	}
}