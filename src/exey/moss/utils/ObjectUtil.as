package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ObjectUtil 
	{
		static public function getKeys(object:Object):Array
		{
			var result:Array = [];				
			for (var k:* in object) result.push(k);
			return result;
		}
		
		static public function swapKeyAndValues(obj:Object, keysToArray:Boolean = false):Object 
		{
			var result:Object = { };
			var val:*
			var rval:*
			for (var k:* in obj) {
				val = obj[k];
				rval = result[val] 
				if (rval && keysToArray) {
					if (rval is Array) (result[val] as Array).push(k)
				} else {
					if (keysToArray) result[val] = [k];
					else result[val] = k;
				}
			}
			return result;
		}
		
		static public function traceChilds(content:Object, prefix:String = ""):void {
			if (content.numChildren) {
				var child:Object;
				for (var i:int, n:int = content.numChildren; i < n; ++i) {
					child = content.getChildAt(i);	
					trace(prefix + child);
					if (child && child.numChildren) traceChilds(child, prefix+"-");
				}
			}
		}
		
		static public function dump(obj:Object, showFunctions:Boolean = false, showUndefined:Boolean = false, showXMLstructures:Boolean = false, maxLineLength:int = 100, indent:int = 0):String
		{
			if (obj == null) return "null";
			return realToString(obj, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent);
			
			function realToString(obj:Object, showFunctions:Boolean, showUndefined:Boolean, showXMLstructures:Boolean, maxLineLength:int, indent:int):String {
				var inProgress:Array = new Array();
				for (var x:int = 0; x < inProgress.length; x++) if (inProgress[x] == obj) return "***";				
				inProgress.push(obj);

				indent ++;
				var t:String = typeof(obj);
				//trace("<<<" + t + ">>>");
				var result:String;

				if ((obj is XML) && (showXMLstructures != true)) result = obj.toString();
				else if (obj is Date) result = obj.toString();
				else if (t == "object") {
					var nameList:Array = new Array();
					if (obj is Array){
					   result = "["; // "Array" + ":";
					   for (var i:int = 0; i < obj.length; i++) nameList.push(i);
					} else {
					   result = "{"; // "Object" + ":";
					   for (var k:* in obj) nameList.push(k);
					   nameList.sort();
					}

					//if (obj.length == undefined) trace("obj.length undefined");
					//if (obj.length == null) trace("obj.length null");
					//if (obj.length == 0) trace("obj.length 0");
					//trace("namelist length " + nameList.length + ", obj.length " + obj.length);
					var sep:String = "";
					for (var j:int = 0; j < nameList.length; j++) {
					   var val:* = obj[nameList[j]];
					   var show:Boolean = true;
					   if (typeof(val) == "function") show = (showFunctions == true);
					   if (typeof(val) == "undefined") show = (showUndefined == true);
					   if (show) {
						  result += sep;
						  if (!(obj is Array))result += nameList[j] + ": ";
						  result += realToString(val, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent);
						  sep = ", `";
					   }
					}
					if (obj is Array) result += "]";
					else result += "}";
				}
				else if (t == "function") result = "function";
				else if (t == "string") result = "\"" + obj + "\"";
				else result = String(obj);

				if (result == "undefined") result = "-";
				inProgress.pop();
				return StringUtil.replaceAll(result, "`", (result.length < maxLineLength) ? "" : ("\n" + doIndent(indent)));
			}
			
			function doIndent(indent:int):String {
				var result:String = "";
				for (var i:int = 0; i < indent; i ++)result += "     ";
				return result;
			}
		}		
		
		
		/**
		* Dumper обьектов
		*/
		static public function dumper(node:Object, fl:int = 2, name:String = '', tabs:String = ''):String {
			var attr:Vector.<String> = Vector.<String>([]);
			var i:int;	//	итерации
			var debStr:String = '';
			debStr += (name ? '\n' + tabs + '"'+ name + '": ' : '');

			var tp:String = typeof(node);
			////trace('typeof: ', tp, 'name: ', name, 'tabs: ', tabs.length);
			switch(tp) {
				case 'string':		// строка
					debStr += '"'+node+'"';
					break;
				case 'number':		// число
					debStr += node;
					break;
				case 'function':	// функция
				case 'object':		// обьект
					if(node == null) {
						debStr += 'null';
						break;
					}
					////trace('hhhhh: ', node.constructor,':', node.prototype);
					var constrType:String = node.constructor.toString();
					if(constrType == '[class Array]') {			// массив
						debStr += "["+ '\n' + tabs + '\t';
						for(i=0;i< node.length;i++) attr.push(dumper(node[i], fl, '', tabs+'\t'));
						////trace('attr: ',name , ' : ', attr);
						debStr += attr.join(',');
						debStr += '\n' + tabs + ']';
					} else if(constrType == '[class Object]') {	// хэш
						debStr += "{" + tabs + '\t';
						for(var prop:String in node) attr.push(dumper(node[prop], fl, prop, tabs+'\t'));
						debStr += tabs+'\t' + attr.join(',');
						debStr += '\n' + tabs + '}';
					} else  {									// напечатаем класс
						debStr += constrType;
					}
					break;
			}
			return debStr;
		}
	}
}