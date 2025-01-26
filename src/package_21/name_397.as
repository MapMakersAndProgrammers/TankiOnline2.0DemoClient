package package_21
{
   import alternativa.engine3d.alternativa3d;
   import flash.utils.Dictionary;
   import package_19.name_509;
   
   use namespace alternativa3d;
   
   public class name_397
   {
      public static const BOUNDS:int = 8;
      
      private static var boundWires:Dictionary = new Dictionary();
      
      public function name_397()
      {
         super();
      }
      
      private static function method_643() : name_509
      {
         var res:name_509 = new name_509();
         res.alternativa3d::geometry.alternativa3d::method_558(-0.5,-0.5,-0.5,0.5,-0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(0.5,-0.5,-0.5,0.5,0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(0.5,0.5,-0.5,-0.5,0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(-0.5,0.5,-0.5,-0.5,-0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(-0.5,-0.5,0.5,0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(0.5,-0.5,0.5,0.5,0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(0.5,0.5,0.5,-0.5,0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(-0.5,0.5,0.5,-0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(-0.5,-0.5,-0.5,-0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(0.5,-0.5,-0.5,0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(0.5,0.5,-0.5,0.5,0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::method_558(-0.5,0.5,-0.5,-0.5,0.5,0.5);
         return res;
      }
      
      alternativa3d static function name_399(camera:name_124, boundBox:name_386, transform:name_139, color:int = -1) : void
      {
         var boundWire:name_509 = boundWires[camera.alternativa3d::context3D];
         if(boundWire == null)
         {
            boundWire = method_643();
            boundWires[camera.alternativa3d::context3D] = boundWire;
            boundWire.alternativa3d::geometry.upload(camera.alternativa3d::context3D);
         }
         boundWire.color = color >= 0 ? uint(color) : 10092288;
         boundWire.thickness = 1;
         boundWire.alternativa3d::transform.compose((boundBox.minX + boundBox.maxX) * 0.5,(boundBox.minY + boundBox.maxY) * 0.5,(boundBox.minZ + boundBox.maxZ) * 0.5,0,0,0,boundBox.maxX - boundBox.minX,boundBox.maxY - boundBox.minY,boundBox.maxZ - boundBox.minZ);
         boundWire.alternativa3d::localToCameraTransform.combine(transform,boundWire.alternativa3d::transform);
         boundWire.alternativa3d::collectDraws(camera,null,0);
      }
   }
}

