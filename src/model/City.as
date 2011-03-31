package model 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class City extends Sprite
	{
		public var cityName:String;
		public var position:Point;
		
		public function City(name:String, x:int, y:int) 
		{
			cityName = name;
			position = new Point(x, y);
			graphics.beginFill(0xFF5555);
			graphics.lineStyle(2, 0xFF0000);
			graphics.drawCircle(x, y, 6);
			graphics.endFill();
		}
		
		public override function toString():String {
			return cityName;
		}
	}

}