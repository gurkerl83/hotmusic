package cz.hotmusic.component
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.ISearchSort;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ServiceEvent;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	
	import flash.ui.Keyboard;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	public class SearchSort extends FeathersControl
	{
		public function SearchSort(se:ServiceEvent, list:List, screen:ISearchSort, sortBy:String=AZ)
		{
			super();
			this.se = se;
			this.list = list;
			this.screen = screen;
			this.sortBy = sortBy;
		}
		
		public static const AZ:String = "A-Z";
		public static const ZA:String = "Z-A";
		public static const NEWEST:String = "Newest";
		public static const OLDEST:String = "Oldest";
		
		public var sortBy:String = AZ;
		
		private var se:ServiceEvent;
		private var list:List;
		private var screen:ISearchSort;
		
		private var sortPicker:PickerList;
		private var searchTI:TextInput;
		private var searchButton:Button;
		
		public function clear():void
		{
			if (searchTI)
				searchTI.text = "";
//			if (sortPicker)
//				sortPicker.selectedIndex = 0;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			stage.addEventListener(KeyboardEvent.KEY_UP, function onKey(event:KeyboardEvent):void {
				if (event.keyCode == Keyboard.ENTER && searchTI.focusManager && searchTI.focusManager.focus == searchTI)
					onList(null);
			});
			
			searchTI = new TextInput();
			searchTI.name = "textinputblack";
			searchTI.prompt = "search";
			searchTI.width = 400;
			searchTI.height = 40;
			
			searchButton = new Button(Texture.fromBitmap(new FontAssets.LupaUp()),"",Texture.fromBitmap(new FontAssets.LupaDown()));
			searchButton.addEventListener(Event.TRIGGERED, onSearch);
			
			sortPicker = new PickerList();
			sortPicker.dataProvider = new ListCollection([AZ, ZA, NEWEST, OLDEST]);;
			sortPicker.width = 200;
			sortPicker.addEventListener(Event.CHANGE, onSort);
			
			if (sortBy != null && sortBy != "" && sortBy != AZ) {
				sortPicker.selectedItem = sortBy;
			}
//			
//			onList(null);
			
			addChild(searchTI);
			addChild(searchButton);
			addChild(sortPicker);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			searchButton.x = searchTI.width - searchButton.width - 6;
			searchButton.y = 6;
			
			sortPicker.x = searchTI.width + 40;
			
			setSize(sortPicker.x + sortPicker.width, 40);
		}
		
		private function onSort(event:Event):void 
		{
			sortBy = screen.sort = String(sortPicker.selectedItem);
			dispatchEventWith("sortChange");
			onList(event);
		}
		
		private function onSearch(event:Event):void 
		{
			screen.search = searchTI.text;
			onList(event);
		}
		
		private function onList(event:Event):void 
		{
			se.sedata = screen;
			se.sid = Model.getInstance().user.sid;
			se.resultCallback = function onResult(result:ResultEvent):void 
			{
				list.dataProvider = new ListCollection(DataHelper.al2a(result.result));
			}
			se.faultCallback = Alert.showError;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
	}
}