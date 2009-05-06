package flexbrasil
{
	import flash.display.*;

	/**
	 * Funciona como a AreaLimitada, mas não adiciona o conteúdo interno,
	 * apenas se atribui para a propriedade mask do MovieClip.
	 * A vantagem é que a hierarquia do objeto alvo não é afetada.
	 * ...
	 * @author Marcos Neves flex ARROBA flexbrasil.com.br
	 */
	public class Mascara extends MovieClip
	{
		private var _alvo:DisplayObject;
		private var _alvoTemp:DisplayObject;
		private var _width:Number = 100;
		private var _height:Number = 100;
		/**
		 * Menor valor permitido para horizontal, vertical, v e h
		 */
		public var limiteMenor:Number = 0;
		public var limiteMaior:Number = 1;

		public function Mascara()
		{
			// remove o simbolo dummy utilizado para feedback no palco do flash.
			if (numChildren > 0)
			{
				_width = super.width;
				_height = super.height;
				removeChildAt(0);
			}
			redesenhar();
			_alvoTemp = new Shape();
			_alvo = _alvoTemp;
		}

		public function set alvo(d:DisplayObject):void
		{
			if (!d)
			{
				if (_alvo) _alvo.mask = null;
				d = _alvoTemp;
			}
			_alvo = d;
			_alvo.mask = this;
		}

		public function get alvo():DisplayObject
		{
			return _alvo === _alvoTemp ? null : _alvo;
		}

		/**
		 * @return Valor proporcional 0 e 1  que representa a posição horizontal do alvo em relação a mascara.
		 */
		public function get h():Number
		{
			return (_alvo.x - x) / width;
		}

		/**
		 * @return Valor proporcional 0 e 1  que representa a posição vertical do alvo em relação a mascara.
		 */
		public function get v():Number
		{
			return (_alvo.y - y) / height;
		}

		/**
		 * @param novo Valor proporcional 0 e 1  que representa a posição horizontal do alvo em relação a mascara.
		 */
		public function set h(novo:Number):void
		{
			novo = Calc.entre(limiteMenor, novo, limiteMaior)
			_alvo.x = novo * width + x
		}

		/**
		 * @param novo Valor proporcional 0 e 1  que representa a posição vertical do alvo em relação a mascara.
		 */
		public function set v(novo:Number):void
		{
			novo = Calc.entre(limiteMenor, novo, limiteMaior)
			_alvo.y = novo * height + y
		}

		override public function set width(novo:Number):void
		{
			_width = novo;
			redesenhar();
		}

		override public function set height(novo:Number):void
		{
			_height = novo;
			redesenhar();
		}

		/**
		 * horizontal e vertical de 0 a 1 para encaixar o alvo dentro da mascara.
		 */
		public function set horizontal(novo:Number)
		{
			novo = Calc.entre(limiteMenor, novo, limiteMaior)
			_alvo.x = x - novo * menorX
		}

		public function get horizontal():Number
		{
			return (x - _alvo.x) / menorX;
		}

		public function set vertical(novo:Number):void
		{
			novo = Calc.entre(limiteMenor, novo, limiteMaior)
			_alvo.y = y - novo * menorY
		}

		public function get vertical():Number
		{
			return (y - _alvo.y) / menorY;
		}

		private function get menorX():Number
		{
			return _alvo.width - width
		}

		private function get menorY():Number
		{
			return _alvo.height - height;
		}

		/**
		 * Para a mascara funcionar, eh preciso que ela tenha uma forma.
		 * @todo permitir fornecer outra forma, ou uma função que irá desenhar uma outra forma.
		 */
		private function redesenhar():void
		{
			scaleX = 1;
			scaleY = 1;
			graphics.clear();
			graphics.beginFill(0xFF0000);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
		}
	}
}