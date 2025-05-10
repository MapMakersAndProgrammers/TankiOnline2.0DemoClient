package alternativa.engine3d.loaders
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.BoundBox;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.core.VertexStream;
   import alternativa.engine3d.lights.AmbientLight;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.lights.SpotLight;
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.objects.Joint;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.OptionalMap;
   import alternativa.protocol.ProtocolBuffer;
   import alternativa.protocol.impl.OptionalMapCodecHelper;
   import alternativa.protocol.impl.PacketHelper;
   import alternativa.protocol.impl.Protocol;
   import alternativa.protocol.info.TypeCodecInfo;
   import alternativa.protocol.osgi.ProtocolActivator;
   import alternativa.types.Long;
   import commons.A3DMatrix;
   import commons.Id;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import platform.client.a3d.osgi.Activator;
   import platform.clients.fp10.libraries.alternativaprotocol.Activator;
   import versions.version1.a3d.A3D;
   import versions.version1.a3d.geometry.A3DGeometry;
   import versions.version1.a3d.geometry.A3DIndexBuffer;
   import versions.version1.a3d.geometry.A3DVertexBuffer;
   import versions.version1.a3d.id.ParentId;
   import versions.version1.a3d.materials.A3DImage;
   import versions.version1.a3d.materials.A3DMap;
   import versions.version1.a3d.materials.A3DMaterial;
   import versions.version1.a3d.objects.A3DBox;
   import versions.version1.a3d.objects.A3DObject;
   import versions.version1.a3d.objects.A3DSurface;
   import versions.version2.a3d.A3D2;
   import versions.version2.a3d.geometry.A3D2IndexBuffer;
   import versions.version2.a3d.geometry.A3D2VertexAttributes;
   import versions.version2.a3d.geometry.A3D2VertexBuffer;
   import versions.version2.a3d.materials.A3D2Image;
   import versions.version2.a3d.materials.A3D2Map;
   import versions.version2.a3d.materials.A3D2Material;
   import versions.version2.a3d.objects.A3D2AmbientLight;
   import versions.version2.a3d.objects.A3D2Box;
   import versions.version2.a3d.objects.A3D2DirectionalLight;
   import versions.version2.a3d.objects.A3D2Joint;
   import versions.version2.a3d.objects.A3D2Mesh;
   import versions.version2.a3d.objects.A3D2Object;
   import versions.version2.a3d.objects.A3D2OmniLight;
   import versions.version2.a3d.objects.A3D2Skin;
   import versions.version2.a3d.objects.A3D2SpotLight;
   import versions.version2.a3d.objects.A3D2Surface;
   import versions.version2.a3d.objects.A3D2Transform;
   
   use namespace alternativa3d;
   
   public class ParserA3D
   {
      public var hierarchy:Vector.<Object3D>;
      
      public var objects:Vector.<Object3D>;
      
      private var maps:Dictionary;
      
      private var materials:Dictionary;
      
      private var protocol:Protocol;
      
      private var §_-gk§:Object;
      
      private var §_-Y8§:Boolean = false;
      
      public function ParserA3D()
      {
         super();
         this.init();
      }
      
      private static function convert1_2(source:A3D) : A3D2
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
         var _loc47_:A3D2Object = null;
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
               destMaterial = new A3D2Material(idToInt(sourceMaterial.diffuseMapId),idToInt(sourceMaterial.glossinessMapId),idToInt(sourceMaterial.id),idToInt(sourceMaterial.lightMapId),idToInt(sourceMaterial.normalMapId),idToInt(sourceMaterial.opacityMapId),-1,idToInt(sourceMaterial.specularMapId));
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
                     destIndexBufferId = destIndexBuffer.id;
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
                  destMesh = new A3D2Mesh(idToInt(sourceObject.boundBoxId),idToLong(sourceObject.id),destIndexBufferId,sourceObject.name,convertParent1_2(sourceObject.parentId),convertSurfaces1_2(sourceObject.surfaces),new A3D2Transform(sourceObject.transformation.matrix),destVertexBuffersIds,sourceObject.visible);
                  destMeshes.push(destMesh);
                  objectsMap[sourceObject.id.id] = destMesh;
               }
               else
               {
                  _loc47_ = new A3D2Object(idToInt(sourceObject.boundBoxId),idToLong(sourceObject.id),sourceObject.name,convertParent1_2(sourceObject.parentId),new A3D2Transform(sourceObject.transformation.matrix),sourceObject.visible);
                  destObjects.push(_loc47_);
                  objectsMap[sourceObject.id.id] = _loc47_;
               }
            }
         }
         return new A3D2(null,null,null,destBoxes,null,null,null,destImages,destIndexBuffers,null,destMaps,destMaterials,destMeshes != null && destMeshes.length > 0 ? destMeshes : null,destObjects != null && destObjects.length > 0 ? destObjects : null,null,null,null,null,destVertexBuffers);
      }
      
      private static function idToInt(id:Id) : int
      {
         return id != null ? int(id.id) : -1;
      }
      
      private static function idToLong(id:Id) : Long
      {
         return id != null ? Long.fromInt(id.id) : Long.fromInt(-1);
      }
      
      private static function convertParent1_2(parentId:ParentId) : Long
      {
         if(parentId == null)
         {
            return null;
         }
         return parentId != null ? Long.fromInt(parentId.id) : null;
      }
      
      private static function convertSurfaces1_2(source:Vector.<A3DSurface>) : Vector.<A3D2Surface>
      {
         var sourceSurface:A3DSurface = null;
         var destSurface:A3D2Surface = null;
         var dest:Vector.<A3D2Surface> = new Vector.<A3D2Surface>();
         for(var i:int = 0,var count:int = int(source.length); i < count; i++)
         {
            sourceSurface = source[i];
            destSurface = new A3D2Surface(sourceSurface.indexBegin,idToInt(sourceSurface.materialId),sourceSurface.numTriangles);
            dest[i] = destSurface;
         }
         return dest;
      }
      
      public function parse(input:ByteArray) : void
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
               this.parseVersionOver1(input);
            }
         }
         catch(e:Error)
         {
            throw new Error("parsing failed",0);
         }
      }
      
      public function getObjectByName(name:String) : Object3D
      {
         var object:Object3D = null;
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
         if(this.§_-Y8§)
         {
            return;
         }
         if(OSGi.getInstance() != null)
         {
            this.protocol = Protocol(OSGi.getInstance().getService(IProtocol));
            return;
         }
         OSGi.clientLog = new DummyClientLog();
         var osgi:OSGi = new OSGi();
         osgi.registerService(IClientLog,new DummyClientLog());
         new ProtocolActivator().start(osgi);
         new platform.client.a3d.osgi.Activator().start(osgi);
         new platform.clients.fp10.libraries.alternativaprotocol.Activator().start(osgi);
         this.protocol = Protocol(osgi.getService(IProtocol));
         this.§_-Y8§ = true;
      }
      
      private function parseVersion1(input:ByteArray) : void
      {
         input.position = 4;
         var nullMap:OptionalMap = OptionalMapCodecHelper.decodeNullMap(input);
         nullMap.setReadPosition(0);
         var data:ByteArray = new ByteArray();
         data.writeBytes(input,input.position);
         data.position = 0;
         var buffer:ProtocolBuffer = new ProtocolBuffer(data,data,nullMap);
         var codec:ICodec = this.protocol.getCodec(new TypeCodecInfo(A3D,false));
         var _a3d:A3D = A3D(codec.decode(buffer));
         var a3d2:A3D2 = convert1_2(_a3d);
         this.doParse2_0(a3d2);
      }
      
      private function doParse2_0(a3d:A3D2) : void
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
         var parent:Long = null;
         var p:Object3D = null;
         var object:Object3D = null;
         var resJoint:Joint = null;
         var resSkin:Mesh = null;
         var resAmbientLight:AmbientLight = null;
         var resObject:Object3D = null;
         var resOmniLight:OmniLight = null;
         var resSpotLight:SpotLight = null;
         var resDirLight:DirectionalLight = null;
         var resMesh:Mesh = null;
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
         this.hierarchy = new Vector.<Object3D>();
         this.objects = new Vector.<Object3D>();
         this.maps = new Dictionary();
         this.materials = new Dictionary();
         this.§_-gk§ = new Dictionary();
         for each(a3DJoint in a3d.joints)
         {
            resJoint = new Joint();
            resJoint.visible = a3DJoint.visible;
            resJoint.name = a3DJoint.name;
            parents[resJoint] = a3DJoint.parentId;
            objectsMap[a3DJoint.id] = resJoint;
            if(a3DJoint.parentId == null)
            {
               this.hierarchy.push(resJoint);
            }
            this.objects.push(resJoint);
            this.decomposeTransformation(a3DJoint.transform,resJoint);
            a3DBox = a3DBoxes[a3DJoint.boundBoxId];
            if(a3DBox != null)
            {
               this.parseBoundBox(a3DBox.box,resJoint);
            }
         }
         for each(a3DSkin in a3d.skins)
         {
            resSkin = this.parseSkin(a3DSkin,a3DIndexBuffers,a3DVertexBuffers,a3DMaterials,a3DMaps,a3DImages);
            resSkin.visible = a3DSkin.visible;
            resSkin.name = a3DSkin.name;
            parents[resSkin] = a3DSkin.parentId;
            objectsMap[a3DSkin.id] = resSkin;
            if(a3DSkin.parentId == null)
            {
               this.hierarchy.push(resSkin);
            }
            this.objects.push(resSkin);
            this.decomposeTransformation(a3DSkin.transform,resSkin);
            a3DBox = a3DBoxes[a3DSkin.boundBoxId];
            if(a3DBox != null)
            {
               this.parseBoundBox(a3DBox.box,resSkin);
            }
         }
         for each(a3DAmbientLight in a3d.ambientLights)
         {
            resAmbientLight = new AmbientLight(a3DAmbientLight.color);
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
            this.decomposeTransformation(a3DAmbientLight.transform,resAmbientLight);
            a3DBox = a3DBoxes[a3DAmbientLight.boundBoxId];
            if(a3DBox != null)
            {
               this.parseBoundBox(a3DBox.box,resAmbientLight);
            }
         }
         for each(a3DObject in a3d.objects)
         {
            resObject = new Object3D();
            resObject.visible = a3DObject.visible;
            resObject.name = a3DObject.name;
            parents[resObject] = a3DObject.parentId;
            objectsMap[a3DObject.id] = resObject;
            if(a3DObject.parentId == null)
            {
               this.hierarchy.push(resObject);
            }
            this.objects.push(resObject);
            this.decomposeTransformation(a3DObject.transform,resObject);
            a3DBox = a3DBoxes[a3DObject.boundBoxId];
            if(a3DBox != null)
            {
               this.parseBoundBox(a3DBox.box,resObject);
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
            this.decomposeTransformation(a3DOmniLight.transform,resOmniLight);
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
            this.decomposeTransformation(a3DSpotLight.transform,resSpotLight);
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
            this.decomposeTransformation(a3DDirLight.transform,resDirLight);
         }
         for each(a3DMesh in a3d.meshes)
         {
            resMesh = this.parseMesh(a3DMesh,a3DIndexBuffers,a3DVertexBuffers,a3DMaterials,a3DMaps,a3DImages);
            resMesh.visible = a3DMesh.visible;
            resMesh.name = a3DMesh.name;
            parents[resMesh] = a3DMesh.parentId;
            objectsMap[a3DMesh.id] = resMesh;
            if(a3DMesh.parentId == null)
            {
               this.hierarchy.push(resMesh);
            }
            this.objects.push(resMesh);
            this.decomposeTransformation(a3DMesh.transform,resMesh);
            a3DBox = a3DBoxes[a3DMesh.boundBoxId];
            if(a3DBox != null)
            {
               this.parseBoundBox(a3DBox.box,resMesh);
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
      
      private function parseSurfaceJoints(source:Vector.<Vector.<Long>>, objectsMap:Dictionary) : Vector.<Vector.<Joint>>
      {
         var vector:Vector.<Long> = null;
         var resultVector:Vector.<Joint> = null;
         var j:int = 0;
         var jcount:int = 0;
         var result:Vector.<Vector.<Joint>> = new Vector.<Vector.<Joint>>();
         for(var i:int = 0,var count:int = int(source.length); i < count; i++)
         {
            vector = source[i];
            resultVector = new Vector.<Joint>();
            for(j = 0,jcount = int(vector.length); j < jcount; j++)
            {
               resultVector[j] = objectsMap[vector[j]];
            }
            result[i] = resultVector;
         }
         return result;
      }
      
      private function parseVersionOver1(input:ByteArray) : void
      {
         input.position = 0;
         var data:ByteArray = new ByteArray();
         var buffer:ProtocolBuffer = new ProtocolBuffer(data,data,new OptionalMap());
         PacketHelper.unwrapPacket(input,buffer);
         input.position = 0;
         var versionMajor:int = int(buffer.reader.readUnsignedShort());
         var versionMinor:int = int(buffer.reader.readUnsignedShort());
         switch(versionMajor)
         {
            case 2:
               this.parseVersion2_0(buffer);
         }
      }
      
      private function parseVersion2_0(buffer:ProtocolBuffer) : void
      {
         var codec:ICodec = this.protocol.getCodec(new TypeCodecInfo(A3D2,false));
         var a3d:A3D2 = A3D2(codec.decode(buffer));
         this.doParse2_0(a3d);
      }
      
      private function parseBoundBox(box:Vector.<Number>, destination:Object3D) : void
      {
         destination.boundBox = new BoundBox();
         destination.boundBox.minX = box[0];
         destination.boundBox.minY = box[1];
         destination.boundBox.minZ = box[2];
         destination.boundBox.maxX = box[3];
         destination.boundBox.maxY = box[4];
         destination.boundBox.maxZ = box[5];
      }
      
      private function decomposeTransformation(transform:A3D2Transform, obj:Object3D) : void
      {
         if(transform == null)
         {
            return;
         }
         var matrix:A3DMatrix = transform.matrix;
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
      
      private function decomposeBindTransformation(transform:A3D2Transform, obj:Joint) : void
      {
         if(transform == null)
         {
            return;
         }
         var matrix:A3DMatrix = transform.matrix;
         var mat:Vector.<Number> = Vector.<Number>([matrix.a,matrix.b,matrix.c,matrix.d,matrix.e,matrix.f,matrix.g,matrix.h,matrix.i,matrix.j,matrix.k,matrix.l]);
         obj.alternativa3d::setBindPoseMatrix(mat);
      }
      
      private function parseMesh(a3DMesh:A3D2Mesh, indexBuffers:Dictionary, vertexBuffers:Dictionary, materials:Dictionary, maps:Dictionary, images:Dictionary) : Mesh
      {
         var s:A3D2Surface = null;
         var m:ParserMaterial = null;
         var res:Mesh = new Mesh();
         res.geometry = this.parseGeometry(a3DMesh.indexBufferId,a3DMesh.vertexBuffers,indexBuffers,vertexBuffers);
         var surfaces:Vector.<A3D2Surface> = a3DMesh.surfaces;
         for(var i:int = 0; i < surfaces.length; i++)
         {
            s = surfaces[i];
            m = this.parseMaterial(materials[s.materialId],maps,images);
            res.addSurface(m,s.indexBegin,s.numTriangles);
         }
         return res;
      }
      
      private function parseSkin(a3DSkin:A3D2Skin, indexBuffers:Dictionary, vertexBuffers:Dictionary, materials:Dictionary, maps:Dictionary, images:Dictionary) : Skin
      {
         var s:A3D2Surface = null;
         var m:ParserMaterial = null;
         var res:Skin = new Skin(1,a3DSkin.joints.length);
         res.geometry = this.parseGeometry(a3DSkin.indexBufferId,a3DSkin.vertexBuffers,indexBuffers,vertexBuffers);
         var surfaces:Vector.<A3D2Surface> = a3DSkin.surfaces;
         for(var i:int = 0; i < surfaces.length; i++)
         {
            s = surfaces[i];
            m = this.parseMaterial(materials[s.materialId],maps,images);
            res.addSurface(m,s.indexBegin,s.numTriangles);
         }
         return res;
      }
      
      private function traceGeometry(geometry:Geometry) : void
      {
         var offset:int = 0;
         var i:int = 0;
         var attr:int = 0;
         var vertexStream:VertexStream = geometry.alternativa3d::_vertexStreams[0];
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
                     case VertexAttributes.JOINTS[0]:
                        data.position = j * stride + offset;
                        trace("JOINT0:",data.readFloat(),data.readFloat(),data.readFloat(),data.readFloat());
                        break;
                     case VertexAttributes.JOINTS[1]:
                        data.position = j * stride + offset;
                        trace("JOINT1:",data.readFloat(),data.readFloat(),data.readFloat(),data.readFloat());
                  }
                  prev = attr;
               }
            }
         }
      }
      
      private function parseGeometry(indexBufferID:int, vertexBuffersIDs:Vector.<int>, indexBuffers:Dictionary, vertexBuffers:Dictionary) : Geometry
      {
         var id:int = 0;
         var geometry:Geometry = null;
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
         geometry = this.§_-gk§[key];
         if(geometry != null)
         {
            return geometry;
         }
         geometry = new Geometry();
         var a3dIB:A3D2IndexBuffer = indexBuffers[indexBufferID];
         var indices:Vector.<uint> = A3DUtils.byteArrayToVectorUint(a3dIB.byteBuffer);
         var uvoffset:int = 0;
         geometry.alternativa3d::_indices = indices;
         var buffers:Vector.<int> = vertexBuffersIDs;
         for(var j:int = 0; j < buffers.length; j++)
         {
            buffer = vertexBuffers[buffers[j]];
            vertexCount = buffer.vertexCount;
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
                     attr = int(VertexAttributes.POSITION);
                     break;
                  case A3D2VertexAttributes.NORMAL:
                     attr = int(VertexAttributes.NORMAL);
                     break;
                  case A3D2VertexAttributes.TANGENT4:
                     attr = int(VertexAttributes.TANGENT4);
                     break;
                  case A3D2VertexAttributes.TEXCOORD:
                     attr = int(VertexAttributes.TEXCOORDS[uvoffset]);
                     uvoffset++;
                     break;
                  case A3D2VertexAttributes.JOINT:
                     attr = int(VertexAttributes.JOINTS[jointsOffset]);
                     jointsOffset++;
               }
               numFloats = VertexAttributes.getAttributeStride(attr);
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
         this.§_-gk§[key] = geometry;
         return geometry;
      }
      
      private function parseMap(source:A3D2Map, images:Dictionary) : ExternalTextureResource
      {
         if(source == null)
         {
            return null;
         }
         var res:ExternalTextureResource = this.maps[source.imageId];
         if(res != null)
         {
            return res;
         }
         return this.maps[source.imageId] = new ExternalTextureResource(images[source.imageId].url);
      }
      
      private function parseMaterial(source:A3D2Material, a3DMaps:Dictionary, images:Dictionary) : ParserMaterial
      {
         if(source == null)
         {
            return null;
         }
         var res:ParserMaterial = this.materials[source.id];
         if(res != null)
         {
            return res;
         }
         res = this.materials[source.id] = new ParserMaterial();
         res.textures["diffuse"] = this.parseMap(a3DMaps[source.diffuseMapId],images);
         res.textures["emission"] = this.parseMap(a3DMaps[source.lightMapId],images);
         res.textures["bump"] = this.parseMap(a3DMaps[source.normalMapId],images);
         res.textures["specular"] = this.parseMap(a3DMaps[source.specularMapId],images);
         res.textures["glossiness"] = this.parseMap(a3DMaps[source.glossinessMapId],images);
         res.textures["transparent"] = this.parseMap(a3DMaps[source.opacityMapId],images);
         return res;
      }
   }
}

import alternativa.osgi.service.clientlog.IClientLog;
import alternativa.osgi.service.clientlog.IClientLogChannelListener;

class DummyClientLog implements IClientLog
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
   
   public function addLogListener(listener:IClientLogChannelListener) : void
   {
   }
   
   public function removeLogListener(listener:IClientLogChannelListener) : void
   {
   }
   
   public function addLogChannelListener(channelName:String, listener:IClientLogChannelListener) : void
   {
   }
   
   public function removeLogChannelListener(channelName:String, listener:IClientLogChannelListener) : void
   {
   }
   
   public function getChannelNames() : Vector.<String>
   {
      return null;
   }
}
