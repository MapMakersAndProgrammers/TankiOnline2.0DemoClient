package versions.version2.a3d.objects
{
   public class A3D2Box
   {
      private var name_Ge:Vector.<Number>;
      
      private var name_3I:int;
      
      public function A3D2Box(box:Vector.<Number>, id:int)
      {
         super();
         this.name_Ge = box;
         this.name_3I = id;
      }
      
      public function get box() : Vector.<Number>
      {
         return this.name_Ge;
      }
      
      public function set box(value:Vector.<Number>) : void
      {
         this.name_Ge = value;
      }
      
      public function get id() : int
      {
         return this.name_3I;
      }
      
      public function set id(value:int) : void
      {
         this.name_3I = value;
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

