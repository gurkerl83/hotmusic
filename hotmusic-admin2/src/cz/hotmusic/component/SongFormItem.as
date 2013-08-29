package cz.hotmusic.component
{
	import starling.display.Quad;

	public class SongFormItem extends FormItem
	{
		public function SongFormItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			paddingLeft = 30;
			bg.color = 0x808080;
		}
	}
}