package versions.version2.a3d.objects
{
   public class A3D2Surface
   {
      private var name_50:int;
      
      private var name_pS:int;
      
      private var name_4C:int;
      
      public function A3D2Surface(indexBegin:int, materialId:int, numTriangles:int)
      {
         super();
         this.name_50 = indexBegin;
         this.name_pS = materialId;
         this.name_4C = numTriangles;
      }
      
      public function get indexBegin() : int
      {
         return this.name_50;
      }
      
      public function set indexBegin(value:int) : void
      {
         this.name_50 = value;
      }
      
      public function get materialId() : int
      {
         return this.name_pS;
      }
      
      public function set materialId(value:int) : void
      {
         this.name_pS = value;
      }
      
      public function get numTriangles() : int
      {
         return this.name_4C;
      }
      
      public function set numTriangles(value:int) : void
      {
         this.name_4C = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D2Surface [";
         result += "indexBegin = " + this.indexBegin + " ";
         result += "materialId = " + this.materialId + " ";
         result += "numTriangles = " + this.numTriangles + " ";
         return result + "]";
      }
   }
}

