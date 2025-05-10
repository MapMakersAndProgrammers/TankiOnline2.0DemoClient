package versions.version2.a3d.animation
{
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class A3D2Keyframe
   {
      private var §_-qC§:Number;
      
      private var §_-bP§:A3D2Transform;
      
      public function A3D2Keyframe(time:Number, transform:A3D2Transform)
      {
         super();
         this.§_-qC§ = time;
         this.§_-bP§ = transform;
      }
      
      public function get time() : Number
      {
         return this.§_-qC§;
      }
      
      public function set time(value:Number) : void
      {
         this.§_-qC§ = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.§_-bP§;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.§_-bP§ = value;
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

