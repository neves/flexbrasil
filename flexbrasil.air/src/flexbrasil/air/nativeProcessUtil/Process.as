package flexbrasil.air.nativeProcessUtil
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	import mx.events.FlexEvent;
	import mx.utils.ObjectUtil;

	/**
	 * Facilita a manipulação de processos que recebem e retornam dados no formato String.
	 */
	[Event(name="exit", type="flash.events.NativeProcessExitEvent")]
	public class Process extends EventDispatcher
	{
		[Bindable] public var input:String = "";
		[Bindable] public var output:String = "";
		[Bindable] public var error:String = "";
		[Bindable] public var workingDir:String = null;
		[Bindable] public var defaultArgs:Array = [];
		[Bindable] public var args:Array = [];
		[Bindable] public var exitCode:Number = NaN;

		protected var nativeProcess:NativeProcess;
		protected var nativeProcessStartupInfo:NativeProcessStartupInfo;

		private var _cmd:String = "";

		public function Process()
		{
			super();
			nativeProcess = new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onError);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutput);
			nativeProcessStartupInfo = new NativeProcessStartupInfo();
		}

		public function start():void
		{
			if (running) return;
			exitCode = NaN;
			output = "";
			error = "";
			nativeProcessStartupInfo.executable = new File(cmd);
			nativeProcessStartupInfo.arguments = Vector.<String>(defaultArgs.concat(args));
			if (workingDir) nativeProcessStartupInfo.workingDirectory = new File(workingDir);
			nativeProcess.start(nativeProcessStartupInfo);
			updateRunning();
			nativeProcess.standardInput.writeUTFBytes(input);
		}

		public function exit(force:Boolean = true):void
		{
			nativeProcess.exit(force);
		}

		[Bindable(event="runningPropertyChanged")]
		public function get running():Boolean
		{
			return nativeProcess.running;
		}

		public function set cmd(path:String):void
		{
			_cmd = path;
			dispatchEvent(new FlexEvent("namePropertyChanged"));
		}

		public function get cmd():String
		{
			return _cmd;
		}

		[Bindable(event="namePropertyChanged")]
		public function get name():String
		{
			if (cmd) {
				try {
					return new File(cmd).name;
				}catch(e:Error){}
			}
			return "";
		}

		protected function onExit(e:NativeProcessExitEvent):void
		{
			exitCode = e.exitCode;
			updateRunning();
			dispatchEvent(e);
		}

		protected function updateRunning():void
		{
			dispatchEvent(new FlexEvent("runningPropertyChanged"));
		}

		protected function onError(e:ProgressEvent):void
		{
			error += nativeProcess.standardError.readUTFBytes(nativeProcess.standardError.bytesAvailable);
		}

		protected function onOutput(e:ProgressEvent):void
		{
			output += nativeProcess.standardOutput.readUTFBytes(nativeProcess.standardOutput.bytesAvailable);
		}
	}
}