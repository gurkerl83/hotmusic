package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.lib.model.Genre;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class GenreRenderer extends DefaultListItemRenderer
	{
		public function GenreRenderer()
		{
			super();
		}
		
//		private var _nameLabel:Label;
		private var _deleteButton:Button;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
//			var g:Genre = Genre(value);
//			_nameLabel.text = g.name;
//			labelTextRenderer.text = g.name;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
//			_nameLabel = new Label();
			_deleteButton = new Button(Texture.fromBitmap(new FontAssets.Delete()));
			_deleteButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				e.stopImmediatePropagation();
				dispatchEventWith("delete", true);
			});
			
//			addChild(_nameLabel);
			addChild(_deleteButton);
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			
			if (_deleteButton.y == 0)
				_deleteButton.y = actualHeight/2 - _deleteButton.height/2;
			if (_deleteButton.x == 0)
				_deleteButton.x = actualWidth - _deleteButton.width - _deleteButton.y ;
		}
	}
}