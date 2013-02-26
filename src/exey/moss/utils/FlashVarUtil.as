package exey.moss.utils 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class FlashVarUtil 
	{
		
		static public function getVars(stage:Stage):Object
		{
			return stage.loaderInfo.parameters
		}
		
	}
}