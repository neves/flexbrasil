package flexbrasil.flash
{
	import flash.display.*
	import flash.text.*
	import flexbrasil.*
	import flash.events.*
	import flash.utils.*

	/**
	 * @TODO adicionar a classe os seguintes atributos:
	 *		url: para onde irá ao clicar no banner, por padrão sem link
	 *		target: em qual janela abrir, por padrão na mesma
	 *		duracao, se informado, o banner fica parado n segundos ao seu fim.
	 * @TODO permitir que textos/imagens não precisem estar no primeiro quadro.
	 * @TODO permitir carregar a fonte externamente dinamicamente.
	 * @TODO criar um componente Flash para a classe Img
	 * @TODO criar um componente Flash para DynamicBanner
	 */
	public class DynamicBanner extends Proxy
	{
		private var _mc:MovieClip
		private var _dummy:MovieClip
		private var lateCheck:Dictionary = new Dictionary()

		/**
		 * O Dummy sempre atribui ele mesmo para uma propriedade chamada dummy
		 */
		public function set dummy(mclip)
		{
			_dummy = mclip
			// chamar init apenas quando mclip.parent existir.
			$(_dummy).init = init
		}

		private function init()
		{
			// neste caso não precisamos do dummy, apenas do pai dele.
			// @BUG: dentro do objeto Proxy, this.propriedade nao chama callProperty
			// precisa criar uma referencia em uma variavel temporaria.
			var self = this
			_mc = _dummy.parent as MovieClip
			_mc.addEventListener(Event.ADDED, onAdded)
			_mc.addEventListener(Event.REMOVED, onRemoved)
		}

		/**
		 * memoriza um TextField/Img para ser modificado quando for adicionado na tela.
		 */
		private function addLate(child):void
		{
			if (child.name != "") {
				if (child is TextField) lateCheck[child.name] = child.htmlText
				else if (child is Img) lateCheck[child.name] = child.url
			}
		}

		/**
		 * @internal Diferente do onAdded, dispara apenas para o pai.
		 */		
		private function onRemoved(e)
		{
			var who = e.target
			addLate(who)
			$(who).recursiveChildren(addLate)
		}

		/**
		 * @internal Dispara para os filhos primeiro, 
		 * subindo a arvore ate o pai DisplayObject que foi adicionado.
		 */
		private function onAdded(e)
		{
			var who = e.target
			if (who is TextField || who is Img)
			{
				if(lateCheck[who.name] !== undefined)
				{
					setValue(who, lateCheck[who.name])
					delete lateCheck[who.name]
				}
			}
		}

		override flash_proxy function callProperty(methodName:*, ... args):*
		{

		}

		override flash_proxy function setProperty(nome:*, value:*):void 
		{
			var found:Boolean = false
			$(_mc).recursiveChildren(function(child)
			{
				if (child.name == nome)
				{
					found = setValue(child, value)
					if (found) throw new Break
				}
			})
			if (!found) lateCheck[nome] = value
		}

		/**
		 * Seta o texto ou url para "value", 
		 * dependendo se ele for TextField ou Img
		 */
		private function setValue(child, value)
		{
			if (child is TextField)
			{
				child.htmlText = value
				return true
			}else if (child is Img)
			{
				child.url = value
				return true
			}
			return false
		}
	}
}