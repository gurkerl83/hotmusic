package cz.hotmusic.helper
{
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	
	import flash.text.TextFormat;

	public class TextHelper
	{
		public function TextHelper()
		{
		}
		
		public static var _instance:TextHelper;
		public static function getInstance():TextHelper
		{
			if (_instance == null)
				_instance = new TextHelper();
			return _instance;
		}
		
		public function detailSongValue():ITextRenderer
		{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = new TextFormat("MyriadProSemibold", 60, 0xF19300);
			textRenderer.embedFonts = true;
			return textRenderer;
		}
		public function detailOtherValue():ITextRenderer
		{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = new TextFormat("MyriadProSemibold", 34, 0xc8c8c8);
			textRenderer.embedFonts = true;
			return textRenderer;
		}
		public function detailLinks():ITextRenderer
		{
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = new TextFormat("MyriadProRegular", 34, 0x7A787A);
			textRenderer.embedFonts = true;
			return textRenderer;
		}
	}
}