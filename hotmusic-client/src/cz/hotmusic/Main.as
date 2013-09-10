package cz.hotmusic
{
	import cz.hotmusic.helper.LoginHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
import feathers.core.FocusManager;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		private static const LOGIN_SCREEN:String = "loginScreen";
		private static const CREATE_ACCOUNT_SCREEN:String = "createAccountScreen";
		private static const MAIN_LIST:String = "mainList";
		private static const DETAIL_SCREEN:String = "detailScreen";
		
		public function Main()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var _theme:MetalWorksMobileTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		private function addedToStageHandler(event:starling.events.Event):void
		{
            FocusManager.isEnabled = true;
			this._theme = new MetalWorksMobileTheme(this.stage);
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._navigator.addScreen(LOGIN_SCREEN, new ScreenNavigatorItem(LoginScreen,
				{
					login: MAIN_LIST,
					create: CREATE_ACCOUNT_SCREEN
				}));

			this._navigator.addScreen(MAIN_LIST, new ScreenNavigatorItem(new MainListScreen(),
				{
					showDetail: DETAIL_SCREEN
				}));
			
			this._navigator.addScreen(DETAIL_SCREEN, new ScreenNavigatorItem(DetailScreen,
				{
					complete: MAIN_LIST
				}));

			this._navigator.addScreen(CREATE_ACCOUNT_SCREEN, new ScreenNavigatorItem(CreateAccountScreen,
				{
					login: MAIN_LIST,
					back: LOGIN_SCREEN
				}));

			autologin(mainScreen, loginScreen);
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.5;
		}
		
		private function loginScreen(fault:Object=null):void
		{
			_navigator.showScreen(LOGIN_SCREEN);
		}
		
		private function mainScreen(result:ResultEvent=null):void
		{
			Model.getInstance().user = User(result.result);
			
			DataHelper.getInstance().addEventListener(DataHelper.INIT_COMPLETE, function ich(e:flash.events.Event):void {
				removeEventListener(DataHelper.INIT_COMPLETE, ich);
				_navigator.showScreen(MAIN_LIST);
			});
			DataHelper.getInstance().initModel(null, null, Model.getInstance(), true);
		}
		
		private function autologin(successCall:Function, failCall:Function):void {
			var lh:LoginHelper = LoginHelper.getInstance();
			
			if (!lh.isLoginSO()) {
				failCall.call();
				return;
			}
			
			var loginSO:Object = lh.getLoginSO();
			lh.login(loginSO.user, loginSO.pass, loginSO.facebookId, successCall, failCall)
		}
	}
}