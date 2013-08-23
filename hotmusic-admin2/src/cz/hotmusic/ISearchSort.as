package cz.hotmusic
{
	public interface ISearchSort
	{
		function set page(value:int):void;
		function get page():int;
		function set sort(value:String):void;
		function get sort():String;
		function set search(value:String):void;
		function get search():String;
	}
}