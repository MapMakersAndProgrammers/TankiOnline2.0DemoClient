package alternativa.engine3d.core
{
   import flash.display3D.Context3D;
   
   public class Resource
   {
      public function Resource()
      {
         super();
      }
      
      public function get isUploaded() : Boolean
      {
         return false;
      }
      
      public function upload(context3D:Context3D) : void
      {
         throw new Error("Cannot upload without data");
      }
      
      public function dispose() : void
      {
      }
   }
}

