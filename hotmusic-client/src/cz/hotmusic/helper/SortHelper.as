package cz.hotmusic.helper
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.lib.model.Song;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class SortHelper
	{
		public function SortHelper()
		{
		}
		
		private static var _instance:SortHelper;
		public static function getInstance():SortHelper
		{
			if (_instance == null) {
				_instance = new SortHelper();
				_instance.createSorts();
			}
			return _instance;
		}
		
		private function init():void
		{
			createSorts();
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
		
		public var sorts:Array;
		
		public function sort(array:Array, sortBy:int):Array
		{
			var sortedArr:Array = array;
			if (array == null || sortBy <= 0 || sortBy > 12)
				return array;
			
			switch(sortBy)
			{
				case INTERPRET_AZ:		sortedArr.sortOn("name", Array.CASEINSENSITIVE);	break;
				case INTERPRET_ZA:		sortedArr.sortOn("name", Array.CASEINSENSITIVE|Array.DESCENDING);	break;
				case INTERPRET_NEWEST:	sortedArr.sort(sortAdded, Array.DESCENDING); break;
				case INTERPRET_OLDEST:	sortedArr.sort(sortAdded); break;
				case GENRES_AZ:			sortedArr.sort(sortGenre, Array.CASEINSENSITIVE);	break;
				case GENRES_ZA:			sortedArr.sort(sortGenre, Array.CASEINSENSITIVE|Array.DESCENDING);	break;
				case STATUS_ALL:		sortedArr = sortedArr.filter(filterStatusAll);	break;
				case STATUS_HOTTEST:	sortedArr = sortedArr.filter(filterHottest);	break;
				case STATUS_HOT:		sortedArr = sortedArr.filter(filterHot);	break;
				case STATUS_WARM:		sortedArr = sortedArr.filter(filterWarm);	break;
				case RATING_BEST: 		sortedArr.sort(sortRating, Array.DESCENDING); break;
				case RATING_WORST: 		sortedArr.sort(sortRating); break;
			}
			
			return sortedArr;
		}
		
		private function sortAdded(o1:Song, o2:Song):int
		{
			if (o1.addedDate.time < o2.addedDate.time)
				return -1;
			else if (o1.addedDate.time > o2.addedDate.time)
				return 1;
			else
				return 0;
		}

		private function sortGenre(o1:Song, o2:Song):int
		{
			if (o1.genre.name < o2.genre.name)
				return -1;
			else if (o1.genre.name > o2.genre.name)
				return 1;
			else
				return 0;
		}
		
		private function filterStatusAll(o:Song, index:int, array:Array):Boolean
		{
			if (o.hotstatus > 0)
				return true;
			return false;
		}
		private function filterHottest(o:Song, index:int, array:Array):Boolean
		{
			if (o.hotstatus == 3)
				return true;
			return false;
		}
		private function filterHot(o:Song, index:int, array:Array):Boolean
		{
			if (o.hotstatus == 2)
				return true;
			return false;
		}
		private function filterWarm(o:Song, index:int, array:Array):Boolean
		{
			if (o.hotstatus == 1)
				return true;
			return false;
		}
		
		private function sortRating(o1:Song, o2:Song):int
		{
			var r1:Number,r2:Number;
			
			if (o1.rateDown == 0 && o1.rateUp == 0)
				r1 = 0.5;
			else
				r1 = o1.rateUp/(o1.rateUp+o1.rateDown);
			
			if (o2.rateDown == 0 && o2.rateUp == 0)
				r2 = 0.5;
			else
				r2 = o2.rateUp/(o2.rateUp+o2.rateDown);
				
			if (r1 < r2)
				return -1;
			else if (r1 > r2)
				return 1;
			else
				return 0;
		}
		
		private function createSorts():void 
		{
			sorts =	[
				{ 
					header: "Interprets sorting",
					children: [
						{ sortby: "A-Z", sortbykey: SortHelper.INTERPRET_AZ},
						{ sortby: "Z-A", sortbykey: SortHelper.INTERPRET_ZA},
						{ sortby: "newest first", sortbykey: SortHelper.INTERPRET_NEWEST},
						{ sortby: "oldest first", sortbykey: SortHelper.INTERPRET_OLDEST}
					]
				},{
					header: "Genres Sorting",
					children: [
						{ sortby: "A-Z", sortbykey: SortHelper.GENRES_AZ},
						{ sortby: "Z-A", sortbykey: SortHelper.GENRES_ZA}
					]	
				},{
					header: "Sort by status",
					children: [
						{ sortby: "View All", sortbykey: SortHelper.STATUS_ALL, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.HotAll())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.HotAllSelected()))},
						{ sortby: "Hottest", sortbykey: SortHelper.STATUS_HOTTEST, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.Hottest())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.HottestSelected()))},
						{ sortby: "Hot", sortbykey: SortHelper.STATUS_HOT, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.Hot())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.HotSelected()))},
						{ sortby: "Warm", sortbykey: SortHelper.STATUS_WARM, rightNormalImg: new Image(Texture.fromBitmap(new FontAssets.Warm())), rightSelectedImg: new Image(Texture.fromBitmap(new FontAssets.WarmSelected()))}
					]
				},{
					header: "Sort by rating",
					children: [
						{leftNormalImg: new Image(Texture.fromBitmap(new FontAssets.RateUpSmall())), leftSelectedImg: new Image(Texture.fromBitmap(new FontAssets.RateUpSmallSelected())), sortby: "Best first", sortbykey: SortHelper.RATING_BEST},
						{leftNormalImg: new Image(Texture.fromBitmap(new FontAssets.RateDownSmall())), leftSelectedImg: new Image(Texture.fromBitmap(new FontAssets.RateDownSmallSelected())), sortby: "Worst first", sortbykey: SortHelper.RATING_WORST}
					]
				}
			];
		}
	}
}