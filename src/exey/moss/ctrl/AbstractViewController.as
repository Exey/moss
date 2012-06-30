package exey.moss.ctrl
{
	import exey.moss.data.IDataBase;
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
		
		public function AbstractViewController(container:DisplayObjectContainer, dataBase:IDataBase)
		{
			this.container = container;
			this.database = dataBase;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		protected var container:DisplayObjectContainer;
		protected var database:IDataBase;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
	}

}