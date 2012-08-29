package exey.moss.ctrl {
	
	import exey.moss.data.DataBaseProto;
	import exey.moss.gui.comps.container.StarlingContainer;
	import exey.moss.mngr.KeyboardManager;
	import exey.moss.mngr.WindowManager;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author ...
	 */
	public class AbstractStarlingGameController 
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AbstractStarlingGameController()
		{

		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		// data model
		protected var _dataBase:DataBaseProto;
		
		// main container, usually root sprite
		public var container:DisplayObjectContainer;
		// layers
		public var topLayer:StarlingContainer;
		public var tooltipLayer:StarlingContainer;
		public var windowLayer:StarlingContainer;
		public var hudLayer:StarlingContainer;
		public var viewLayer:StarlingContainer;		
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		protected function initLayers(container:DisplayObjectContainer, w:Number, h:Number):void {
			viewLayer 		= new StarlingContainer(container, w, h);
			hudLayer 		= new StarlingContainer(container, w, h);
			windowLayer 	= new StarlingContainer(container, w, h);
			tooltipLayer 	= new StarlingContainer(container, w, h);
			topLayer 		= new StarlingContainer(container, w, h);
		}
		
		protected function initManagers():void {
			//new KeyboardManager(container.stage);
			//new WindowManager(windowLayer);
		}
		
	}

}