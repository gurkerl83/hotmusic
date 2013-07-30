package cz.hotmusic.components
{
	import cz.hotmusic.FontAssets;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	
	import flash.desktop.NativeApplication;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.utils.flash_proxy;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SendDialog extends FeathersControl
	{
		public function SendDialog()
		{
			super();
		}
		
		public static const ADD_ARTIST_STATE:String = "ADD_ARTIST_STATE";
		public static const FEEDBACK_STATE:String = "FEEDBACK_STATE";
		
		private var currentState:String;
		private var shifted:Boolean = false;
		
		private var line1:Quad;
		private var line2:Quad;
		private var line3:Quad;
		private var line4:Quad;
		
		private var bg:Quad;
		private var addArtistBtn:starling.display.Button;
		private var label:Label;
		private var text:Label;
		private var artistTI:TextInput;
		private var sendBtn:feathers.controls.Button;
		
		public function state(state:String):void {
			if (state == currentState)
				return;
			
			if (state == ADD_ARTIST_STATE) {
				label.text = "Do you miss any artist here?";
				text.text = "So write it here and we will follow him. Are you the artist? Visit our website for more info.";
				artistTI.prompt = "artist name";
				addArtistBtn.upState = Texture.fromBitmap(new FontAssets.AddArtist());
				addArtistBtn.downState = Texture.fromBitmap(new FontAssets.AddArtist());;
			} else {
				label.text = "We love your feedback!";
				text.text = "Tell us what you think about HotMusic so we can make it even better.";
				artistTI.prompt = "so write to us";
				addArtistBtn.upState = Texture.fromBitmap(new FontAssets.AddFeedback());
				addArtistBtn.downState = Texture.fromBitmap(new FontAssets.AddFeedback());
			}
			invalidate();
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			if (value)
				artistTI.setFocus();
		}
		
		override protected function initialize():void
		{
			bg = new Quad(1,1,0x000004);
			
			line1 = new Quad(1,1,0x444444);
			line2 = new Quad(1,1,0x444444);
			line3 = new Quad(1,1,0x444444);
			line4 = new Quad(1,1,0x444444);
			
			addArtistBtn = new starling.display.Button(Texture.fromBitmap(new FontAssets.AddArtist()));
			addArtistBtn.addEventListener(Event.TRIGGERED, function onClose(event:Event):void {
				shiftDown();
				enterHandler(null);
				dispatchEventWith(Event.CLOSE);
			});
			label = new Label();
			label.name = "header";
//			label.text = "Do you miss any artist here?";
			text = new Label();
//			text.text = "So write it here and we will follow him. Are you the artist? Visit our website for more info.";
			artistTI = new TextInput();
//			artistTI.addEventListener(FocusEvent.FOCUS_IN, function onTIFocus(event:Event):void {
//				shiftUp();
//			});
//			artistTI.addEventListener(FocusEvent.FOCUS_OUT, function onTIFocusOut(event:Event):void {
//				shiftDown();
//			});
//			artistTI.prompt = "artist name";
			sendBtn = new feathers.controls.Button();
			sendBtn.label = "Send";
			sendBtn.addEventListener(Event.TRIGGERED, function onClose(event:Event):void {
//				shiftDown();
				enterHandler(null);
				artistTI.text = null;
				dispatchEventWith(Event.CLOSE);
			});
			
			state(ADD_ARTIST_STATE);

			addChild(bg);
			addChild(line1);
			addChild(line2);
			addChild(line3);
			addChild(line4);
			
			addChild(addArtistBtn);
			addChild(label);
			addChild(text);
			addChild(artistTI);
			addChild(sendBtn);
		}
		
		override protected function draw():void
		{
			var gap:int = 16;
			line1.width = actualWidth;
			
			addArtistBtn.x = actualWidth/2 - addArtistBtn.width/2;
			addArtistBtn.y = line1.height;
			
			line2.width = actualWidth;
			line2.y = addArtistBtn.y + addArtistBtn.height;
			
			label.y = line2.y + line2.height + gap;
			label.x = gap;
			label.width = actualWidth - 2*gap;
			label.validate();
			
			text.y = label.y + label.height + gap;
			text.x = gap;
			text.width = actualWidth - 2*gap;
			text.textRendererProperties.wordWrap = true;
			text.validate();
			
			line3.width = actualWidth;
			line3.y = text.y + text.height + gap;
			
			sendBtn.validate();
			sendBtn.x = actualWidth - sendBtn.width - gap;
			
			artistTI.y = line3.y + line3.height + gap;
			artistTI.x = gap;
			artistTI.width = actualWidth - 3*gap - sendBtn.width;
			
			sendBtn.y = artistTI.y + artistTI.height/2 - sendBtn.height/2;
			
			line4.width = actualWidth;
			line4.y = artistTI.y + artistTI.height + gap;
			
			bg.width = actualWidth;
			bg.height = line4.y + line4.height;
			
			setSizeInternal(actualWidth, bg.height, true);
		}
		
		private function enterHandler (event:Event):void
		{
			var nativeStage:Stage = Starling.current.nativeStage;
			//			var focus:InteractiveObject = mystage.focus;
			//			_searchTI.prompt = "enterHandler " + (mystage.focus != null) ? "focus: "+mystage.focus : "focus is null";
			nativeStage.focus = null;
			//				Starling.current.nativeStage.focus = null;
		}
		
		private function shiftUp():void {
			if (shifted)
				return;

			var shiftHeight:int = Starling.current.nativeStage.softKeyboardRect.height;
			if (shiftHeight <= 0)
				shiftHeight = 400;
			y -= shiftHeight;
			shifted = true;
		}

		private function shiftDown():void {
			if (!shifted)
				return;
			
			var shiftHeight:int = Starling.current.nativeStage.softKeyboardRect.height;
			if (shiftHeight <= 0)
				shiftHeight = 400;
			y += shiftHeight;
			shifted = false;
		}
	}
}