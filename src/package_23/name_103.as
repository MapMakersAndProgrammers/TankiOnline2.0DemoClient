package package_23
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DCompareMode;
   import flash.geom.Matrix3D;
   import package_21.name_124;
   import package_21.name_135;
   import package_21.name_386;
   import package_21.name_78;
   import package_30.name_114;
   import package_4.name_127;
   
   use namespace alternativa3d;
   
   public class name_103
   {
      private static var counter:int = 0;
      
      private static const boundVertices:Vector.<Number> = new Vector.<Number>(24);
      
      alternativa3d var var_104:String;
      
      public var active:Boolean = false;
      
      public function name_103()
      {
         super();
         ++counter;
         this.alternativa3d::var_104 = "M" + counter.toString();
      }
      
      alternativa3d function get name_372() : Boolean
      {
         return false;
      }
      
      public function update() : void
      {
      }
      
      public function getVShader(index:int = 0) : name_114
      {
         return null;
      }
      
      public function getFShader(index:int = 0) : name_114
      {
         return null;
      }
      
      public function getFIntensityShader() : name_114
      {
         throw new Error("Not implemented");
      }
      
      public function applyShader(destination:name_135, program:name_127, object:name_78, camera:name_124, index:int = 0) : void
      {
      }
      
      public function get debug() : Boolean
      {
         return false;
      }
      
      public function set debug(value:Boolean) : void
      {
      }
      
      alternativa3d function cullReciever(boundBox:name_386, object:name_78) : Boolean
      {
         return false;
      }
      
      protected function method_221(context:Context3D) : void
      {
         context.setTextureAt(0,null);
         context.setTextureAt(1,null);
         context.setTextureAt(2,null);
         context.setTextureAt(3,null);
         context.setTextureAt(4,null);
         context.setTextureAt(5,null);
         context.setTextureAt(6,null);
         context.setTextureAt(7,null);
         context.setVertexBufferAt(1,null);
         context.setVertexBufferAt(2,null);
         context.setVertexBufferAt(3,null);
         context.setVertexBufferAt(4,null);
         context.setVertexBufferAt(5,null);
         context.setVertexBufferAt(6,null);
         context.setVertexBufferAt(7,null);
         context.setDepthTest(true,Context3DCompareMode.LESS);
         context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
      }
      
      alternativa3d function method_222(bounds:name_386, matrix:Matrix3D) : Boolean
      {
         var i:int = 0;
         var infront:Boolean = false;
         var behind:Boolean = false;
         boundVertices[0] = bounds.minX;
         boundVertices[1] = bounds.minY;
         boundVertices[2] = bounds.minZ;
         boundVertices[3] = bounds.maxX;
         boundVertices[4] = bounds.minY;
         boundVertices[5] = bounds.minZ;
         boundVertices[6] = bounds.minX;
         boundVertices[7] = bounds.maxY;
         boundVertices[8] = bounds.minZ;
         boundVertices[9] = bounds.maxX;
         boundVertices[10] = bounds.maxY;
         boundVertices[11] = bounds.minZ;
         boundVertices[12] = bounds.minX;
         boundVertices[13] = bounds.minY;
         boundVertices[14] = bounds.maxZ;
         boundVertices[15] = bounds.maxX;
         boundVertices[16] = bounds.minY;
         boundVertices[17] = bounds.maxZ;
         boundVertices[18] = bounds.minX;
         boundVertices[19] = bounds.maxY;
         boundVertices[20] = bounds.maxZ;
         boundVertices[21] = bounds.maxX;
         boundVertices[22] = bounds.maxY;
         boundVertices[23] = bounds.maxZ;
         matrix.transformVectors(boundVertices,boundVertices);
         i = 2;
         infront = false;
         behind = false;
         while(i <= 23)
         {
            if(boundVertices[i] > 0)
            {
               infront = true;
               if(behind)
               {
                  break;
               }
            }
            else
            {
               behind = true;
               if(infront)
               {
                  break;
               }
            }
            i += 3;
         }
         if(behind)
         {
            if(!infront)
            {
               return false;
            }
         }
         i = 0;
         infront = false;
         behind = false;
         while(i <= 21)
         {
            if(boundVertices[i] > 0)
            {
               infront = true;
               if(behind)
               {
                  break;
               }
            }
            else
            {
               behind = true;
               if(infront)
               {
                  break;
               }
            }
            i += 3;
         }
         if(behind)
         {
            if(!infront)
            {
               return false;
            }
         }
         i = 0;
         infront = false;
         behind = false;
         while(i <= 21)
         {
            if(boundVertices[i] < 1)
            {
               infront = true;
               if(behind)
               {
                  break;
               }
            }
            else
            {
               behind = true;
               if(infront)
               {
                  break;
               }
            }
            i += 3;
         }
         if(behind)
         {
            if(!infront)
            {
               return false;
            }
         }
         i = 1;
         infront = false;
         behind = false;
         while(i <= 22)
         {
            if(boundVertices[i] > 0)
            {
               infront = true;
               if(behind)
               {
                  break;
               }
            }
            else
            {
               behind = true;
               if(infront)
               {
                  break;
               }
            }
            i += 3;
         }
         if(behind)
         {
            if(!infront)
            {
               return false;
            }
         }
         i = 1;
         infront = false;
         behind = false;
         while(i <= 22)
         {
            if(boundVertices[i] < 1)
            {
               infront = true;
               if(behind)
               {
                  break;
               }
            }
            else
            {
               behind = true;
               if(infront)
               {
                  break;
               }
            }
            i += 3;
         }
         if(behind)
         {
            if(!infront)
            {
               return false;
            }
         }
         return true;
      }
   }
}

