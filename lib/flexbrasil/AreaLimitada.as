package flexbrasil
{
	import flash.display.*
	import flash.events.*
	/**
	 * @author Marcos Neves flex ARROBA flexbrasil.com.br
	 */
	dynamic public class AreaLimitada extends MovieClip
	{
		/**
		 * Possui um conteúdo dummy para não dar erro NullException nos métodos.
		 */
		private var _conteudoTemp:DisplayObject;
		/**
		 * Aponta para o conteúdo que está sendo mascarado.
		 */
		private var _conteudo:DisplayObject;

		public function AreaLimitada()
		{
			_conteudoTemp = new Shape();
			_conteudo = _conteudoTemp;
			criarMascaraSeNaoExistir()
			this._mascara.visible = false;
			arrumarEscala()
		}

		/**
		 * Desta maneira, a classe pode estar na biblioteca ou ser instanciada por código.
		 */
		private function criarMascaraSeNaoExistir():void
		{
			if (!this._mascara)
			{
				this._mascara = new MovieClip()
				this._mascara.graphics.beginFill(0xFF0000)
				this._mascara.graphics.drawRect(0, 0, 100, 100)
				this._mascara.graphics.endFill()
				addChild(this._mascara)
			}
		}

		/**
		 * Transferir as transformações aplicadas ao elemento na scena,
		 * para a mascara interna e resetar a escala.
		 */
		private function arrumarEscala():void
		{
			this._mascara.width = super.width
			this._mascara.height = super.height
			scaleX = 1
			scaleY = 1
		}

		private function removerConteudo():void
		{
			removeChild(_conteudo);
			_conteudo.mask = null;
			_conteudo = _conteudoTemp;
		}

		public function set conteudo(c:DisplayObject):void
		{
			if (c === _conteudo) return;
			if (contains(_conteudo)) removerConteudo()
			if (c == null)
			{
				_conteudo = _conteudoTemp;
				return;
			}
			_conteudo = c
			addChild(_conteudo)
			_conteudo.x = 0
			_conteudo.y = 0
			_conteudo.mask = this._mascara
		}
		
		public function get conteudo():DisplayObject
		{
			return _conteudo === _conteudoTemp ? null : _conteudo;
		}

		override public function get width():Number
		{
			return this._mascara.width
		}

		override public function get height():Number
		{
			return this._mascara.height
		}

		override public function set width(novo:Number):void
		{
			this._mascara.width = novo
		}

		override public function set height(novo:Number):void
		{
			this._mascara.height = novo
		}

		public function set horizontal(h:Number)
		{
			_conteudo.x =  limitX * Calc.entre0e1(h)
		}

		public function get horizontal():Number
		{
			if (limitX == 0) return 0
			return _conteudo.x / limitX
		}

		public function get vertical():Number
		{
			if (limitY == 0) return 0
			return _conteudo.y / limitY
		}

		public function set vertical(v:Number):void
		{
			_conteudo.y = limitY * Calc.entre0e1(v)
		}

		private function get limitX():Number
		{
			return - (_conteudo.width - this._mascara.width)
		}

		private function get limitY():Number
		{
			return - (_conteudo.height - this._mascara.height)
		}
	}
}