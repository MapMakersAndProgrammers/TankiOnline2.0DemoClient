package alternativa.tanks.game.subsystems.rendersystem
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.core.View;
   import alternativa.engine3d.core.events.MouseEvent3D;
   import alternativa.engine3d.effects.ParticleSystem;
   import alternativa.engine3d.effects.name_77;
   import alternativa.engine3d.lights.DirectionalLight;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.shadows.ShadowRenderer;
   import alternativa.engine3d.shadows.ShadowsSystem;
   import alternativa.engine3d.shadows.StaticShadowRenderer;
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.camera.AxisIndicator;
   import alternativa.tanks.game.entities.map.MapMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TreesMaterial;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.utils.BitFlags;
   import alternativa.tanks.game.utils.objectpool.ObjectPoolManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DRenderMode;
   import flash.events.Event;
   import flash.geom.Vector3D;
   import flash.ui.Keyboard;
   
   use namespace alternativa3d;
   
   public class RenderSystem extends GameTask implements IResourceManager
   {
      public static const SKYBOX_CONTAINER_ID:String = "skyboxContainer";
      
      public static const MAP_GEOMETRY_CONTAINER_ID:String = "mapGeometryContainer";
      
      public static const LIGHTS_CONTAINER_ID:String = "lightsContainer";
      
      public static const DYNAMIC_OBJECTS_CONTAINER_ID:String = "dynamicObjectsContainer";
      
      public static const EFFECTS_CONTAINER_ID:String = "effectsContainer";
      
      private static const BIT_DEBUG_GEOMETRY:int = 1;
      
      private static const BIT_DEBUG_LIGHTS:int = 1 << 1;
      
      private var rootContainer:Object3D;
      
      private var skyboxContainer:Object3D;
      
      private var mapGeometryContainer:Object3D;
      
      private var lightsContainer:Object3D;
      
      private var dynamicObjectsContainer:Object3D;
      
      private var effectsContainer:Object3D;
      
      private var var_12:Object = {};
      
      private var view:View;
      
      private var camera:GameCamera;
      
      private var var_13:ICameraController;
      
      private var axisIndicator:AxisIndicator;
      
      private var renderers:RendererList;
      
      private var var_10:RendererList;
      
      private var effects:Vector.<IGraphicEffect>;
      
      private var numEffects:int;
      
      private var var_14:Boolean = true;
      
      private var var_8:Object = {};
      
      private var var_16:Lights;
      
      private var var_20:Boolean;
      
      private var var_19:Boolean;
      
      private var objectPoolManager:ObjectPoolManager = new ObjectPoolManager();
      
      private var var_18:Vector.<TextMarker>;
      
      private var var_17:BitFlags = new BitFlags();
      
      private var stage:Stage;
      
      private var stage3d:Stage3D;
      
      private var resourceManager:ResourceManager;
      
      private var var_9:ShadowsSystem;
      
      private var staticShadowRenderer:StaticShadowRenderer;
      
      private var var_11:Vector.<IDeferredAction>;
      
      private var var_7:Vector.<IShadowRendererConstructor>;
      
      private var var_15:Boolean;
      
      private var var_5:BitmapTextureResource;
      
      private var var_6:ParticleSystem;
      
      public function RenderSystem(priority:int, stage:Stage)
      {
         super(priority);
         this.stage = stage;
         this.renderers = new RendererList();
         this.var_10 = new RendererList();
         this.effects = new Vector.<IGraphicEffect>();
         this.rootContainer = new Object3D();
         this.rootContainer.name = "root";
         this.skyboxContainer = this.createContainer(SKYBOX_CONTAINER_ID);
         this.mapGeometryContainer = this.createContainer(MAP_GEOMETRY_CONTAINER_ID);
         this.lightsContainer = this.createContainer(LIGHTS_CONTAINER_ID);
         this.dynamicObjectsContainer = this.createContainer(DYNAMIC_OBJECTS_CONTAINER_ID);
         this.effectsContainer = this.createContainer(EFFECTS_CONTAINER_ID);
         this.var_16 = new Lights(this.lightsContainer);
         this.view = new View(100,100,false,6710886,1,4);
         this.view.hideLogo();
         this.camera = new GameCamera(10,50000);
         this.camera.nearClipping = 1;
         this.camera.view = this.view;
         this.rootContainer.addChild(this.camera);
         var giLight:DirectionalLight = new DirectionalLight(9222892);
         giLight.intensity = 0.5;
         giLight.rotationX = Math.PI;
         this.var_6 = new ParticleSystem();
         this.var_6.gravity = new Vector3D(0,0,-1);
         this.var_6.wind = new Vector3D(1,0,0);
         this.rootContainer.addChild(this.var_6);
         this.axisIndicator = new AxisIndicator(100);
         this.resourceManager = new ResourceManager();
         this.var_9 = new ShadowsSystem();
         this.staticShadowRenderer = new StaticShadowRenderer(null,1024,4);
         this.var_11 = new Vector.<IDeferredAction>();
         this.rootContainer.addEventListener(MouseEvent3D.CLICK,this.onClick);
      }
      
      private function onClick(e:MouseEvent3D) : void
      {
         if(e.target is Decal)
         {
            trace(e.target,e.target.name,Decal(e.target).offset,e.target.scaleX,e.target.scaleY,e.target.scaleZ);
         }
         else
         {
            trace(e.target,e.target.name);
         }
      }
      
      public function get lights() : Lights
      {
         return this.var_16;
      }
      
      public function setFogMode(mode:int) : void
      {
         MapMaterial.fogMode = mode;
         TankMaterial.fogMode = mode;
         TankMaterial2.fogMode = mode;
         TracksMaterial2.fogMode = mode;
         TreesMaterial.fogMode = mode;
         SkyMaterial.fogMode = mode;
         GiShadowMaterial.fogMode = mode;
         if(mode == 1)
         {
            this.var_6.fogFar = MapMaterial.fogFar;
         }
         else
         {
            this.var_6.fogFar = 0;
         }
      }
      
      public function setFogNear(value:Number) : void
      {
         MapMaterial.fogNear = value;
         TankMaterial.fogNear = value;
         TankMaterial2.fogNear = value;
         TracksMaterial2.fogNear = value;
         TreesMaterial.fogNear = value;
         GiShadowMaterial.fogNear = value;
         this.var_6.fogNear = value;
      }
      
      public function setFogFar(value:Number) : void
      {
         MapMaterial.fogFar = value;
         TankMaterial.fogFar = value;
         TankMaterial2.fogFar = value;
         TracksMaterial2.fogFar = value;
         TreesMaterial.fogFar = value;
         GiShadowMaterial.fogFar = value;
         this.var_6.fogFar = value;
      }
      
      public function setMaxFogDensity(value:Number) : void
      {
         MapMaterial.fogMaxDensity = value;
         TankMaterial.fogMaxDensity = value;
         TankMaterial2.fogMaxDensity = value;
         TracksMaterial2.fogMaxDensity = value;
         TreesMaterial.fogMaxDensity = value;
         SkyMaterial.fogMaxDensity = value;
         GiShadowMaterial.fogMaxDensity = value;
         this.var_6.fogMaxDensity = value;
      }
      
      public function setFogColor(color:uint) : void
      {
         var r:Number = (color >> 16 & 0xFF) / 255;
         var g:Number = (color >> 8 & 0xFF) / 255;
         var b:Number = (color & 0xFF) / 255;
         MapMaterial.fogColorR = r;
         MapMaterial.fogColorG = g;
         MapMaterial.fogColorB = b;
         TankMaterial.fogColorR = r;
         TankMaterial.fogColorG = g;
         TankMaterial.fogColorB = b;
         TankMaterial2.fogColorR = r;
         TankMaterial2.fogColorG = g;
         TankMaterial2.fogColorB = b;
         TracksMaterial2.fogColorR = r;
         TracksMaterial2.fogColorG = g;
         TracksMaterial2.fogColorB = b;
         TreesMaterial.fogColorR = r;
         TreesMaterial.fogColorG = g;
         TreesMaterial.fogColorB = b;
         SkyMaterial.fogColorR = r;
         SkyMaterial.fogColorG = g;
         SkyMaterial.fogColorB = b;
         GiShadowMaterial.fogColorR = r;
         GiShadowMaterial.fogColorG = g;
         GiShadowMaterial.fogColorB = b;
         this.var_6.name_76 = color;
      }
      
      public function setFogHorizonSize(value:Number) : void
      {
         SkyMaterial.fogHeight = value;
      }
      
      public function setFogHorizonOffset(value:Number) : void
      {
         SkyMaterial.fogOffset = value;
      }
      
      public function setFogTextureParams(textureParams:String) : void
      {
         var fogBitmap:BitmapData = RenderUtils.getFogBitmap(textureParams,128);
         var fogInitializator:FogInitializator = new FogInitializator(fogBitmap,this);
         if(this.isContext3DAvailable())
         {
            fogInitializator.execute(this.stage3d);
         }
         else
         {
            this.var_11.push(fogInitializator);
         }
      }
      
      public function setFogTexture(bitmapData:BitmapData) : void
      {
         if(!this.isContext3DAvailable())
         {
            throw new Error("Context3D is not available. Use setFogTextureParams() instead.");
         }
         if(this.var_5 != null)
         {
            this.releaseResource(this.var_5);
         }
         this.var_5 = new BitmapTextureResource(bitmapData);
         this.useResource(this.var_5);
         MapMaterial.setFogTexture(this.var_5);
         TankMaterial.setFogTexture(this.var_5);
         TankMaterial2.setFogTexture(this.var_5);
         GiShadowMaterial.setFogTexture(this.var_5);
         TracksMaterial2.setFogTexture(this.var_5);
         TreesMaterial.setFogTexture(this.var_5);
         SkyMaterial.setFogTexture(this.var_5);
      }
      
      public function isShadowSystemReady() : Boolean
      {
         return this.var_15;
      }
      
      public function setShadowSystemReady() : void
      {
         var shadowRendererConstructor:IShadowRendererConstructor = null;
         this.var_15 = true;
         if(this.var_7 != null)
         {
            for each(shadowRendererConstructor in this.var_7)
            {
               shadowRendererConstructor.createShadowRenderer();
            }
            this.var_7 = null;
         }
      }
      
      public function addShadowRendererConstructor(shadowRendererConstructor:IShadowRendererConstructor) : void
      {
         if(shadowRendererConstructor == null)
         {
            throw new ArgumentError("Parameter shadowRendererConstructor is null");
         }
         if(this.var_15)
         {
            throw new Error("Cannot add constructor: shadow system is ready");
         }
         if(this.var_7 == null)
         {
            this.var_7 = new Vector.<IShadowRendererConstructor>();
         }
         var index:int = int(this.var_7.indexOf(shadowRendererConstructor));
         if(index < 0)
         {
            this.var_7.push(shadowRendererConstructor);
         }
      }
      
      public function removeShadowRendererConstructor(shadowRendererConstructor:IShadowRendererConstructor) : void
      {
         var index:int = 0;
         if(this.var_7 != null)
         {
            index = int(this.var_7.indexOf(shadowRendererConstructor));
            if(index >= 0)
            {
               this.var_7.splice(index,1);
            }
         }
      }
      
      public function getShadowSystem() : ShadowsSystem
      {
         return this.var_9;
      }
      
      public function setAntialiasing(value:int) : void
      {
         this.view.antiAlias = value;
      }
      
      public function getAnitaliasing() : int
      {
         return this.view.antiAlias;
      }
      
      public function addShadowRenderer(renderer:ShadowRenderer) : void
      {
         if(renderer == null)
         {
            throw new ArgumentError("Parameter renderer is null");
         }
         if(this.var_9.renderers.indexOf(renderer) < 0)
         {
            this.var_9.renderers.push(renderer);
         }
      }
      
      public function removeShadowRenderer(renderer:ShadowRenderer) : void
      {
         var index:int = int(this.var_9.renderers.indexOf(renderer));
         if(index >= 0)
         {
            this.var_9.renderers.splice(index,1);
         }
      }
      
      public function setStage3D(stage3d:Stage3D) : void
      {
         this.stage3d = stage3d;
         this.initContext(stage3d.context3D);
      }
      
      public function requestContext3D() : void
      {
         this.stage3d = this.stage.stage3Ds[0];
         this.stage3d.addEventListener(Event.CONTEXT3D_CREATE,this.onContext3DCreate);
         this.stage3d.requestContext3D(Context3DRenderMode.AUTO);
      }
      
      public function useResource(resource:Resource) : void
      {
         this.resourceManager.useResource(resource);
      }
      
      public function useResources(resources:Vector.<Resource>) : void
      {
         this.resourceManager.useResources(resources);
      }
      
      public function releaseResource(resource:Resource) : void
      {
         this.resourceManager.releaseResource(resource);
      }
      
      public function releaseResources(resources:Vector.<Resource>) : void
      {
         this.resourceManager.releaseResources(resources);
      }
      
      public function clear() : void
      {
      }
      
      public function getRootContainer() : Object3D
      {
         return this.rootContainer;
      }
      
      public function getMapGeometryContainer() : Object3D
      {
         return this.mapGeometryContainer;
      }
      
      public function getDynamicObjectsContainer() : Object3D
      {
         return this.dynamicObjectsContainer;
      }
      
      public function getEffectsContainer() : Object3D
      {
         return this.effectsContainer;
      }
      
      public function getContainer(containerId:String) : Object3D
      {
         return this.var_12[containerId];
      }
      
      public function uploadResource(resource:Resource) : void
      {
         this.resourceManager.uploadResource(resource);
      }
      
      public function addContainer(containerId:String, container:Object3D, uploadResources:Boolean) : void
      {
         if(this.getContainer(containerId) != null)
         {
            throw new Error("Container with id \"" + containerId + "\" already exists");
         }
         this.var_12[containerId] = container;
         this.rootContainer.addChild(container);
         if(uploadResources)
         {
            this.resourceManager.useResources(container.getResources(true));
         }
      }
      
      public function getAxisIndicator() : AxisIndicator
      {
         return this.axisIndicator;
      }
      
      public function getOverlay(name:String) : Sprite
      {
         var view:View = null;
         var overlay:Sprite = this.var_8[name];
         if(overlay == null)
         {
            overlay = new Sprite();
            this.var_8[name] = overlay;
            view = this.camera.view;
            overlay.x = view.x + (view.width >> 1);
            overlay.y = view.y + (view.height >> 1);
            view.parent.addChild(overlay);
         }
         return overlay;
      }
      
      public function removeOverlay(name:String) : void
      {
         var overlay:Sprite = this.var_8[name];
         if(overlay != null)
         {
            delete this.var_8[name];
            overlay.parent.removeChild(overlay);
         }
      }
      
      public function addObject(object:Object3D) : void
      {
         this.rootContainer.addChild(object);
         this.resourceManager.useResources(object.getResources());
      }
      
      public function getView() : View
      {
         return this.view;
      }
      
      public function getCameraDiagram() : DisplayObject
      {
         return this.camera.diagram;
      }
      
      public function setPhysicsVisualObjects(objects:Vector.<Object3D>) : void
      {
         var object3D:Object3D = null;
         for each(object3D in objects)
         {
         }
      }
      
      public function addRenderer(renderer:IRenderer) : void
      {
         this.renderers.add(renderer);
      }
      
      public function removeRenderer(renderer:IRenderer) : void
      {
         this.renderers.remove(renderer);
      }
      
      public function addPostRenderer(renderer:IRenderer) : void
      {
         this.var_10.add(renderer);
      }
      
      public function removePostRenderer(renderer:IRenderer) : void
      {
         this.var_10.remove(renderer);
      }
      
      public function method_21(effect:IGraphicEffect) : void
      {
         if(this.effects.indexOf(effect) >= 0)
         {
            throw new Error("Effect " + effect + " already exists");
         }
         var _loc2_:* = this.numEffects++;
         this.effects[_loc2_] = effect;
         effect.addedToRenderSystem(this);
      }
      
      public function addA3DEffect(effect:name_77) : void
      {
         this.var_6.method_21(effect);
      }
      
      public function setCameraController(controller:ICameraController) : void
      {
         if(this.var_13 == controller)
         {
            return;
         }
         this.var_13 = controller;
         controller.enable();
      }
      
      public function getCamera() : GameCamera
      {
         return this.camera;
      }
      
      public function disableCameraController() : void
      {
         this.var_14 = false;
         false;
      }
      
      public function enableCameraController() : void
      {
         this.var_14 = true;
         true;
      }
      
      public function setViewRect(x:int, y:int, width:int, height:int) : void
      {
         var overlay:Sprite = null;
         var view:View = this.camera.view;
         view.x = x;
         view.y = y;
         view.width = width;
         view.height = height;
         for each(var _loc9_ in this.var_8)
         {
            overlay = _loc9_;
            _loc9_;
            overlay.x = x + (width >> 1);
            overlay.y = y + (height >> 1);
         }
      }
      
      public function getContext3D() : Context3D
      {
         return this.stage3d.context3D;
      }
      
      override public function start() : void
      {
         var input:IInput = IInput(var_4.getTaskInterface(IInput));
         input.addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onToggleDebugKey,Keyboard.F7);
         input.addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onToggleDebugKey,Keyboard.F8);
         input.addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onToggleDebugKey,Keyboard.TAB);
      }
      
      override public function stop() : void
      {
         var overlay:Sprite = null;
         for each(var _loc4_ in this.var_8)
         {
            overlay = _loc4_;
            _loc4_;
            overlay.parent.removeChild(overlay);
         }
         this.stage3d.context3D.clear(0,0,0,1,1,0,4294967295);
         this.stage3d.context3D.present();
         this.resourceManager.clear();
         this.staticShadowRenderer.dispose();
      }
      
      override public function run() : void
      {
         var i:int = 0;
         var overlay:Sprite = null;
         var renderer:IRenderer = null;
         var effect:IGraphicEffect = null;
         if(this.stage3d == null || this.stage3d.context3D == null)
         {
            return;
         }
         for each(var _loc7_ in this.var_8)
         {
            overlay = _loc7_;
            _loc7_;
            overlay.graphics.clear();
         }
         for(i = 0; i < this.renderers.numRenderers; i++)
         {
            renderer = this.renderers.renderers[i];
            renderer.render();
         }
         if(this.var_13 != null && this.var_14)
         {
            this.var_13.update();
         }
         this.camera.calculateAxis();
         for(i = 0; i < this.var_10.numRenderers; i++)
         {
            renderer = this.var_10.renderers[i];
            renderer.render();
         }
         for(i = 0; i < this.numEffects; )
         {
            effect = this.effects[i];
            if(!effect.play(this.camera))
            {
               this.effects[i] = this.effects[--this.numEffects];
               this.effects[this.numEffects] = null;
               effect.destroy();
               i--;
            }
            i++;
         }
         if(this.axisIndicator.parent != null)
         {
            this.axisIndicator.update(this.camera);
         }
         this.camera.startTimer();
         this.var_9.update(this.rootContainer);
         this.camera.render(this.stage3d);
         this.camera.stopTimer();
      }
      
      public function initStaticShadow(mainDirectionalLight:DirectionalLight) : void
      {
         var staticShadowInitializer:StaticShadowInitializer = new StaticShadowInitializer(this.staticShadowRenderer,this.mapGeometryContainer,mainDirectionalLight);
         if(this.isContext3DAvailable())
         {
            staticShadowInitializer.execute(this.getContext3D());
         }
         else
         {
            this.var_11.push(staticShadowInitializer);
         }
      }
      
      private function isContext3DAvailable() : Boolean
      {
         return this.stage3d != null && this.stage3d.context3D != null;
      }
      
      private function createContainer(id:String) : Object3D
      {
         var container:Object3D = new Object3D();
         container.name = id;
         this.var_12[id] = container;
         this.rootContainer.addChild(container);
         return container;
      }
      
      private function onContext3DCreate(event:Event) : void
      {
         this.initContext(this.stage3d.context3D);
      }
      
      private function initContext(context3D:Context3D) : void
      {
         var deferredAction:IDeferredAction = null;
         context3D.enableErrorChecking = false;
         this.resourceManager.setContext(context3D);
         this.staticShadowRenderer.context = context3D;
         for each(var _loc5_ in this.var_11)
         {
            deferredAction = _loc5_;
            _loc5_;
            deferredAction.execute(this.stage3d);
         }
         this.var_11 = null;
      }
      
      private function onToggleDebugKey(eventType:KeyboardEventType, keyCode:uint) : void
      {
         switch(keyCode)
         {
            case Keyboard.F7:
            case Keyboard.F8:
            case Keyboard.TAB:
         }
      }
      
      private function addObject3DMarkers(objects:Vector.<Object3D>) : Vector.<TextMarker>
      {
         var object:Object3D = null;
         var textMarker:TextMarker = null;
         if(objects == null)
         {
            return new Vector.<TextMarker>();
         }
         var markers:Vector.<TextMarker> = new Vector.<TextMarker>(objects.length);
         for(var i:int = 0; i < objects.length; i++)
         {
            object = objects[i];
            textMarker = TextMarker(this.objectPoolManager.getObject(TextMarker));
            textMarker.init(this.getOverlay("markers"),object.name || "[none]",object);
            this.method_21(textMarker);
            markers[i] = textMarker;
         }
         return markers;
      }
      
      private function switchMapView() : void
      {
      }
      
      private function updateDebugMode() : void
      {
         this.camera.debug = this.var_17.flags != 0;
      }
      
      private function toggleLightDebug() : void
      {
      }
      
      private function toggleGraphicsDebug() : void
      {
      }
      
      public function hideView() : void
      {
         if(this.stage3d != null)
         {
            this.stage3d.context3D.clear(51 / 255,48 / 255,38 / 255);
            this.stage3d.context3D.present();
         }
      }
      
      public function showView() : void
      {
      }
   }
}

