package alternativa.tanks.sounds
{
   import alternativa.tanks.config.loaders.SoundsLibrary;
   import alternativa.tanks.game.entities.tank.IChassisManualControlCallback;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public class ChassisSoundCallback implements IChassisManualControlCallback
   {
      private var §_-9N§:Sound;
      
      private var §_-dF§:Sound;
      
      private var §_-ik§:Sound;
      
      private var §_-QG§:Sound;
      
      private var §_-qB§:SoundChannel;
      
      private var §_-kx§:Boolean = false;
      
      public function ChassisSoundCallback(param1:SoundsLibrary)
      {
         super();
         this.§_-9N§ = param1.getSound("startmoving");
         this.§_-dF§ = param1.getSound("endmoving");
         this.§_-ik§ = param1.getSound("move");
         this.§_-QG§ = param1.getSound("idle");
         this.idleLoop();
      }
      
      public function onControlChanged(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:Boolean = param1 != 0 || param2 != 0;
         if(_loc4_ && !this.§_-kx§)
         {
            if(this.§_-qB§ != null)
            {
               this.§_-qB§.stop();
            }
            this.startMoving();
         }
         else if(!_loc4_ && this.§_-kx§)
         {
            if(this.§_-qB§ != null)
            {
               this.§_-qB§.stop();
            }
            this.stopMoving();
         }
         this.§_-kx§ = _loc4_;
      }
      
      private function stopMoving() : void
      {
         this.idleLoop();
      }
      
      private function onStopMoveComplete(param1:Event) : void
      {
         this.§_-qB§.removeEventListener(Event.SOUND_COMPLETE,this.onStopMoveComplete);
         this.idleLoop();
      }
      
      private function startMoving() : void
      {
         if(this.§_-qB§ != null)
         {
            this.§_-qB§.stop();
         }
         this.§_-qB§ = this.§_-9N§.play();
         this.§_-qB§.addEventListener(Event.SOUND_COMPLETE,this.onStartMoveComplete);
      }
      
      private function onStartMoveComplete(param1:Event) : void
      {
         this.§_-qB§.stop();
         this.moveLoop();
      }
      
      private function moveLoop() : void
      {
         this.§_-qB§ = this.§_-ik§.play(0);
         this.§_-qB§.addEventListener(Event.SOUND_COMPLETE,this.onMoveLoop);
      }
      
      private function onMoveLoop(param1:Event) : void
      {
         this.§_-qB§.removeEventListener(Event.SOUND_COMPLETE,this.onMoveLoop);
         this.moveLoop();
      }
      
      private function idleLoop() : void
      {
         this.§_-qB§ = this.§_-QG§.play(0);
         this.§_-qB§.addEventListener(Event.SOUND_COMPLETE,this.onIdleLoop);
      }
      
      private function onIdleLoop(param1:Event) : void
      {
         this.§_-qB§.removeEventListener(Event.SOUND_COMPLETE,this.onIdleLoop);
         this.idleLoop();
      }
      
      public function onSync() : void
      {
      }
   }
}

