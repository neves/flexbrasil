package flexbrasil.flash
{
	import flash.display.*
	import flash.events.*
	
	/**
	 * Basta arrastar dentro do MovieClip que possui os labels,
	 * e nomear os botoes com o mesmo nome dos labels dos quadros.
	 */
	public class AutoGotoLabel extends MovieClip
	{
		private var pai:MovieClip
		public function AutoGotoLabel()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}

		private function onAddedToStage(e)
		{
			// salva o pai, pois serei removido do container
			pai = parent as MovieClip
			pai.stop()
			pai.addEventListener(MouseEvent.CLICK, parentClick)
			pai.removeChild(this) // remove o dummy da tela
		}

		private function parentClick(e:MouseEvent)
		{
			var label = e.target.name
			if ( pai.currentLabels.some (
					function(frameLabel) {
						return frameLabel.name == label
					}
				 )
			) {
				pai.gotoAndStop(label)
				e.stopPropagation()
			}
		}
	}
}