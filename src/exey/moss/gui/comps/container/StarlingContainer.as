package exey.moss.gui.comps.container 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class StarlingContainer extends Sprite
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function StarlingContainer(parent:DisplayObjectContainer, width:Number, height:Number)
		{
			//this.graphics.drawRect(0, 0, width, height);
			parent.addChild(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		private var _locked:Boolean;
		public function get locked():Boolean
		{
			return _locked;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function lock():void
		{
			if (_locked)
				return;
			_locked = true;
			//mouseChildren = false;
			//mouseEnabled = false;
		}
		
		public function unlock():void
		{
			if (!_locked)
				return;
			_locked = true;
			//mouseChildren = true;
			//mouseEnabled = true;
		}
		
	}

}