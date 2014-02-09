package exey.moss.mngr 
{
	import exey.moss.view.IView;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ViewManager 
	{	
		static private const views:Array = [];
		static private var viewsLength:int = 0;
		static private var viewLayer:Object;
		static public var currentView:IView;
		
		public function ViewManager(viewLayer:Object) 
		{
			ViewManager.viewLayer = viewLayer;
		}
		
		static public function addAndShow(v:IView):void 
		{
			add(v);
			simpleTransitionTo(viewsLength-1);
		}
		
		static public function add(v:IView):void 
		{
			views[viewsLength] = v;
			viewsLength++;
		}
		
		static public function simpleTransitionTo(index:uint):void 
		{
			if (currentView) {
				currentView.hide();
				viewLayer.removeChild(currentView);
			}
			var v:IView = views[index];
			v.show();
			viewLayer.addChild(v);
			currentView = v;
		}
		
		static public function simpleTransitionToView(v:IView):void 
		{
			if (currentView) {
				currentView.hide();
				viewLayer.removeChild(currentView);
			}
			v.show();
			viewLayer.addChild(v);
			currentView = v;
		}
		
	}
}