package exey.moss.data 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class AnyVar extends VarAbstract implements IVar
	{
		private var _value:*;
		public function get value():* {return _value;}
		
		public function AnyVar(name:String, signal:Signal, value:*) 
		{
			_value = value;		
		}
	}
}