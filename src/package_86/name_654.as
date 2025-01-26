package package_86
{
   import package_92.name_271;
   
   public class name_654
   {
      public var body:name_271;
      
      public var distance:Number;
      
      public function name_654(body:name_271, distance:Number)
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

