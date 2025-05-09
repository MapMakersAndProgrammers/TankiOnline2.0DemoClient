package §in §
{
   import alternativa.tanks.game.utils.objectpool.ObjectPool;
   import alternativa.tanks.game.utils.objectpool.PooledObject;
   
   public class DeferredCommand extends PooledObject
   {
      public var next:DeferredCommand;
      
      public function DeferredCommand(objectPool:ObjectPool)
      {
         super(objectPool);
      }
      
      public function execute() : void
      {
      }
   }
}

