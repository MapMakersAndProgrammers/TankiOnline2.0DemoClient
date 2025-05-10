package alternativa.tanks.game.usertitle.component
{
   import alternativa.tanks.game.entities.IComponentState;
   
   public class ComponentStateBase implements IComponentState
   {
      protected var component:UserTitleComponent;
      
      public function ComponentStateBase(component:UserTitleComponent)
      {
         super();
         this.component = component;
      }
      
      public function start(data:*) : void
      {
      }
      
      public function stop() : void
      {
      }
   }
}

