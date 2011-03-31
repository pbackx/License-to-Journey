package model 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class TrainCard extends Sprite
	{

		public var type:TrainType;
					
		public function TrainCard(type:TrainType) {
			this.type = type;
			addChild(new type.bitmapClass);
			var t:TextField = new TextField();
			t.text = type.toString();
			t.x = 112;
			addChild(t);
		}
		
		public override function toString():String {
			return "[card " + type.toString() + "]";
		}
	}

}