package exey.moss.mngr 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.tooltip.TextToolTip;
	import exey.moss.gui.comps.tooltip.XMLToolTip;
	import exey.malevich.mngr.data.ToolTipData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class TooltipManager 
	{
		static public const ZERO_POINT:Point = new Point(0, 0);
		static private const DISTANCE:Number = 20;
		
		static private var toolTipsContainer:DisplayObjectContainer;
		static public var currentTarget:DisplayObject;
		static public var currentToolTip:ComponentAbstract;
		
		public function TooltipManager(toolTipsContainer:DisplayObjectContainer) 
		{
			TooltipManager.toolTipsContainer = toolTipsContainer;
		}
		
		public function update():void 
		{
			return;
			if (!TooltipManager.currentToolTip || !TooltipManager.currentTarget)
				return;
			var target:DisplayObject = currentTarget;
			var toolTip:ComponentAbstract = currentToolTip;
			var targetCoords:Point = target.localToGlobal(ZERO_POINT);
			var newX:Number = targetCoords.x + target.mouseX;
			var newY:Number = targetCoords.y + target.mouseY;
			if (newX < toolTipsContainer.stage.stageWidth * 0.5)
				newX += DISTANCE;
			else
				newX -= toolTip.width + DISTANCE;
			
			toolTip.move(newX, newY);
		}
		
		static public function addStaticToolTip(target:DisplayObject, text:String):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new TextToolTip(text));
			TooltipManager.addToolTip(tooltipData);
		}
		
		static public function addStaticXMLToolTip(target:DisplayObject, xml:XML):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new XMLToolTip(xml, 200));
			TooltipManager.addToolTip(tooltipData);
		}
		
		static public function addStaticXMLToolTip2(target:DisplayObject, xml:XML):void
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new XMLToolTip(xml, 400, 0xfcdb00, 0.7, 0x000000));
			TooltipManager.addToolTip(tooltipData);
		}
		
		static public function addStaticMultilineToolTip(target:DisplayObject, text:String, width:Number = 300):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new TextToolTip(text, width));
			TooltipManager.addToolTip(tooltipData);
		}		
		
		static public function addToolTip(data:ToolTipData):void 
		{
			var onOver:Function = function(e:Event):void {
				////trace("onOut", e.target)
				TooltipManager.showTooltip(data.target, data.toolTip);
			}
			
			var onOut:Function = function(e:Event):void {
				////trace("onOut", e.target)
				if (e.target is XMLToolTip)
					return;				
				TooltipManager.hideTooltip();
			}
			
			//data.target.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			data.target.addEventListener(MouseEvent.CLICK, onOver);
			//data.target.addEventListener(MouseEvent.MOUSE_OUT, onOut);			
			data.target.stage.addEventListener(MouseEvent.MOUSE_DOWN, onOut);			
		}
		
		static public function removeToolTip(data:ToolTipData):void 
		{
			data.target.removeEventListener(MouseEvent.MOUSE_OVER, data.onOver);
			data.target.removeEventListener(MouseEvent.MOUSE_OUT, data.onOut);
			data.toolTip = null
		}		
		
		static public function showTooltip(target:DisplayObject, toolTip:ComponentAbstract):void 
		{
			TooltipManager.currentTarget = target;
			if (TooltipManager.currentToolTip)
				TooltipManager.hideTooltip();
			var targetCoords:Point = target.localToGlobal(ZERO_POINT);
			TooltipManager.currentToolTip = toolTip;
			toolTip.show(toolTipsContainer);
			//toolTip.move(targetCoords.x, targetCoords.y);
			toolTip.move(650, 200);
		}
		
		static public function hideTooltip():void 
		{
			if (!TooltipManager.currentToolTip)
				return;
			TooltipManager.currentToolTip.hide();
			TooltipManager.currentToolTip = null;
		}
	}
}