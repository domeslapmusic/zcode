class tv.zarate.Utils.MathUtils{
	
	// Returns random between min and max, including both

	public static function getRandomBetween(min:Number,max:Number):Number{
		return min + Math.floor(Math.random()*(max+1-min));
	}
	
	// Returns random between 0 and max, including both
	
	public static function getRandom(max:Number):Number{
		return getRandomBetween(0,max);
	}
	
}