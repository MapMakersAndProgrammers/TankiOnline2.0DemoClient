package package_21
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import package_4.name_127;
   
   use namespace alternativa3d;
   
   public class name_430
   {
      protected static var collector:name_135;
      
      private static var _usedBuffers:uint = 0;
      
      private static var _usedTextures:uint = 0;
      
      alternativa3d var camera:name_124;
      
      alternativa3d var var_585:Vector.<name_135> = new Vector.<name_135>();
      
      public function name_430()
      {
         super();
      }
      
      alternativa3d function render(context:Context3D) : void
      {
         var list:name_135 = null;
         var next:name_135 = null;
         var drawUnitsLength:int = int(this.alternativa3d::var_585.length);
         for(var i:int = 0; i < drawUnitsLength; )
         {
            list = this.alternativa3d::var_585[i];
            if(list != null)
            {
               switch(i)
               {
                  case name_128.SKY:
                     context.setDepthTest(false,Context3DCompareMode.ALWAYS);
                     break;
                  case name_128.OPAQUE_SORT:
                     context.setDepthTest(true,Context3DCompareMode.LESS);
                     break;
                  case name_128.OPAQUE:
                     context.setDepthTest(true,Context3DCompareMode.LESS);
                     break;
                  case name_128.TANK_SHADOW:
                     context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
                     break;
                  case name_128.TANK_OPAQUE:
                     context.setDepthTest(true,Context3DCompareMode.LESS);
                     break;
                  case name_128.DECALS:
                     context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
                     break;
                  case name_128.SHADOWS:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case name_128.SHADOWED_LIGHTS:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case name_128.LIGHTS:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case name_128.FOG:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case name_128.TRANSPARENT_SORT:
                     if(list.alternativa3d::next != null)
                     {
                        list = this.alternativa3d::method_646(list);
                     }
                     context.setDepthTest(false,Context3DCompareMode.LESS);
                     break;
                  case name_128.NEXT_LAYER:
                     context.setDepthTest(false,Context3DCompareMode.ALWAYS);
                     break;
                  case name_128.EFFECTS:
                     if(list.alternativa3d::next != null)
                     {
                        list = this.alternativa3d::method_646(list);
                     }
                     context.setDepthTest(false,Context3DCompareMode.LESS);
               }
               continue loop1;
            }
            i++;
         }
         this.alternativa3d::var_585.length = 0;
      }
      
      alternativa3d function name_137(object:name_78, program:Program3D, indexBuffer:IndexBuffer3D, firstIndex:int, numTriangles:int, debugShader:name_127 = null) : name_135
      {
         var res:name_135 = null;
         if(collector != null)
         {
            res = collector;
            collector = collector.alternativa3d::next;
            res.alternativa3d::next = null;
         }
         else
         {
            res = new name_135();
         }
         res.alternativa3d::object = object;
         res.alternativa3d::program = program;
         res.alternativa3d::indexBuffer = indexBuffer;
         res.alternativa3d::firstIndex = firstIndex;
         res.alternativa3d::numTriangles = numTriangles;
         return res;
      }
      
      alternativa3d function name_130(drawUnit:name_135, renderPriority:int) : void
      {
         if(renderPriority >= this.alternativa3d::var_585.length)
         {
            this.alternativa3d::var_585.length = renderPriority + 1;
         }
         drawUnit.alternativa3d::next = this.alternativa3d::var_585[renderPriority];
         this.alternativa3d::var_585[renderPriority] = drawUnit;
      }
      
      protected function method_647(drawUnit:name_135, context:Context3D, camera:name_124) : void
      {
         var bufferIndex:int = 0;
         var bufferBit:int = 0;
         var currentBuffers:int = 0;
         var textureSampler:int = 0;
         var textureBit:int = 0;
         var currentTextures:int = 0;
         context.setBlendFactors(drawUnit.alternativa3d::blendSource,drawUnit.alternativa3d::blendDestination);
         context.setCulling(drawUnit.alternativa3d::culling);
         for(var i:int = 0; i < drawUnit.alternativa3d::name_403; i++)
         {
            bufferIndex = drawUnit.alternativa3d::name_405[i];
            bufferBit = 1 << bufferIndex;
            currentBuffers |= bufferBit;
            _usedBuffers &= ~bufferBit;
            context.setVertexBufferAt(bufferIndex,drawUnit.alternativa3d::vertexBuffers[i],drawUnit.alternativa3d::name_411[i],drawUnit.alternativa3d::name_409[i]);
         }
         if(drawUnit.alternativa3d::name_404 > 0)
         {
            context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,drawUnit.alternativa3d::name_410,drawUnit.alternativa3d::name_404);
         }
         if(drawUnit.alternativa3d::name_407 > 0)
         {
            context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,drawUnit.alternativa3d::name_408,drawUnit.alternativa3d::name_407);
         }
         for(i = 0; i < drawUnit.alternativa3d::var_182; )
         {
            textureSampler = drawUnit.alternativa3d::var_183[i];
            textureBit = 1 << textureSampler;
            currentTextures |= textureBit;
            _usedTextures &= ~textureBit;
            context.setTextureAt(textureSampler,drawUnit.alternativa3d::textures[i]);
            i++;
         }
         context.setProgram(drawUnit.alternativa3d::program);
         for(bufferIndex = 0; _usedBuffers > 0; )
         {
            bufferBit = _usedBuffers & 1;
            _usedBuffers >>= 1;
            if(Boolean(bufferBit))
            {
               context.setVertexBufferAt(bufferIndex,null);
            }
            bufferIndex++;
         }
         for(textureSampler = 0; _usedTextures > 0; )
         {
            textureBit = _usedTextures & 1;
            _usedTextures >>= 1;
            if(Boolean(textureBit))
            {
               context.setTextureAt(textureSampler,null);
            }
            textureSampler++;
         }
         context.drawTriangles(drawUnit.alternativa3d::indexBuffer,drawUnit.alternativa3d::firstIndex,drawUnit.alternativa3d::numTriangles);
         _usedBuffers = currentBuffers;
         _usedTextures = currentTextures;
         ++camera.alternativa3d::numDraws;
         camera.alternativa3d::numTriangles += drawUnit.alternativa3d::numTriangles;
      }
      
      alternativa3d function method_646(list:name_135, direction:Boolean = true) : name_135
      {
         var left:name_135 = list;
         var right:name_135 = list.alternativa3d::next;
         while(right != null && right.alternativa3d::next != null)
         {
            list = list.alternativa3d::next;
            right = right.alternativa3d::next.alternativa3d::next;
         }
         right = list.alternativa3d::next;
         list.alternativa3d::next = null;
         if(left.alternativa3d::next != null)
         {
            left = this.alternativa3d::method_646(left,direction);
         }
         if(right.alternativa3d::next != null)
         {
            right = this.alternativa3d::method_646(right,direction);
         }
         var flag:Boolean = direction ? left.alternativa3d::object.alternativa3d::localToCameraTransform.l > right.alternativa3d::object.alternativa3d::localToCameraTransform.l : left.alternativa3d::object.alternativa3d::localToCameraTransform.l < right.alternativa3d::object.alternativa3d::localToCameraTransform.l;
         if(flag)
         {
            list = left;
            left = left.alternativa3d::next;
         }
         else
         {
            list = right;
            right = right.alternativa3d::next;
         }
         var last:name_135 = list;
         while(left != null)
         {
            if(right == null)
            {
               last.alternativa3d::next = left;
               return list;
            }
            if(flag)
            {
               if(direction ? left.alternativa3d::object.alternativa3d::localToCameraTransform.l > right.alternativa3d::object.alternativa3d::localToCameraTransform.l : left.alternativa3d::object.alternativa3d::localToCameraTransform.l < right.alternativa3d::object.alternativa3d::localToCameraTransform.l)
               {
                  last = left;
                  left = left.alternativa3d::next;
               }
               else
               {
                  last.alternativa3d::next = right;
                  last = right;
                  right = right.alternativa3d::next;
                  flag = false;
               }
            }
            else if(direction ? left.alternativa3d::object.alternativa3d::localToCameraTransform.l < right.alternativa3d::object.alternativa3d::localToCameraTransform.l : left.alternativa3d::object.alternativa3d::localToCameraTransform.l > right.alternativa3d::object.alternativa3d::localToCameraTransform.l)
            {
               last = right;
               right = right.alternativa3d::next;
            }
            else
            {
               last.alternativa3d::next = left;
               last = left;
               left = left.alternativa3d::next;
               flag = true;
            }
         }
         last.alternativa3d::next = right;
         return list;
      }
   }
}

