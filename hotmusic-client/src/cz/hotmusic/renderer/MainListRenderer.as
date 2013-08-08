package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	import cz.hotmusic.model.Song;
	import cz.zc.mylib.helper.DateHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import flash.desktop.Icon;
	import flash.display.Bitmap;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;

	public class MainListRenderer extends DefaultListItemRenderer
	{
		
		protected var artistTextRenderer:Label;
		protected var hotIcon1:Image;
		protected var hotIcon2:Image;
		protected var hotIcon3:Image;
		
		public function MainListRenderer()
		{
			super();
			
//			this.horizontalAlign = HORIZONTAL_ALIGN_LEFT;
		}
		
		protected function createHotIcons():void
		{
			var hst:Texture = Texture.fromBitmap(new FontAssets.HotStatusSmall());
			hotIcon1 = new Image(hst);
			hotIcon2 = new Image(hst);
			hotIcon3 = new Image(hst);
			this.addChild(DisplayObject(hotIcon1));
			this.addChild(DisplayObject(hotIcon2));
			this.addChild(DisplayObject(hotIcon3));
		}
		
		protected function createMessage():void
		{
			if(this.artistTextRenderer)
			{
				this.removeChild(DisplayObject(this.artistTextRenderer), true);
				this.artistTextRenderer = null;
			}
			
//			const factory:Function = FeathersControl.defaultTextRendererFactory;
//			this.messageTextRenderer = ITextRenderer(factory());
//			this.messageTextRenderer.nameList.add(this.labelName);
			this.artistTextRenderer = new Label();
			this.addChild(DisplayObject(this.artistTextRenderer));
		}
		
		private function showHotIcons(value:Number):void
		{
			if (value == 1) {
				hotIcon1.visible = true;
				hotIcon2.visible = false;
				hotIcon3.visible = false;
			}
			else if (value == 2) {
				hotIcon1.visible = true;
				hotIcon2.visible = true;
				hotIcon3.visible = false;
			}
			else if (value == 3) {
				hotIcon1.visible = true;
				hotIcon2.visible = true;
				hotIcon3.visible = true;
			}
			else {
				hotIcon1.visible = false;
				hotIcon2.visible = false;
				hotIcon3.visible = false;
			}
				
		}
		
		/* OVERRIDE */
		override public function set data(value:Object):void
		{
			var song:Song = Song(value);
			super.data = song;
			
			if(artistTextRenderer && song) {
				artistTextRenderer.text = song.artist.name;
				this.invalidate(INVALIDATION_FLAG_DATA);
			}
			if (song)
			{
				showHotIcons(song.hotstatus);
			}
		}
		
		override protected function draw():void
		{
			super.draw();
			
//			this.createMessage();
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			
			if(artistTextRenderer) {
				labelTextRenderer.y = labelTextRenderer.y - 15;
				artistTextRenderer.y = labelTextRenderer.y + labelTextRenderer.height;
				artistTextRenderer.x = labelTextRenderer.x; 
			}
			accessoryLabel.y = accessoryLabel.y - 15;
			
			hotIcon1.x = actualWidth - paddingRight - hotIcon1.width;  
			hotIcon1.y = accessoryLabel.y + accessoryLabel.height + 10;
			hotIcon2.x = actualWidth - paddingRight - 2*hotIcon1.width;  
			hotIcon2.y = accessoryLabel.y + accessoryLabel.height + 10;
			hotIcon3.x = actualWidth - paddingRight - 3*hotIcon1.width;  
			hotIcon3.y = accessoryLabel.y + accessoryLabel.height + 10;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.createMessage();
			this.createHotIcons();
		}
		
	}
}