package exey.moss.data 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class NumberVar extends VarAbstract implements IVar
	{
		private var _value:Number;
		public function get value():Number {return _value;}		
		
		public function set value(value:Number):void 
		{
			_value = value;
		}
		
		public function NumberVar(name:String, signal:Signal, value:Number) 
		{
			super(name, signal);
			_value = value;		
		}
	}
}