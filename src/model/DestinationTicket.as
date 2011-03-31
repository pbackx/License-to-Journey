package model 
{
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class DestinationTicket
	{
		public var from:City;
		public var to:City;
		public var points:Number;
		
		public function DestinationTicket(data:Array) 
		{
			this.from = data[0];
			this.to = data[1];
			this.points = data[2];
		}
		
		public function toString():String
		{
			return "[" + from.cityName + "->" + to.cityName + ":" + points + "]";
		}
	}

}