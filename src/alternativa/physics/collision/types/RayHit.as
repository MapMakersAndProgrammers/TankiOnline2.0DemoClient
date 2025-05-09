package alternativa.physics.collision.types
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionPrimitive;
   
   public class RayHit
   {
      public var t:Number = 0;
      
      public var position:Vector3 = new Vector3();
      
      public var normal:Vector3 = new Vector3();
      
      public var primitive:CollisionPrimitive;
      
      public function RayHit()
      {
         super();
      }
      
      public function copy(source:RayHit) : void
      {
         this.t = source.t;
         this.position.copy(source.position);
         this.normal.copy(source.normal);
         this.primitive = source.primitive;
      }
   }
}

