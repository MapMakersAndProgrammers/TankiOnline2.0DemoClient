package package_18
{
   import alternativa.engine3d.alternativa3d;
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
   import alternativa.tanks.game.GameTask;
   import package_19.name_91;
   import package_2.name_9;
   import package_21.name_77;
   import package_21.name_78;
   import package_21.name_81;
   import package_22.name_83;
   import package_22.name_87;
   import package_23.name_103;
   import package_23.name_92;
   import package_23.name_97;
   import package_24.DirectionalLight;
   import package_25.name_113;
   import package_25.name_98;
   import package_26.name_100;
   import package_27.name_95;
   import package_28.name_93;
   import package_29.MouseEvent3D;
   import package_3.TankMaterial2;
   import package_3.name_10;
   import package_3.name_29;
   import package_3.name_33;
   import package_3.name_7;
   import package_9.name_23;
   
   use namespace alternativa3d;
   
   public class name_44 extends GameTask implements class_3
   {
      public static const SKYBOX_CONTAINER_ID:String = "skyboxContainer";
      
      public static const MAP_GEOMETRY_CONTAINER_ID:String = "mapGeometryContainer";
      
      public static const LIGHTS_CONTAINER_ID:String = "lightsContainer";
      
      public static const DYNAMIC_OBJECTS_CONTAINER_ID:String = "dynamicObjectsContainer";
      
      public static const EFFECTS_CONTAINER_ID:String = "effectsContainer";
      
      private static const BIT_DEBUG_GEOMETRY:int = 1;
      
      private static const BIT_DEBUG_LIGHTS:int = 1 << 1;
      
      private var rootContainer:name_78;
      
      private var skyboxContainer:name_78;
      
      private var mapGeometryContainer:name_78;
      
      private var lightsContainer:name_78;
      
      private var dynamicObjectsContainer:name_78;
      
      private var effectsContainer:name_78;
      
      private var var_12:Object = {};
      
      private var view:name_81;
      
      private var camera:name_90;
      
      private var var_13:name_102;
      
      private var axisIndicator:name_23;
      
      private var renderers:name_86;
      
      private var var_11:name_86;
      
      private var effects:Vector.<name_85>;
      
      private var numEffects:int;
      
      private var var_14:Boolean = true;
      
      private var var_8:Object = {};
      
      private var var_16:name_89;
      
      private var var_20:Boolean;
      
      private var var_18:Boolean;
      
      private var objectPoolManager:name_100 = new name_100();
      
      private var var_19:Vector.<name_80>;
      
      private var var_17:name_95 = new name_95();
      
      private var stage:Stage;
      
      private var stage3d:Stage3D;
      
      private var resourceManager:name_101;
      
      private var var_9:name_92;
      
      private var staticShadowRenderer:name_97;
      
      private var var_10:Vector.<name_88>;
      
      private var var_7:Vector.<name_84>;
      
      private var var_15:Boolean;
      
      private var var_6:name_93;
      
      private var var_5:name_98;
      
      public function name_44(priority:int, stage:Stage)
      {
         super(priority);
         this.stage = stage;
         this.renderers = new name_86();
         this.var_11 = new name_86();
         this.effects = new Vector.<name_85>();
         this.rootContainer = new name_78();
         this.rootContainer.name = "root";
         this.skyboxContainer = this.method_34(SKYBOX_CONTAINER_ID);
         this.mapGeometryContainer = this.method_34(MAP_GEOMETRY_CONTAINER_ID);
         this.lightsContainer = this.method_34(LIGHTS_CONTAINER_ID);
         this.dynamicObjectsContainer = this.method_34(DYNAMIC_OBJECTS_CONTAINER_ID);
         this.effectsContainer = this.method_34(EFFECTS_CONTAINER_ID);
         this.var_16 = new name_89(this.lightsContainer);
         this.view = new name_81(100,100,false,6710886,1,4);
         this.view.name_106();
         this.camera = new name_90(10,50000);
         this.camera.nearClipping = 1;
         this.camera.view = this.view;
         this.rootContainer.addChild(this.camera);
         var giLight:DirectionalLight = new DirectionalLight(9222892);
         giLight.intensity = 0.5;
         giLight.rotationX = Math.PI;
         this.var_5 = new name_98();
         this.var_5.gravity = new Vector3D(0,0,-1);
         this.var_5.wind = new Vector3D(1,0,0);
         this.rootContainer.addChild(this.var_5);
         this.axisIndicator = new name_23(100);
         this.resourceManager = new name_101();
         this.var_9 = new name_92();
         this.staticShadowRenderer = new name_97(null,1024,4);
         this.var_10 = new Vector.<name_88>();
         this.rootContainer.addEventListener(MouseEvent3D.CLICK,this.onClick);
      }
      
      private function onClick(e:MouseEvent3D) : void
      {
         if(e.target is name_91)
         {
            trace(e.target,e.target.name,name_91(e.target).offset,e.target.scaleX,e.target.scaleY,e.target.scaleZ);
         }
         else
         {
            trace(e.target,e.target.name);
         }
      }
      
      public function get lights() : name_89
      {
         return this.var_16;
      }
      
      public function name_41(mode:int) : void
      {
         name_9.fogMode = mode;
         name_7.fogMode = mode;
         TankMaterial2.fogMode = mode;
         name_33.fogMode = mode;
         name_10.fogMode = mode;
         name_79.fogMode = mode;
         name_29.fogMode = mode;
         if(mode == 1)
         {
            this.var_5.fogFar = name_9.fogFar;
         }
         else
         {
            this.var_5.fogFar = 0;
         }
      }
      
      public function name_47(value:Number) : void
      {
         name_9.fogNear = value;
         name_7.fogNear = value;
         TankMaterial2.fogNear = value;
         name_33.fogNear = value;
         name_10.fogNear = value;
         name_29.fogNear = value;
         this.var_5.fogNear = value;
      }
      
      public function name_48(value:Number) : void
      {
         name_9.fogFar = value;
         name_7.fogFar = value;
         TankMaterial2.fogFar = value;
         name_33.fogFar = value;
         name_10.fogFar = value;
         name_29.fogFar = value;
         this.var_5.fogFar = value;
      }
      
      public function name_49(value:Number) : void
      {
         name_9.fogMaxDensity = value;
         name_7.fogMaxDensity = value;
         TankMaterial2.fogMaxDensity = value;
         name_33.fogMaxDensity = value;
         name_10.fogMaxDensity = value;
         name_79.fogMaxDensity = value;
         name_29.fogMaxDensity = value;
         this.var_5.fogMaxDensity = value;
      }
      
      public function name_40(color:uint) : void
      {
         var r:Number = (color >> 16 & 0xFF) / 255;
         var g:Number = (color >> 8 & 0xFF) / 255;
         var b:Number = (color & 0xFF) / 255;
         name_9.fogColorR = r;
         name_9.fogColorG = g;
         name_9.fogColorB = b;
         name_7.fogColorR = r;
         name_7.fogColorG = g;
         name_7.fogColorB = b;
         TankMaterial2.fogColorR = r;
         TankMaterial2.fogColorG = g;
         TankMaterial2.fogColorB = b;
         name_33.fogColorR = r;
         name_33.fogColorG = g;
         name_33.fogColorB = b;
         name_10.fogColorR = r;
         name_10.fogColorG = g;
         name_10.fogColorB = b;
         name_79.fogColorR = r;
         name_79.fogColorG = g;
         name_79.fogColorB = b;
         name_29.fogColorR = r;
         name_29.fogColorG = g;
         name_29.fogColorB = b;
         this.var_5.name_107 = color;
      }
      
      public function name_38(value:Number) : void
      {
         name_79.fogHeight = value;
      }
      
      public function name_34(value:Number) : void
      {
         name_79.fogOffset = value;
      }
      
      public function name_36(textureParams:String) : void
      {
         var fogBitmap:BitmapData = name_104.name_109(textureParams,128);
         var fogInitializator:name_99 = new name_99(fogBitmap,this);
         if(this.method_35())
         {
            fogInitializator.execute(this.stage3d);
         }
         else
         {
            this.var_10.push(fogInitializator);
         }
      }
      
      public function method_33(bitmapData:BitmapData) : void
      {
         if(!this.method_35())
         {
            throw new Error("Context3D is not available. Use setFogTextureParams() instead.");
         }
         if(this.var_6 != null)
         {
            this.method_28(this.var_6);
         }
         this.var_6 = new name_93(bitmapData);
         this.method_29(this.var_6);
         name_9.method_33(this.var_6);
         name_7.method_33(this.var_6);
         TankMaterial2.method_33(this.var_6);
         name_29.method_33(this.var_6);
         name_33.method_33(this.var_6);
         name_10.method_33(this.var_6);
         name_79.method_33(this.var_6);
      }
      
      public function method_57() : Boolean
      {
         return this.var_15;
      }
      
      public function method_58() : void
      {
         var shadowRendererConstructor:name_84 = null;
         this.var_15 = true;
         if(this.var_7 != null)
         {
            for each(shadowRendererConstructor in this.var_7)
            {
               shadowRendererConstructor.name_111();
            }
            this.var_7 = null;
         }
      }
      
      public function method_59(shadowRendererConstructor:name_84) : void
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
            this.var_7 = new Vector.<name_84>();
         }
         var index:int = int(this.var_7.indexOf(shadowRendererConstructor));
         if(index < 0)
         {
            this.var_7.push(shadowRendererConstructor);
         }
      }
      
      public function method_49(shadowRendererConstructor:name_84) : void
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
      
      public function method_55() : name_92
      {
         return this.var_9;
      }
      
      public function method_54(value:int) : void
      {
         this.view.antiAlias = value;
      }
      
      public function method_72() : int
      {
         return this.view.antiAlias;
      }
      
      public function method_70(renderer:name_103) : void
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
      
      public function method_65(renderer:name_103) : void
      {
         var index:int = int(this.var_9.renderers.indexOf(renderer));
         if(index >= 0)
         {
            this.var_9.renderers.splice(index,1);
         }
      }
      
      public function name_37(stage3d:Stage3D) : void
      {
         this.stage3d = stage3d;
         this.method_38(stage3d.context3D);
      }
      
      public function requestContext3D() : void
      {
         this.stage3d = this.stage.stage3Ds[0];
         this.stage3d.addEventListener(Event.CONTEXT3D_CREATE,this.method_39);
         this.stage3d.requestContext3D(Context3DRenderMode.AUTO);
      }
      
      public function method_29(resource:name_77) : void
      {
         this.resourceManager.method_29(resource);
      }
      
      public function method_32(resources:Vector.<name_77>) : void
      {
         this.resourceManager.method_32(resources);
      }
      
      public function method_28(resource:name_77) : void
      {
         this.resourceManager.method_28(resource);
      }
      
      public function method_31(resources:Vector.<name_77>) : void
      {
         this.resourceManager.method_31(resources);
      }
      
      public function clear() : void
      {
      }
      
      public function method_62() : name_78
      {
         return this.rootContainer;
      }
      
      public function method_68() : name_78
      {
         return this.mapGeometryContainer;
      }
      
      public function method_46() : name_78
      {
         return this.dynamicObjectsContainer;
      }
      
      public function method_60() : name_78
      {
         return this.effectsContainer;
      }
      
      public function method_40(containerId:String) : name_78
      {
         return this.var_12[containerId];
      }
      
      public function method_30(resource:name_77) : void
      {
         this.resourceManager.method_30(resource);
      }
      
      public function method_47(containerId:String, container:name_78, uploadResources:Boolean) : void
      {
         if(this.method_40(containerId) != null)
         {
            throw new Error("Container with id \"" + containerId + "\" already exists");
         }
         this.var_12[containerId] = container;
         this.rootContainer.addChild(container);
         if(uploadResources)
         {
            this.resourceManager.method_32(container.getResources(true));
         }
      }
      
      public function name_42() : name_23
      {
         return this.axisIndicator;
      }
      
      public function method_41(name:String) : Sprite
      {
         var view:name_81 = null;
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
      
      public function method_51(name:String) : void
      {
         var overlay:Sprite = this.var_8[name];
         if(overlay != null)
         {
            delete this.var_8[name];
            overlay.parent.removeChild(overlay);
         }
      }
      
      public function addObject(object:name_78) : void
      {
         this.rootContainer.addChild(object);
         this.resourceManager.method_32(object.getResources());
      }
      
      public function name_71() : name_81
      {
         return this.view;
      }
      
      public function name_39() : DisplayObject
      {
         return this.camera.diagram;
      }
      
      public function method_43(objects:Vector.<name_78>) : void
      {
         var object3D:name_78 = null;
         for each(object3D in objects)
         {
         }
      }
      
      public function method_63(renderer:name_82) : void
      {
         this.renderers.add(renderer);
      }
      
      public function method_64(renderer:name_82) : void
      {
         this.renderers.remove(renderer);
      }
      
      public function method_56(renderer:name_82) : void
      {
         this.var_11.add(renderer);
      }
      
      public function method_53(renderer:name_82) : void
      {
         this.var_11.remove(renderer);
      }
      
      public function method_37(effect:name_85) : void
      {
         if(this.effects.indexOf(effect) >= 0)
         {
            throw new Error("Effect " + effect + " already exists");
         }
         var _loc2_:* = this.numEffects++;
         this.effects[_loc2_] = effect;
         effect.addedToRenderSystem(this);
      }
      
      public function method_48(effect:name_113) : void
      {
         this.var_5.method_37(effect);
      }
      
      public function name_63(controller:name_102) : void
      {
         if(this.var_13 == controller)
         {
            return;
         }
         this.var_13 = controller;
         controller.name_108();
      }
      
      public function name_27() : name_90
      {
         return this.camera;
      }
      
      public function method_45() : void
      {
         this.var_14 = false;
         false;
      }
      
      public function method_69() : void
      {
         this.var_14 = true;
         true;
      }
      
      public function name_46(x:int, y:int, width:int, height:int) : void
      {
         var overlay:Sprite = null;
         var view:name_81 = this.camera.view;
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
      
      public function method_42() : Context3D
      {
         return this.stage3d.context3D;
      }
      
      override public function start() : void
      {
         var input:name_87 = name_87(var_4.getTaskInterface(name_87));
         input.name_94(name_83.KEY_DOWN,this.method_36,Keyboard.F7);
         input.name_94(name_83.KEY_DOWN,this.method_36,Keyboard.F8);
         input.name_94(name_83.KEY_DOWN,this.method_36,Keyboard.TAB);
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
         var renderer:name_82 = null;
         var effect:name_85 = null;
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
         this.camera.name_112();
         for(i = 0; i < this.var_11.numRenderers; i++)
         {
            renderer = this.var_11.renderers[i];
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
      
      public function method_71(mainDirectionalLight:DirectionalLight) : void
      {
         var staticShadowInitializer:name_96 = new name_96(this.staticShadowRenderer,this.mapGeometryContainer,mainDirectionalLight);
         if(this.method_35())
         {
            staticShadowInitializer.execute(this.method_42());
         }
         else
         {
            this.var_10.push(staticShadowInitializer);
         }
      }
      
      private function method_35() : Boolean
      {
         return this.stage3d != null && this.stage3d.context3D != null;
      }
      
      private function method_34(id:String) : name_78
      {
         var container:name_78 = new name_78();
         container.name = id;
         this.var_12[id] = container;
         this.rootContainer.addChild(container);
         return container;
      }
      
      private function method_39(event:Event) : void
      {
         this.method_38(this.stage3d.context3D);
      }
      
      private function method_38(context3D:Context3D) : void
      {
         var deferredAction:name_88 = null;
         context3D.enableErrorChecking = false;
         this.resourceManager.name_105(context3D);
         this.staticShadowRenderer.context = context3D;
         for each(var _loc5_ in this.var_10)
         {
            deferredAction = _loc5_;
            _loc5_;
            deferredAction.execute(this.stage3d);
         }
         this.var_10 = null;
      }
      
      private function method_36(eventType:name_83, keyCode:uint) : void
      {
         switch(keyCode)
         {
            case Keyboard.F7:
            case Keyboard.F8:
            case Keyboard.TAB:
         }
      }
      
      private function addObject3DMarkers(objects:Vector.<name_78>) : Vector.<name_80>
      {
         var object:name_78 = null;
         var textMarker:name_80 = null;
         if(objects == null)
         {
            return new Vector.<name_80>();
         }
         var markers:Vector.<name_80> = new Vector.<name_80>(objects.length);
         for(var i:int = 0; i < objects.length; i++)
         {
            object = objects[i];
            textMarker = name_80(this.objectPoolManager.name_110(name_80));
            textMarker.init(this.method_41("markers"),object.name || "[none]",object);
            this.method_37(textMarker);
            markers[i] = textMarker;
         }
         return markers;
      }
      
      private function method_67() : void
      {
      }
      
      private function method_61() : void
      {
         this.camera.debug = this.var_17.flags != 0;
      }
      
      private function method_50() : void
      {
      }
      
      private function method_44() : void
      {
      }
      
      public function method_66() : void
      {
         if(this.stage3d != null)
         {
            this.stage3d.context3D.clear(51 / 255,48 / 255,38 / 255);
            this.stage3d.context3D.present();
         }
      }
      
      public function method_52() : void
      {
      }
   }
}

