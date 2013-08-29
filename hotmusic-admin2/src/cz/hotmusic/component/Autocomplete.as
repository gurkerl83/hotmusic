package cz.hotmusic.component
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.helper.ObjectHelper;
	import cz.hotmusic.lib.event.ServiceEvent;
	
	import feathers.controls.List;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.core.FocusManager;
	import feathers.core.IFocusDisplayObject;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class Autocomplete extends FeathersControl //implements IFocusDisplayObject
	{
		public function Autocomplete()
		{
			super();
		}
		
		
		public function set serviceEvent(se:ServiceEvent):void
		{
			_se = se;
		}
		public function get serviceEvent():ServiceEvent
		{
			return _se;
		}
		
		private var _se:ServiceEvent;
		private var _selectedItem:Object;

		public function get selectedItem():Object
		{
			return _selectedItem;
		}

		public function set selectedItem(value:Object):void
		{
			_selectedItem = value;

			textinput.removeEventListener(Event.CHANGE, tiChangeHandler);
			
			if (value == null) {
				textinput.text = null;
			}	else
				textinput.text = value.name;
			
			textinput.addEventListener(Event.CHANGE, tiChangeHandler);
		}

		public var textinput:TextInput;
		private var _list:List;
		
		override protected function initialize():void
		{
			super.initialize();
			
			addEventListener(FeathersEventType.FOCUS_OUT, autocompleteFocusOutHandler);
			addEventListener(FeathersEventType.FOCUS_IN, autocompleteFocusInHandler);
			
			textinput = new TextInput();
			textinput.name = "textinputwhite";
			textinput.addEventListener(FeathersEventType.FOCUS_OUT,tiFocusOutHandler); 
			textinput.addEventListener(FeathersEventType.FOCUS_IN,tiFocusInHandler); 
			textinput.addEventListener(Event.CHANGE, tiChangeHandler);
			
//			stage.addEventListener(KeyboardEvent.KEY_UP, tiKey);
			_list = new List();
			_list.itemRendererProperties.labelField = "name";
			_list.itemRendererName = "autocomplete";
			_list.addEventListener(FeathersEventType.FOCUS_IN, function listFocusInHandler(event:Event):void {
				
			});
			_list.addEventListener(Event.CHANGE, function onListChange(event:Event):void {
				if (_list.selectedIndex < 0)
					return;
				
				textinput.removeEventListener(Event.CHANGE, tiChangeHandler);
				textinput.text = _list.selectedItem.name;
				_selectedItem = _list.selectedItem;
//				_textinput.setFocus();
//				_textinput.selectRange(_textinput.text.length, _textinput.text.length);
				textinput.addEventListener(Event.CHANGE, tiChangeHandler);
//				_list.visible = false;
				_list.selectedIndex = -1;
				removeChild(_list);
			});
			
			addChild(textinput);
//			addChild(_list);
		}
		
		private function autocompleteFocusOutHandler(event:Event):void 
		{
			trace("autocompleteFocusOutHandler" + ObjectHelper.getId(this));
		}

		private function autocompleteFocusInHandler(event:Event):void 
		{
			trace("autocompleteFocusInHandler" + ObjectHelper.getId(this));
		}
		
		private function tiFocusOutHandler(event:Event):void {
			trace("tiFocusOutHandler" + ObjectHelper.getId(this));
			if (_selectedItem == null) {
				// pokud zadam text a nevyberu ze seznamu, pokusim se najit jestli
				// se text neshoduje s nejakou polozkou v seznamu, abych pracoval s objektem
				if (_list.dataProvider != null)
				{
					for each (var item:Object in _list.dataProvider.data)
					{
						if (item && item.name == textinput.text) {
							_selectedItem = item;
							break;
						}
					}
				}
//				textinput.removeEventListener(Event.CHANGE, tiChangeHandler);
//				textinput.text = "";
//				textinput.addEventListener(Event.CHANGE, tiChangeHandler);
			}
//			stage.removeEventListener(KeyboardEvent.KEY_UP, tiKey);
			
			// toto zajisti, aby se volal draw vzdy az po tom co je focusIn!!! :)
			invalidate();
		}
		
		private function tiFocusInHandler(event:Event):void {
			trace("tiFocusInHandler" + ObjectHelper.getId(this));
			textinput.selectRange(textinput.text.length, textinput.text.length);
//			stage.addEventListener(KeyboardEvent.KEY_UP, tiKey);
		}
		
//		private function tiKey(event:KeyboardEvent):void {
//			if (event.keyCode == 40 && _list.selectedIndex < (_list.dataProvider.length-1))
//				_list.selectedIndex++;
//			if (event.keyCode == 38 && _list.selectedIndex > 0)
//				_list.selectedIndex--;
//		}
		
		override protected function draw():void
		{
			super.draw();
			textinput.width = actualWidth;
			textinput.validate();
			_list.width = actualWidth;
			_list.y = textinput.height;
			setSize(actualWidth, textinput.height);
			
			// kdyz kliknu mimo
			if (textinput.focusManager.focus != textinput && _list.focusManager && _list.focusManager.focus != _list)
			{
				removeChild(_list);
			}
		}
		
		private function tiChangeHandler(event:Event):void
		{
			trace("tiChangeHandler");
			_selectedItem = null;
			if (textinput.text.length <= 0)
			{
				_list.selectedIndex = -1;
				removeChild(_list);
				return;
			}
			
			_se.sedata = textinput.text;
			_se.resultCallback = function onResult(result:ResultEvent):void {
				var items:Array = [];
				for each (var item:Object in result.result)
				{
					items.push(item);
				}
				_list.dataProvider = new ListCollection(items);
				addChild(_list);
			}
			CairngormEventDispatcher.getInstance().dispatchEvent(_se);
		}
		
	}
}