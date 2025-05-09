package alternativa.engine3d.animation.keys
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class Keyframe
   {
      alternativa3d var var_420:Number = 0;
      
      public function Keyframe()
      {
         super();
      }
      
      public function get time() : Number
      {
         return this.alternativa3d::var_420;
      }
      
      public function get value() : Object
      {
         return null;
      }
      
      public function set value(v:Object) : void
      {
      }
      
      alternativa3d function get nextKeyFrame() : Keyframe
      {
         return null;
      }
      
      alternativa3d function set nextKeyFrame(value:Keyframe) : void
      {
      }
      
      public function toString() : String
      {
         return "[Keyframe time = " + this.alternativa3d::var_420.toFixed(2) + " value = " + this.value + "]";
      }
   }
}

