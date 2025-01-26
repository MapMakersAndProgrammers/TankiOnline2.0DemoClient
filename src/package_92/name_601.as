package package_92
{
   import package_76.name_235;
   
   public class name_601
   {
      public var head:name_513;
      
      public var tail:name_513;
      
      public var size:int;
      
      public function name_601()
      {
         super();
      }
      
      public function append(primitive:name_235) : void
      {
         var item:name_513 = name_513.create(primitive);
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
      
      public function remove(primitve:name_235) : void
      {
         var item:name_513 = this.method_628(primitve);
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
      
      public function method_628(primitive:name_235) : name_513
      {
         var item:name_513 = this.head;
         while(item != null && item.primitive != primitive)
         {
            item = item.next;
         }
         return item;
      }
      
      public function clear() : void
      {
         for(var item:name_513 = null; this.head != null; )
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

