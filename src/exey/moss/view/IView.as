package exey.moss.view
{
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public interface IView
	{
		function show():void;
		function hide():void;
		function fadeOut(duration:Number):void;
		function fadeIn(duration:Number, delay:Number):void;
	}
	
}