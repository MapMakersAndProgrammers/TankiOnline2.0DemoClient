package package_28
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.CubeTexture;
   import flash.display3D.textures.Texture;
   import flash.utils.ByteArray;
   
   use namespace alternativa3d;
   
   public class name_241 extends name_129
   {
      public var data:ByteArray;
      
      public function name_241(data:ByteArray)
      {
         super();
         this.data = data;
      }
      
      override public function upload(context3D:Context3D) : void
      {
         var type:uint = 0;
         var format:String = null;
         if(alternativa3d::_texture != null)
         {
            alternativa3d::_texture.dispose();
         }
         if(this.data != null)
         {
            this.data.position = 6;
            type = uint(this.data.readByte());
            switch(type & 0x7F)
            {
               case 0:
                  format = Context3DTextureFormat.BGRA;
                  break;
               case 1:
                  format = Context3DTextureFormat.BGRA;
                  break;
               case 2:
                  format = Context3DTextureFormat.COMPRESSED;
            }
            if((type & ~0x7F) == 0)
            {
               alternativa3d::_texture = context3D.createTexture(1 << this.data.readByte(),1 << this.data.readByte(),format,false);
               Texture(alternativa3d::_texture).uploadCompressedTextureFromByteArray(this.data,0);
            }
            else
            {
               alternativa3d::_texture = context3D.createCubeTexture(1 << this.data.readByte(),format,false);
               CubeTexture(alternativa3d::_texture).uploadCompressedTextureFromByteArray(this.data,0);
            }
            return;
         }
         alternativa3d::_texture = null;
         throw new Error("Cannot upload without data");
      }
   }
}

