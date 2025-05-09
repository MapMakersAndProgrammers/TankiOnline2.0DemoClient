package alternativa.tanks.game.entities.tank.graphics
{
   public class MaterialType
   {
      public static const NORMAL:MaterialType = new MaterialType("NORMAL");
      
      public static const ACTIVATING:MaterialType = new MaterialType("ACTIVATING");
      
      public static const DEAD:MaterialType = new MaterialType("DEAD");
      
      private var stringValue:String;
      
      public function MaterialType(stringValue:String)
      {
         super();
         this.stringValue = stringValue;
      }
      
      public function toString() : String
      {
         return this.stringValue;
      }
   }
}

