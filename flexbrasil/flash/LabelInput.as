package flexbrasil.flash
{
	import flash.display.*
	import flash.text.*
	import flexbrasil.Calc

	public class LabelInput extends Sprite
	{
		public var labelField:TextField
		private var valueField:TextField
		private var _value:*

		public function LabelInput(label:String = "Label", value:* = "")
		{
			createFields()
			this.label = label
			this.value = value
		}

		override public function get height():Number
		{
			return Math.max(labelField.textHeight, valueField.textHeight)
		}

		private function createFields():void
		{
			labelField = new TextField()
			valueField = new TextField()
			valueField.x = labelField.width
			labelField.autoSize = TextFieldAutoSize.RIGHT
			valueField.autoSize = TextFieldAutoSize.LEFT
			var tf:TextFormat = new TextFormat()
			tf.font = "Verdana"
			tf.size = 10
			
			valueField.defaultTextFormat = tf

			tf.align = TextFormatAlign.RIGHT
			tf.bold = true
			labelField.defaultTextFormat = tf

			labelField.selectable = valueField.selectable = false
			
			addChild(labelField)
			addChild(valueField)
		}

		public function set label(label:String):void
		{
			labelField.text = label + ":"
		}

		public function get label():String
		{
			return labelField.text
		}

		public function set value(value:*):void
		{
			_value = value
			valueField.text = String(value is Number ? Calc.snap(value) : _value)
		}

		public function get value():*
		{
			return _value
		}
	}
}
