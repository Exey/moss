package exey.moss.data 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class XMLVar extends VarAbstract implements IVar 
	{		
		private var _value:XML;
		public function get value():XML {return _value;}		
		
		public function set value(value:XML):void 
		{
			_value = value;
		}		
		
		public function XMLVar(name:String, signal:Signal, value:XML) 
		{
			super(name, signal);
			_value = value;	
		}
		
	}

}