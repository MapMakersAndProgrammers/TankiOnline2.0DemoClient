package package_123
{
   use namespace collada;
   
   public class name_707
   {
      public var scene:name_737;
      
      private var data:XML;
      
      internal var var_690:Object;
      
      internal var arrays:Object;
      
      internal var vertices:Object;
      
      public var geometries:Object;
      
      internal var nodes:Object;
      
      internal var lights:Object;
      
      internal var images:Object;
      
      internal var effects:Object;
      
      internal var var_692:Object;
      
      internal var var_691:Object;
      
      public var materials:Object;
      
      internal var logger:name_743;
      
      public var versionMajor:uint;
      
      public var versionMinor:uint;
      
      public var unitScaleFactor:Number = 1;
      
      public function name_707(document:XML, units:Number)
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
         this.logger = new name_743();
         this.method_848();
         this.method_847();
         this.registerInstanceControllers();
         this.method_846();
      }
      
      private function method_845(url:XML) : String
      {
         var path:String = url.toString();
         if(path.charAt(0) == "#")
         {
            return path.substr(1);
         }
         this.logger.name_745(url);
         return null;
      }
      
      private function method_848() : void
      {
         var element:XML = null;
         var source:name_740 = null;
         var light:name_741 = null;
         var image:name_734 = null;
         var effect:name_738 = null;
         var material:name_713 = null;
         var geom:name_736 = null;
         var controller:name_735 = null;
         var node:name_706 = null;
         this.var_690 = new Object();
         this.arrays = new Object();
         for each(element in this.data..source)
         {
            source = new name_740(element,this);
            if(source.id != null)
            {
               this.var_690[source.id] = source;
            }
         }
         this.lights = new Object();
         for each(element in this.data.library_lights.light)
         {
            light = new name_741(element,this);
            if(light.id != null)
            {
               this.lights[light.id] = light;
            }
         }
         this.images = new Object();
         for each(element in this.data.library_images.image)
         {
            image = new name_734(element,this);
            if(image.id != null)
            {
               this.images[image.id] = image;
            }
         }
         this.effects = new Object();
         for each(element in this.data.library_effects.effect)
         {
            effect = new name_738(element,this);
            if(effect.id != null)
            {
               this.effects[effect.id] = effect;
            }
         }
         this.materials = new Object();
         for each(element in this.data.library_materials.material)
         {
            material = new name_713(element,this);
            if(material.id != null)
            {
               this.materials[material.id] = material;
            }
         }
         this.geometries = new Object();
         this.vertices = new Object();
         for each(element in this.data.library_geometries.geometry)
         {
            geom = new name_736(element,this);
            if(geom.id != null)
            {
               this.geometries[geom.id] = geom;
            }
         }
         this.var_692 = new Object();
         for each(element in this.data.library_controllers.controller)
         {
            controller = new name_735(element,this);
            if(controller.id != null)
            {
               this.var_692[controller.id] = controller;
            }
         }
         this.nodes = new Object();
         for each(element in this.data.library_nodes.node)
         {
            node = new name_706(element,this);
            if(node.id != null)
            {
               this.nodes[node.id] = node;
            }
         }
      }
      
      private function method_847() : void
      {
         var element:XML = null;
         var vscene:name_737 = null;
         var vsceneURL:XML = this.data.scene.instance_visual_scene.@url[0];
         var vsceneID:String = this.method_845(vsceneURL);
         for each(element in this.data.library_visual_scenes.visual_scene)
         {
            vscene = new name_737(element,this);
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
      
      private function method_846() : void
      {
         var element:XML = null;
         var sampler:name_739 = null;
         var channel:name_742 = null;
         var node:name_706 = null;
         this.var_691 = new Object();
         for each(element in this.data.library_animations..sampler)
         {
            sampler = new name_739(element,this);
            if(sampler.id != null)
            {
               this.var_691[sampler.id] = sampler;
            }
         }
         for each(element in this.data.library_animations..channel)
         {
            channel = new name_742(element,this);
            node = channel.node;
            if(node != null)
            {
               node.name_747(channel);
            }
         }
      }
      
      public function findArray(url:XML) : name_746
      {
         return this.arrays[this.method_845(url)];
      }
      
      public function findSource(url:XML) : name_740
      {
         return this.var_690[this.method_845(url)];
      }
      
      public function findLight(url:XML) : name_741
      {
         return this.lights[this.method_845(url)];
      }
      
      public function findImage(url:XML) : name_734
      {
         return this.images[this.method_845(url)];
      }
      
      public function findImageByID(id:String) : name_734
      {
         return this.images[id];
      }
      
      public function findEffect(url:XML) : name_738
      {
         return this.effects[this.method_845(url)];
      }
      
      public function findMaterial(url:XML) : name_713
      {
         return this.materials[this.method_845(url)];
      }
      
      public function findVertices(url:XML) : name_744
      {
         return this.vertices[this.method_845(url)];
      }
      
      public function findGeometry(url:XML) : name_736
      {
         return this.geometries[this.method_845(url)];
      }
      
      public function findNode(url:XML) : name_706
      {
         return this.nodes[this.method_845(url)];
      }
      
      public function findNodeByID(id:String) : name_706
      {
         return this.nodes[id];
      }
      
      public function findController(url:XML) : name_735
      {
         return this.var_692[this.method_845(url)];
      }
      
      public function findSampler(url:XML) : name_739
      {
         return this.var_691[this.method_845(url)];
      }
   }
}

