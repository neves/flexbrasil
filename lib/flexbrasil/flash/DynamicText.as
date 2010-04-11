package flexbrasil.flash
{
	import flash.display.*
	import flash.text.*
	import flexbrasil.*

	public class DynamicText extends MovieClip
	{
		private var tf:TextField

		public function DynamicText()
		{
			tf = getDynamicTextChildren()
		}

		public function set text(s:String):void
		{
			tf.text = s
		}

		public function get text():String
		{
			return tf.text
		}

		private function getDynamicTextChildren():TextField
		{
			return $(this).children.filter(function(item:*)
			{
				return item is TextField
			}).pop()
		}
	}
}