package package_83
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import package_10.name_23;
   import package_13.name_28;
   import package_14.name_3;
   import package_17.name_28;
   import package_19.class_16;
   import package_19.name_523;
   import package_19.name_531;
   import package_21.name_136;
   import package_21.name_85;
   import package_3.name_29;
   import package_32.name_180;
   import package_33.name_117;
   import package_33.name_130;
   import package_33.name_334;
   import package_33.name_542;
   import package_35.DirectionalLight;
   import package_35.OmniLight;
   import package_35.SpotLight;
   import package_35.name_530;
   import package_85.A3D2AmbientLight;
   import package_85.A3D2Box;
   import package_85.A3D2DirectionalLight;
   import package_85.A3D2Joint;
   import package_85.A3D2Mesh;
   import package_85.A3D2Object;
   import package_85.A3D2OmniLight;
   import package_85.A3D2Skin;
   import package_85.A3D2SpotLight;
   import package_85.A3D2Surface;
   import package_85.A3D2Transform;
   import package_86.A3D2IndexBuffer;
   import package_86.A3D2VertexAttributes;
   import package_86.A3D2VertexBuffer;
   import package_87.A3D2Image;
   import package_87.A3D2Map;
   import package_87.A3D2Material;
   import package_88.name_522;
   import package_89.name_525;
   import package_89.name_529;
   import package_89.name_533;
   import package_89.name_536;
   import package_90.name_524;
   import package_91.A3DImage;
   import package_91.A3DMap;
   import package_91.A3DMaterial;
   import package_92.name_527;
   import package_92.name_535;
   import package_92.name_538;
   import package_93.A3DBox;
   import package_93.A3DObject;
   import package_93.A3DSurface;
   import package_94.A3DGeometry;
   import package_94.A3DIndexBuffer;
   import package_94.A3DVertexBuffer;
   import package_95.name_526;
   import package_96.name_528;
   import package_97.name_534;
   import package_97.name_540;
   import package_98.name_543;
   
   use namespace alternativa3d;
   
   public class name_470
   {
      public var hierarchy:Vector.<name_130>;
      
      public var objects:Vector.<name_130>;
      
      private var maps:Dictionary;
      
      private var materials:Dictionary;
      
      private var protocol:name_527;
      
      private var var_628:Object;
      
      private var var_629:Boolean = false;
      
      public function name_470()
      {
         super();
         this.init();
      }
      
      private static function method_290(source:name_526) : name_524
      {
         var i:int = 0;
         var count:int = 0;
         var sourceBox:A3DBox = null;
         var destBox:A3D2Box = null;
         var sourceGeometry:A3DGeometry = null;
         var sourceImage:A3DImage = null;
         var destImage:A3D2Image = null;
         var sourceMap:A3DMap = null;
         var destMap:A3D2Map = null;
         var sourceMaterial:A3DMaterial = null;
         var destMaterial:A3D2Material = null;
         var sourceObject:A3DObject = null;
         var destMesh:A3D2Mesh = null;
         var destIndexBufferId:int = 0;
         var destVertexBuffersIds:Vector.<int> = null;
         var sourceIndexBuffer:A3DIndexBuffer = null;
         var sourceVertexBuffers:Vector.<A3DVertexBuffer> = null;
         var destIndexBuffer:A3D2IndexBuffer = null;
         var j:int = 0;
         var inCount:int = 0;
         var sourceVertexBuffer:A3DVertexBuffer = null;
         var sourceAttributes:Vector.<int> = null;
         var destAttributes:Vector.<A3D2VertexAttributes> = null;
         var k:int = 0;
         var kCount:int = 0;
         var destVertexBuffer:A3D2VertexBuffer = null;
         var attr:int = 0;
         var destObject:A3D2Object = null;
         var sourceBoxes:Vector.<A3DBox> = source.boxes;
         var destBoxes:Vector.<A3D2Box> = null;
         if(sourceBoxes != null)
         {
            destBoxes = new Vector.<A3D2Box>();
            for(i = 0,count = int(sourceBoxes.length); i < count; i++)
            {
               sourceBox = sourceBoxes[i];
               destBox = new A3D2Box(sourceBox.box,sourceBox.id.id);
               destBoxes[i] = destBox;
            }
         }
         var sourceGeometries:Dictionary = new Dictionary();
         if(source.geometries != null)
         {
            for each(sourceGeometry in source.geometries)
            {
               sourceGeometries[sourceGeometry.id.id] = sourceGeometry;
            }
         }
         var sourceImages:Vector.<A3DImage> = source.images;
         var destImages:Vector.<A3D2Image> = null;
         if(sourceImages != null)
         {
            destImages = new Vector.<A3D2Image>();
            for(i = 0,count = int(sourceImages.length); i < count; i++)
            {
               sourceImage = sourceImages[i];
               destImage = new A3D2Image(sourceImage.id.id,sourceImage.url);
               destImages[i] = destImage;
            }
         }
         var sourceMaps:Vector.<A3DMap> = source.maps;
         var destMaps:Vector.<A3D2Map> = null;
         if(sourceMaps != null)
         {
            destMaps = new Vector.<A3D2Map>();
            for(i = 0,count = int(sourceMaps.length); i < count; i++)
            {
               sourceMap = sourceMaps[i];
               destMap = new A3D2Map(sourceMap.channel,sourceMap.id.id,sourceMap.imageId.id);
               destMaps[i] = destMap;
            }
         }
         var sourceMaterials:Vector.<A3DMaterial> = source.materials;
         var destMaterials:Vector.<A3D2Material> = null;
         if(sourceMaterials != null)
         {
            destMaterials = new Vector.<A3D2Material>();
            for(i = 0,count = int(sourceMaterials.length); i < count; i++)
            {
               sourceMaterial = sourceMaterials[i];
               destMaterial = new A3D2Material(method_280(sourceMaterial.diffuseMapId),method_280(sourceMaterial.glossinessMapId),method_280(sourceMaterial.id),method_280(sourceMaterial.lightMapId),method_280(sourceMaterial.normalMapId),method_280(sourceMaterial.opacityMapId),-1,method_280(sourceMaterial.specularMapId));
               destMaterials[i] = destMaterial;
            }
         }
         var sourceObjects:Vector.<A3DObject> = source.objects;
         var destObjects:Vector.<A3D2Object> = null;
         var destMeshes:Vector.<A3D2Mesh> = null;
         var destVertexBuffers:Vector.<A3D2VertexBuffer> = null;
         var destIndexBuffers:Vector.<A3D2IndexBuffer> = null;
         var lastIndexBufferIndex:uint = 0;
         var lastVertexBufferIndex:uint = 0;
         var objectsMap:Dictionary = new Dictionary();
         if(sourceObjects != null)
         {
            destMeshes = new Vector.<A3D2Mesh>();
            destObjects = new Vector.<A3D2Object>();
            destVertexBuffers = new Vector.<A3D2VertexBuffer>();
            destIndexBuffers = new Vector.<A3D2IndexBuffer>();
            for(i = 0,count = int(sourceObjects.length); i < count; i++)
            {
               sourceObject = sourceObjects[i];
               if(sourceObject.surfaces != null && sourceObject.surfaces.length > 0)
               {
                  destMesh = null;
                  sourceGeometry = sourceGeometries[sourceObject.geometryId.id];
                  destIndexBufferId = -1;
                  destVertexBuffersIds = new Vector.<int>();
                  if(sourceGeometry != null)
                  {
                     sourceIndexBuffer = sourceGeometry.indexBuffer;
                     sourceVertexBuffers = sourceGeometry.vertexBuffers;
                     destIndexBuffer = new A3D2IndexBuffer(sourceIndexBuffer.byteBuffer,lastIndexBufferIndex++,sourceIndexBuffer.indexCount);
                     destIndexBufferId = int(destIndexBuffer.id);
                     destIndexBuffers.push(destIndexBuffer);
                     for(j = 0,inCount = int(sourceVertexBuffers.length); j < inCount; j++)
                     {
                        sourceVertexBuffer = sourceVertexBuffers[j];
                        sourceAttributes = sourceVertexBuffer.attributes;
                        destAttributes = new Vector.<A3D2VertexAttributes>();
                        for(k = 0,kCount = int(sourceAttributes.length); k < kCount; )
                        {
                           attr = sourceAttributes[k];
                           switch(attr)
                           {
                              case 0:
                                 destAttributes[k] = A3D2VertexAttributes.POSITION;
                                 break;
                              case 1:
                                 destAttributes[k] = A3D2VertexAttributes.NORMAL;
                                 break;
                              case 2:
                                 destAttributes[k] = A3D2VertexAttributes.TANGENT4;
                                 break;
                              case 3:
                                 break;
                              case 4:
                                 break;
                              case 5:
                                 destAttributes[k] = A3D2VertexAttributes.TEXCOORD;
                                 break;
                           }
                           k++;
                        }
                        destVertexBuffer = new A3D2VertexBuffer(destAttributes,sourceVertexBuffer.byteBuffer,lastVertexBufferIndex++,sourceVertexBuffer.vertexCount);
                        destVertexBuffers.push(destVertexBuffer);
                        destVertexBuffersIds.push(destVertexBuffer.id);
                     }
                  }
                  destMesh = new A3D2Mesh(method_280(sourceObject.boundBoxId),method_284(sourceObject.id),destIndexBufferId,sourceObject.name,method_285(sourceObject.parentId),method_288(sourceObject.surfaces),new A3D2Transform(sourceObject.transformation.matrix),destVertexBuffersIds,sourceObject.visible);
                  destMeshes.push(destMesh);
                  objectsMap[sourceObject.id.id] = destMesh;
               }
               else
               {
                  destObject = new A3D2Object(method_280(sourceObject.boundBoxId),method_284(sourceObject.id),sourceObject.name,method_285(sourceObject.parentId),new A3D2Transform(sourceObject.transformation.matrix),sourceObject.visible);
                  destObjects.push(destObject);
                  objectsMap[sourceObject.id.id] = destObject;
               }
            }
         }
         return new name_524(null,null,null,destBoxes,null,null,null,destImages,destIndexBuffers,null,destMaps,destMaterials,destMeshes != null && destMeshes.length > 0 ? destMeshes : null,destObjects != null && destObjects.length > 0 ? destObjects : null,null,null,null,null,destVertexBuffers);
      }
      
      private static function method_280(id:name_540) : int
      {
         return id != null ? int(id.id) : -1;
      }
      
      private static function method_284(id:name_540) : name_522
      {
         return id != null ? name_522.name_532(id.id) : name_522.name_532(-1);
      }
      
      private static function method_285(parentId:name_543) : name_522
      {
         if(parentId == null)
         {
            return null;
         }
         return parentId != null ? name_522.name_532(parentId.id) : null;
      }
      
      private static function method_288(source:Vector.<A3DSurface>) : Vector.<A3D2Surface>
      {
         var sourceSurface:A3DSurface = null;
         var destSurface:A3D2Surface = null;
         var dest:Vector.<A3D2Surface> = new Vector.<A3D2Surface>();
         for(var i:int = 0,var count:int = int(source.length); i < count; i++)
         {
            sourceSurface = source[i];
            destSurface = new A3D2Surface(sourceSurface.indexBegin,method_280(sourceSurface.materialId),sourceSurface.numTriangles);
            dest[i] = destSurface;
         }
         return dest;
      }
      
      public function method_132(input:ByteArray) : void
      {
         var version:int = 0;
         try
         {
            input.position = 0;
            version = int(input.readByte());
            if(version == 0)
            {
               this.parseVersion1(input);
            }
            else
            {
               this.method_292(input);
            }
         }
         catch(e:Error)
         {
            throw new Error("parsing failed",0);
         }
      }
      
      public function method_295(name:String) : name_130
      {
         var object:name_130 = null;
         for each(object in this.objects)
         {
            if(object.name == name)
            {
               return object;
            }
         }
         return null;
      }
      
      private function init() : void
      {
         if(this.var_629)
         {
            return;
         }
         if(name_3.name_8() != null)
         {
            this.protocol = name_527(name_3.name_8().name_21(name_529));
            return;
         }
         name_3.clientLog = new DummyClientLog();
         var osgi:name_3 = new name_3();
         osgi.method_38(name_180,new DummyClientLog());
         new name_23().start(osgi);
         new package_17.name_28().start(osgi);
         new package_13.name_28().start(osgi);
         this.protocol = name_527(osgi.name_21(name_529));
         this.var_629 = true;
      }
      
      private function parseVersion1(input:ByteArray) : void
      {
         input.position = 4;
         var nullMap:name_533 = name_538.name_541(input);
         nullMap.name_548(0);
         var data:ByteArray = new ByteArray();
         data.writeBytes(input,input.position);
         data.position = 0;
         var buffer:name_525 = new name_525(data,data,nullMap);
         var codec:name_536 = this.protocol.name_539(new name_528(name_526,false));
         var _a3d:name_526 = name_526(codec.name_537(buffer));
         var a3d2:name_524 = method_290(_a3d);
         this.method_286(a3d2);
      }
      
      private function method_286(a3d:name_524) : void
      {
         var a3DObject:A3D2Object = null;
         var a3DMesh:A3D2Mesh = null;
         var a3DIndexBuffer:A3D2IndexBuffer = null;
         var a3DVertexBuffer:A3D2VertexBuffer = null;
         var a3DMaterial:A3D2Material = null;
         var a3DBox:A3D2Box = null;
         var a3DMap:A3D2Map = null;
         var a3DImage:A3D2Image = null;
         var a3DAmbientLight:A3D2AmbientLight = null;
         var a3DOmniLight:A3D2OmniLight = null;
         var a3DSpotLight:A3D2SpotLight = null;
         var a3DDirLight:A3D2DirectionalLight = null;
         var a3DSkin:A3D2Skin = null;
         var a3DJoint:A3D2Joint = null;
         var parent:name_522 = null;
         var p:name_130 = null;
         var object:name_130 = null;
         var resJoint:name_523 = null;
         var resSkin:class_16 = null;
         var resAmbientLight:name_530 = null;
         var resObject:name_130 = null;
         var resOmniLight:OmniLight = null;
         var resSpotLight:SpotLight = null;
         var resDirLight:DirectionalLight = null;
         var resMesh:class_16 = null;
         var objectsMap:Dictionary = new Dictionary();
         var a3DIndexBuffers:Dictionary = new Dictionary();
         var a3DVertexBuffers:Dictionary = new Dictionary();
         var a3DMaterials:Dictionary = new Dictionary();
         var a3DBoxes:Dictionary = new Dictionary();
         var a3DMaps:Dictionary = new Dictionary();
         var a3DImages:Dictionary = new Dictionary();
         var parents:Dictionary = new Dictionary();
         for each(a3DIndexBuffer in a3d.indexBuffers)
         {
            a3DIndexBuffers[a3DIndexBuffer.id] = a3DIndexBuffer;
         }
         for each(a3DVertexBuffer in a3d.vertexBuffers)
         {
            a3DVertexBuffers[a3DVertexBuffer.id] = a3DVertexBuffer;
         }
         for each(a3DBox in a3d.boxes)
         {
            a3DBoxes[a3DBox.id] = a3DBox;
         }
         for each(a3DMaterial in a3d.materials)
         {
            a3DMaterials[a3DMaterial.id] = a3DMaterial;
         }
         for each(a3DMap in a3d.maps)
         {
            a3DMaps[a3DMap.id] = a3DMap;
         }
         for each(a3DImage in a3d.images)
         {
            a3DImages[a3DImage.id] = a3DImage;
         }
         this.hierarchy = new Vector.<name_130>();
         this.objects = new Vector.<name_130>();
         this.maps = new Dictionary();
         this.materials = new Dictionary();
         this.var_628 = new Dictionary();
         for each(a3DJoint in a3d.joints)
         {
            resJoint = new name_523();
            resJoint.visible = a3DJoint.visible;
            resJoint.name = a3DJoint.name;
            parents[resJoint] = a3DJoint.parentId;
            objectsMap[a3DJoint.id] = resJoint;
            if(a3DJoint.parentId == null)
            {
               this.hierarchy.push(resJoint);
            }
            this.objects.push(resJoint);
            this.method_281(a3DJoint.transform,resJoint);
            a3DBox = a3DBoxes[a3DJoint.boundBoxId];
            if(a3DBox != null)
            {
               this.method_283(a3DBox.box,resJoint);
            }
         }
         for each(a3DSkin in a3d.skins)
         {
            resSkin = this.method_291(a3DSkin,a3DIndexBuffers,a3DVertexBuffers,a3DMaterials,a3DMaps,a3DImages);
            resSkin.visible = a3DSkin.visible;
            resSkin.name = a3DSkin.name;
            parents[resSkin] = a3DSkin.parentId;
            objectsMap[a3DSkin.id] = resSkin;
            if(a3DSkin.parentId == null)
            {
               this.hierarchy.push(resSkin);
            }
            this.objects.push(resSkin);
            this.method_281(a3DSkin.transform,resSkin);
            a3DBox = a3DBoxes[a3DSkin.boundBoxId];
            if(a3DBox != null)
            {
               this.method_283(a3DBox.box,resSkin);
            }
         }
         for each(a3DAmbientLight in a3d.ambientLights)
         {
            resAmbientLight = new name_530(a3DAmbientLight.color);
            resAmbientLight.intensity = a3DAmbientLight.intensity;
            resAmbientLight.visible = a3DAmbientLight.visible;
            resAmbientLight.name = a3DAmbientLight.name;
            parents[resAmbientLight] = a3DAmbientLight.parentId;
            objectsMap[a3DAmbientLight.id] = resAmbientLight;
            if(a3DAmbientLight.parentId == null)
            {
               this.hierarchy.push(resAmbientLight);
            }
            this.objects.push(resAmbientLight);
            this.method_281(a3DAmbientLight.transform,resAmbientLight);
            a3DBox = a3DBoxes[a3DAmbientLight.boundBoxId];
            if(a3DBox != null)
            {
               this.method_283(a3DBox.box,resAmbientLight);
            }
         }
         for each(a3DObject in a3d.objects)
         {
            resObject = new name_130();
            resObject.visible = a3DObject.visible;
            resObject.name = a3DObject.name;
            parents[resObject] = a3DObject.parentId;
            objectsMap[a3DObject.id] = resObject;
            if(a3DObject.parentId == null)
            {
               this.hierarchy.push(resObject);
            }
            this.objects.push(resObject);
            this.method_281(a3DObject.transform,resObject);
            a3DBox = a3DBoxes[a3DObject.boundBoxId];
            if(a3DBox != null)
            {
               this.method_283(a3DBox.box,resObject);
            }
         }
         for each(a3DOmniLight in a3d.omniLights)
         {
            resOmniLight = new OmniLight(a3DOmniLight.color,a3DOmniLight.attenuationBegin,a3DOmniLight.attenuationEnd);
            resOmniLight.visible = a3DOmniLight.visible;
            resOmniLight.name = a3DOmniLight.name;
            parents[resOmniLight] = a3DOmniLight.parentId;
            objectsMap[a3DOmniLight.id] = resOmniLight;
            if(a3DOmniLight.parentId == null)
            {
               this.hierarchy.push(resOmniLight);
            }
            this.objects.push(resOmniLight);
            this.method_281(a3DOmniLight.transform,resOmniLight);
         }
         for each(a3DSpotLight in a3d.spotLights)
         {
            resSpotLight = new SpotLight(a3DSpotLight.color,a3DSpotLight.attenuationBegin,a3DSpotLight.attenuationEnd,a3DSpotLight.hotspot,a3DSpotLight.falloff);
            resSpotLight.visible = a3DSpotLight.visible;
            resSpotLight.name = a3DSpotLight.name;
            parents[resSpotLight] = a3DSpotLight.parentId;
            objectsMap[a3DSpotLight.id] = resSpotLight;
            if(a3DSpotLight.parentId == null)
            {
               this.hierarchy.push(resSpotLight);
            }
            this.objects.push(resSpotLight);
            this.method_281(a3DSpotLight.transform,resSpotLight);
         }
         for each(a3DDirLight in a3d.directionalLights)
         {
            resDirLight = new DirectionalLight(a3DDirLight.color);
            resDirLight.visible = a3DDirLight.visible;
            resDirLight.name = a3DDirLight.name;
            parents[resDirLight] = a3DDirLight.parentId;
            objectsMap[a3DDirLight.id] = resDirLight;
            if(a3DDirLight.parentId == null)
            {
               this.hierarchy.push(resDirLight);
            }
            this.objects.push(resDirLight);
            this.method_281(a3DDirLight.transform,resDirLight);
         }
         for each(a3DMesh in a3d.meshes)
         {
            resMesh = this.method_293(a3DMesh,a3DIndexBuffers,a3DVertexBuffers,a3DMaterials,a3DMaps,a3DImages);
            resMesh.visible = a3DMesh.visible;
            resMesh.name = a3DMesh.name;
            parents[resMesh] = a3DMesh.parentId;
            objectsMap[a3DMesh.id] = resMesh;
            if(a3DMesh.parentId == null)
            {
               this.hierarchy.push(resMesh);
            }
            this.objects.push(resMesh);
            this.method_281(a3DMesh.transform,resMesh);
            a3DBox = a3DBoxes[a3DMesh.boundBoxId];
            if(a3DBox != null)
            {
               this.method_283(a3DBox.box,resMesh);
            }
         }
         for each(object in objectsMap)
         {
            parent = parents[object];
            if(parent != null)
            {
               p = objectsMap[parent];
               p.addChild(object);
            }
         }
      }
      
      private function method_296(source:Vector.<Vector.<name_522>>, objectsMap:Dictionary) : Vector.<Vector.<name_523>>
      {
         var vector:Vector.<name_522> = null;
         var resultVector:Vector.<name_523> = null;
         var j:int = 0;
         var jcount:int = 0;
         var result:Vector.<Vector.<name_523>> = new Vector.<Vector.<name_523>>();
         for(var i:int = 0,var count:int = int(source.length); i < count; i++)
         {
            vector = source[i];
            resultVector = new Vector.<name_523>();
            for(j = 0,jcount = int(vector.length); j < jcount; j++)
            {
               resultVector[j] = objectsMap[vector[j]];
            }
            result[i] = resultVector;
         }
         return result;
      }
      
      private function method_292(input:ByteArray) : void
      {
         input.position = 0;
         var data:ByteArray = new ByteArray();
         var buffer:name_525 = new name_525(data,data,new name_533());
         name_535.name_546(input,buffer);
         input.position = 0;
         var versionMajor:int = int(buffer.reader.readUnsignedShort());
         var versionMinor:int = int(buffer.reader.readUnsignedShort());
         switch(versionMajor)
         {
            case 2:
               this.parseVersion2_0(buffer);
         }
      }
      
      private function parseVersion2_0(buffer:name_525) : void
      {
         var codec:name_536 = this.protocol.name_539(new name_528(name_524,false));
         var a3d:name_524 = name_524(codec.name_537(buffer));
         this.method_286(a3d);
      }
      
      private function method_283(box:Vector.<Number>, destination:name_130) : void
      {
         destination.boundBox = new name_334();
         destination.boundBox.minX = box[0];
         destination.boundBox.minY = box[1];
         destination.boundBox.minZ = box[2];
         destination.boundBox.maxX = box[3];
         destination.boundBox.maxY = box[4];
         destination.boundBox.maxZ = box[5];
      }
      
      private function method_281(transform:A3D2Transform, obj:name_130) : void
      {
         if(transform == null)
         {
            return;
         }
         var matrix:name_534 = transform.matrix;
         var mat:Matrix3D = new Matrix3D(Vector.<Number>([matrix.a,matrix.e,matrix.i,0,matrix.b,matrix.f,matrix.j,0,matrix.c,matrix.g,matrix.k,0,matrix.d,matrix.h,matrix.l,1]));
         var vecs:Vector.<Vector3D> = mat.decompose();
         obj.x = vecs[0].x;
         obj.y = vecs[0].y;
         obj.z = vecs[0].z;
         obj.rotationX = vecs[1].x;
         obj.rotationY = vecs[1].y;
         obj.rotationZ = vecs[1].z;
         obj.scaleX = vecs[2].x;
         obj.scaleY = vecs[2].y;
         obj.scaleZ = vecs[2].z;
      }
      
      private function method_294(transform:A3D2Transform, obj:name_523) : void
      {
         if(transform == null)
         {
            return;
         }
         var matrix:name_534 = transform.matrix;
         var mat:Vector.<Number> = Vector.<Number>([matrix.a,matrix.b,matrix.c,matrix.d,matrix.e,matrix.f,matrix.g,matrix.h,matrix.i,matrix.j,matrix.k,matrix.l]);
         obj.alternativa3d::name_545(mat);
      }
      
      private function method_293(a3DMesh:A3D2Mesh, indexBuffers:Dictionary, vertexBuffers:Dictionary, materials:Dictionary, maps:Dictionary, images:Dictionary) : class_16
      {
         var s:A3D2Surface = null;
         var m:name_471 = null;
         var res:class_16 = new class_16();
         res.geometry = this.method_289(a3DMesh.indexBufferId,a3DMesh.vertexBuffers,indexBuffers,vertexBuffers);
         var surfaces:Vector.<A3D2Surface> = a3DMesh.surfaces;
         for(var i:int = 0; i < surfaces.length; i++)
         {
            s = surfaces[i];
            m = this.method_287(materials[s.materialId],maps,images);
            res.addSurface(m,s.indexBegin,s.numTriangles);
         }
         return res;
      }
      
      private function method_291(a3DSkin:A3D2Skin, indexBuffers:Dictionary, vertexBuffers:Dictionary, materials:Dictionary, maps:Dictionary, images:Dictionary) : name_531
      {
         var s:A3D2Surface = null;
         var m:name_471 = null;
         var res:name_531 = new name_531(1,a3DSkin.joints.length);
         res.geometry = this.method_289(a3DSkin.indexBufferId,a3DSkin.vertexBuffers,indexBuffers,vertexBuffers);
         var surfaces:Vector.<A3D2Surface> = a3DSkin.surfaces;
         for(var i:int = 0; i < surfaces.length; i++)
         {
            s = surfaces[i];
            m = this.method_287(materials[s.materialId],maps,images);
            res.addSurface(m,s.indexBegin,s.numTriangles);
         }
         return res;
      }
      
      private function method_297(geometry:name_136) : void
      {
         var offset:int = 0;
         var i:int = 0;
         var attr:int = 0;
         var vertexStream:name_542 = geometry.alternativa3d::_vertexStreams[0];
         var prev:int = -1;
         var stride:int = vertexStream.attributes.length * 4;
         var length:int = vertexStream.data.length / stride;
         var data:ByteArray = vertexStream.data;
         for(var j:int = 0; j < length; j++)
         {
            offset = -4;
            for(i = 0; i < stride; i++)
            {
               attr = int(vertexStream.attributes[i]);
               offset += 4;
               if(attr != prev)
               {
                  switch(attr)
                  {
                     case name_117.JOINTS[0]:
                        data.position = j * stride + offset;
                        trace("JOINT0:",data.readFloat(),data.readFloat(),data.readFloat(),data.readFloat());
                        break;
                     case name_117.JOINTS[1]:
                        data.position = j * stride + offset;
                        trace("JOINT1:",data.readFloat(),data.readFloat(),data.readFloat(),data.readFloat());
                  }
                  prev = attr;
               }
            }
         }
      }
      
      private function method_289(indexBufferID:int, vertexBuffersIDs:Vector.<int>, indexBuffers:Dictionary, vertexBuffers:Dictionary) : name_136
      {
         var id:int = 0;
         var geometry:name_136 = null;
         var vertexCount:uint = 0;
         var buffer:A3D2VertexBuffer = null;
         var byteArray:ByteArray = null;
         var offset:int = 0;
         var attributes:Array = null;
         var jointsOffset:int = 0;
         var k:int = 0;
         var attr:int = 0;
         var numFloats:int = 0;
         var t:int = 0;
         var key:String = "i" + indexBufferID.toString();
         for each(id in vertexBuffersIDs)
         {
            key += "v" + id.toString();
         }
         geometry = this.var_628[key];
         if(geometry != null)
         {
            return geometry;
         }
         geometry = new name_136();
         var a3dIB:A3D2IndexBuffer = indexBuffers[indexBufferID];
         var indices:Vector.<uint> = name_29.name_544(a3dIB.byteBuffer);
         var uvoffset:int = 0;
         geometry.alternativa3d::_indices = indices;
         var buffers:Vector.<int> = vertexBuffersIDs;
         for(var j:int = 0; j < buffers.length; j++)
         {
            buffer = vertexBuffers[buffers[j]];
            vertexCount = uint(buffer.vertexCount);
            byteArray = buffer.byteBuffer;
            byteArray.endian = Endian.LITTLE_ENDIAN;
            offset = 0;
            attributes = new Array();
            jointsOffset = 0;
            for(k = 0; k < buffer.attributes.length; k++)
            {
               switch(buffer.attributes[k])
               {
                  case A3D2VertexAttributes.POSITION:
                     attr = int(name_117.POSITION);
                     break;
                  case A3D2VertexAttributes.NORMAL:
                     attr = int(name_117.NORMAL);
                     break;
                  case A3D2VertexAttributes.TANGENT4:
                     attr = int(name_117.TANGENT4);
                     break;
                  case A3D2VertexAttributes.TEXCOORD:
                     attr = int(name_117.TEXCOORDS[uvoffset]);
                     uvoffset++;
                     break;
                  case A3D2VertexAttributes.JOINT:
                     attr = int(name_117.JOINTS[jointsOffset]);
                     jointsOffset++;
               }
               numFloats = int(name_117.name_547(attr));
               numFloats = numFloats < 1 ? 1 : numFloats;
               for(t = 0; t < numFloats; t++)
               {
                  attributes[offset] = attr;
                  offset++;
               }
            }
            geometry.addVertexStream(attributes);
            geometry.alternativa3d::_vertexStreams[0].data = byteArray;
         }
         geometry.alternativa3d::_numVertices = buffers.length > 0 ? int(vertexCount) : 0;
         this.var_628[key] = geometry;
         return geometry;
      }
      
      private function method_282(source:A3D2Map, images:Dictionary) : name_85
      {
         if(source == null)
         {
            return null;
         }
         var res:name_85 = this.maps[source.imageId];
         if(res != null)
         {
            return res;
         }
         return this.maps[source.imageId] = new name_85(images[source.imageId].url);
      }
      
      private function method_287(source:A3D2Material, a3DMaps:Dictionary, images:Dictionary) : name_471
      {
         if(source == null)
         {
            return null;
         }
         var res:name_471 = this.materials[source.id];
         if(res != null)
         {
            return res;
         }
         res = this.materials[source.id] = new name_471();
         res.textures["diffuse"] = this.method_282(a3DMaps[source.diffuseMapId],images);
         res.textures["emission"] = this.method_282(a3DMaps[source.lightMapId],images);
         res.textures["bump"] = this.method_282(a3DMaps[source.normalMapId],images);
         res.textures["specular"] = this.method_282(a3DMaps[source.specularMapId],images);
         res.textures["glossiness"] = this.method_282(a3DMaps[source.glossinessMapId],images);
         res.textures["transparent"] = this.method_282(a3DMaps[source.opacityMapId],images);
         return res;
      }
   }
}

import package_32.class_23;
import package_32.name_180;

class DummyClientLog implements name_180
{
   public function DummyClientLog()
   {
      super();
   }
   
   public function logError(channelName:String, text:String, ... vars) : void
   {
   }
   
   public function log(channelName:String, text:String, ... rest) : void
   {
   }
   
   public function getChannelStrings(channelName:String) : Vector.<String>
   {
      return null;
   }
   
   public function addLogListener(listener:class_23) : void
   {
   }
   
   public function removeLogListener(listener:class_23) : void
   {
   }
   
   public function addLogChannelListener(channelName:String, listener:class_23) : void
   {
   }
   
   public function removeLogChannelListener(channelName:String, listener:class_23) : void
   {
   }
   
   public function getChannelNames() : Vector.<String>
   {
      return null;
   }
}
