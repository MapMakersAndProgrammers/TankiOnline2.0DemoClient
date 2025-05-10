package alternativa.engine3d.lights
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   
   use namespace alternativa3d;
   
   public class AmbientLight extends Light3D
   {
      public function AmbientLight(color:uint)
      {
         super();
         this.color = color;
      }
      
      override alternativa3d function calculateVisibility(camera:Camera3D) : void
      {
         camera.alternativa3d::ambient[0] += (color >> 16 & 0xFF) * intensity / 255;
         camera.alternativa3d::ambient[1] += (color >> 8 & 0xFF) * intensity / 255;
         camera.alternativa3d::ambient[2] += (color & 0xFF) * intensity / 255;
      }
      
      override alternativa3d function collectDraws(camera:Camera3D, lights:Vector.<Light3D>, lightsLength:int) : void
      {
         var debug:int = 0;
         if(camera.debug)
         {
            debug = camera.alternativa3d::checkInDebug(this);
            if(Boolean(debug & Debug.BOUNDS) && boundBox != null)
            {
               Debug.alternativa3d::drawBoundBox(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override public function clone() : Object3D
      {
         var res:AmbientLight = new AmbientLight(color);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

