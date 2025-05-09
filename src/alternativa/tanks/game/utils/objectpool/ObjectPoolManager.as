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
      
      public function getObject(objectClass:Class) : Object
      {
         return this.getPool(objectClass).getObject();
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

