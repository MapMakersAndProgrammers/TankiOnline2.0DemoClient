package alternativa.tanks.game.entities.map
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import package_116.name_529;
   import package_116.name_530;
   import package_116.name_641;
   import package_15.name_55;
   import package_19.name_117;
   import package_19.name_380;
   import package_19.name_91;
   import package_21.name_116;
   import package_21.name_78;
   import package_27.name_170;
   import package_27.name_642;
   import package_28.name_129;
   import package_28.name_167;
   import package_28.name_241;
   import package_28.name_259;
   import package_28.name_93;
   import package_3.name_10;
   import package_4.name_643;
   import package_76.name_235;
   import package_86.name_257;
   
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
      
      private static var fakeEmissionTextureResource:name_93 = new name_93(new BitmapData(1,1,false,8355711));
      
      private static var fakeBumpTextureResource:name_93 = new name_93(new BitmapData(1,1,false,8355839));
      
      private var var_346:Vector.<name_78> = new Vector.<name_78>();
      
      private var var_569:Vector.<name_235>;
      
      private var var_16:Vector.<name_116>;
      
      private var var_406:Vector.<name_91> = new Vector.<name_91>();
      
      private var var_570:name_170;
      
      private var mapFiles:name_55;
      
      private var collector:Vector.<name_78>;
      
      private var var_571:name_259 = new name_259(new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680));
      
      public function A3DMapBuilder()
      {
         super();
      }
      
      public function get objects() : Vector.<name_78>
      {
         return this.var_346;
      }
      
      public function get collisionPrimitives() : Vector.<name_235>
      {
         return this.var_569;
      }
      
      public function get lights() : Vector.<name_116>
      {
         return this.var_16;
      }
      
      public function get decals() : Vector.<name_91>
      {
         return this.var_406;
      }
      
      public function name_385(mapFiles:name_55) : void
      {
         var geometryFileName:String = null;
         this.mapFiles = mapFiles;
         var mapGeometryFiles:Vector.<String> = this.getMapGeometryFiles(mapFiles);
         this.collector = new Vector.<name_78>();
         this.var_570 = new name_170();
         for each(geometryFileName in mapGeometryFiles)
         {
            this.var_570.addTask(new GeometryBuildTask(mapFiles.name_248(geometryFileName),this.collector));
         }
         this.var_570.addEventListener(Event.COMPLETE,this.onGeometryComplete);
         this.var_570.run();
      }
      
      private function onGeometryComplete(event:Event) : void
      {
         var surface:name_117 = null;
         var object:name_78 = null;
         var mesh:name_380 = null;
         var meshName:String = null;
         var decal:name_91 = null;
         var resourceCache:Object = {};
         for each(object in this.collector)
         {
            mesh = object as name_380;
            if(mesh != null)
            {
               meshName = mesh.name.toLowerCase();
               if(meshName.indexOf("decal") >= 0)
               {
                  decal = new name_91(1.5);
                  decal.name = meshName;
                  decal.useShadow = true;
                  decal.geometry = mesh.geometry;
                  decal.alternativa3d::var_92 = mesh.alternativa3d::var_92;
                  decal.alternativa3d::var_93 = mesh.alternativa3d::var_93;
                  for each(surface in decal.alternativa3d::var_92)
                  {
                     surface.alternativa3d::object = decal;
                  }
                  decal.boundBox = mesh.boundBox;
                  decal.matrix = mesh.matrix;
                  mesh = decal;
                  this.var_406.push(decal);
               }
               mesh.calculateBoundBox();
               this.setupMaterials(mesh,resourceCache);
               this.var_346.push(mesh);
            }
         }
         this.collector = null;
         this.var_570 = null;
         this.parseTrees(this.mapFiles.name_248(TREES_FILE));
         this.parseReflections(this.mapFiles.name_248(MARKET_FILE));
         this.parseBeams(this.mapFiles.name_248(BEAMS_FILE));
         this.parseLights(this.mapFiles.name_248(LIGHTS_FILE));
         this.parseCollisionGeometry(this.mapFiles.name_248(PHYSICS_FILE));
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function parseReflections(data:ByteArray) : void
      {
         var parser:name_529 = null;
         var resourceCache:Object = null;
         var object:name_78 = null;
         var mesh:name_380 = null;
         var i:int = 0;
         var surface:name_117 = null;
         var material:name_641 = null;
         var diffName:String = null;
         var diffuse:name_129 = null;
         var bump:name_129 = null;
         var opacity:name_129 = null;
         var emission:name_129 = null;
         var reflection:name_129 = null;
         var envMaterial:name_643 = null;
         if(data != null)
         {
            parser = new name_529();
            parser.method_314(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as name_380;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.method_217; )
                  {
                     surface = mesh.method_216(i);
                     if(surface.material != null)
                     {
                        material = name_641(surface.material);
                        diffName = name_167(material.textures["diffuse"]).url;
                        diffuse = this.getCompressedTextureResource(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.getCompressedTextureResource(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.getCompressedTextureResource(material.textures["transparent"],resourceCache,this.mapFiles);
                        emission = this.getCompressedTextureResource(material.textures["emission"],resourceCache,this.mapFiles);
                        if(diffName.indexOf("vetrino01") >= 0)
                        {
                           reflection = this.getCompressedTextureResource(new name_167("vetrino_rfl.atf"),resourceCache,this.mapFiles);
                           envMaterial = new name_643(diffuse,this.var_571,null,reflection,emission,opacity);
                           envMaterial.reflection = 0.4;
                           surface.material = envMaterial;
                        }
                        else
                        {
                           surface.material = new MapMaterial(diffuse,emission,1,opacity);
                        }
                     }
                     i++;
                  }
                  this.var_346.push(mesh);
               }
            }
         }
      }
      
      private function setupMaterials(mesh:name_380, resourceCache:Object) : void
      {
         var surface:name_117 = null;
         var parserMaterial:name_641 = null;
         var diffuseTextureResource:name_129 = null;
         var emissionTextureResource:name_129 = null;
         var opacityTextureResource:name_129 = null;
         var material:MapMaterial = null;
         for each(surface in mesh.alternativa3d::var_92)
         {
            parserMaterial = surface.material as name_641;
            if(parserMaterial != null)
            {
               diffuseTextureResource = this.getCompressedTextureResource(parserMaterial.textures["diffuse"],resourceCache,this.mapFiles);
               emissionTextureResource = this.getCompressedTextureResource(parserMaterial.textures["emission"],resourceCache,this.mapFiles);
               opacityTextureResource = this.getCompressedTextureResource(parserMaterial.textures["transparent"],resourceCache,this.mapFiles);
               if(emissionTextureResource == null)
               {
                  material = new MapMaterial(diffuseTextureResource,fakeEmissionTextureResource,0,opacityTextureResource);
               }
               else
               {
                  material = new MapMaterial(diffuseTextureResource,emissionTextureResource,1,opacityTextureResource);
               }
               surface.material = material;
            }
         }
      }
      
      private function getMapGeometryFiles(mapFiles:name_55) : Vector.<String>
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
         var parser:name_529 = null;
         var resourceCache:Object = null;
         var object:name_78 = null;
         var mesh:name_380 = null;
         var i:int = 0;
         var surface:name_117 = null;
         var material:name_641 = null;
         var diffuse:name_129 = null;
         var bump:name_129 = null;
         var opacity:name_129 = null;
         var trMaterial:name_10 = null;
         if(data != null)
         {
            parser = new name_529();
            parser.method_314(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as name_380;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.method_217; )
                  {
                     surface = mesh.method_216(i);
                     if(surface.material != null)
                     {
                        material = name_641(surface.material);
                        diffuse = this.getCompressedTextureResource(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.getCompressedTextureResource(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.getCompressedTextureResource(material.textures["transparent"],resourceCache,this.mapFiles);
                        trMaterial = new name_10(diffuse,fakeBumpTextureResource,null,null,opacity);
                        trMaterial.var_25 = 0;
                        trMaterial.alphaThreshold = 0.2;
                        surface.material = trMaterial;
                     }
                     i++;
                  }
                  this.var_346.push(mesh);
               }
            }
         }
      }
      
      private function parseBeams(data:ByteArray) : void
      {
         var object:name_78 = null;
         var mesh:name_380 = null;
         var i:int = 0;
         var surface:name_117 = null;
         var material:name_641 = null;
         var diffuse:name_129 = null;
         var opacity:name_129 = null;
         if(data == null)
         {
            return;
         }
         var parser:name_529 = new name_529();
         parser.method_314(data);
         var resourceCache:Object = {};
         for each(object in parser.objects)
         {
            mesh = object as name_380;
            if(mesh != null)
            {
               for(i = 0; i < mesh.method_217; )
               {
                  surface = mesh.method_216(i);
                  if(surface.material != null)
                  {
                     material = name_641(surface.material);
                     diffuse = this.getCompressedTextureResource(material.textures["diffuse"],resourceCache,this.mapFiles);
                     opacity = this.getCompressedTextureResource(material.textures["transparent"],resourceCache,this.mapFiles);
                     surface.material = new VisibleLightMaterial(opacity);
                  }
                  i++;
               }
               this.var_346.push(mesh);
            }
         }
      }
      
      private function parseLights(lightsData:ByteArray) : void
      {
         var parserCollada:name_530 = null;
         var numLights:uint = 0;
         var i:int = 0;
         if(lightsData != null)
         {
            parserCollada = new name_530();
            parserCollada.method_314(XML(lightsData.toString()));
            numLights = uint(parserCollada.lights.length);
            this.var_16 = new Vector.<name_116>(numLights);
            for(i = 0; i < numLights; i++)
            {
               this.var_16[i] = parserCollada.lights[i];
               name_116(this.var_16[i]).alternativa3d::removeFromParent();
            }
         }
      }
      
      private function getCompressedTextureResource(fileTextureResource:name_167, resourceCache:Object, mapFiles:name_55) : name_241
      {
         var textureName:String = null;
         var resource:name_241 = null;
         var textureData:ByteArray = null;
         if(fileTextureResource != null && Boolean(fileTextureResource.url))
         {
            textureName = fileTextureResource.url.toLowerCase();
            textureName = textureName.replace(".png",".atf");
            textureName = textureName.replace(".jpg",".atf");
            if(mapFiles.name_248(textureName) != null)
            {
               resource = resourceCache[textureName];
               if(resource == null)
               {
                  textureData = mapFiles.name_248(textureName);
                  resource = new name_241(textureData);
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
         var object:name_78 = null;
         var objectName:String = null;
         var parserA3D:name_529 = new name_529();
         parserA3D.method_314(a3dData);
         this.var_569 = new Vector.<name_235>();
         for each(object in parserA3D.objects)
         {
            if(object is name_380)
            {
               objectName = object.name.toLowerCase();
               if(objectName.indexOf("tri") == 0)
               {
                  name_642.name_644(name_380(object),this.var_569,name_257.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("box") == 0)
               {
                  name_642.name_646(name_380(object),this.var_569,name_257.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("plane") == 0)
               {
                  name_642.name_645(name_380(object),this.var_569,name_257.STATIC,COLLISION_MASK);
               }
            }
         }
      }
   }
}

import flash.utils.ByteArray;
import flash.utils.setTimeout;
import package_116.name_529;
import package_21.name_78;
import package_27.class_7;

class GeometryBuildTask extends class_7
{
   private var data:ByteArray;
   
   private var collector:Vector.<name_78>;
   
   public function GeometryBuildTask(data:ByteArray, collector:Vector.<name_78>)
   {
      super();
      this.data = data;
      this.collector = collector;
   }
   
   override public function run() : void
   {
      var object:name_78 = null;
      var parser:name_529 = new name_529();
      parser.method_314(this.data);
      for each(object in parser.objects)
      {
         this.collector.push(object);
      }
      setTimeout(method_102,0);
   }
}
