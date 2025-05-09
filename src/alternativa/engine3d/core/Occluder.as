package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class Occluder extends Object3D
   {
      public function Occluder()
      {
         super();
      }
      
      override alternativa3d function calculateVisibility(camera:Camera3D) : void
      {
         camera.alternativa3d::occluders[camera.alternativa3d::occludersLength] = this;
         ++camera.alternativa3d::occludersLength;
      }
   }
}

