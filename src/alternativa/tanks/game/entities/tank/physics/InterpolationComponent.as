package alternativa.tanks.game.entities.tank.physics
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.subsystems.physicssystem.IPhysicsController;
   
   public class InterpolationComponent extends EntityComponent implements IPhysicsController
   {
      private var chassisController:IPhysicsController;
      
      private var turretController:IPhysicsController;
      
      private var gameKernel:GameKernel;
      
      private var var_426:Boolean;
      
      public function InterpolationComponent()
      {
         super();
      }
      
      public function setChassisController(chassisController:IPhysicsController) : void
      {
         this.chassisController = chassisController;
      }
      
      public function setTurretController(turretController:IPhysicsController) : void
      {
         this.turretController = turretController;
      }
      
      public function updateBeforeSimulation(physicsStep:int) : void
      {
      }
      
      public function updateAfterSimulation(physicsStep:int) : void
      {
      }
      
      public function interpolate(interpolationCoeff:Number) : void
      {
         this.chassisController.interpolate(interpolationCoeff);
         this.turretController.interpolate(interpolationCoeff);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.removeFromScene();
         this.chassisController = null;
         this.turretController = null;
         gameKernel = null;
      }
      
      override public function initComponent() : void
      {
         entity.addEventHandler(TankEvents.SET_ACTIVATING_STATE,this.onActivate);
         entity.addEventHandler(TankEvents.SET_ACTIVE_STATE,this.onActivate);
         entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.onActivate);
         entity.addEventHandler(TankEvents.SET_RESPAWN_STATE,this.onDeactivate);
      }
      
      private function onActivate(eventType:String, data:*) : void
      {
         this.addToScene();
      }
      
      private function onDeactivate(eventType:String, data:*) : void
      {
         this.removeFromScene();
      }
      
      private function addToScene() : void
      {
         if(!this.var_426)
         {
            this.gameKernel.getPhysicsSystem().addInterpolationController(this);
            this.var_426 = true;
         }
      }
      
      private function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.gameKernel.getPhysicsSystem().removeInterpolationController(this);
            this.var_426 = false;
         }
      }
   }
}

