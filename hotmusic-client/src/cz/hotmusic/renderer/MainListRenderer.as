package cz.hotmusic.renderer
{
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import starling.display.DisplayObject;

	public class MainListRenderer extends DefaultListItemRenderer
	{
		
		protected var messageTextRenderer:Label;
		
		public function MainListRenderer()
		{
			super();
			
//			this.horizontalAlign = HORIZONTAL_ALIGN_LEFT;
		}
		
		protected function createMessage():void
		{
			if(this.messageTextRenderer)
			{
				this.removeChild(DisplayObject(this.messageTextRenderer), true);
				this.messageTextRenderer = null;
			}
			
//			const factory:Function = FeathersControl.defaultTextRendererFactory;
//			this.messageTextRenderer = ITextRenderer(factory());
//			this.messageTextRenderer.nameList.add(this.labelName);
			this.messageTextRenderer = new Label();
			this.addChild(DisplayObject(this.messageTextRenderer));
		}
		
		/* OVERRIDE */
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(messageTextRenderer && value) {
				messageTextRenderer.text = value.artist;
				this.invalidate(INVALIDATION_FLAG_DATA);
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
			
			if(messageTextRenderer) {
				labelTextRenderer.y = labelTextRenderer.y - 15;
				messageTextRenderer.y = labelTextRenderer.y + labelTextRenderer.height;
				messageTextRenderer.x = labelTextRenderer.x; 
			}
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.createMessage();
		}
		
	}
}