package package_71
{
   import flash.ui.Keyboard;
   import package_1.name_12;
   import package_10.class_17;
   import package_10.name_17;
   import package_10.name_57;
   import package_22.name_87;
   import package_42.name_477;
   import package_45.name_182;
   
   public class name_316 extends class_17 implements name_477
   {
      private static const KEY_FORWARD:uint = Keyboard.UP;
      
      private static const KEY_BACK:uint = Keyboard.DOWN;
      
      private static const KEY_LEFT:uint = Keyboard.LEFT;
      
      private static const KEY_RIGHT:uint = Keyboard.RIGHT;
      
      private static var conReverseBackTurn:name_12 = new name_12("reverse_back_turn",1,0,1);
      
      private static const SYNC_INTERVAL:int = 4000;
      
      private var input:name_87;
      
      private var physicsComponent:class_30;
      
      private var gameKernel:name_17;
      
      private var callback:class_29;
      
      private var name_308:Boolean;
      
      private var var_503:int;
      
      public function name_316(callback:class_29)
      {
         super();
         this.callback = callback;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = class_30(entity.getComponentStrict(class_30));
         entity.addEventHandler(name_252.SET_ACTIVATING_STATE,this.method_410);
         entity.addEventHandler(name_252.SET_ACTIVE_STATE,this.method_410);
         entity.addEventHandler(name_252.SET_DEAD_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_RESPAWN_STATE,this.method_408);
         entity.addEventHandler(name_252.SET_DISABLED_STATE,this.method_408);
         entity.addEventHandler(name_57.BATTLE_FINISHED,this.method_386);
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
         this.input = gameKernel.name_66();
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         this.method_409();
      }
      
      public function runLogic() : void
      {
         var moveDirection:int = this.input.name_192(KEY_FORWARD) - this.input.name_192(KEY_BACK);
         var turnDirection:int = this.input.name_192(KEY_RIGHT) - this.input.name_192(KEY_LEFT);
         if(Boolean(this.physicsComponent.setChassisControls(moveDirection,turnDirection,Boolean(conReverseBackTurn.value))) || name_182.time - this.var_503 > SYNC_INTERVAL)
         {
            if(this.callback != null)
            {
               this.callback.method_448(moveDirection,turnDirection,Boolean(conReverseBackTurn.value));
            }
            this.var_503 = name_182.time;
         }
      }
      
      private function method_410(eventType:String, eventData:*) : void
      {
         this.name_108();
      }
      
      private function method_408(eventType:String, eventData:*) : void
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
      
      private function method_386(gameType:String, gameData:*) : void
      {
         this.method_409();
      }
   }
}

