package exey.moss.utils 
{
	import flash.utils.describeType;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ClassUtil 
	{
		
		static public function getExtends(obj:*):Array 
		{
			var a:Array = [];
			var dt:XML = describeType(obj)
			a[0] = dt.@name;
			for each (var ec:XML in dt.extendsClass) {
				a.push(ec.@type)
			}
			return a
		}
		
	}

}