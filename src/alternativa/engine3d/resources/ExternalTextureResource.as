package alternativa.engine3d.resources
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.display3D.textures.TextureBase;
   
   use namespace alternativa3d;
   
   public class ExternalTextureResource extends TextureResource
   {
      public var url:String;
      
      public function ExternalTextureResource(url:String)
      {
         super();
         this.url = url;
      }
      
      override public function upload(context3D:Context3D) : void
      {
      }
      
      public function get data() : TextureBase
      {
         return alternativa3d::_texture;
      }
      
      public function set data(value:TextureBase) : void
      {
         alternativa3d::_texture = value;
      }
   }
}

