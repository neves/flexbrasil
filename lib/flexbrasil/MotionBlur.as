/*
 * Aplica MotionBlur automático no objeto baseado no seu deslocamento no eixo X e Y.
 * @TODO: Por enquanto suporta apenas movimento horizontal e vertical, acho não ser possível fazer na diagonal.
 */
package flexbrasil
{
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;

	public class MotionBlur
	{
		private var obj:DisplayObject;
		private var blur:BlurFilter;
		private var lastX:Number;
		private var lastY:Number;

		public var quality:Number = BitmapFilterQuality.LOW;
		public var factor:Number = 1;

		public function MotionBlur(obj:DisplayObject, quality:Number = 1, factor:Number = 1)
		{
			this.obj = obj;
			this.quality = quality;
			this.factor = factor;
			obj.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			blur = new BlurFilter(10, 10, quality);
			var f = obj.filters;
			f.push(blur)
			obj.filters = f;
		}

		private function onEnterFrame(e:Event):void
		{
			var deltaX:Number = Math.abs(obj.x - lastX);
			lastX = obj.x;
			var deltaY:Number = Math.abs(obj.y - lastY);
			lastY = obj.y;
			blur.blurX = deltaX * factor;
			blur.blurY = deltaY * factor;
			blur.quality = quality;
			obj.filters = update(obj.filters);
		}

		private function update(filters:Array)
		{
			return filters.map(cmp, this)
		}

		private function cmp(element:*, index:int, arr:Array):*
		{
			return element is BlurFilter ? this.blur : element;
		}
	}
}