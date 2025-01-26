package package_92
{
   public class name_671
   {
      private static var poolTop:name_671;
      
      public var body:name_271;
      
      public var next:name_671;
      
      public var prev:name_671;
      
      public function name_671(body:name_271)
      {
         super();
         this.body = body;
      }
      
      public static function create(body:name_271) : name_671
      {
         var item:name_671 = null;
         if(poolTop == null)
         {
            item = new name_671(body);
         }
         else
         {
            item = poolTop;
            poolTop = item.next;
            item.next = null;
            item.body = body;
         }
         return item;
      }
      
      public static function method_712() : void
      {
         for(var item:name_671 = poolTop; item != null; )
         {
            poolTop = item.next;
            item.next = null;
            item = poolTop;
         }
      }
      
      public function dispose() : void
      {
         this.body = null;
         this.prev = null;
         this.next = poolTop;
         poolTop = this;
      }
   }
}

