package package_55
{
   import package_48.A3D2Transform;
   
   public class A3D2Keyframe
   {
      private var var_420:Number;
      
      private var var_262:A3D2Transform;
      
      public function A3D2Keyframe(time:Number, transform:A3D2Transform)
      {
         super();
         this.var_420 = time;
         this.var_262 = transform;
      }
      
      public function get time() : Number
      {
         return this.var_420;
      }
      
      public function set time(value:Number) : void
      {
         this.var_420 = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.var_262;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.var_262 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Keyframe [";
         result += "time = " + this.time + " ";
         result += "transform = " + this.transform + " ";
         return result + "]";
      }
   }
}

