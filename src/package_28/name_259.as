package package_28
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.CubeTexture;
   import flash.filters.ConvolutionFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace alternativa3d;
   
   public class name_259 extends name_129
   {
      private static var temporaryBitmapData:BitmapData;
      
      private static const filter:ConvolutionFilter = new ConvolutionFilter(2,2,[1,1,1,1],4,0,false,true);
      
      private static const rect:Rectangle = new Rectangle();
      
      private static const point:Point = new Point();
      
      private static const matrix:Matrix = new Matrix(0.5,0,0,0.5);
      
      public var left:BitmapData;
      
      public var right:BitmapData;
      
      public var top:BitmapData;
      
      public var bottom:BitmapData;
      
      public var front:BitmapData;
      
      public var back:BitmapData;
      
      public function name_259(left:BitmapData, right:BitmapData, bottom:BitmapData, top:BitmapData, back:BitmapData, front:BitmapData)
      {
         super();
         this.left = left;
         this.right = right;
         this.bottom = bottom;
         this.top = top;
         this.back = back;
         this.front = front;
      }
      
      override public function upload(context3D:Context3D) : void
      {
         if(alternativa3d::_texture != null)
         {
            alternativa3d::_texture.dispose();
         }
         alternativa3d::_texture = context3D.createCubeTexture(this.left.width,Context3DTextureFormat.BGRA,false);
         var cubeTexture:CubeTexture = CubeTexture(alternativa3d::_texture);
         filter.preserveAlpha = !this.left.transparent;
         var bmp:BitmapData = temporaryBitmapData != null ? temporaryBitmapData : new BitmapData(this.left.width,this.left.height,this.left.transparent);
         var level:int = 0;
         cubeTexture.uploadFromBitmapData(this.left,1,level++);
         var current:BitmapData = this.left;
         rect.width = this.left.width;
         rect.height = this.left.height;
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
            if(current != this.left)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,this.left.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            cubeTexture.uploadFromBitmapData(current,1,level++);
         }
         level = 0;
         cubeTexture.uploadFromBitmapData(this.right,0,level++);
         current = this.right;
         rect.width = this.right.width;
         rect.height = this.right.height;
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
            if(current != this.right)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,this.right.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            cubeTexture.uploadFromBitmapData(current,0,level++);
         }
         level = 0;
         cubeTexture.uploadFromBitmapData(this.back,3,level++);
         current = this.back;
         rect.width = this.back.width;
         rect.height = this.back.height;
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
            if(current != this.back)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,this.back.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            cubeTexture.uploadFromBitmapData(current,3,level++);
         }
         level = 0;
         cubeTexture.uploadFromBitmapData(this.front,2,level++);
         current = this.front;
         rect.width = this.front.width;
         rect.height = this.front.height;
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
            if(current != this.front)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,this.front.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            cubeTexture.uploadFromBitmapData(current,2,level++);
         }
         level = 0;
         cubeTexture.uploadFromBitmapData(this.bottom,5,level++);
         current = this.bottom;
         rect.width = this.bottom.width;
         rect.height = this.bottom.height;
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
            if(current != this.bottom)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,this.bottom.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            cubeTexture.uploadFromBitmapData(current,5,level++);
         }
         level = 0;
         cubeTexture.uploadFromBitmapData(this.top,4,level++);
         current = this.top;
         rect.width = this.top.width;
         rect.height = this.top.height;
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
            if(current != this.top)
            {
               current.dispose();
            }
            current = new BitmapData(rect.width,rect.height,this.top.transparent,0);
            current.draw(bmp,matrix,null,null,null,false);
            cubeTexture.uploadFromBitmapData(current,4,level++);
         }
         if(temporaryBitmapData == null)
         {
            bmp.dispose();
         }
      }
   }
}

