package app.view
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class GalleryView extends Sprite
	{
		private var bg:Shape;

		public function GalleryView()
		{
		}

		public function addImage(image:Sprite, tX:Number, tY:Number):void
		{
			image.x = tX;
			image.y = tY;
			this.addChild(image);
		}

		public function drawBackground():void
		{
			bg = new Shape();
			bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(bg);
			bg.visible = false;
		}

	}
}
