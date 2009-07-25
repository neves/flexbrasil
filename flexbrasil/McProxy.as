package flexbrasil
{
	import flash.events.*
	import flash.utils.*
	import flash.display.*
	import flexbrasil.Calc
	import flash.geom.*

	public class McProxy extends Proxy
	{
		private var mc:*

		public function McProxy(mc)
		{
			this.mc = mc
		}
		
		public function set init(callback:Function):void
		{
			if (mc.stage == null)
			{
				var addedToStage = function(e){
					callback()
					mc.removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
				}
				mc.addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			}else{
				callback()
			}
		}

		/**
		 * contrário de isLivePreview
		 */
		public function get isRuntime()
		{
			return ! isLivePreview
		}

		/**
		 * @return boolean true se o MovieClip estiver dentro do flash.
		 */
		public function get isLivePreview()
		{
			return mc.parent != null && 
				   getQualifiedClassName(mc.parent) == "fl.livepreview::LivePreviewParent";
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
			return this
		}

		public function forwardEvent(eventType, newEventType:String = "")
		{
			if (newEventType == "")
				newEventType = eventType
			mc.addEventListener(eventType, function(e)
			{
				if (e.target == e.currentTarget && eventType == newEventType) return
				e.stopPropagation()
				mc.dispatchEvent(new Event(newEventType, e.bubbles, e.cancelable))
			})
			return this
		}

		public function get point():Point
		{
			return new Point(mc.x, mc.y)
		}

		public function get pointGlobal():Point
		{
			return mc.parent.localToGlobal(point)
		}

		public function pointTo(target:DisplayObject):Point
		{
			return target.globalToLocal(pointGlobal)
		}

		/**
		 * @TODO: encontrar uma utilidade
		 */
		override flash_proxy function getProperty(name:*):* {

		}

		override flash_proxy function setProperty(name:*, value:*):void
		{
			mc.addEventListener(name, value)
		}

		/**
		 * gotoAndStop para o proximo label.
		 * @TODO: talvez criar uma propriedade que retorna apenas o nome do proximo label
		 * se loop for true, volta para o primeiro label se estiver no fim.
		 */
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

		/**
		 * gotoAndStop para o label anterior.
		 * @TODO: talvez criar uma propriedade que retorna apenas o nome do label anterior
 		 * se loop for true, volta para o último label se estiver no primeiro.
		 */
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
		 * retorna o path completo do MovieClip, separado por "." (ponto)
		 * Decidir se retorna stage e root no path também.
		 */
		public function get path():String
		{
			if (mc.parent == mc.root) return mc.name // nao traz stage.root
			if (mc.parent == null && mc is Stage) return "stage"
			if (mc == mc.root) return $(mc.parent).path + "." + "root"
			return $(mc.parent).path + "." + mc.name
		}

		/**
		 * Iterage nos filhos do container, retornando um array com todos eles.
		 * Retorna um array vazio para qualquer outra classe.
		 */
		public function get children():Array
		{
			if ( ! (mc is DisplayObjectContainer) ) return []
			var a:Array = []
			for (var i = 0; i < mc.numChildren; i++)
				a.push(mc.getChildAt(i));
			return a
		}

		public function recursiveChildren(callback:Function):void
		{
			if ( ! (mc is DisplayObjectContainer) ) return
			try {
				for (var i = 0; i < mc.numChildren; i++)
				{
					var child:DisplayObject = mc.getChildAt(i)
					callback(child)
					$(child).recursiveChildren(callback)
				}
			} catch(e:Break) {
				return
			}
		}

		/**
		 * Traz o MovieClip para frente em relação aos outros no mesmo container.
		 */
		public function trazerFrente():void
		{
			mc.parent.setChildIndex(mc, mc.parent.numChildren - 1)
		}

		/**
		 * Representação texto do MovieClip.
		 */
		public function toString()
		{
			return "$(" + getQualifiedClassName(mc) + ", " + mc.name + ")"
		}

		public function set right(px:Number)
		{
			if (!mc.parent) return
			var parentWidth = mc.parent == mc.root ? mc.stage.stageWidth : mc.parent.width
			mc.x = parentWidth - mc.width + px
		}

		public function set bottom(px:Number)
		{
			if (!mc.parent) return
			var parentHeight = mc.parent == mc.root ? mc.stage.stageHeight : mc.parent.height
			mc.y = parentHeight - mc.height + px
		}

		public function set depois(callback:Function)
		{
			var f:Function = function(e)
			{
				mc.removeEventListener(Event.ENTER_FRAME, f)
				callback.call(mc)
			}
			mc.addEventListener(Event.ENTER_FRAME, f)
		}
		
		public function removeChildren()
		{
			for (var i = mc.numChildren - 1; i >= 0; i--)
				mc.removeChildAt(i)
		}
		
		public function set cor(color:Number)
		{
			var c:ColorTransform = new ColorTransform()
			c.color = color
			mc.transform.colorTransform = c
		}
		
		public function get cor():Number
		{
			return mc.transform.colorTransform.color
		}

		public function get bitmapData():BitmapData
		{
			// não pode criar BitmapData com tamanho zero.
			var bmp = new BitmapData(Math.max(mc.width, 1), 
									 Math.max(mc.height, 1))
			bmp.draw(mc,
					 mc.transform.matrix,
					 mc.transform.colorTransform,
					 mc.blendMode,
					 null,
					 true)
			return bmp
		}
	}
}