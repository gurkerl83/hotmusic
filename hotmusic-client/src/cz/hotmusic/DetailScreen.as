package cz.hotmusic
{
	import cz.hotmusic.helper.TextHelper;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.model.Song;
	import cz.hotmusic.renderer.MainListRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	
	import org.osmf.elements.ImageElement;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	[Event(name="complete",type="starling.events.Event")]
	
	public class DetailScreen extends Screen
	{
		public function DetailScreen()
		{
			super();
		}
		
		private var _header:Header;
		private var _backButton:starling.display.Button;
		private var _scrollContainer:ScrollContainer;
		private var beginX:int;
		private var beginY:int;
		
		private var _songLabel:Label;
		private var _songValue:Label;
		private var _artistLabel:Label;
		private var _artistValue:Label;
		private var _albumLabel:Label;
		private var _albumValue:Label;
		private var _genreLabel:Label;
		private var _genreValue:Label;
		private var _statusLabel:Label;
		private var _statusImage1:Image;
		private var _statusImage2:Image;
		private var _statusImage3:Image;
		private var _rateLabel:Label;
		private var _rateUpValue:Label;
		private var _rateUpButton:starling.display.Button;
		private var _rateDownValue:Label;
		private var _rateDownButton:starling.display.Button;
		private var _shareLabel:Label;
		private var _shareTwitterButton:starling.display.Button;
		private var _shareFacebookButton:starling.display.Button;
		private var _shareGooglePlusButton:starling.display.Button;
		private var _shareEmailButton:starling.display.Button;
		private var _shareSmsButton:starling.display.Button;

		private var _itunesIcon:Image;
		private var _itunesLabel:Label;
		private var _itunesRight:Image;
		private var _googleMusicIcon:Image;
		private var _googleMusicLabel:Label;
		private var _googleMusicRight:Image;
		private var _amazonIcon:Image;
		private var _amazonLabel:Label;
		private var _amazonRight:Image;
		private var _beatportIcon:Image;
		private var _beatportLabel:Label;
		private var _beatportRight:Image;
		private var _soundcloudIcon:Image;
		private var _soundcloudLabel:Label;
		private var _soundcloudRight:Image;
		private var _youtubeIcon:Image;
		private var _youtubeLabel:Label;
		private var _youtubeRight:Image;
		
		private var _line1:Quad;
		private var _line2:Quad;
		private var _line3:Quad;
		private var _line4:Quad;
		private var _line5:Quad;
		private var _line6:Quad;
		private var _line7:Quad;
		private var _line8:Quad;
		private var _line9:Quad;
		private var _line10:Quad;
		private var _line11:Quad;
		private var _line12:Quad;
		private var _line13:Quad;
		private var _backgroundQuad:Quad;
//		public var songData:Song;
		
		private var _space:int = 150;
		private var _leftPadding:int = 15;
		private var _linePadding:int = 10;
		private var _lineHeight:int = 2;
		
		
		override protected function initialize():void
		{
			_backgroundQuad = new Quad(1,1,0x1A171B);
			this.addChild(_backgroundQuad);
			
			_scrollContainer = new ScrollContainer();
			this.addChild(_scrollContainer);

			_backButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Back()));
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			
			this._header = new Header();
//			this._header.title = "song detail";
			this._header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
			this.addChild(this._header);
			
			_songLabel = new Label();
			_songLabel.text = "Song:";
			_songValue = new Label();
			_songValue.text = Model.getInstance().selectedSong.name;
//			_songValue.textRendererProperties.textFormat = new TextFormat((new FontAssets.MyriadProBold()).fontName, 40, 0xF19300);
			_songValue.textRendererFactory = TextHelper.getInstance().detailSongValue;
			_scrollContainer.addChild(_songLabel);
			_scrollContainer.addChild(_songValue);
			
			_line1 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line1);
			
			_artistLabel = new Label();
			_artistLabel.text = "Artist:";
			_artistValue = new Label();
			_artistValue.text = Model.getInstance().selectedSong.artist.value;
			_artistValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_scrollContainer.addChild(_artistLabel);
			_scrollContainer.addChild(_artistValue);
			
			_line2 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line2);

			_albumLabel = new Label();
			_albumLabel.text = "Album:";
			_albumValue = new Label();
			_albumValue.text = Model.getInstance().selectedSong.album.value;
			_albumValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_scrollContainer.addChild(_albumLabel);
			_scrollContainer.addChild(_albumValue);
			
			_line3 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line3);

			_genreLabel = new Label();
			_genreLabel.text = "Genre:";
			_genreValue = new Label();
			_genreValue.text = Model.getInstance().selectedSong.genre.value;
			_genreValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_scrollContainer.addChild(_genreLabel);
			_scrollContainer.addChild(_genreValue);
			
			_line4 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line4);

			_statusLabel = new Label();
			_statusLabel.text = "Status:";
			
			var hsbm:Bitmap = new FontAssets.HotStatus();
			_statusImage1 = new Image(Texture.fromBitmap(hsbm));
			_statusImage2 = new Image(Texture.fromBitmap(hsbm));
			_statusImage3 = new Image(Texture.fromBitmap(hsbm));
			
			_scrollContainer.addChild(_statusLabel);
			_scrollContainer.addChild(_statusImage1);
			_scrollContainer.addChild(_statusImage2);
			_scrollContainer.addChild(_statusImage3);
			
			_line5 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line5);

			_rateLabel = new Label();
			_rateLabel.text = "Rate now:";
			_rateUpButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.RateUp()));
			_rateUpButton.addEventListener(TouchEvent.TOUCH, onRateUp);
			_rateUpValue = new Label();
			_rateUpValue.text = Model.getInstance().selectedSong.rateUp.toString();
			_rateUpValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_rateDownButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.RateDown()));
			_rateDownButton.addEventListener(TouchEvent.TOUCH, onRateDown);
			_rateDownValue = new Label();
			_rateDownValue.text = Model.getInstance().selectedSong.rateDown.toString();
			_rateDownValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_scrollContainer.addChild(_rateLabel);
			_scrollContainer.addChild(_rateUpButton);
			_scrollContainer.addChild(_rateUpValue);
			_scrollContainer.addChild(_rateDownButton);
			_scrollContainer.addChild(_rateDownValue);
			
			_line6 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line6);

			_shareLabel = new Label();
			_shareLabel.text = "Share:";
			_shareTwitterButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Twitter()));
			_shareFacebookButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Facebook()));
			_shareGooglePlusButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.GooglePlus()));
			_shareEmailButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Email()));
			_shareSmsButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Sms()));
			_scrollContainer.addChild(_shareLabel);
			_scrollContainer.addChild(_shareTwitterButton);
			_scrollContainer.addChild(_shareFacebookButton);
			_scrollContainer.addChild(_shareGooglePlusButton);
			_scrollContainer.addChild(_shareEmailButton);
			_scrollContainer.addChild(_shareSmsButton);
			
			// ---------------------------------------------------------
			
			_line7 = new Quad(1,1,0xF19300);
			_scrollContainer.addChild(_line7);
			
			var rightbm:Bitmap = new FontAssets.Right();
			
			var itunesbm:Bitmap = new FontAssets.ITunes();
			_itunesIcon = new Image(Texture.fromBitmap(itunesbm));
			_itunesLabel = new Label();
			_itunesLabel.text = "Buy on iTunes";
			_itunesLabel.textRendererFactory = TextHelper.getInstance().detailLinks;
			_itunesRight = new Image(Texture.fromBitmap(rightbm));
			_scrollContainer.addChild(_itunesIcon);
			_scrollContainer.addChild(_itunesLabel);
			_scrollContainer.addChild(_itunesRight);

			_line8 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line8);
			
			var googlemusicbm:Bitmap = new FontAssets.GoogleMusic();
			_googleMusicIcon = new Image(Texture.fromBitmap(googlemusicbm));
			_googleMusicLabel = new Label();
			_googleMusicLabel.text = "Buy on Google Play Music";
			_googleMusicLabel.textRendererFactory = TextHelper.getInstance().detailLinks;
			_googleMusicRight = new Image(Texture.fromBitmap(rightbm));
			_scrollContainer.addChild(_googleMusicIcon);
			_scrollContainer.addChild(_googleMusicLabel);
			_scrollContainer.addChild(_googleMusicRight);
			
			_line9 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line9);
			
			var amazonbm:Bitmap = new FontAssets.Amazon();
			_amazonIcon = new Image(Texture.fromBitmap(amazonbm));
			_amazonLabel = new Label();
			_amazonLabel.text = "Buy on Amazon Music";
			_amazonLabel.textRendererFactory = TextHelper.getInstance().detailLinks;
			_amazonRight = new Image(Texture.fromBitmap(rightbm));
			_scrollContainer.addChild(_amazonIcon);
			_scrollContainer.addChild(_amazonLabel);
			_scrollContainer.addChild(_amazonRight);
			
			_line10 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line10);
			
			var beatportbm:Bitmap = new FontAssets.Beatport();
			_beatportIcon = new Image(Texture.fromBitmap(beatportbm));
			_beatportLabel = new Label();
			_beatportLabel.text = "Buy on Beatport";
			_beatportLabel.textRendererFactory = TextHelper.getInstance().detailLinks;
			_beatportRight = new Image(Texture.fromBitmap(rightbm));
			_scrollContainer.addChild(_beatportIcon);
			_scrollContainer.addChild(_beatportLabel);
			_scrollContainer.addChild(_beatportRight);
			
			_line11 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line11);
			
			var soundcloudbm:Bitmap = new FontAssets.SoundCloud();
			_soundcloudIcon = new Image(Texture.fromBitmap(soundcloudbm));
			_soundcloudLabel = new Label();
			_soundcloudLabel.text = "Listen on Soundcloud";
			_soundcloudLabel.textRendererFactory = TextHelper.getInstance().detailLinks;
			_soundcloudRight = new Image(Texture.fromBitmap(rightbm));
			_scrollContainer.addChild(_soundcloudIcon);
			_scrollContainer.addChild(_soundcloudLabel);
			_scrollContainer.addChild(_soundcloudRight);
			
			_line12 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line12);
			
			var youtubebm:Bitmap = new FontAssets.YouTube();
			_youtubeIcon = new Image(Texture.fromBitmap(youtubebm));
			_youtubeLabel = new Label();
			_youtubeLabel.text = "Watch on YouTube";
			_youtubeLabel.textRendererFactory = TextHelper.getInstance().detailLinks;
			_youtubeRight = new Image(Texture.fromBitmap(rightbm));
			_scrollContainer.addChild(_youtubeIcon);
			_scrollContainer.addChild(_youtubeLabel);
			_scrollContainer.addChild(_youtubeRight);
			
			_line13 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line13);
			
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			_backgroundQuad.width = actualWidth;
			_backgroundQuad.height = actualHeight;
			
			_scrollContainer.width = actualWidth;
			_scrollContainer.height = actualHeight - _header.height;
			_scrollContainer.y = _header.height;
			_scrollContainer.validate();
			
			_songValue.x = _space;
			_songValue.y = 0;
			_songValue.width = actualWidth - _space - _leftPadding;
			_songValue.textRendererProperties.wordWrap = true;
			_songValue.validate();
			
			_songLabel.x = _leftPadding;
			_songLabel.y = 20;
			_songLabel.validate();
			
			_line1.x = _leftPadding;
			_line1.y = _songValue.y + _songValue.height + _linePadding;
			_line1.height = _lineHeight;
			_line1.width = actualWidth - 2*_leftPadding;
			
			_artistValue.x = _space;
			_artistValue.y = _line1.y + _lineHeight + _linePadding;
			_artistValue.validate();
			
			_artistLabel.validate();
			_artistLabel.x = _leftPadding;
			_artistLabel.y =  _artistValue.height/2 - _artistLabel.height/2 + _artistValue.y;
			_artistLabel.validate();

			_line2.x = _leftPadding;
			_line2.y = _artistValue.y + _artistValue.height + _linePadding;
			_line2.height = _lineHeight;
			_line2.width = actualWidth - 2*_leftPadding;
			
			_albumValue.x = _space;
			_albumValue.y = _line2.y + _lineHeight + _linePadding;
			_albumValue.validate();
			
			_albumLabel.validate();
			_albumLabel.x = _leftPadding;
			_albumLabel.y =  _albumValue.height/2 - _albumLabel.height/2 + _albumValue.y;
			_albumLabel.validate();
			
			_line3.x = _leftPadding;
			_line3.y = _albumValue.y + _albumValue.height + _linePadding;
			_line3.height = _lineHeight;
			_line3.width = actualWidth - 2*_leftPadding;;
			
			_genreValue.x = _space;
			_genreValue.y = _line3.y + _lineHeight + _linePadding;
			_genreValue.validate();
			
			_genreLabel.validate();
			_genreLabel.x = _leftPadding;
			_genreLabel.y = _genreValue.height/2 - _genreLabel.height/2 + _genreValue.y;
			_genreLabel.validate();
			
			_line4.x = _leftPadding;
			_line4.y = _genreValue.y + _genreValue.height + _linePadding;
			_line4.height = _lineHeight;
			_line4.width = actualWidth - 2*_leftPadding;;
			
			_statusImage1.x = _space;
			_statusImage1.y = _line4.y + _lineHeight + _linePadding;
			_statusImage2.x = _space + _statusImage1.width;
			_statusImage2.y = _line4.y + _lineHeight + _linePadding;
			_statusImage3.x = _space + _statusImage1.width + _statusImage2.width;
			_statusImage3.y = _line4.y + _lineHeight + _linePadding;
			
			_statusLabel.validate();
			_statusLabel.x = _leftPadding;
			_statusLabel.y = _statusImage1.height/2 - _statusLabel.height/2 + _statusImage1.y;
			_statusLabel.validate();
			
			_line5.x = _leftPadding;
			_line5.y = _statusImage1.y + _statusImage1.height + _linePadding*2;
			_line5.height = _lineHeight;
			_line5.width = actualWidth - 2*_leftPadding;;
			
			_rateUpButton.x = _space;
			_rateUpButton.y = _line5.y + _lineHeight + _linePadding*4;
			_rateUpValue.validate();
			_rateUpValue.x = _rateUpButton.x + _rateUpButton.width + 40;
			_rateUpValue.y = _rateUpButton.y + _rateUpButton.height/2 - _rateUpValue.height/2;
			
			_rateDownButton.x = _rateUpValue.x + _rateUpValue.width + 140;
			_rateDownButton.y = _line5.y + _lineHeight + _linePadding*4;
			_rateDownValue.validate();
			_rateDownValue.x = _rateDownButton.x + _rateDownButton.width + 40;
			_rateDownValue.y = _rateDownButton.y + _rateDownButton.height/2 - _rateDownValue.height/2;
			
			
			_rateLabel.validate();
			_rateLabel.x = _leftPadding;
			_rateLabel.y = _rateUpButton.height/2 - _rateLabel.height/2 + _rateUpButton.y;
			_rateLabel.validate();
			
			_line6.x = _leftPadding;
			_line6.y = _rateUpButton.y + _rateUpButton.height + _linePadding*4;
			_line6.height = _lineHeight;
			_line6.width = actualWidth - 2*_leftPadding;;
			
			_shareTwitterButton.x = _space;
			_shareTwitterButton.y = _line6.y + _lineHeight + _linePadding*4;
			_shareFacebookButton.x = _shareTwitterButton.x + _shareTwitterButton.width + 40;
			_shareFacebookButton.y = _line6.y + _lineHeight + _linePadding*4;
			_shareGooglePlusButton.x = _shareFacebookButton.x + _shareFacebookButton.width + 40;
			_shareGooglePlusButton.y = _line6.y + _lineHeight + _linePadding*4;
			_shareEmailButton.x = _shareGooglePlusButton.x + _shareGooglePlusButton.width + 40;
			_shareEmailButton.y = _line6.y + _lineHeight + _linePadding*4;
			_shareSmsButton.x = _shareEmailButton.x + _shareEmailButton.width + 40;
			_shareSmsButton.y = _line6.y + _lineHeight + _linePadding*4;
			
			_shareLabel.validate();
			 _shareLabel.x = _leftPadding;
			 _shareLabel.y =  _shareTwitterButton.height/2 - _shareLabel.height/2 + _shareTwitterButton.y;
			_shareLabel.validate();
			
			
			//-------------------------------------------------

			_line7.y = _shareTwitterButton.y + _shareTwitterButton.height + _linePadding*4;
			_line7.height = _lineHeight*2;
			_line7.width = actualWidth;
			
			_itunesIcon.x = _space/2 - _itunesIcon.width/2;
			_itunesIcon.y = _line7.y + _lineHeight + _linePadding*2;
			_itunesLabel.x = _space;
			_itunesLabel.y = _line7.y + _lineHeight + _linePadding*2;
			_itunesRight.x = actualWidth - _itunesRight.width - _leftPadding;
			_itunesRight.y = _line7.y + _lineHeight + _linePadding*2;

			_line8.y = _itunesIcon.y + _itunesIcon.height + _linePadding*2;
			_line8.height = _lineHeight;
			_line8.width = actualWidth;
			
			_googleMusicIcon.x = _space/2 - _googleMusicIcon.width/2;
			_googleMusicIcon.y = _line8.y + _lineHeight + _linePadding*2;
			_googleMusicLabel.x = _space;
			_googleMusicLabel.y = _line8.y + _lineHeight + _linePadding*2;
			_googleMusicRight.x = actualWidth - _googleMusicRight.width - _leftPadding;
			_googleMusicRight.y = _line8.y + _lineHeight + _linePadding*2;

			_line9.y = _googleMusicIcon.y + _googleMusicIcon.height + _linePadding*2;
			_line9.height = _lineHeight;
			_line9.width = actualWidth;
			
			_amazonIcon.x = _space/2 - _amazonIcon.width/2;
			_amazonIcon.y = _line9.y + _lineHeight + _linePadding*2;
			_amazonLabel.x = _space;
			_amazonLabel.y = _line9.y + _lineHeight + _linePadding*2;
			_amazonRight.x = actualWidth - _amazonRight.width - _leftPadding;
			_amazonRight.y = _line9.y + _lineHeight + _linePadding*2;

			_line10.y = _amazonIcon.y + _amazonIcon.height + _linePadding*2;
			_line10.height = _lineHeight;
			_line10.width = actualWidth;
			
			_beatportIcon.x = _space/2 - _beatportIcon.width/2;
			_beatportIcon.y = _line10.y + _lineHeight + _linePadding*2;
			_beatportLabel.x = _space;
			_beatportLabel.y = _line10.y + _lineHeight + _linePadding*2;
			_beatportRight.x = actualWidth - _beatportRight.width - _leftPadding;
			_beatportRight.y = _line10.y + _lineHeight + _linePadding*2;

			_line11.y = _beatportIcon.y + _beatportIcon.height + _linePadding*2;
			_line11.height = _lineHeight;
			_line11.width = actualWidth;
			
			_soundcloudIcon.x = _space/2 - _soundcloudIcon.width/2;
			_soundcloudIcon.y = _line11.y + _lineHeight + _linePadding*2;
			_soundcloudLabel.x = _space;
			_soundcloudLabel.y = _line11.y + _lineHeight + _linePadding*2;
			_soundcloudRight.x = actualWidth - _soundcloudRight.width - _leftPadding;
			_soundcloudRight.y = _line11.y + _lineHeight + _linePadding*2;

			_line12.y = _soundcloudIcon.y + _soundcloudIcon.height + _linePadding*2;
			_line12.height = _lineHeight;
			_line12.width = actualWidth;
			
			_youtubeIcon.x = _space/2 - _youtubeIcon.width/2;
			_youtubeIcon.y = _line12.y + _lineHeight + _linePadding*2;
			_youtubeLabel.x = _space;
			_youtubeLabel.y = _line12.y + _lineHeight + _linePadding*2;
			_youtubeRight.x = actualWidth - _youtubeRight.width - _leftPadding;
			_youtubeRight.y = _line12.y + _lineHeight + _linePadding*2;
			
			_line13.y = _youtubeIcon.y + _youtubeIcon.height + _linePadding*2;
			_line13.height = _lineHeight;
			_line13.width = actualWidth;
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function list_changeHandler(event:Event):void
		{
			//			const eventType:String = this._list.selectedItem.event as String;
			//			this.dispatchEventWith(eventType);
		}
		
		private function backButton_triggeredHandler(event:Event):void 
		{
			dispatchEventWith(Event.COMPLETE);
		}
		
		private function onRateUp(event:TouchEvent):void
		{
			var t:Touch = event.touches.pop(); 

			
			if (t.phase == TouchPhase.BEGAN)
			{
				beginX = t.globalX; 
				beginY = t.globalY;
			}
			if (t.phase != TouchPhase.ENDED)
				return;
			
			if (t.globalX != beginX || t.globalY != beginY )
				return;
			
			trace("onRateUp()");
			Model.getInstance().selectedSong.rateUp++;
			_rateUpValue.text = Model.getInstance().selectedSong.rateUp.toString();
		}
		private function onRateDown(event:TouchEvent):void
		{
			if (event.touches.pop().phase != TouchPhase.ENDED)
				return;
			trace("onRateDown()");
			trace(event.touches.pop().phase);// == TouchPhase.BEGAN
			Model.getInstance().selectedSong.rateDown++;
			_rateDownValue.text = Model.getInstance().selectedSong.rateDown.toString();
			
		}
	}
}