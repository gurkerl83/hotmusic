package cz.hotmusic.component
{
	import cz.hotmusic.helper.ObjectHelper;
	import cz.hotmusic.lib.event.ServiceEvent;
	
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.core.IFocusDisplayObject;
	import feathers.events.FeathersEventType;
	import feathers.themes.Theme;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class FormItem extends FeathersControl// implements IFocusDisplayObject
	{
		public function FormItem()
		{
			super();
		}

		public var isAutocomplete:Boolean;
		public var serviceEvent:ServiceEvent;
		
		public function get selectedItem():Object {
			if (autocomplete && autocomplete.selectedItem)
				return autocomplete.selectedItem;
			return null;
		}
		public function set selectedItem(value:Object):void {
			autocomplete.selectedItem = value;
		}
		
		public function showValidator():void
		{
			_bgRed.visible = true;
		}

		public function hideValidator():void
		{
			_bgRed.visible = false;
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
			if (isAutocomplete)
				return autocomplete.textinput.text;
			return textinput.text;
		}
		
		private static const NORMAL_STATE	:String = "normal";
		private static const INVALID_STATE	:String = "invalid";
		
		protected static const COLAPSED_HEIGHT:int = 50;
		
		private var currentState:String
		
		protected var bg:Quad;
		private var _bgRed:Quad;
		protected var orderNumberLbl:Label;
		protected var labelLbl:Label;
		public var textinput:TextInput;
		public var autocomplete:Autocomplete;
		
		protected var paddingLeft:int;
		
		override protected function initialize():void
		{
			super.initialize();
			
			height = COLAPSED_HEIGHT;
			paddingLeft = 20;
			
			bg = new Quad(1,1,0xCCCCCC);
			_bgRed = new Quad(1,1,0xD49799);
			_bgRed.visible = false;
			
			orderNumberLbl = new Label();
			orderNumberLbl.name = Theme.SMALL_BOLD_ORANGE;
			
			labelLbl = new Label();
			labelLbl.name = Theme.SMALL_NORMAL_BLACK;
			
			if (isAutocomplete) {
				autocomplete = new Autocomplete();
				autocomplete.serviceEvent = serviceEvent;
			} else {
				textinput = new TextInput();
				textinput.name = "textinputwhite";
				textinput.addEventListener(FeathersEventType.FOCUS_IN,tiFocusInHandler); 
			}
			
			addChild(bg);
			addChild(_bgRed);
			addChild(orderNumberLbl);
			addChild(labelLbl);
			
			if (isAutocomplete)
				addChild(autocomplete);
			else
				addChild(textinput);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var gap:int = 16;
			
			bg.width = _bgRed.width = actualWidth;
			bg.height = _bgRed.height = COLAPSED_HEIGHT;
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				orderNumberLbl.text = _orderNumber;
				labelLbl.text = _label;
				if (!isAutocomplete)
					textinput.text = _value;
			}
			
			orderNumberLbl.validate();
			orderNumberLbl.x = paddingLeft;
			orderNumberLbl.y = actualHeight/2 - orderNumberLbl.height/2;
			
			
			labelLbl.validate();
			labelLbl.x = orderNumberLbl.x + orderNumberLbl.width;// + gap;
			labelLbl.y = actualHeight/2 - labelLbl.height/2;

			if (isAutocomplete) {
				autocomplete.x = 250;
				autocomplete.validate();
				autocomplete.y = actualHeight/2 - autocomplete.height/2;
				autocomplete.width = actualWidth - autocomplete.x - autocomplete.y;
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
		
//		override public function showFocus():void
//		{
//			trace("FormItem.showFocus" + ObjectHelper.getId(this));
//			super.showFocus();
//			if (isAutocomplete)
//				_autocomplete.showFocus();
//			else
//				textinput.setFocus();
//		}
		
		override public function showFocus():void
		{
			super.showFocus();
		}
		
		// toto je zde kvuli nastaveni focusu uvnitr
		override public function set nextTabFocus(value:IFocusDisplayObject):void
		{
			trace("FormItem.nextTabFocus set" + ObjectHelper.getId(this));
			if (isAutocomplete)
				autocomplete.textinput.nextTabFocus = value;
			else
				textinput.nextTabFocus = value;
		}
		
		override public function set previousTabFocus(value:IFocusDisplayObject):void
		{
			trace("FormItem.previousTabFocus set" + ObjectHelper.getId(this));
			if (isAutocomplete)
				autocomplete.textinput.previousTabFocus = value;
			else
				textinput.previousTabFocus = value;
		}
		
		override public function get nextTabFocus():IFocusDisplayObject
		{
			trace("FormItem.nextTabFocus get" + ObjectHelper.getId(this));
			if (isAutocomplete)
				return autocomplete.textinput.nextTabFocus;
			else
				return textinput.nextTabFocus;
		}

		override public function get previousTabFocus():IFocusDisplayObject
		{
			trace("FormItem.previousTabFocus get" + ObjectHelper.getId(this));
			if (isAutocomplete)
				return autocomplete.textinput.previousTabFocus;
			else
				return textinput.previousTabFocus;
		}
	}
}