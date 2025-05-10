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
      
      alternativa3d var name_kR:Vector.<int> = new Vector.<int>();
      
      alternativa3d var name_Oq:int = 0;
      
      alternativa3d var vertexBuffers:Vector.<VertexBuffer3D> = new Vector.<VertexBuffer3D>();
      
      alternativa3d var name_else:Vector.<int> = new Vector.<int>();
      
      alternativa3d var name_nw:Vector.<int> = new Vector.<int>();
      
      alternativa3d var name_EL:Vector.<String> = new Vector.<String>();
      
      alternativa3d var name_3G:int = 0;
      
      alternativa3d var name_Aq:Vector.<Number> = new Vector.<Number>();
      
      alternativa3d var name_9X:int = 0;
      
      alternativa3d var name_Cl:Vector.<Number> = new Vector.<Number>(28 * 4,true);
      
      alternativa3d var name_Kv:int = 0;
      
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
         this.name_Oq = 0;
         this.alternativa3d::vertexBuffers.length = 0;
         this.name_3G = 0;
         this.name_9X = 0;
         this.name_Kv = 0;
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
         this.name_kR[this.name_Oq] = sampler;
         this.alternativa3d::textures[this.name_Oq] = texture;
         ++this.name_Oq;
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
         this.name_else[this.name_3G] = index;
         this.alternativa3d::vertexBuffers[this.name_3G] = buffer;
         this.name_nw[this.name_3G] = bufferOffset;
         this.name_EL[this.name_3G] = format;
         ++this.name_3G;
      }
      
      alternativa3d function setVertexConstantsFromVector(firstRegister:int, data:Vector.<Number>, numRegisters:int) : void
      {
         if(uint(firstRegister + numRegisters) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + numRegisters > this.name_9X)
         {
            this.name_9X = firstRegister + numRegisters;
            this.name_Aq.length = this.name_9X << 2;
         }
         for(var i:int = 0, len:int = numRegisters << 2; i < len; )
         {
            this.name_Aq[offset] = data[i];
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
         if(firstRegister + 1 > this.name_9X)
         {
            this.name_9X = firstRegister + 1;
            this.name_Aq.length = this.name_9X << 2;
         }
         this.name_Aq[offset] = x;
         offset++;
         this.name_Aq[offset] = y;
         offset++;
         this.name_Aq[offset] = z;
         offset++;
         this.name_Aq[offset] = w;
      }
      
      alternativa3d function setVertexConstantsFromTransform(firstRegister:int, transform:Transform3D) : void
      {
         if(uint(firstRegister + 3) > 128)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 3 > this.name_9X)
         {
            this.name_9X = firstRegister + 3;
            this.name_Aq.length = this.name_9X << 2;
         }
         this.name_Aq[offset] = transform.a;
         offset++;
         this.name_Aq[offset] = transform.b;
         offset++;
         this.name_Aq[offset] = transform.c;
         offset++;
         this.name_Aq[offset] = transform.d;
         offset++;
         this.name_Aq[offset] = transform.e;
         offset++;
         this.name_Aq[offset] = transform.f;
         offset++;
         this.name_Aq[offset] = transform.g;
         offset++;
         this.name_Aq[offset] = transform.h;
         offset++;
         this.name_Aq[offset] = transform.i;
         offset++;
         this.name_Aq[offset] = transform.j;
         offset++;
         this.name_Aq[offset] = transform.k;
         offset++;
         this.name_Aq[offset] = transform.l;
      }
      
      alternativa3d function setProjectionConstants(camera:Camera3D, firstRegister:int, transform:Transform3D = null) : void
      {
         if(uint(firstRegister + 4) > 128)
         {
            throw new Error("Register index is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 4 > this.name_9X)
         {
            this.name_9X = firstRegister + 4;
            this.name_Aq.length = this.name_9X << 2;
         }
         if(transform != null)
         {
            this.name_Aq[offset] = transform.a * camera.alternativa3d::m0;
            offset++;
            this.name_Aq[offset] = transform.b * camera.alternativa3d::m0;
            offset++;
            this.name_Aq[offset] = transform.c * camera.alternativa3d::m0;
            offset++;
            this.name_Aq[offset] = transform.d * camera.alternativa3d::m0;
            offset++;
            this.name_Aq[offset] = transform.e * camera.alternativa3d::m5;
            offset++;
            this.name_Aq[offset] = transform.f * camera.alternativa3d::m5;
            offset++;
            this.name_Aq[offset] = transform.g * camera.alternativa3d::m5;
            offset++;
            this.name_Aq[offset] = transform.h * camera.alternativa3d::m5;
            offset++;
            this.name_Aq[offset] = transform.i * camera.alternativa3d::m10;
            offset++;
            this.name_Aq[offset] = transform.j * camera.alternativa3d::m10;
            offset++;
            this.name_Aq[offset] = transform.k * camera.alternativa3d::m10;
            offset++;
            this.name_Aq[offset] = transform.l * camera.alternativa3d::m10 + camera.alternativa3d::m14;
            offset++;
            if(!camera.orthographic)
            {
               this.name_Aq[offset] = transform.i;
               offset++;
               this.name_Aq[offset] = transform.j;
               offset++;
               this.name_Aq[offset] = transform.k;
               offset++;
               this.name_Aq[offset] = transform.l;
            }
            else
            {
               this.name_Aq[offset] = 0;
               offset++;
               this.name_Aq[offset] = 0;
               offset++;
               this.name_Aq[offset] = 0;
               offset++;
               this.name_Aq[offset] = 1;
            }
         }
         else
         {
            this.name_Aq[offset] = camera.alternativa3d::m0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = camera.alternativa3d::m5;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = camera.alternativa3d::m10;
            offset++;
            this.name_Aq[offset] = camera.alternativa3d::m14;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            this.name_Aq[offset] = 0;
            offset++;
            if(!camera.orthographic)
            {
               this.name_Aq[offset] = 1;
               offset++;
               this.name_Aq[offset] = 0;
            }
            else
            {
               this.name_Aq[offset] = 0;
               offset++;
               this.name_Aq[offset] = 1;
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
         if(firstRegister + numRegisters > this.name_Kv)
         {
            this.name_Kv = firstRegister + numRegisters;
         }
         for(var i:int = 0, len:int = numRegisters << 2; i < len; )
         {
            this.name_Cl[offset] = data[i];
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
         if(firstRegister + 1 > this.name_Kv)
         {
            this.name_Kv = firstRegister + 1;
         }
         this.name_Cl[offset] = x;
         offset++;
         this.name_Cl[offset] = y;
         offset++;
         this.name_Cl[offset] = z;
         offset++;
         this.name_Cl[offset] = w;
      }
      
      alternativa3d function setFragmentConstantsFromTransform(firstRegister:int, transform:Transform3D) : void
      {
         if(uint(firstRegister + 3) > 28)
         {
            throw new Error("Register index " + firstRegister + " is out of bounds.");
         }
         var offset:int = firstRegister << 2;
         if(firstRegister + 3 > this.name_Kv)
         {
            this.name_Kv = firstRegister + 3;
         }
         this.name_Cl[offset] = transform.a;
         offset++;
         this.name_Cl[offset] = transform.b;
         offset++;
         this.name_Cl[offset] = transform.c;
         offset++;
         this.name_Cl[offset] = transform.d;
         offset++;
         this.name_Cl[offset] = transform.e;
         offset++;
         this.name_Cl[offset] = transform.f;
         offset++;
         this.name_Cl[offset] = transform.g;
         offset++;
         this.name_Cl[offset] = transform.h;
         offset++;
         this.name_Cl[offset] = transform.i;
         offset++;
         this.name_Cl[offset] = transform.j;
         offset++;
         this.name_Cl[offset] = transform.k;
         offset++;
         this.name_Cl[offset] = transform.l;
      }
   }
}

