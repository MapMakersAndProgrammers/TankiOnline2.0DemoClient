package versions.version2.a3d.animation
{
   public class A3D2Track
   {
      private var name_3I:int;
      
      private var name_1:Vector.<A3D2Keyframe>;
      
      private var name_pa:String;
      
      public function A3D2Track(id:int, keyframes:Vector.<A3D2Keyframe>, objectName:String)
      {
         super();
         this.name_3I = id;
         this.name_1 = keyframes;
         this.name_pa = objectName;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
      }
      
      public function get keyframes() : Vector.<A3D2Keyframe>
      {
         return this.name_1;
      }
      
      public function set keyframes(value:Vector.<A3D2Keyframe>) : void
      {
         this.name_1 = value;
      }
      
      public function get objectName() : String
      {
         return this.name_pa;
      }
      
      public function set objectName(value:String) : void
      {
         this.name_pa = value;
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

