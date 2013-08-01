package cz.hotmusic
{
	import cz.hotmusic.helper.LoginHelper;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	
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
		
		private var _theme:MetalWorksMobileTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		private function addedToStageHandler(event:Event):void
		{
			this._theme = new MetalWorksMobileTheme(this.stage);
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._navigator.addScreen(LOGIN_SCREEN, new ScreenNavigatorItem(LoginScreen,
				{
					login: MAIN_LIST
				}));

			this._navigator.addScreen(MAIN_LIST, new ScreenNavigatorItem(MainListScreen,
				{
					showDetail: DETAIL_SCREEN
				}));
			
			this._navigator.addScreen(DETAIL_SCREEN, new ScreenNavigatorItem(DetailScreen,
				{
					complete: MAIN_LIST
				}));

			autologin(mainScreen, loginScreen);
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.5;
		}
		
		private function loginScreen():void
		{
			_navigator.showScreen(LOGIN_SCREEN);
		}
		
		private function mainScreen():void
		{
			_navigator.showScreen(MAIN_LIST);
		}
		
		private function autologin(successCall:Function, failCall:Function):void {
			var lh:LoginHelper = LoginHelper.getInstance();
			
			if (!lh.isLoginSO()) {
				failCall.call();
				return;
			}
			
			var loginSO:Object = lh.getLoginSO();
			lh.login(loginSO.user, loginSO.pass, loginSO.isFB, successCall, failCall)
		}
	}
}