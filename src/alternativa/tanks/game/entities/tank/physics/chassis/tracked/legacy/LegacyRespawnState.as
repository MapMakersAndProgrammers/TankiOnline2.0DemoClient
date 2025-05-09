package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   public class LegacyRespawnState extends LegacyComponentState
   {
      public function LegacyRespawnState(component:LegacyTrackedChassisComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.setChassisControls(0,0,false);
         component.removeFromScene();
      }
      
      override public function stop() : void
      {
         component.setLinearVelocityXYZ(0,0,0);
         component.setAngularVelocityXYZ(0,0,0);
      }
   }
}

