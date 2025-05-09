package versions.version1.a3d.objects
{
   import commons.A3DMatrix;
   
   public class A3DTransformation
   {
      private var var_412:A3DMatrix;
      
      public function A3DTransformation(matrix:A3DMatrix)
      {
         super();
         this.var_412 = matrix;
      }
      
      public function get matrix() : A3DMatrix
      {
         return this.var_412;
      }
      
      public function set matrix(value:A3DMatrix) : void
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

