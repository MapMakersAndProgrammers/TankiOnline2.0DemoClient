package alternativa.tanks.game.entities.tank
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
   import alternativa.tanks.game.weapons.IBasicWeapon;
   import alternativa.utils.KeyboardUtils;
   
   public class BasicWeaponManualControlComponent extends EntityComponent implements ILogicUnit
   {
      private static const KEY_FIRE:uint = KeyboardUtils.SPACE;
      
      private var gameKernel:GameKernel;
      
      private var enabled:Boolean;
      
      private var var_442:IBasicWeapon;
      
      private var var_508:Boolean;
      
      private var var_507:Boolean;
      
      public function BasicWeaponManualControlComponent()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         this.var_442 = IBasicWeapon(entity.getComponentStrict(IBasicWeapon));
         entity.addEventHandler(TankEvents.SET_ACTIVATING_STATE,this.onSetInactiveState);
         entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.onSetInactiveState);
         entity.addEventHandler(TankEvents.SET_RESPAWN_STATE,this.onSetInactiveState);
         entity.addEventHandler(TankEvents.SET_ACTIVE_STATE,this.onSetActiveState);
         entity.addEventHandler(TankEvents.SET_DISABLED_STATE,this.onSetInactiveState);
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.onBattleFinished);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var inputSystem:IInput = gameKernel.getInputSystem();
         inputSystem.addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKey,KEY_FIRE);
         inputSystem.addKeyboardListener(KeyboardEventType.KEY_UP,this.onKey,KEY_FIRE);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.disable();
         var inputSystem:IInput = gameKernel.getInputSystem();
         inputSystem.removeKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKey,KEY_FIRE);
         inputSystem.removeKeyboardListener(KeyboardEventType.KEY_UP,this.onKey,KEY_FIRE);
      }
      
      public function runLogic() : void
      {
         if(this.var_508)
         {
            this.var_442.pullTrigger();
            if(this.var_507)
            {
               this.var_442.forceUpdate();
            }
         }
         if(this.var_507)
         {
            this.var_442.releaseTrigger();
         }
         this.var_508 = false;
         this.var_507 = false;
      }
      
      private function onKey(eventType:KeyboardEventType, keyCode:uint) : void
      {
         switch(eventType)
         {
            case KeyboardEventType.KEY_DOWN:
               this.var_508 = true;
               if(!this.enabled)
               {
                  this.var_507 = false;
               }
               break;
            case KeyboardEventType.KEY_UP:
               this.var_507 = true;
               if(!this.enabled)
               {
                  this.var_442.releaseTrigger();
                  this.var_508 = false;
                  break;
               }
         }
      }
      
      private function enable() : void
      {
         if(!this.enabled)
         {
            this.enabled = true;
            this.gameKernel.getLogicSystem1().addLogicUnit(this);
         }
      }
      
      private function disable() : void
      {
         if(this.enabled)
         {
            this.enabled = false;
            this.gameKernel.getLogicSystem1().removeLogicUnit(this);
         }
      }
      
      private function onSetInactiveState(eventType:String, data:*) : void
      {
         this.disable();
      }
      
      private function onSetActiveState(eventType:String, data:*) : void
      {
         this.enable();
      }
      
      private function onBattleFinished(gameType:String, gameData:*) : void
      {
         this.disable();
      }
   }
}

