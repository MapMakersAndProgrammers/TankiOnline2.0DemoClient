package package_125
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class name_778 extends name_748
   {
      alternativa3d var name_781:Number = 0;
      
      alternativa3d var next:name_778;
      
      public function name_778()
      {
         super();
      }
      
      public function interpolate(a:name_778, b:name_778, c:Number) : void
      {
         this.alternativa3d::name_781 = (1 - c) * a.alternativa3d::name_781 + c * b.alternativa3d::name_781;
      }
      
      override public function get value() : Object
      {
         return this.alternativa3d::name_781;
      }
      
      override public function set value(v:Object) : void
      {
         this.alternativa3d::name_781 = Number(v);
      }
      
      override alternativa3d function get nextKeyFrame() : name_748
      {
         return this.alternativa3d::next;
      }
      
      override alternativa3d function set nextKeyFrame(value:name_748) : void
      {
         this.alternativa3d::next = name_778(value);
      }
   }
}

