package exey.moss.debug 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public function deb(...rest):void
	{
		CONFIG::debug {
			stackTrace(rest)
		}
	}

}