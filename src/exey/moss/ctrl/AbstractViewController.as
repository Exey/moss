package exey.moss.ctrl
{
	import exey.moss.data.DataBaseProto;
	import flash.display.DisplayObjectContainer;
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