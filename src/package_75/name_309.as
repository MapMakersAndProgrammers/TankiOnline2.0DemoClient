package package_75
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_44.name_465;
   import package_71.name_252;
   
   public class name_309 extends EntityComponent implements name_465
   {
      private var chassisController:name_465;
      
      private var turretController:name_465;
      
      private var gameKernel:GameKernel;
      
      private var var_426:Boolean;
      
      public function name_309()
      {
         super();
      }
      
      public function method_463(chassisController:name_465) : void
      {
         this.chassisController = chassisController;
      }
      
      public function name_507(turretController:name_465) : void
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
         entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.method_461);
         entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.method_461);
         entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_461);
         entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.method_462);
      }
      
      private function method_461(eventType:String, data:*) : void
      {
         this.addToScene();
      }
      
      private function method_462(eventType:String, data:*) : void
      {
         this.removeFromScene();
      }
      
      private function addToScene() : void
      {
         if(!this.var_426)
         {
            this.gameKernel.method_112().method_330(this);
            this.var_426 = true;
         }
      }
      
      private function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.gameKernel.method_112().method_332(this);
            this.var_426 = false;
         }
      }
   }
}

