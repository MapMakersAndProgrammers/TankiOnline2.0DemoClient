package alternativa.tanks.sounds
{
   import alternativa.tanks.config.loaders.SoundsLibrary;
   import alternativa.tanks.game.entities.tank.IChassisManualControlCallback;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public class ChassisSoundCallback implements IChassisManualControlCallback
   {
      private var var_462:Sound;
      
      private var var_465:Sound;
      
      private var var_464:Sound;
      
      private var var_463:Sound;
      
      private var var_460:SoundChannel;
      
      private var var_461:Boolean = false;
      
      public function ChassisSoundCallback(param1:SoundsLibrary)
      {
         super();
         this.var_462 = param1.getSound("startmoving");
         this.var_465 = param1.getSound("endmoving");
         this.var_464 = param1.getSound("move");
         this.var_463 = param1.getSound("idle");
         this.idleLoop();
      }
      
      public function onControlChanged(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:Boolean = param1 != 0 || param2 != 0;
         if(_loc4_ && !this.var_461)
         {
            if(this.var_460 != null)
            {
               this.var_460.stop();
            }
            this.startMoving();
         }
         else if(!_loc4_ && this.var_461)
         {
            if(this.var_460 != null)
            {
               this.var_460.stop();
            }
            this.stopMoving();
         }
         this.var_461 = _loc4_;
      }
      
      private function stopMoving() : void
      {
         this.idleLoop();
      }
      
      private function onStopMoveComplete(param1:Event) : void
      {
         this.var_460.removeEventListener(Event.SOUND_COMPLETE,this.onStopMoveComplete);
         this.idleLoop();
      }
      
      private function startMoving() : void
      {
         if(this.var_460 != null)
         {
            this.var_460.stop();
         }
         this.var_460 = this.var_462.play();
         this.var_460.addEventListener(Event.SOUND_COMPLETE,this.onStartMoveComplete);
      }
      
      private function onStartMoveComplete(param1:Event) : void
      {
         this.var_460.stop();
         this.moveLoop();
      }
      
      private function moveLoop() : void
      {
         this.var_460 = this.var_464.play(0);
         this.var_460.addEventListener(Event.SOUND_COMPLETE,this.onMoveLoop);
      }
      
      private function onMoveLoop(param1:Event) : void
      {
         this.var_460.removeEventListener(Event.SOUND_COMPLETE,this.onMoveLoop);
         this.moveLoop();
      }
      
      private function idleLoop() : void
      {
         this.var_460 = this.var_463.play(0);
         this.var_460.addEventListener(Event.SOUND_COMPLETE,this.onIdleLoop);
      }
      
      private function onIdleLoop(param1:Event) : void
      {
         this.var_460.removeEventListener(Event.SOUND_COMPLETE,this.onIdleLoop);
         this.idleLoop();
      }
      
      public function onSync() : void
      {
      }
   }
}

