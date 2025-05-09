package versions.version2.a3d.animation
{
   public class A3D2Track
   {
      private var var_101:int;
      
      private var var_288:Vector.<A3D2Keyframe>;
      
      private var var_289:String;
      
      public function A3D2Track(id:int, keyframes:Vector.<A3D2Keyframe>, objectName:String)
      {
         super();
         this.var_101 = id;
         this.var_288 = keyframes;
         this.var_289 = objectName;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
      }
      
      public function get keyframes() : Vector.<A3D2Keyframe>
      {
         return this.var_288;
      }
      
      public function set keyframes(value:Vector.<A3D2Keyframe>) : void
      {
         this.var_288 = value;
      }
      
      public function get objectName() : String
      {
         return this.var_289;
      }
      
      public function set objectName(value:String) : void
      {
         this.var_289 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Track [";
         result += "id = " + this.id + " ";
         result += "keyframes = " + this.keyframes + " ";
         result += "objectName = " + this.objectName + " ";
         return result + "]";
      }
   }
}

