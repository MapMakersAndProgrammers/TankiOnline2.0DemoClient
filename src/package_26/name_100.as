package package_26
{
   import flash.utils.Dictionary;
   
   public class name_100
   {
      private var var_103:Dictionary = new Dictionary();
      
      public function name_100()
      {
         super();
      }
      
      public function name_110(objectClass:Class) : Object
      {
         return this.method_220(objectClass).name_110();
      }
      
      private function method_220(objectClass:Class) : name_402
      {
         var pool:name_402 = this.var_103[objectClass];
         if(pool == null)
         {
            pool = new name_402(objectClass);
            this.var_103[objectClass] = pool;
         }
         return pool;
      }
   }
}

