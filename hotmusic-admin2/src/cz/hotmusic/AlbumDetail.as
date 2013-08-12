package cz.hotmusic
{
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AlbumDetail extends Screen implements IActionButtons
	{
		public function AlbumDetail()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().saveButton, ButtonHelper.inst().cancelButton, ButtonHelper.inst().clearButton];
			}
			return _actionButtons;
		}
		
		private var albumname:FormItem;
		private var artistname:FormItem;
		private var genre:FormItem;
		private var releasedate:FormItem;
		private var itunes:FormItem;
		private var google:FormItem;
		private var amazon:FormItem;
		private var beatport:FormItem;
		
		override protected function initialize():void
		{
			super.initialize();
			
			albumname = new FormItem();
			albumname.orderNumber = "1.";
			albumname.label = "Album name";
//			albumname.value = "Slash";

			artistname = new FormItem();
			artistname.orderNumber = "2.";
			artistname.label = "Artist name";
			
			genre = new FormItem();
			genre.orderNumber = "3.";
			genre.label = "Genre";
			
			releasedate = new FormItem();
			releasedate.orderNumber = "4.";
			releasedate.label = "Release date";
			
			itunes = new FormItem();
			itunes.orderNumber = "5.";
			itunes.label = "iTunes link to buy";
			
			google = new FormItem();
			google.orderNumber = "6.";
			google.label = "Google Play link to buy";
			
			amazon = new FormItem();
			amazon.orderNumber = "7.";
			amazon.label = "Amazon link to buy";
			
			beatport = new FormItem();
			beatport.orderNumber = "8.";
			beatport.label = "Beatport link to buy";
			
			addChild(albumname);
			addChild(artistname);
			addChild(genre);
			addChild(releasedate);
			addChild(itunes);
			addChild(google);
			addChild(amazon);
			addChild(beatport);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 4;
			var gap:int = 20;
			
			albumname.x = padding;
			albumname.y = padding;
			albumname.width = actualWidth - 2*padding;
			
			artistname.x = padding;
			artistname.y = albumname.y + albumname.height + formgap;
			artistname.width = actualWidth - 2*padding;
			
			genre.x = padding;
			genre.y = artistname.y + artistname.height + formgap;
			genre.width = actualWidth - 2*padding;
			
			releasedate.x = padding;
			releasedate.y = genre.y + genre.height + gap;
			releasedate.width = actualWidth - 2*padding;
			
			itunes.x = padding;
			itunes.y = releasedate.y + releasedate.height + gap;
			itunes.width = actualWidth - 2*padding;
			
			google.x = padding;
			google.y = itunes.y + itunes.height + formgap;
			google.width = actualWidth - 2*padding;
			
			amazon.x = padding;
			amazon.y = google.y + google.height + formgap;
			amazon.width = actualWidth - 2*padding;
			
			beatport.x = padding;
			beatport.y = amazon.y + amazon.height + formgap;
			beatport.width = actualWidth - 2*padding;
		}
	}
}