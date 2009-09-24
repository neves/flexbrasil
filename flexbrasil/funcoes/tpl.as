/**
 * import flexbrasil.funcoes.*
 * ou
 * import flexbrasil.funcoes.tpl
 * para chamar, utilizar apenas tpl("dir/{n}.jpg", {n:23})
 */
package flexbrasil.funcoes
{
	public function tpl(str:String, vars:Object, padrao = ""):String
	{
		return str.replace(/\{([^\{\}]+)\}/g, function() {
			var word = arguments[1]
			return vars[word] == undefined ? padrao : vars[word]
		})
	}
}