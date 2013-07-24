package cz.hotmusic.renderer
{
	import cz.hotmusic.FontAssets;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import flash.desktop.Icon;
	import flash.display.Bitmap;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class RightListRenderer extends DefaultGroupedListItemRenderer
	{
		
		protected var leftGrayImg:Image;
		protected var leftOrangeImg:Image;
		private var showLeftImg:Boolean;
		protected var rightGrayImg:Image;
		protected var rightOrangeImg:Image;
		private var showRightImg:Boolean;
		protected var pipe:Image;
		
		public function RightListRenderer()
		{
			super();
		}
		
		protected function createLeftImg(normalImg:Image, selectedImg:Image):void
		{
			leftGrayImg = normalImg;
			leftOrangeImg = selectedImg;
			
			this.addChild(leftGrayImg);
			this.addChild(leftOrangeImg);
		}

		protected function createRightImg(normalImg:Image, selectedImg:Image):void
		{
			rightGrayImg = normalImg;
			rightOrangeImg = selectedImg;
			
			this.addChild(rightGrayImg);
			this.addChild(rightOrangeImg);
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
			if (value == null)
				return;
			
			if (value.leftNormalImg && value.leftSelectedImg)
			{
				if (leftGrayImg && leftGrayImg != value.leftNormalImg)
					removeChild(leftGrayImg);
				if (leftOrangeImg && leftOrangeImg != value.leftNormalImg)
					removeChild(leftOrangeImg);
				createLeftImg(value.leftNormalImg, value.leftSelectedImg);
			} else {
				removeChild(leftGrayImg);
				removeChild(leftOrangeImg);
				leftGrayImg = leftOrangeImg = null;
			}
			
			if (value.rightNormalImg && value.rightSelectedImg)
			{
				if (rightGrayImg && rightGrayImg != value.rightNormalImg)
					removeChild(rightGrayImg);
				if (rightOrangeImg && rightOrangeImg != value.rightNormalImg)
					removeChild(rightOrangeImg);
				createRightImg(value.rightNormalImg, value.rightSelectedImg);
			} else {
				removeChild(rightGrayImg);
				removeChild(rightOrangeImg);
				rightGrayImg = rightOrangeImg = null;
			}
		}
		
		override protected function draw():void
		{
			super.draw();
		}
		
		override protected function layoutContent():void
		{
			super.layoutContent();
//			labelTextRenderer.x = labelTextRenderer.x + 70;
			
			pipe.x = actualWidth - pipe.width - 25;
			pipe.y = actualHeight/2 - pipe.height/2;
			
			if (leftGrayImg && leftOrangeImg) 
			{
				leftGrayImg.x = leftOrangeImg.x = paddingLeft;
				leftGrayImg.y = leftOrangeImg.y = actualHeight/2 - leftGrayImg.height/2;
				labelTextRenderer.x = leftGrayImg.x + leftGrayImg.width + gap;
			}

			if (rightGrayImg && rightOrangeImg) 
			{
				rightGrayImg.x = rightOrangeImg.x = labelTextRenderer.x + labelTextRenderer.width + gap;
				rightGrayImg.y = rightOrangeImg.y = actualHeight/2 - rightGrayImg.height/2;
			}
			
		}
		
		override protected function initialize():void
		{
			super.initialize();
			createPipe();
//			createLeftImg();
			//			height = height - 6;
		}
		
		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			if (isSelected) {
				pipe.visible = true;
				if (leftGrayImg && leftOrangeImg)
				{
					leftGrayImg.visible = false;
					leftOrangeImg.visible = true;
				}
				if (rightGrayImg && rightOrangeImg)
				{
					rightGrayImg.visible = false;
					rightOrangeImg.visible = true;
				}
			}
			else {
				pipe.visible = false;
				if (leftGrayImg && leftOrangeImg)
				{
					leftGrayImg.visible = true;
					leftOrangeImg.visible = false;
				}
				if (rightGrayImg && rightOrangeImg)
				{
					rightGrayImg.visible = true;
					rightOrangeImg.visible = false;
				}
			}
		}
	}
}