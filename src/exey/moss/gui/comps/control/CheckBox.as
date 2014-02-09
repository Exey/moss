package exey.moss.gui.comps.control 
{
	import exey.moss.gui.comps.button.RadioButton;
	import exey.moss.utils.LoaderUtil;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 
	 */
	public class CheckBox extends RadioButton
	{
		
		public function CheckBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, label:String = "", scale:Number = 1, textFormat:TextFormat = null) 
		{
			super(parent, xpos, ypos, label, scale, textFormat);
		}
		
		override public function draw():void
		{
			var radius:Number = DEFAULT_RADIUS * scale;
			
			this.graphics.lineStyle(BORDER_THICKNESS*scale, BORDER_COLOR);
			this.graphics.beginFill(BACKGROUND_COLOR);
			this.graphics.drawRect(0, 0, radius*2, radius*2);
			
			dot = new Sprite();
			dot.graphics.beginFill(DOT_COLOR);
			dot.graphics.drawRect(0, 0, radius*2 - scale*4, radius*2 - scale*4);
			dot.x = (4 * scale+BORDER_THICKNESS)*0.5;
			dot.y = (4 * scale+BORDER_THICKNESS)*0.5;
			addChild(dot);
		}		
		
	}
}