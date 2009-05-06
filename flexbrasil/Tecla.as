package flexbrasil
{
	import flash.events.*
	import flash.display.*
	import flash.utils.*
	import flash.ui.*

	public class Tecla extends Proxy
	{
		private static var keyStatus:Dictionary = new Dictionary()
		private static var iniciado = false
		private static var stageChild
		private static var e:EventDispatcher = new EventDispatcher()

		// ============================== Proxu =============================

		override flash_proxy function getProperty(name:*):* {
			return Tecla.pressionado(name)
    	}

		/**
		 * Adiciona um keyDown event especificamente para a tecla informada.
		 **/
		override flash_proxy function setProperty(tecla:*, callback:*):void {
			down = function(event)
			{
				if (event.keyCode == convertToConstKey(tecla))
				{
					callback(event)
				}
			}
		}

		override flash_proxy function callProperty(methodName:*, ... args):* {

		}

		public function toString():String
		{
			return "Tecla"
		}

		// ============================== static =============================

		public static function pressionado(tecla)
		{
			return keyStatus[convertToConstKey(tecla)]
		}

		/**
		 * A classe tecla, precisa do stage para ouvir os eventos de teclado.
		 * Pode ser iniciado com o próprio stage ou um filho do stage.
		 */
		public static function iniciar(stage:DisplayObject):void
		{
			// se não for stage, procurada pela propriedade stage
			if (!(stage is Stage))
			{
				// se ainda não foi adicionado no stage, ouve o evento ADDED_TO_STAGE para fazê-lo.
				if (stage.stage == null)
				{
					stage.addEventListener(Event.ADDED_TO_STAGE, autoIniciar)
					stageChild = stage
					return
				}
				stage = stage.stage
			}

			if (iniciado) return
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp)
			iniciado = true
		}

		public static function set down(callback:Function):void
		{
			e.addEventListener(KeyboardEvent.KEY_DOWN, callback)
		}

		public static function set undown(callback:Function):void
		{
			e.removeEventListener(KeyboardEvent.KEY_DOWN, callback)
		}

		public static function set up(callback:Function):void
		{
			e.addEventListener(KeyboardEvent.KEY_UP, callback)
		}

		public static function set unup(callback:Function):void
		{
			e.removeEventListener(KeyboardEvent.KEY_UP, callback)
		}

		// ============================== private =============================

		private static function convertToConstKey(tecla):*
		{
			if (int(tecla) > 0) return int(tecla)
			var k = Keyboard[tecla.toString().toUpperCase()]
			// Avisa se estiver verificando uma tecla que não existe.
			if (k === undefined) throw new Error("A constante Keyboard." + tecla + " não existe.")
			return k
		}

		/**
		 * Evento que responde ADDED_TO_STAGE
		 */
		private static function autoIniciar(e)
		{
			stageChild.removeEventListener(Event.ADDED_TO_STAGE, autoIniciar)
			iniciar(stageChild.stage)
		}

		/**
		 * Dispara o evento keyDown apenas uma vez,
		 * diferente do padrão que é disparar repetidamente,
		 * dependendo da configuração de teclado do usuário.
		 */
		private static function onKeyDown(event)
		{
			if (!keyStatus[event.keyCode])
				e.dispatchEvent(event)
			keyStatus[event.keyCode] = true
		}

		/**
		 * Funciona igual o padrão.
		 * Existe apenas para padronizar.
		 */
		private static function onKeyUp(event)
		{
			if (keyStatus[event.keyCode])
				e.dispatchEvent(event)
			keyStatus[event.keyCode] = false
		}
	}
}
