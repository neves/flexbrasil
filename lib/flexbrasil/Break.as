/**
Classe utilizada para fazer break de um loop de dentro de uma função.
try {
	throw new Break // disparar dentro de uma funcao
} catch(error:Break) {
	trace(typeof(error))
}
**/
package flexbrasil
{
	public class Break {}
}