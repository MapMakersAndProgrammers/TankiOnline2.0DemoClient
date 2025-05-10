package versions.version1.a3d.id
{
   public class ParentId
   {
      private var §_-3I§:uint;
      
      public function ParentId(id:uint)
      {
         super();
         this.§_-3I§ = id;
      }
      
      public function get id() : uint
      {
         return this.§_-3I§;
      }
      
      public function set id(value:uint) : void
      {
         this.§_-3I§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "ParentId [";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

