package model 
{
	import ascb.util.ArrayUtilities;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class DestinationTicketDeck extends Sprite
	{
		[Embed(source = '../../assets/ticket.jpg')]
		private var TicketClass:Class;
		private var ticket:Bitmap = new TicketClass();

		private var ticketData:Array = new Array(
				new Array("Boston", "Miami", 12),
				new Array("Calgary", "Phoenix", 13),
				new Array("Calgary", "Salt Lake City", 7),
				new Array("Chicago", "New Orleans",  7),
				new Array("Chicago", "Santa Fe", 9),
				new Array("Dallas", "New York", 11),
				new Array("Denver", "El Paso", 4),
				new Array("Denver", "Pittsburgh", 11),
				new Array("Duluth", "El Paso", 10),
				new Array("Duluth", "Houston", 8),
				new Array("Helena", "Los Angeles", 8),
				new Array("Kansas City", "Houston", 5),
				new Array("Los Angeles", "Chicago", 16),
				new Array("Los Angeles", "New York", 21),
				new Array("Los Angeles", "Miami", 20),
				new Array("Montréal", "Atlanta", 9),
				new Array("Montréal", "New Orleans", 13),
				new Array("New York", "Atlanta", 6),
				new Array("Portland", "Nashville", 17),
				new Array("Portland", "Phoenix", 11),
				new Array("San Francisco", "Atlanta", 17),
				new Array("Sault St. Marie", "Nashville", 8),
				new Array("Sault St. Marie", "Oklahoma City", 9),
				new Array("Seattle", "Los Angeles", 9),
				new Array("Seattle", "New York", 22),
				new Array("Toronto", "Miami", 10),
				new Array("Vancouver", "Montréal", 20),
				new Array("Vancouver", "Santa Fe", 13),
				new Array("Winnipeg", "Houston", 12),
				new Array("Winnipeg", "Little Rock", 11)
			);
		
		private var tickets:Array;
		private var discardedTickets:Array;
		
		public function DestinationTicketDeck(board:Board) 
		{
			// http://code.google.com/p/easyflash/source/browse/ascb/play/Cards.as?spec=svn2e90e4a3e69d4ba05c646bc00402c445bd259aa5&r=2e90e4a3e69d4ba05c646bc00402c445bd259aa5
			addChild(ticket);
			
			tickets = new Array();
			discardedTickets = new Array();
			for (var i:Number = 0; i < ticketData.length; i++)
			{
				var data:Array = ticketData[i];
				data[0] = board.cities[data[0]];
				data[1] = board.cities[data[1]];
				if (data[0] == null || data[1] == null)
					throw new Error("city not found");
				tickets.push(new DestinationTicket(data));
			}
			shuffle();
		}

		private function shuffle():void
		{
			var shuffled:Array = ArrayUtilities.randomize(tickets);
			for (var i:Number = 0; i < shuffled.length; i++) {
				tickets[i] = shuffled[i];
			}
		}
		
		public function draw3():Array {
			var draw:Array = new Array();
			for (var i:Number = 0; i < 3; i++) {
				if (tickets.length == 0) {
					for (var j:Number = 0; j < discardedTickets.length; j++) {
						tickets.push(discardedTickets.shift());
					}
					shuffle();
				}
				if (tickets.length > 0) {
					draw.push(tickets.shift());
				}
			}
			return draw;
		}
		
		public function returnTickets(r:Array): void {
			for (var i:Number = 0; i < r.length; i++) {
				var ticket:DestinationTicket = r[i];
				discardedTickets.push(ticket);
			}
		}
	}

}