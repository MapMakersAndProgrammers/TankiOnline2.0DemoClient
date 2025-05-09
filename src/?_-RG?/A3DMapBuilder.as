package §_-RG§
{
   import §_-1e§.§_-Nh§;
   import §_-1z§.§_-KJ§;
   import §_-1z§.§_-VF§;
   import §_-1z§.§_-b1§;
   import §_-1z§.§_-n4§;
   import §_-1z§.§_-pi§;
   import §_-8D§.§_-Jo§;
   import §_-8D§.§_-OX§;
   import §_-Ex§.§_-8f§;
   import §_-Ex§.§_-U2§;
   import §_-Ex§.§_-a2§;
   import §_-O5§.§_-Hk§;
   import §_-V-§.§_-Q4§;
   import §_-V-§.§_-Ui§;
   import §_-Vh§.§_-18§;
   import §_-Yj§.§_-4X§;
   import §_-am§.§_-Fh§;
   import §_-am§.§_-Jd§;
   import §_-am§.§_-qn§;
   import §_-fT§.§_-HM§;
   import alternativa.engine3d.alternativa3d;
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
      
      private static var fakeEmissionTextureResource:§_-b1§ = new §_-b1§(new BitmapData(1,1,false,8355711));
      
      private static var fakeBumpTextureResource:§_-b1§ = new §_-b1§(new BitmapData(1,1,false,8355839));
      
      private var §_-Kq§:Vector.<§_-OX§> = new Vector.<§_-OX§>();
      
      private var §_-73§:Vector.<§_-Nh§>;
      
      private var §_-9k§:Vector.<§_-Jo§>;
      
      private var §_-Gv§:Vector.<§_-8f§> = new Vector.<§_-8f§>();
      
      private var §_-ah§:§_-Ui§;
      
      private var mapFiles:§_-Hk§;
      
      private var collector:Vector.<§_-OX§>;
      
      private var §_-TE§:§_-VF§ = new §_-VF§(new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680),new BitmapData(1,1,false,16711680));
      
      public function A3DMapBuilder()
      {
         super();
      }
      
      public function get objects() : Vector.<§_-OX§>
      {
         return this.§_-Kq§;
      }
      
      public function get collisionPrimitives() : Vector.<§_-Nh§>
      {
         return this.§_-73§;
      }
      
      public function get lights() : Vector.<§_-Jo§>
      {
         return this.§_-9k§;
      }
      
      public function get decals() : Vector.<§_-8f§>
      {
         return this.§_-Gv§;
      }
      
      public function §_-Q7§(mapFiles:§_-Hk§) : void
      {
         var geometryFileName:String = null;
         this.mapFiles = mapFiles;
         var mapGeometryFiles:Vector.<String> = this.§_-VG§(mapFiles);
         this.collector = new Vector.<§_-OX§>();
         this.§_-ah§ = new §_-Ui§();
         for each(geometryFileName in mapGeometryFiles)
         {
            this.§_-ah§.addTask(new GeometryBuildTask(mapFiles.§_-HG§(geometryFileName),this.collector));
         }
         this.§_-ah§.addEventListener(Event.COMPLETE,this.§_-OY§);
         this.§_-ah§.run();
      }
      
      private function §_-OY§(event:Event) : void
      {
         var surface:§_-a2§ = null;
         var object:§_-OX§ = null;
         var mesh:§_-U2§ = null;
         var meshName:String = null;
         var decal:§_-8f§ = null;
         var resourceCache:Object = {};
         for each(object in this.collector)
         {
            mesh = object as §_-U2§;
            if(mesh != null)
            {
               meshName = mesh.name.toLowerCase();
               if(meshName.indexOf("decal") >= 0)
               {
                  decal = new §_-8f§(1.5);
                  decal.name = meshName;
                  decal.useShadow = true;
                  decal.geometry = mesh.geometry;
                  decal.alternativa3d::_-eW = mesh.alternativa3d::_-eW;
                  decal.alternativa3d::_-Oy = mesh.alternativa3d::_-Oy;
                  for each(surface in decal.alternativa3d::_-eW)
                  {
                     surface.alternativa3d::object = decal;
                  }
                  decal.boundBox = mesh.boundBox;
                  decal.matrix = mesh.matrix;
                  mesh = decal;
                  this.§_-Gv§.push(decal);
               }
               mesh.calculateBoundBox();
               this.§_-Gj§(mesh,resourceCache);
               this.§_-Kq§.push(mesh);
            }
         }
         this.collector = null;
         this.§_-ah§ = null;
         this.§_-gU§(this.mapFiles.§_-HG§(TREES_FILE));
         this.§_-hj§(this.mapFiles.§_-HG§(MARKET_FILE));
         this.§_-1o§(this.mapFiles.§_-HG§(BEAMS_FILE));
         this.§_-F0§(this.mapFiles.§_-HG§(LIGHTS_FILE));
         this.§_-et§(this.mapFiles.§_-HG§(PHYSICS_FILE));
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function §_-hj§(data:ByteArray) : void
      {
         var parser:§_-Fh§ = null;
         var resourceCache:Object = null;
         var object:§_-OX§ = null;
         var mesh:§_-U2§ = null;
         var i:int = 0;
         var surface:§_-a2§ = null;
         var material:§_-qn§ = null;
         var diffName:String = null;
         var diffuse:§_-pi§ = null;
         var bump:§_-pi§ = null;
         var opacity:§_-pi§ = null;
         var emission:§_-pi§ = null;
         var reflection:§_-pi§ = null;
         var envMaterial:§_-18§ = null;
         if(data != null)
         {
            parser = new §_-Fh§();
            parser.§_-Om§(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as §_-U2§;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.§_-hT§; )
                  {
                     surface = mesh.§_-Hq§(i);
                     if(surface.material != null)
                     {
                        material = §_-qn§(surface.material);
                        diffName = §_-n4§(material.textures["diffuse"]).url;
                        diffuse = this.§_-kb§(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.§_-kb§(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.§_-kb§(material.textures["transparent"],resourceCache,this.mapFiles);
                        emission = this.§_-kb§(material.textures["emission"],resourceCache,this.mapFiles);
                        if(diffName.indexOf("vetrino01") >= 0)
                        {
                           reflection = this.§_-kb§(new §_-n4§("vetrino_rfl.atf"),resourceCache,this.mapFiles);
                           envMaterial = new §_-18§(diffuse,this.§_-TE§,null,reflection,emission,opacity);
                           envMaterial.reflection = 0.4;
                           surface.material = envMaterial;
                        }
                        else
                        {
                           surface.material = new §_-pE§(diffuse,emission,1,opacity);
                        }
                     }
                     i++;
                  }
                  this.§_-Kq§.push(mesh);
               }
            }
         }
      }
      
      private function §_-Gj§(mesh:§_-U2§, resourceCache:Object) : void
      {
         var surface:§_-a2§ = null;
         var parserMaterial:§_-qn§ = null;
         var diffuseTextureResource:§_-pi§ = null;
         var emissionTextureResource:§_-pi§ = null;
         var opacityTextureResource:§_-pi§ = null;
         var material:§_-pE§ = null;
         for each(surface in mesh.alternativa3d::_-eW)
         {
            parserMaterial = surface.material as §_-qn§;
            if(parserMaterial != null)
            {
               diffuseTextureResource = this.§_-kb§(parserMaterial.textures["diffuse"],resourceCache,this.mapFiles);
               emissionTextureResource = this.§_-kb§(parserMaterial.textures["emission"],resourceCache,this.mapFiles);
               opacityTextureResource = this.§_-kb§(parserMaterial.textures["transparent"],resourceCache,this.mapFiles);
               if(emissionTextureResource == null)
               {
                  material = new §_-pE§(diffuseTextureResource,fakeEmissionTextureResource,0,opacityTextureResource);
               }
               else
               {
                  material = new §_-pE§(diffuseTextureResource,emissionTextureResource,1,opacityTextureResource);
               }
               surface.material = material;
            }
         }
      }
      
      private function §_-VG§(mapFiles:§_-Hk§) : Vector.<String>
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
      
      private function §_-gU§(data:ByteArray) : void
      {
         var parser:§_-Fh§ = null;
         var resourceCache:Object = null;
         var object:§_-OX§ = null;
         var mesh:§_-U2§ = null;
         var i:int = 0;
         var surface:§_-a2§ = null;
         var material:§_-qn§ = null;
         var diffuse:§_-pi§ = null;
         var bump:§_-pi§ = null;
         var opacity:§_-pi§ = null;
         var trMaterial:§_-4X§ = null;
         if(data != null)
         {
            parser = new §_-Fh§();
            parser.§_-Om§(data);
            resourceCache = {};
            for each(object in parser.objects)
            {
               mesh = object as §_-U2§;
               if(mesh != null)
               {
                  for(i = 0; i < mesh.§_-hT§; )
                  {
                     surface = mesh.§_-Hq§(i);
                     if(surface.material != null)
                     {
                        material = §_-qn§(surface.material);
                        diffuse = this.§_-kb§(material.textures["diffuse"],resourceCache,this.mapFiles);
                        bump = this.§_-kb§(material.textures["bump"],resourceCache,this.mapFiles);
                        opacity = this.§_-kb§(material.textures["transparent"],resourceCache,this.mapFiles);
                        trMaterial = new §_-4X§(diffuse,fakeBumpTextureResource,null,null,opacity);
                        trMaterial.§_-kj§ = 0;
                        trMaterial.alphaThreshold = 0.2;
                        surface.material = trMaterial;
                     }
                     i++;
                  }
                  this.§_-Kq§.push(mesh);
               }
            }
         }
      }
      
      private function §_-1o§(data:ByteArray) : void
      {
         var object:§_-OX§ = null;
         var mesh:§_-U2§ = null;
         var i:int = 0;
         var surface:§_-a2§ = null;
         var material:§_-qn§ = null;
         var diffuse:§_-pi§ = null;
         var opacity:§_-pi§ = null;
         if(data == null)
         {
            return;
         }
         var parser:§_-Fh§ = new §_-Fh§();
         parser.§_-Om§(data);
         var resourceCache:Object = {};
         for each(object in parser.objects)
         {
            mesh = object as §_-U2§;
            if(mesh != null)
            {
               for(i = 0; i < mesh.§_-hT§; )
               {
                  surface = mesh.§_-Hq§(i);
                  if(surface.material != null)
                  {
                     material = §_-qn§(surface.material);
                     diffuse = this.§_-kb§(material.textures["diffuse"],resourceCache,this.mapFiles);
                     opacity = this.§_-kb§(material.textures["transparent"],resourceCache,this.mapFiles);
                     surface.material = new §_-Au§(opacity);
                  }
                  i++;
               }
               this.§_-Kq§.push(mesh);
            }
         }
      }
      
      private function §_-F0§(lightsData:ByteArray) : void
      {
         var parserCollada:§_-Jd§ = null;
         var numLights:uint = 0;
         var i:int = 0;
         if(lightsData != null)
         {
            parserCollada = new §_-Jd§();
            parserCollada.§_-Om§(XML(lightsData.toString()));
            numLights = uint(parserCollada.lights.length);
            this.§_-9k§ = new Vector.<§_-Jo§>(numLights);
            for(i = 0; i < numLights; i++)
            {
               this.§_-9k§[i] = parserCollada.lights[i];
               §_-Jo§(this.§_-9k§[i]).alternativa3d::removeFromParent();
            }
         }
      }
      
      private function §_-kb§(fileTextureResource:§_-n4§, resourceCache:Object, mapFiles:§_-Hk§) : §_-KJ§
      {
         var textureName:String = null;
         var resource:§_-KJ§ = null;
         var textureData:ByteArray = null;
         if(fileTextureResource != null && Boolean(fileTextureResource.url))
         {
            textureName = fileTextureResource.url.toLowerCase();
            textureName = textureName.replace(".png",".atf");
            textureName = textureName.replace(".jpg",".atf");
            if(mapFiles.§_-HG§(textureName) != null)
            {
               resource = resourceCache[textureName];
               if(resource == null)
               {
                  textureData = mapFiles.§_-HG§(textureName);
                  resource = new §_-KJ§(textureData);
                  resourceCache[textureName] = resource;
               }
               return resource;
            }
            trace("[WARN] texture not found:",fileTextureResource.url.toLowerCase());
         }
         return null;
      }
      
      private function §_-et§(a3dData:ByteArray) : void
      {
         var object:§_-OX§ = null;
         var objectName:String = null;
         var parserA3D:§_-Fh§ = new §_-Fh§();
         parserA3D.§_-Om§(a3dData);
         this.§_-73§ = new Vector.<§_-Nh§>();
         for each(object in parserA3D.objects)
         {
            if(object is §_-U2§)
            {
               objectName = object.name.toLowerCase();
               if(objectName.indexOf("tri") == 0)
               {
                  §_-Q4§.§_-eU§(§_-U2§(object),this.§_-73§,§_-HM§.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("box") == 0)
               {
                  §_-Q4§.§_-MS§(§_-U2§(object),this.§_-73§,§_-HM§.STATIC,COLLISION_MASK);
               }
               else if(objectName.indexOf("plane") == 0)
               {
                  §_-Q4§.§_-4D§(§_-U2§(object),this.§_-73§,§_-HM§.STATIC,COLLISION_MASK);
               }
            }
         }
      }
   }
}

import §_-8D§.§_-OX§;
import §_-V-§.§_-h5§;
import §_-am§.§_-Fh§;
import flash.utils.ByteArray;
import flash.utils.setTimeout;

class GeometryBuildTask extends §_-h5§
{
   private var data:ByteArray;
   
   private var collector:Vector.<§_-OX§>;
   
   public function GeometryBuildTask(data:ByteArray, collector:Vector.<§_-OX§>)
   {
      super();
      this.data = data;
      this.collector = collector;
   }
   
   override public function run() : void
   {
      var object:§_-OX§ = null;
      var parser:§_-Fh§ = new §_-Fh§();
      parser.§_-Om§(this.data);
      for each(object in parser.objects)
      {
         this.collector.push(object);
      }
      setTimeout(§_-3Z§,0);
   }
}
