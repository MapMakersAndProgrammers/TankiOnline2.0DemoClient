package package_23
{
   import alternativa.engine3d.alternativa3d;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   import package_19.name_380;
   import package_21.name_124;
   import package_21.name_135;
   import package_21.name_139;
   import package_21.name_386;
   import package_21.name_78;
   import package_24.DirectionalLight;
   import package_28.name_129;
   import package_28.name_167;
   import package_30.name_114;
   import package_30.name_115;
   import package_4.class_5;
   import package_4.name_127;
   import package_96.name_279;
   
   use namespace alternativa3d;
   
   public class name_97 extends name_103
   {
      private static var pcfOffsets:Vector.<Number>;
      
      private static const constants:Vector.<Number> = Vector.<Number>([255,255,1000,1]);
      
      private static const points:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D()]);
      
      private static const objectToShadowMap:name_139 = new name_139();
      
      private static const objectToUVMap:Matrix3D = new Matrix3D();
      
      public var context:Context3D;
      
      private const alpha:Number = 0.7;
      
      private var bounds:name_386 = new name_386();
      
      private var partSize:Number;
      
      private var var_162:Vector.<Vector.<Texture>> = new Vector.<Vector.<Texture>>();
      
      private var var_165:Vector.<Vector.<Matrix3D>> = new Vector.<Vector.<Matrix3D>>();
      
      private var light:DirectionalLight;
      
      private var var_167:name_139 = new name_139();
      
      private var var_168:Boolean = false;
      
      private var var_163:name_78;
      
      private var var_166:Dictionary = new Dictionary();
      
      private var var_164:Number = 0;
      
      private var var_169:Matrix3D = new Matrix3D();
      
      private var rawData:Vector.<Number> = new Vector.<Number>(16);
      
      public function name_97(context:Context3D, partSize:int, pcfSize:Number = 0)
      {
         super();
         this.context = context;
         this.partSize = partSize;
         this.var_164 = pcfSize;
         constants[3] = 1 - this.alpha;
      }
      
      alternativa3d static function calculateBoundBox(boundBox:name_386, object:name_78, hierarchy:Boolean = true) : void
      {
         var point:Vector3D = null;
         var bb:name_386 = null;
         var transform:name_139 = null;
         var i:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var z:Number = NaN;
         var child:name_78 = null;
         if(object.boundBox != null)
         {
            bb = object.boundBox;
            point = points[0];
            point.x = bb.minX;
            point.y = bb.minY;
            point.z = bb.minZ;
            point = points[1];
            point.x = bb.minX;
            point.y = bb.minY;
            point.z = bb.maxZ;
            point = points[2];
            point.x = bb.minX;
            point.y = bb.maxY;
            point.z = bb.minZ;
            point = points[3];
            point.x = bb.minX;
            point.y = bb.maxY;
            point.z = bb.maxZ;
            point = points[4];
            point.x = bb.maxX;
            point.y = bb.minY;
            point.z = bb.minZ;
            point = points[5];
            point.x = bb.maxX;
            point.y = bb.minY;
            point.z = bb.maxZ;
            point = points[6];
            point.x = bb.maxX;
            point.y = bb.maxY;
            point.z = bb.minZ;
            point = points[7];
            point.x = bb.maxX;
            point.y = bb.maxY;
            point.z = bb.maxZ;
            transform = object.alternativa3d::localToCameraTransform;
            for(i = 0; i < 8; )
            {
               point = points[i];
               x = transform.a * point.x + transform.b * point.y + transform.c * point.z + transform.d;
               y = transform.e * point.x + transform.f * point.y + transform.g * point.z + transform.h;
               z = transform.i * point.x + transform.j * point.y + transform.k * point.z + transform.l;
               if(x < boundBox.minX)
               {
                  boundBox.minX = x;
               }
               if(x > boundBox.maxX)
               {
                  boundBox.maxX = x;
               }
               if(y < boundBox.minY)
               {
                  boundBox.minY = y;
               }
               if(y > boundBox.maxY)
               {
                  boundBox.maxY = y;
               }
               if(z < boundBox.minZ)
               {
                  boundBox.minZ = z;
               }
               if(z > boundBox.maxZ)
               {
                  boundBox.maxZ = z;
               }
               i++;
            }
         }
         if(hierarchy)
         {
            for(child = object.alternativa3d::childrenList; child != null; )
            {
               if(child.visible)
               {
                  if(child.alternativa3d::transformChanged)
                  {
                     child.alternativa3d::composeTransforms();
                  }
                  child.alternativa3d::localToCameraTransform.combine(object.alternativa3d::localToCameraTransform,child.alternativa3d::transform);
                  alternativa3d::calculateBoundBox(boundBox,child);
               }
               child = child.alternativa3d::next;
            }
         }
      }
      
      private static function method_264(index:int) : name_114
      {
         var shader:name_114 = name_114.name_140(["m44 v0, a0, c4"]);
         shader.name_122(name_115.ATTRIBUTE,0,"aPosition");
         shader.name_122(name_115.CONSTANT,0,"cPROJ",4);
         shader.name_122(name_115.CONSTANT,4,"cTOSHADOW",4);
         shader.name_122(name_115.VARYING,0,"vSHADOWSAMPLE");
         return shader;
      }
      
      private static function method_263(mult:Boolean, usePCF:Boolean, index:int, grayScale:Boolean = false) : name_114
      {
         var i:int = 0;
         var line:int = 0;
         var shaderArr:Array = [];
         var numPass:uint = usePCF ? 4 : 1;
         for(i = 0; i < numPass; i++)
         {
            var _loc10_:* = line++;
            shaderArr[_loc10_] = "mov t0.w, v0.z";
            var _loc11_:* = line++;
            shaderArr[_loc11_] = "mul t0.w, t0.w, c4.y";
            if(usePCF)
            {
               var _loc12_:* = line++;
               shaderArr[_loc12_] = "add t1, v0, c" + (i + 5).toString() + "";
               var _loc13_:* = line++;
               shaderArr[_loc13_] = "tex t1, t1, s0 <2d,clamp,near,nomip>";
            }
            else
            {
               _loc12_ = line++;
               shaderArr[_loc12_] = "tex t1, v0, s0 <2d,clamp,near,nomip>";
            }
            _loc12_ = line++;
            shaderArr[_loc12_] = "mul t1.w, t1.x, c4.x";
            _loc13_ = line++;
            shaderArr[_loc13_] = "add t1.w, t1.w, t1.y";
            var _loc14_:* = line++;
            shaderArr[_loc14_] = "sub t2.z, t1.w, t0.w";
            var _loc15_:* = line++;
            shaderArr[_loc15_] = "mul t2.z, t2.z, c4.z";
            var _loc16_:* = line++;
            shaderArr[_loc16_] = "sat t2.z, t2.z";
            var _loc17_:* = line++;
            shaderArr[_loc17_] = "sat t2.z, t2.z";
            if(usePCF)
            {
               if(i == 0)
               {
                  var _loc18_:* = line++;
                  shaderArr[_loc18_] = "mov t2.x, t2.z";
               }
               else
               {
                  _loc18_ = line++;
                  shaderArr[_loc18_] = "add t2.x, t2.x, t2.z";
               }
            }
         }
         if(usePCF)
         {
            _loc10_ = line++;
            shaderArr[_loc10_] = "mul t2.z, t2.x, c5.w";
         }
         if(grayScale)
         {
            shaderArr.push("mov o0.w, t2.z");
         }
         else if(mult)
         {
            shaderArr.push("mul t0.xyz, i0.xyz, t2.z");
            shaderArr.push("mov t0.w, i0.w");
            shaderArr.push("mov o0, t0");
         }
         else
         {
            shaderArr.push("mov t0, t2.z");
            shaderArr.push("mov o0, t0");
         }
         var shader:name_114 = name_114.name_140(shaderArr,"StaticShadowMap");
         shader.name_122(name_115.VARYING,0,"vSHADOWSAMPLE");
         shader.name_122(name_115.CONSTANT,4,"cConstants",1);
         if(usePCF)
         {
            for(i = 0; i < numPass; i++)
            {
               shader.name_122(name_115.CONSTANT,i + 5,"cPCF" + i.toString(),1);
            }
         }
         shader.name_122(name_115.SAMPLER,0,"sSHADOWMAP");
         return shader;
      }
      
      public function method_267(object:name_78) : void
      {
         this.var_166[object] = true;
      }
      
      public function method_266(object:name_78) : void
      {
         delete this.var_166[object];
      }
      
      public function dispose() : void
      {
         var textures:Vector.<Texture> = null;
         var texture:Texture = null;
         for each(textures in this.var_162)
         {
            for each(texture in textures)
            {
               texture.dispose();
            }
         }
         this.var_162.length = 0;
         this.var_165.length = 0;
      }
      
      override alternativa3d function cullReciever(boundBox:name_386, object:name_78) : Boolean
      {
         return this.var_166[object];
      }
      
      public function name_401(object:name_78, light:DirectionalLight, widthPartsCount:int = 1, heightPartsCount:int = 1, overlap:Number = 0) : void
      {
         var root:name_78 = null;
         var maps:Vector.<Texture> = null;
         var matrices:Vector.<Matrix3D> = null;
         var yIndex:int = 0;
         var leftX:Number = NaN;
         var leftY:Number = NaN;
         var width:Number = NaN;
         var height:Number = NaN;
         var uvMatrix:Matrix3D = null;
         var shadowMap:Texture = null;
         var texture:name_129 = null;
         var material:class_5 = null;
         var debugObject:name_380 = null;
         var offset:Number = NaN;
         this.light = light;
         object.alternativa3d::localToCameraTransform.compose(object.alternativa3d::_x,object.alternativa3d::_y,object.alternativa3d::_z,object.alternativa3d::_rotationX,object.alternativa3d::_rotationY,object.alternativa3d::_rotationZ,object.alternativa3d::_scaleX,object.alternativa3d::_scaleY,object.alternativa3d::_scaleZ);
         for(root = object; root.alternativa3d::_parent != null; )
         {
            root = root.alternativa3d::_parent;
            root.alternativa3d::localToGlobalTransform.compose(root.alternativa3d::_x,root.alternativa3d::_y,root.alternativa3d::_z,root.alternativa3d::_rotationX,root.alternativa3d::_rotationY,root.alternativa3d::_rotationZ,root.alternativa3d::_scaleX,root.alternativa3d::_scaleY,root.alternativa3d::_scaleZ);
            object.alternativa3d::localToCameraTransform.append(root.alternativa3d::localToGlobalTransform);
         }
         light.alternativa3d::localToGlobalTransform.compose(light.alternativa3d::_x,light.alternativa3d::_y,light.alternativa3d::_z,light.alternativa3d::_rotationX,light.alternativa3d::_rotationY,light.alternativa3d::_rotationZ,light.alternativa3d::_scaleX,light.alternativa3d::_scaleY,light.alternativa3d::_scaleZ);
         for(root = light; root.alternativa3d::_parent != null; )
         {
            root = root.alternativa3d::_parent;
            root.alternativa3d::localToGlobalTransform.compose(root.alternativa3d::_x,root.alternativa3d::_y,root.alternativa3d::_z,root.alternativa3d::_rotationX,root.alternativa3d::_rotationY,root.alternativa3d::_rotationZ,root.alternativa3d::_scaleX,root.alternativa3d::_scaleY,root.alternativa3d::_scaleZ);
            light.alternativa3d::localToGlobalTransform.append(root.alternativa3d::localToGlobalTransform);
         }
         light.alternativa3d::globalToLocalTransform.copy(light.alternativa3d::localToGlobalTransform);
         light.alternativa3d::globalToLocalTransform.invert();
         this.var_167.copy(light.alternativa3d::globalToLocalTransform);
         object.alternativa3d::localToCameraTransform.append(light.alternativa3d::globalToLocalTransform);
         this.bounds.reset();
         alternativa3d::calculateBoundBox(this.bounds,object);
         var frustumMinX:Number = this.bounds.minX;
         var frustumMaxX:Number = this.bounds.maxX;
         var frustumMinY:Number = this.bounds.minY;
         var frustumMaxY:Number = this.bounds.maxY;
         var frustumMinZ:Number = this.bounds.minZ;
         var frustumMaxZ:Number = this.bounds.maxZ;
         var halfOverlap:Number = overlap * 0.5;
         var partWorldWidth:Number = (frustumMaxX - frustumMinX) / widthPartsCount;
         var partWorldHeight:Number = (frustumMaxY - frustumMinY) / heightPartsCount;
         this.var_163 = new name_78();
         if(this.var_168)
         {
            light.addChild(this.var_163);
         }
         for(var xIndex:int = 0; xIndex < widthPartsCount; )
         {
            maps = new Vector.<Texture>();
            matrices = new Vector.<Matrix3D>();
            for(yIndex = 0; yIndex < heightPartsCount; yIndex++)
            {
               leftX = frustumMinX + xIndex * partWorldWidth;
               leftY = frustumMinY + yIndex * partWorldHeight;
               if(xIndex == 0)
               {
                  width = partWorldWidth + halfOverlap;
               }
               else if(xIndex == widthPartsCount - 1)
               {
                  leftX -= halfOverlap;
                  width = partWorldWidth + halfOverlap;
               }
               else
               {
                  leftX -= halfOverlap;
                  width = partWorldWidth + overlap;
               }
               if(yIndex == 0)
               {
                  height = partWorldHeight + halfOverlap;
               }
               else if(yIndex == heightPartsCount - 1)
               {
                  leftY -= halfOverlap;
                  height = partWorldHeight + halfOverlap;
               }
               else
               {
                  leftY -= halfOverlap;
                  height = partWorldHeight + overlap;
               }
               uvMatrix = new Matrix3D();
               this.method_265(this.var_169,uvMatrix,leftX,leftY,frustumMinZ,leftX + width,leftY + height,frustumMaxZ);
               shadowMap = this.context.createTexture(this.partSize,this.partSize,Context3DTextureFormat.BGRA,true);
               this.context.setRenderToTexture(shadowMap,true,0,0);
               this.context.clear(1,1,1,0.5);
               method_221(this.context);
               name_208.alternativa3d::name_428(this.context,object,light,this.var_169);
               method_221(this.context);
               maps.push(shadowMap);
               matrices.push(uvMatrix);
               texture = new name_167(null);
               texture.alternativa3d::_texture = shadowMap;
               material = new class_5(texture);
               material.var_21 = true;
               debugObject = new name_279(width,height,1,1,1,1,false,material);
               debugObject.geometry.upload(this.context);
               debugObject.x = leftX + width / 2;
               debugObject.y = leftY + height / 2;
               debugObject.z = frustumMinZ;
               this.var_163.addChild(debugObject);
            }
            this.var_162.push(maps);
            this.var_165.push(matrices);
            xIndex++;
         }
         this.context.setRenderToBackBuffer();
         if(this.var_164 > 0)
         {
            offset = this.var_164 / partWorldWidth;
            pcfOffsets = Vector.<Number>([-offset,-offset,0,1 / 4,-offset,offset,0,1,offset,-offset,0,1,offset,offset,0,1]);
         }
      }
      
      private function method_265(matrix:Matrix3D, uvMatrix:Matrix3D, frustumMinX:Number, frustumMinY:Number, frustumMinZ:Number, frustumMaxX:Number, frustumMaxY:Number, frustumMaxZ:Number) : void
      {
         this.rawData[0] = 2 / (frustumMaxX - frustumMinX);
         this.rawData[5] = 2 / (frustumMaxY - frustumMinY);
         this.rawData[10] = 1 / (frustumMaxZ - frustumMinZ);
         this.rawData[12] = -0.5 * (frustumMaxX + frustumMinX) * this.rawData[0];
         this.rawData[13] = -0.5 * (frustumMaxY + frustumMinY) * this.rawData[5];
         this.rawData[14] = -frustumMinZ / (frustumMaxZ - frustumMinZ);
         this.rawData[15] = 1;
         matrix.rawData = this.rawData;
         this.rawData[0] = 1 / (frustumMaxX - frustumMinX);
         this.rawData[5] = -1 / (frustumMaxY - frustumMinY);
         this.rawData[12] = 0.5 - 0.5 * (frustumMaxX + frustumMinX) * this.rawData[0];
         this.rawData[13] = 0.5 - 0.5 * (frustumMaxY + frustumMinY) * this.rawData[5];
         uvMatrix.rawData = this.rawData;
      }
      
      override public function get debug() : Boolean
      {
         return this.var_168;
      }
      
      override public function set debug(value:Boolean) : void
      {
         this.var_168 = value;
         if(this.var_163 != null)
         {
            if(value)
            {
               if(this.light != null)
               {
                  this.light.addChild(this.var_163);
               }
            }
            else if(this.var_163.alternativa3d::_parent != null)
            {
               this.var_163.alternativa3d::removeFromParent();
            }
         }
      }
      
      override public function getVShader(index:int = 0) : name_114
      {
         return method_264(index);
      }
      
      override public function getFShader(index:int = 0) : name_114
      {
         return method_263(false,this.var_164 > 0,index);
      }
      
      override public function getFIntensityShader() : name_114
      {
         return method_263(false,this.var_164 > 0,0,true);
      }
      
      override public function applyShader(drawUnit:name_135, program:name_127, object:name_78, camera:name_124, index:int = 0) : void
      {
         objectToShadowMap.combine(camera.alternativa3d::localToGlobalTransform,object.alternativa3d::localToCameraTransform);
         objectToShadowMap.append(this.var_167);
         var coords:Vector3D = new Vector3D(objectToShadowMap.d,objectToShadowMap.h,objectToShadowMap.l);
         var xIndex:int = (coords.x - this.bounds.minX) / (this.bounds.maxX - this.bounds.minX) * this.var_162.length;
         xIndex = xIndex < 0 ? 0 : (xIndex >= this.var_162.length ? int(this.var_162.length - 1) : xIndex);
         var maps:Vector.<Texture> = this.var_162[xIndex];
         var matrices:Vector.<Matrix3D> = this.var_165[xIndex];
         var yIndex:int = (coords.y - this.bounds.minY) / (this.bounds.maxY - this.bounds.minY) * maps.length;
         yIndex = yIndex < 0 ? 0 : (yIndex >= maps.length ? int(maps.length - 1) : yIndex);
         var shadowMap:Texture = maps[yIndex];
         var uvMatrix:Matrix3D = matrices[yIndex];
         name_208.alternativa3d::name_427(objectToUVMap,objectToShadowMap);
         objectToUVMap.append(uvMatrix);
         objectToUVMap.transpose();
         drawUnit.alternativa3d::name_426(program.vertexShader.getVariableIndex("cTOSHADOW"),objectToUVMap.rawData,4);
         drawUnit.alternativa3d::name_205(program.fragmentShader.getVariableIndex("cConstants"),constants,1);
         if(this.var_164 > 0)
         {
            drawUnit.alternativa3d::name_205(program.fragmentShader.getVariableIndex("cPCF0"),pcfOffsets,pcfOffsets.length >> 2);
         }
         drawUnit.alternativa3d::setTextureAt(program.fragmentShader.getVariableIndex("sSHADOWMAP"),shadowMap);
      }
   }
}

