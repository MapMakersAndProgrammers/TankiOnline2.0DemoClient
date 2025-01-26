package package_24
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_397;
   import package_21.name_78;
   import package_23.name_103;
   
   use namespace alternativa3d;
   
   public class DirectionalLight extends name_116
   {
      public var shadow:name_103;
      
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
      
      override alternativa3d function collectDraws(camera:name_124, lights:Vector.<name_116>, lightsLength:int) : void
      {
         var debug:int = 0;
         if(camera.debug)
         {
            debug = int(camera.alternativa3d::checkInDebug(this));
            if(Boolean(debug & name_397.BOUNDS) && boundBox != null)
            {
               name_397.alternativa3d::name_399(camera,boundBox,alternativa3d::localToCameraTransform);
            }
         }
      }
      
      override public function clone() : name_78
      {
         var res:DirectionalLight = new DirectionalLight(color);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

