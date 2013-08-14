package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.component.DateField;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.themes.Theme;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class AlbumRenderer extends DefaultListItemRenderer
	{
		public function AlbumRenderer()
		{
			super();
		}
		
		private var _deleteButton:Button;
		private var _dateField:DateField;
		private var _artistLabel:Label;
		private var _artistValue:Label;
		
		private var album:Album;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			album = Album(value);
			if (_dateField && album)
				_dateField.date = album.addedDate;
			
			if (_artistValue && album && album.artist)
				_artistValue.text = album.artist.name;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_deleteButton = new Button(Texture.fromBitmap(new FontAssets.Delete()));
			_deleteButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				e.stopImmediatePropagation();
				dispatchEventWith("delete", true);
			});
			
			_artistLabel = new Label();
			_artistLabel.name = Theme.SMALL_NORMAL_ORANGE;
			_artistLabel.text = "artist:";
			
			_artistValue = new Label();
			_artistValue.name = Theme.SMALL_NORMAL_BLACK;
			
			_dateField = new DateField();
			
			addChild(_deleteButton);
			addChild(_artistLabel);
			addChild(_artistValue);
			addChild(_dateField);
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			
			if (_deleteButton.y == 0)
				_deleteButton.y = actualHeight/2 - _deleteButton.height/2;
			if (_deleteButton.x == 0)
				_deleteButton.x = actualWidth - _deleteButton.width - _deleteButton.y ;
			
			_artistLabel.validate();
			_artistLabel.y = actualHeight/2 - _artistLabel.height/2;
			_artistLabel.x = 300;

			_artistValue.validate();
			_artistValue.y = actualHeight/2 - _artistValue.height/2;
			_artistValue.x = _artistLabel.x + _artistLabel.width;
			
			_dateField.validate();
			_dateField.x = _deleteButton.x - gap - _dateField.width;
			_dateField.y = actualHeight/2 - _dateField.height/2;
			
			//			if (artist)
			//				 _dateField.date = artist.addedDate;
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}