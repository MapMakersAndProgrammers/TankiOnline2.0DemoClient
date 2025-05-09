package alternativa.tanks
{
   import alternativa.engine3d.resources.ATFTextureResource;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public interface ITextureResourceService
   {
      function getCompressedTextureResource(param1:ByteArray) : ATFTextureResource;
      
      function releaseCompressedTextureResource(param1:ByteArray) : void;
      
      function getBitmapTextureResource(param1:BitmapData) : BitmapTextureResource;
      
      function releaseBitmapTextureResource(param1:BitmapData) : void;
   }
}

