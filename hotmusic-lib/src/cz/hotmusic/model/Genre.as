package cz.hotmusic.model
{
	public class Genre
	{
		public function Genre(name:String=null)
		{
			if (name != null)
				this.name = name;
		}
		
		public var id:String;
		public var objectUUID:String;
		public var name:String;
	}
}