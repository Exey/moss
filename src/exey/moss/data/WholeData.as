package exey.moss.data 
{
	import org.osflash.signals.Signal;
	/**
	 * Non-atomic whole request/response data
	 * @author Exey Panteleev
	 */
	public class WholeData extends Data 
	{
		public var wholeUpdate:Signal = new Signal();
		public var wholeError:Signal = new Signal();		
		
		public var rawData:Object;
		
		public function WholeData(name:String) 
		{
			super(name);
		}
		
		/**
		 * Plain basic deserializer
		 * @param	json
		 */
		public function deserializeJSON(json:Object):void
		{
			var v:Object;
			var delayedSignalVars:Array = [];
			for (var name:String in json) {
				v = updateVar(name, json[name], false); // silent update
				if(v) delayedSignalVars.push(v);
				if(v)  trace(name+" IS UPDATED TO "+json[name]);
				if(!v) trace("3:"+name+" IS NOT INITIALIZED");
			}
			wholeUpdate.dispatch();
			for (var i:int = 0; i < delayedSignalVars.length; i++) {
				v = delayedSignalVars[i];
				v.signal.dispatch((v as Object).value);
			}
			//deb(listVars())
		}
		
		/**
		 * Plain basic deserializer
		 * @param	xml
		 */
		public function deserializeXML(xml:XML):void 
		{
			var v:Object;
			var delayedSignalVars:Array = [];
			for(var i:int=0;i<xml.children().length();i++) {
				var data:XML = xml.children()[i];
				//trace("3:", data.name(), "|", data.text());
				v = updateVar(data.name(), data.text(), false); // silent update
				if(v) delayedSignalVars.push(v);
				if(v)  trace(data.name()+" IS UPDATED TO "+data.text());
				if(!v) trace("3:"+data.name()+" IS NOT INITIALIZED");				
			}
			wholeUpdate.dispatch();
			for (i = 0; i < delayedSignalVars.length; i++) {
				v = delayedSignalVars[i];
				v.signal.dispatch((v as Object).value);
			}
			//deb(listVars())
		}
		
		/**
		 * 
		 * @param	...rest
		 */
		public function updateGroup(...rest):void {
			var vars:Array = []
			for (var i:int = 0; i < rest.length; i++) {
				vars.push(updateVar(rest[i][0], rest[i][1], false));
			}
			var v:IVar;
			for (var j:int = 0; j < vars.length; j++) {
				v = vars[j];
				v.signal.dispatch((v as Object).value)
			}
			wholeUpdate.dispatch();
		}
		
		public function dispose():void
		{
			var length:int = vars.length;
			for (var i:int = 0; i < length; i++) {
				Object(vars[i]).value = null;
			}
		}		
		
	}
}