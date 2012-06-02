package exey.moss.data
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class VarAbstract
	{
		private var _name:String;
		public function get name():String {return _name;}
		private var _signal:Signal;
		public function get signal():Signal {return _signal;}
		
		public function VarAbstract(name:String, signal:Signal)
		{
			_signal = signal;
			_name = name;
		}
	}

}