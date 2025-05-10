package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.TextureBase;
   
   use namespace alternativa3d;
   
   public class DrawUnit
   {
      alternativa3d var next:DrawUnit;
      
      alternativa3d var object:Object3D;
      
      alternativa3d var program:Program3D;
      
      alternativa3d var indexBuffer:IndexBuffer3D;
      
      alternativa3d var firstIndex:int;
      
      alternativa3d var numTriangles:int;
      
      alternativa3d var blendSource:String = "one";
      
      alternativa3d var blendDestination:String = "zero";
      
      alternativa3d var culling:String = "front";
      
      alternativa3d var textures:Vector.<TextureBase> = new Vector.<TextureBase>();
      
      alternativa3d var §_-kR§:Vector.<int> = new Vector.<int>();
      
      alternativa3d var §_-Oq§:int = 0;
      
      alternativa3d var vertexBuffers:Vector.<VertexBuffer3D> = new Vector.<VertexBuffer3D>();
      
      alternativa3d var §else §:Vector.<int> = new Vector.<int>();
      
      alternativa3d var §_-nw§:Vector.<int> = new Vector.<int>();
      
      alternativa3d var §_-EL§:Vector.<String> = new Vector.<String>();
      
      alternativa3d var §_-3G§:int = 0;
      
      alternativa3d var §_-Aq§:Vector.<Number> = new Vector.<Number>();
      
      alternativa3d var §_-9X§:int = 0;
      
      alternativa3d var §_-Cl§:Vector.<Number> = new Vector.<Number>(28 * 4,true);
      
      alternativa3d var §_-Kv§:int = 0;
      
      public function DrawUnit()
      {
         super();
      }
      
      alternativa3d function clear() : void
      {
         this.alternativa3d::object = null;
         this.alternativa3d::program = null;
         this.alternativa3d::indexBuffer = null;
         this.alternativa3d::blendSource = Context3DBlendFactor.ONE;
         this.alternativa3d::blendDestination = Context3DBlendFactor.ZERO;
         this.alternativa3d::culling = Context3DTriangleFace.FRONT;
         this.alternativa3d::textures.length = 0;
         this.alternativa3d::_-Oq = 0;
         this.alternativa3d::vertexBuffers.length = 0;
         this.alternativa3d::_-3G = 0;
         this.alternativa3d::_-9X = 0;
         this.alternativa3d::_-Kv = 0;
      }
      
      alternativa3d function setTextureAt(sampler:int, texture:TextureBase) : void
      {
         if(uint(sampler) > 8)
         {
            throw new Error("Sampler index " + sampler + " is out of bounds.");
         }
         if(texture == null)
         {
            throw new Error("Texture is null");
         }
         this.alternativa3d::_-kR[this.alternativa3d::_-Oq] = sampler;
         this.alternativa3d::textures[this.alternativa3d::_-Oq] = texture;
         ++this.alternativa3d::_-Oq;
      }
      
      alternativa3d function setVertexBufferAt(index:int, buffer:VertexBuffer3D, bufferOffset:int, format:String) : void
      {
         if(uint(index) > 8)
         {
            throw new Error("VertexBuffer index " + index + " is out of bounds.");
         }
         if(buffer == null)
         {
            throw new Error("Buffer is null");
         }
         this.alternativa3d::else [this.alternativa3d::_-3G] = index;
         this.alternativa3d::vertexBuffers[this.alternativa3d::_-3G] = buffer;
         this.alternativa3d::_-nw[this.alternativa3d::_-3G] = bufferOffset;
         this.alternativa3d::_-EL[this.alternativa3d::_-3G] = format;
         ++this.alternativa3d::_-3G;
      }
      
      alternativa3d function setVertexConstantsFromVector(firstRegister:int, data:Vector.<Number>, numRegisters:int) : void
      {
         if(uint(firstRegister + numRegisters) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + numRegisters > this.alternativa3d::_-9X)
         {
            this.alternativa3d::_-9X = firstRegister + numRegisters;
            this.alternativa3d::_-Aq.length = this.alternativa3d::_-9X << 2;
         }
         for(var i:int = 0,var len:int = numRegisters << 2; i < len; )
         {
            this.alternativa3d::_-Aq[offset] = data[i];
            offset++;
            i++;
         }
      }
      
      alternativa3d function setVertexConstantsFromNumbers(firstRegister:int, x:Number, y:Number, z:Number, w:Number = 1) : void
      {
         if(uint(firstRegister + 1) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 1 > this.alternativa3d::_-9X)
         {
            this.alternativa3d::_-9X = firstRegister + 1;
            this.alternativa3d::_-Aq.length = this.alternativa3d::_-9X << 2;
         }
         this.alternativa3d::_-Aq[offset] = x;
         offset++;
         this.alternativa3d::_-Aq[offset] = y;
         offset++;
         this.alternativa3d::_-Aq[offset] = z;
         offset++;
         this.alternativa3d::_-Aq[offset] = w;
      }
      
      alternativa3d function setVertexConstantsFromTransform(firstRegister:int, transform:Transform3D) : void
      {
         if(uint(firstRegister + 3) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 3 > this.alternativa3d::_-9X)
         {
            this.alternativa3d::_-9X = firstRegister + 3;
            this.alternativa3d::_-Aq.length = this.alternativa3d::_-9X << 2;
         }
         this.alternativa3d::_-Aq[offset] = transform.a;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.b;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.c;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.d;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.e;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.f;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.g;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.h;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.i;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.j;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.k;
         offset++;
         this.alternativa3d::_-Aq[offset] = transform.l;
      }
      
      alternativa3d function setProjectionConstants(camera:Camera3D, firstRegister:int, transform:Transform3D = null) : void
      {
         if(uint(firstRegister + 4) > 128)
         {
            throw new Error("Register index is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 4 > this.alternativa3d::_-9X)
         {
            this.alternativa3d::_-9X = firstRegister + 4;
            this.alternativa3d::_-Aq.length = this.alternativa3d::_-9X << 2;
         }
         if(transform != null)
         {
            this.alternativa3d::_-Aq[offset] = transform.a * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.b * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.c * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.d * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.e * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.f * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.g * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.h * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.i * camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.j * camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.k * camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::_-Aq[offset] = transform.l * camera.alternativa3d::m10 + camera.alternativa3d::m14;
            offset++;
            if(!camera.orthographic)
            {
               this.alternativa3d::_-Aq[offset] = transform.i;
               offset++;
               this.alternativa3d::_-Aq[offset] = transform.j;
               offset++;
               this.alternativa3d::_-Aq[offset] = transform.k;
               offset++;
               this.alternativa3d::_-Aq[offset] = transform.l;
            }
            else
            {
               this.alternativa3d::_-Aq[offset] = 0;
               offset++;
               this.alternativa3d::_-Aq[offset] = 0;
               offset++;
               this.alternativa3d::_-Aq[offset] = 0;
               offset++;
               this.alternativa3d::_-Aq[offset] = 1;
            }
         }
         else
         {
            this.alternativa3d::_-Aq[offset] = camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::_-Aq[offset] = camera.alternativa3d::m14;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            this.alternativa3d::_-Aq[offset] = 0;
            offset++;
            if(!camera.orthographic)
            {
               this.alternativa3d::_-Aq[offset] = 1;
               offset++;
               this.alternativa3d::_-Aq[offset] = 0;
            }
            else
            {
               this.alternativa3d::_-Aq[offset] = 0;
               offset++;
               this.alternativa3d::_-Aq[offset] = 1;
            }
         }
      }
      
      alternativa3d function setFragmentConstantsFromVector(firstRegister:int, data:Vector.<Number>, numRegisters:int) : void
      {
         if(uint(firstRegister + numRegisters) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + numRegisters > this.alternativa3d::_-Kv)
         {
            this.alternativa3d::_-Kv = firstRegister + numRegisters;
         }
         for(var i:int = 0,var len:int = numRegisters << 2; i < len; )
         {
            this.alternativa3d::_-Cl[offset] = data[i];
            offset++;
            i++;
         }
      }
      
      alternativa3d function setFragmentConstantsFromNumbers(firstRegister:int, x:Number, y:Number, z:Number, w:Number = 1) : void
      {
         if(uint(firstRegister + 1) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 1 > this.alternativa3d::_-Kv)
         {
            this.alternativa3d::_-Kv = firstRegister + 1;
         }
         this.alternativa3d::_-Cl[offset] = x;
         offset++;
         this.alternativa3d::_-Cl[offset] = y;
         offset++;
         this.alternativa3d::_-Cl[offset] = z;
         offset++;
         this.alternativa3d::_-Cl[offset] = w;
      }
      
      alternativa3d function setFragmentConstantsFromTransform(firstRegister:int, transform:Transform3D) : void
      {
         if(uint(firstRegister + 3) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 3 > this.alternativa3d::_-Kv)
         {
            this.alternativa3d::_-Kv = firstRegister + 3;
         }
         this.alternativa3d::_-Cl[offset] = transform.a;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.b;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.c;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.d;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.e;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.f;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.g;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.h;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.i;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.j;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.k;
         offset++;
         this.alternativa3d::_-Cl[offset] = transform.l;
      }
   }
}

