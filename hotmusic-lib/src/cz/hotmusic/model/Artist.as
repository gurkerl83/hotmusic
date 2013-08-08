package cz.hotmusic.model
{
	public class Artist
	{
		public function Artist(name:String=null)
		{
			if (name != null)
				this.name = name;
		}
		
		public var id:String;
		public var name:String;
	}
}