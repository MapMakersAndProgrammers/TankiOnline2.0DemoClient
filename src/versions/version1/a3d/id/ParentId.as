package versions.version1.a3d.id
{
   public class ParentId
   {
      private var name_3I:uint;
      
      public function ParentId(id:uint)
      {
         super();
         this.name_3I = id;
      }
      
      public function get id() : uint
      {
         return this.name_3I;
      }
      
      public function set id(value:uint) : void
      {
         this.name_3I = value;
      }
      
      public function toString() : String
      {
         var result:String = "ParentId [";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

