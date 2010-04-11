package flexbrasil.layouts
{
	import flash.display.*
	import flash.events.*
	import flexbrasil.*

	public class Flow
	{
		private var container:DisplayObjectContainer
		public var width:Number = 100
		public var gapH:Number = 0
		public var gapV:Number = 0
		public var minW:Number = Number.MAX_VALUE
		public var minH:Number = Number.MAX_VALUE

		public function Flow(container:*, 
							 width:Number = 100, 
							 gapH:Number = 0, 
							 gapV:Number = 0,
							 minW:Number = Number.MAX_VALUE,
							 minH:Number = Number.MAX_VALUE)
		{
			if (container is DisplayObjectContainer)
			{
				this.width = width
				this.gapH = gapH
				this.gapV = gapV
				this.minW = minW
				this.minH = minH
				this.container = container
			}
			else if(container is Object)
			{
				for (var i in container)
				{
					this[i] = container[i]
				}
			}
			this.container.addEventListener(Event.ADDED, f(layout))
			this.container.addEventListener(Event.REMOVED, f(layout))
			layout()
		}
		
		public function layout()
		{
			var x = 0
			var y = 0
			var height = 0
			var primeiroDaColuna = true
			for each (var child:DisplayObject in $(container).children) {
				// sempre adiciona o primeiro, mesmo sendo maior que width
				if (primeiroDaColuna)
				{
					child.x = x
					child.y = y
					height = Math.max(height, child.height)
					primeiroDaColuna = false
				}else{
					if (x + child.width > width)
					{
						x = 0
						y += Math.min(height, minH) + gapV
						child.x = x
						child.y = y
						height = child.height
					}else{
						child.x = x
						child.y = y
						height = Math.max(height, child.height)
					}
				}
				x += child.width + gapH
			}
		}
	}
}