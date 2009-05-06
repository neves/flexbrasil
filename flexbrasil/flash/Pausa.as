package flexbrasil.flash
{
	import flash.display.*
	import flash.events.*
	import flash.text.*
	import flash.utils.*
	import fl.livepreview.LivePreviewParent;

	dynamic public class Pausa extends MovieClip
	{
		//public var _duracao:TextField
		public function Pausa()
		{
			if (!isLivePreview) visible = false
			(parent as MovieClip).stop()
			addEventListener(Event.ENTER_FRAME, enterFrame)
		}

		private function get isLivePreview():Boolean
		{
			return parent != null && 
				   getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent";
		}

		private function enterFrame(e)
		{
			removeEventListener(Event.ENTER_FRAME, enterFrame)
			var timer:Timer = new Timer(duracao * 1000, 1)
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completo)
			timer.start()
		}

		private function completo(e)
		{
			(parent as MovieClip).play()
		}

		[Inspectable(defaultValue=3, type="Number")]
		public function get duracao():Number
		{
			return parseFloat(_duracao.text);
		}

		public function set duracao(d:Number):void
		{
			_duracao.text = d.toString();
		}
	}
}