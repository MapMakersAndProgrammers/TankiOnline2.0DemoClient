package alternativa.tanks.game.utils.objectpool
{
   import flash.utils.Dictionary;
   
   public class ObjectPoolManager
   {
      private var name_Jm:Dictionary = new Dictionary();
      
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
         var pool:ObjectPool = this.name_Jm[objectClass];
         if(pool == null)
         {
            pool = new ObjectPool(objectClass);
            this.name_Jm[objectClass] = pool;
         }
         return pool;
      }
   }
}

