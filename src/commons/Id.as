package commons
{
   public class Id
   {
      private var name_3I:uint;
      
      public function Id(id:uint)
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
         var result:String = "Id [";
         result += "id = " + this.id + " ";
         return result + "]";
      }
   }
}

