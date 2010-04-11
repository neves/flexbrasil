package asteroid
{
	import flash.display.*
	import flash.events.*
	import flexbrasil.*

	public class Asteroid extends MovieClip
	{
		public function Asteroid()
		{
			stop()
			$(this).click = explodir
			$(this).enterFrame = loop
		}
		
		public function explodir(e = null)
		{
			gotoAndPlay("explodir")
		}

		private function loop(e)
		{
			
		}

		private function destroy()
		{
			parent.removeChild(this)
			delete this
			stop()
		}
	}
}