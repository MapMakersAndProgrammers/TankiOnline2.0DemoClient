package alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy
{
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.IActivatingStateCallback;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.subsystems.physicssystem.PhysicsSystem;
   
   public class LegacyActivatingState extends LegacyComponentState
   {
      private var §_-Cn§:ContactFilter;
      
      public function LegacyActivatingState(component:LegacyTrackedChassisComponent)
      {
         super(component);
         this.§_-Cn§ = new ContactFilter();
      }
      
      override public function start(data:*) : void
      {
         var gameKernel:GameKernel = null;
         var physicsSystem:PhysicsSystem = null;
         component.addToScene();
         component.setDetailedCollisionGroup(CollisionGroup.TANK);
         component.setSuspensionCollisionMask(CollisionGroup.STATIC);
         component.body.postCollisionFilter = this.§_-Cn§;
         var callback:IActivatingStateCallback = IActivatingStateCallback(data);
         if(callback != null)
         {
            gameKernel = component.gameKernel;
            this.§_-Cn§.initCallback(callback);
            gameKernel.getLogicSystem1().addLogicUnit(this.§_-Cn§);
            physicsSystem = gameKernel.getPhysicsSystem();
            physicsSystem.addControllerAfter(this.§_-Cn§);
            physicsSystem.addControllerBefore(this.§_-Cn§);
         }
      }
      
      override public function stop() : void
      {
         var gameKernel:GameKernel = null;
         var physicsSystem:PhysicsSystem = null;
         component.body.postCollisionFilter = null;
         if(this.§_-Cn§.callback != null)
         {
            gameKernel = component.gameKernel;
            gameKernel.getLogicSystem1().removeLogicUnit(this.§_-Cn§);
            physicsSystem = gameKernel.getPhysicsSystem();
            physicsSystem.removeControllerAfter(this.§_-Cn§);
            physicsSystem.removeControllerBefore(this.§_-Cn§);
            this.§_-Cn§.callback = null;
         }
      }
   }
}

import alternativa.physics.Body;
import alternativa.physics.collision.IBodyCollisionFilter;
import alternativa.tanks.game.entities.tank.IActivatingStateCallback;
import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
import alternativa.tanks.game.subsystems.physicssystem.IPhysicsController;
import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
import flash.utils.getTimer;

class ContactFilter implements IBodyCollisionFilter, IPhysicsController, ILogicUnit
{
   private static const MIN_TRANSPARENCY_DURATION:int = 3000;
   
   public var callback:IActivatingStateCallback;
   
   private var numContacts:int;
   
   private var canActivate:Boolean;
   
   private var startTime:int;
   
   public function ContactFilter()
   {
      super();
   }
   
   public function initCallback(callback:IActivatingStateCallback) : void
   {
      this.canActivate = false;
      this.startTime = getTimer();
      this.callback = callback;
   }
   
   public function acceptBodiesCollision(body1:Body, body2:Body) : Boolean
   {
      ++this.numContacts;
      return false;
   }
   
   public function updateBeforeSimulation(physicsStep:int) : void
   {
      this.numContacts = 0;
   }
   
   public function updateAfterSimulation(physicsStep:int) : void
   {
      if(Boolean(this.canActivate) && this.numContacts == 0)
      {
         this.callback.onCanActivate();
      }
   }
   
   public function interpolate(interpolationCoeff:Number) : void
   {
   }
   
   public function runLogic() : void
   {
      if(TimeSystem.time - this.startTime > MIN_TRANSPARENCY_DURATION)
      {
         this.canActivate = true;
      }
   }
}
