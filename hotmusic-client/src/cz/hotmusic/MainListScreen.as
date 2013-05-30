package cz.hotmusic
{
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
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
		
		private var _header:Header;
		private var _list:List;
		
		override protected function initialize():void
		{
			this._header = new Header();
			this._header.title = "hotmusic";
			this.addChild(this._header);
			
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
			this.addChild(this._list);
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function list_changeHandler(event:Event):void
		{
			const eventType:String = this._list.selectedItem.event as String;
			this.dispatchEventWith(eventType);
		}
	}
}