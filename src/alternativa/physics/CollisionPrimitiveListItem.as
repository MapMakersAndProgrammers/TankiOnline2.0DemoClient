package alternativa.physics
{
   import alternativa.physics.collision.CollisionPrimitive;
   
   public class CollisionPrimitiveListItem
   {
      private static var poolTop:CollisionPrimitiveListItem;
      
      public var primitive:CollisionPrimitive;
      
      public var next:CollisionPrimitiveListItem;
      
      public var prev:CollisionPrimitiveListItem;
      
      public function CollisionPrimitiveListItem(primitive:CollisionPrimitive)
      {
         super();
         this.primitive = primitive;
      }
      
      public static function create(primitive:CollisionPrimitive) : CollisionPrimitiveListItem
      {
         var item:CollisionPrimitiveListItem = null;
         if(poolTop == null)
         {
            item = new CollisionPrimitiveListItem(primitive);
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
      
      public static function clearPool() : void
      {
         for(var curr:CollisionPrimitiveListItem = poolTop; curr != null; )
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

