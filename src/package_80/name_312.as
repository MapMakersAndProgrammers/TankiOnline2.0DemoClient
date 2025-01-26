package package_80
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import package_41.name_173;
   import package_71.class_29;
   
   public class name_312 implements class_29
   {
      private var var_462:Sound;
      
      private var var_465:Sound;
      
      private var var_464:Sound;
      
      private var var_463:Sound;
      
      private var var_460:SoundChannel;
      
      private var var_461:Boolean = false;
      
      public function name_312(param1:name_173)
      {
         super();
         this.var_462 = param1.name_297("startmoving");
         this.var_465 = param1.name_297("endmoving");
         this.var_464 = param1.name_297("move");
         this.var_463 = param1.name_297("idle");
         this.method_449();
      }
      
      public function method_448(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:Boolean = param1 != 0 || param2 != 0;
         if(_loc4_ && !this.var_461)
         {
            if(this.var_460 != null)
            {
               this.var_460.stop();
            }
            this.method_454();
         }
         else if(!_loc4_ && this.var_461)
         {
            if(this.var_460 != null)
            {
               this.var_460.stop();
            }
            this.method_455();
         }
         this.var_461 = _loc4_;
      }
      
      private function method_455() : void
      {
         this.method_449();
      }
      
      private function method_453(param1:Event) : void
      {
         this.var_460.removeEventListener(Event.SOUND_COMPLETE,this.method_453);
         this.method_449();
      }
      
      private function method_454() : void
      {
         if(this.var_460 != null)
         {
            this.var_460.stop();
         }
         this.var_460 = this.var_462.play();
         this.var_460.addEventListener(Event.SOUND_COMPLETE,this.method_456);
      }
      
      private function method_456(param1:Event) : void
      {
         this.var_460.stop();
         this.method_450();
      }
      
      private function method_450() : void
      {
         this.var_460 = this.var_464.play(0);
         this.var_460.addEventListener(Event.SOUND_COMPLETE,this.method_451);
      }
      
      private function method_451(param1:Event) : void
      {
         this.var_460.removeEventListener(Event.SOUND_COMPLETE,this.method_451);
         this.method_450();
      }
      
      private function method_449() : void
      {
         this.var_460 = this.var_463.play(0);
         this.var_460.addEventListener(Event.SOUND_COMPLETE,this.method_452);
      }
      
      private function method_452(param1:Event) : void
      {
         this.var_460.removeEventListener(Event.SOUND_COMPLETE,this.method_452);
         this.method_449();
      }
      
      public function method_447() : void
      {
      }
   }
}

