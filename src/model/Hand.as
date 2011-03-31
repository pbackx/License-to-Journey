package model 
{
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class Hand
	{
		private var sorted:Object = new Object();
		private var cards:TrainCardDeck;
		
		public function Hand(cards:TrainCardDeck) {
			this.cards = cards;
		}
		
		public function addCard(card:TrainCard):void {
			var count:Number = 1;
			var o:Object = sorted[card.type];
			if (o != null) {
				count = o as Number;
				count ++;
			}
			sorted[card.type] = count;
		}
		
		private function number(t:String):Number {
			var n:Number = sorted[t];
			if (isNaN(n)) {
				return 0;
			} else {
				return n;
			}
		}

		public function hasCards(type:TrainType, number:Number):Boolean {
			if (type == TrainType.LOCOMOTIVE) {
				var locs:Number = this.number(TrainType.LOCOMOTIVE.toString());
				if (locs >= number) return true;
				for (var t:String in sorted) {
					if (t != TrainType.LOCOMOTIVE.toString()) {
						var inhand:Number = locs + this.number(t);
						if (inhand >= number) return true;
					}
				}
				return false;
			} else {
				inhand = this.number(type.toString()) + this.number(TrainType.LOCOMOTIVE.toString());
				return inhand >= number;
			}
		}
		
		public function removeCards(type:String, number:Number):void {
			var ct:Number = this.number(type);
			if (ct >= number) {
				ct = ct - number;
				sorted[type] = ct;
				cards.returnCards(type, number);
			} else {
				cards.returnCards(type, sorted[type]);
				sorted[type] = 0;

				number = number - ct;
				var lt:Number = this.number(TrainType.LOCOMOTIVE.toString());
				lt = lt - number;
				sorted[TrainType.LOCOMOTIVE] = lt;
				cards.returnCards(TrainType.LOCOMOTIVE.toString(), number);
			}
		}
		
		public function toString():String {
			var m:String = "hand: ";
			for (var v:String in sorted) {
				m += v + ":" + sorted[v] + ", ";
			}
			return m;
		}
		
	}

}