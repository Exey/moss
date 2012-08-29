package exey.moss.data {	
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class Data {
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
		
		protected function initInt(name:String, value:int = 0):void
		{
			vars.push(new IntVar(name, new Signal(int), value));
		}
		
		public function getInt(name:String):int
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
		
		public function updateInt(name:String, value:int):void
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
		
		public function addToInt(name:String, value:int):void
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
		
		protected function initNumber(name:String, value:Number = 0):void
		{
			vars.push(new NumberVar(name, new Signal(Number), value));
		}
		
		public function getNumber(name:String):Number
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
		
		public function updateNumber(name:String, value:Number):void
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
		
		public function addToNumber(name:String, value:Number):void
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
		
		protected function initString(name:String, value:String = undefined):void
		{
			vars.push(new StringVar(name, new Signal(String), value));
		}
		
		public function getString(name:String):String
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
		
		public function updateString(name:String, value:String):void
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
		
		protected function initArray(name:String, value:Array = undefined):void
		{
			vars.push(new ArrayVar(name, new Signal(Array), value));
		}
		
		public function getArray(name:String):Array
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
		
		public function updateArray(name:String, value:Array):void
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
		//  XML
		//
		//--------------------------------------------------------------------------
		
		protected function initXML(name:String, value:XML = undefined):void
		{
			vars.push(new XMLVar(name, new Signal(XML), value));
		}
		
		public function getXML(name:String):XML
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as XMLVar).value;
			}
			return null;
		}
		
		public function updateXML(name:String, value:XML):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as XMLVar).value = value;
					v.signal.dispatch(value);
					break;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Object
		//
		//--------------------------------------------------------------------------
		
		protected function initObject(name:String, value:Object = undefined):void {
			vars.push(new ObjectVar(name, new Signal(Object), value));
		}
		
		public function getObject(name:String):Object
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as ObjectVar).value;
			}
			return null;
		}
		
		public function updateObject(name:String, value:Object):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as ObjectVar).value = value;
					v.signal.dispatch(value);
					break;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected
		//
		//--------------------------------------------------------------------------
		
		public function listVars():String
		{
			var result:String = _name+":\n"
			for (var i:uint = 0; i < vars.length; i++)
				result += vars[i].name+" : "+(vars[i] as Object).value+"\n"
			return result
		}
		
		public function getVar(name:String):Object
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
					return (v as Object).value;
			}
			return null;
		}
		
		protected function updateVar(name:String, value:Object):void
		{
			var v:IVar;
			for (var i:uint = 0; i < vars.length; i++)
			{
				v = vars[i];
				if (v.name == name)
				{
					(v as Object).value = value;
					v.signal.dispatch((v as Object).value);
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