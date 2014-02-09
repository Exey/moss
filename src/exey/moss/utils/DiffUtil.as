package exey.moss.utils 
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class DiffUtil 
	{
		
		static public function calculatesWaveDiff(wave:Vector.<uint>, wave2:Array):Array 
		{
			var diffs:Array = [];
			var currentDiff:int;
			var wave2Length:uint = wave2.length;
			var waveLength:uint = wave.length-wave2Length;
			var i:int, j:int;
			for (i = 0; i < waveLength; i++) {
				currentDiff = 0;
				for (j = 0; j < wave2Length; j++) {
					currentDiff += Math.abs(wave[i+j]-wave2[j]);
				}
				diffs[i] = currentDiff;
			}
			return diffs;
		}
		
		static public function calculateMaxMinDiffIndexes(diffs:Array):Array 
		{
			var bestDiffIndex:int, lastBest:int = int.MAX_VALUE;
			var worstDiffIndex:int, lastWorst:int = 0;
			var currentDiff:int;
			//var diffTotal:int = 0;
			for (var k:int = 0; k < diffs.length; k++) {
				currentDiff = diffs[k]
				//diffTotal += currentDiff; // for detect sound start
				if (lastBest > currentDiff) {
					bestDiffIndex = k;
					lastBest = currentDiff
				}
				if (lastWorst < currentDiff) {
					worstDiffIndex = k;
					lastWorst = currentDiff;
				}
			}
			return [bestDiffIndex, worstDiffIndex]
		}
		
	}
}