package model 
{
	import ascb.util.ArrayUtilities;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class Player
	{
		public var playerName:String;
		protected var gameSetup:Boolean = false; // if we are in the initial setup of the game
		
		public var trainsLeft:int = 45;
		
		private var connections:Array;
		private var connectionUnderConsideration:Connection;
		
		private var destinationTickets:Array = new Array();
		private var destinationTicketsUnderConsideration:Array;
		
		public var hand:Hand;
		
		protected var board:Board;
		
		private var cardQuota:int = 2;
		
		public function Player(board:Board) 
		{
			this.board = board;
			this.hand = new Hand(board.cards);
		}
		
		public function connect(e:MouseEvent):void
		{
			connectionUnderConsideration = e.target as Connection;
			var numberOfChoices:Number = 0;
			var goodChoice:TrainType;
			if (connectionUnderConsideration.type1 != null) {
				if (!connectionUnderConsideration.used1 && hand.hasCards(connectionUnderConsideration.type1, connectionUnderConsideration.length)) {
					numberOfChoices++;
					goodChoice = connectionUnderConsideration.type1;
				}
			}
			if (!connectionUnderConsideration.used2 && connectionUnderConsideration.type2 != null && !(connectionUnderConsideration.type1 == TrainType.LOCOMOTIVE)) {
				if (hand.hasCards(connectionUnderConsideration.type2, connectionUnderConsideration.length)) {
					numberOfChoices++;
					goodChoice = connectionUnderConsideration.type2;
				}				
			}
			if (numberOfChoices == 0) {
				board.logMessage("cannot connect " + connectionUnderConsideration);
				return;
			} else if (numberOfChoices == 1) {
				if (goodChoice == TrainType.LOCOMOTIVE) {
					var choices:Array = createHandOptions(connectionUnderConsideration.length);
					if (choices.length == 1) {
						doConnection(choices[0]);
					} else {
						showConnectionChoices(choices, e.stageX, e.stageY);
					}
				} else {
					doConnection(goodChoice.toString());
				}
			} else {
				var choices:Array = [connectionUnderConsideration.type1, connectionUnderConsideration.type2];
				showConnectionChoices(choices, e.stageX, e.stageY);
			}
		}
		
		protected function showConnectionChoices(choices:Array, x:Number, y:Number):void {
			throw new Error("please implement showConnectionChoices in your implementation of Player. It should callback pickedConnectionChoice to continue the game");
		}
		
		protected function pickedConnectionChoice(type:String):void {
			doConnection(type);
		}
		
		private function doConnection(type:String):void {
			var rem:Number = connectionUnderConsideration.connect(type, playerName);
			hand.removeCards(type, rem);
			trainsLeft -= rem;
			board.logMessage("hand reduced to: " + hand.toString() + " | trains left: " + trainsLeft);
			
			board.endTurn();
		}
		
		public function takeTrainCard(e:MouseEvent):void
		{
			var card:TrainCard;
			if (e.target is TrainCardDeck) {
				card = board.cards.draw();
				cardQuota--;
			} else {
				card = e.target as TrainCard;
				board.cards.take(card);
				if (card.type == TrainType.LOCOMOTIVE) {
					cardQuota -= 2;
				} else {
					cardQuota--;
				}
			}
			hand.addCard(card);
			board.logMessage(hand.toString());
			if (cardQuota == 0) {
				cardQuota = 2;
				board.endTurn();
			}
		}
		
		public function takeDestinationTickets(e:MouseEvent):void 
		{
			var t:Array = board.tickets.draw3();
			gameSetup = e == null;
			destinationTicketsUnderConsideration = ArrayUtilities.duplicate(t) as Array;
			showTickets(t);
		}
		
		protected function showTickets(l:Array):void {
			throw new Error("please implement showTickets in your extension of Player. It should callback pickedTickets to continue the game.");
		}
		
		protected function pickedTickets(picked:Array):void {
			for (var i:Number = 0; i < picked.length; i++) {
				var index:Number = destinationTicketsUnderConsideration.indexOf(picked[i]);
				destinationTickets.push(picked[i]);
				destinationTicketsUnderConsideration.splice(index, 1);
			}
			var m:String = "in hand: ";
			for (i = 0; i < destinationTickets.length; i++) {
				m += destinationTickets[i].toString();
			}
			board.logMessage(m);
			board.tickets.returnTickets(destinationTicketsUnderConsideration);
			destinationTicketsUnderConsideration = null;
			
			if (gameSetup) {
				board.continueSetup();
			} else {
				board.endTurn();
			}
		}
		
		private function createHandOptions(length:int):Array {
			// create a list of possibilities to make a length connection
			var choices:Array = new Array();
			for (var i:int = 0; i < TrainType.list.length; i++) {
				if (TrainType.list[i] != TrainType.LOCOMOTIVE) {
					if (hand.hasCards(TrainType.list[i], length)) {
						choices.push(TrainType.list[i]);
					}
				}
			}
			return choices;
		}
		
		public function tickets():String {
			var m:String = "";
			for (var i:int = 0; i < destinationTickets.length; i++) {
				m += destinationTickets[i].toString();
			}
			return m;
		}
	}
}