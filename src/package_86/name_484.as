package package_86
{
   import package_46.Matrix4;
   import package_46.name_194;
   
   public class name_484
   {
      public var hs:name_194;
      
      public var matrix:Matrix4;
      
      public function name_484(hs:name_194, matrix:Matrix4)
      {
         super();
         this.hs = hs;
         this.matrix = matrix;
      }
      
      public function toString() : String
      {
         return "BoxData(hs=" + this.hs + ", matrix=" + this.matrix + ")";
      }
   }
}

