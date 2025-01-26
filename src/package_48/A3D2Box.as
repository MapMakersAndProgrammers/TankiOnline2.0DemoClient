package package_48
{
   public class A3D2Box
   {
      private var var_290:Vector.<Number>;
      
      private var var_101:int;
      
      public function A3D2Box(box:Vector.<Number>, id:int)
      {
         super();
         this.var_290 = box;
         this.var_101 = id;
      }
      
      public function get box() : Vector.<Number>
      {
         return this.var_290;
      }
      
      public function set box(value:Vector.<Number>) : void
      {
         this.var_290 = value;
      }
      
      public function get id() : int
      {
         return this.var_101;
      }
      
      public function set id(value:int) : void
      {
         this.var_101 = value;
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

