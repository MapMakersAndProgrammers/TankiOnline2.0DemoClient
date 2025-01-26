package package_113
{
   import package_76.name_235;
   import package_92.name_271;
   
   public class name_685
   {
      private static var poolSize:int;
      
      private static var pool:Vector.<name_685> = new Vector.<name_685>();
      
      public var body:name_271;
      
      public var simplePrimitives:Vector.<name_235>;
      
      public var detailedPrimitives:Vector.<name_235>;
      
      public var index:int;
      
      public var i:int;
      
      public var j:int;
      
      public var k:int;
      
      public var timestamp:int;
      
      public function name_685()
      {
         super();
      }
      
      public static function create() : name_685
      {
         if(poolSize == 0)
         {
            return new name_685();
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

