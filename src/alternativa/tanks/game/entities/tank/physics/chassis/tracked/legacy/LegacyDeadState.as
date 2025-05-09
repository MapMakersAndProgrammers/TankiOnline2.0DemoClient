package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.physics.Body;
   import alternativa.tanks.game.physics.CollisionGroup;
   
   public class LegacyDeadState extends LegacyComponentState
   {
      public function LegacyDeadState(component:LegacyTrackedChassisComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setDetailedCollisionGroup(CollisionGroup.TANK | CollisionGroup.WEAPON);
         component.setSuspensionCollisionMask(CollisionGroup.STATIC | CollisionGroup.TANK);
         component.setChassisControls(0,0,false);
         var body:Body = component.getBody();
         body.state.velocity.z += 500;
         body.state.rotation.reset(2,2,2);
      }
   }
}

