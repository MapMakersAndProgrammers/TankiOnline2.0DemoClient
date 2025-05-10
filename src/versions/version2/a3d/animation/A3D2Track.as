package versions.version2.a3d.animation
{
   public class A3D2Track
   {
      private var §_-3I§:int;
      
      private var §_-1§:Vector.<A3D2Keyframe>;
      
      private var §_-pa§:String;
      
      public function A3D2Track(id:int, keyframes:Vector.<A3D2Keyframe>, objectName:String)
      {
         super();
         this.§_-3I§ = id;
         this.§_-1§ = keyframes;
         this.§_-pa§ = objectName;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function get keyframes() : Vector.<A3D2Keyframe>
      {
         return this.§_-1§;
      }
      
      public function set keyframes(value:Vector.<A3D2Keyframe>) : void
      {
         this.§_-1§ = value;
      }
      
      public function get objectName() : String
      {
         return this.§_-pa§;
      }
      
      public function set objectName(value:String) : void
      {
         this.§_-pa§ = value;
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

