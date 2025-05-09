package alternativa.engine3d.objects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.Material;
   
   use namespace alternativa3d;
   
   public class Surface
   {
      public var material:Material;
      
      public var indexBegin:int = 0;
      
      public var numTriangles:int = 0;
      
      alternativa3d var object:Object3D;
      
      public function Surface()
      {
         super();
      }
      
      public function clone() : Surface
      {
         var res:Surface = new Surface();
         res.alternativa3d::object = this.alternativa3d::object;
         res.material = this.material;
         res.indexBegin = this.indexBegin;
         res.numTriangles = this.numTriangles;
         return res;
      }
   }
}

