package alternativa.tanks.game.entities
{
   public class EmptyState implements IComponentState
   {
      public static const INSTANCE:EmptyState = new EmptyState();
      
      public function EmptyState()
      {
         super();
      }
      
      public function start(data:*) : void
      {
      }
      
      public function stop() : void
      {
      }
   }
}

