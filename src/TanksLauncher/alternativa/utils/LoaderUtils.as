package alternativa.utils
{
   import flash.utils.ByteArray;
   
   public class LoaderUtils
   {
      
      public function LoaderUtils()
      {
         super();
      }
      
      public static function getResourcePath(resourceId:ByteArray, resourceVersion:uint) : String
      {
         return "/" + resourceId.readUnsignedInt().toString(8) + "/" + resourceId.readUnsignedShort().toString(8) + "/" + resourceId.readUnsignedByte().toString(8) + "/" + resourceId.readUnsignedByte().toString(8) + "/" + resourceVersion.toString(8) + "/";
      }
   }
}

