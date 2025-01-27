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
      
      final public function method_254() : void
      {
         this.objectPool.name_425(this);
      }
   }
}

