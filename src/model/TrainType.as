package model 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public final class TrainType
	{
		[Embed(source = '../../assets/box.png')]
		private static var BoxClass:Class;
		[Embed(source = '../../assets/caboose.png')]
		private static var CabooseClass:Class;
		[Embed(source = '../../assets/coal.png')]
		private static var CoalClass:Class;
		[Embed(source = '../../assets/freight.png')]
		private static var FreightClass:Class;
		[Embed(source = '../../assets/hopper.png')]
		private static var HopperClass:Class;
		[Embed(source = '../../assets/locomotive.png')]
		private static var LocomotiveClass:Class;
		[Embed(source = '../../assets/passenger.png')]
		private static var PassengerClass:Class;
		[Embed(source = '../../assets/reefer.png')]
		private static var ReeferClass:Class;
		[Embed(source = '../../assets/tanker.png')]
		private static var TankerClass:Class;
		
		public static const BOX:TrainType = new TrainType("Box", 0xFFFF00, BoxClass); //yellow
		public static const PASSENGER:TrainType = new TrainType("Passenger", 0x0000FF, PassengerClass); //blue
		public static const TANKER:TrainType = new TrainType("Tanker", 0x964B00, TankerClass); //orange
		public static const REEFER:TrainType = new TrainType("Reefer", 0xFF00FF, ReeferClass); //purple
		public static const FREIGHT:TrainType = new TrainType("Freight", 0xFFFFFF, FreightClass); //white
		public static const HOPPER:TrainType = new TrainType("Hopper", 0x000000, HopperClass); //black
		public static const COAL:TrainType = new TrainType("Coal", 0xFF0000, CoalClass); //red
		public static const CABOOSE:TrainType = new TrainType("Caboose", 0x00FF00, CabooseClass); //green
		public static const LOCOMOTIVE:TrainType = new TrainType("Locomotive", 0x888888, LocomotiveClass); //gray

		public static const list:Array = [BOX, PASSENGER, TANKER, REEFER, FREIGHT, HOPPER, COAL, CABOOSE, LOCOMOTIVE];
		
		private var description:String;
		public var color:uint;
		public var bitmapClass:Class;
		
		public function TrainType(description:String, color:uint, bitmapClass:Class) 
		{
			this.description = description;
			this.color = color;
			this.bitmapClass = bitmapClass;
		}
		
		public function toString():String
		{
			return description;
		}
		
		public static function fromString(type:String):TrainType {
			for (var i:int = 0; i < list.length; i++) {
				if (list[i].toString() == type) {
					return list[i];
				}
			}
			return null;
		}
	}

}