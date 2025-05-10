package versions.version1.a3d
{
   import versions.version1.a3d.geometry.A3DGeometry;
   import versions.version1.a3d.materials.A3DImage;
   import versions.version1.a3d.materials.A3DMap;
   import versions.version1.a3d.materials.A3DMaterial;
   import versions.version1.a3d.objects.A3DBox;
   import versions.version1.a3d.objects.A3DObject;
   
   public class A3D
   {
      private var §_-0§:Vector.<A3DBox>;
      
      private var OptionalMap:Vector.<A3DGeometry>;
      
      private var §_-ce§:Vector.<A3DImage>;
      
      private var §_-XJ§:Vector.<A3DMap>;
      
      private var §_-22§:Vector.<A3DMaterial>;
      
      private var §_-Kq§:Vector.<A3DObject>;
      
      public function A3D(boxes:Vector.<A3DBox>, geometries:Vector.<A3DGeometry>, images:Vector.<A3DImage>, maps:Vector.<A3DMap>, materials:Vector.<A3DMaterial>, objects:Vector.<A3DObject>)
      {
         super();
         this.§_-0§ = boxes;
         this.OptionalMap = geometries;
         this.§_-ce§ = images;
         this.§_-XJ§ = maps;
         this.§_-22§ = materials;
         this.§_-Kq§ = objects;
      }
      
      public function get boxes() : Vector.<A3DBox>
      {
         return this.§_-0§;
      }
      
      public function set boxes(value:Vector.<A3DBox>) : void
      {
         this.§_-0§ = value;
      }
      
      public function get geometries() : Vector.<A3DGeometry>
      {
         return this.OptionalMap;
      }
      
      public function set geometries(value:Vector.<A3DGeometry>) : void
      {
         this.OptionalMap = value;
      }
      
      public function get images() : Vector.<A3DImage>
      {
         return this.§_-ce§;
      }
      
      public function set images(value:Vector.<A3DImage>) : void
      {
         this.§_-ce§ = value;
      }
      
      public function get maps() : Vector.<A3DMap>
      {
         return this.§_-XJ§;
      }
      
      public function set maps(value:Vector.<A3DMap>) : void
      {
         this.§_-XJ§ = value;
      }
      
      public function get materials() : Vector.<A3DMaterial>
      {
         return this.§_-22§;
      }
      
      public function set materials(value:Vector.<A3DMaterial>) : void
      {
         this.§_-22§ = value;
      }
      
      public function get objects() : Vector.<A3DObject>
      {
         return this.§_-Kq§;
      }
      
      public function set objects(value:Vector.<A3DObject>) : void
      {
         this.§_-Kq§ = value;
      }
      
      public function toString() : String
      {
         var result:String = "A3D [";
         result += "boxes = " + this.boxes + " ";
         result += "geometries = " + this.geometries + " ";
         result += "images = " + this.images + " ";
         result += "maps = " + this.maps + " ";
         result += "materials = " + this.materials + " ";
         result += "objects = " + this.objects + " ";
         return result + "]";
      }
   }
}

