package flexbrasil
{
	import flash.events.*;
	import flash.utils.*;
	import flash.display.*
	import flexbrasil.Calc

	public class McProxy extends Proxy
	{
		private var mc:*

		public function McProxy(mc)
		{
			this.mc = mc
		}

		/**
		 * Varre o movieClip, adicionando os listeners baseado no nome dos seus métodos.
		 * Por exemplo, se a classe tiver um metodo chamado onEnterFrame,
		 * ele será adicionado como o listener do evento enterFrame
		 * @param match:RegExp expressao regular utilizada para filtrar os metodos 
		 * que serão adicionados automaticamente como eventos handlers.
		 * on_addedToStage e onAddedToStage são convertido para o evento addedToStage
		 * @TODO, se nao tiver parametro, faz um wrapper.
		 */
		public function autoEvents(match = "^on[A-Z_].+")
		{
			var rx:RegExp = new RegExp(match)
			for each(var method in describeType(mc).method.@name)
			{
				if (rx.test(method))
				{
					// remove o prefixo
					var eventName = method.toString().replace(/^on_?/, "")
					// converte a primeira letra para minúsculo
					eventName = eventName.substr(0, 1).toLowerCase() + eventName.substr(1)
					// adiciona o evento
					this[eventName] = this.mc[method]
				}
			}
		}

		/**
		 * Desloca o objeto nas cordenadas x,y baseado em sua rotação
		 */
		public function set mover(pixels:Number):void
		{
			var dx = Math.cos(Calc.radianos(mc.rotation))
			var dy = Math.sin(Calc.radianos(mc.rotation))
			mc.x += dx * pixels
			mc.y += dy * pixels
		}

		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			mc.addEventListener(methodName, args[0])
		}
		
		override flash_proxy function getProperty(name:*):* {

		}

		override flash_proxy function setProperty(name:*, value:*):void
		{
			mc.addEventListener(name, value)
		}

		public function nextLabel(loop = false)
		{
			var next = false
			for each(var i in mc.currentLabels)
			{
				if (next)
				{
					mc.gotoAndStop(i.name)
					return
				}
				if (i.name == mc.currentLabel)
					next = true
			}
			if (loop)
				mc.gotoAndStop(mc.currentLabels[0].name)
		}

		public function prevLabel(loop = false)
		{
			var next = false
			var labels = mc.currentLabels.reverse()
			for each(var i in labels)
			{
				if (next)
				{
					mc.gotoAndStop(i.name)
					return
				}
				if (i.name == mc.currentLabel)
					next = true
			}
			if (loop)
				mc.gotoAndStop(labels[0].name)
		}

		/**
		 * Iterage nos filhos do container, retornando um array com todos eles.
		 */
		public function get children():Array
		{
			var a:Array = []
			for (var i = 0; i < mc.numChildren; i++)
				a.push(mc.getChildAt(i))
			return a
		}
	}
}