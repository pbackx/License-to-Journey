package model 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class Board extends Sprite
	{
		[Embed(source='../../assets/board.jpg')]
		private var BoardClass:Class;
		private var board:Bitmap = new BoardClass();

		private var cityData:Array = new Array(
						new Array("Vancouver", 85, 82),        new Array("Seattle", 83, 125),
						new Array("Portland", 65, 164),        new Array("San Francisco", 55, 318),
						new Array("Los Angeles", 115, 400),    new Array("Calgary", 186, 69),
						new Array("Salt Lake City", 212, 268), new Array("Las Vegas", 166, 354),
						new Array("Phoenix", 209, 404),        new Array("Helena", 266, 171),
						new Array("Denver", 312, 292),         new Array("Santa Fe", 305, 363),
						new Array("El Paso", 303, 434),        new Array("Winnipeg", 362, 77),
						new Array("Duluth", 451, 166),         new Array("Omaha", 428, 239),
						new Array("Kansas City", 444, 279),    new Array("Oklahoma City", 428, 346),
						new Array("Dallas", 444, 416),         new Array("Houston", 476, 448),
						new Array("Sault St. Marie", 549, 116),new Array("Chicago", 547, 215),
						new Array("Saint Louis", 511, 280),    new Array("Little Rock", 498, 350),
						new Array("New Orleans", 549, 436),    new Array("Toronto", 636, 132),
						new Array("Pittsburgh", 650, 204),     new Array("Nashville", 585, 311),
						new Array("Atlanta", 625, 338),        new Array("Montréal", 700, 65),
						new Array("Boston", 755, 110),         new Array("New York", 715, 169),
						new Array("Washington", 721, 238),     new Array("Raleigh", 675, 293),
						new Array("Charleston", 698, 343),     new Array("Miami", 721, 465));
		
		private var connectionsData:Array = new Array(
						new Array("Vancouver", "Calgary", 3, TrainType.LOCOMOTIVE, null),
						new Array("Vancouver", "Seattle", 1, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Seattle", "Calgary", 4, TrainType.LOCOMOTIVE, null),
						new Array("Calgary", "Winnipeg", 6, TrainType.FREIGHT, null),
						new Array("Calgary", "Helena", 4, TrainType.LOCOMOTIVE, null),
						new Array("Seattle", "Helena", 6, TrainType.BOX, null),
						new Array("Seattle", "Portland", 1, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Portland", "San Francisco", 5, TrainType.CABOOSE, TrainType.REEFER),
						new Array("Portland", "Salt Lake City", 6, TrainType.PASSENGER, null),
						new Array("San Francisco", "Los Angeles", 3, TrainType.BOX, TrainType.REEFER),
						new Array("San Francisco", "Salt Lake City", 5, TrainType.TANKER, TrainType.FREIGHT),
						new Array("Los Angeles", "Las Vegas", 2, TrainType.LOCOMOTIVE, null),
						new Array("Los Angeles", "Phoenix", 3, TrainType.LOCOMOTIVE, null),
						new Array("Los Angeles", "El Paso", 6, TrainType.HOPPER, null),
						new Array("Helena", "Winnipeg", 4, TrainType.PASSENGER, null),
						new Array("Helena", "Duluth", 6, TrainType.TANKER, null),
						new Array("Helena", "Omaha", 5, TrainType.COAL, null),
						new Array("Helena", "Denver", 4, TrainType.CABOOSE, null),
						new Array("Helena", "Salt Lake City", 3, TrainType.REEFER, null),
						new Array("Salt Lake City", "Denver", 3, TrainType.COAL, TrainType.BOX),
						new Array("Salt Lake City", "Las Vegas", 3, TrainType.TANKER, null),
						new Array("Phoenix", "Denver", 5, TrainType.FREIGHT, null),
						new Array("Phoenix", "Santa Fe", 3, TrainType.LOCOMOTIVE, null),
						new Array("Phoenix", "El Paso", 3, TrainType.LOCOMOTIVE, null),
						new Array("Winnipeg", "Sault St. Marie", 6, TrainType.LOCOMOTIVE, null),
						new Array("Winnipeg", "Duluth", 4, TrainType.HOPPER, null),
						new Array("Denver", "Omaha", 4, TrainType.REEFER, null),
						new Array("Denver", "Kansas City", 4, TrainType.HOPPER, TrainType.TANKER),
						new Array("Denver", "Oklahoma City", 4, TrainType.COAL, null),
						new Array("Denver", "Santa Fe", 2, TrainType.LOCOMOTIVE, null),
						new Array("Santa Fe", "Oklahoma City", 3, TrainType.PASSENGER, null),
						new Array("Santa Fe", "El Paso", 2, TrainType.LOCOMOTIVE, null),
						new Array("El Paso", "Oklahoma City", 5, TrainType.BOX, null),
						new Array("El Paso", "Dallas", 4, TrainType.COAL, null),
						new Array("El Paso", "Houston", 6, TrainType.CABOOSE, null),
						new Array("Duluth", "Sault St. Marie", 3, TrainType.LOCOMOTIVE, null),
						new Array("Duluth", "Toronto", 6, TrainType.REEFER, null),
						new Array("Duluth", "Chicago", 6, TrainType.COAL, null),
						new Array("Duluth", "Omaha", 2, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Omaha", "Chicago", 4, TrainType.PASSENGER, null),
						new Array("Omaha", "Kansas City", 1, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Kansas City", "Saint Louis", 2, TrainType.PASSENGER, TrainType.REEFER),
						new Array("Kansas City", "Oklahoma City", 2, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Oklahoma City", "Little Rock", 2, TrainType.LOCOMOTIVE, null),
						new Array("Oklahoma City", "Dallas", 2, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Dallas", "Little Rock", 2, TrainType.LOCOMOTIVE, null),
						new Array("Dallas", "Houston", 1, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Houston", "New Orleans", 2, TrainType.LOCOMOTIVE, null),
						new Array("Sault St. Marie", "Montréal", 5, TrainType.HOPPER, null),
						new Array("Sault St. Marie", "Toronto", 2, TrainType.LOCOMOTIVE, null),
						new Array("Chicago", "Toronto", 4, TrainType.FREIGHT, null),
						new Array("Chicago", "Pittsburgh", 3, TrainType.HOPPER, TrainType.TANKER),
						new Array("Chicago", "Saint Louis", 2, TrainType.FREIGHT, TrainType.CABOOSE),
						new Array("Saint Louis", "Pittsburgh", 5, TrainType.CABOOSE, null),
						new Array("Saint Louis", "Nashville", 2, TrainType.LOCOMOTIVE, null),
						new Array("Saint Louis", "Little Rock", 2, TrainType.LOCOMOTIVE, null),
						new Array("Little Rock", "Nashville", 3, TrainType.FREIGHT, null),
						new Array("Little Rock", "New Orleans", 3, TrainType.CABOOSE, null),
						new Array("Montréal", "Boston", 2, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Montréal", "New York", 3, TrainType.PASSENGER, null),
						new Array("Montréal", "Toronto", 3, TrainType.LOCOMOTIVE, null),
						new Array("New York", "Boston", 2, TrainType.BOX, TrainType.COAL),
						new Array("New York", "Washington", 2, TrainType.TANKER, TrainType.HOPPER),
						new Array("New York", "Pittsburgh", 2, TrainType.FREIGHT, TrainType.CABOOSE),
						new Array("Pittsburgh", "Toronto", 2, TrainType.LOCOMOTIVE, null),
						new Array("Pittsburgh", "Washington", 2, TrainType.LOCOMOTIVE, null),
						new Array("Pittsburgh", "Raleigh", 2, TrainType.LOCOMOTIVE, null),
						new Array("Pittsburgh", "Nashville", 4, TrainType.BOX, null),
						new Array("Raleigh", "Washington", 2, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Raleigh", "Charleston", 2, TrainType.LOCOMOTIVE, null),
						new Array("Raleigh", "Atlanta", 2, TrainType.LOCOMOTIVE, TrainType.LOCOMOTIVE),
						new Array("Raleigh", "Nashville", 3, TrainType.HOPPER, null),
						new Array("Atlanta", "Charleston", 2, TrainType.LOCOMOTIVE, null),
						new Array("Atlanta", "Miami", 5, TrainType.PASSENGER, null),
						new Array("Atlanta", "New Orleans", 4, TrainType.BOX, TrainType.TANKER),
						new Array("Atlanta", "Nashville", 1, TrainType.LOCOMOTIVE, null),
						new Array("Miami", "New Orleans", 6, TrainType.COAL, null),
						new Array("Miami", "Charleston", 4, TrainType.REEFER, null)
						);
						
		public var cities:Object = new Object();
		
		public var tickets:DestinationTicketDeck;
		
		private var log:TextField = new TextField();
		
		public var currentPlayer:Player;
		
		public var cards:TrainCardDeck;
		
		public var continueSetupFunction:Function;
		private var turnCallback:Function;
		
		public function Board() 
		{
			addChild(board);
			for (var i:int = 0; i < cityData.length; i++)
			{
				var c:Array = cityData[i];
				var city:City = new City(c[0], c[1], c[2]);
				addChild(city);
				cities[c[0]] = city;
			}
			
			for (i = 0; i < connectionsData.length; i++)
			{
				c = connectionsData[i];
				var connection:Connection = new Connection(cities[c[0]], cities[c[1]], c[2], c[3], c[4]);
				addChild(connection);
				connection.addEventListener(MouseEvent.CLICK, dispatchConnect);
			}
			
			// destinatino tickets stack
			tickets = new DestinationTicketDeck(this);
			addChild(tickets);
			tickets.scaleX = .40;
			tickets.scaleY = .40;
			tickets.x = 800;
			
			log.y = 530;
			log.height = 70;
			log.width = 800;
			addChild(log);
			
			tickets.addEventListener(MouseEvent.CLICK, dispatchTakeDestinationTickets);
			
			// train cards
			cards = new TrainCardDeck(this);
			addChild(cards);
			cards.x = 800;
			cards.y = 150;
			
			cards.addEventListener(MouseEvent.CLICK, dispatchTakeTrainCard);
		}

		public function logMessage(s:String):void
		{
			log.appendText("\n" + s);
			log.scrollV = log.maxScrollV;
		}
		
		public function getRoutes(from:City, to:City):/* list of routes */void
		{
			//calculate all possible routes between 2 cities + annotate with distance & colors
		}

		public function dispatchConnect(e:MouseEvent):void {
			currentPlayer.connect(e);
		}
		
		public function dispatchTakeDestinationTickets(e:MouseEvent):void {
			currentPlayer.takeDestinationTickets(e);
		}
		
		public function dispatchTakeTrainCard(e:MouseEvent):void {
			currentPlayer.takeTrainCard(e);
		}
		
		public function continueSetup():void {
			continueSetupFunction();
		}
		
		public function startTurn(player:Player, turnCallback:Function):void {
			this.currentPlayer = player;
			this.turnCallback = turnCallback;
		}
		
		public function endTurn():void {
			turnCallback();
		}
	}

}