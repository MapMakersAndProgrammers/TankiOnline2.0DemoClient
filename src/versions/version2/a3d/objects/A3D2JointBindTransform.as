package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2JointBindTransform
   {
      private var §_-NL§:A3D2Transform;
      
      private var §_-3I§:Long;
      
      public function A3D2JointBindTransform(bindPoseTransform:A3D2Transform, id:Long)
      {
         super();
         this.§_-NL§ = bindPoseTransform;
         this.§_-3I§ = id;
      }
      
      public function get bindPoseTransform() : A3D2Transform
      {
         return this.§_-NL§;
      }
      
      public function set bindPoseTransform(value:A3D2Transform) : void
      {
         this.§_-NL§ = value;
      }
      
      public function get id() : Long
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Long) : void
      {
         this.§_-3I§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2JointBindTransform [";
         result += "bindPoseTransform = " + this.bindPoseTransform + " ";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

