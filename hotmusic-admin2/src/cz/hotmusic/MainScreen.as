package cz.hotmusic
{
	import cz.hotmusic.component.ActionButton;
	import cz.hotmusic.component.Header;
	import cz.hotmusic.component.Menu;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.Theme;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class MainScreen extends Screen
	{
		public function MainScreen()
		{
			super();
		}
		
		// SCREEN IDS
		public static const SONGS_LIST			:String = "SONGS_LIST";
		public static const SONG_DETAIL			:String = "SONG_DETAIL";
		public static const ARTISTS_LIST		:String = "ARTISTS_LIST";
		public static const ARTIST_DETAIL		:String = "ARTIST_DETAIL";
		public static const ALBUMS_LIST			:String = "ALBUMS_LIST";
		public static const ALBUM_DETAIL		:String = "ALBUM_DETAIL";
		public static const GENRES_LIST			:String = "GENRES_LIST";
		public static const GENRE_DETAIL		:String = "GENRE_DETAIL";
		public static const USERS_LIST			:String = "USERS_LIST";
		public static const USER_DETAIL			:String = "USER_DETAIL";
		public static const ADD_ARTISTS_LIST	:String = "ADD_ARTISTS_LIST";
		public static const ADD_ARTIST_DETAIL	:String = "ADD_ARTIST_DETAIL";
		
		private var label:Label;
		private var header:Header;
		private var menu:Menu;
		private var screenNavigator:ScreenNavigator;
		
		override protected function initialize():void {
			super.initialize();
			
			header = new Header();
			header.addEventListener(ActionButton.SAVE_BUTTON, saveButtonTriggeredHandler);
			header.addEventListener(ActionButton.CANCEL_BUTTON, cancelButtonTriggeredHandler);
			header.addEventListener(ActionButton.CLEAR_BUTTON, clearButtonTriggeredHandler);
			header.addEventListener(ActionButton.ADD_NEW_BUTTON, addNewButtonTriggeredHandler);
			
			screenNavigator = new ScreenNavigator();
			var scr:DisplayObject;
			
			// SONGS
			
			screenNavigator.addScreen(SONGS_LIST, new ScreenNavigatorItem(SongsList,{showDetail: function onSongDetail(event:Event):void
			{
				scr = screenNavigator.showScreen(SONG_DETAIL)
				if (event.data != null)
					SongDetail(scr).songData = Song(event.data);
			}}));
			screenNavigator.addScreen(SONG_DETAIL, new ScreenNavigatorItem(SongDetail,{close: SONGS_LIST}));
			
			// ARTISTS
			
			screenNavigator.addScreen(ARTISTS_LIST, new ScreenNavigatorItem(ArtistsList,{showDetail: function onSongDetail(event:Event):void
			{
				scr = screenNavigator.showScreen(ARTIST_DETAIL)
				if (event.data != null)
					ArtistDetail(scr).artistData = Artist(event.data);
			}}));
			screenNavigator.addScreen(ARTIST_DETAIL, new ScreenNavigatorItem(ArtistDetail,{close: ARTISTS_LIST}));
			
			// ALBUMS
			
			screenNavigator.addScreen(ALBUMS_LIST, new ScreenNavigatorItem(AlbumsList,{showDetail: function onSongDetail(event:Event):void
			{
				scr = screenNavigator.showScreen(ALBUM_DETAIL)
				if (event.data != null)
					AlbumDetail(scr).data = Album(event.data);
			}}));
			screenNavigator.addScreen(ALBUM_DETAIL, new ScreenNavigatorItem(AlbumDetail,{close: ALBUMS_LIST}));
			
			// GENRES
			
			screenNavigator.addScreen(GENRES_LIST, new ScreenNavigatorItem(GenresList,{showDetail: function onSongDetail(event:Event):void
			{
				scr = screenNavigator.showScreen(GENRE_DETAIL)
				if (event.data != null)
					GenreDetail(scr).data = Genre(event.data);
			}}));
			screenNavigator.addScreen(GENRE_DETAIL, new ScreenNavigatorItem(GenreDetail,{close: GENRES_LIST}));
			
			// USERS
			
			screenNavigator.addScreen(USERS_LIST, new ScreenNavigatorItem(UsersList,{showDetail: function onSongDetail(event:Event):void
			{
				scr = screenNavigator.showScreen(USER_DETAIL)
				if (event.data != null)
					UserDetail(scr).data = User(event.data);
			}}));
			screenNavigator.addScreen(USER_DETAIL, new ScreenNavigatorItem(UserDetail,{close: USERS_LIST}));
			
			// ADD ARTIST
			
			screenNavigator.addScreen(ADD_ARTISTS_LIST, new ScreenNavigatorItem(AddArtistsList,{showDetail: function onSongDetail(event:Event):void
			{
//				scr = screenNavigator.showScreen(ADD_ARTIST_DETAIL)
//				if (event.data != null)
//					AddArtistDetail(scr).artistData = Artist(event.data);
			}}));
			screenNavigator.addScreen(ADD_ARTIST_DETAIL, new ScreenNavigatorItem(AddArtistDetail,{close: ADD_ARTISTS_LIST}));

			screenNavigator.addEventListener(Event.CHANGE, screenNavigatorChangeHandler);
			
			menu = new Menu(screenNavigator);
			menu.setAuthorization(Model.getInstance().user.genresAuthorized, Model.getInstance().user.usersAuthorized, Model.getInstance().user.addArtistAuthorized);
			
			addChild(header);
			addChild(menu);
			addChild(screenNavigator);
			
			screenNavigator.showScreen(SONGS_LIST);
		}
		
		override protected function draw():void {
			super.draw();
			
			var padding:int = 20;
//			header.height = 100;
			header.width = actualWidth;
			
			menu.y = header.height;
			menu.height = actualHeight - header.height;
			
			screenNavigator.x = menu.width + padding;
			screenNavigator.y = header.height + padding;
			screenNavigator.width = actualWidth - screenNavigator.x - padding;
			screenNavigator.height = actualHeight - screenNavigator.y - 2*padding;
		}
		
		private function saveButtonTriggeredHandler(event:Event):void 
		{
			IActions(screenNavigator.activeScreen).save();
//			screenNavigator.activeScreen.dispatchEventWith(Event.CLOSE);
		}
		
		private function cancelButtonTriggeredHandler(event:Event):void 
		{
			screenNavigator.activeScreen.dispatchEventWith(Event.CLOSE);
		}

		private function clearButtonTriggeredHandler(event:Event):void 
		{
			IActions(screenNavigator.activeScreen).clear();
//			screenNavigator.activeScreen.dispatchEventWith(Event.CLOSE);
		}

		private function addNewButtonTriggeredHandler(event:Event):void 
		{
			screenNavigator.activeScreen.dispatchEventWith("showDetail");
		}
		
		private function screenNavigatorChangeHandler(event:Event):void 
		{
			header.actionButtons(IActionButtons(screenNavigator.activeScreen).actionButtons);
		}
	}
}