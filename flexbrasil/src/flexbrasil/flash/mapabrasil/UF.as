package
{
	import flash.display.*
	import flash.events.MouseEvent
	import flash.text.*
	import flash.geom.*
	import flash.filters.*
	import flash.utils.getQualifiedClassName

	public class UF extends MovieClip
	{
		var texto:TextField = new TextField();
		var _name:String;

		function UF()
		{
			setupLabelInsideBrasil()
		}

		private function setupLabelInsideBrasil()
		{
			_name = getQualifiedClassName(this);
			texto.text = _name;
			var tf:TextFormat = new TextFormat();
			tf.font = "Verdana";
			tf.size = Math.round(9/parent.scaleX);
			tf.color = 0;

			texto.setTextFormat(tf);
			texto.autoSize = TextFieldAutoSize.LEFT;
			var p:Point = localToGlobal(
				new Point(centro.x - texto.width/2, centro.y - texto.height/2)
			);
			p = parent.globalToLocal(p);
			texto.x = Math.round(p.x);
			texto.y = Math.round(p.y);
			texto.selectable = false;
			texto.mouseEnabled = false;
			parent.addChild(texto)
			removeChild(centro)
		}
	}
}