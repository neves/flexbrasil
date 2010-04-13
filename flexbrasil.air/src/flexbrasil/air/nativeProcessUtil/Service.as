package flexbrasil.air.nativeProcessUtil
{
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;

	import mx.utils.ObjectUtil;

	public class Service extends Process
	{
		[Bindable] public var forceKill:Boolean = false;
		[Bindable] public var restartDelay:Number = 500;
		protected var restarting:Boolean = false;
		protected var restartTimer:Timer;
		protected var assassin:Assassin;
		protected var monitor:Monitor;

		public function Service()
		{
			super();
			setupRestartTimer();
			setupMonitor();
			assassin = new Assassin();
		}

		public function restart():void
		{
			if (running) {
				restarting = true;
				exit();
			}else{
				start();
			}
		}

		public function kill():void
		{
			assassin.kill(name);
		}

		override public function exit(force:Boolean=true):void
		{
			// se o processo foi iniciado por esta classe, super.running será true,
			// então ele é que deverá parar o processo
			if (super.running) super.exit(force);
			// caso contrário o processo já estivesse rodando, matá-lo.
			else if (monitor.running) kill();
		}

		override public function set cmd(path:String):void
		{
			super.cmd = path;
			monitor.name = name; // sempre que o comando alterar, o monitor deve ser atualizado
		}

		[Bindable(event="runningPropertyChanged")]
		override public function get running():Boolean
		{
			// o processo pode estar rodando por mim ou ja ter iniciado previamente
			return super.running || monitor.running;
		}

		override protected function onExit(e:NativeProcessExitEvent):void
		{
			super.onExit(e);
			if (forceKill) kill();
			if (restarting) {
				restarting = false;
				startLater();
			}
		}

		protected function startLater():void
		{
			restartTimer.delay = restartDelay;
			restartTimer.start();			
		}

		protected function setupRestartTimer():void
		{
			restartTimer = new Timer(restartDelay, 1);
			restartTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
				start();
			});
		}

		protected function setupMonitor():void
		{
			monitor = new Monitor();
			monitor.enabled = true;
			// faz o binding manualmente, pois ele não se propaga para esta classe.
			monitor.addEventListener("runningPropertyChanged", function(e:Event):void {
				updateRunning();
			});
		}
	}
}