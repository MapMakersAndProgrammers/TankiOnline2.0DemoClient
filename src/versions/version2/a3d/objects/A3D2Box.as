package versions.version2.a3d.objects
{
   public class A3D2Box
   {
      private var §_-Ge§:Vector.<Number>;
      
      private var §_-3I§:int;
      
      public function A3D2Box(box:Vector.<Number>, id:int)
      {
         super();
         this.§_-Ge§ = box;
         this.§_-3I§ = id;
      }
      
      public function get box() : Vector.<Number>
      {
         return this.§_-Ge§;
      }
      
      public function set box(value:Vector.<Number>) : void
      {
         this.§_-Ge§ = value;
      }
      
      public function get id() : int
      {
         return this.§_-3I§;
      }
      
      public function set id(value:int) : void
      {
         this.§_-3I§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Box [";
         result += "box = " + this.box + " ";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

