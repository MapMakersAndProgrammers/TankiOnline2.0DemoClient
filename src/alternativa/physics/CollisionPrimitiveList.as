package alternativa.physics
{
   import alternativa.physics.collision.CollisionPrimitive;
   
   public class CollisionPrimitiveList
   {
      public var head:CollisionPrimitiveListItem;
      
      public var tail:CollisionPrimitiveListItem;
      
      public var size:int;
      
      public function CollisionPrimitiveList()
      {
         super();
      }
      
      public function append(primitive:CollisionPrimitive) : void
      {
         var item:CollisionPrimitiveListItem = CollisionPrimitiveListItem.create(primitive);
         if(this.head == null)
         {
            this.head = this.tail = item;
         }
         else
         {
            this.tail.next = item;
            item.prev = this.tail;
            this.tail = item;
         }
         ++this.size;
      }
      
      public function remove(primitve:CollisionPrimitive) : void
      {
         var item:CollisionPrimitiveListItem = this.findItem(primitve);
         if(item == null)
         {
            return;
         }
         if(item == this.head)
         {
            if(this.size == 1)
            {
               this.head = this.tail = null;
            }
            else
            {
               this.head = item.next;
               this.head.prev = null;
            }
         }
         else if(item == this.tail)
         {
            this.tail = this.tail.prev;
            this.tail.next = null;
         }
         else
         {
            item.prev.next = item.next;
            item.next.prev = item.prev;
         }
         item.dispose();
         --this.size;
      }
      
      public function findItem(primitive:CollisionPrimitive) : CollisionPrimitiveListItem
      {
         var item:CollisionPrimitiveListItem = this.head;
         while(item != null && item.primitive != primitive)
         {
            item = item.next;
         }
         return item;
      }
      
      public function clear() : void
      {
         for(var item:CollisionPrimitiveListItem = null; this.head != null; )
         {
            item = this.head;
            this.head = this.head.next;
            item.dispose();
         }
         this.tail = null;
         this.size = 0;
      }
   }
}

