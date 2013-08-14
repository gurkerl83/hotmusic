package cz.hotmusic.component
{
	import cz.hotmusic.lib.event.ServiceEvent;
	import cz.hotmusic.helper.ObjectHelper;
	
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.core.IFocusDisplayObject;
	import feathers.events.FeathersEventType;
	import feathers.themes.Theme;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class FormItem extends FeathersControl implements IFocusDisplayObject
	{
		public function FormItem()
		{
			super();
		}

		public var isAutocomplete:Boolean;
		public var serviceEvent:ServiceEvent;
		public function get selectedItem():Object {
			if (_autocomplete && _autocomplete.selectedItem)
				return _autocomplete.selectedItem;
			return null;
		}
		
		private var _label:String;
		private var _orderNumber:String;
		private var _value:String;
		
		public function set label(value:String):void
		{
			_label = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get label():String
		{
			return _label;
		}

		public function set orderNumber(value:String):void
		{
			_orderNumber = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get orderNumber():String
		{
			return _orderNumber
		}

		public function set value(val:String):void
		{
			_value = val;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get value():String
		{
			return textinput.text;
		}
		
		private static const NORMAL_STATE	:String = "normal";
		private static const INVALID_STATE	:String = "invalid";
		
		private var currentState:String
		
		private var _bg:Quad;
		private var _orderNumberLbl:Label;
		private var _labelLbl:Label;
		public var textinput:TextInput;
		private var _autocomplete:Autocomplete;
		
		override protected function initialize():void
		{
			super.initialize();
			
			height = 50;
			
			_bg = new Quad(1,1,0xCCCCCC);
			
			_orderNumberLbl = new Label();
			_orderNumberLbl.name = Theme.SMALL_BOLD_ORANGE;
			
			_labelLbl = new Label();
			_labelLbl.name = Theme.SMALL_NORMAL_BLACK;
			
			if (isAutocomplete) {
				_autocomplete = new Autocomplete();
				_autocomplete.serviceEvent = serviceEvent;
			} else {
				textinput = new TextInput();
				textinput.name = "textinputwhite";
				textinput.addEventListener(FeathersEventType.FOCUS_IN,tiFocusInHandler); 
			}
			
			addChild(_bg);
			addChild(_orderNumberLbl);
			addChild(_labelLbl);
			if (isAutocomplete)
				addChild(_autocomplete);
			else
				addChild(textinput);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var paddingLeft:int = 20;
			var gap:int = 16;
			
			_bg.width = actualWidth;
			_bg.height = actualHeight;
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_orderNumberLbl.text = _orderNumber;
				_labelLbl.text = _label;
				if (!isAutocomplete)
					textinput.text = _value;
			}
			
			_orderNumberLbl.validate();
			_orderNumberLbl.x = paddingLeft;
			_orderNumberLbl.y = actualHeight/2 - _orderNumberLbl.height/2;
			
			
			_labelLbl.validate();
			_labelLbl.x = _orderNumberLbl.x + _orderNumberLbl.width;// + gap;
			_labelLbl.y = actualHeight/2 - _labelLbl.height/2;

			if (isAutocomplete) {
				_autocomplete.x = 250;
				_autocomplete.validate();
				_autocomplete.y = actualHeight/2 - _autocomplete.height/2;
				_autocomplete.width = actualWidth - _autocomplete.x - _autocomplete.y;
			} else {
				textinput.x = 250;
				textinput.validate();
				textinput.y = actualHeight/2 - textinput.height/2;
				textinput.width = actualWidth - textinput.x - textinput.y;
			}
		}
		
		private function tiFocusInHandler(event:Event):void {
			trace("FormItem.tiFocusInHandler" + ObjectHelper.getId(this));
//			textinput.selectRange(textinput.text.length, textinput.text.length);
		}
		
		override public function showFocus():void
		{
			trace("FormItem.showFocus" + ObjectHelper.getId(this));
			super.showFocus();
			if (isAutocomplete)
				_autocomplete.showFocus();
			else
				textinput.setFocus();
		}
		
		// toto je zde kvuli nastaveni focusu uvnitr
		override public function set nextTabFocus(value:IFocusDisplayObject):void
		{
			trace("FormItem.nextTabFocus set" + ObjectHelper.getId(this));
			if (isAutocomplete)
				_autocomplete.textinput.nextTabFocus = value;
			else
				textinput.nextTabFocus = value;
		}
		
		override public function set previousTabFocus(value:IFocusDisplayObject):void
		{
			trace("FormItem.previousTabFocus set" + ObjectHelper.getId(this));
			if (isAutocomplete)
				_autocomplete.textinput.previousTabFocus = value;
			else
				textinput.previousTabFocus = value;
		}
		
		override public function get nextTabFocus():IFocusDisplayObject
		{
			trace("FormItem.nextTabFocus get" + ObjectHelper.getId(this));
			if (isAutocomplete)
				return _autocomplete.textinput.nextTabFocus;
			else
				return textinput.nextTabFocus;
		}

		override public function get previousTabFocus():IFocusDisplayObject
		{
			trace("FormItem.previousTabFocus get" + ObjectHelper.getId(this));
			if (isAutocomplete)
				return _autocomplete.textinput.previousTabFocus;
			else
				return textinput.previousTabFocus;
		}
	}
}