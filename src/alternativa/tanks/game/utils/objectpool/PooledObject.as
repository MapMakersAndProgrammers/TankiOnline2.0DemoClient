package alternativa.tanks.game.utils.objectpool
{
   public class PooledObject
   {
      protected var objectPool:ObjectPool;
      
      public function PooledObject(objectPool:ObjectPool)
      {
         super();
         this.objectPool = objectPool;
      }
      
      final public function storeInPool() : void
      {
         this.objectPool.putObject(this);
      }
   }
}

