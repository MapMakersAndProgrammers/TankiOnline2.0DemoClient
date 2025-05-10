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
      
      private var name_lp:IBasicWeapon;
      
      private var name_89:Boolean;
      
      private var name_ZM:Boolean;
      
      public function BasicWeaponManualControlComponent()
      {
         super();
      }
      
      override public function initComponent() : void
      {
         this.name_lp = IBasicWeapon(entity.getComponentStrict(IBasicWeapon));
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
         if(this.name_89)
         {
            this.name_lp.pullTrigger();
            if(this.name_ZM)
            {
               this.name_lp.forceUpdate();
            }
         }
         if(this.name_ZM)
         {
            this.name_lp.releaseTrigger();
         }
         this.name_89 = false;
         this.name_ZM = false;
      }
      
      private function onKey(eventType:KeyboardEventType, keyCode:uint) : void
      {
         switch(eventType)
         {
            case KeyboardEventType.KEY_DOWN:
               this.name_89 = true;
               if(!this.enabled)
               {
                  this.name_ZM = false;
               }
               break;
            case KeyboardEventType.KEY_UP:
               this.name_ZM = true;
               if(!this.enabled)
               {
                  this.name_lp.releaseTrigger();
                  this.name_89 = false;
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

