package alternativa.tanks.game.entities.tank.physics.turret
{
   import alternativa.tanks.game.entities.IComponentState;
   
   public class RespawnState implements IComponentState
   {
      private var component:TurretPhysicsComponent;
      
      public function RespawnState(component:TurretPhysicsComponent)
      {
         super();
         this.component = component;
      }
      
      public function start(data:*) : void
      {
         this.component.setTurretControls(0);
         this.component.centerTurret(false);
         this.component.setTurretDirection(0);
         this.component.removeFromScene();
      }
      
      public function stop() : void
      {
         this.component.addToScene();
      }
   }
}

