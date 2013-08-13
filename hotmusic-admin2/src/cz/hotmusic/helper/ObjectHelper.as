package cz.hotmusic.helper
{
	public class ObjectHelper
	{
		public function ObjectHelper()
		{
		}
		
		public static function getId(o:Object):String
		{
			var memoryHash:String;
			try
			{
				FakeClass(o);
			}
			catch (e:Error)
			{
				memoryHash = String(e).replace(/.*([@|\$].*?) to .*$/gi, '$1');
			}
			
			return memoryHash;
			
		}
	}
}
		internal final class FakeClass { }