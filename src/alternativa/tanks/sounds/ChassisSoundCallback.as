package alternativa.tanks.sounds
{
   import alternativa.tanks.config.loaders.SoundsLibrary;
   import alternativa.tanks.game.entities.tank.IChassisManualControlCallback;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public class ChassisSoundCallback implements IChassisManualControlCallback
   {
      private var name_9N:Sound;
      
      private var name_dF:Sound;
      
      private var name_ik:Sound;
      
      private var name_QG:Sound;
      
      private var name_qB:SoundChannel;
      
      private var name_kx:Boolean = false;
      
      public function ChassisSoundCallback(param1:SoundsLibrary)
      {
         super();
         this.name_9N = param1.getSound("startmoving");
         this.name_dF = param1.getSound("endmoving");
         this.name_ik = param1.getSound("move");
         this.name_QG = param1.getSound("idle");
         this.idleLoop();
      }
      
      public function onControlChanged(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:Boolean = param1 != 0 || param2 != 0;
         if(_loc4_ && !this.name_kx)
         {
            if(this.name_qB != null)
            {
               this.name_qB.stop();
            }
            this.startMoving();
         }
         else if(!_loc4_ && this.name_kx)
         {
            if(this.name_qB != null)
            {
               this.name_qB.stop();
            }
            this.stopMoving();
         }
         this.name_kx = _loc4_;
      }
      
      private function stopMoving() : void
      {
         this.idleLoop();
      }
      
      private function onStopMoveComplete(param1:Event) : void
      {
         this.name_qB.removeEventListener(Event.SOUND_COMPLETE,this.onStopMoveComplete);
         this.idleLoop();
      }
      
      private function startMoving() : void
      {
         if(this.name_qB != null)
         {
            this.name_qB.stop();
         }
         this.name_qB = this.name_9N.play();
         this.name_qB.addEventListener(Event.SOUND_COMPLETE,this.onStartMoveComplete);
      }
      
      private function onStartMoveComplete(param1:Event) : void
      {
         this.name_qB.stop();
         this.moveLoop();
      }
      
      private function moveLoop() : void
      {
         this.name_qB = this.name_ik.play(0);
         this.name_qB.addEventListener(Event.SOUND_COMPLETE,this.onMoveLoop);
      }
      
      private function onMoveLoop(param1:Event) : void
      {
         this.name_qB.removeEventListener(Event.SOUND_COMPLETE,this.onMoveLoop);
         this.moveLoop();
      }
      
      private function idleLoop() : void
      {
         this.name_qB = this.name_QG.play(0);
         this.name_qB.addEventListener(Event.SOUND_COMPLETE,this.onIdleLoop);
      }
      
      private function onIdleLoop(param1:Event) : void
      {
         this.name_qB.removeEventListener(Event.SOUND_COMPLETE,this.onIdleLoop);
         this.idleLoop();
      }
      
      public function onSync() : void
      {
      }
   }
}

