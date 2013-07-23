package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	
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

	public class LeftListRenderer extends DefaultListItemRenderer
	{
		
		protected var badgeYellow:Image;
		protected var badgeGray:Image;
		private var badgeLabel:Label;
		private var showBadge:Boolean;
		protected var pipe:Image;
		
		public function LeftListRenderer()
		{
			super();
//			isSelectableWithoutToggle = false;
//			isToggle = false;
//			this.horizontalAlign = HORIZONTAL_ALIGN_LEFT;
		}
		
		protected function createBadge():void
		{
			var hst:Texture = Texture.fromBitmap(new FontAssets.BadgeGray());
			badgeGray = new Image(hst);
			var hst:Texture = Texture.fromBitmap(new FontAssets.BadgeYellow());
			badgeYellow = new Image(hst);
			badgeLabel = new Label();
			badgeLabel.name = "badgeLabel";
			
			this.addChild(DisplayObject(badgeGray));
			this.addChild(DisplayObject(badgeYellow));
			this.addChild(DisplayObject(badgeLabel));
		}
		
		protected function createPipe():void 
		{
			pipe = new Image(Texture.fromBitmap(new FontAssets.Pipe()));
			pipe.visible = false;
			this.addChild(pipe);
		}
		
		/* OVERRIDE */
		override public function set data(value:Object):void
		{
			super.data = value;
			if (value == null || !(value.count > 0)) {
				showBadge = false;
//				isToggle = false;
			}
			else {
				showBadge = true;
				badgeLabel.text = value.count;
//				isToggle = true;
			}
		}
		
		override protected function draw():void
		{
			super.draw();
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
			labelTextRenderer.x = labelTextRenderer.x + 70;
			
			pipe.x = actualWidth - pipe.width - 25;
			pipe.y = actualHeight/2 - pipe.height/2;
			
			badgeGray.x = badgeYellow.x = paddingLeft;
			badgeGray.y = badgeYellow.y = actualHeight/2 - badgeGray.height/2;
			
			badgeLabel.validate();
			badgeLabel.x = badgeGray.x + badgeGray.width/2 - badgeLabel.width/2 - 1;
			badgeLabel.y = actualHeight/2 - badgeLabel.height/2;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			createPipe();
			createBadge();
//			height = height - 6;
		}
		
		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			if (isSelected) {
				pipe.visible = true;
				badgeGray.visible = false;
				badgeYellow.visible = showBadge ? true:false;
				badgeLabel.visible = showBadge ? true:false;
			}
			else {
				pipe.visible = false;
				badgeGray.visible = showBadge ? true:false;
				badgeYellow.visible = false;
				badgeLabel.visible = showBadge ? true:false;
			}
		}
	}
}