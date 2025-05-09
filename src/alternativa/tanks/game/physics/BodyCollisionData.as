package alternativa.tanks.game.physics
{
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionPrimitive;
   
   public class BodyCollisionData
   {
      public var body:Body;
      
      public var simplePrimitives:Vector.<CollisionPrimitive>;
      
      public var detailedPrimitives:Vector.<CollisionPrimitive>;
      
      public function BodyCollisionData(body:Body, simplePrimitives:Vector.<CollisionPrimitive>, detailedPrimitives:Vector.<CollisionPrimitive>)
      {
         super();
         this.body = body;
         this.simplePrimitives = simplePrimitives;
         this.detailedPrimitives = detailedPrimitives;
      }
   }
}

