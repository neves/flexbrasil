package flexbrasil.flash
{
	import flash.display.*
	import flash.utils.*
	import flash.text.*

	public class InfoPanel extends Proxy
	{
		private var container:DisplayObjectContainer
		private var hash:Object = {}

		public function InfoPanel(container:DisplayObjectContainer)
		{
			// criar um dummy para adicionar os inputs
			var dummy = new Sprite()
			container.addChild(dummy)
			this.container = dummy
		}

		override flash_proxy function getProperty(name:*):*
		{
			if (!hash.hasOwnProperty(name))
				return undefined
	        return hash[name].value;
	    }

		override flash_proxy function setProperty(name:*, value:*):void
		{
			if (!hash.hasOwnProperty(name))
				hash[name] = addInput(name, value)
			 hash[name].value = value;
	    }

		private function addInput(label, value):LabelInput
		{
			var ti = new LabelInput(label, value)
			ti.y = container.height
			container.addChild(ti)
			return ti
		}
	}
}