package app.view 
{
	import app.model.BoxItem;
	import app.model.IBox;

	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	

	public class ImageView extends Sprite
	{
		private var bmp:Bitmap;
		private var _itemModel:BoxItem;

		public function ImageView(bitmap:Bitmap, model:BoxItem)
		{
			_itemModel = model;
			bmp = bitmap;
			bmp.smoothing = true;
			bmp.pixelSnapping = PixelSnapping.AUTO;
			addChild(bmp);
		}

		public function destroy():void
		{
			_itemModel = null;
			removeChild(bmp);
			bmp = null;
		}

		public function get itemModel():BoxItem
		{
			return _itemModel;
		}
	}
}