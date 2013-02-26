package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ArraySortUtils 
	{
		
        static public function stringLongToShortw(a:String, b:String):int {
            if (a.length < b.length) 		return 1;
            else if (a.length > b.length) 	return -1;
            else							return 0;
        }
		
        static public function stringNothing(a:String, b:String):int {
			if (cols.indexOf(a) > cols.indexOf(b)) 			return 1;
			else if (cols.indexOf(a) < cols.indexOf(b)) 	return -1;
			else											return 0;
        }
		
	}
}