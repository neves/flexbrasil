package
{
	import flash.display.*
	import flash.events.*
	import flexbrasil.*
	import flash.utils.*

	public class Pintar extends MovieClip
	{
		public function Pintar()
		{
			$(this).autoEvents();
		}

		public function on_mouseDown(e)
		{
			addEventListener(MouseEvent.MOUSE_MOVE, pintar)
			graphics.moveTo(mouseX, mouseY)
		}

		public function on_MouseUp(e)
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, pintar)
		}
		
		private function pintar(e)
		{
			graphics.beginFill(0xFF0000)
			graphics.lineStyle(25, 0xFF0000)
			graphics.lineTo(mouseX, mouseY)
			graphics.moveTo(mouseX, mouseY)
			graphics.endFill()
		}
	}
}