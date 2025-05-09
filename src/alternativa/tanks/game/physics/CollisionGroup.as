package alternativa.tanks.game.physics
{
   public class CollisionGroup
   {
      public static const STATIC:int = 1;
      
      public static const TANK:int = 1 << 1;
      
      public static const WEAPON:int = 1 << 2;
      
      public function CollisionGroup()
      {
         super();
      }
   }
}

