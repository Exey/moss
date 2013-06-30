package exey.moss.starling.ctrl 
{
	import exey.moss.data.DataBaseProto;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author ...
	 */
	public class AbstractViewController 
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AbstractViewController(container:DisplayObjectContainer, dataBase:DataBaseProto)
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