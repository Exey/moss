package exey.moss.stage3d.ctrl 
{
	import exey.moss.data.DataBaseProto;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class AbstractViewController 
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AbstractViewController(dataBase:DataBaseProto) 
		{
			_database = dataBase;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		protected var _database:DataBaseProto;
		
	}
}