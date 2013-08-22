package cz.hotmusic
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.FocusManager;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		private static const LOGIN_SCREEN:String = "loginScreen";
		private static const MAIN_LIST:String = "mainList";
		private static const DETAIL_SCREEN:String = "detailScreen";
		
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var _theme:Theme;
		public static var navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		private function addedToStageHandler(event:Event):void
		{
			FocusManager.isEnabled = true;
			this._theme = new Theme(this.stage);
			
			navigator = new ScreenNavigator();
			
			navigator.addScreen(LOGIN_SCREEN, new ScreenNavigatorItem(LoginScreen,
				{
					login: MAIN_LIST
				}));

			navigator.addScreen(MAIN_LIST, new ScreenNavigatorItem(MainScreen,
				{
					logout: LOGIN_SCREEN
				}));

			this.addChild(navigator);
			navigator.showScreen(LOGIN_SCREEN);

			this._transitionManager = new ScreenSlidingStackTransitionManager(navigator);
			this._transitionManager.duration = 0.5;
		}
	}
}