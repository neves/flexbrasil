package flexbrasil
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flexbrasil.Calc;
	
	/**
	 * Proxy que atrasa a atribuição de valores numéricos para as propriedades dos objetos.
	 * Faz o mesmo que Calc.atrasar, mas de uma forma mais elegante!
	 * @author Marcos Neves flex ARROBA flexbrasil.com.br
	 * @example flexbrasil/_exemplos/labs/atrasador.fla
	 */
	dynamic public class Atrasador extends Proxy
	{
		public var fator:Number = 5;
		private var proxy:Object;

		public function Atrasador(proxy:Object, fator:Number = 5)
		{
			this.fator = fator;
			this.proxy = proxy;
		}

		override flash_proxy function setProperty(name:*, value:*):void
		{
			proxy[name] = Calc.atrasar(proxy[name], value, fator);
		}

		override flash_proxy function getProperty(name:*):*
		{
			return proxy[name];
		}
	}
}