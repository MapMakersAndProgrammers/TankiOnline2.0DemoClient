package package_108
{
   import package_127.name_729;
   import package_127.name_730;
   
   internal class name_640 implements name_373
   {
      private var list:name_374;
      
      private var var_568:int;
      
      private var var_668:name_639;
      
      private var var_667:name_639;
      
      public function name_640(list:name_374)
      {
         super();
         this.list = list;
         this.var_568 = list.var_568;
         this.var_667 = list.head;
         this.var_668 = this.var_667.next;
      }
      
      public function add(data:Object) : void
      {
         this.method_811();
         var item:name_639 = new name_639();
         item.data = data;
         item.prev = this.var_667;
         item.next = this.var_668;
         this.var_667.next = item;
         this.var_668.prev = item;
         this.var_667 = item;
         this.method_812();
      }
      
      public function hasNext() : Boolean
      {
         this.method_811();
         return this.var_668 != this.list.tail;
      }
      
      public function method_626() : Boolean
      {
         this.method_811();
         return this.var_667 != this.list.head;
      }
      
      public function next() : Object
      {
         this.method_811();
         if(this.var_668 == this.list.tail)
         {
            throw new name_729();
         }
         this.var_667 = this.var_668;
         this.var_668 = this.var_668.next;
         return this.var_667.data;
      }
      
      public function name_375() : Object
      {
         this.method_811();
         if(this.var_667 == this.list.head)
         {
            throw new name_729();
         }
         this.var_668 = this.var_667;
         this.var_667 = this.var_667.prev;
         return this.var_668.data;
      }
      
      private function method_811() : void
      {
         if(this.var_568 != this.list.var_568)
         {
            throw new name_730();
         }
      }
      
      private function method_812() : void
      {
         ++this.var_568;
         this.list.var_568 = this.var_568;
      }
   }
}

