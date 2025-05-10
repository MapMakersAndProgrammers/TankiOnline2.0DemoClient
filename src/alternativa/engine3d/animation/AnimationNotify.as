package alternativa.engine3d.animation
{
   import alternativa.engine3d.alternativa3d;
   import flash.events.EventDispatcher;
   
   use namespace alternativa3d;
   
   public class AnimationNotify extends EventDispatcher
   {
      public var name:String;
      
      alternativa3d var name_qC:Number = 0;
      
      alternativa3d var next:AnimationNotify;
      
      alternativa3d var name_1n:Number;
      
      alternativa3d var name_XY:AnimationNotify;
      
      public function AnimationNotify(name:String)
      {
         super();
         this.name = name;
      }
      
      public function get time() : Number
      {
         return this.name_qC;
      }
   }
}

