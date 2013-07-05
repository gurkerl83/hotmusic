package cz.hotmusic
{
	public class FontAssets
	{
		
		[Embed(source="assets/font/MyriadPro/MyriadPro-Regular.otf", fontName="MyriadProRegular", mimeType="application/x-font", embedAsCFF="false")]
		public static var MyriadProRegular:Class;
		[Embed(source="assets/font/MyriadPro/MyriadPro-Bold.otf", fontName="MyriadProBold", mimeType="application/x-font", embedAsCFF="false")]
		public static var MyriadProBold:Class;
		[Embed(source="assets/font/MyriadPro/MyriadPro-Semibold.otf", fontName="MyriadProSemibold", mimeType="application/x-font", embedAsCFF="false")]
		public static var MyriadProSemibold:Class;
		
		[Embed(source="assets/icon/status.png")]
		public static const HotStatus:Class;
		[Embed(source="assets/icon/rateup.png")]
		public static const RateUp:Class;
		[Embed(source="assets/icon/ratedown.png")]
		public static const RateDown:Class;
		[Embed(source="assets/icon/twitter.png")]
		public static const Twitter:Class;
		[Embed(source="assets/icon/facebook.png")]
		public static const Facebook:Class;
		[Embed(source="assets/icon/googleplus.png")]
		public static const GooglePlus:Class;
		[Embed(source="assets/icon/email.png")]
		public static const Email:Class;
		[Embed(source="assets/icon/sms.png")]
		public static const Sms:Class;
		
		[Embed(source="assets/icon/itunes.png")]
		public static const ITunes:Class;
		[Embed(source="assets/icon/googlemusic.png")]
		public static const GoogleMusic:Class;
		[Embed(source="assets/icon/amazon.png")]
		public static const Amazon:Class;
		[Embed(source="assets/icon/beatport.png")]
		public static const Beatport:Class;
		[Embed(source="assets/icon/soundcloud.png")]
		public static const SoundCloud:Class;
		[Embed(source="assets/icon/youtube.png")]
		public static const YouTube:Class;

		[Embed(source="assets/icon/right.png")]
		public static const Right:Class;
		
		public function FontAssets()
		{
		}
	}
}