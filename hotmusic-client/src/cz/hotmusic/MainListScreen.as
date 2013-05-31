package cz.hotmusic
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
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
	[Event(name="showButton",type="starling.events.Event")]
	[Event(name="showButtonGroup",type="starling.events.Event")]
	[Event(name="showCallout",type="starling.events.Event")]
	[Event(name="showGroupedList",type="starling.events.Event")]
	[Event(name="showList",type="starling.events.Event")]
	[Event(name="showPageIndicator",type="starling.events.Event")]
	[Event(name="showPickerList",type="starling.events.Event")]
	[Event(name="showProgressBar",type="starling.events.Event")]
	[Event(name="showScrollText",type="starling.events.Event")]
	[Event(name="showSlider",type="starling.events.Event")]
	[Event(name="showTabBar",type="starling.events.Event")]
	[Event(name="showTextInput",type="starling.events.Event")]
	[Event(name="showToggles",type="starling.events.Event")]
	
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
		private var _filterButton:Button;
		
		private var _rightActive:Boolean;
		private var _rightList:List;
		private var _rightHeader:Header;
		
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
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;

			this._leftHeader.width = actualWidth - _space;
			_leftHeader.validate();
			
			this._leftList.y = this._header.height;
			this._leftList.width = this.actualWidth - _space;
			this._leftList.height = this.actualHeight - this._leftList.y;

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
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function list_changeHandler(event:Event):void
		{
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
			this._leftButton = new Button();
			this._leftButton.label = "left";
			this._leftButton.addEventListener(Event.TRIGGERED, leftButton_triggeredHandler);
			
			this._rightButton = new Button();
			this._rightButton.label = "right";
			this._rightButton.addEventListener(Event.TRIGGERED, rightButton_triggeredHandler);
			
			this._header = new Header();
			this._header.title = "hotmusic";
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
			this._list.dataProvider = new ListCollection(
				[
					{ song: "What if", artist: "Coldplay", added: "TODAY", hotstatus: "3", event: SHOW_DETAIL },
					{ song: "The Adventures Of Rain D...", artist: "Red Hot Chilli Peppers", added: "YESTERDAY", hotstatus: "2", event: SHOW_DETAIL },
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
					{ song: "Tear Drop", artist: "Massive Attack", added: "7.5.2013", hotstatus: "0", event: SHOW_DETAIL },
				]);
			this._list.itemRendererProperties.labelField = "song";
			this._list.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			this._list.addEventListener(Event.CHANGE, list_changeHandler);
		}
		
		private function initLeftMenu():void
		{
			this._filterButton = new Button();
			this._filterButton.label = "filter";
			this._filterButton.addEventListener(Event.TRIGGERED, filterButton_triggeredHandler);
			
			this._leftHeader = new Header();
			this._leftHeader.title = "genres";
			this._leftHeader.rightItems = new <DisplayObject>
				[
					this._filterButton
				];
			
			
			// LIST
			this._leftList = new List();
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