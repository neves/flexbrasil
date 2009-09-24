package flexbrasil.labs 
{
	import flash.events.*;
	import flexbrasil.Img;
	/**
	 * Criar uma versão genérica para carregar qualquer coisa,
	 * ou um sequenciador genérico para qualquer coisa.
	 * @author ...
	 */
	public class CarregadorSequencial extends Array
	{
		private var current:Img = null

		public function load(e = null)
		{
			if (current)
			{
				current.removeEventListener(Event.COMPLETE, load)
				current.removeEventListener(IOErrorEvent.IO_ERROR, load)
			}
			current = shift()
			if ( ! current ) return // disparar evento de conclusao
			current.addEventListener(Event.COMPLETE, load)
			current.addEventListener(IOErrorEvent.IO_ERROR, load)
			current.load()
		}
	}	
}