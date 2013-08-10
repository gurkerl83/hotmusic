package cz.hotmusic.component
{
	import cz.hotmusic.FontAssets;
	import cz.zc.mylib.helper.DateHelper;
	
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import feathers.themes.Theme;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class DateField extends FeathersControl
	{
		public function DateField()
		{
			super();
		}
		
		public function set date(value:Date):void
		{
			_date = value;
			invalidate();
		}
		public function get date():Date
		{
			return _date;
		}
		
		private var _date:Date;
		private var _dateLabel:Label;
		private var _datebg:Image;
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_dateLabel = new Label();
			_dateLabel.name = Theme.TINY_BOLD_WHITE;
			
			_datebg = new Image(Texture.fromBitmap(new FontAssets.DateBG()));
			
			addChild(_datebg);
			addChild(_dateLabel);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var gap:int = 4;
			
			setSize(_datebg.width, _datebg.height);
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_dateLabel.text = DateHelper.formatDateUS(_date);
				_dateLabel.validate();
			}
//			_dateLabel.validate();
			_dateLabel.x = actualWidth/2 - _dateLabel.width/2 - gap;
			_dateLabel.y = actualHeight/2 - _dateLabel.height/2;
			
		}
	}
}