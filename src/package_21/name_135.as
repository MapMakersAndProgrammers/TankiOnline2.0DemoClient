package package_21
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.TextureBase;
   
   use namespace alternativa3d;
   
   public class name_135
   {
      alternativa3d var next:name_135;
      
      alternativa3d var object:name_78;
      
      alternativa3d var program:Program3D;
      
      alternativa3d var indexBuffer:IndexBuffer3D;
      
      alternativa3d var firstIndex:int;
      
      alternativa3d var numTriangles:int;
      
      alternativa3d var blendSource:String = "one";
      
      alternativa3d var blendDestination:String = "zero";
      
      alternativa3d var culling:String = "front";
      
      alternativa3d var textures:Vector.<TextureBase> = new Vector.<TextureBase>();
      
      alternativa3d var var_183:Vector.<int> = new Vector.<int>();
      
      alternativa3d var var_182:int = 0;
      
      alternativa3d var vertexBuffers:Vector.<VertexBuffer3D> = new Vector.<VertexBuffer3D>();
      
      alternativa3d var name_405:Vector.<int> = new Vector.<int>();
      
      alternativa3d var name_411:Vector.<int> = new Vector.<int>();
      
      alternativa3d var name_409:Vector.<String> = new Vector.<String>();
      
      alternativa3d var name_403:int = 0;
      
      alternativa3d var name_410:Vector.<Number> = new Vector.<Number>();
      
      alternativa3d var name_404:int = 0;
      
      alternativa3d var name_408:Vector.<Number> = new Vector.<Number>(28 * 4,true);
      
      alternativa3d var name_407:int = 0;
      
      public function name_135()
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
         this.alternativa3d::var_182 = 0;
         this.alternativa3d::vertexBuffers.length = 0;
         this.alternativa3d::name_403 = 0;
         this.alternativa3d::name_404 = 0;
         this.alternativa3d::name_407 = 0;
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
         this.alternativa3d::var_183[this.alternativa3d::var_182] = sampler;
         this.alternativa3d::textures[this.alternativa3d::var_182] = texture;
         ++this.alternativa3d::var_182;
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
         this.alternativa3d::name_405[this.alternativa3d::name_403] = index;
         this.alternativa3d::vertexBuffers[this.alternativa3d::name_403] = buffer;
         this.alternativa3d::name_411[this.alternativa3d::name_403] = bufferOffset;
         this.alternativa3d::name_409[this.alternativa3d::name_403] = format;
         ++this.alternativa3d::name_403;
      }
      
      alternativa3d function name_426(firstRegister:int, data:Vector.<Number>, numRegisters:int) : void
      {
         if(uint(firstRegister + numRegisters) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + numRegisters > this.alternativa3d::name_404)
         {
            this.alternativa3d::name_404 = firstRegister + numRegisters;
            this.alternativa3d::name_410.length = this.alternativa3d::name_404 << 2;
         }
         for(var i:int = 0,var len:int = numRegisters << 2; i < len; )
         {
            this.alternativa3d::name_410[offset] = data[i];
            offset++;
            i++;
         }
      }
      
      alternativa3d function name_144(firstRegister:int, x:Number, y:Number, z:Number, w:Number = 1) : void
      {
         if(uint(firstRegister + 1) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 1 > this.alternativa3d::name_404)
         {
            this.alternativa3d::name_404 = firstRegister + 1;
            this.alternativa3d::name_410.length = this.alternativa3d::name_404 << 2;
         }
         this.alternativa3d::name_410[offset] = x;
         offset++;
         this.alternativa3d::name_410[offset] = y;
         offset++;
         this.alternativa3d::name_410[offset] = z;
         offset++;
         this.alternativa3d::name_410[offset] = w;
      }
      
      alternativa3d function name_412(firstRegister:int, transform:name_139) : void
      {
         if(uint(firstRegister + 3) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 3 > this.alternativa3d::name_404)
         {
            this.alternativa3d::name_404 = firstRegister + 3;
            this.alternativa3d::name_410.length = this.alternativa3d::name_404 << 2;
         }
         this.alternativa3d::name_410[offset] = transform.a;
         offset++;
         this.alternativa3d::name_410[offset] = transform.b;
         offset++;
         this.alternativa3d::name_410[offset] = transform.c;
         offset++;
         this.alternativa3d::name_410[offset] = transform.d;
         offset++;
         this.alternativa3d::name_410[offset] = transform.e;
         offset++;
         this.alternativa3d::name_410[offset] = transform.f;
         offset++;
         this.alternativa3d::name_410[offset] = transform.g;
         offset++;
         this.alternativa3d::name_410[offset] = transform.h;
         offset++;
         this.alternativa3d::name_410[offset] = transform.i;
         offset++;
         this.alternativa3d::name_410[offset] = transform.j;
         offset++;
         this.alternativa3d::name_410[offset] = transform.k;
         offset++;
         this.alternativa3d::name_410[offset] = transform.l;
      }
      
      alternativa3d function name_136(camera:name_124, firstRegister:int, transform:name_139 = null) : void
      {
         if(uint(firstRegister + 4) > 128)
         {
            throw new Error("Register index is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 4 > this.alternativa3d::name_404)
         {
            this.alternativa3d::name_404 = firstRegister + 4;
            this.alternativa3d::name_410.length = this.alternativa3d::name_404 << 2;
         }
         if(transform != null)
         {
            this.alternativa3d::name_410[offset] = transform.a * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::name_410[offset] = transform.b * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::name_410[offset] = transform.c * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::name_410[offset] = transform.d * camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::name_410[offset] = transform.e * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::name_410[offset] = transform.f * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::name_410[offset] = transform.g * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::name_410[offset] = transform.h * camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::name_410[offset] = transform.i * camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::name_410[offset] = transform.j * camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::name_410[offset] = transform.k * camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::name_410[offset] = transform.l * camera.alternativa3d::m10 + camera.alternativa3d::m14;
            offset++;
            if(!camera.orthographic)
            {
               this.alternativa3d::name_410[offset] = transform.i;
               offset++;
               this.alternativa3d::name_410[offset] = transform.j;
               offset++;
               this.alternativa3d::name_410[offset] = transform.k;
               offset++;
               this.alternativa3d::name_410[offset] = transform.l;
            }
            else
            {
               this.alternativa3d::name_410[offset] = 0;
               offset++;
               this.alternativa3d::name_410[offset] = 0;
               offset++;
               this.alternativa3d::name_410[offset] = 0;
               offset++;
               this.alternativa3d::name_410[offset] = 1;
            }
         }
         else
         {
            this.alternativa3d::name_410[offset] = camera.alternativa3d::m0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = camera.alternativa3d::m5;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = camera.alternativa3d::m10;
            offset++;
            this.alternativa3d::name_410[offset] = camera.alternativa3d::m14;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            this.alternativa3d::name_410[offset] = 0;
            offset++;
            if(!camera.orthographic)
            {
               this.alternativa3d::name_410[offset] = 1;
               offset++;
               this.alternativa3d::name_410[offset] = 0;
            }
            else
            {
               this.alternativa3d::name_410[offset] = 0;
               offset++;
               this.alternativa3d::name_410[offset] = 1;
            }
         }
      }
      
      alternativa3d function name_205(firstRegister:int, data:Vector.<Number>, numRegisters:int) : void
      {
         if(uint(firstRegister + numRegisters) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + numRegisters > this.alternativa3d::name_407)
         {
            this.alternativa3d::name_407 = firstRegister + numRegisters;
         }
         for(var i:int = 0,var len:int = numRegisters << 2; i < len; )
         {
            this.alternativa3d::name_408[offset] = data[i];
            offset++;
            i++;
         }
      }
      
      alternativa3d function name_134(firstRegister:int, x:Number, y:Number, z:Number, w:Number = 1) : void
      {
         if(uint(firstRegister + 1) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 1 > this.alternativa3d::name_407)
         {
            this.alternativa3d::name_407 = firstRegister + 1;
         }
         this.alternativa3d::name_408[offset] = x;
         offset++;
         this.alternativa3d::name_408[offset] = y;
         offset++;
         this.alternativa3d::name_408[offset] = z;
         offset++;
         this.alternativa3d::name_408[offset] = w;
      }
      
      alternativa3d function method_291(firstRegister:int, transform:name_139) : void
      {
         if(uint(firstRegister + 3) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 3 > this.alternativa3d::name_407)
         {
            this.alternativa3d::name_407 = firstRegister + 3;
         }
         this.alternativa3d::name_408[offset] = transform.a;
         offset++;
         this.alternativa3d::name_408[offset] = transform.b;
         offset++;
         this.alternativa3d::name_408[offset] = transform.c;
         offset++;
         this.alternativa3d::name_408[offset] = transform.d;
         offset++;
         this.alternativa3d::name_408[offset] = transform.e;
         offset++;
         this.alternativa3d::name_408[offset] = transform.f;
         offset++;
         this.alternativa3d::name_408[offset] = transform.g;
         offset++;
         this.alternativa3d::name_408[offset] = transform.h;
         offset++;
         this.alternativa3d::name_408[offset] = transform.i;
         offset++;
         this.alternativa3d::name_408[offset] = transform.j;
         offset++;
         this.alternativa3d::name_408[offset] = transform.k;
         offset++;
         this.alternativa3d::name_408[offset] = transform.l;
      }
   }
}

