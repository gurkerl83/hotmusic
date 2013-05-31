package cz.hotmusic
{
	import cz.hotmusic.model.Model;
	import cz.hotmusic.model.Song;
	import cz.hotmusic.renderer.MainListRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	[Event(name="complete",type="starling.events.Event")]
	
	public class DetailScreen extends Screen
	{
		public function DetailScreen()
		{
			super();
		}
		
		private var _header:Header;
		private var _backButton:Button;
		
		private var _songLabel:Label;
		private var _songValue:Label;
		private var _artistLabel:Label;
		private var _artistValue:Label;
		private var _albumLabel:Label;
		private var _albumValue:Label;
		private var _genreLabel:Label;
		private var _genreValue:Label;
		private var _statusLabel:Label;
		private var _statusValue:Label;
		private var _rateLabel:Label;
		private var _rateValue:Label;
		private var _shareLabel:Label;
		private var _shareValue:Label;
		private var _quad1:Quad;
		private var _backgroundQuad:Quad;
//		public var songData:Song;
		
		private var _space:int = 150;
		
		override protected function initialize():void
		{
			_backgroundQuad = new Quad(1,1,0x1A171B);
			this.addChild(_backgroundQuad);

			_backButton = new Button();
			_backButton.label = "back";
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			
			this._header = new Header();
			this._header.title = "song detail";
			this._header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
			this.addChild(this._header);
			
			
			_songLabel = new Label();
			_songLabel.text = "Song:";
			_songValue = new Label();
			_songValue.text = Model.getInstance().selectedSong.name;
			this.addChild(_songLabel);
			this.addChild(_songValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);
			
			_artistLabel = new Label();
			_artistLabel.text = "Artist:";
			_artistValue = new Label();
			_artistValue.text = Model.getInstance().selectedSong.artist.value;
			this.addChild(_artistLabel);
			this.addChild(_artistValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);

			_albumLabel = new Label();
			_albumLabel.text = "album:";
			_albumValue = new Label();
			_albumValue.text = Model.getInstance().selectedSong.album.value;
			this.addChild(_albumLabel);
			this.addChild(_albumValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);

			_genreLabel = new Label();
			_genreLabel.text = "genre:";
			_genreValue = new Label();
			_genreValue.text = Model.getInstance().selectedSong.genre.value;
			this.addChild(_genreLabel);
			this.addChild(_genreValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);

			_statusLabel = new Label();
			_statusLabel.text = "status:";
			_statusValue = new Label();
			_statusValue.text = Model.getInstance().selectedSong.hotstatus.toString();
			this.addChild(_statusLabel);
			this.addChild(_statusValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);

			_rateLabel = new Label();
			_rateLabel.text = "rate:";
			_rateValue = new Label();
			_rateValue.text = Model.getInstance().selectedSong.rateUp.toString();
			this.addChild(_rateLabel);
			this.addChild(_rateValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);

			_shareLabel = new Label();
			_shareLabel.text = "share:";
			_shareValue = new Label();
			_shareValue.text = "icons.....";
			this.addChild(_shareLabel);
			this.addChild(_shareValue);
			
			_quad1 = new Quad(1,1,0x333235);
			this.addChild(_quad1);
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			_backgroundQuad.width = actualWidth;
			_backgroundQuad.height = actualHeight;
			
			_songValue.x = _space;
			_songValue.y = _header.height;
			_songValue.validate();
			
			_songLabel.y = _header.height;
			_songLabel.validate();
			
			_quad1.y = _songValue.y + _songValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
			
			_artistValue.x = _space;
			_artistValue.y = _songValue.height + _songValue.y;
			_artistValue.validate();
			
			_artistLabel.y = _songValue.height + _songValue.y;
			_artistLabel.validate();
			
			_quad1.y = _artistValue.y + _artistValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
			
			_albumValue.x = _space;
			_albumValue.y = _artistValue.height + _artistValue.y;
			_albumValue.validate();
			
			_albumLabel.y = _artistValue.height + _artistValue.y;
			_albumLabel.validate();
			
			_quad1.y = _albumValue.y + _albumValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
			
			_genreValue.x = _space;
			_genreValue.y = _albumValue.height + _albumValue.y;
			_genreValue.validate();
			
			_genreLabel.y = _albumValue.height + _albumValue.y;
			_genreLabel.validate();
			
			_quad1.y = _genreValue.y + _genreValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
			
			_statusValue.x = _space;
			_statusValue.y = _genreValue.height + _genreValue.y;
			_statusValue.validate();
			
			_statusLabel.y = _genreValue.height + _genreValue.y;
			_statusLabel.validate();
			
			_quad1.y = _statusValue.y + _statusValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
			
			_rateValue.x = _space;
			_rateValue.y = _statusValue.height + _statusValue.y;
			_rateValue.validate();
			
			_rateLabel.y = _statusValue.height + _statusValue.y;
			_rateLabel.validate();
			
			_quad1.y = _rateValue.y + _rateValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
			
			_shareValue.x = _space;
			_shareValue.y = _rateValue.height + _rateValue.y;
			_shareValue.validate();
			
			_shareLabel.y =  _rateValue.height + _rateValue.y;
			_shareLabel.validate();
			
			_quad1.y = _shareValue.y + _shareValue.height;
			_quad1.height = 1;
			_quad1.width = actualWidth;
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
	}
}