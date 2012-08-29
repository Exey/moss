package exey.moss.mngr {
	import flash.net.SharedObject;

    public class SharedObjectManager extends Object {
        public function SharedObjectManager() {}
        static public function setProperty(name:String, varName:String, value:Object) : void {
            var so:SharedObject = SharedObject.getLocal(name);
            SharedObject.getLocal(name).data[varName] = value;
            so.flush();
        }
		
        static public function getProperty(name:String, varName:String) : Object {
            return SharedObject.getLocal(name).data[varName];
        }
		
        static public function getData(name:String):Object {
            return SharedObject.getLocal(name).data;
        }

    }
}
