package alternativa.tanks.game.entities.map
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.loaders.ParserA3D;
   import alternativa.engine3d.loaders.ParserCollada;
   import alternativa.engine3d.loaders.ParserMaterial;
   import alternativa.engine3d.materials.EnvironmentMaterial;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Surface;
   import alternativa.engine3d.resources.ATFTextureResource;
   import alternativa.engine3d.resources.BitmapCubeTextureResource;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.ExternalTextureResource;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.engine3d.materials.StandardMaterial;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.utils.PhysicsParsingUtils;
   import alternativa.tanks.game.utils.TaskSequence;
   import alternativa.utils.ByteArrayMap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   use namespace alternativa3d;
   
   public class A3DMapBuilder extends EventDispatcher
   {
      public static const MAIN_FILE:String = "main.a3d";
      
      public static const ADDITIONAL_FILES_START:String = "part";
      
      public static const TREES_FILE:String = "trees.a3d";
      
      public static const MARKET_FILE:String = "market.a3d";
      
      public static const PHYSICS_FILE:String = "physics.a3d";
      
      public static const BEAMS_FILE:String = "beams.a3d";
      
      public static const LIGHTS_FILE:String = "lights.dae";
      
      private static const COLLISION_MASK:int = 255;
      
      private static var fakeEmissionTextureResource:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1,1,false,8355711));
      
      private static var fakeBumpTextureResource:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1,1,false,8355839));
      
      private var name_Kq:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var name_73:Vector.<CollisionPrimitive>;
      
      private var name_9k:Vector.<Light3D>;
      
      private var name_Gv:Vector.<Decal> = new Vector.<Decal>();
      
      private var name_ah:TaskSequence;
      
      private var mapFiles:ByteArrayMap;
      
      private var collector:Vector.<Object3D>;
      
      private var name_TE:BitmapCubeTextureResource = new BitmapCubeTextureResource(new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680));
      
      public function A3DMapBuilder()
      {
         super();
      }
      
      public function get objects() : Vector.<Object3D>
      {
         return this.name_Kq;
      }
      
      public function get collisionPrimitives() : Vector.<CollisionPrimitive>
      {
         return this.name_73;
      }
      
      public function get lights() : Vector.<Light3D>
      {
         return this.name_9k;
      }
      
      public function get decals() : Vector.<Decal>
      {
         return this.name_Gv;
      }
      
      public function buildMap(mapFiles:ByteArrayMap) : void
      {
         var geometryFileName:String = null;
         this.mapFiles = mapFiles;
         var mapGeometryFiles:Vector.<String> = this.getMapGeometryFiles(mapFiles);
         this.collector = new Vector.<Object3D>();
         this.name_ah = new TaskSequence();
         for each(geometryFileName in mapGeometryFiles)
         {
            this.name_ah.addTask(new GeometryBuildTask(mapFiles.getValue(geometryFileName),this.collector));
         }
         this.name_ah.addEventListener(Event.COMPLETE,this.onGeometryComplete);
         this.name_ah.run();
      }
      
      private function onGeometryComplete(event:Event) : void
      {
         var surface:Surface = null;
         var object:Object3D = null;
         var mesh:Mesh = null;
         var meshName:String = null;
         var decal:Decal = null;
         var resourceCache:Object = {};
         for each(object in this.collector)
         {
            mesh = object as Mesh;
            if(mesh != null)
            {
               meshName = mesh.name.toLowerCase();
               if(meshName.indexOf("decal") >= 0)
               {
                  decal = new Decal(); //XXX: in 8.16 it accepts an offset argument, it was set to 1.5 here before
                  decal.name = meshName;
                  decal.useShadow = true;
                  decal.geometry = mesh.geometry;
                  decal._surfaces = mesh._surfaces;
                  decal._surfacesLength = mesh._surfacesLength;
                  for each(surface in decal._surfaces)
                  {
                     surface.alternativa3d::object = decal;
                  }
                  decal.boundBox = mesh.boundBox;
                  decal.matrix = mesh.matrix;
                  mesh = decal;
                  this.name_Gv.push(decal);
               }
               mesh.calculateBoundBox();
               this.setupMaterials(mesh,resourceCache);
               this.name_Kq.push(mesh);
            }
         }
         this.collector = null;
         this.name_ah = null;
         this.parseTrees(this.mapFiles.getValue(TREES_FILE));
         this.parseReflections(this.mapFiles.getValue(MARKET_FILE));
         this.parseBeams(this.mapFiles.getValue(BEAMS_FILE));
         this.parseLights(this.mapFiles.getValue(LIGHTS_FILE));
         this.parseCollisionGeometry(this.mapFiles.getValue(PHYSICS_FILE));
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function parseReflections(data:ByteArray) : void
      {
         var parser:ParserA3D = null;
         var resourceCache:Object = null;
         var object:Object3D = null;
         var mesh:Mesh = null;
         var i:int = 0;
         var surface:Surface = null;
         var material:ParserMaterial = null;
         var diffName:String = null;
         var diffuse:TextureResource = null;
         var bump:TextureResource = null;
         var opacity:TextureResource = null;
         var emission:TextureResource = null;
         var reflection:TextureResource = null;
         var envMaterial:EnvironmentMaterial = null;
         if(data != null)
         {
            parser = new ParserA3D();
            parser.parse(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as Mesh;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.numSurfaces; )
                  {
                     surface = mesh.getSurface(i);
                     if(surface.material != null)
                     {
                        material = ParserMaterial(surface.material);
                        diffName = ExternalTextureResource(material.textures["diffuse"]).url;
                        diffuse = this.getCompressedTextureResource(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.getCompressedTextureResource(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.getCompressedTextureResource(material.textures["transparent"],resourceCache,this.mapFiles);
                        emission = this.getCompressedTextureResource(material.textures["emission"],resourceCache,this.mapFiles);
                        if(diffName.indexOf("vetrino01") >= 0)
                        {
                           reflection = this.getCompressedTextureResource(new ExternalTextureResource("vetrino_rfl.atf"),resourceCache,this.mapFiles);
                           envMaterial = new EnvironmentMaterial(diffuse,this.name_TE,null,reflection,emission,opacity);
                           envMaterial.reflection = 0.4;
                           surface.material = envMaterial;
                        }
                        else
                        {
                           var mapMaterial:StandardMaterial = new StandardMaterial(diffuse, null, null, null, opacity);
                           mapMaterial.lightMap = emission;
                           mapMaterial.lightMapChannel = 1;
                           surface.material = mapMaterial;
                        }
                     }
                     i++;
                  }
                  this.name_Kq.push(mesh);
               }
            }
         }
      }
      
      private function setupMaterials(mesh:Mesh, resourceCache:Object) : void
      {
         var surface:Surface = null;
         var parserMaterial:ParserMaterial = null;
         var diffuseTextureResource:TextureResource = null;
         var emissionTextureResource:TextureResource = null;
         var opacityTextureResource:TextureResource = null;
         var material:StandardMaterial = null;
         for each(surface in mesh._surfaces)
         {
            parserMaterial = surface.material as ParserMaterial;
            if(parserMaterial != null)
            {
               diffuseTextureResource = this.getCompressedTextureResource(parserMaterial.textures["diffuse"],resourceCache,this.mapFiles);
               emissionTextureResource = this.getCompressedTextureResource(parserMaterial.textures["emission"],resourceCache,this.mapFiles);
               opacityTextureResource = this.getCompressedTextureResource(parserMaterial.textures["transparent"],resourceCache,this.mapFiles);
               material = new StandardMaterial(diffuseTextureResource, null, null, null, opacityTextureResource);
               if(emissionTextureResource == null)
               {
                  material.lightMap = fakeBumpTextureResource;
                  material.lightMapChannel = 0;
               }
               else
               {
                  material.lightMap = fakeBumpTextureResource;
                  material.lightMapChannel = 1;
               }
               surface.material = material;
            }
         }
      }
      
      private function getMapGeometryFiles(mapFiles:ByteArrayMap) : Vector.<String>
      {
         var name:String = null;
         var names:Vector.<String> = new Vector.<String>();
         names.push(MAIN_FILE);
         for(name in mapFiles.data)
         {
            if(name.indexOf(ADDITIONAL_FILES_START) == 0 && name.indexOf(".a3d") > 0)
            {
               names.push(name);
            }
         }
         return names;
      }
      
      private function parseTrees(data:ByteArray) : void
      {
         var parser:ParserA3D = null;
         var resourceCache:Object = null;
         var object:Object3D = null;
         var mesh:Mesh = null;
         var i:int = 0;
         var surface:Surface = null;
         var material:ParserMaterial = null;
         var diffuse:TextureResource = null;
         var bump:TextureResource = null;
         var opacity:TextureResource = null;
         var trMaterial:StandardMaterial = null;
         if(data != null)
         {
            parser = new ParserA3D();
            parser.parse(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as Mesh;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.numSurfaces; )
                  {
                     surface = mesh.getSurface(i);
                     if(surface.material != null)
                     {
                        material = ParserMaterial(surface.material);
                        diffuse = this.getCompressedTextureResource(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.getCompressedTextureResource(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.getCompressedTextureResource(material.textures["transparent"],resourceCache,this.mapFiles);
                        trMaterial = new StandardMaterial(diffuse,fakeBumpTextureResource,null,null,opacity);
                        trMaterial.specularPower = 0;
                        trMaterial.alphaThreshold = 0.2;
                        surface.material = trMaterial;
                     }
                     i++;
                  }
                  this.name_Kq.push(mesh);
               }
            }
         }
      }
      
      private function parseBeams(data:ByteArray) : void
      {
         var object:Object3D = null;
         var mesh:Mesh = null;
         var i:int = 0;
         var surface:Surface = null;
         var material:ParserMaterial = null;
         var diffuse:TextureResource = null;
         var opacity:TextureResource = null;
         if(data == null)
         {
            return;
         }
         var parser:ParserA3D = new ParserA3D();
         parser.parse(data);
         var resourceCache:Object = {};
         for each(object in parser.objects)
         {
            mesh = object as Mesh;
            if(mesh != null)
            {
               for(i = 0; i < mesh.numSurfaces; )
               {
                  surface = mesh.getSurface(i);
                  if(surface.material != null)
                  {
                     material = ParserMaterial(surface.material);
                     diffuse = this.getCompressedTextureResource(material.textures["diffuse"],resourceCache,this.mapFiles);
                     opacity = this.getCompressedTextureResource(material.textures["transparent"],resourceCache,this.mapFiles);
                     surface.material = new VisibleLightMaterial(opacity);
                  }
                  i++;
               }
               this.name_Kq.push(mesh);
            }
         }
      }
      
      private function parseLights(lightsData:ByteArray) : void
      {
         var parserCollada:ParserCollada = null;
         var numLights:uint = 0;
         var i:int = 0;
         if(lightsData != null)
         {
            parserCollada = new ParserCollada();
            parserCollada.parse(XML(lightsData.toString()));
            numLights = uint(parserCollada.lights.length);
            this.name_9k = new Vector.<Light3D>(numLights);
            for(i = 0; i < numLights; i++)
            {
               this.name_9k[i] = parserCollada.lights[i];
               Light3D(this.name_9k[i]).alternativa3d::removeFromParent();
            }
         }
      }
      
      private function getCompressedTextureResource(fileTextureResource:ExternalTextureResource, resourceCache:Object, mapFiles:ByteArrayMap) : ATFTextureResource
      {
         var textureName:String = null;
         var resource:ATFTextureResource = null;
         var textureData:ByteArray = null;
         if(fileTextureResource != null && Boolean(fileTextureResource.url))
         {
            textureName = fileTextureResource.url.toLowerCase();
            textureName = textureName.replace(".png",".atf");
            textureName = textureName.replace(".jpg",".atf");
            if(mapFiles.getValue(textureName) != null)
            {
               resource = resourceCache[textureName];
               if(resource == null)
               {
                  textureData = mapFiles.getValue(textureName);
                  resource = new ATFTextureResource(textureData);
                  resourceCache[textureName] = resource;
               }
               return resource;
            }
            trace("[WARN] texture not found:",fileTextureResource.url.toLowerCase());
         }
         return null;
      }
      
      private function parseCollisionGeometry(a3dData:ByteArray) : void
      {
         var object:Object3D = null;
         var objectName:String = null;
         var parserA3D:ParserA3D = new ParserA3D();
         parserA3D.parse(a3dData);
         this.name_73 = new Vector.<CollisionPrimitive>();
         for each(object in parserA3D.objects)
         {
            if(object is Mesh)
            {
               objectName = object.name.toLowerCase();
               if(objectName.indexOf("tri") == 0)
               {
                  PhysicsParsingUtils.parseCollisionTriangles(Mesh(object),this.name_73,CollisionGroup.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("box") == 0)
               {
                  PhysicsParsingUtils.parseBox(Mesh(object),this.name_73,CollisionGroup.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("plane") == 0)
               {
                  PhysicsParsingUtils.parsePlane(Mesh(object),this.name_73,CollisionGroup.STATIC,COLLISION_MASK);
               }
            }
         }
      }
   }
}

import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.loaders.ParserA3D;
import alternativa.tanks.game.utils.Task;
import flash.utils.ByteArray;
import flash.utils.setTimeout;

class GeometryBuildTask extends Task
{
   private var data:ByteArray;
   
   private var collector:Vector.<Object3D>;
   
   public function GeometryBuildTask(data:ByteArray, collector:Vector.<Object3D>)
   {
      super();
      this.data = data;
      this.collector = collector;
   }
   
   override public function run() : void
   {
      var object:Object3D = null;
      var parser:ParserA3D = new ParserA3D();
      parser.parse(this.data);
      for each(object in parser.objects)
      {
         this.collector.push(object);
      }
      setTimeout(completeTask,0);
   }
}
