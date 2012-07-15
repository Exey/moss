package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ObjectUtil 
	{
		static public function getKeys(object:Object):Array {
			var result:Array = [];				
			for (var k:*in object) result.push(k);
			return result;
		}
	}
}