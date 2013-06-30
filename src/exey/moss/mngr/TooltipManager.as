package exey.moss.mngr 
{
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Quad;
	import exey.moss.gui.comps.tooltip.TextToolTip;
	import exey.moss.mngr.data.ToolTipData;
	import exey.moss.utils.AnimationUtil;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/**
	 * Comfortable adding tooltips
	 * @author Exey Panteleev
	 */
	public class ToolTipManager 
	{
		static public const ZERO_POINT:Point = new Point(0, 0);
		static protected const DISTANCE:Number = 20;
		static protected const DELAY:Number = 0.2; // showing delay in seconds
		
		static private var container:DisplayObjectContainer;
		static private var textFormat:TextFormat;
		static public var current:ToolTipData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ToolTipManager(container:DisplayObjectContainer, textFormat:TextFormat = null) 
		{
			if(container)	ToolTipManager.container = container;
			if(textFormat) 	ToolTipManager.textFormat = textFormat;
		}
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------
		
		public function update():void 
		{
			if (!current) return;
			var c:ToolTipData = current;
			var targetCoords:Point = c.target.localToGlobal(ZERO_POINT);
			var newX:Number = targetCoords.x + c.target.mouseX;
			var newY:Number = targetCoords.y + c.target.mouseY;
			c.toolTip.move(newX, newY);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Static API
		//
		//--------------------------------------------------------------------------
		
		static public function addTextToolTip(target:DisplayObject, text:String):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new TextToolTip(text, 0, textFormat));
			add(tooltipData);
		}
		
		static public function addTextMultilineToolTip(target:DisplayObject, text:String, width:Number = 300):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new TextToolTip(text, width, textFormat));
			add(tooltipData);
		}		
		
		static public function add(data:ToolTipData):void 
		{
			data.onOver = function(e:MouseEvent):void {
				Actuate.timer(DELAY).onComplete(show, data, e.target.stage);
			}
			data.onOut 	= function(e:MouseEvent):void { hideCurrent(); }
			data.target.addEventListener(MouseEvent.ROLL_OVER, data.onOver);
			data.target.addEventListener(MouseEvent.ROLL_OUT, data.onOut);			
		}
		
		static public function remove(data:ToolTipData):void 
		{
			data.target.removeEventListener(MouseEvent.ROLL_OVER, data.onOver);
			data.target.removeEventListener(MouseEvent.ROLL_OUT, data.onOut);
			data.toolTip = null
		}
		
		static public function hideCurrent():void 
		{
			if (!current) return;
			current.toolTip.hide();
			current = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		static protected function show(data:ToolTipData, stage:Stage):void 
		{
			var targetContainer:DisplayObjectContainer = data.target.parent;
			var mouseCoord:Point = new Point(stage.mouseX, stage.mouseY);
			//var mouseLocal:Point = targetContainer.globalToLocal(mouseCoord);
			var isOver:Boolean = data.target.hitTestPoint(mouseCoord.x, mouseCoord.y);
			//trace("3:show", data.target, "|", isOver, "|", mouseCoord, "|", mouseLocal);
			if (!isOver) return;
			if (current) hideCurrent();
			current = data;
			var targetCoords:Point = data.target.localToGlobal(ZERO_POINT);
			data.toolTip.show(container);
			data.toolTip.alpha = 0;
			AnimationUtil.fadeIn(data.toolTip, DELAY, Quad.easeIn)
			data.toolTip.move(targetCoords.x, targetCoords.y);
		}
		
	}
}