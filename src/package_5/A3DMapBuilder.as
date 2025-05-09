package package_5
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import package_1.name_13;
   import package_12.name_54;
   import package_19.class_16;
   import package_19.name_134;
   import package_19.name_472;
   import package_21.name_152;
   import package_21.name_172;
   import package_21.name_84;
   import package_21.name_85;
   import package_21.name_86;
   import package_29.name_473;
   import package_29.name_90;
   import package_3.name_475;
   import package_33.name_121;
   import package_33.name_130;
   import package_51.name_276;
   import package_54.name_170;
   import package_83.name_470;
   import package_83.name_471;
   import package_83.name_474;
   
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
      
      private static var fakeEmissionTextureResource:name_84 = new name_84(new BitmapData(1,1,false,8355711));
      
      private static var fakeBumpTextureResource:name_84 = new name_84(new BitmapData(1,1,false,8355839));
      
      private var var_348:Vector.<name_130> = new Vector.<name_130>();
      
      private var var_569:Vector.<name_276>;
      
      private var var_16:Vector.<name_121>;
      
      private var var_398:Vector.<name_472> = new Vector.<name_472>();
      
      private var var_570:name_90;
      
      private var mapFiles:name_54;
      
      private var collector:Vector.<name_130>;
      
      private var var_571:name_172 = new name_172(new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680));
      
      public function A3DMapBuilder()
      {
         super();
      }
      
      public function get objects() : Vector.<name_130>
      {
         return this.var_348;
      }
      
      public function get collisionPrimitives() : Vector.<name_276>
      {
         return this.var_569;
      }
      
      public function get lights() : Vector.<name_121>
      {
         return this.var_16;
      }
      
      public function get decals() : Vector.<name_472>
      {
         return this.var_398;
      }
      
      public function method_234(mapFiles:name_54) : void
      {
         var geometryFileName:String = null;
         this.mapFiles = mapFiles;
         var mapGeometryFiles:Vector.<String> = this.method_231(mapFiles);
         this.collector = new Vector.<name_130>();
         this.var_570 = new name_90();
         for each(geometryFileName in mapGeometryFiles)
         {
            this.var_570.addTask(new GeometryBuildTask(mapFiles.name_160(geometryFileName),this.collector));
         }
         this.var_570.addEventListener(Event.COMPLETE,this.method_227);
         this.var_570.run();
      }
      
      private function method_227(event:Event) : void
      {
         var surface:name_134 = null;
         var object:name_130 = null;
         var mesh:class_16 = null;
         var meshName:String = null;
         var decal:name_472 = null;
         var resourceCache:Object = {};
         for each(object in this.collector)
         {
            mesh = object as class_16;
            if(mesh != null)
            {
               meshName = mesh.name.toLowerCase();
               if(meshName.indexOf("decal") >= 0)
               {
                  decal = new name_472(1.5);
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
                  this.var_398.push(decal);
               }
               mesh.calculateBoundBox();
               this.method_229(mesh,resourceCache);
               this.var_348.push(mesh);
            }
         }
         this.collector = null;
         this.var_570 = null;
         this.method_230(this.mapFiles.name_160(TREES_FILE));
         this.method_233(this.mapFiles.name_160(MARKET_FILE));
         this.method_232(this.mapFiles.name_160(BEAMS_FILE));
         this.method_226(this.mapFiles.name_160(LIGHTS_FILE));
         this.method_228(this.mapFiles.name_160(PHYSICS_FILE));
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function method_233(data:ByteArray) : void
      {
         var parser:name_470 = null;
         var resourceCache:Object = null;
         var object:name_130 = null;
         var mesh:class_16 = null;
         var i:int = 0;
         var surface:name_134 = null;
         var material:name_471 = null;
         var diffName:String = null;
         var diffuse:name_86 = null;
         var bump:name_86 = null;
         var opacity:name_86 = null;
         var emission:name_86 = null;
         var reflection:name_86 = null;
         var envMaterial:name_475 = null;
         if(data != null)
         {
            parser = new name_470();
            parser.method_132(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as class_16;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.name_477; )
                  {
                     surface = mesh.name_476(i);
                     if(surface.material != null)
                     {
                        material = name_471(surface.material);
                        diffName = name_85(material.textures["diffuse"]).url;
                        diffuse = this.name_167(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.name_167(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.name_167(material.textures["transparent"],resourceCache,this.mapFiles);
                        emission = this.name_167(material.textures["emission"],resourceCache,this.mapFiles);
                        if(diffName.indexOf("vetrino01") >= 0)
                        {
                           reflection = this.name_167(new name_85("vetrino_rfl.atf"),resourceCache,this.mapFiles);
                           envMaterial = new name_475(diffuse,this.var_571,null,reflection,emission,opacity);
                           envMaterial.reflection = 0.4;
                           surface.material = envMaterial;
                        }
                        else
                        {
                           surface.material = new name_11(diffuse,emission,1,opacity);
                        }
                     }
                     i++;
                  }
                  this.var_348.push(mesh);
               }
            }
         }
      }
      
      private function method_229(mesh:class_16, resourceCache:Object) : void
      {
         var surface:name_134 = null;
         var parserMaterial:name_471 = null;
         var diffuseTextureResource:name_86 = null;
         var emissionTextureResource:name_86 = null;
         var opacityTextureResource:name_86 = null;
         var material:name_11 = null;
         for each(surface in mesh.alternativa3d::var_92)
         {
            parserMaterial = surface.material as name_471;
            if(parserMaterial != null)
            {
               diffuseTextureResource = this.name_167(parserMaterial.textures["diffuse"],resourceCache,this.mapFiles);
               emissionTextureResource = this.name_167(parserMaterial.textures["emission"],resourceCache,this.mapFiles);
               opacityTextureResource = this.name_167(parserMaterial.textures["transparent"],resourceCache,this.mapFiles);
               if(emissionTextureResource == null)
               {
                  material = new name_11(diffuseTextureResource,fakeEmissionTextureResource,0,opacityTextureResource);
               }
               else
               {
                  material = new name_11(diffuseTextureResource,emissionTextureResource,1,opacityTextureResource);
               }
               surface.material = material;
            }
         }
      }
      
      private function method_231(mapFiles:name_54) : Vector.<String>
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
      
      private function method_230(data:ByteArray) : void
      {
         var parser:name_470 = null;
         var resourceCache:Object = null;
         var object:name_130 = null;
         var mesh:class_16 = null;
         var i:int = 0;
         var surface:name_134 = null;
         var material:name_471 = null;
         var diffuse:name_86 = null;
         var bump:name_86 = null;
         var opacity:name_86 = null;
         var trMaterial:name_13 = null;
         if(data != null)
         {
            parser = new name_470();
            parser.method_132(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as class_16;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.name_477; )
                  {
                     surface = mesh.name_476(i);
                     if(surface.material != null)
                     {
                        material = name_471(surface.material);
                        diffuse = this.name_167(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.name_167(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.name_167(material.textures["transparent"],resourceCache,this.mapFiles);
                        trMaterial = new name_13(diffuse,fakeBumpTextureResource,null,null,opacity);
                        trMaterial.var_26 = 0;
                        trMaterial.alphaThreshold = 0.2;
                        surface.material = trMaterial;
                     }
                     i++;
                  }
                  this.var_348.push(mesh);
               }
            }
         }
      }
      
      private function method_232(data:ByteArray) : void
      {
         var object:name_130 = null;
         var mesh:class_16 = null;
         var i:int = 0;
         var surface:name_134 = null;
         var material:name_471 = null;
         var diffuse:name_86 = null;
         var opacity:name_86 = null;
         if(data == null)
         {
            return;
         }
         var parser:name_470 = new name_470();
         parser.method_132(data);
         var resourceCache:Object = {};
         for each(object in parser.objects)
         {
            mesh = object as class_16;
            if(mesh != null)
            {
               for(i = 0; i < mesh.name_477; )
               {
                  surface = mesh.name_476(i);
                  if(surface.material != null)
                  {
                     material = name_471(surface.material);
                     diffuse = this.name_167(material.textures["diffuse"],resourceCache,this.mapFiles);
                     opacity = this.name_167(material.textures["transparent"],resourceCache,this.mapFiles);
                     surface.material = new name_2(opacity);
                  }
                  i++;
               }
               this.var_348.push(mesh);
            }
         }
      }
      
      private function method_226(lightsData:ByteArray) : void
      {
         var parserCollada:name_474 = null;
         var numLights:uint = 0;
         var i:int = 0;
         if(lightsData != null)
         {
            parserCollada = new name_474();
            parserCollada.method_132(XML(lightsData.toString()));
            numLights = uint(parserCollada.lights.length);
            this.var_16 = new Vector.<name_121>(numLights);
            for(i = 0; i < numLights; i++)
            {
               this.var_16[i] = parserCollada.lights[i];
               name_121(this.var_16[i]).alternativa3d::removeFromParent();
            }
         }
      }
      
      private function name_167(fileTextureResource:name_85, resourceCache:Object, mapFiles:name_54) : name_152
      {
         var textureName:String = null;
         var resource:name_152 = null;
         var textureData:ByteArray = null;
         if(fileTextureResource != null && Boolean(fileTextureResource.url))
         {
            textureName = fileTextureResource.url.toLowerCase();
            textureName = textureName.replace(".png",".atf");
            textureName = textureName.replace(".jpg",".atf");
            if(mapFiles.name_160(textureName) != null)
            {
               resource = resourceCache[textureName];
               if(resource == null)
               {
                  textureData = mapFiles.name_160(textureName);
                  resource = new name_152(textureData);
                  resourceCache[textureName] = resource;
               }
               return resource;
            }
            trace("[WARN] texture not found:",fileTextureResource.url.toLowerCase());
         }
         return null;
      }
      
      private function method_228(a3dData:ByteArray) : void
      {
         var object:name_130 = null;
         var objectName:String = null;
         var parserA3D:name_470 = new name_470();
         parserA3D.method_132(a3dData);
         this.var_569 = new Vector.<name_276>();
         for each(object in parserA3D.objects)
         {
            if(object is class_16)
            {
               objectName = object.name.toLowerCase();
               if(objectName.indexOf("tri") == 0)
               {
                  name_473.name_478(class_16(object),this.var_569,name_170.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("box") == 0)
               {
                  name_473.name_480(class_16(object),this.var_569,name_170.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("plane") == 0)
               {
                  name_473.name_479(class_16(object),this.var_569,name_170.STATIC,COLLISION_MASK);
               }
            }
         }
      }
   }
}

import flash.utils.ByteArray;
import flash.utils.setTimeout;
import package_29.class_3;
import package_33.name_130;
import package_83.name_470;

class GeometryBuildTask extends class_3
{
   private var data:ByteArray;
   
   private var collector:Vector.<name_130>;
   
   public function GeometryBuildTask(data:ByteArray, collector:Vector.<name_130>)
   {
      super();
      this.data = data;
      this.collector = collector;
   }
   
   override public function run() : void
   {
      var object:name_130 = null;
      var parser:name_470 = new name_470();
      parser.method_132(this.data);
      for each(object in parser.objects)
      {
         this.collector.push(object);
      }
      setTimeout(name_88,0);
   }
}
