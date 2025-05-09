package commons
{
   public class Id
   {
      private var §_-3I§:uint;
      
      public function Id(id:uint)
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
         var result:String = "Id [";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

