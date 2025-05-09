package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.tanks.game.physics.CollisionGroup;
   
   public class LegacyActiveState extends LegacyComponentState
   {
      public function LegacyActiveState(component:LegacyTrackedChassisComponent)
      {
         super(component);
      }
      
      override public function start(data:*) : void
      {
         component.addToScene();
         component.setDetailedCollisionGroup(CollisionGroup.TANK | CollisionGroup.WEAPON);
         component.setSuspensionCollisionMask(CollisionGroup.STATIC | CollisionGroup.TANK);
      }
   }
}

