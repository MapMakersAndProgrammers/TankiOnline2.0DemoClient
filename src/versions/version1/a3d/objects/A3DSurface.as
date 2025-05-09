package versions.version1.a3d.objects
{
   import commons.Id;
   
   public class A3DSurface
   {
      private var §_-50§:int;
      
      private var §_-pS§:Id;
      
      private var §_-4C§:int;
      
      public function A3DSurface(indexBegin:int, materialId:Id, numTriangles:int)
      {
         super();
         this.§_-50§ = indexBegin;
         this.§_-pS§ = materialId;
         this.§_-4C§ = numTriangles;
      }
      
      public function get indexBegin() : int
      {
         return this.§_-50§;
      }
      
      public function set indexBegin(value:int) : void
      {
         this.§_-50§ = value;
      }
      
      public function get materialId() : Id
      {
         return this.§_-pS§;
      }
      
      public function set materialId(value:Id) : void
      {
         this.§_-pS§ = value;
      }
      
      public function get numTriangles() : int
      {
         return this.§_-4C§;
      }
      
      public function set numTriangles(value:int) : void
      {
         this.§_-4C§ = value;
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

