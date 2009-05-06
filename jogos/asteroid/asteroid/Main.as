package asteroid
{
	import flash.display.*
	import flash.net.*
	import flash.events.*
	import flash.utils.*
	import flash.media.*
	import flexbrasil.*

	public class Main extends MovieClip
	{
		private var nave:Nave
		public function Main()
		{
			nave = new Nave()
			addChild(nave)
			Tecla.iniciar(this)
			var arquivo = "arquivos.xml"
			//loadXml(arquivo, arquivoLoaded)
			$(this).addedToStage = addedToStage
		}

		private function addedToStage(e)
		{
			nave.x = stage.stageWidth / 2 + nave.width / 2
			nave.y = stage.stageHeight / 2 + nave.height / 2
		}

		private function arquivoLoaded(xml)
		{
			var s:Sound = new Sound(new URLRequest(xml.audios.file.@path))
			$(stage).click = function(e){
				//s.play()
			}
		}

		private function loadXml(arquivo:String, callback:Function):void
		{
			var request:URLRequest = new URLRequest(arquivo)
			var urlLoader:URLLoader = new URLLoader()
			urlLoader.load(request)
			urlLoader.addEventListener(Event.COMPLETE, function(e){
				callback(XML(e.target.data))
			})
		}
	}
}
