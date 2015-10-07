package app.service
{
	import app.model.IBox;
	import flash.display.Sprite;

	public interface IFactory
	{
		function makeBox(url:String):IBox;
		function addImage(imgURL:String, mRow:int, mColumn:int):Sprite;
	}
}
