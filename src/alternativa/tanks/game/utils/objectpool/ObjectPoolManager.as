package alternativa.tanks.game.utils.objectpool
{
   import flash.utils.Dictionary;
   
   public class ObjectPoolManager
   {
      private var var_103:Dictionary = new Dictionary();
      
      public function ObjectPoolManager()
      {
         super();
      }
      
      public function name_110(objectClass:Class) : Object
      {
         return this.getPool(objectClass).name_110();
      }
      
      private function getPool(objectClass:Class) : ObjectPool
      {
         var pool:ObjectPool = this.var_103[objectClass];
         if(pool == null)
         {
            pool = new ObjectPool(objectClass);
            this.var_103[objectClass] = pool;
         }
         return pool;
      }
   }
}

