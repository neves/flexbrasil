package flexbrasil.flash
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class LayoutFluido extends MovieClip
	{
		public function LayoutFluido()
		{
			super();
			removeChildAt(0);
			stage.addEventListener(Event.RESIZE, onResize);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			onResize();
		}

		private function onResize(e:Event = null):void
		{
			parent.x = stage.stageWidth - parent.width;
			parent.y = stage.stageHeight - parent.height;
		}
	}
}