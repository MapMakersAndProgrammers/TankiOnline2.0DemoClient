package alternativa.tanks
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import package_28.name_241;
   import package_28.name_93;
   
   public interface ITextureResourceService
   {
      function getCompressedTextureResource(param1:ByteArray) : name_241;
      
      function releaseCompressedTextureResource(param1:ByteArray) : void;
      
      function getBitmapTextureResource(param1:BitmapData) : name_93;
      
      function releaseBitmapTextureResource(param1:BitmapData) : void;
   }
}

