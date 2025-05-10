package alternativa.engine3d.core
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.materials.ShaderProgram;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   
   use namespace alternativa3d;
   
   public class Renderer
   {
      protected static var collector:DrawUnit;
      
      private static var _usedBuffers:uint = 0;
      
      private static var _usedTextures:uint = 0;
      
      alternativa3d var camera:Camera3D;
      
      alternativa3d var name_T5:Vector.<DrawUnit> = new Vector.<DrawUnit>();
      
      public function Renderer()
      {
         super();
      }
      
      alternativa3d function render(context:Context3D) : void
      {
         var list:DrawUnit = null;
         var next:DrawUnit = null;
         var drawUnitsLength:int = int(this.name_T5.length);
         for(var i:int = 0; i < drawUnitsLength; i++)
         {
            list = this.name_T5[i];
            if(list != null)
            {
               switch(i)
               {
                  case RenderPriority.SKY:
                     context.setDepthTest(false,Context3DCompareMode.ALWAYS);
                     break;
                  case RenderPriority.OPAQUE_SORT:
                     context.setDepthTest(true,Context3DCompareMode.LESS);
                     break;
                  case RenderPriority.OPAQUE:
                     context.setDepthTest(true,Context3DCompareMode.LESS);
                     break;
                  case RenderPriority.TANK_SHADOW:
                     context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
                     break;
                  case RenderPriority.TANK_OPAQUE:
                     context.setDepthTest(true,Context3DCompareMode.LESS);
                     break;
                  case RenderPriority.DECALS:
                     context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
                     break;
                  case RenderPriority.SHADOWS:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case RenderPriority.SHADOWED_LIGHTS:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case RenderPriority.LIGHTS:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case RenderPriority.FOG:
                     context.setDepthTest(false,Context3DCompareMode.EQUAL);
                     break;
                  case RenderPriority.TRANSPARENT_SORT:
                     if(list.alternativa3d::next != null)
                     {
                        list = this.alternativa3d::sortByAverageZ(list);
                     }
                     context.setDepthTest(false,Context3DCompareMode.LESS);
                     break;
                  case RenderPriority.NEXT_LAYER:
                     context.setDepthTest(false,Context3DCompareMode.ALWAYS);
                     break;
                  case RenderPriority.EFFECTS:
                     if(list.alternativa3d::next != null)
                     {
                        list = this.alternativa3d::sortByAverageZ(list);
                     }
                     context.setDepthTest(false,Context3DCompareMode.LESS);
               }
               // Rendering, XXX: this was missing from the decompile so I just coppied the code from latest A3D (8.32)
               while (list != null) {
                  next = list.next;
                  renderDrawUnit(list, context, camera);
                  // Send to collector
                  list.clear();
                  list.next = collector;
                  collector = list;
                  list = next;
               }
            }
         }

         this.name_T5.length = 0;
      }
      
      alternativa3d function createDrawUnit(object:Object3D, program:Program3D, indexBuffer:IndexBuffer3D, firstIndex:int, numTriangles:int, debugShader:ShaderProgram = null) : DrawUnit
      {
         var res:DrawUnit = null;
         if(collector != null)
         {
            res = collector;
            collector = collector.alternativa3d::next;
            res.alternativa3d::next = null;
         }
         else
         {
            res = new DrawUnit();
         }
         res.alternativa3d::object = object;
         res.alternativa3d::program = program;
         res.alternativa3d::indexBuffer = indexBuffer;
         res.alternativa3d::firstIndex = firstIndex;
         res.alternativa3d::numTriangles = numTriangles;
         return res;
      }
      
      alternativa3d function addDrawUnit(drawUnit:DrawUnit, renderPriority:int) : void
      {
         if(renderPriority >= this.name_T5.length)
         {
            this.name_T5.length = renderPriority + 1;
         }
         drawUnit.alternativa3d::next = this.name_T5[renderPriority];
         this.name_T5[renderPriority] = drawUnit;
      }
      
      protected function renderDrawUnit(drawUnit:DrawUnit, context:Context3D, camera:Camera3D) : void
      {
         var bufferIndex:int = 0;
         var bufferBit:int = 0;
         var currentBuffers:int = 0;
         var textureSampler:int = 0;
         var textureBit:int = 0;
         var currentTextures:int = 0;
         context.setBlendFactors(drawUnit.alternativa3d::blendSource,drawUnit.alternativa3d::blendDestination);
         context.setCulling(drawUnit.alternativa3d::culling);
         for(var i:int = 0; i < drawUnit.name_3G; i++)
         {
            bufferIndex = int(drawUnit.name_else[i]);
            bufferBit = 1 << bufferIndex;
            currentBuffers |= bufferBit;
            _usedBuffers &= ~bufferBit;
            context.setVertexBufferAt(bufferIndex,drawUnit.alternativa3d::vertexBuffers[i],drawUnit.name_nw[i],drawUnit.name_EL[i]);
         }
         if(drawUnit.name_9X > 0)
         {
            context.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,drawUnit.name_Aq,drawUnit.name_9X);
         }
         if(drawUnit.name_Kv > 0)
         {
            context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,drawUnit.name_Cl,drawUnit.name_Kv);
         }
         for(i = 0; i < drawUnit.name_Oq; )
         {
            textureSampler = int(drawUnit.name_kR[i]);
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
      
      alternativa3d function sortByAverageZ(list:DrawUnit, direction:Boolean = true) : DrawUnit
      {
         var left:DrawUnit = list;
         var right:DrawUnit = list.alternativa3d::next;
         while(right != null && right.alternativa3d::next != null)
         {
            list = list.alternativa3d::next;
            right = right.alternativa3d::next.alternativa3d::next;
         }
         right = list.alternativa3d::next;
         list.alternativa3d::next = null;
         if(left.alternativa3d::next != null)
         {
            left = this.alternativa3d::sortByAverageZ(left,direction);
         }
         if(right.alternativa3d::next != null)
         {
            right = this.alternativa3d::sortByAverageZ(right,direction);
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
         var last:DrawUnit = list;
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

