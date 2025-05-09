package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.objects.WireFrame;
   import flash.utils.Dictionary;
   
   use namespace alternativa3d;
   
   public class Debug
   {
      public static const BOUNDS:int = 8;
      
      private static var boundWires:Dictionary = new Dictionary();
      
      public function Debug()
      {
         super();
      }
      
      private static function createBoundWire() : WireFrame
      {
         var res:WireFrame = new WireFrame();
         res.alternativa3d::geometry.alternativa3d::addLine(-0.5,-0.5,-0.5,0.5,-0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(0.5,-0.5,-0.5,0.5,0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(0.5,0.5,-0.5,-0.5,0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(-0.5,0.5,-0.5,-0.5,-0.5,-0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(-0.5,-0.5,0.5,0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(0.5,-0.5,0.5,0.5,0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(0.5,0.5,0.5,-0.5,0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(-0.5,0.5,0.5,-0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(-0.5,-0.5,-0.5,-0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(0.5,-0.5,-0.5,0.5,-0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(0.5,0.5,-0.5,0.5,0.5,0.5);
         res.alternativa3d::geometry.alternativa3d::addLine(-0.5,0.5,-0.5,-0.5,0.5,0.5);
         return res;
      }
      
      alternativa3d static function drawBoundBox(camera:Camera3D, boundBox:BoundBox, transform:Transform3D, color:int = -1) : void
      {
         var boundWire:WireFrame = boundWires[camera.alternativa3d::context3D];
         if(boundWire == null)
         {
            boundWire = createBoundWire();
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

