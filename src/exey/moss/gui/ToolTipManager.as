package exey.moss.gui 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.tooltip.TextToolTip;
	import exey.moss.mngr.data.ToolTipData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Comfortable adding tooltips
	 * @author Exey Panteleev
	 */
	public class ToolTipManager 
	{
		static public const ZERO_POINT:Point = new Point(0, 0);
		static private const DISTANCE:Number = 20;
		
		static private var toolTipsContainer:DisplayObjectContainer;
		static public var currentTarget:DisplayObject;
		static public var currentToolTip:ComponentAbstract;
		
		public function ToolTipManager(toolTipsContainer:DisplayObjectContainer) 
		{
			ToolTipManager.toolTipsContainer = toolTipsContainer;
		}
		
		public function update():void 
		{
			if (!ToolTipManager.currentToolTip || !ToolTipManager.currentTarget)
				return;
			var target:DisplayObject = currentTarget;
			var toolTip:ComponentAbstract = currentToolTip;
			var targetCoords:Point = target.localToGlobal(ZERO_POINT);
			var newX:Number = targetCoords.x + target.mouseX;
			var newY:Number = targetCoords.y + target.mouseY;
			
			toolTip.move(newX, newY);
		}
		
		static public function addStaticToolTip(target:DisplayObject, text:String):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new TextToolTip(text));
			ToolTipManager.addToolTip(tooltipData);
		}
		
		static public function addStaticMultilineToolTip(target:DisplayObject, text:String, width:Number = 300):void 
		{
			var tooltipData:ToolTipData = new ToolTipData(target, new TextToolTip(text, width));
			ToolTipManager.addToolTip(tooltipData);
		}		
		
		static public function addToolTip(data:ToolTipData):void 
		{
			var onOver:Function = function(e:Event):void {
				ToolTipManager.showTooltip(data.target, data.toolTip);
			}
			
			var onOut:Function = function(e:Event):void {
				ToolTipManager.hideTooltip();
			}
			
			data.target.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			data.target.addEventListener(MouseEvent.MOUSE_OUT, onOut);			
		}
		
		static public function removeToolTip(data:ToolTipData):void 
		{
			data.target.removeEventListener(MouseEvent.MOUSE_OVER, data.onOver);
			data.target.removeEventListener(MouseEvent.MOUSE_OUT, data.onOut);
			data.toolTip = null
		}		
		
		static public function showTooltip(target:DisplayObject, toolTip:ComponentAbstract):void 
		{
			ToolTipManager.currentTarget = target;
			if (ToolTipManager.currentToolTip)
				ToolTipManager.hideTooltip();
			var targetCoords:Point = target.localToGlobal(ZERO_POINT);
			ToolTipManager.currentToolTip = toolTip;
			toolTip.show(toolTipsContainer);
			toolTip.move(targetCoords.x, targetCoords.y);
		}
		
		static public function hideTooltip():void 
		{
			if (!ToolTipManager.currentToolTip)
				return;
			ToolTipManager.currentToolTip.hide();
			ToolTipManager.currentToolTip = null;
		}
	}
}