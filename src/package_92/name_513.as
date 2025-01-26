package package_92
{
   import package_76.name_235;
   
   public class name_513
   {
      private static var poolTop:name_513;
      
      public var primitive:name_235;
      
      public var next:name_513;
      
      public var prev:name_513;
      
      public function name_513(primitive:name_235)
      {
         super();
         this.primitive = primitive;
      }
      
      public static function create(primitive:name_235) : name_513
      {
         var item:name_513 = null;
         if(poolTop == null)
         {
            item = new name_513(primitive);
         }
         else
         {
            item = poolTop;
            item.primitive = primitive;
            poolTop = item.next;
            item.next = null;
         }
         return item;
      }
      
      public static function method_712() : void
      {
         for(var curr:name_513 = poolTop; curr != null; )
         {
            poolTop = curr.next;
            curr.next = null;
            curr = poolTop;
         }
      }
      
      public function dispose() : void
      {
         this.primitive = null;
         this.prev = null;
         this.next = poolTop;
         poolTop = this;
      }
   }
}

