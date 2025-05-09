package versions.version1.a3d.id
{
   public class ParentId
   {
      private var var_101:uint;
      
      public function ParentId(id:uint)
      {
         super();
         this.var_101 = id;
      }
      
      public function get id() : uint
      {
         return this.var_101;
      }
      
      public function set id(value:uint) : void
      {
         this.var_101 = value;
      }
      
      public function toString() : String
      {
         var result:String = "ParentId [";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

