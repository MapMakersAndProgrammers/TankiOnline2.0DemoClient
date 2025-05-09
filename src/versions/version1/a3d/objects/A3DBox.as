package versions.version1.a3d.objects
{
   import commons.Id;
   
   public class A3DBox
   {
      private var §_-Ge§:Vector.<Number>;
      
      private var §_-3I§:Id;
      
      public function A3DBox(box:Vector.<Number>, id:Id)
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
      
      public function get id() : Id
      {
         return this.§_-3I§;
      }
      
      public function set id(value:Id) : void
      {
         this.§_-3I§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3DBox [";
         result += "box = " + this.box + " ";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

