package flexbrasil 
{
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * Exibe na tela o fps atual da animação.
	 * @author Marcos Neves flex ARROBA flexbrasil.com.br
	 */
	public class FPS extends MovieClip
	{
		private var _fps:Number = 30;
		private var ultimoTimer:Number = 0;
		private var textField:TextField;

		public function FPS()
		{
			addEventListener(Event.ENTER_FRAME, atualizarFps);
			textField = new TextField();
			textField.selectable = false;
			addChild(textField);
			blendMode = BlendMode.INVERT;
		}

		private function atualizarFps(e):void
		{
			var timerAtual = getTimer();
			fps = 1000 / (timerAtual - ultimoTimer);
			ultimoTimer = timerAtual;
			sempreAcima();
		}

		private function sempreAcima():void
		{
			var maiorPosicao = parent.numChildren - 1;
			var minhaPosicao = parent.getChildIndex(this);
			if (minhaPosicao != maiorPosicao)
				parent.setChildIndex(this, maiorPosicao);
		}

		private function set fps(numero:Number):void
		{
			_fps = Calc.atrasar(_fps, numero);
			textField.text = Math.round(_fps).toString();
		}
	}
}