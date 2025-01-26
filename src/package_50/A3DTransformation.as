package package_50
{
   import package_57.name_214;
   
   public class A3DTransformation
   {
      private var var_412:name_214;
      
      public function A3DTransformation(matrix:name_214)
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
         var result:String = "A3DTransformation [";
         result += "matrix = " + this.matrix + " ";
         return result + "]";
      }
   }
}

