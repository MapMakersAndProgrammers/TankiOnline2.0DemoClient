package package_65
{
   import package_50.A3DBox;
   import package_50.A3DObject;
   import package_53.A3DImage;
   import package_53.A3DMap;
   import package_53.A3DMaterial;
   import package_54.A3DGeometry;
   
   public class name_210
   {
      private var var_349:Vector.<A3DBox>;
      
      private var name_447:Vector.<A3DGeometry>;
      
      private var var_348:Vector.<A3DImage>;
      
      private var var_347:Vector.<A3DMap>;
      
      private var var_350:Vector.<A3DMaterial>;
      
      private var var_346:Vector.<A3DObject>;
      
      public function name_210(boxes:Vector.<A3DBox>, geometries:Vector.<A3DGeometry>, images:Vector.<A3DImage>, maps:Vector.<A3DMap>, materials:Vector.<A3DMaterial>, objects:Vector.<A3DObject>)
      {
         super();
         this.var_349 = boxes;
         this.name_447 = geometries;
         this.var_348 = images;
         this.var_347 = maps;
         this.var_350 = materials;
         this.var_346 = objects;
      }
      
      public function get boxes() : Vector.<A3DBox>
      {
         return this.var_349;
      }
      
      public function set boxes(value:Vector.<A3DBox>) : void
      {
         this.var_349 = value;
      }
      
      public function get geometries() : Vector.<A3DGeometry>
      {
         return this.name_447;
      }
      
      public function set geometries(value:Vector.<A3DGeometry>) : void
      {
         this.name_447 = value;
      }
      
      public function get images() : Vector.<A3DImage>
      {
         return this.var_348;
      }
      
      public function set images(value:Vector.<A3DImage>) : void
      {
         this.var_348 = value;
      }
      
      public function get maps() : Vector.<A3DMap>
      {
         return this.var_347;
      }
      
      public function set maps(value:Vector.<A3DMap>) : void
      {
         this.var_347 = value;
      }
      
      public function get materials() : Vector.<A3DMaterial>
      {
         return this.var_350;
      }
      
      public function set materials(value:Vector.<A3DMaterial>) : void
      {
         this.var_350 = value;
      }
      
      public function get objects() : Vector.<A3DObject>
      {
         return this.var_346;
      }
      
      public function set objects(value:Vector.<A3DObject>) : void
      {
         this.var_346 = value;
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

