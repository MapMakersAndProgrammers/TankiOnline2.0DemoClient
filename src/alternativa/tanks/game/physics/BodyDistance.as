package alternativa.tanks.game.physics
{
   import alternativa.physics.Body;
   
   public class BodyDistance
   {
      public var body:Body;
      
      public var distance:Number;
      
      public function BodyDistance(body:Body, distance:Number)
      {
         super();
         this.body = body;
         this.distance = distance;
      }
      
      public function toString() : String
      {
         return "[BodyDistance body=" + this.body + ", distance=" + this.distance + "]";
      }
   }
}

