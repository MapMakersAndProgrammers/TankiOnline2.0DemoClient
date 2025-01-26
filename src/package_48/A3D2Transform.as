package package_48
{
   import package_57.name_214;
   
   public class A3D2Transform
   {
      private var var_412:name_214;
      
      public function A3D2Transform(matrix:name_214)
      {
         super();
         this.var_412 = matrix;
      }
      
      public function get matrix() : name_214
      {
         return this.var_412;
      }
      
      public function set matrix(value:name_214) : void
      {
         this.var_412 = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Transform [";
         result += "matrix = " + this.matrix + " ";
         return result + "]";
      }
   }
}

