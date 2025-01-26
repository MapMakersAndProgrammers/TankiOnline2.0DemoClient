package package_50
{
   import package_57.name_213;
   
   public class A3DBox
   {
      private var var_290:Vector.<Number>;
      
      private var var_101:name_213;
      
      public function A3DBox(box:Vector.<Number>, id:name_213)
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
      
      public function get id() : name_213
      {
         return this.var_101;
      }
      
      public function set id(value:name_213) : void
      {
         this.var_101 = value;
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

