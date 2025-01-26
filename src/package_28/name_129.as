package package_28
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.textures.TextureBase;
   import package_21.name_77;
   
   use namespace alternativa3d;
   
   public class name_129 extends name_77
   {
      alternativa3d var _texture:TextureBase;
      
      public function name_129()
      {
         super();
      }
      
      override public function get isUploaded() : Boolean
      {
         return this.alternativa3d::_texture != null;
      }
      
      override public function dispose() : void
      {
         if(this.alternativa3d::_texture != null)
         {
            this.alternativa3d::_texture.dispose();
            this.alternativa3d::_texture = null;
         }
      }
   }
}

