package alternativa.tanks.game.entities.tank.physics.turret
{
   import alternativa.tanks.game.entities.IComponentState;
   
   public class DeadState implements IComponentState
   {
      private var component:TurretPhysicsComponent;
      
      public function DeadState(component:TurretPhysicsComponent)
      {
         super();
         this.component = component;
      }
      
      public function start(data:*) : void
      {
         this.component.setTurretControls(0);
         this.component.centerTurret(false);
      }
      
      public function stop() : void
      {
      }
   }
}

