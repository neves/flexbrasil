package flexbrasil.mxml.controles
{
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.IViewCursor;
	import mx.controls.ComboBox;
	import mx.events.FlexEvent;

	/**
	 * Extende o ComboBox, adicionando os atributos selectedValue e valueField  
	 * @author Marcos Neves <marcos.neves@gmail.com>
	 */
	public class Combo extends ComboBox
	{
		/**
		 * mesmo funcionamento do labelField
		 */
		protected var _valueField:String = null;

		/**
		 * Por padrão, o valueField utiliza o mesmo valor do labelField
		 */
		[Bindable(event="valueCommit")] // preciso disparar valueCommit no set, para forçar atualização
		public function get valueField():String
		{
			return _valueField == null ? labelField : _valueField; 
		}

		public function set valueField(name:String):void
		{
			if (name == _valueField) return; 
			_valueField = name;
			dispatchEvent(new FlexEvent("valueCommit"));
		}

		[Bindable(event="valueCommit")]
		public function get selectedValue():Object
		{
			return itemToValue(selectedItem);
		}

		public function set selectedValue(newValue:Object):void
		{
			setSelectedItem(newValue)
		}

		/**
		 * Semelhante ao método privado de mesmo nome da classe pai ComboBase,
		 * mas utiliza itemToValue para fazer a comparação.
		 * Utiliza cursor para iteragir nos elementos do combo, ao invés de um for
		 */
		protected function setSelectedItem(data:Object):void
	    {
	        if (!collection || collection.length == 0)
	        {
	            invalidateDisplayList();
	            return;
	        }

			var listCursor:IViewCursor = collection.createCursor();
	        var i:int = 0;
	        do
	        {
	            if (data == itemToValue(listCursor.current))
	            {
	            	selectedIndex = i; // invalidateDisplayList() é executado aqui
					return;
	            }
	            i++;
	        }
	        while (listCursor.moveNext());

            selectedIndex = -1;
	    }

		/**
		 * helper que retorna o valor atual baseado no campo valueField
		 * Implementação baseado no método publico itemToLabel.
		 */
		protected function itemToValue(item:Object):String
		{
			// we need to check for null explicitly otherwise
			// a numeric zero will not get properly converted to a string.
			// (do not use !item)
			if (item == null)
				return null;
			
			if (typeof(item) == "object")
			{
				try
				{
					if (item[valueField] != null)
						item = item[valueField];
				}
				catch(e:Error)
				{
				}
			}
			else if (typeof(item) == "xml")
			{
				try
				{
					if (item[valueField].length() != 0)
						item = item[valueField];
				}
				catch(e:Error)
				{
				}
			}

			if (typeof(item) == "string")
				return String(item);

			try
			{
				return item.toString(); // @TODO suportar dados complexos como xml, objetos, etc
			}
			catch(e:Error)
			{
			}
			
			return null;
		}
	}
}