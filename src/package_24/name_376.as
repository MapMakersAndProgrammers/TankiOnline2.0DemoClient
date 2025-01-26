package package_24
{
   import alternativa.engine3d.alternativa3d;
   import package_21.name_116;
   import package_21.name_124;
   import package_21.name_397;
   import package_21.name_78;
   
   use namespace alternativa3d;
   
   public class name_376 extends name_116
   {
      public function name_376(color:uint)
      {
         super();
         this.color = color;
      }
      
      override alternativa3d function calculateVisibility(camera:name_124) : void
      {
         camera.alternativa3d::ambient[0] += (color >> 16 & 0xFF) * intensity / 255;
         camera.alternativa3d::ambient[1] += (color >> 8 & 0xFF) * intensity / 255;
         camera.alternativa3d::ambient[2] += (color & 0xFF) * intensity / 255;
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
         var res:name_376 = new name_376(color);
         res.clonePropertiesFrom(this);
         return res;
      }
   }
}

