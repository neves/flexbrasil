package flexbrasil 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;

	/**
	 * @TODO: criar mecanismo de transição entre o loader antigo e o novo.
	 * @author ...
	 */
	public class Img extends Sprite
	{
		public var autoLoad:Boolean = true;
		/**
		 * Objeto com metadados definidos pelo usuário, referente a imagem carregada.
		 * Utilizar para armazenar id, categoria, cor, tamanho, descrição, título, etc...
		 */
		public var meta:Object = {}

		private var loader:Loader;
		private var oldLoader:Loader;
		private var _url:String;

		public function Img(url:String = null, width:Number = 0, heigth:Number = 0)
		{
			// remove o simbolo dummy utilizado para feedback no palco do flash.
			if (numChildren > 0)
			{
				scaleX = scaleY = 1
				removeChildAt(0);
			}
			// definir true caso queira interagir com o swf carregado
			mouseChildren = false // faz o target nos eventos de mouse ser sempre Img e não Loader
			this.url = url
		}

		public function set url(url:String):void
		{
			if (!url) return
			_url = url
			if (autoLoad) load()
		}

		public function load()
		{
			oldLoader = loader
			loader = new Loader()
			addListeners()
			loader.load(new URLRequest(_url))
			addChild(loader)
		}

		public function unload()
		{
			if (oldLoader)
			{
				try{
					oldLoader.close()
				}catch(e){}
				oldLoader.unloadAndStop()
				removeListeners()
				if (contains(oldLoader))
					removeChild(oldLoader)
				oldLoader = null
			}
		}

		// complete Dispatched when data has loaded successfully. LoaderInfo
		private function loaderComplete(e)
		{
			unload()
			dispatchEvent(e)
			//trace(e)
		}

		// unload Dispatched by a LoaderInfo object whenever a loaded object is removed by using the unload() method of the Loader object, or when a second load is performed by the same Loader object and the original content is removed prior to the load beginning. LoaderInfo 
		private function loaderUnload(e)
		{
			dispatchEvent(e)
			//trace(e)
		}
		
		// httpStatus Dispatched when a network request is made over HTTP and an HTTP status code can be detected. LoaderInfo 
		private function loaderHttpStatus(e)
		{
			dispatchEvent(e)
			//trace(e)
		}
		
		// init Dispatched when the properties and methods of a loaded SWF file are accessible. LoaderInfo 
		private function loaderInit(e)
		{
			dispatchEvent(e)
			//trace(e)
		}
		
		// ioError Dispatched when an input or output error occurs that causes a load operation to fail. LoaderInfo 
		private function loaderIoError(e)
		{
			dispatchEvent(e)
			//trace(e)
		}
		
		// open Dispatched when a load operation starts. LoaderInfo 
		private function loaderOpen(e)
		{
			dispatchEvent(e)
			//trace(e)
		}
		
		// progress Dispatched when data is received as the download operation progresses. LoaderInfo 
		private function loaderProgress(e)
		{
			dispatchEvent(e)
			//trace(e)
		}

		private function addListeners()
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete)
			loader.contentLoaderInfo.addEventListener(Event.UNLOAD, loaderUnload)
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, loaderHttpStatus)
			loader.contentLoaderInfo.addEventListener(Event.INIT, loaderInit)
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderIoError)
			loader.contentLoaderInfo.addEventListener(Event.OPEN, loaderOpen)
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgress)
		}

		private function removeListeners()
		{
			oldLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderComplete)
			oldLoader.contentLoaderInfo.removeEventListener(Event.UNLOAD, loaderUnload)
			oldLoader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loaderHttpStatus)
			oldLoader.contentLoaderInfo.removeEventListener(Event.INIT, loaderInit)
			oldLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loaderIoError)
			oldLoader.contentLoaderInfo.removeEventListener(Event.OPEN, loaderOpen)
			oldLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loaderProgress)
		}
	}
}