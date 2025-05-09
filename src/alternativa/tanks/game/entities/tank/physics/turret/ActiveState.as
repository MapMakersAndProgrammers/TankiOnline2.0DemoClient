package alternativa.tanks.game.entities.tank.physics.turret
{
   import alternativa.tanks.game.entities.IComponentState;
   
   public class ActiveState implements IComponentState
   {
      private var component:TurretPhysicsComponent;
      
      public function ActiveState(component:TurretPhysicsComponent)
      {
         super();
         this.component = component;
      }
      
      public function start(data:*) : void
      {
         this.component.addToScene();
      }
      
      public function stop() : void
      {
      }
   }
}

