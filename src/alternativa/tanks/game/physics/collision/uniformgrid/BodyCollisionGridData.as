package alternativa.tanks.game.physics.collision.uniformgrid
{
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionPrimitive;
   
   public class BodyCollisionGridData
   {
      private static var poolSize:int;
      
      private static var pool:Vector.<BodyCollisionGridData> = new Vector.<BodyCollisionGridData>();
      
      public var body:Body;
      
      public var simplePrimitives:Vector.<CollisionPrimitive>;
      
      public var detailedPrimitives:Vector.<CollisionPrimitive>;
      
      public var index:int;
      
      public var i:int;
      
      public var j:int;
      
      public var k:int;
      
      public var timestamp:int;
      
      public function BodyCollisionGridData()
      {
         super();
      }
      
      public static function create() : BodyCollisionGridData
      {
         if(poolSize == 0)
         {
            return new BodyCollisionGridData();
         }
         return pool[--poolSize];
      }
      
      public function destroy() : void
      {
         this.body = null;
         this.simplePrimitives = null;
         this.detailedPrimitives = null;
         var _loc1_:* = poolSize++;
         pool[_loc1_] = this;
      }
   }
}

