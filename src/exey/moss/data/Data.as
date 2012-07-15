package exey.moss.data
{	
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class Data
	{
		private var _name:String;
		protected var vars:Vector.<IVar> = new Vector.<IVar>();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------		
		
		public function Data(name:String)
		{
			_name = name;
		}
		
		public function addListener(varName:String, handler:Function):void 
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == varName)
				{
					v.signal.add(handler);
					break;
				}
			}
		}
		
		public function removeVar(name:String):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					vars.splice(i, 1);
			}
		}		
		
		//--------------------------------------------------------------------------
		//
		//  int
		//
		//--------------------------------------------------------------------------		
		
		public function initIntVar(name:String, value:int = 0):void
		{
			vars.push(new IntVar(name, new Signal(int), value));
		}
		
		public function getIntVar(name:String):int
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as IntVar).value;
			}
			return undefined;
		}
		
		public function updateIntVar(name:String, value:int):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as IntVar).value = value;
					v.signal.dispatch(value);
					break;
				}
			}
		}
		
		public function addToIntVar(name:String, value:int):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as IntVar).value += value;
					v.signal.dispatch(value);
					break;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Number
		//
		//--------------------------------------------------------------------------
		
		public function initNumberVar(name:String, value:Number):void
		{
			vars.push(new NumberVar(name, new Signal(Number), value));
		}
		
		public function getNumberVar(name:String):Number
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as NumberVar).value;
			}
			return NaN;
		}
		
		public function updateNumberVar(name:String, value:Number):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as NumberVar).value = value;
					v.signal.dispatch(value);
					break;
				}
			}
		}
		
		public function addToNumberVar(name:String, value:Number):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as NumberVar).value += value;
					v.signal.dispatch(value);
					break;
				}
			}
		}		
		
		//--------------------------------------------------------------------------
		//
		//  String
		//
		//--------------------------------------------------------------------------		
		
		public function initStringVar(name:String, value:String = undefined):void
		{
			vars.push(new StringVar(name, new Signal(String), value));
		}
		
		public function getStringVar(name:String):String
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as StringVar).value;
			}
			return null;
		}
		
		public function updateStringVar(name:String, value:String):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as StringVar).value = value;
					v.signal.dispatch(value);
					break;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Array
		//
		//--------------------------------------------------------------------------
		
		public function initArrayVar(name:String, value:Array = undefined):void
		{
			vars.push(new ArrayVar(name, new Signal(Array), value));
		}
		
		public function getArrayVar(name:String):Array
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as ArrayVar).value;
			}
			return null;
		}
		
		public function updateArrayVar(name:String, value:Array):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as ArrayVar).value = value;
					v.signal.dispatch(value);
					break;
				}
			}
		}		
		
		//--------------------------------------------------------------------------
		//
		//  Common
		//
		//--------------------------------------------------------------------------		
		
		public function toString():String
		{
			var s:String = "[Data: " + _name + "\n";
			var v:IVar;
			for (var i:int = 0; i < vars.length; i++)
			{
				v = vars[i];
				s += "      "+v.name + " = " + (v as Object).value + "\n";
			}
			s+="]"
			return s;
		}
	}
}