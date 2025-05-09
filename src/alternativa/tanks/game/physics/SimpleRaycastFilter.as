package alternativa.tanks.game.physics
{
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.IRaycastFilter;
   
   public class SimpleRaycastFilter implements IRaycastFilter
   {
      public var body:Body;
      
      public function SimpleRaycastFilter(body:Body = null)
      {
         super();
         this.body = body;
      }
      
      public function acceptRayHit(primitive:CollisionPrimitive) : Boolean
      {
         return this.body != primitive.body;
      }
   }
}

