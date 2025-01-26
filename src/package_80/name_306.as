package package_80
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import package_41.name_173;
   import package_71.class_10;
   
   public class name_306 implements class_10
   {
      private var soundLibrary:name_173;
      
      private var var_474:Sound;
      
      private var var_473:SoundChannel = null;
      
      public function name_306(param1:name_173)
      {
         super();
         this.soundLibrary = param1;
         this.var_474 = param1.name_297("turret");
      }
      
      public function onTurretControlChanged(param1:int, param2:Boolean) : void
      {
         if(this.var_473 != null)
         {
            this.var_473.stop();
         }
         if(param1 != 0)
         {
            this.method_476();
         }
      }
      
      private function method_476() : void
      {
         if(this.var_474 != null)
         {
            this.var_473 = this.var_474.play(0,0,new SoundTransform(0.2));
            this.var_473.addEventListener(Event.SOUND_COMPLETE,this.method_475);
         }
      }
      
      private function method_475(param1:Event) : void
      {
         if(this.var_473 != null)
         {
            this.var_473.removeEventListener(Event.SOUND_COMPLETE,this.method_475);
            this.method_476();
         }
      }
   }
}

