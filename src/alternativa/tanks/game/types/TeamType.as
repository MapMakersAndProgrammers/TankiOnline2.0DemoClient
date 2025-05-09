package alternativa.tanks.game.types
{
   public class TeamType
   {
      public static const NONE:TeamType = new TeamType("NONE");
      
      public static const RED:TeamType = new TeamType("RED");
      
      public static const BLUE:TeamType = new TeamType("BLUE");
      
      private var value:String;
      
      public function TeamType(value:String)
      {
         super();
         this.value = value;
      }
      
      public function toString() : String
      {
         return this.value;
      }
   }
}

