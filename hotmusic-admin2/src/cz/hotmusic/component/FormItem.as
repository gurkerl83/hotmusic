package cz.hotmusic.component
{
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.themes.Theme;
	
	import starling.display.Quad;
	
	public class FormItem extends FeathersControl
	{
		public function FormItem()
		{
			super();
		}

		public var autocomplete:Boolean;
		
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
			return _value;
		}
		
		private static const NORMAL_STATE	:String = "normal";
		private static const INVALID_STATE	:String = "invalid";
		
		private var currentState:String
		
		private var _bg:Quad;
		private var _orderNumberLbl:Label;
		private var _labelLbl:Label;
		private var _textinput:TextInput;
		
		override protected function initialize():void
		{
			super.initialize();
			
			height = 50;
			
			_bg = new Quad(1,1,0xCCCCCC);
			
			_orderNumberLbl = new Label();
			_orderNumberLbl.name = Theme.SMALL_BOLD_ORANGE;
			
			_labelLbl = new Label();
			_labelLbl.name = Theme.SMALL_BOLD_BLACK;
			
			_textinput = new TextInput();
			_textinput.name = "textinputwhite";
			
			addChild(_bg);
			addChild(_orderNumberLbl);
			addChild(_labelLbl);
			addChild(_textinput);
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
				_textinput.text = _value;
			}
			
			_orderNumberLbl.validate();
			_orderNumberLbl.x = paddingLeft;
			_orderNumberLbl.y = actualHeight/2 - _orderNumberLbl.height/2;
			
			
			_labelLbl.validate();
			_labelLbl.x = _orderNumberLbl.x + _orderNumberLbl.width + gap;
			_labelLbl.y = actualHeight/2 - _labelLbl.height/2;

			_textinput.x = 200;
			_textinput.width = actualWidth - _textinput.x - paddingLeft; 
			_textinput.validate();
			_textinput.y = actualHeight/2 - _textinput.height/2;
		}
	}
}