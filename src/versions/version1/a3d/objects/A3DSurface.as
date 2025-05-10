package versions.version1.a3d.objects
{
   import commons.Id;
   
   public class A3DSurface
   {
      private var name_50:int;
      
      private var name_pS:Id;
      
      private var name_4C:int;
      
      public function A3DSurface(indexBegin:int, materialId:Id, numTriangles:int)
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
      
      public function get materialId() : Id
      {
         return this.name_pS;
      }
      
      public function set materialId(value:Id) : void
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
         var result:String = "A3DSurface [";
         result += "indexBegin = " + this.indexBegin + " ";
         result += "materialId = " + this.materialId + " ";
         result += "numTriangles = " + this.numTriangles + " ";
         return result + "]";
      }
   }
}

