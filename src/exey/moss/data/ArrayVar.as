package exey.moss.data 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ArrayVar extends VarAbstract implements IVar 
	{		
		private var _value:Array;
		public function get value():Array {return _value;}		
		
		public function set value(value:Array):void 
		{
			_value = value;
		}		
		
		public function ArrayVar(name:String, signal:Signal, value:Array) 
		{
			super(name, signal);
			_value = value;	
		}
	}
}