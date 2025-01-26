package alternativa.tanks.game
{
   public class EntityComponent
   {
      protected var entity:Entity;
      
      public function EntityComponent()
      {
         super();
      }
      
      public function method_197(entity:Entity) : void
      {
         this.entity = entity;
      }
      
      public function initComponent() : void
      {
      }
      
      public function addToGame(gameKernel:GameKernel) : void
      {
      }
      
      public function removeFromGame(gameKernel:GameKernel) : void
      {
      }
   }
}

