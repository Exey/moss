package exey.moss.data 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class IntVar extends VarAbstract implements IVar
	{
		private var _value:int;
		public function get value():int {return _value;}
		
		public function set value(value:int):void 
		{
			_value = value;
		}
		
		public function IntVar(name:String, signal:Signal, value:int) 
		{
			super(name, signal);
			_value = value;			
		}
	}

}