package versions.version1.a3d.objects
{
   import commons.Id;
   
   public class A3DSurface
   {
      private var var_300:int;
      
      private var var_301:Id;
      
      private var var_299:int;
      
      public function A3DSurface(indexBegin:int, materialId:Id, numTriangles:int)
      {
         super();
         this.var_300 = indexBegin;
         this.var_301 = materialId;
         this.var_299 = numTriangles;
      }
      
      public function get indexBegin() : int
      {
         return this.var_300;
      }
      
      public function set indexBegin(value:int) : void
      {
         this.var_300 = value;
      }
      
      public function get materialId() : Id
      {
         return this.var_301;
      }
      
      public function set materialId(value:Id) : void
      {
         this.var_301 = value;
      }
      
      public function get numTriangles() : int
      {
         return this.var_299;
      }
      
      public function set numTriangles(value:int) : void
      {
         this.var_299 = value;
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

