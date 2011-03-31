package model 
{
	import com.bit101.components.PushButton;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Peter Backx
	 */
	public class HumanPlayer extends Player
	{
		private var consideredTickets:Array;
		private var buttons:Array = new Array(); //just so we can remove them
		
		public function HumanPlayer(board:Board) 
		{
			super(board);
		}
		
		protected override function showTickets(tickets:Array):void
		{
			this.consideredTickets = tickets;
			var i:Number, b:PushButton;
			for (i = 0; i < tickets.length; i++) {
				b = new PushButton(board, 810, 10 + i * 20, tickets[i].toString());
				b.setSize(150, 20);
				b.toggle = true;
				buttons.push(b);
			}
			b = new PushButton(board, 810, 10 + i * 20, "select", picked);
			buttons.push(b);
		}
		
		private function picked(e:MouseEvent):void {
			var picked:Array = new Array();
			for (var i:Number = 0; i < buttons.length; i++ ) {
				if (buttons[i].selected) {
					for (var j:Number = 0; j < consideredTickets.length; j++) {
						if (consideredTickets[j].toString() == buttons[i].label) {
							picked.push(consideredTickets[j]);
							break;
						}
					}
				}
			}
			
			var minTickets:Number = 1;
			if (gameSetup) {
				minTickets = 2;
			}
			
			if (picked.length < minTickets) {
				return;
			}
			clearButtons();
			pickedTickets(picked);			
		}
		
		private function clearButtons():void {
			for (var i:Number = 0; i < buttons.length; i++ ) {
				board.removeChild(buttons[i]);
			}
			buttons = new Array();
		}
		
		protected override function showConnectionChoices(choices:Array, x:Number, y:Number):void {
			for (var i:int = 0; i < choices.length; i++) {
				var b:PushButton = new PushButton(board, x, y + i*20, choices[i].toString(), clickType);
				buttons.push(b);
			}
		}
		
		private function clickType(e:MouseEvent):void {
			pickedConnectionChoice(e.target.label);
			clearButtons();
		}
	}

}