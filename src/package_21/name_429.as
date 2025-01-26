package package_21
{
   public class name_429
   {
      public static var collector:name_429;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var offset:Number;
      
      public var next:name_429;
      
      public function name_429()
      {
         super();
      }
      
      public static function create() : name_429
      {
         var res:name_429 = null;
         if(collector != null)
         {
            res = collector;
            collector = res.next;
            res.next = null;
            return res;
         }
         return new name_429();
      }
      
      public function create() : name_429
      {
         var res:name_429 = null;
         if(collector != null)
         {
            res = collector;
            collector = res.next;
            res.next = null;
            return res;
         }
         return new name_429();
      }
   }
}

