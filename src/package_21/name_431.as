package package_21
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class name_431 extends name_78
   {
      public function name_431()
      {
         super();
      }
      
      override alternativa3d function calculateVisibility(camera:name_124) : void
      {
         camera.alternativa3d::occluders[camera.alternativa3d::occludersLength] = this;
         ++camera.alternativa3d::occludersLength;
      }
   }
}

