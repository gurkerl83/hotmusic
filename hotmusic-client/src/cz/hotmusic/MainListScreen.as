package cz.hotmusic
{
	import cz.hotmusic.model.DataHelper;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.LeftListRenderer;
	import cz.hotmusic.renderer.MainListRenderer;
	import cz.hotmusic.renderer.RightListRenderer;
	
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.events.FeathersEventType;
	import feathers.skins.StandardIcons;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.geom.Rectangle;
	
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
		private var _addArtistButton:Button;
		private var _feedbackButton:Button;
		private var _header:Header;
		private var _list:List;
		
		private var _leftActive:Boolean;
		private var _leftList:List;
		private var _leftHeader:Header;
		private var _filterButton:feathers.controls.Button;
		
		private var _rightActive:Boolean;
		private var _rightList:GroupedList;
		private var _rightHeader:Header;
		private var _logo:Image;
		private var _leftShadow:Image;
		private var _rightShadow:Image;
		private var _bottomBg:Scale9Image;
		private var _searchTI:TextInput;
		private var _line:Quad;
		
		private var _space:int = 100;
		
		private var myQuad:Quad = new Quad(actualWidth, actualHeight);
		
		override protected function initialize():void
		{
			
			initMainList();
			initLeftMenu();
			initRightMenu();
			initBottomMenu();
//			
//			this.addChild(this._leftHeader);
//			this.addChild(this._leftList);
//			
//			this.addChild(myQuad);
//
			addChild(_leftList);
			addChild(_leftHeader);
			
			addChild(_searchTI);
			addChild(_line);
			this.addChild(this._rightHeader);
			this.addChild(this._rightList);
			
			this.addChild(this._header);
			this.addChild(this._list);
			this.addChild(this._leftShadow);
			this.addChild(this._rightShadow);
			this.addChild(this._bottomBg);
			this.addChild(this._addArtistButton);
			this.addChild(this._feedbackButton);
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
			
			var sgap:int = 24;
			_searchTI.x = _space + sgap;
			_searchTI.y = _header.height + sgap;
			_searchTI.width = actualWidth - _space - 2*sgap;
			_searchTI.validate();
			
			
			_line.y = _searchTI.y + _searchTI.height + sgap;
			_line.width = actualWidth;
			
			this._rightList.y = _line.y;
			this._rightList.width = this.actualWidth - _space;
			this._rightList.x = _space;
			this._rightList.height = this.actualHeight - this._rightList.y;
			
			// BOTTOM
			
			this._bottomBg.width = actualWidth;
			this._bottomBg.y = actualHeight - _bottomBg.height;
			_addArtistButton.x = actualWidth/3 - _addArtistButton.width/2;
			_addArtistButton.y = _bottomBg.y + _bottomBg.height/2 - _addArtistButton.height/2;
			_feedbackButton.x = 2*actualWidth/3 - _feedbackButton.width/2;
			_feedbackButton.y = _bottomBg.y + _bottomBg.height/2 - _feedbackButton.height/2;
			
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

		private function leftlist_changeHandler(event:Event):void
		{
			if (_list.selectedItem == null)
				return;
						
		}
		
		
		private function leftButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith("leftMenu");

//			if (!_leftActive && getChildAt(0) == _leftHeader)
			if (!_leftActive)
			{
				_searchTI.visible = false;
				_line.visible = false;
				_rightHeader.visible = false;
				_rightList.visible = false;
				_leftList.visible = true;
				_leftHeader.visible = true;
//				removeChild(_rightHeader);
//				removeChild(_rightList);
//				addChildAt(_leftList, 0);
//				addChildAt(_leftHeader, 0);
			} else {
				_leftHeader.visible = false;
				_leftList.visible = false;
//				removeChild(_leftHeader);
//				removeChild(_leftList);
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
			
			// bottom menu
			_bottomBg.x = _header.x;
			_addArtistButton.x = _header.x + actualWidth/3 - _addArtistButton.width/2;
			_feedbackButton.x = _header.x + 2*actualWidth/3 - _feedbackButton.width/2;
		}
		
		private function rightButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith("rightMenu");
			
//			if (!_rightActive && getChildAt(0) == _rightHeader)
			if (!_rightActive)
			{
				_leftHeader.visible = false;
				_leftList.visible = false;
				_searchTI.visible = true;
				_line.visible = true;
				_rightList.visible = true;
				_rightHeader.visible = true;
//				removeChild(_leftHeader);
//				removeChild(_leftList);
//				addChildAt(_searchTI, 0);
//				addChildAt(_line, 0);
//				addChildAt(_rightList, 0);
//				addChildAt(_rightHeader, 0);
			} else {
				_searchTI.visible = false;
				_line.visible = false;
				_rightList.visible = false;
				_rightHeader.visible = false;
//				removeChild(_rightHeader);
//				removeChild(_rightList);
//				removeChild(_searchTI);
//				removeChild(_line);
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
//			this.dispatchEventWith("filterButton");
			
			filterGenreBy = _leftList.selectedItem.genre;
			var filteredArr:Array;
			filteredArr = DataHelper.getInstance().songs.filter(filterGenre); 
			this._list.dataProvider = new ListCollection(filteredArr);
		}
		private var filterGenreBy:String;
		private function filterGenre(item:Object, index:int, arr:Array):Boolean
		{
			if (filterGenreBy == item.genre || filterGenreBy == "All genres")
				return true;
			return false;
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
//			this._list.itemRendererType = MainListRenderer;
//			this._list.itemRendererType = DefaultListItemRenderer;
			this._list.itemRendererType = MainListRenderer;
			this._list.dataProvider = new ListCollection(DataHelper.getInstance().songs);
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
			this._leftList.itemRendererType = LeftListRenderer;
			this._leftList.dataProvider = new ListCollection(DataHelper.getInstance().genres);
				
			this._leftList.itemRendererProperties.labelField = "genre";
			this._leftList.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._leftList.addEventListener(Event.CHANGE, leftlist_changeHandler);
		}
		
		private function initRightMenu():void
		{
			this._rightHeader = new Header();
			this._rightHeader.title = "Filter";
			
			// Search
			_searchTI = new TextInput();
			_searchTI.text = "Search artist, song or whatever...";
			
			_line = new Quad(1,1,0x444444);
			
			// LIST
			this._rightList = new GroupedList();
			this._rightList.itemRendererType = RightListRenderer;
			this._rightList.dataProvider = new HierarchicalCollection(DataHelper.getInstance().sorts);
			this._rightList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
				
			this._rightList.itemRendererProperties.labelField = "sortby";
			this._rightList.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._rightList.addEventListener(Event.CHANGE, list_changeHandler);
		}
		
		private function initBottomMenu():void
		{
			const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
			_bottomBg = new Scale9Image(new Scale9Textures(MetalWorksMobileTheme.atlas.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID)); //new Quad(300, 70, 0);
			_addArtistButton = new Button(Texture.fromBitmap(new FontAssets.AddArtist()));
			_feedbackButton = new Button(Texture.fromBitmap(new FontAssets.AddFeedback()));
		}
	}
}