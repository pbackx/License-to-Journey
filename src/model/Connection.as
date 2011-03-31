package model 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class Connection extends Sprite
	{
		private var from:City;
		private var to:City;
		
		public var type1:TrainType;
		public var used1:Boolean = false;
		public var type2:TrainType;
		public var used2:Boolean = false;
		
		public var length:int;
		
		public function Connection(from:City, to:City, length:int, type1:TrainType, type2:TrainType) 
		{
			this.from = from;
			this.to = to;
			this.length = length;
			this.type1 = type1;
			this.type2 = type2;
			
			var offset:int = 0;
			if (type2 != null)
			{
				offset = 5;
			}
			if (type1 != null)
			{
				graphics.lineStyle(4, type1.color);
				graphics.moveTo(from.position.x+offset, from.position.y+offset);
				graphics.lineTo(to.position.x+offset, to.position.y+offset);
			}
			if (type2 != null)
			{
				graphics.lineStyle(4, type2.color);
				graphics.moveTo(from.position.x-offset, from.position.y-offset);
				graphics.lineTo(to.position.x-offset, to.position.y-offset);
			}
		}
		
		public override function toString():String {
			return "[" + from.toString() + "-" + to.toString() + ":" + type1 + "|" + type2 + ":" + length + "]";
		}
		
		public function connect(type:String, player:String):Number {
			var label:TextField = new TextField();
			label.textColor = 0xFFFFFF;
			label.text = player;

			var x:Number = (from.position.x + to.position.x) / 2;
			var y:Number = (from.position.y + to.position.y) / 2;
			
			var connect1:Boolean = !used1 && (type1.toString() == type || type1 == TrainType.LOCOMOTIVE);
			var connect2:Boolean = type2 != null && (!used2 && (type2.toString() == type || type2 == TrainType.LOCOMOTIVE));
			if (connect1) {
				used1 = true;
				y += 3;
			} else if (connect2) {
				used2 = true;
				x -= 3;
			} else {
				return 0;
			}
			addChild(label);
			label.x = x;
			label.y = y;
			return length;
		}
	}

}