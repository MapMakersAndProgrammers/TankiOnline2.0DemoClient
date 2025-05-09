package alternativa.tanks.game.utils.list
{
   import alternativa.tanks.game.utils.list.errors.ConcurrentModificationError;
   import alternativa.tanks.game.utils.list.errors.NoSuchElementError;
   
   internal class ListIteratorImpl implements ListIterator
   {
      private var list:List;
      
      private var var_568:int;
      
      private var var_668:ListItem;
      
      private var var_667:ListItem;
      
      public function ListIteratorImpl(list:List)
      {
         super();
         this.list = list;
         this.var_568 = list.var_568;
         this.var_667 = list.head;
         this.var_668 = this.var_667.next;
      }
      
      public function add(data:Object) : void
      {
         this.validateList();
         var item:ListItem = new ListItem();
         item.data = data;
         item.prev = this.var_667;
         item.next = this.var_668;
         this.var_667.next = item;
         this.var_668.prev = item;
         this.var_667 = item;
         this.incChangeCounter();
      }
      
      public function hasNext() : Boolean
      {
         this.validateList();
         return this.var_668 != this.list.tail;
      }
      
      public function hasPrevious() : Boolean
      {
         this.validateList();
         return this.var_667 != this.list.head;
      }
      
      public function next() : Object
      {
         this.validateList();
         if(this.var_668 == this.list.tail)
         {
            throw new NoSuchElementError();
         }
         this.var_667 = this.var_668;
         this.var_668 = this.var_668.next;
         return this.var_667.data;
      }
      
      public function previous() : Object
      {
         this.validateList();
         if(this.var_667 == this.list.head)
         {
            throw new NoSuchElementError();
         }
         this.var_668 = this.var_667;
         this.var_667 = this.var_667.prev;
         return this.var_668.data;
      }
      
      private function validateList() : void
      {
         if(this.var_568 != this.list.var_568)
         {
            throw new ConcurrentModificationError();
         }
      }
      
      private function incChangeCounter() : void
      {
         ++this.var_568;
         this.list.var_568 = this.var_568;
      }
   }
}

