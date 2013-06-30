package exey.moss.ctrl
{
	import exey.moss.data.DataBaseProto;
	import exey.moss.gui.comps.container.Container;
	import exey.moss.mngr.KeyboardManager;
	import exey.moss.mngr.WindowManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;

	public class AbstractGameController
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function AbstractGameController()
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
		public var topLayer:Container;
		public var tooltipLayer:Container;
		public var windowLayer:Container;
		public var hudLayer:Container;
		public var viewLayer:Container;		
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		protected function initLayers(container:DisplayObjectContainer, w:Number, h:Number):void {
			viewLayer 		= new Container(container, w, h, "viewLayer");
			hudLayer 		= new Container(container, w, h, "hudLayer");
			windowLayer 	= new Container(container, w, h, "windowLayer");
			tooltipLayer 	= new Container(container, w, h, "tooltipLayer");
			topLayer 		= new Container(container, w, h, "topLayer");
		}
		
		protected function initManagers():void {
			new KeyboardManager(container.stage);
			new WindowManager(windowLayer);
		}
		
	}

}