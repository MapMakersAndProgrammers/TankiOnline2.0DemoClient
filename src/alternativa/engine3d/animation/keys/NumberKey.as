package alternativa.engine3d.animation.keys
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class NumberKey extends Keyframe
   {
      alternativa3d var §_-4O§:Number = 0;
      
      alternativa3d var next:NumberKey;
      
      public function NumberKey()
      {
         super();
      }
      
      public function interpolate(a:NumberKey, b:NumberKey, c:Number) : void
      {
         this.alternativa3d::_-4O = (1 - c) * a.alternativa3d::_-4O + c * b.alternativa3d::_-4O;
      }
      
      override public function get value() : Object
      {
         return this.alternativa3d::_-4O;
      }
      
      override public function set value(v:Object) : void
      {
         this.alternativa3d::_-4O = Number(v);
      }
      
      override alternativa3d function get nextKeyFrame() : Keyframe
      {
         return this.alternativa3d::next;
      }
      
      override alternativa3d function set nextKeyFrame(value:Keyframe) : void
      {
         this.alternativa3d::next = NumberKey(value);
      }
   }
}

