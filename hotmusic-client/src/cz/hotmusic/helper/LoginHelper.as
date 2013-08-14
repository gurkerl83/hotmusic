package cz.hotmusic.helper
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.model.User;
	import cz.zc.mylib.event.GenericEvent;
	
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.SharedObject;
	
	import mx.rpc.events.ResultEvent;
	
	import starling.core.Starling;

	[Event(name="loginSuccess", type="cz.zc.mylib.event.GenericEvent")]
	[Event(name="loginError", type="cz.zc.mylib.event.GenericEvent")]
	[Event(name="facebookSuccess", type="cz.zc.mylib.event.GenericEvent")]
	[Event(name="createSuccess", type="cz.zc.mylib.event.GenericEvent")]
	public class LoginHelper extends EventDispatcher
	{
		private static const SO_NAME			:String = "login";
		private static const TEST_USER			:String = "aaa";
		private static const TEST_PASS			:String = "aaa";
		private static const TEST_FBID			:String = "1397109711";
		private static const HOTMUSIC_FB_ID		:String = "334957266639220";
		
		private var successFBCall:Function;
		private var failFBCall:Function;
		
		private var facebookWidth:Number; 
		private var facebookHeight:Number; 
		
		public function LoginHelper()
		{
		}
		
		private static var _instance:LoginHelper;
		public static function getInstance():LoginHelper
		{
			if (_instance == null)
				_instance = new LoginHelper();
			_instance.resetLoginSO();
			return _instance;
		}
		
		private var user:String;
		private var pass:String;
		private var isFB:Boolean;
		private var successCall:Function;
		private var failCall:Function;
		
		public function login(user:String, pass:String, isFB:Boolean=false, successCall:Function=null, failCall:Function=null):void
		{
			if (user == null || user == "")
				if (failCall != null) failCall.call();
			if (!isFB && (pass == null || pass == ""))
				if (failCall != null) failCall.call();
			
			this.user = user;
			this.pass = pass;
			this.isFB = isFB;
			this.successCall = successCall;
			this.failCall = failCall;

//			var result:Boolean;
			
			// server call
			var pse:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LOGIN, loginProfileServiceResult, loginProfileServiceFault);
			pse.user = new User();
			pse.user.email = user;
			pse.user.password = pass;
			CairngormEventDispatcher.getInstance().dispatchEvent(pse);
			
//			if (user == TEST_USER && pass == TEST_PASS && !isFB)
//				result = true;
//			
//			if (user == TEST_FBID && isFB)
//				result = true;
		}
		
		private function loginProfileServiceResult(result:ResultEvent):void
		{
			// login incorrect
			if (result.result == null)
			{
				if (failCall != null) failCall.call();
				return;
			}
			
			// login ok, save to SO
			if (!isLoginSO())
				setLoginSO(user, pass, isFB);
			
			// call callback
			if (successCall != null) successCall.call(this, result);
		}
		
		private function loginProfileServiceFault(info:Object):void
		{
			if (failCall != null) failCall.call();
		}
		
		public function facebook(facebookWidth:Number, facebookHeight:Number, successCall:Function=null, failCall:Function=null):void 
		{
			this.facebookWidth = facebookWidth;
			this.facebookHeight = facebookHeight;
			this.successFBCall = successCall;
			this.failFBCall = failCall;
			FacebookMobile.init(HOTMUSIC_FB_ID, onInitFB);
		}
		
		public function createAccount(user:String, pass:String, isFB:Boolean=false):void
		{
			if (user == null || user == "")
				return;
			if (!isFB && (pass == null || pass == ""))
				return;
			
			// TODO server call
		}
		
		public function getLoginSO():Object
		{
			var so:SharedObject = SharedObject.getLocal(SO_NAME);
			var loginObj:Object = new Object();
			loginObj.user = so.data.user;
			loginObj.pass = so.data.pass;
			loginObj.isFB = so.data.isFB;
			return loginObj;
		}
		
		public function setLoginSO(user:String, pass:String, isFB:Boolean):void
		{
			var so:SharedObject = SharedObject.getLocal(SO_NAME);
			var loginObj:Object = new Object();
			so.data.user = user;
			so.data.pass = pass;
			so.data.isFB = isFB;
			so.flush();
		}
		
		public function isLoginSO():Boolean
		{	var so:SharedObject = SharedObject.getLocal(SO_NAME);
			if (so.data.user == null)
				return false;
			return true;
		}
		
		public function resetLoginSO():void
		{
			var so:SharedObject = SharedObject.getLocal(SO_NAME);
			so.clear();
		}
		
		//--------------------------------------------
		//
		// PRIVATE
		//
		//--------------------------------------------
		
		private var webView:StageWebView;
		private function onInitFB(sessionFB:FacebookSession, err:Object):void 
		{
			var stage:Stage = Starling.current.nativeStage;
			webView = new StageWebView();
			webView.viewPort = new Rectangle(0, 0, facebookWidth, facebookHeight);
			FacebookMobile.login(onLoginFB, stage, ["read_stream"], webView);
		}
		
		private function onLoginFB(sessionFB:FacebookSession, err:Object):void
		{
			if (sessionFB && sessionFB.uid) 
			{
				createAccount(sessionFB.uid, "", true);
//				setLoginSO(sessionFB.uid, "", true);
				login(sessionFB.uid, "", true, this.successFBCall, this.failFBCall);
				// else TODO nepodarilo se vytvorit ucet
			}
		}
	}
}