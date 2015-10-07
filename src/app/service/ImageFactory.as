package app.service
{
	import app.model.IBox;
	import app.model.BoxItem;

	import flash.display.Sprite;

	public class ImageFactory implements IFactory
	{
		public function ImageFactory()
		{
		}

		public function makeBox(url:String):IBox
		{
			return new BoxItem(url);
		}

		public function addImage(imgURL:String, mRow:int, mColumn:int):Sprite
		{
			return null;
		}
	}
}
