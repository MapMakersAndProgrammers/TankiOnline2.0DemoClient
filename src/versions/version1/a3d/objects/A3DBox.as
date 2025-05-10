package versions.version1.a3d.objects
{
   import commons.Id;
   
   public class A3DBox
   {
      private var name_Ge:Vector.<Number>;
      
      private var name_3I:Id;
      
      public function A3DBox(box:Vector.<Number>, id:Id)
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
      
      public function get id() : Id
      {
         return this.name_3I;
      }
      
      public function set id(value:Id) : void
      {
         this.name_3I = value;
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

