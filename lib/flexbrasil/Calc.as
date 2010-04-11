package flexbrasil
{
	/**
	 * Rotinas matemáticas.
	 * O nome da classe é Calc para não conflitar com a classe Math padrão.
	 * @author Marcos Neves flex ARROBA flexbrasil.com.br
	 */
	public class Calc
	{
		/**
		 * É muito comum precisar garantir que determinado valor não ultrapasse certos limites,
		 * por exemplo, caso um valor em graus não possa ultrapassar -360 e 360.
		 * Calc.entre(-360, numero, 360)
		 * @param	min Valor mínimo permitido.
		 * @param	numero Número em contexto.
		 * @param	max Valor máximo permitido.
		 * @return Retorna valor, ou min/max caso o valor esteja fora destes limites.
		 */
		public static function entre(min:Number, numero:Number, max:Number):Number
		{
			return Math.max(min, Math.min(numero, max))
		}

		/**
		 * 
		 * @param	numero Número que deve estar entre 0 e 1
		 * @return Retorna valor, ou min/max caso o valor esteja fora destes limites.
		 */
		public static function entre0e1(numero:Number):Number
		{
			return entre(0, numero, 1)
		}

		/**
		 * Atrasa um valor proporcional ao parâmetro fator.
		 * @usage flexbrasil/_exemplos/Calc/atrasar.fla
		 * @param	origem Valor atual da propriedade
		 * @param	destino Valor a ser atribuída à propriedade
		 * @param	fator coeficiente de divisão, quanto maior, mais lento.
		 */
		public static function atrasar(origem:Number, destino:Number, fator:Number = 6)
		{
			var diferenca = destino - origem
			diferenca /= fator
			return snap(origem + diferenca, 0.0001)
		}

		/**
		 * Arredonda um numero para um intervalo fixo.
		 * @param	numero Valor que será arredondado de acordo com o intervalo definido
		 * @param	intervalo Qual o intervalo do snap
		 * @see flexbrasil/_exemplos/Calc/snap.fla
		 * @return valor arredondado
		 */
		public static function snap(numero:Number, intervalo:Number = 0.01):Number
		{
			var fator = 1 / intervalo;
			return Math.round(numero * fator) / fator;
		}

		/**
		 * Mesmo que snap, mas arredonda para baixo.
		 * @param	numero Valor que será arredondado de acordo com o intervalo definido
		 * @param	intervalo Qual o intervalo do snap
		 * @see flexbrasil/_exemplos/Calc/snap.fla
		 * @return valor arredondado
		 */
		public static function snapAbaixo(numero:Number, intervalo:Number = 0.1):Number
		{
			var fator = 1 / intervalo;
			return Math.floor(numero * fator) / fator;
		}

		/**
		 * Mesmo que snap, mas arredonda para baixo.
		 * @param	numero Valor que será arredondado de acordo com o intervalo definido
		 * @param	intervalo Qual o intervalo do snap
		 * @see flexbrasil/_exemplos/Calc/snap.fla
		 * @return valor arredondado
		 */
		public static function snapAcima(numero:Number, intervalo:Number = 0.1):Number
		{
			var fator = 1 / intervalo;
			return Math.ceil(numero * fator) / fator;
		}

		/**
		 * Converte radianos para graus
		 */		
		public static function graus(radianos:Number):Number
		{
			return radianos * 180 / Math.PI
		}

		/**
		 * Converte graus para radianos. 
		 * Todas as funções Math.* trabalham com angulos em radianos.
		 */
		public static function radianos(graus:Number):Number
		{
			return graus * Math.PI / 180
		}
	}
}