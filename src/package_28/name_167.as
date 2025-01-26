package package_28
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.display3D.textures.TextureBase;
   
   use namespace alternativa3d;
   
   public class name_167 extends name_129
   {
      public var url:String;
      
      public function name_167(url:String)
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

