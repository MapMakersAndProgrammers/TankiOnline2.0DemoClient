package alternativa.tanks.game.entities.map
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.lights.AmbientLight;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.lights.SpotLight;
   import alternativa.engine3d.materials.FillMaterial;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.SkyBox;
   import alternativa.engine3d.primitives.Box;
   import alternativa.engine3d.resources.ATFTextureResource;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.Geometry;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.physics.collision.CollisionPrimitive;
   import alternativa.physics.collision.primitives.CollisionRect;
   import alternativa.physics.collision.primitives.CollisionTriangle;
   import alternativa.physics.collision.primitives.name_311;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.subsystems.physicssystem.PhysicsSystem;
   import alternativa.tanks.game.subsystems.rendersystem.Lights;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.rendersystem.SkyMaterial;
   import alternativa.utils.ByteArrayMap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   use namespace alternativa3d;
   
   public class A3DMapComponent extends EntityComponent
   {
      public static const PHYSICS_GEOMETRY:String = "physicsGeometry";
      
      private var files:ByteArrayMap;
      
      private var skyboxFiles:ByteArrayMap;
      
      private var skyboxSize:Number;
      
      private var var_89:A3DMapBuilder;
      
      private var gameKernel:GameKernel;
      
      private var var_90:Number = 1.5;
      
      private var listener:IA3DMapComponentListener;
      
      private var var_91:Boolean = true;
      
      public function A3DMapComponent(files:ByteArrayMap, skyboxFiles:ByteArrayMap, skyboxSize:Number, listener:IA3DMapComponentListener)
      {
         super();
         this.files = files;
         this.skyboxFiles = skyboxFiles;
         this.skyboxSize = skyboxSize;
         this.listener = listener;
      }
      
      override public function initComponent() : void
      {
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.createSkybox();
         gameKernel.getInputSystem().addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKeyDown);
         if(gameKernel.options[MapOptions.FAKE_MAP] != null)
         {
            this.buildFakeMap();
         }
         else
         {
            this.buildRealMap();
         }
      }
      
      private function createSkybox() : void
      {
         var skyBox:SkyBox = null;
         var surfaceIds:Array = null;
         var surfaceId:String = null;
         var renderSystem:RenderSystem = null;
         var container:Object3D = null;
         var texture:ByteArray = null;
         var textureResource:ATFTextureResource = null;
         if(this.skyboxFiles != null)
         {
            skyBox = new SkyBox(this.skyboxSize);
            surfaceIds = [SkyBox.BACK,SkyBox.BOTTOM,SkyBox.FRONT,SkyBox.LEFT,SkyBox.RIGHT,SkyBox.TOP];
            for each(surfaceId in surfaceIds)
            {
               texture = this.skyboxFiles.getValue(surfaceId);
               textureResource = new ATFTextureResource(texture);
               skyBox.getSide(surfaceId).material = new SkyMaterial(textureResource);
            }
            renderSystem = this.gameKernel.getRenderSystem();
            renderSystem.useResources(skyBox.getResources(true));
            container = renderSystem.getContainer(RenderSystem.SKYBOX_CONTAINER_ID);
            container.addChild(skyBox);
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         var object:Object3D = null;
         var lights:Lights = null;
         var light:Light3D = null;
         var renderSystem:RenderSystem = gameKernel.getRenderSystem();
         var mapGeometryContainer:Object3D = renderSystem.getMapGeometryContainer();
         for each(object in this.var_89.objects)
         {
            mapGeometryContainer.removeChild(object);
         }
         renderSystem.releaseResources(mapGeometryContainer.getResources(true));
         lights = renderSystem.lights;
         for each(light in this.var_89.lights)
         {
            if(light is DirectionalLight)
            {
               lights.directionalLigths.remove(DirectionalLight(light));
            }
            else if(light is AmbientLight)
            {
               lights.ambientLight = null;
            }
            else if(light is SpotLight)
            {
               lights.spotLights.remove(SpotLight(light));
            }
            else if(light is OmniLight)
            {
               lights.omniLigths.remove(OmniLight(light));
            }
         }
         gameKernel.getInputSystem().removeKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKeyDown);
         this.gameKernel = null;
      }
      
      private function buildRealMap() : void
      {
         this.var_89 = new A3DMapBuilder();
         this.var_89.addEventListener(Event.COMPLETE,this.onBuildingComplete);
         this.var_89.buildMap(this.files);
      }
      
      private function onBuildingComplete(event:Event) : void
      {
         var staticShadowLight:DirectionalLight = this.initLights();
         this.initGraphics(staticShadowLight);
         this.initPhysics();
         this.complete();
      }
      
      private function complete() : void
      {
         this.gameKernel.getRenderSystem().setShadowSystemReady();
         if(this.listener != null)
         {
            this.listener.onA3DMapComplete();
         }
      }
      
      private function initLights() : DirectionalLight
      {
         var staticShadowLight:DirectionalLight = null;
         var light:Light3D = null;
         if(Boolean(this.gameKernel.options["fakelight"]))
         {
            this.initFakeLight();
            return null;
         }
         var renderSystem:RenderSystem = this.gameKernel.getRenderSystem();
         var lights:Lights = renderSystem.lights;
         for each(light in this.var_89.lights)
         {
            if(light is DirectionalLight)
            {
               if(staticShadowLight == null)
               {
                  staticShadowLight = DirectionalLight(light);
               }
               lights.directionalLigths.add(DirectionalLight(light));
            }
            else if(light is AmbientLight)
            {
               lights.ambientLight = AmbientLight(light);
            }
            else if(light is SpotLight)
            {
               lights.spotLights.add(SpotLight(light));
            }
            else if(light is OmniLight)
            {
               lights.omniLigths.add(OmniLight(light));
            }
            if(light is AmbientLight || light is DirectionalLight)
            {
               light.intensity *= 2;
            }
            if(light is DirectionalLight || light is AmbientLight)
            {
               light.boundBox = null;
            }
            else
            {
               light.calculateBoundBox();
            }
         }
         return staticShadowLight;
      }
      
      private function initFakeLight() : void
      {
         this.gameKernel.getRenderSystem().lights.ambientLight = new AmbientLight(16777215);
      }
      
      private function initGraphics(staticShadowLight:DirectionalLight) : void
      {
         var object:Object3D = null;
         var renderSystem:RenderSystem = this.gameKernel.getRenderSystem();
         var mapGeometryContainer:Object3D = renderSystem.getMapGeometryContainer();
         for each(object in this.var_89.objects)
         {
            mapGeometryContainer.addChild(object);
         }
         renderSystem.useResources(mapGeometryContainer.getResources(true));
         if(staticShadowLight != null)
         {
            renderSystem.initStaticShadow(staticShadowLight);
         }
      }
      
      private function initPhysics() : void
      {
         var renderSystem:RenderSystem = null;
         var physicsContainer:Object3D = null;
         var physicsSystem:PhysicsSystem = this.gameKernel.getPhysicsSystem();
         physicsSystem.initCollisionGeometry(this.var_89.collisionPrimitives);
         if(this.gameKernel.options[MapOptions.VISUALIZE_PHYSICS] != null)
         {
            renderSystem = this.gameKernel.getRenderSystem();
            physicsContainer = this.createPhysicsVisualObjects(this.var_89.collisionPrimitives);
            physicsContainer.visible = false;
            renderSystem.addContainer(PHYSICS_GEOMETRY,physicsContainer,true);
         }
      }
      
      private function createPhysicsVisualObjects(collisionPrimitives:Vector.<CollisionPrimitive>) : Object3D
      {
         var collisionPrimitive:CollisionPrimitive = null;
         var physicsVisualContainer:Object3D = new Object3D();
         var boxMaterial:FillMaterial = new FillMaterial(11141120);
         var triangleMaterial:FillMaterial = new FillMaterial(43520);
         var numCollisionPrimitives:int = int(collisionPrimitives.length);
         for(var i:int = 0; i < numCollisionPrimitives; )
         {
            collisionPrimitive = collisionPrimitives[i];
            if(collisionPrimitive is name_311)
            {
               physicsVisualContainer.addChild(this.createPhysicsVisualBox(name_311(collisionPrimitive),boxMaterial));
            }
            else if(collisionPrimitive is CollisionTriangle)
            {
               physicsVisualContainer.addChild(this.createPhysicsVisualTriangle(CollisionTriangle(collisionPrimitive),triangleMaterial));
            }
            i++;
         }
         return physicsVisualContainer;
      }
      
      private function createPhysicsVisualBox(collisionBox:name_311, material:Material) : Box
      {
         var size:Vector3 = collisionBox.hs.clone().scale(2);
         var box:Box = new Box(size.x,size.y,size.z);
         box.setMaterialToAllSurfaces(material);
         this.setPhysicsTransform(collisionBox,box);
         return box;
      }
      
      private function createPhysicsVisualTriangle(collisionTriangle:CollisionTriangle, material:Material) : Mesh
      {
         var mesh:Mesh = new Mesh();
         var geometry:Geometry = new Geometry();
         var attributes:Array = [];
         attributes[0] = VertexAttributes.POSITION;
         attributes[1] = VertexAttributes.POSITION;
         attributes[2] = VertexAttributes.POSITION;
         geometry.addVertexStream(attributes);
         geometry.numVertices = 3;
         var values:Vector.<Number> = new Vector.<Number>(9);
         values[0] = collisionTriangle.v0.x;
         values[1] = collisionTriangle.v0.y;
         values[2] = collisionTriangle.v0.z;
         values[3] = collisionTriangle.v1.x;
         values[4] = collisionTriangle.v1.y;
         values[5] = collisionTriangle.v1.z;
         values[6] = collisionTriangle.v2.x;
         values[7] = collisionTriangle.v2.y;
         values[8] = collisionTriangle.v2.z;
         geometry.setAttributeValues(VertexAttributes.POSITION,values);
         geometry.indices = Vector.<uint>([0,1,2]);
         mesh.geometry = geometry;
         mesh.addSurface(material,0,1);
         mesh.calculateBoundBox();
         this.setPhysicsTransform(collisionTriangle,mesh);
         return mesh;
      }
      
      private function setPhysicsTransform(collisionPrimitive:CollisionPrimitive, object:Object3D) : void
      {
         var t:Matrix4 = collisionPrimitive.transform;
         var eulerAngles:Vector3 = new Vector3();
         t.getEulerAngles(eulerAngles);
         object.x = t.d;
         object.y = t.h;
         object.z = t.l;
         object.rotationX = eulerAngles.x;
         object.rotationY = eulerAngles.y;
         object.rotationZ = eulerAngles.z;
      }
      
      private function buildFakeMap() : void
      {
         var collisionRect:CollisionRect = new CollisionRect(new Vector3(20000,20000),1,255);
         var collisionPrimitives:Vector.<CollisionPrimitive> = Vector.<CollisionPrimitive>([collisionRect]);
         this.gameKernel.getPhysicsSystem().initCollisionGeometry(collisionPrimitives);
         var renderSystem:RenderSystem = this.gameKernel.getRenderSystem();
         renderSystem.getContainer(RenderSystem.LIGHTS_CONTAINER_ID).addChild(new AmbientLight(16777215));
         this.addZeroMarker(renderSystem);
         var bitmapData:BitmapData = new BitmapData(512,512);
         bitmapData.perlinNoise(10,10,3,13,false,true);
         var bitmapTextureResource:BitmapTextureResource = new BitmapTextureResource(bitmapData);
         var box:Box = new Box(2 * 20000,2 * 20000,10);
         box.setMaterialToAllSurfaces(new TextureMaterial(bitmapTextureResource));
         box.z = -5;
         renderSystem.getMapGeometryContainer().addChild(box);
         renderSystem.useResources(box.getResources());
         setTimeout(this.complete,0);
      }
      
      private function addZeroMarker(renderSystem:RenderSystem) : void
      {
         var resource:Resource = null;
         var box:Box = new Box(50,50,50);
         box.setMaterialToAllSurfaces(new FillMaterial(11141120));
         for each(resource in box.getResources())
         {
            renderSystem.useResource(resource);
         }
         renderSystem.getMapGeometryContainer().addChild(box);
      }
      
      private function onKeyDown(eventType:KeyboardEventType, keyCode:uint) : void
      {
         switch(keyCode)
         {
            case Keyboard.F1:
            case Keyboard.F2:
            case Keyboard.F3:
            case Keyboard.NUMBER_6:
            case Keyboard.COMMA:
            case Keyboard.PERIOD:
            case Keyboard.SEMICOLON:
            case Keyboard.QUOTE:
         }
      }
      
      private function toggleDecals() : void
      {
         var d:Decal = null;
         this.var_91 = !this.var_91;
         for each(d in this.var_89.decals)
         {
            d.visible = this.var_91;
         }
      }
      
      private function get decalsOffset() : Number
      {
         return this.var_90;
      }
      
      private function set decalsOffset(value:Number) : void
      {
         var decal:Decal = null;
         this.var_90 = value;
         for each(decal in this.var_89.decals)
         {
            decal.offset = this.var_90;
         }
         IConsole(OSGi.getInstance().getService(IConsole)).addText("Decals offset: " + this.var_90);
      }
      
      private function toggleGeometry(containerId:String) : void
      {
         var container:Object3D = this.gameKernel.getRenderSystem().getContainer(containerId);
         if(container != null)
         {
            container.visible = !container.visible;
         }
      }
   }
}

