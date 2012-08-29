package exey.moss.data 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ObjectVar extends VarAbstract implements IVar 
	{		
		private var _value:Object;
		public function get value():Object {return _value;}		
		
		public function set value(value:Object):void 
		{
			_value = value;
		}		
		
		public function ObjectVar(name:String, signal:Signal, value:Object) 
		{
			super(name, signal);
			_value = value;	
		}
	}
}