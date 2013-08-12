package cz.hotmusic
{
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.event.SongServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class SongDetail extends Screen implements IActionButtons, IActions
	{
		public function SongDetail()
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
		
		private var songname:FormItem;
		private var artistname:FormItem;
		private var albumname:FormItem;
		private var genre:FormItem;
		private var releasedate:FormItem;
		private var itunes:FormItem;
		private var google:FormItem;
		private var amazon:FormItem;
		private var beatport:FormItem;
		private var soundcloud:FormItem;
		private var youtube:FormItem;
		
		public function save():void
		{
//			if (!songname.value || !surname.value || !email.value)
//				return;
//			
//			var user:User = new User();
//			user.firstname = firstname.value;
//			user.surname = surname.value;
//			user.email = email.value;
//			user.adminRights = adminRightCB.isSelected;
//			user.genresAuthorized = genresCB.isSelected;
//			user.usersAuthorized = usersCB.isSelected;
//			user.addArtistAuthorized = addArtistCB.isSelected;
//			
//			var pse:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.REGISTER, createResult, createFault);
//			pse.user = user;
//			CairngormEventDispatcher.getInstance().dispatchEvent(pse);
		}
		
		public function clear():void
		{
			songname.value = "";
			albumname.value = "";
			genre.value = "";
			releasedate.value = "";
			itunes.value = "";
			google.value = "";
			amazon.value = "";
			beatport.value = "";
			soundcloud.value = "";
			youtube.value = "";
		}
		
		public function remove():void
		{
			
		}
		
		private function createResult(result:Object):void
		{
			DataHelper.getInstance().addEventListener(DataHelper.SONGS_COMPLETE, function sch(event:flash.events.Event):void {
				removeEventListener(DataHelper.SONGS_COMPLETE, sch);
				dispatchEventWith(starling.events.Event.CLOSE);
			});
		}
		
		private function createFault(info:Object):void
		{
			trace("got error");
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			songname = new FormItem();
			songname.orderNumber = "1.";
			songname.label = "Song name";
//			songname.value = "The Adventure Of Rain Dancce Maggie";
			
			artistname = new FormItem();
			artistname.orderNumber = "2.";
			artistname.label = "Artist name";
			
			albumname = new FormItem();
			albumname.orderNumber = "3.";
			albumname.label = "Album name";
			
			genre = new FormItem();
			genre.orderNumber = "4.";
			genre.label = "Genre";
			
			releasedate = new FormItem();
			releasedate.orderNumber = "5.";
			releasedate.label = "Release date";
			
			itunes = new FormItem();
			itunes.orderNumber = "6.";
			itunes.label = "iTunes link to buy";
			
			google = new FormItem();
			google.orderNumber = "7.";
			google.label = "Google Play link to buy";
			
			amazon = new FormItem();
			amazon.orderNumber = "8.";
			amazon.label = "Amazon link to buy";
			
			beatport = new FormItem();
			beatport.orderNumber = "9.";
			beatport.label = "Beatport link to buy";
			
			soundcloud = new FormItem();
			soundcloud.orderNumber = "10.";
			soundcloud.label = "Soundcloud listen link";
			
			youtube = new FormItem();
			youtube.orderNumber = "11.";
			youtube.label = "YouTube watch link";
			
			addChild(songname);
			addChild(artistname);
			addChild(albumname);
			addChild(genre);
			addChild(releasedate);
			addChild(itunes);
			addChild(google);
			addChild(amazon);
			addChild(beatport);
			addChild(soundcloud);
			addChild(youtube);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 4;
			var gap:int = 20;
			
			songname.x = padding;
			songname.y = padding;
			songname.width = actualWidth - 2*padding;
			
			artistname.x = padding;
			artistname.y = songname.y + songname.height + formgap;
			artistname.width = actualWidth - 2*padding;
			
			albumname.x = padding;
			albumname.y = songname.y + songname.height + formgap;
			albumname.width = actualWidth - 2*padding;
			
			genre.x = padding;
			genre.y = albumname.y + albumname.height + formgap;
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
			
			soundcloud.x = padding;
			soundcloud.y = beatport.y + beatport.height + gap;
			soundcloud.width = actualWidth - 2*padding;
			
			youtube.x = padding;
			youtube.y = soundcloud.y + soundcloud.height + gap;
			youtube.width = actualWidth - 2*padding;
		}
	}
}