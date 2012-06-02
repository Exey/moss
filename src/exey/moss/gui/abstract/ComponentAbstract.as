package exey.moss.gui.abstract
{
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 * Abstract Class of Visual Component
	 * @author Exey Panteleev
	 */
	public class ComponentAbstract extends Sprite
	{
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Component.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function ComponentAbstract(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			// process attributes
			if (parent != null)
				parent.addChild(this);
			move(xpos, ypos);
		}
		
		public function move(xpos:Number, ypos:Number):void
		{
			this.x = xpos;
			this.y = ypos;
		}
		
		public function show(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}
		
		public function hide():void
		{
			if (parent)
				parent.removeChild(this);
		}
		
		/**
		 * Marks the component to be redrawn on the next frame.
		 */
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		protected function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}
		
		public function draw():void
		{
			
		}
	}
}