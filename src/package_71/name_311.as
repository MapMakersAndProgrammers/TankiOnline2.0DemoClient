package package_71
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import package_15.name_191;
   import package_22.name_83;
   import package_22.name_87;
   import package_42.name_477;
   import package_75.class_15;
   
   public class name_311 extends EntityComponent implements name_477
   {
      private static const KEY_LEFT:int = name_191.Z;
      
      private static const KEY_RIGHT:int = name_191.X;
      
      private static const KEY_CENTER:int = name_191.C;
      
      private var callback:class_10;
      
      private var physicsComponent:class_15;
      
      private var gameKernel:GameKernel;
      
      private var name_308:Boolean;
      
      private var center:Boolean;
      
      private var input:name_87;
      
      public function name_311(callback:class_10)
      {
         super();
         if(callback == null)
         {
            throw new Error("Parameter callback is null");
         }
         this.callback = callback;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = class_15(entity.getComponentStrict(class_15));
         entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.method_410);
         entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.method_410);
         entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_DISABLED_STATE,this.method_408);
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.method_386);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.input = gameKernel.name_66();
         this.input.name_94(name_83.KEY_DOWN,this.method_15,KEY_CENTER);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.method_409();
         this.input.name_384(name_83.KEY_DOWN,this.method_15,KEY_CENTER);
      }
      
      public function runLogic() : void
      {
         var turnDirection:int = this.input.name_192(KEY_LEFT) - this.input.name_192(KEY_RIGHT);
         if(this.physicsComponent.setTurretControls(turnDirection))
         {
            this.callback.onTurretControlChanged(turnDirection,false);
         }
         if(this.center)
         {
            this.physicsComponent.centerTurret(true);
            this.callback.onTurretControlChanged(0,true);
            this.center = false;
         }
      }
      
      private function method_410(eventType:String, data:*) : void
      {
         this.name_108();
      }
      
      private function method_408(eventType:String, data:*) : void
      {
         this.method_409();
      }
      
      private function name_108() : void
      {
         if(!this.name_308)
         {
            this.name_308 = true;
            this.gameKernel.getLogicSystem1().addLogicUnit(this);
         }
      }
      
      private function method_409() : void
      {
         if(this.name_308)
         {
            this.name_308 = false;
            this.gameKernel.getLogicSystem1().removeLogicUnit(this);
         }
      }
      
      private function method_386(eventType:String, eventData:*) : void
      {
         this.method_409();
      }
      
      private function method_15(eventType:name_83, keyCode:uint) : void
      {
      }
   }
}

