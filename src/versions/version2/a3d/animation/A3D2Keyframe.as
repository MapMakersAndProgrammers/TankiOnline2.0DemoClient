package versions.version2.a3d.animation
{
   import versions.version2.a3d.objects.A3D2Transform;
   
   public class A3D2Keyframe
   {
      private var name_qC:Number;
      
      private var name_bP:A3D2Transform;
      
      public function A3D2Keyframe(time:Number, transform:A3D2Transform)
      {
         super();
         this.name_qC = time;
         this.name_bP = transform;
      }
      
      public function get time() : Number
      {
         return this.name_qC;
      }
      
      public function set time(value:Number) : void
      {
         this.name_qC = value;
      }
      
      public function get transform() : A3D2Transform
      {
         return this.name_bP;
      }
      
      public function set transform(value:A3D2Transform) : void
      {
         this.name_bP = value;
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

