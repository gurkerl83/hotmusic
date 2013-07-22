package cz.hotmusic
{
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.MainListRenderer;
	
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.skins.StandardIcons;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	[Event(name="showDetail",type="starling.events.Event")]
	
	public class MainListScreen extends Screen
	{
		public static const SHOW_DETAIL:String = "showDetail";
		
		public function MainListScreen()
		{
			super();
		}
		
		private var _leftButton:Button;
		private var _rightButton:Button;
		private var _header:Header;
		private var _list:List;
		
		private var _leftActive:Boolean;
		private var _leftList:List;
		private var _leftHeader:Header;
		private var _filterButton:feathers.controls.Button;
		
		private var _rightActive:Boolean;
		private var _rightList:List;
		private var _rightHeader:Header;
		private var _logo:Image;
		private var _leftShadow:Image;
		private var _rightShadow:Image;
		
		private var _space:int = 100;
		
		private var myQuad:Quad = new Quad(actualWidth, actualHeight);
		
		override protected function initialize():void
		{
			
			initMainList();
			initLeftMenu();
			initRightMenu();
//			
//			this.addChild(this._leftHeader);
//			this.addChild(this._leftList);
//			
//			this.addChild(myQuad);
//
//			this.addChild(this._rightHeader);
//			this.addChild(this._rightList);
			
			this.addChild(this._header);
			this.addChild(this._list);
			this.addChild(this._leftShadow);
			this.addChild(this._rightShadow);
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			_logo.x = this._header.width/2 - _logo.width/2;
			_logo.y = this._header.height/2 - _logo.height/2;
			
			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;
			
			_leftShadow.x = - _leftShadow.width;
			_rightShadow.x = actualWidth;
			_leftShadow.height = actualHeight;
			_rightShadow.height = actualHeight;

			// LEFT
			
			this._leftHeader.width = actualWidth - _space;
			_leftHeader.validate();
			
			this._leftList.y = this._header.height;
			this._leftList.width = this.actualWidth - _space;
			this._leftList.height = this.actualHeight - this._leftList.y;

			// RIGHT
			
			this._rightHeader.width = actualWidth - _space;
			this._rightHeader.x = _space;
			_rightHeader.validate();
			
			this._rightList.y = this._header.height;
			this._rightList.width = this.actualWidth - _space;
			this._rightList.x = _space;
			this._rightList.height = this.actualHeight - this._rightList.y;
			
			
//			myQuad.width = actualWidth;
//			myQuad.height = actualHeight;
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
//			return StandardIcons.listDrillDownAccessoryTexture;
			return null;
		}
		
		private function list_changeHandler(event:Event):void
		{
			if (_list.selectedItem == null)
				return;
			
			Model.getInstance().selectedSong.name = _list.selectedItem.song;
			Model.getInstance().selectedSong.album.value = _list.selectedItem.album ? _list.selectedItem.album : "no album";
			Model.getInstance().selectedSong.added = _list.selectedItem.added;
			Model.getInstance().selectedSong.artist.value = _list.selectedItem.artist;
			Model.getInstance().selectedSong.genre.value = _list.selectedItem.genre ? _list.selectedItem.genre : "no genre";
			
			dispatchEventWith("showDetail");
//			const eventType:String = this._list.selectedItem.event as String;
//			this.dispatchEventWith(eventType);
		}
		
		
		private function leftButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith("leftMenu");

//			if (!_leftActive && getChildAt(0) == _leftHeader)
			if (!_leftActive)
			{
				removeChild(_rightHeader);
				removeChild(_rightList);
				addChildAt(_leftList, 0);
				addChildAt(_leftHeader, 0);
//				swapChildren(_leftHeader, _rightHeader);
//				swapChildren(_leftList, _rightList);
			} else {
				removeChild(_leftHeader);
				removeChild(_leftList);
			}
			validate();
			
			var targetX:int = _leftActive ? 0 : actualWidth - _space;
			_leftActive = !_leftActive;
			
			var myTween:Tween = new Tween(_header, 0.25, Transitions.EASE_OUT);
			myTween.animate("x", targetX);
			myTween.onUpdate = myTween_onUpdate;
			Starling.juggler.add(myTween);
		}
		
		private function myTween_onUpdate():void
		{
			_list.x = _header.x;
			_leftShadow.x = _header.x - _leftShadow.width;
			_rightShadow.x = _header.x + _header.width;
		}
		
		private function rightButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith("rightMenu");
			
//			if (!_rightActive && getChildAt(0) == _rightHeader)
			if (!_rightActive)
			{
				removeChild(_leftHeader);
				removeChild(_leftList);
				addChildAt(_rightList, 0);
				addChildAt(_rightHeader, 0);
//				swapChildren(_leftHeader, _rightHeader);
//				swapChildren(_leftList, _rightList);
			} else {
				removeChild(_rightHeader);
				removeChild(_rightList);
			}
			validate();
			
			var targetX:int = _rightActive ? 0 : - (actualWidth - _space);
			_rightActive = !_rightActive;
			
			var myTween:Tween = new Tween(_header, 0.25, Transitions.EASE_OUT);
			myTween.animate("x", targetX);
			myTween.onUpdate = myTween_onUpdate;
			Starling.juggler.add(myTween);
		}

		private function filterButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith("filterButton");
		}
		
		private function initMainList():void
		{
			// HEADER
			this._leftButton = new Button(Texture.fromBitmap(new FontAssets.Carky()));
//			this._leftButton.label = "left";
			this._leftButton.addEventListener(Event.TRIGGERED, leftButton_triggeredHandler);
			
			this._rightButton = new Button(Texture.fromBitmap(new FontAssets.Trychtyr()));
//			this._rightButton.label = "right";
			this._rightButton.addEventListener(Event.TRIGGERED, rightButton_triggeredHandler);
			
			this._header = new Header();
//			this._header.title = "hotmusic";
			_logo = Image.fromBitmap(new FontAssets.HotMusic());
			this._header.addChild(_logo);
			
			
			this._header.leftItems = new <DisplayObject>
				[
					this._leftButton
				];
			this._header.rightItems = new <DisplayObject>
				[
					this._rightButton
				];
			
			
			// LIST
			this._list = new List();
			this._list.itemRendererType = MainListRenderer;
			this._list.itemRendererType = DefaultListItemRenderer;
			this._list.itemRendererType = MainListRenderer;
			this._list.dataProvider = new ListCollection(
				[
					{ song: "What if", artist: "Coldplay", added: "TODAY", hotstatus: "3", event: SHOW_DETAIL },
					{ song: "The Adventures Of Rain Dance Maggie", artist: "Red Hot Chilli Peppers", album:"I'm with you", genre:"rock / pop / classical", added: "YESTERDAY", hotstatus: "2", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "YESTERDAY", hotstatus: "1", event: SHOW_DETAIL },
					{ song: "Jump Around", artist: "House of Pain", added: "2 DAYS AGO", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Heartbeats", artist: "Jose Gonzales", added: "23.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Roads", artist: "Portishead", added: "21.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Everything At Once", artist: "MGMT", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL }
				]);
			this._list.itemRendererProperties.labelField = "song";
//			this._list.itemRendererProperties.iconSourceFunction = accessorySourceFunction;
//			this._list.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._list.itemRendererProperties.accessoryLabelField = "added";
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			
			this._leftShadow = new Image(Texture.fromBitmap(new FontAssets.ShadowLeft()));
			this._rightShadow = new Image(Texture.fromBitmap(new FontAssets.ShadowRight()));
		}
		
		private function initLeftMenu():void
		{
			this._filterButton = new feathers.controls.Button();
			this._filterButton.label = "Filter";
			this._filterButton.addEventListener(Event.TRIGGERED, filterButton_triggeredHandler);
			
			this._leftHeader = new Header();
			this._leftHeader.title = "Genres";
			this._leftHeader.rightItems = new <DisplayObject>
				[
					this._filterButton
				];
			
			
			// LIST
			this._leftList = new List();
//			this._leftList.allowMultipleSelection = true;
			this._leftList.dataProvider = new ListCollection(
				[
					{ genre: "All genres", event: SHOW_DETAIL },
					{ genre: "RnB and Soul", event: SHOW_DETAIL },
					{ genre: "hip hop, rap", event: SHOW_DETAIL },
					{ genre: "rock", event: SHOW_DETAIL },
					{ genre: "reggae", event: SHOW_DETAIL },
					{ genre: "indian (Indie, bollywood)", event: SHOW_DETAIL },
					{ genre: "house/trance", event: SHOW_DETAIL },
					{ genre: "DnB", event: SHOW_DETAIL },
					{ genre: "Dance (hardcore, garage...)", event: SHOW_DETAIL },
					{ genre: "Techno", event: SHOW_DETAIL },
					{ genre: "dubstep", event: SHOW_DETAIL },
					{ genre: "RnB and Soul", event: SHOW_DETAIL },
					{ genre: "hip hop, rap", event: SHOW_DETAIL },
					{ genre: "rock", event: SHOW_DETAIL },
					{ genre: "reggae", event: SHOW_DETAIL },
					{ genre: "indian (Indie, bollywood)", event: SHOW_DETAIL },
					{ genre: "house/trance", event: SHOW_DETAIL },
					{ genre: "DnB", event: SHOW_DETAIL },
					{ genre: "Dance (hardcore, garage...)", event: SHOW_DETAIL },
					{ genre: "Techno", event: SHOW_DETAIL },
					{ genre: "dubstep", event: SHOW_DETAIL },
					{ genre: "RnB and Soul", event: SHOW_DETAIL },
					{ genre: "hip hop, rap", event: SHOW_DETAIL },
					{ genre: "rock", event: SHOW_DETAIL },
					{ genre: "reggae", event: SHOW_DETAIL },
					{ genre: "indian (Indie, bollywood)", event: SHOW_DETAIL },
					{ genre: "house/trance", event: SHOW_DETAIL },
					{ genre: "DnB", event: SHOW_DETAIL },
					{ genre: "Dance (hardcore, garage...)", event: SHOW_DETAIL },
					{ genre: "Techno", event: SHOW_DETAIL },
					{ genre: "dubstep", event: SHOW_DETAIL },
					{ genre: "RnB and Soul", event: SHOW_DETAIL },
					{ genre: "hip hop, rap", event: SHOW_DETAIL },
					{ genre: "rock", event: SHOW_DETAIL },
					{ genre: "reggae", event: SHOW_DETAIL },
					{ genre: "indian (Indie, bollywood)", event: SHOW_DETAIL },
					{ genre: "house/trance", event: SHOW_DETAIL },
					{ genre: "DnB", event: SHOW_DETAIL },
					{ genre: "Dance (hardcore, garage...)", event: SHOW_DETAIL },
					{ genre: "Techno", event: SHOW_DETAIL },
					{ genre: "dubstep", event: SHOW_DETAIL },
				]);
			this._leftList.itemRendererProperties.labelField = "genre";
			this._leftList.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._leftList.addEventListener(Event.CHANGE, list_changeHandler);
		}
		
		private function initRightMenu():void
		{
			this._rightHeader = new Header();
			this._rightHeader.title = "Filter";
			
			// LIST
			this._rightList = new List();
			this._rightList.dataProvider = new ListCollection(
				[
					{ sortby: "A-Z", event: SHOW_DETAIL },
					{ sortby: "Z-A", event: SHOW_DETAIL },
					{ sortby: "newest first", event: SHOW_DETAIL },
					{ sortby: "oldest first", event: SHOW_DETAIL },
					{ sortby: "View All", event: SHOW_DETAIL },
					{ sortby: "Hottest", event: SHOW_DETAIL },
					{ sortby: "Hot", event: SHOW_DETAIL },
					{ sortby: "Warm", event: SHOW_DETAIL },
					{ sortby: "Best first", event: SHOW_DETAIL },
					{ sortby: "Worst first", event: SHOW_DETAIL },
					{ sortby: "Date from", event: SHOW_DETAIL },
					{ sortby: "Date to", event: SHOW_DETAIL },
				]);
			this._rightList.itemRendererProperties.labelField = "sortby";
			this._rightList.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._rightList.addEventListener(Event.CHANGE, list_changeHandler);
		}
	}
}