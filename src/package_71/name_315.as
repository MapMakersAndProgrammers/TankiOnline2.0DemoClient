package package_71
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameEvents;
   import package_15.name_191;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import package_42.name_477;
   import alternativa.tanks.game.weapons.IBasicWeapon;
   
   public class name_315 extends EntityComponent implements name_477
   {
      private static const KEY_FIRE:uint = name_191.SPACE;
      
      private var gameKernel:GameKernel;
      
      private var name_308:Boolean;
      
      private var var_442:IBasicWeapon;
      
      private var var_508:Boolean;
      
      private var var_507:Boolean;
      
      public function name_315()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         this.var_442 = IBasicWeapon(entity.getComponentStrict(IBasicWeapon));
         entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.method_410);
         entity.addEventHandler(name_252.SET_DISABLED_STATE,this.method_408);
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.method_386);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var inputSystem:IInput = gameKernel.name_66();
         inputSystem.name_94(KeyboardEventType.KEY_DOWN,this.method_193,KEY_FIRE);
         inputSystem.name_94(KeyboardEventType.KEY_UP,this.method_193,KEY_FIRE);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.method_409();
         var inputSystem:IInput = gameKernel.name_66();
         inputSystem.name_384(KeyboardEventType.KEY_DOWN,this.method_193,KEY_FIRE);
         inputSystem.name_384(KeyboardEventType.KEY_UP,this.method_193,KEY_FIRE);
      }
      
      public function runLogic() : void
      {
         if(this.var_508)
         {
            this.var_442.method_394();
            if(this.var_507)
            {
               this.var_442.method_395();
            }
         }
         if(this.var_507)
         {
            this.var_442.method_393();
         }
         this.var_508 = false;
         this.var_507 = false;
      }
      
      private function method_193(eventType:KeyboardEventType, keyCode:uint) : void
      {
         switch(eventType)
         {
            case KeyboardEventType.KEY_DOWN:
               this.var_508 = true;
               if(!this.name_308)
               {
                  this.var_507 = false;
               }
               break;
            case KeyboardEventType.KEY_UP:
               this.var_507 = true;
               if(!this.name_308)
               {
                  this.var_442.method_393();
                  this.var_508 = false;
                  break;
               }
         }
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
      
      private function method_408(eventType:String, data:*) : void
      {
         this.method_409();
      }
      
      private function method_410(eventType:String, data:*) : void
      {
         this.name_108();
      }
      
      private function method_386(gameType:String, gameData:*) : void
      {
         this.method_409();
      }
   }
}

