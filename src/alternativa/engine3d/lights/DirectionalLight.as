package alternativa.engine3d.lights
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Debug;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.shadows.ShadowRenderer;
   
   use namespace alternativa3d;
   
   public class DirectionalLight extends Light3D
   {
      public var shadow:ShadowRenderer;
      
      public function DirectionalLight(color:uint)
      {
         super();
         this.color = color;
      }
      
      public function lookAt(x:Number, y:Number, z:Number) : void
      {
         var dx:Number = x - this.x;
         var dy:Number = y - this.y;
         var dz:Number = z - this.z;
         rotationX = Math.atan2(dz,Math.sqrt(dx * dx + dy * dy)) - Math.PI / 2;
         rotationY = 0;
         rotationZ = -Math.atan2(dx,dy);
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
         var res:DirectionalLight = new DirectionalLight(color);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

