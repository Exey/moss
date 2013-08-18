package exey.moss.gui.comps.window 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public interface ICenteredWindowAbstract 
	{
		function get closeSignal():Signal;
		function updateContainerSize(width:Number, height:Number):void;
		function animateIn():void;
		function animateOut():void;
		function destroy():void;
	}
}