package alternativa.tanks.game.weapons
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   
   public class WeaponHit
   {
      public var distance:Number;
      
      public var body:Body;
      
      public var position:Vector3 = new Vector3();
      
      public var direction:Vector3 = new Vector3();
      
      public var normal:Vector3 = new Vector3();
      
      public function WeaponHit()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[WeaponHit distance=" + this.distance + ", body=" + this.body + ", position=" + this.position + ", direction=" + this.direction + ", normal=" + this.normal + "]";
      }
   }
}

