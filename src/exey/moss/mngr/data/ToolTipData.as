package exey.moss.mngr.data 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ToolTipData {
		
		public var target:DisplayObject
		public var toolTip:ComponentAbstract
		public var onOver:Function
		public var onOut:Function
		
		public function ToolTipData(target:DisplayObject, toolTip:ComponentAbstract)
		{
			this.target = target
			this.toolTip = toolTip
		}
	}
}