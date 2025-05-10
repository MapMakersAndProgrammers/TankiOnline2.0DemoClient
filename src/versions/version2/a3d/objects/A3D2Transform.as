package versions.version2.a3d.objects
{
   import commons.A3DMatrix;
   
   public class A3D2Transform
   {
      private var name_6p:A3DMatrix;
      
      public function A3D2Transform(matrix:A3DMatrix)
      {
         super();
         this.name_6p = matrix;
      }
      
      public function get matrix() : A3DMatrix
      {
         return this.name_6p;
      }
      
      public function set matrix(value:A3DMatrix) : void
      {
         this.name_6p = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Transform [";
         result += "matrix = " + this.matrix + " ";
         return result + "]";
      }
   }
}

