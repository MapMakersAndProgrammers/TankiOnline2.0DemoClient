package alternativa.tanks.game.utils.list
{
   import alternativa.tanks.game.utils.list.errors.ConcurrentModificationError;
   import alternativa.tanks.game.utils.list.errors.NoSuchElementError;
   
   internal class ListIteratorImpl implements ListIterator
   {
      private var list:List;
      
      private var name_M0:int;
      
      private var name_9H:ListItem;
      
      private var name_4o:ListItem;
      
      public function ListIteratorImpl(list:List)
      {
         super();
         this.list = list;
         this.name_M0 = list.name_M0;
         this.name_4o = list.head;
         this.name_9H = this.name_4o.next;
      }
      
      public function add(data:Object) : void
      {
         this.validateList();
         var item:ListItem = new ListItem();
         item.data = data;
         item.prev = this.name_4o;
         item.next = this.name_9H;
         this.name_4o.next = item;
         this.name_9H.prev = item;
         this.name_4o = item;
         this.incChangeCounter();
      }
      
      public function hasNext() : Boolean
      {
         this.validateList();
         return this.name_9H != this.list.tail;
      }
      
      public function hasPrevious() : Boolean
      {
         this.validateList();
         return this.name_4o != this.list.head;
      }
      
      public function next() : Object
      {
         this.validateList();
         if(this.name_9H == this.list.tail)
         {
            throw new NoSuchElementError();
         }
         this.name_4o = this.name_9H;
         this.name_9H = this.name_9H.next;
         return this.name_4o.data;
      }
      
      public function previous() : Object
      {
         this.validateList();
         if(this.name_4o == this.list.head)
         {
            throw new NoSuchElementError();
         }
         this.name_9H = this.name_4o;
         this.name_4o = this.name_4o.prev;
         return this.name_9H.data;
      }
      
      private function validateList() : void
      {
         if(this.name_M0 != this.list.name_M0)
         {
            throw new ConcurrentModificationError();
         }
      }
      
      private function incChangeCounter() : void
      {
         ++this.name_M0;
         this.list.name_M0 = this.name_M0;
      }
   }
}

