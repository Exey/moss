package exey.moss.ctrl 
{
	import exey.moss.data.DataBaseProto;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author ...
	 */
	public class AbstractStarlingViewController 
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AbstractStarlingViewController(container:DisplayObjectContainer, dataBase:DataBaseProto)
		{
			this.container = container;
			_database = dataBase;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		protected var container:DisplayObjectContainer;
		protected var _database:DataBaseProto;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
	}

}