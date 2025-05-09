package alternativa.tanks.game.entities.tank
{
   import alternativa.engine3d.resources.Geometry;
   import alternativa.math.Vector3;
   
   public class TankWheel
   {
      public var name:String;
      
      public var geometry:Geometry;
      
      public var position:Vector3;
      
      public function TankWheel(name:String, geometry:Geometry, position:Vector3)
      {
         super();
         this.name = name;
         this.geometry = geometry;
         this.position = position;
      }
   }
}

