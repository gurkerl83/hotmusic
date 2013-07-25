package cz.hotmusic.helper
{
	public class SortHelper
	{
		public function SortHelper()
		{
		}
		
		public static var _instance:SortHelper;
		public static function getInstance():SortHelper
		{
			if (_instance == null)
				_instance = new SortHelper();
			return _instance;
		}
		
		// INTERPRETS SORTING
		public static const INTERPRET_AZ			:int = 1;
		public static const INTERPRET_ZA			:int = 2;
		public static const INTERPRET_NEWEST		:int = 3;
		public static const INTERPRET_OLDEST		:int = 4;
		
		// GENRES SORTING
		public static const GENRES_AZ				:int = 5;
		public static const GENRES_ZA				:int = 6;
		
		// SORT BY STATUS
		public static const STATUS_ALL				:int = 7;
		public static const STATUS_HOTTEST			:int = 8;
		public static const STATUS_HOT				:int = 9;
		public static const STATUS_WARM				:int = 10;
		
		// SORT BY RATING
		public static const RATING_BEST				:int = 11;
		public static const RATING_WORST			:int = 12;
		
		public function sort(array:Array, sortBy:int):Array
		{
			var sortedArr:Array = array;
			if (array == null || sortBy <= 0 || sortBy > 12)
				return array;
			
			switch(sortBy)
			{
				case INTERPRET_AZ:	sortedArr.sortOn("song", Array.CASEINSENSITIVE);	break;
				case INTERPRET_ZA:	sortedArr.sortOn("song", Array.CASEINSENSITIVE|Array.DESCENDING);	break;
				case INTERPRET_NEWEST: sortedArr.sort(sortAdded, Array.DESCENDING); break;
				case INTERPRET_OLDEST: sortedArr.sort(sortAdded); break;
				case GENRES_AZ:	sortedArr.sortOn("genre", Array.CASEINSENSITIVE);	break;
				case GENRES_ZA:	sortedArr.sortOn("genre", Array.CASEINSENSITIVE|Array.DESCENDING);	break;
				case STATUS_ALL:	sortedArr = sortedArr.filter(filterStatusAll);	break;
				case STATUS_HOTTEST:	sortedArr = sortedArr.filter(filterHottest);	break;
				case STATUS_HOT:	sortedArr = sortedArr.filter(filterHot);	break;
				case STATUS_WARM:	sortedArr = sortedArr.filter(filterWarm);	break;
				case RATING_BEST: sortedArr.sort(sortRating, Array.DESCENDING); break;
				case RATING_WORST: sortedArr.sort(sortRating); break;
			}
			
			return sortedArr;
		}
		
		private function sortAdded(o1:Object, o2:Object):int
		{
			if (o1.added.time < o2.added.time)
				return -1;
			else if (o1.added.time > o2.added.time)
				return 1;
			else
				return 0;
		}
		
		private function filterStatusAll(o:Object, index:int, array:Array):Boolean
		{
			if (o.hotstatus > 0)
				return true;
			return false;
		}
		private function filterHottest(o:Object, index:int, array:Array):Boolean
		{
			if (o.hotstatus == 3)
				return true;
			return false;
		}
		private function filterHot(o:Object, index:int, array:Array):Boolean
		{
			if (o.hotstatus == 2)
				return true;
			return false;
		}
		private function filterWarm(o:Object, index:int, array:Array):Boolean
		{
			if (o.hotstatus == 1)
				return true;
			return false;
		}
		
		private function sortRating(o1:Object, o2:Object):int
		{
			var r1:Number,r2:Number;
			
			if (o1.ratedown == 0 && o1.rateup == 0)
				r1 = 0.5;
			else
				r1 = o1.rateup/(o1.rateup+o1.ratedown);
			
			if (o2.ratedown == 0 && o2.rateup == 0)
				r2 = 0.5;
			else
				r2 = o2.rateup/(o2.rateup+o2.ratedown);
				
			if (r1 < r2)
				return -1;
			else if (r1 > r2)
				return 1;
			else
				return 0;
		}
	}
}