/**
 * Classe utilizada como Dummy para objetos que precisam ser utilizados no palco,
 * mas que não precisam/podem necessariamente extenderem MovieClip
 */
package flexbrasil.flash
{
	import flexbrasil.*
	import flash.display.*
	import flash.utils.*
	import flash.events.*

	public class Dummy extends MovieClip
	{
		/**
		 * Sempre aponta para o objeto real.
		 */
		public var instance:*

		public function Dummy()
		{
			var klass = getQualifiedClassName(this)
			klass = klass.replace(/Dummy$/, "")
			var ref:Class = getDefinitionByName(klass) as Class
			instance = new ref()
			instance.dummy = this
			removeMe()
		}

		/**
		 * Remove o dummy da tela ao iniciar o swf
		 */
		private function removeMe(e:Event = null)
		{
			if ( $(this).isRuntime )
				if (parent == null) {
					addEventListener(Event.ADDED_TO_STAGE, removeMe)
				} else {
					//parent.removeChild(this)
					visible = false
					removeEventListener(Event.ADDED_TO_STAGE, removeMe)
				}
		}
	}
}