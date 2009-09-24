/**
 * import flexbrasil.*
 * ou
 * import flexbrasil.f
 * para chamar, utilizar apenas f(...)
 */
package flexbrasil
{
	import flash.events.*;

	public function f(func:Function):Function
	{
		return function(e:Event):void
		{
			func.call();
		}
	}
}