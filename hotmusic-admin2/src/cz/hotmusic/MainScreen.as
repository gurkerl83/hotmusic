package cz.hotmusic
{
	import cz.hotmusic.component.ActionButton;
	import cz.hotmusic.component.Header;
	import cz.hotmusic.component.Menu;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.Theme;
	
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
			
//			var saveButton:Button = new Button();
//			saveButton.label = "Save";
//			saveButton.addEventListener(Event.TRIGGERED, saveButtonTriggeredHandler);
//			
//			var cancelButton:Button = new Button();
//			cancelButton.label = "Cancel";
//			cancelButton.name = Theme.SMALL_BOLD_RED;
//			cancelButton.addEventListener(Event.TRIGGERED, cancelButtonTriggeredHandler);
//
//			var clearButton:Button = new Button();
//			clearButton.label = "Clear";
//			clearButton.name = Theme.SMALL_BOLD_BLUE;
//			clearButton.addEventListener(Event.TRIGGERED, clearButtonTriggeredHandler);
//
//			var addNewButton:Button = new Button();
//			addNewButton.label = "Add new ";
//			addNewButton.addEventListener(Event.TRIGGERED, addNewButtonTriggeredHandler);
//			
//			var buttons:Array = [saveButton, cancelButton, clearButton];
//			header.actionButtons(buttons);
			
			screenNavigator = new ScreenNavigator();
			screenNavigator.addScreen(SONGS_LIST, new ScreenNavigatorItem(SongsList,{showDetail: SONG_DETAIL}));
			screenNavigator.addScreen(SONG_DETAIL, new ScreenNavigatorItem(SongDetail,{close: SONGS_LIST}));
			
			screenNavigator.addScreen(ARTISTS_LIST, new ScreenNavigatorItem(ArtistsList,{showDetail: ARTIST_DETAIL}));
			screenNavigator.addScreen(ARTIST_DETAIL, new ScreenNavigatorItem(ArtistDetail,{close: ARTISTS_LIST}));
			
			screenNavigator.addScreen(ALBUMS_LIST, new ScreenNavigatorItem(AlbumsList,{showDetail: ALBUM_DETAIL}));
			screenNavigator.addScreen(ALBUM_DETAIL, new ScreenNavigatorItem(AlbumDetail,{close: ALBUMS_LIST}));
			
			screenNavigator.addScreen(GENRES_LIST, new ScreenNavigatorItem(GenresList,{showDetail: GENRE_DETAIL}));
			screenNavigator.addScreen(GENRE_DETAIL, new ScreenNavigatorItem(GenreDetail,{close: GENRES_LIST}));
			
			screenNavigator.addScreen(USERS_LIST, new ScreenNavigatorItem(UsersList,{showDetail: USER_DETAIL}));
			screenNavigator.addScreen(USER_DETAIL, new ScreenNavigatorItem(UserDetail,{close: USERS_LIST}));
			
			screenNavigator.addScreen(ADD_ARTISTS_LIST, new ScreenNavigatorItem(AddArtistsList,{showDetail: ADD_ARTIST_DETAIL}));
			screenNavigator.addScreen(ADD_ARTIST_DETAIL, new ScreenNavigatorItem(AddArtistDetail,{close: ADD_ARTISTS_LIST}));

			screenNavigator.addEventListener(Event.CHANGE, screenNavigatorChangeHandler);
			screenNavigator.showScreen(SONGS_LIST);
			
			menu = new Menu(screenNavigator);
			menu.setAuthorization(true, true, true);
			
//			var transitionManager:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(screenNavigator);
//			transitionManager.duration = 0.5;
			
			addChild(header);
			addChild(menu);
			addChild(screenNavigator);
		}
		
		override protected function draw():void {
			super.draw();
			
//			header.height = 100;
			header.width = actualWidth;
			
			menu.y = header.height;
			
			screenNavigator.x = menu.width;
			screenNavigator.y = header.height;
			screenNavigator.width = actualWidth - screenNavigator.x;
			screenNavigator.height = actualHeight - screenNavigator.y;
		}
		
		private function saveButtonTriggeredHandler(event:Event):void 
		{
			screenNavigator.activeScreen.dispatchEventWith(Event.CLOSE);
		}
		
		private function cancelButtonTriggeredHandler(event:Event):void 
		{
			screenNavigator.activeScreen.dispatchEventWith(Event.CLOSE);
		}

		private function clearButtonTriggeredHandler(event:Event):void 
		{
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