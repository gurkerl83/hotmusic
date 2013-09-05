package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.component.DateField;
	import cz.hotmusic.lib.model.AddArtist;
	import cz.hotmusic.lib.model.Genre;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class AddArtistRenderer extends DefaultListItemRenderer
	{
		public function AddArtistRenderer()
		{
			super();
		}
		
		private var _rejectBg:Quad;
		private var _acceptBg:Quad;
		private var _rejectButton:Button;
		private var _acceptButton:Button;
		private var _dateField:DateField;
		
		private var addArtist:AddArtist;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			addArtist = AddArtist(value);
			
			if (addArtist == null)
				return;
			
			if (_dateField && addArtist)
				_dateField.date = addArtist.addedDate;
			
			if (addArtist.state == AddArtist.WAITING_STATE) {
				_rejectButton.visible = _acceptButton.visible = true;
				_rejectBg.visible = _acceptBg.visible = false;
				
			} else if (addArtist.state == AddArtist.ADDED_STATE) {
				_rejectButton.visible = _rejectBg.visible = true;
				_acceptButton.visible = _acceptBg.visible = false;
				
			} else if (addArtist.state == AddArtist.REJECTED_STATE) {
				_rejectButton.visible = _rejectBg.visible = false;
				_acceptButton.visible = _acceptBg.visible = true;
			}
			
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_rejectBg = new Quad(1,1,0x9EBEA4);
			_acceptBg = new Quad(1,1,0xCB9799);
			_rejectBg.visible = _acceptBg.visible = false;
			
			_rejectButton = new Button(Texture.fromBitmap(new FontAssets.Delete()));
			_rejectButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				e.stopImmediatePropagation();
				dispatchEventWith("reject", true);
			});
			
			_dateField = new DateField();
			
			_acceptButton = new Button(Texture.fromBitmap(new FontAssets.Check()));
			_acceptButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				e.stopImmediatePropagation();
				dispatchEventWith("accept", true);
			});
			
			addChild(_rejectBg);
			addChild(_acceptBg);
			addChild(_rejectButton);
			addChild(_dateField);
			addChild(_acceptButton);
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			
			_rejectBg.width = _acceptBg.width = actualWidth;
			_rejectBg.height = _acceptBg.height = actualHeight;
			
			if (_rejectButton.y == 0) {
				_rejectButton.y = actualHeight/2 - _rejectButton.height/2;
//				trace("deleteButton.y = " + _deleteButton.y);
			}
			if (_rejectButton.x == 0) {
				_rejectButton.x = actualWidth - _rejectButton.width - _rejectButton.y ;
//				trace("deleteButton.x = " + _deleteButton.x);
			}
			
			_dateField.validate();
			_dateField.x = _rejectButton.x - gap - _dateField.width;
			_dateField.y = actualHeight/2 - _dateField.height/2;
			
			if (_acceptButton.y == 0) {
				_acceptButton.y = actualHeight/2 - _acceptButton.height/2;
				//				trace("deleteButton.y = " + _deleteButton.y);
			}
			if (_acceptButton.x == 0) {
				_acceptButton.x = _dateField.x - gap - _acceptButton.width;
				//				trace("deleteButton.x = " + _deleteButton.x);
			}
			
			
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}