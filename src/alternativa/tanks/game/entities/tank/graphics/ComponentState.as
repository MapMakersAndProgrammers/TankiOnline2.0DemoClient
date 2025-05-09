package alternativa.tanks.game.entities.tank.graphics
{
   import alternativa.tanks.game.entities.IComponentState;
   
   public class ComponentState implements IComponentState
   {
      protected var component:GraphicsControlComponent;
      
      public function ComponentState(component:GraphicsControlComponent)
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

