package app.model
{
	import app.view.ImageView;

	import flash.display.DisplayObject;

	public interface IBox
	{
		function addImage(img:ImageView):void
		function get columnIndex():int;
		function set columnIndex(value:int):void;
		function get index():int;
		function set index(value:int):void;
		function get imageURL():String
		function get width():int;
		function set width(n:int):void;
		function get height():int;
		function set height(n:int):void;
		function get originalWidth():int;
		function get originalHeight():int;
		function get aspectRatio():Number;
		function get displayObject():DisplayObject;
		function resetSize():void
		function destroy():void
	}
}
