package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.tanks.game.entities.IComponentState;
   
   public class LegacyComponentState implements IComponentState
   {
      protected var component:LegacyTrackedChassisComponent;
      
      public function LegacyComponentState(component:LegacyTrackedChassisComponent)
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

