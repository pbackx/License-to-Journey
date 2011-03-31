package 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.Board;
	import model.HumanPlayer;
	import model.Player;
	
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class Main extends Sprite 
	{
		private var board:Board;
		private var players:Array = new Array();
		private var currentPlayer:int = -1;
		private var turnsLeft:int = -1;
		
		private var playerNames:Array = ["player 1", "player 2", "player 3", "player 4"];
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			board = new Board();
			addChild(board);
			
			var name:String = playerNames.shift();
			addPlayer(name, continueSetup);
		}
		
		private function continueSetup():void {
			if(playerNames.length > 0) {
				var name:String = playerNames.shift();
				addPlayer(name, continueSetup);
			} else {
				nextTurn();
			}
		}
		
		public function addPlayer(name:String, continueSetupFunction:Function):void {
			board.continueSetupFunction = continueSetupFunction;
			var player:Player = new HumanPlayer(board);
			player.playerName = name;
			for (var i:Number = 0; i < 4; i++) {
				player.hand.addCard(board.cards.draw());
			}
			board.logMessage(name + player.hand);
			player.takeDestinationTickets(null);
			players.push(player);
		}
		
		public function nextTurn():void {
			if (turnsLeft != -1) {
				turnsLeft--;
				if (turnsLeft == 0) {
					board.logMessage("game over");
					return;
				}
			} else {
				var previousPlayer:Player = players[currentPlayer];
				if (previousPlayer != null && previousPlayer.trainsLeft <= 2) {
					turnsLeft = players.length;
					board.logMessage("last turn for all players");
				}
			}
			
			currentPlayer++;
			if (currentPlayer >= players.length) {
				currentPlayer = 0;
			}
			var cp:Player = players[currentPlayer];
			board.logMessage(cp.playerName + " | trains left: " + cp.trainsLeft);
			board.logMessage(cp.hand.toString());
			board.logMessage(cp.tickets());
			board.startTurn(cp, nextTurn);
		}
	}
	
}