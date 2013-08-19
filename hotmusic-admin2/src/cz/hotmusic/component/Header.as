package cz.hotmusic.component
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import feathers.themes.Theme;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Header extends FeathersControl
	{
		public function Header()
		{
			super();
		}
		
		public function actionButtons(buttons:Array):void
		{
			if (this.buttons == buttons)
				return;
			
			if (this.buttons && this.buttons.length > 0)
			{
				for each (var button:feathers.controls.Button in this.buttons)
				{
					removeChild(button);
				}
			}
			
			this.buttons = buttons;
			
			if (buttons && buttons.length > 0)
			{
				for each (var button:feathers.controls.Button in buttons)
				{
					addChild(button);
				}
			}
			
			invalidate();
		}
		
		private var buttons:Array;
		
		private var bg:DisplayObject;
		private var logo:Image;
		private var userLbl:Label;
		private var rightsLbl:Label;
		private var logoutBtn:starling.display.Button;
//		private var updateLbl:Label;
//		private var updateValue:Label;
		
		override protected function initialize():void 
		{
			super.initialize();
			
			height = 100;
			
			bg = new Quad(1,1,0x000004);
			
			logo = new Image(Texture.fromBitmap(new FontAssets.LogoSmallBlack()));
			
			userLbl = new Label();
			userLbl.text = Model.getInstance().user.firstname + " " + Model.getInstance().user.surname;
			userLbl.name = Theme.SMALL_NORMAL_GRAY;
			
			rightsLbl = new Label();
			rightsLbl.text = Model.getInstance().user.adminRights ? "admin" : "user";
			rightsLbl.name = Theme.TINY_NORMAL_GRAY;
			
			logoutBtn = new starling.display.Button(Texture.fromBitmap(new FontAssets.Logout()));
			logoutBtn.addEventListener(Event.TRIGGERED, logout);
			
//			updateLbl = new Label();
//			updateLbl.text = "For the next update:";
//			updateLbl.name = Theme.SMALL_NORMAL_GRAY;
//			
//			updateValue = new Label();
//			updateValue.text = "47:55:14";
//			updateValue.name = Theme.LARGE_BOLD_GRAY;
			
			addChildAt(bg,0);
			addChild(logo);
			addChild(userLbl);
			addChild(rightsLbl);
			addChild(logoutBtn);
//			addChild(updateLbl);
//			addChild(updateValue);
			
			
		}
		
		private function logout(event:Event):void
		{
			ButtonHelper.inst().reset();
			dispatchEventWith("logout", true);
		}
		
		override protected function draw():void
		{
			super.draw();
			var gap:int = 6;
			var paddingLeft:int = 20;
			var baseline:int = 0;
			
			bg.width = actualWidth;
			bg.height = actualHeight;
			
			logo.x = paddingLeft;
			logo.y = actualHeight/2 - logo.height/2;
			
			userLbl.validate();
			userLbl.x = logo.x + logo.width + gap;
			userLbl.y = actualHeight/2 - userLbl.height/2 - baseline;
			
			rightsLbl.validate();
			rightsLbl.x = userLbl.x;
			rightsLbl.y = userLbl.y + userLbl.height;
			
			logoutBtn.x = rightsLbl.x + Math.max(rightsLbl.width, userLbl.width)  + gap;
			logoutBtn.y = actualHeight/2 - logoutBtn.height/2;

//			updateLbl.validate();
//			updateLbl.x = logoutBtn.x + logoutBtn.width + gap;
//			updateLbl.y = actualHeight/2 - updateLbl.height/2 - baseline;
//
//			updateValue.validate();
//			updateValue.x = updateLbl.x + updateLbl.width +gap ;
//			updateValue.y = actualHeight/2 - updateValue.height/2 - baseline;
			
			if (buttons && buttons.length > 0)
			{
				var btngap:int = paddingLeft;
				for each (var button:feathers.controls.Button in buttons)
				{
					button.validate();
					button.x = actualWidth - button.width - btngap;
					button.y = actualHeight/2 - button.height/2;
					btngap += button.width + 3*gap; 
				}
			}
		}
	}
}