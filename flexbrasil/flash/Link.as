package flexbrasil.flash
{
	import flash.display.*
	import flash.events.*
	import flash.net.*
	import flash.utils.*

	public class Link extends MovieClip
	{
		private var _url:String = "/";

		/**
		"_self" specifies the current frame in the current window. 
		"_blank" specifies a new window. 
		"_parent" specifies the parent of the current frame. 
		"_top" specifies the top-level frame in the current window. 
		*/
		private var _janela:String = "_blank";

		public function Link()
		{
			if(!isLivePreview) dummy.visible = false
			addEventListener(MouseEvent.CLICK, doAction)
		}

		private function get isLivePreview():Boolean
		{
			return parent != null && 
				   getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent";
		}

		private function doAction(e):void
		{
			navigateToURL(new URLRequest(_url), _janela)
		}

		[Inspectable(defaultValue="/", type="String")]
		public function get url():String
		{
			return _url;
		}

		public function set url(url:String):void
		{
			_url = url
		}

		[Inspectable(defaultValue="_blank", type="String")]
		public function get janela():String
		{
			return _janela;
		}

		public function set janela(janela:String):void
		{
			_janela = janela
		}
	}
}