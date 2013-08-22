package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.sticksports.nativeExtensions.social.Social;
	import com.sticksports.nativeExtensions.social.SocialService;
	
	import cz.hotmusic.helper.TextHelper;
	import cz.hotmusic.lib.event.ServiceEvent;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.Vote;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.MainListRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
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
//		private var _shareGooglePlusButton:starling.display.Button;
		private var _shareEmailButton:starling.display.Button;
//		private var _shareSmsButton:starling.display.Button;

		private var _line1:Quad;
		private var _line2:Quad;
		private var _line3:Quad;
		private var _line4:Quad;
		private var _line5:Quad;
		private var _line6:Quad;
		private var _line7:Quad;
		
		private var _list:List;
		
		private var _space:int = 150;
		private var _leftPadding:int = 15;
		private var _linePadding:int = 10;
		private var _lineHeight:int = 2;
		
		private var song:Song;
		
		
		override protected function initialize():void
		{
//			_backgroundQuad = new Quad(1,1,0x1A171B);
//			this.addChild(_backgroundQuad);
			
			song = Model.getInstance().selectedSong;
			
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
			_songValue.text = song.name;
//			_songValue.textRendererProperties.textFormat = new TextFormat((new FontAssets.MyriadProBold()).fontName, 40, 0xF19300);
			_songValue.textRendererFactory = TextHelper.getInstance().detailSongValue;
			_scrollContainer.addChild(_songLabel);
			_scrollContainer.addChild(_songValue);
			
			_line1 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line1);
			
			_artistLabel = new Label();
			_artistLabel.text = "Artist:";
			_artistValue = new Label();
			_artistValue.text = song.artist.name;
			_artistValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_scrollContainer.addChild(_artistLabel);
			_scrollContainer.addChild(_artistValue);
			
			_line2 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line2);

			_albumLabel = new Label();
			_albumLabel.text = "Album:";
			_albumValue = new Label();
			_albumValue.text = song.album == null ? "no album" : song.album.name;
			_albumValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_scrollContainer.addChild(_albumLabel);
			_scrollContainer.addChild(_albumValue);
			
			_line3 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line3);

			_genreLabel = new Label();
			_genreLabel.text = "Genre:";
			_genreValue = new Label();
			_genreValue.text = song.genre.name;
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
			_statusImage1.visible = (song.hotstatus >= 1) ? true:false;
			_statusImage2.visible = (song.hotstatus >= 2) ? true:false;
			_statusImage3.visible = (song.hotstatus >= 3) ? true:false;
			
			_scrollContainer.addChild(_statusLabel);
			_scrollContainer.addChild(_statusImage1);
			_scrollContainer.addChild(_statusImage2);
			_scrollContainer.addChild(_statusImage3);
			
			_line5 = new Quad(1,1,0x333235);
			_scrollContainer.addChild(_line5);

			_rateLabel = new Label();
			_rateLabel.text = "Rate now:";
			_rateUpButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.RateUp()));
			if (song.canVote) {
				_rateUpButton.addEventListener(TouchEvent.TOUCH, onRateUp);
			} else {
				_rateUpButton.enabled = false;
			}
			_rateUpValue = new Label();
			_rateUpValue.text = song.rateUp.toString();
			_rateUpValue.textRendererFactory = TextHelper.getInstance().detailOtherValue;
			_rateDownButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.RateDown()));
			if (song.canVote) {
				_rateDownButton.addEventListener(TouchEvent.TOUCH, onRateDown);
			} else {
				_rateDownButton.enabled = false;
			}
			_rateDownValue = new Label();
			_rateDownValue.text = song.rateDown.toString();
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
			_shareTwitterButton.addEventListener(Event.TRIGGERED, function onTwitter(event:Event):void {
				var msgt:String = "#hotmusic testing message: I recommend song "+song.name+" from "+ song.artist.name;
				if (Social.isSupported && Social.isAvailableForService(SocialService.twitter)) {
					var st:Social = new Social(SocialService.twitter);
					st.setMessage(msgt);
					st.launch();
				} 
				else
					navigateToURL(new URLRequest('http://twitter.com/home?status='+encodeURIComponent(msgt)),'_blank');
			});
			_shareFacebookButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Facebook()));
			_shareFacebookButton.addEventListener(Event.TRIGGERED, function onFacebook(event:Event):void {
				var msgf:String = "#hotmusic testing message: I recommend song "+song.name+" from "+ song.artist.name;
				if (Social.isSupported && Social.isAvailableForService(SocialService.facebook)) {
					var sf:Social = new Social(SocialService.facebook);
					sf.setMessage(msgf);
					sf.launch();
				} 
				else
					navigateToURL(new URLRequest('http://facebook.com/?'), '_blank');
			});
//			_shareGooglePlusButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.GooglePlus()));
//			_shareGooglePlusButton.addEventListener(Event.TRIGGERED, function onGooglePlus(event:Event):void {
//				navigateToURL(new URLRequest('https://plus.google.com/'), '_blank');
//			});
			_shareEmailButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Email()));
			_shareEmailButton.addEventListener(Event.TRIGGERED, function onEmail(event:Event):void {
				var subjmail:String = "hotmusic testing message";
				var msgmail:String = "I recommend song "+song.name+" from "+ song.artist.name;
				navigateToURL(new URLRequest('mailto:aaa@bbb.cc?subject='+encodeURIComponent(subjmail)+'&body='+encodeURIComponent(msgmail)), '_blank');
			});
//			_shareSmsButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Sms()));
			_scrollContainer.addChild(_shareLabel);
			_scrollContainer.addChild(_shareTwitterButton);
			_scrollContainer.addChild(_shareFacebookButton);
//			_scrollContainer.addChild(_shareGooglePlusButton);
			_scrollContainer.addChild(_shareEmailButton);
//			_scrollContainer.addChild(_shareSmsButton);
			
			// ---------------------------------------------------------
			
			_line7 = new Quad(1,1,0xF19300);
			_scrollContainer.addChild(_line7);
			
			var rightbm:Bitmap = new FontAssets.Right();
			
			this._list = new List();
			this._list.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
//			this._list.itemRendererType = ListRenderer;
			this._list.dataProvider = new ListCollection(getURLDataProvider());
			this._list.itemRendererProperties.labelField = "label";
			this._list.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			
			_scrollContainer.addChild(_list);
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		override protected function draw():void
		{
			this._header.paddingTop = this._header.paddingBottom = this._header.paddingLeft = this._header.paddingRight = 0;
			this._header.width = this.actualWidth;
			this._header.validate();
			
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
			
			var iconBlackborder:int = 14;
			_rateUpButton.x = _space - iconBlackborder;
			_rateUpButton.y = _line5.y + _lineHeight + _linePadding*3;
			_rateUpValue.validate();
			_rateUpValue.x = _rateUpButton.x + _rateUpButton.width + 40;
			_rateUpValue.y = _rateUpButton.y + _rateUpButton.height/2 - _rateUpValue.height/2;
			
			_rateDownButton.x = _rateUpValue.x + _rateUpValue.width + 100;
			_rateDownButton.y = _line5.y + _lineHeight + _linePadding*3;
			_rateDownValue.validate();
			_rateDownValue.x = _rateDownButton.x + _rateDownButton.width + 40;
			_rateDownValue.y = _rateDownButton.y + _rateDownButton.height/2 - _rateDownValue.height/2;
			
			
			_rateLabel.validate();
			_rateLabel.x = _leftPadding;
			_rateLabel.y = _rateUpButton.height/2 - _rateLabel.height/2 + _rateUpButton.y;
			_rateLabel.validate();
			
			_line6.x = _leftPadding;
			_line6.y = _rateUpButton.y + _rateUpButton.height + _linePadding*3;
			_line6.height = _lineHeight;
			_line6.width = actualWidth - 2*_leftPadding;;
			
			var iconspace:int = 40;
			_shareTwitterButton.x = _space - iconBlackborder;
			_shareTwitterButton.y = _line6.y + _lineHeight + _linePadding*3;
			_shareFacebookButton.x = _shareTwitterButton.x + _shareTwitterButton.width + iconspace;
			_shareFacebookButton.y = _line6.y + _lineHeight + _linePadding*3;
//			_shareGooglePlusButton.x = _shareFacebookButton.x + _shareFacebookButton.width + iconspace;
//			_shareGooglePlusButton.y = _line6.y + _lineHeight + _linePadding*3;
			_shareEmailButton.x = _shareFacebookButton.x + _shareFacebookButton.width + iconspace;
			_shareEmailButton.y = _line6.y + _lineHeight + _linePadding*3;
//			_shareSmsButton.x = _shareEmailButton.x + _shareEmailButton.width + iconspace;
//			_shareSmsButton.y = _line6.y + _lineHeight + _linePadding*3;
			
			_shareLabel.validate();
			 _shareLabel.x = _leftPadding;
			 _shareLabel.y =  _shareTwitterButton.height/2 - _shareLabel.height/2 + _shareTwitterButton.y;
			_shareLabel.validate();
			
			
			//-------------------------------------------------

			_line7.y = _shareTwitterButton.y + _shareTwitterButton.height + _linePadding*3;
			_line7.height = _lineHeight*2;
			_line7.width = actualWidth;
			
			_list.y = _line7.y + 2;
			_list.width = actualWidth;
			
		}
		
		private function list_changeHandler(event:Event):void
		{
			_list.removeEventListener(Event.CHANGE, list_changeHandler);
			navigateToURL(new URLRequest(_list.selectedItem.url),"_blank");
			_list.selectedIndex = -1;
			_list.addEventListener(Event.CHANGE, list_changeHandler);
		}
		
		private function backButton_triggeredHandler(event:Event):void 
		{
			dispatchEventWith(Event.COMPLETE);
		}
		
		private var touchTolerance:int = 20;
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
			
			if (Math.abs(t.globalX - beginX) > touchTolerance || Math.abs(t.globalY - beginY) > touchTolerance )
				return;
			
			trace("onRateUp()");
			if (_rateUpButton.enabled) {
				song.rateUp++;
				song.canVote = false;
				_rateUpValue.text = song.rateUp.toString();
				_rateDownButton.enabled = false;
				_rateUpButton.enabled = false;
				
				_rateUpButton.removeEventListener(Event.TRIGGERED, onRateUp);
				_rateDownButton.removeEventListener(Event.TRIGGERED, onRateDown);
				
				callRateService(1);
			}
		}
		private function onRateDown(event:TouchEvent):void
		{
			var t:Touch = event.touches.pop(); 
			
			if (t.phase == TouchPhase.BEGAN)
			{
				beginX = t.globalX; 
				beginY = t.globalY;
			}
			if (t.phase != TouchPhase.ENDED)
				return;
			
			if (Math.abs(t.globalX - beginX) > touchTolerance || Math.abs(t.globalY - beginY) > touchTolerance )
				return;
			
			trace("onRateDown()");
			if (_rateDownButton.enabled) {
				song.rateDown++;
				song.canVote = false;
				_rateDownValue.text = song.rateDown.toString();
				_rateDownButton.enabled = false;
				_rateUpButton.enabled = false;
				
				_rateUpButton.removeEventListener(Event.TRIGGERED, onRateUp);
				_rateDownButton.removeEventListener(Event.TRIGGERED, onRateDown);
				
				callRateService(-1);
			}
			
		}
		
		private function getURLDataProvider():Array
		{
			var dp:Array = [];
			if (song.itunes && song.itunes.length > 0)
				dp.push({icon: new Image(Texture.fromBitmap(new FontAssets.ITunes())), label: "Buy on iTunes", url: song.itunes});
			if (song.googlePlay && song.googlePlay.length > 0)
				dp.push({icon: new Image(Texture.fromBitmap(new FontAssets.GoogleMusic())), label: "Buy on Google Play Music", url: song.googlePlay});
			if (song.amazon && song.amazon.length > 0)
				dp.push({icon: new Image(Texture.fromBitmap(new FontAssets.Amazon())), label: "Buy on Amazon Music", url: song.amazon});
			if (song.beatport && song.beatport.length > 0)
				dp.push({icon: new Image(Texture.fromBitmap(new FontAssets.Beatport())), label: "Buy on Beatport", url: song.beatport});
			if (song.soundcloud && song.soundcloud.length > 0)
				dp.push({icon: new Image(Texture.fromBitmap(new FontAssets.SoundCloud())), label: "Listen on Soundcloud", url: song.soundcloud});
			if (song.youtube && song.youtube.length > 0)
				dp.push({icon: new Image(Texture.fromBitmap(new FontAssets.YouTube())), label: "Watch on YouTube", url: song.youtube});
			
			return dp;
		}
		
		private function callRateService(rate:int):void
		{
			var vote:Vote = new Vote();
			vote.rate = rate;
			vote.user = Model.getInstance().user;
			vote.song = song;
			
			var se:ServiceEvent = new SongServiceEvent(SongServiceEvent.VOTE, null, null);
			se.sid = Model.getInstance().user.sid;
			se.sedata = vote;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
	}
}