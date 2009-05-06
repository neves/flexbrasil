package flexbrasil 
{
	
	/**
	 * Chama um metodo e ignora qualquer exceção disparada.
	 * @TODO: criar também uma classe Proxy
	 * @TODO: aceitar parâmetros
	 * @author ...
	 */
	public function tryCatch(method:Function)
	{
		try {
			method.call()
		}catch (e) {
			trace("tryCatch: ", e)
		}
	}
}