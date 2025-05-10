package alternativa.engine3d.loaders.collada
{
   use namespace collada;
   
   public class DaeDocument
   {
      public var scene:DaeVisualScene;
      
      private var data:XML;
      
      internal var name_DR:Object;
      
      internal var arrays:Object;
      
      internal var vertices:Object;
      
      public var geometries:Object;
      
      internal var nodes:Object;
      
      internal var lights:Object;
      
      internal var images:Object;
      
      internal var effects:Object;
      
      internal var name_DW:Object;
      
      internal var name_GB:Object;
      
      public var materials:Object;
      
      internal var logger:DaeLogger;
      
      public var versionMajor:uint;
      
      public var versionMinor:uint;
      
      public var unitScaleFactor:Number = 1;
      
      public function DaeDocument(document:XML, units:Number)
      {
         super();
         this.data = document;
         var versionComponents:Array = this.data.@version[0].toString().split(/[.,]/);
         this.versionMajor = parseInt(versionComponents[1],10);
         this.versionMinor = parseInt(versionComponents[2],10);
         var colladaUnit:Number = Number(parseFloat(this.data.asset[0].unit[0].@meter));
         if(units > 0)
         {
            this.unitScaleFactor = colladaUnit / units;
         }
         else
         {
            this.unitScaleFactor = 1;
         }
         this.logger = new DaeLogger();
         this.constructStructures();
         this.constructScenes();
         this.registerInstanceControllers();
         this.constructAnimations();
      }
      
      private function getLocalID(url:XML) : String
      {
         var path:String = url.toString();
         if(path.charAt(0) == "#")
         {
            return path.substr(1);
         }
         this.logger.logExternalError(url);
         return null;
      }
      
      private function constructStructures() : void
      {
         var element:XML = null;
         var source:DaeSource = null;
         var light:DaeLight = null;
         var image:DaeImage = null;
         var effect:DaeEffect = null;
         var material:DaeMaterial = null;
         var geom:DaeGeometry = null;
         var controller:DaeController = null;
         var node:DaeNode = null;
         this.name_DR = new Object();
         this.arrays = new Object();
         for each(element in this.data..source)
         {
            source = new DaeSource(element,this);
            if(source.id != null)
            {
               this.name_DR[source.id] = source;
            }
         }
         this.lights = new Object();
         for each(element in this.data.library_lights.light)
         {
            light = new DaeLight(element,this);
            if(light.id != null)
            {
               this.lights[light.id] = light;
            }
         }
         this.images = new Object();
         for each(element in this.data.library_images.image)
         {
            image = new DaeImage(element,this);
            if(image.id != null)
            {
               this.images[image.id] = image;
            }
         }
         this.effects = new Object();
         for each(element in this.data.library_effects.effect)
         {
            effect = new DaeEffect(element,this);
            if(effect.id != null)
            {
               this.effects[effect.id] = effect;
            }
         }
         this.materials = new Object();
         for each(element in this.data.library_materials.material)
         {
            material = new DaeMaterial(element,this);
            if(material.id != null)
            {
               this.materials[material.id] = material;
            }
         }
         this.geometries = new Object();
         this.vertices = new Object();
         for each(element in this.data.library_geometries.geometry)
         {
            geom = new DaeGeometry(element,this);
            if(geom.id != null)
            {
               this.geometries[geom.id] = geom;
            }
         }
         this.name_DW = new Object();
         for each(element in this.data.library_controllers.controller)
         {
            controller = new DaeController(element,this);
            if(controller.id != null)
            {
               this.name_DW[controller.id] = controller;
            }
         }
         this.nodes = new Object();
         for each(element in this.data.library_nodes.node)
         {
            node = new DaeNode(element,this);
            if(node.id != null)
            {
               this.nodes[node.id] = node;
            }
         }
      }
      
      private function constructScenes() : void
      {
         var element:XML = null;
         var vscene:DaeVisualScene = null;
         var vsceneURL:XML = this.data.scene.instance_visual_scene.@url[0];
         var vsceneID:String = this.getLocalID(vsceneURL);
         for each(element in this.data.library_visual_scenes.visual_scene)
         {
            vscene = new DaeVisualScene(element,this);
            if(vscene.id == vsceneID)
            {
               this.scene = vscene;
            }
         }
         if(vsceneID != null && this.scene == null)
         {
            this.logger.logNotFoundError(vsceneURL);
         }
      }
      
      private function registerInstanceControllers() : void
      {
         var i:int = 0;
         var count:int = 0;
         if(this.scene != null)
         {
            for(i = 0,count = int(this.scene.nodes.length); i < count; i++)
            {
               this.scene.nodes[i].registerInstanceControllers();
            }
         }
      }
      
      private function constructAnimations() : void
      {
         var element:XML = null;
         var sampler:DaeSampler = null;
         var channel:DaeChannel = null;
         var node:DaeNode = null;
         this.name_GB = new Object();
         for each(element in this.data.library_animations..sampler)
         {
            sampler = new DaeSampler(element,this);
            if(sampler.id != null)
            {
               this.name_GB[sampler.id] = sampler;
            }
         }
         for each(element in this.data.library_animations..channel)
         {
            channel = new DaeChannel(element,this);
            node = channel.node;
            if(node != null)
            {
               node.addChannel(channel);
            }
         }
      }
      
      public function findArray(url:XML) : DaeArray
      {
         return this.arrays[this.getLocalID(url)];
      }
      
      public function findSource(url:XML) : DaeSource
      {
         return this.name_DR[this.getLocalID(url)];
      }
      
      public function findLight(url:XML) : DaeLight
      {
         return this.lights[this.getLocalID(url)];
      }
      
      public function findImage(url:XML) : DaeImage
      {
         return this.images[this.getLocalID(url)];
      }
      
      public function findImageByID(id:String) : DaeImage
      {
         return this.images[id];
      }
      
      public function findEffect(url:XML) : DaeEffect
      {
         return this.effects[this.getLocalID(url)];
      }
      
      public function findMaterial(url:XML) : DaeMaterial
      {
         return this.materials[this.getLocalID(url)];
      }
      
      public function findVertices(url:XML) : DaeVertices
      {
         return this.vertices[this.getLocalID(url)];
      }
      
      public function findGeometry(url:XML) : DaeGeometry
      {
         return this.geometries[this.getLocalID(url)];
      }
      
      public function findNode(url:XML) : DaeNode
      {
         return this.nodes[this.getLocalID(url)];
      }
      
      public function findNodeByID(id:String) : DaeNode
      {
         return this.nodes[id];
      }
      
      public function findController(url:XML) : DaeController
      {
         return this.name_DW[this.getLocalID(url)];
      }
      
      public function findSampler(url:XML) : DaeSampler
      {
         return this.name_GB[this.getLocalID(url)];
      }
   }
}

