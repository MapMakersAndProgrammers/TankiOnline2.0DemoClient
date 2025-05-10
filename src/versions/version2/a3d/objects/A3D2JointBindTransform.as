package versions.version2.a3d.objects
{
   import alternativa.types.Long;
   
   public class A3D2JointBindTransform
   {
      private var name_NL:A3D2Transform;
      
      private var name_3I:Long;
      
      public function A3D2JointBindTransform(bindPoseTransform:A3D2Transform, id:Long)
      {
         super();
         this.name_NL = bindPoseTransform;
         this.name_3I = id;
      }
      
      public function get bindPoseTransform() : A3D2Transform
      {
         return this.name_NL;
      }
      
      public function set bindPoseTransform(value:A3D2Transform) : void
      {
         this.name_NL = value;
      }
      
      public function get id() : Long
      {
         return this.name_3I;
      }
      
      public function set id(value:Long) : void
      {
         this.name_3I = value;
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

