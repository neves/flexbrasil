package asteroid
{
	import flash.display.*
	import flash.events.*
	import flexbrasil.*
	import flash.geom.*

	public class Nave extends MovieClip
	{
		private var velocidadeMovimento:Number = 0
		private var velocidadeRotacao:Number = 0
		private var aceleracao:Number = 0.1

		public function Nave()
		{
			stop()
			// Criar um setup que possa ser desfeito ao destruir.
			$(this).addedToStage = addedToStage
			//stage.frameRate = 1
		}

		private function addedToStage(e)
		{
			$(stage).mouseDown = disparar
			T.CONTROL = disparar
			$(this).enterFrame = loop
		}

		private function disparar(e)
		{
			var m = new Missel(this)
			parent.addChild(m)
		}

		public function explodir(e = null)
		{
			gotoAndPlay("explodir")
		}

		private function loop(e)
		{
			if (T.UP) velocidadeMovimento += aceleracao
			if (T.DOWN) velocidadeMovimento -= aceleracao
			if (T.LEFT) velocidadeRotacao -= aceleracao
			if (T.RIGHT) velocidadeRotacao += aceleracao
			velocidadeMovimento = Calc.entre(-2, velocidadeMovimento, 2)
			velocidadeRotacao = Calc.entre(-1, velocidadeRotacao, 1)
			//var r = Calc.graus(Math.atan2(stage.mouseY - y, stage.mouseX - x))
			//rotation = Calc.atrasar(rotation, r, 25)
			rotation += velocidadeRotacao
			$(this).mover = velocidadeMovimento
		}

		private function destroy()
		{
			parent.removeChild(this)
			delete this
			stop()
			removeEventListener(Event.ENTER_FRAME, loop)
		}
	}
}