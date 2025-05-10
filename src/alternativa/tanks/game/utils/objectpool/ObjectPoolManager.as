package alternativa.tanks.game.utils.objectpool
{
   import flash.utils.Dictionary;
   
   public class ObjectPoolManager
   {
      private var §_-Jm§:Dictionary = new Dictionary();
      
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
         var pool:ObjectPool = this.§_-Jm§[objectClass];
         if(pool == null)
         {
            pool = new ObjectPool(objectClass);
            this.§_-Jm§[objectClass] = pool;
         }
         return pool;
      }
   }
}

