package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.component.DateField;
	import cz.hotmusic.model.Artist;
	import cz.hotmusic.model.Genre;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ArtistRenderer extends DefaultListItemRenderer
	{
		public function ArtistRenderer()
		{
			super();
		}
		
		private var _deleteButton:Button;
		private var _dateField:DateField;
		
		private var artist:Artist;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			artist = Artist(value);
			if (_dateField && artist)
				_dateField.date = artist.addedDate;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_deleteButton = new Button(Texture.fromBitmap(new FontAssets.Delete()));
			_deleteButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				e.stopImmediatePropagation();
				dispatchEventWith("delete", true);
			});
			
			_dateField = new DateField();
			
			addChild(_deleteButton);
			addChild(_dateField);
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			
			if (_deleteButton.y == 0) {
				_deleteButton.y = actualHeight/2 - _deleteButton.height/2;
//				trace("deleteButton.y = " + _deleteButton.y);
			}
			if (_deleteButton.x == 0) {
				_deleteButton.x = actualWidth - _deleteButton.width - _deleteButton.y ;
//				trace("deleteButton.x = " + _deleteButton.x);
			}
			
			_dateField.validate();
			_dateField.x = _deleteButton.x - gap - _dateField.width;
			_dateField.y = actualHeight/2 - _dateField.height/2;
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}