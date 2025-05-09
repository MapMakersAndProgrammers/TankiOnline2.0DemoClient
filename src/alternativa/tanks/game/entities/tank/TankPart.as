package alternativa.tanks.game.entities.tank
{
   import alternativa.engine3d.resources.Geometry;
   import alternativa.utils.ByteArrayMap;
   
   public class TankPart
   {
      public var id:String;
      
      public var geometry:Geometry;
      
      public var textureData:ByteArrayMap = new ByteArrayMap();
      
      public function TankPart()
      {
         super();
      }
   }
}

