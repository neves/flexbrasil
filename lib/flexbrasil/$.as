package flexbrasil
{
	import flash.events.*;

	/**
	 * Atalho para criar um McProxy sobre o objeto.
	 */
	public function $(obj):*
	{
		return new McProxy(obj)
	}
}