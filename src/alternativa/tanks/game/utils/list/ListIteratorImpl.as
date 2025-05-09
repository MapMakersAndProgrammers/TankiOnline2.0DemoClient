package alternativa.tanks.game.utils.list
{
   import alternativa.tanks.game.utils.list.errors.ConcurrentModificationError;
   import alternativa.tanks.game.utils.list.errors.NoSuchElementError;
   
   internal class ListIteratorImpl implements ListIterator
   {
      private var list:List;
      
      private var §_-M0§:int;
      
      private var §_-9H§:ListItem;
      
      private var §_-4o§:ListItem;
      
      public function ListIteratorImpl(list:List)
      {
         super();
         this.list = list;
         this.§_-M0§ = list.§_-M0§;
         this.§_-4o§ = list.head;
         this.§_-9H§ = this.§_-4o§.next;
      }
      
      public function add(data:Object) : void
      {
         this.validateList();
         var item:ListItem = new ListItem();
         item.data = data;
         item.prev = this.§_-4o§;
         item.next = this.§_-9H§;
         this.§_-4o§.next = item;
         this.§_-9H§.prev = item;
         this.§_-4o§ = item;
         this.incChangeCounter();
      }
      
      public function hasNext() : Boolean
      {
         this.validateList();
         return this.§_-9H§ != this.list.tail;
      }
      
      public function hasPrevious() : Boolean
      {
         this.validateList();
         return this.§_-4o§ != this.list.head;
      }
      
      public function next() : Object
      {
         this.validateList();
         if(this.§_-9H§ == this.list.tail)
         {
            throw new NoSuchElementError();
         }
         this.§_-4o§ = this.§_-9H§;
         this.§_-9H§ = this.§_-9H§.next;
         return this.§_-4o§.data;
      }
      
      public function previous() : Object
      {
         this.validateList();
         if(this.§_-4o§ == this.list.head)
         {
            throw new NoSuchElementError();
         }
         this.§_-9H§ = this.§_-4o§;
         this.§_-4o§ = this.§_-4o§.prev;
         return this.§_-9H§.data;
      }
      
      private function validateList() : void
      {
         if(this.§_-M0§ != this.list.§_-M0§)
         {
            throw new ConcurrentModificationError();
         }
      }
      
      private function incChangeCounter() : void
      {
         ++this.§_-M0§;
         this.list.§_-M0§ = this.§_-M0§;
      }
   }
}

