package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import cz.hotmusic.helper.LoginHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.model.User;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.SharedObject;
	
	import mx.rpc.events.ResultEvent;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class CreateAccountScreen extends Screen
	{
		public function CreateAccountScreen()
		{
			super();
		}
		
		private var _header:Header;
		private var _backButton:starling.display.Button;
		private var _logo:Image;
		private var _firstnameTI:TextInput;
		private var _surnameTI:TextInput;
		private var _emailTI:TextInput;
		private var _passwordTI:TextInput;
		private var _password2TI:TextInput;
		private var _createAccountBtn:Button;
		
		override protected function initialize():void
		{
			
			_backButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Back()));
			_backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			
			this._header = new Header();
			_logo = Image.fromBitmap(new FontAssets.HotMusic());
			this._header.addChild(_logo);
			//			this._header.title = "song detail";
			this._header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
			this.addChild(this._header);
			
			_firstnameTI = new TextInput();
			_firstnameTI.prompt = "firstname";
			_firstnameTI.name = "textinputblack";
			
			_surnameTI = new TextInput();
			_surnameTI.prompt = "surname";
			_surnameTI.name = "textinputblack";
			
			_emailTI = new TextInput();
			_emailTI.prompt = "e-mail";
			_emailTI.name = "textinputblack";
			
			_passwordTI = new TextInput();
			_passwordTI.prompt = "password";
			_passwordTI.name = "textinputblack";
			_passwordTI.displayAsPassword = true;
			
			_password2TI = new TextInput();
			_password2TI.prompt = "re-password";
			_password2TI.name = "textinputblack";
			_password2TI.displayAsPassword = true;
			
			_createAccountBtn = new Button();
			_createAccountBtn.label = "Create new account";
			_createAccountBtn.addEventListener(starling.events.Event.TRIGGERED, function (event:starling.events.Event):void {
				if (_passwordTI.text == null || _passwordTI.text == "" || _passwordTI.text != _password2TI.text ||
					_firstnameTI.text == null || _firstnameTI.text == "" ||
					_surnameTI.text == null || _surnameTI.text == "" ||
					_emailTI.text == null || _emailTI.text == "" 
				)
					return; //TODO chybova hlaska
				
				LoginHelper.getInstance().createAccount(_emailTI.text, _passwordTI.text, _firstnameTI.text, _surnameTI.text, function(res:ResultEvent):void
				{
					LoginHelper.getInstance().login(_emailTI.text, _passwordTI.text, null, function(result:ResultEvent):void
					{
						Model.getInstance().user = User(result.result);
						
						DataHelper.getInstance().addEventListener(DataHelper.INIT_COMPLETE, function ich(e:flash.events.Event):void {
							removeEventListener(DataHelper.INIT_COMPLETE, ich);
							dispatchEventWith("login");
						});
						DataHelper.getInstance().initModel(null, null, Model.getInstance());
					})
				})
			});
			
			addChild(_logo);
			addChild(_firstnameTI);
			addChild(_surnameTI);
			addChild(_emailTI);
			addChild(_passwordTI);
			addChild(_password2TI);
			addChild(_createAccountBtn);
		}
		
		private function backButton_triggeredHandler(event:starling.events.Event):void 
		{
			dispatchEventWith("back");
		}
		
		override protected function draw():void
		{
			var gap:int = 28;
			var padding:int = 70;
			var btnHeight:int = 70;
			
			this._header.paddingTop = this._header.paddingBottom = this._header.paddingLeft = this._header.paddingRight = 0;
			this._header.width = this.actualWidth;
			this._header.validate();
			
			_logo.x = this._header.width/2 - _logo.width/2;
			_logo.y = this._header.height/2 - _logo.height/2;
			
			_firstnameTI.x = padding;
			_firstnameTI.y = _header.y + _header.height + padding;
			_firstnameTI.width = actualWidth - 2*padding;
			_firstnameTI.validate();

			_surnameTI.x = padding;
			_surnameTI.y = _firstnameTI.y + _firstnameTI.height + gap;
			_surnameTI.width = actualWidth - 2*padding;
			_surnameTI.validate();

			_emailTI.x = padding;
			_emailTI.y = _surnameTI.y + _surnameTI.height + gap;
			_emailTI.width = actualWidth - 2*padding;
			_emailTI.validate();

			_passwordTI.x = padding;
			_passwordTI.y = _emailTI.y + _emailTI.height + gap;
			_passwordTI.width = actualWidth - 2*padding;
			_passwordTI.validate();
			
			_password2TI.x = padding;
			_password2TI.y = _passwordTI.y + _passwordTI.height + gap;
			_password2TI.width = actualWidth - 2*padding;
			_password2TI.validate();
			
			_createAccountBtn.width = actualWidth - 2*padding;
			_createAccountBtn.y = _password2TI.y + _password2TI.height + gap;
			_createAccountBtn.x = padding;
			_createAccountBtn.height = btnHeight;
		}
		
		
	}
}