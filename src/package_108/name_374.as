package package_108
{
   public class name_374
   {
      internal var head:name_639;
      
      internal var tail:name_639;
      
      internal var var_568:int;
      
      public function name_374()
      {
         super();
         this.head = new name_639();
         this.tail = new name_639();
         this.head.next = this.tail;
         this.tail.prev = this.head;
      }
      
      public function listIterator() : name_373
      {
         return new name_640(this);
      }
      
      public function add(data:Object) : void
      {
         var newItem:name_639 = new name_639();
         newItem.data = data;
         newItem.next = this.tail;
         newItem.prev = this.tail.prev;
         this.tail.prev = newItem;
         newItem.prev.next = newItem;
         ++this.var_568;
      }
      
      public function remove(data:Object) : Boolean
      {
         var item:name_639 = this.method_628(data);
         if(item != null)
         {
            this.method_627(item);
            return true;
         }
         return false;
      }
      
      public function contains(data:Object) : Boolean
      {
         return this.method_628(data) != null;
      }
      
      public function clear() : void
      {
         var tmp:name_639 = null;
         for(var item:name_639 = this.head.next; item != this.tail; )
         {
            tmp = item;
            item = item.next;
            this.method_627(tmp);
         }
      }
      
      public function method_629() : Object
      {
         return this.head.next.data;
      }
      
      public function poll() : Object
      {
         if(this.head.next == this.tail)
         {
            return null;
         }
         var data:Object = this.head.next.data;
         this.method_627(this.head.next);
         return data;
      }
      
      private function method_628(data:Object) : name_639
      {
         for(var item:name_639 = this.head.next; item != this.tail; )
         {
            if(item.data == data)
            {
               return item;
            }
            item = item.next;
         }
         return null;
      }
      
      private function method_627(item:name_639) : void
      {
         if(item == this.head || item == this.tail)
         {
            throw new Error("Cannot remove sentinels");
         }
         item.prev.next = item.next;
         item.next.prev = item.prev;
         item.next = null;
         item.prev = null;
         ++this.var_568;
      }
   }
}

