package asteroid
{
	import flash.display.*
	import flash.events.*
	import flexbrasil.*

	public class Missel extends MovieClip
	{
		public function Missel(relativeTo:DisplayObject = null)
		{
			$(this).enterFrame = loop
			if (relativeTo)
			{
				rotation = relativeTo.rotation
				x = relativeTo.x
				y = relativeTo.y
				$(this).mover = width
			}
		}

		private function loop(e)
		{
			$(this).mover = 10
			// se estiver fora da tela, destruir o objeto
		}
	}
}