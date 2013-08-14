package cz.hotmusic
{
	import com.thejustinwalsh.ane.TestFlight;
	
	import cz.hotmusic.components.SendDialog;
	import cz.hotmusic.helper.SortHelper;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.LeftListRenderer;
	import cz.hotmusic.renderer.MainListRenderer;
	import cz.hotmusic.renderer.RightListRenderer;
	import cz.zc.mylib.helper.DateHelper;
	import cz.zc.mylib.helper.LogHelper;
	
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.TextArea;
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
	
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.ReturnKeyLabel;
	
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
		
		private var _leftButton:starling.display.Button;
		private var _rightButton:starling.display.Button;
		private var _addArtistButton:starling.display.Button;
		private var _feedbackButton:starling.display.Button;
		private var _header:Header;
		private var _list:List;
		
		private var _leftActive:Boolean;
		private var _leftList:List;
		private var _leftHeader:Header;
		private var _filterLeftButton:feathers.controls.Button;
		
		private var _rightActive:Boolean;
		private var _rightList:GroupedList;
		private var _rightHeader:Header;
		private var _filterRightButton:feathers.controls.Button;
		private var _logo:Image;
		private var _leftShadow:Image;
		private var _rightShadow:Image;
		private var _bottomBg:Scale9Image;
		private var _searchTI:TextInput;
		private var _line:Quad;
		private var _endLine:Quad;
		private var _scrollContainer:ScrollContainer;
		
		private var _space:int = 100;
		
		private var myQuad:Quad;
		private var debugPanel:ScrollText;
		private var sendDialog:SendDialog;
		private var curtain:Quad;
		
		override protected function initialize():void
		{
			
			initMainList();
			initLeftMenu();
			initRightMenu();
			initBottomMenu();
			initDebugPanel();
//
			addChild(_leftList);
			addChild(_leftHeader);
			
			addChild(_searchTI);
			addChild(_line);
			this.addChild(this._rightHeader);
			_scrollContainer.addChild(_rightList);
			_scrollContainer.addChild(_filterRightButton);
			_scrollContainer.addChild(_endLine);
			this.addChild(_scrollContainer);
			
			
			this.addChild(this.myQuad);
			this.addChild(this._header);
			this.addChild(this._list);
			this.addChild(this._leftShadow);
			this.addChild(this._rightShadow);
			this.addChild(this._bottomBg);
			this.addChild(this._addArtistButton);
			this.addChild(this._feedbackButton);
			this.addChild(this.debugPanel);
			this.addChild(this.curtain);
			this.addChild(this.sendDialog);
		}
		
		override protected function draw():void
		{
			myQuad.width = actualWidth;
			myQuad.height = actualHeight;
			
			this._header.paddingTop = this._header.paddingBottom = this._header.paddingLeft = this._header.paddingRight = 0;
			this._header.width = this.actualWidth;
			this._header.validate();
			
			_logo.x = this._header.width/2 - _logo.width/2;
			_logo.y = this._header.height/2 - _logo.height/2;
			
			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y - _bottomBg.height;
			
			debugPanel.y = _header.height;
			debugPanel.width = actualWidth;
			debugPanel.height = actualHeight - _list.y - _bottomBg.height;
			
			_leftShadow.x = - _leftShadow.width;
			_rightShadow.x = actualWidth;
			_leftShadow.height = actualHeight;
			_rightShadow.height = actualHeight;

			// LEFT
			
			this._leftHeader.paddingRight = 50;
			this._leftHeader.paddingLeft = 50;
			this._leftHeader.width = actualWidth - _space;
			_leftHeader.validate();
			_filterLeftButton.width *= 2;
			
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
			
			
			_line.x = _space;
			_line.y = _searchTI.y + _searchTI.height + sgap;
			_line.width = actualWidth - _space;
			
			_scrollContainer.width = actualWidth;
			_scrollContainer.height = actualHeight - _header.height - 2*sgap - _searchTI.height - 1;
			_scrollContainer.y = _header.height + 2*sgap + _searchTI.height + 1;
			_scrollContainer.validate();
			
			this._rightList.width = this.actualWidth - _space;
			this._rightList.x = _space;
			
			_filterRightButton.width *= 2;
			_filterRightButton.y = _rightList.height + sgap;
			_filterRightButton.x = _space + (actualWidth - _space)/2 - _filterRightButton.width/2 ;
			
			_endLine.y = _filterRightButton.y + _filterRightButton.height + sgap;
			
			// BOTTOM
			
			this._bottomBg.width = actualWidth;
			this._bottomBg.y = actualHeight - _bottomBg.height;
			_addArtistButton.x = actualWidth/3 - _addArtistButton.width/2;
			_addArtistButton.y = _bottomBg.y + _bottomBg.height/2 - _addArtistButton.height/2;
			_feedbackButton.x = 2*actualWidth/3 - _feedbackButton.width/2;
			_feedbackButton.y = _bottomBg.y + _bottomBg.height/2 - _feedbackButton.height/2;
			
			sendDialog.width = actualWidth;
			sendDialog.validate();
//			sendDialog.height = actualHeight;
			sendDialog.y = actualHeight - sendDialog.height;
			
			curtain.width = actualWidth;
			curtain.height = actualHeight;
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
			
			Model.getInstance().selectedSong.name = Song(_list.selectedItem).name;
			Model.getInstance().selectedSong.album.name = Song(_list.selectedItem).album ? Song(_list.selectedItem).album.name : "no album";
			Model.getInstance().selectedSong.addedDate = Song(_list.selectedItem).addedDate;
			Model.getInstance().selectedSong.addedByUser = Song(_list.selectedItem).addedByUser;
			Model.getInstance().selectedSong.addedBySession = Song(_list.selectedItem).addedBySession;
			Model.getInstance().selectedSong.artist.name = Song(_list.selectedItem).artist.name;
			Model.getInstance().selectedSong.genre.name = Song(_list.selectedItem).genre ? Song(_list.selectedItem).genre.name : "no genre";
			Model.getInstance().selectedSong.rateUp = Song(_list.selectedItem).rateUp;
			Model.getInstance().selectedSong.rateDown = Song(_list.selectedItem).rateDown;
			Model.getInstance().selectedSong.hotstatus = Song(_list.selectedItem).hotstatus;
			
			TestFlight.passCheckpoint("Song Selected: " + Song(_list.selectedItem).name);
			
			dispatchEventWith("showDetail");
		}

		private function leftlist_changeHandler(event:Event):void
		{
			if (_list.selectedItem == null)
				return;
		}
		
		
		private function leftButton_triggeredHandler(event:Event):void
		{
			TestFlight.passCheckpoint("Genres Button");
			this.dispatchEventWith("leftMenu");

			if (!_leftActive)
			{
				_searchTI.visible = false;
				_line.visible = false;
				_rightHeader.visible = false;
				_scrollContainer.visible = false;
				_leftList.visible = true;
				_leftHeader.visible = true;
			}
			validate();
			
			var targetX:int = _leftActive ? 0 : actualWidth - _space;
			
			var myTween:Tween = new Tween(_header, 0.4, Transitions.EASE_OUT);
			myTween.animate("x", targetX);
			myTween.onUpdate = myTween_onUpdate;
			myTween.onComplete = myTweenLeft_onComplete;
			Starling.juggler.add(myTween);
		}
		
		private function myTween_onUpdate():void
		{
			myQuad.x = _header.x;
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
			TestFlight.passCheckpoint("Filter Button");
			this.dispatchEventWith("rightMenu");
			
			if (!_rightActive)
			{
				_leftHeader.visible = false;
				_leftList.visible = false;
				_searchTI.visible = true;
				_line.visible = true;
				_scrollContainer.visible = true;
				_rightHeader.visible = true;
			}
			validate();
			
			var targetX:int = _rightActive ? 0 : - (actualWidth - _space);
			
			var myTween:Tween = new Tween(_header, 0.4, Transitions.EASE_OUT);
			myTween.animate("x", targetX);
			myTween.onUpdate = myTween_onUpdate;
			myTween.onComplete = myTweenRight_onComplete;
			Starling.juggler.add(myTween);
		}
		
		private function myTweenRight_onComplete():void
		{
			if (_rightActive) {
				_searchTI.visible = false;
				_line.visible = false;
				_scrollContainer.visible = false;
				_rightHeader.visible = false;
			}
			_rightActive = !_rightActive;	
			TestFlight.passCheckpoint("Filters are " + _rightActive ? "open":"closed");
		}
		private function myTweenLeft_onComplete():void
		{
			if (_leftActive) {
				_leftHeader.visible = false;
				_leftList.visible = false;
			}
			_leftActive = !_leftActive;	
			TestFlight.passCheckpoint("Genres are " + _leftActive ? "open":"closed");
		}

		private function filterLeftButton_triggeredHandler(event:Event):void
		{
//			this.dispatchEventWith("filterButton");
			if (_leftList.selectedItem == null)
				return;
				
			filterGenreBy = _leftList.selectedItem.name;
			TestFlight.passCheckpoint("Genre Filter Button: by " + filterGenreBy);
			var filteredArr:Array;
			filteredArr = Model.getInstance().songs.filter(filterGenre); 
			this._list.dataProvider = new ListCollection(filteredArr);
			leftButton_triggeredHandler(null);
		}
		private var filterGenreBy:String;
		private function filterGenre(item:Object, index:int, arr:Array):Boolean
		{
			if (filterGenreBy == item.genre.name || filterGenreBy == "All genres")
				return true;
			return false;
		}
		
		private function initMainList():void
		{
			myQuad = new Quad(1, 1, 0x1A171B);
			// HEADER
			this._leftButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Carky()));
			this._leftButton.addEventListener(Event.TRIGGERED, leftButton_triggeredHandler);
			
			this._rightButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.Trychtyr()));
			this._rightButton.addEventListener(Event.TRIGGERED, rightButton_triggeredHandler);
			
			this._header = new Header();
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
			this._list.dataProvider = new ListCollection(Model.getInstance().songs);
			this._list.itemRendererProperties.labelField = "name";
			this._list.itemRendererProperties.accessoryLabelFunction = function(item:Song):String
			{
				return DateHelper.dateToText(item.addedDate);
			}
			
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
			
			this._leftShadow = new Image(Texture.fromBitmap(new FontAssets.ShadowLeft()));
			this._rightShadow = new Image(Texture.fromBitmap(new FontAssets.ShadowRight()));
			
			
		}
		
		private function initLeftMenu():void
		{
			this._filterLeftButton = new feathers.controls.Button();
			this._filterLeftButton.label = "Filter";
			this._filterLeftButton.addEventListener(Event.TRIGGERED, filterLeftButton_triggeredHandler);
			
			this._leftHeader = new Header();
			this._leftHeader.title = "Genres";
			this._leftHeader.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
			this._leftHeader.rightItems = new <DisplayObject>
				[
					this._filterLeftButton
				];
			
			
			// LIST
			this._leftList = new List();
//			this._leftList.allowMultipleSelection = true;
			this._leftList.itemRendererType = LeftListRenderer;

			var allGenres:Genre = new Genre("All genres");
			allGenres.count = Model.getInstance().songs.length;
			
			var genresArr:Array = [];
			genresArr.push(allGenres);
			genresArr = genresArr.concat(Model.getInstance().genres);
			
			this._leftList.dataProvider = new ListCollection(genresArr);
				
			this._leftList.itemRendererProperties.labelField = "name";
			this._leftList.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._leftList.addEventListener(Event.CHANGE, leftlist_changeHandler);
			_leftList.visible = false;
		}
		
		private function initRightMenu():void
		{
			this._rightHeader = new Header();
			this._rightHeader.title = "Filter";
			
			// Search
			_searchTI = new TextInput();
			_searchTI.prompt = "Search artist, song or whatever...";
			_searchTI.textEditorProperties.returnKeyLabel = ReturnKeyLabel.DONE;
			_searchTI.addEventListener(FeathersEventType.ENTER, enterHandler);
			
			_line = new Quad(1,1,0x444444);
			
			_scrollContainer = new ScrollContainer();
			
			// LIST
			this._rightList = new GroupedList();
			this._rightList.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._rightList.itemRendererType = RightListRenderer;
			this._rightList.dataProvider = new HierarchicalCollection(SortHelper.getInstance().sorts);
			this._rightList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			this._rightList.itemRendererProperties.labelField = "sortby";
			this._rightList.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._rightList.addEventListener(Event.CHANGE, list_changeHandler);
			
			// BUTTON
			
			_filterRightButton = new feathers.controls.Button();
			_filterRightButton.label = "Filter";
			_filterRightButton.addEventListener(Event.TRIGGERED, filterRightButton_triggeredHandler);
			
			_endLine = new Quad(1,1,0x1A171B);
			
			_searchTI.visible = false;
			_line.visible = false;
			_scrollContainer.visible = false;
		}
		
		private function filterRightButton_triggeredHandler(event:Event):void
		{
			// SEARCH FILTER
			filterByWhatever = _searchTI.text;
			var filteredArr:Array;
			filteredArr = Model.getInstance().songs.filter(filterWhatever); 
			var checkpointText:String = "Filter Button (right). Search: " + filterByWhatever; 
			// SORT FILTER
			if (_rightList.selectedItem) {
				filteredArr = SortHelper.getInstance().sort(filteredArr, _rightList.selectedItem.sortbykey);
				checkpointText += ", Sort: " + _rightList.selectedItem.sortbykey;
			}
			
			TestFlight.passCheckpoint(checkpointText);
			
			this._list.dataProvider = new ListCollection(filteredArr);
			rightButton_triggeredHandler(null);
		}
		
		private var filterByWhatever:String;
		private function filterWhatever(item:Object, index:int, arr:Array):Boolean
		{
			if (String(item.genre.name).toLowerCase().indexOf(filterByWhatever.toLowerCase()) > -1 ||
				String(item.artist.name).toLowerCase().indexOf(filterByWhatever.toLowerCase()) > -1 ||
				String(item.name).toLowerCase().indexOf(filterByWhatever.toLowerCase()) > -1 ||
				filterByWhatever == null || filterByWhatever.length <= 0
			)
				return true;
			return false;
		}
		
		private function initBottomMenu():void
		{
			const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
			_bottomBg = new Scale9Image(new Scale9Textures(MetalWorksMobileTheme.atlas.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID)); //new Quad(300, 70, 0);
			_addArtistButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.AddArtist()));
			_addArtistButton.addEventListener(Event.TRIGGERED, function onAddArtist(event:Event):void {
				TestFlight.passCheckpoint("AddArtist Button");
				sendDialog.state(SendDialog.ADD_ARTIST_STATE);
				sendDialog.validate();
				sendDialog.visible = true;
				curtain.visible = true;
//				debugPanel.text = LogHelper.textLog;
//				debugPanel.visible = !debugPanel.visible;
			});
			_feedbackButton = new starling.display.Button(Texture.fromBitmap(new FontAssets.AddFeedback()));
			_feedbackButton.addEventListener(Event.TRIGGERED, function onFeedback(event:Event):void {
				TestFlight.passCheckpoint("Feedback Button");
//				TestFlightSDK.service.openFeedbackView();
				try {
					sendDialog.state(SendDialog.FEEDBACK_STATE);
					sendDialog.validate();
					sendDialog.visible = true;
					curtain.visible = true;
//					LogHelper.getInstance(this).log("TestFlight.openFeedbackView() starting");
//					TestFlight.openFeedbackView();
//					LogHelper.getInstance(this).log("TestFlight.openFeedbackView() ended");
				} catch (err:Error) {
					LogHelper.getInstance(this).log(err.getStackTrace());
				}
			});
			
			curtain = new Quad(1, 1, 0x000004);
			curtain.alpha = 0.7;
			curtain.visible = false;
			sendDialog = new SendDialog();
			sendDialog.visible = false;
			sendDialog.addEventListener(Event.CLOSE, function onClose(event:Event):void {
				sendDialog.visible = false;
				curtain.visible = false;
			});
		}
		
		private function initDebugPanel():void {
			debugPanel = new ScrollText();
			debugPanel.visible = false;
			debugPanel.background = true;
			debugPanel.backgroundColor = 0;
		}
		
		private function enterHandler (event:Event):void
		{
			var nativeStage:Stage = Starling.current.nativeStage;
//			var focus:InteractiveObject = mystage.focus;
//			_searchTI.prompt = "enterHandler " + (mystage.focus != null) ? "focus: "+mystage.focus : "focus is null";
			nativeStage.focus = null;
			//				Starling.current.nativeStage.focus = null;
		}
	}
}