package alternativa.tanks.game.entities.tank
{
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
   import alternativa.utils.KeyboardUtils;
   
   public class TurretManualControlComponent extends EntityComponent implements ILogicUnit
   {
      private static const KEY_LEFT:int = KeyboardUtils.Z;
      
      private static const KEY_RIGHT:int = KeyboardUtils.X;
      
      private static const KEY_CENTER:int = KeyboardUtils.C;
      
      private var callback:ITurretManualControlCallback;
      
      private var physicsComponent:ITurretPhysicsComponent;
      
      private var gameKernel:GameKernel;
      
      private var enabled:Boolean;
      
      private var center:Boolean;
      
      private var input:IInput;
      
      public function TurretManualControlComponent(callback:ITurretManualControlCallback)
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
         this.physicsComponent = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         entity.addEventHandler(TankEvents.SET_ACTIVATING_STATE,this.onSetActiveState);
         entity.addEventHandler(TankEvents.SET_ACTIVE_STATE,this.onSetActiveState);
         entity.addEventHandler(TankEvents.SET_DEAD_STATE,this.onSetInactiveState);
         entity.addEventHandler(TankEvents.SET_RESPAWN_STATE,this.onSetInactiveState);
         entity.addEventHandler(TankEvents.SET_DISABLED_STATE,this.onSetInactiveState);
         entity.addEventHandler(GameEvents.BATTLE_FINISHED,this.onBattleFinished);
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.input = gameKernel.getInputSystem();
         this.input.addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKeyDown,KEY_CENTER);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.disable();
         this.input.removeKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKeyDown,KEY_CENTER);
      }
      
      public function runLogic() : void
      {
         var turnDirection:int = this.input.getKeyState(KEY_LEFT) - this.input.getKeyState(KEY_RIGHT);
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
      
      private function onSetActiveState(eventType:String, data:*) : void
      {
         this.enable();
      }
      
      private function onSetInactiveState(eventType:String, data:*) : void
      {
         this.disable();
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
      
      private function onBattleFinished(eventType:String, eventData:*) : void
      {
         this.disable();
      }
      
      private function onKeyDown(eventType:KeyboardEventType, keyCode:uint) : void
      {
      }
   }
}

