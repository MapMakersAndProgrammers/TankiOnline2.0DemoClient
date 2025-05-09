package alternativa.engine3d.resources
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.filters.ConvolutionFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace alternativa3d;
   
   public class BitmapTextureResource extends TextureResource
   {
      private static const rect:Rectangle = new Rectangle();
      
      private static const filter:ConvolutionFilter = new ConvolutionFilter(2,2,[1,1,1,1],4,0,false,true);
      
      private static const matrix:Matrix = new Matrix(0.5,0,0,0.5);
      
      private static const point:Point = new Point();
      
      public var data:BitmapData;
      
      public function BitmapTextureResource(data:BitmapData)
      {
         super();
         this.data = data;
      }
      
      alternativa3d static function createMips(texture:Texture, bitmapData:BitmapData) : void
      {
         rect.width = bitmapData.width;
         rect.height = bitmapData.height;
         var level:int = 1;
         var bmp:BitmapData = new BitmapData(rect.width,rect.height,bitmapData.transparent);
         var current:BitmapData = bitmapData;
         while(rect.width % 2 == 0 || rect.height % 2 == 0)
         {
            bmp.applyFilter(current,rect,point,filter);
            rect.width >>= 1;
            rect.height >>= 1;
            if(rect.width == 0)
            {
               rect.width = 1;
            }
            if(rect.height == 0)
            {
               rect.height = 1;
            }
            if(current != bitmapData)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,bitmapData.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            texture.uploadFromBitmapData(current,level++);
         }
         if(current != bitmapData)
         {
            current.dispose();
         }
         bmp.dispose();
      }
      
      override public function upload(context3D:Context3D) : void
      {
         var level:int = 0;
         var bmp:BitmapData = null;
         var current:BitmapData = null;
         if(alternativa3d::_texture != null)
         {
            alternativa3d::_texture.dispose();
         }
         if(this.data != null)
         {
            alternativa3d::_texture = context3D.createTexture(this.data.width,this.data.height,Context3DTextureFormat.BGRA,false);
            filter.preserveAlpha = !this.data.transparent;
            Texture(alternativa3d::_texture).uploadFromBitmapData(this.data,0);
            level = 1;
            bmp = new BitmapData(this.data.width,this.data.height,this.data.transparent);
            current = this.data;
            rect.width = this.data.width;
            rect.height = this.data.height;
            while(rect.width % 2 == 0 || rect.height % 2 == 0)
            {
               bmp.applyFilter(current,rect,point,filter);
               rect.width >>= 1;
               rect.height >>= 1;
               if(rect.width == 0)
               {
                  rect.width = 1;
               }
               if(rect.height == 0)
               {
                  rect.height = 1;
               }
               if(current != this.data)
               {
                  current.dispose();
               }
               current = new BitmapData(rect.width,rect.height,this.data.transparent,0);
               current.draw(bmp,matrix,null,null,null,false);
               Texture(alternativa3d::_texture).uploadFromBitmapData(current,level++);
            }
            if(current != this.data)
            {
               current.dispose();
            }
            bmp.dispose();
            return;
         }
         alternativa3d::_texture = null;
         throw new Error("Cannot upload without data");
      }
      
      alternativa3d function createMips(texture:Texture, bitmapData:BitmapData) : void
      {
         rect.width = bitmapData.width;
         rect.height = bitmapData.height;
         var level:int = 1;
         var bmp:BitmapData = new BitmapData(rect.width,rect.height,bitmapData.transparent);
         var current:BitmapData = bitmapData;
         while(rect.width % 2 == 0 || rect.height % 2 == 0)
         {
            bmp.applyFilter(current,rect,point,filter);
            rect.width >>= 1;
            rect.height >>= 1;
            if(rect.width == 0)
            {
               rect.width = 1;
            }
            if(rect.height == 0)
            {
               rect.height = 1;
            }
            if(current != bitmapData)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,bitmapData.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            texture.uploadFromBitmapData(current,level++);
         }
         if(current != bitmapData)
         {
            current.dispose();
         }
         bmp.dispose();
      }
   }
}

