package package_92
{
   public class name_681
   {
      public var head:name_671;
      
      public var tail:name_671;
      
      public var size:int;
      
      public function name_681()
      {
         super();
      }
      
      public function append(body:name_271) : void
      {
         var item:name_671 = name_671.create(body);
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
      
      public function remove(body:name_271) : Boolean
      {
         var item:name_671 = this.method_628(body);
         if(item == null)
         {
            return false;
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
            this.tail = item.prev;
            this.tail.next = null;
         }
         else
         {
            item.prev.next = item.next;
            item.next.prev = item.prev;
         }
         item.dispose();
         --this.size;
         return true;
      }
      
      public function method_628(body:name_271) : name_671
      {
         var item:name_671 = this.head;
         while(item != null && item.body != body)
         {
            item = item.next;
         }
         return item;
      }
   }
}

