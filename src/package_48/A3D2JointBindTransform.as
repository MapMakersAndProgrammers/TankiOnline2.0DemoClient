package package_48
{
   import package_33.name_155;
   
   public class A3D2JointBindTransform
   {
      private var var_417:A3D2Transform;
      
      private var var_101:name_155;
      
      public function A3D2JointBindTransform(bindPoseTransform:A3D2Transform, id:name_155)
      {
         super();
         this.var_417 = bindPoseTransform;
         this.var_101 = id;
      }
      
      public function get bindPoseTransform() : A3D2Transform
      {
         return this.var_417;
      }
      
      public function set bindPoseTransform(value:A3D2Transform) : void
      {
         this.var_417 = value;
      }
      
      public function get id() : name_155
      {
         return this.var_101;
      }
      
      public function set id(value:name_155) : void
      {
         this.var_101 = value;
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

