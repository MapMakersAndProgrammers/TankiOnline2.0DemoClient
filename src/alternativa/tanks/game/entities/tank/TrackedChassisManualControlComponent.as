package alternativa.tanks.game.entities.tank
{
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.logicsystem.ILogicUnit;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import flash.ui.Keyboard;
   
   public class TrackedChassisManualControlComponent extends EntityComponent implements ILogicUnit
   {
      private static const KEY_FORWARD:uint = Keyboard.UP;
      
      private static const KEY_BACK:uint = Keyboard.DOWN;
      
      private static const KEY_LEFT:uint = Keyboard.LEFT;
      
      private static const KEY_RIGHT:uint = Keyboard.RIGHT;
      
      private static var conReverseBackTurn:ConsoleVarInt = new ConsoleVarInt("reverse_back_turn",1,0,1);
      
      private static const SYNC_INTERVAL:int = 4000;
      
      private var input:IInput;
      
      private var physicsComponent:IControllableTrackedChassisComponent;
      
      private var gameKernel:GameKernel;
      
      private var callback:IChassisManualControlCallback;
      
      private var enabled:Boolean;
      
      private var name_de:int;
      
      public function TrackedChassisManualControlComponent(callback:IChassisManualControlCallback)
      {
         super();
         this.callback = callback;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = IControllableTrackedChassisComponent(entity.getComponentStrict(IControllableTrackedChassisComponent));
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
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.disable();
      }
      
      public function runLogic() : void
      {
         var moveDirection:int = this.input.getKeyState(KEY_FORWARD) - this.input.getKeyState(KEY_BACK);
         var turnDirection:int = this.input.getKeyState(KEY_RIGHT) - this.input.getKeyState(KEY_LEFT);
         if(Boolean(this.physicsComponent.setChassisControls(moveDirection,turnDirection,Boolean(conReverseBackTurn.value))) || TimeSystem.time - this.name_de > SYNC_INTERVAL)
         {
            if(this.callback != null)
            {
               this.callback.onControlChanged(moveDirection,turnDirection,Boolean(conReverseBackTurn.value));
            }
            this.name_de = TimeSystem.time;
         }
      }
      
      private function onSetActiveState(eventType:String, eventData:*) : void
      {
         this.enable();
      }
      
      private function onSetInactiveState(eventType:String, eventData:*) : void
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
      
      private function onBattleFinished(gameType:String, gameData:*) : void
      {
         this.disable();
      }
   }
}

