package cz.hotmusic.component
{
	import cz.hotmusic.MainScreen;
	import cz.hotmusic.lib.data.DataHelper;
	
	import feathers.controls.List;
	import feathers.controls.ScreenNavigator;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Menu extends FeathersControl
	{
		
		public function Menu(screenNavigator:ScreenNavigator)
		{
			super();
			this.screenNavigator = screenNavigator;
		}
		
		public static const SONGS		:String = "Songs";
		public static const ARTISTS		:String = "Artists";
		public static const ALBUMS		:String = "Albums";
		public static const GENRES		:String = "Genres";
		public static const USERS		:String = "Users";
		public static const ADD_ARTISTS	:String = "+Artists";
		
		private var screenNavigator:ScreenNavigator;
		
		private var authorizeGenres:Boolean;
		private var authorizeUsers:Boolean;
		private var authorizeAddArtist:Boolean;
		
		private var bg:DisplayObject;
		private var list:List;
		
		public function setAuthorization(genres:Boolean, users:Boolean, addArtists:Boolean):void
		{
			authorizeGenres = genres;
			authorizeUsers = users;
			authorizeAddArtist = addArtists;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			width = 250;
			
			bg = new Quad(1,1,0xCCCCCC);
			list = new List();
			list.dataProvider = createDataProvider();
			list.itemRendererProperties.labelField = "label";
			list.selectedIndex = 0;
			list.addEventListener(Event.CHANGE, listChangeHandler);
			list.hasElasticEdges = false;
			
			addChild(bg);
			addChild(list);
		}
		
		override protected function draw():void
		{
			super.draw();
			bg.width = actualWidth - 12;
			bg.height = actualHeight;
			
			list.y = 25;
			list.width = actualWidth;
		}
		
		private function createDataProvider():ListCollection
		{
			var lc:ListCollection = new ListCollection();
			lc.addItem({label:SONGS, page:MainScreen.SONGS_LIST});
			lc.addItem({label:ARTISTS, page:MainScreen.ARTISTS_LIST});
			lc.addItem({label:ALBUMS, page:MainScreen.ALBUMS_LIST});
			if (authorizeGenres)
				lc.addItem({label:GENRES, page:MainScreen.GENRES_LIST});
			if (authorizeUsers)
				lc.addItem({label:USERS, page:MainScreen.USERS_LIST});
			if (authorizeAddArtist)
				lc.addItem({label:ADD_ARTISTS, page:MainScreen.ADD_ARTISTS_LIST});
			
			return lc;
		}
		
		private var listChangePage:String;
		private function listChangeHandler(event:Event):void
		{
//			dispatchEventWith(String(event.currentTarget));
			listChangePage = List(event.currentTarget).selectedItem.page;
			DataHelper.getInstance().getData(String(List(event.target).selectedItem.label), function onData():void {
				screenNavigator.showScreen(listChangePage);
			});
		}
		
	}
}