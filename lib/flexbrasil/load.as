﻿package flexbrasil
{
	import flash.events.*;
	import flash.net.*
	import flash.system.Security;

	/**
	 * Carrega um arquivo de dados externo e passa para direto para o callback.
	 * Suporta hash like parameters.
	 */
	public function load(url:*, 
						 callback:Function = null, 
						 callbackFail:Function = null, 
						 format:String = "text"):void
	{
		if (!(url is String))
		{
			if (url.callback) callback = url.callback;
			if (url.callbackFail) callbackFail = url.callbackFail;
			if (url.format) format = url.format;
			if (url.url) url = url.url;
		}
		var remote = Security.sandboxType.toString() == "remote";
		if (remote) // se remoto, aplica uma data na url para limpar o cache
		{
			url += url.indexOf("?") == -1 ? "?" : "&";
			url += new Date().getTime();
		}

		var urlRequest:URLRequest = new URLRequest(url);
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = format;

		var ok:Function = function(e) {
			
			callback.call(this, urlLoader.data)
		}
		var fail:Function = function(e) {
			if (e is HTTPStatusEvent && (e.status == 200 || e.status == 0)) return;
			if (callbackFail is Function) callbackFail.call(this, e);
			trace(e);
		}
		urlLoader.addEventListener(Event.COMPLETE, ok);
		urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, fail);
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, fail);
		urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, fail);
		urlLoader.load(urlRequest);
	}
}