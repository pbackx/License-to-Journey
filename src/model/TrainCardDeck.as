package model 
{
	import ascb.util.ArrayUtilities;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import model.TrainType;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class TrainCardDeck extends Sprite
	{
		[Embed(source = '../../assets/back.png')]
		private var BackClass:Class;
		private var back:Bitmap = new BackClass();

		private var cardData:Array = new Array(
					new Array(TrainType.LOCOMOTIVE, 14),
					new Array(TrainType.BOX, 12),
					new Array(TrainType.PASSENGER, 12),
					new Array(TrainType.TANKER, 12),
					new Array(TrainType.REEFER, 12),
					new Array(TrainType.FREIGHT, 12),
					new Array(TrainType.HOPPER, 12),
					new Array(TrainType.COAL, 12),
					new Array(TrainType.CABOOSE, 12)
				);

		private var cards:Array = new Array();
		private var discardedCards:Array = new Array();
		private var displayed:Array = new Array();
		private var board:Board;
		
		public function TrainCardDeck(b:Board) 
		{
			this.board = b;
			addChild(back);
			
			for (var i:Number = 0; i < cardData.length; i++) {
				var data:Array = cardData[i];
				for (var j:Number = 0; j < data[1]; j++) {
					cards.push(new TrainCard(data[0]));
				}
			}
			
			shuffle();
			
			deal5();
		}
		
		public function returnCards(type:String, number:int):void {
			for (var i:int = 0; i < number; i++) {
				discardedCards.push(new TrainCard(TrainType.fromString(type)));
			}
		}
		
		private function shuffle():void
		{
			var shuffled:Array = ArrayUtilities.randomize(cards);
			for (var i:Number = 0; i < shuffled.length; i++) {
				cards[i] = shuffled[i];
			}
		}

		public function draw():TrainCard {
			if (cards.length == 0) {
				for (var j:Number = 0; j < discardedCards.length; j++) {
					cards.push(discardedCards.shift());
				}
				shuffle();
			}
			if (cards.length > 0) {
				return cards.shift();
			} else {
				return null;
			}
		}
		
		public function take(card:TrainCard):void {
			var i:Number;
			for (i = 0; i < displayed.length; i++) {
				if (displayed[i] == card) {
					break;
				}
			}
			var y:Number = card.y;
			removeChild(card);
			
			var newCard:TrainCard = draw();
			newCard.y = y;
			displayed[i] = newCard;
			addChild(displayed[i]);
			verifyLocomotives();
		}
		
		private function deal5():void {
			for (var i:Number = 0; i < 5 ; i++) {
				var card:TrainCard = draw();
				card.y = 70 + i*70;
				addChild(card);
				displayed.push(card);
			}
			verifyLocomotives();
		}
		
		private function verifyLocomotives():void {
			var count:Number = 0;
			for (var i:Number = 0; i < displayed.length; i++) {
				if (displayed[i].type == TrainType.LOCOMOTIVE) {
					count ++;
				}
			}
			if (count >= 3) {
				board.logMessage("3 locomotives, redealing cards");
				for (i = 0; i < displayed.length; i++) {
					var card:TrainCard = displayed[i];
					discardedCards.push(card);
					removeChild(card);
				}
				displayed = new Array();
				deal5();
			}
		}
	}

}