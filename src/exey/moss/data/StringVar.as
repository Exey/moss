package exey.moss.data 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class StringVar extends VarAbstract implements IVar
	{
		private var _value:String;
		public function get value():String{return _value;}
		
		public function set value(value:String):void 
		{
			_value = value;
		}
		
		public function StringVar(name:String, signal:Signal, value:String) 
		{
			super(name, signal);
			_value = value;		
		}		
	}
}