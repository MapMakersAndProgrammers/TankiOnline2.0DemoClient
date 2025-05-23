package alternativa.tanks.game.utils.list
{
   public class List
   {
      internal var head:ListItem;
      
      internal var tail:ListItem;
      
      internal var name_M0:int;
      
      public function List()
      {
         super();
         this.head = new ListItem();
         this.tail = new ListItem();
         this.head.next = this.tail;
         this.tail.prev = this.head;
      }
      
      public function listIterator() : ListIterator
      {
         return new ListIteratorImpl(this);
      }
      
      public function add(data:Object) : void
      {
         var newItem:ListItem = new ListItem();
         newItem.data = data;
         newItem.next = this.tail;
         newItem.prev = this.tail.prev;
         this.tail.prev = newItem;
         newItem.prev.next = newItem;
         ++this.name_M0;
      }
      
      public function remove(data:Object) : Boolean
      {
         var item:ListItem = this.findItem(data);
         if(item != null)
         {
            this.removeItem(item);
            return true;
         }
         return false;
      }
      
      public function contains(data:Object) : Boolean
      {
         return this.findItem(data) != null;
      }
      
      public function clear() : void
      {
         var tmp:ListItem = null;
         for(var item:ListItem = this.head.next; item != this.tail; )
         {
            tmp = item;
            item = item.next;
            this.removeItem(tmp);
         }
      }
      
      public function peek() : Object
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
         this.removeItem(this.head.next);
         return data;
      }
      
      private function findItem(data:Object) : ListItem
      {
         for(var item:ListItem = this.head.next; item != this.tail; )
         {
            if(item.data == data)
            {
               return item;
            }
            item = item.next;
         }
         return null;
      }
      
      private function removeItem(item:ListItem) : void
      {
         if(item == this.head || item == this.tail)
         {
            throw new Error("Cannot remove sentinels");
         }
         item.prev.next = item.next;
         item.next.prev = item.prev;
         item.next = null;
         item.prev = null;
         ++this.name_M0;
      }
   }
}

