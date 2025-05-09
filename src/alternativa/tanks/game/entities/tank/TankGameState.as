package alternativa.tanks.game.entities.tank
{
   public class TankGameState
   {
      public static const PAUSED:TankGameState = new TankGameState("PAUSED");
      
      public static const DEAD:TankGameState = new TankGameState("DEAD");
      
      public static const ACTIVATING:TankGameState = new TankGameState("ACTIVATING");
      
      public static const ACTIVE:TankGameState = new TankGameState("ACTIVE");
      
      public static const IN_RESPAWN:TankGameState = new TankGameState("IN_RESPAWN");
      
      public static const DISABLED:TankGameState = new TankGameState("DISABLED");
      
      private var stringValue:String;
      
      public function TankGameState(code:String)
      {
         super();
         this.stringValue = code;
      }
      
      public function toString() : String
      {
         return this.stringValue;
      }
   }
}

