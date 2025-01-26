package package_2
{
   import alternativa.engine3d.alternativa3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_109.name_377;
   import package_109.name_378;
   import package_109.name_381;
   import package_15.name_55;
   import package_18.name_44;
   import package_18.name_79;
   import package_18.name_89;
   import package_19.name_380;
   import package_19.name_53;
   import package_19.name_91;
   import package_21.name_116;
   import package_21.name_126;
   import package_21.name_77;
   import package_21.name_78;
   import package_22.name_83;
   import package_24.DirectionalLight;
   import package_24.OmniLight;
   import package_24.SpotLight;
   import package_24.name_376;
   import package_28.name_119;
   import package_28.name_241;
   import package_28.name_93;
   import package_4.class_4;
   import package_4.class_5;
   import package_4.name_313;
   import package_44.name_178;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_5.name_3;
   import package_6.name_4;
   import package_76.name_235;
   import package_96.name_279;
   
   use namespace alternativa3d;
   
   public class A3DMapComponent extends EntityComponent
   {
      public static const PHYSICS_GEOMETRY:String = "physicsGeometry";
      
      private var files:name_55;
      
      private var skyboxFiles:name_55;
      
      private var skyboxSize:Number;
      
      private var var_89:A3DMapBuilder;
      
      private var gameKernel:GameKernel;
      
      private var var_90:Number = 1.5;
      
      private var listener:class_2;
      
      private var var_91:Boolean = true;
      
      public function A3DMapComponent(files:name_55, skyboxFiles:name_55, skyboxSize:Number, listener:class_2)
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
         this.method_205();
         gameKernel.name_66().name_94(name_83.KEY_DOWN,this.method_15);
         if(gameKernel.options[name_379.FAKE_MAP] != null)
         {
            this.method_204();
         }
         else
         {
            this.method_202();
         }
      }
      
      private function method_205() : void
      {
         var skyBox:name_53 = null;
         var surfaceIds:Array = null;
         var surfaceId:String = null;
         var renderSystem:name_44 = null;
         var container:name_78 = null;
         var texture:ByteArray = null;
         var textureResource:name_241 = null;
         if(this.skyboxFiles != null)
         {
            skyBox = new name_53(this.skyboxSize);
            surfaceIds = [name_53.BACK,name_53.BOTTOM,name_53.FRONT,name_53.LEFT,name_53.RIGHT,name_53.TOP];
            for each(surfaceId in surfaceIds)
            {
               texture = this.skyboxFiles.name_248(surfaceId);
               textureResource = new name_241(texture);
               skyBox.name_383(surfaceId).material = new name_79(textureResource);
            }
            renderSystem = this.gameKernel.name_5();
            renderSystem.method_32(skyBox.getResources(true));
            container = renderSystem.method_40(name_44.SKYBOX_CONTAINER_ID);
            container.addChild(skyBox);
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         var object:name_78 = null;
         var lights:name_89 = null;
         var light:name_116 = null;
         var renderSystem:name_44 = gameKernel.name_5();
         var mapGeometryContainer:name_78 = renderSystem.method_68();
         for each(object in this.var_89.objects)
         {
            mapGeometryContainer.removeChild(object);
         }
         renderSystem.method_31(mapGeometryContainer.getResources(true));
         lights = renderSystem.lights;
         for each(light in this.var_89.lights)
         {
            if(light is DirectionalLight)
            {
               lights.directionalLigths.remove(DirectionalLight(light));
            }
            else if(light is name_376)
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
         gameKernel.name_66().name_384(name_83.KEY_DOWN,this.method_15);
         this.gameKernel = null;
      }
      
      private function method_202() : void
      {
         this.var_89 = new A3DMapBuilder();
         this.var_89.addEventListener(Event.COMPLETE,this.method_200);
         this.var_89.name_385(this.files);
      }
      
      private function method_200(event:Event) : void
      {
         var staticShadowLight:DirectionalLight = this.method_207();
         this.method_206(staticShadowLight);
         this.method_208();
         this.complete();
      }
      
      private function complete() : void
      {
         this.gameKernel.name_5().method_58();
         if(this.listener != null)
         {
            this.listener.onA3DMapComplete();
         }
      }
      
      private function method_207() : DirectionalLight
      {
         var staticShadowLight:DirectionalLight = null;
         var light:name_116 = null;
         if(Boolean(this.gameKernel.options["fakelight"]))
         {
            this.method_210();
            return null;
         }
         var renderSystem:name_44 = this.gameKernel.name_5();
         var lights:name_89 = renderSystem.lights;
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
            else if(light is name_376)
            {
               lights.ambientLight = name_376(light);
            }
            else if(light is SpotLight)
            {
               lights.spotLights.add(SpotLight(light));
            }
            else if(light is OmniLight)
            {
               lights.omniLigths.add(OmniLight(light));
            }
            if(light is name_376 || light is DirectionalLight)
            {
               light.intensity *= 2;
            }
            if(light is DirectionalLight || light is name_376)
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
      
      private function method_210() : void
      {
         this.gameKernel.name_5().lights.ambientLight = new name_376(16777215);
      }
      
      private function method_206(staticShadowLight:DirectionalLight) : void
      {
         var object:name_78 = null;
         var renderSystem:name_44 = this.gameKernel.name_5();
         var mapGeometryContainer:name_78 = renderSystem.method_68();
         for each(object in this.var_89.objects)
         {
            mapGeometryContainer.addChild(object);
         }
         renderSystem.method_32(mapGeometryContainer.getResources(true));
         if(staticShadowLight != null)
         {
            renderSystem.method_71(staticShadowLight);
         }
      }
      
      private function method_208() : void
      {
         var renderSystem:name_44 = null;
         var physicsContainer:name_78 = null;
         var physicsSystem:name_178 = this.gameKernel.method_112();
         physicsSystem.name_382(this.var_89.collisionPrimitives);
         if(this.gameKernel.options[name_379.VISUALIZE_PHYSICS] != null)
         {
            renderSystem = this.gameKernel.name_5();
            physicsContainer = this.method_199(this.var_89.collisionPrimitives);
            physicsContainer.visible = false;
            renderSystem.method_47(PHYSICS_GEOMETRY,physicsContainer,true);
         }
      }
      
      private function method_199(collisionPrimitives:Vector.<name_235>) : name_78
      {
         var collisionPrimitive:name_235 = null;
         var physicsVisualContainer:name_78 = new name_78();
         var boxMaterial:name_313 = new name_313(11141120);
         var triangleMaterial:name_313 = new name_313(43520);
         var numCollisionPrimitives:int = int(collisionPrimitives.length);
         for(var i:int = 0; i < numCollisionPrimitives; )
         {
            collisionPrimitive = collisionPrimitives[i];
            if(collisionPrimitive is name_377)
            {
               physicsVisualContainer.addChild(this.method_211(name_377(collisionPrimitive),boxMaterial));
            }
            else if(collisionPrimitive is name_378)
            {
               physicsVisualContainer.addChild(this.method_209(name_378(collisionPrimitive),triangleMaterial));
            }
            i++;
         }
         return physicsVisualContainer;
      }
      
      private function method_211(collisionBox:name_377, material:class_4) : name_279
      {
         var size:name_194 = collisionBox.hs.clone().scale(2);
         var box:name_279 = new name_279(size.x,size.y,size.z);
         box.setMaterialToAllSurfaces(material);
         this.method_198(collisionBox,box);
         return box;
      }
      
      private function method_209(collisionTriangle:name_378, material:class_4) : name_380
      {
         var mesh:name_380 = new name_380();
         var geometry:name_119 = new name_119();
         var attributes:Array = [];
         attributes[0] = name_126.POSITION;
         attributes[1] = name_126.POSITION;
         attributes[2] = name_126.POSITION;
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
         geometry.setAttributeValues(name_126.POSITION,values);
         geometry.indices = Vector.<uint>([0,1,2]);
         mesh.geometry = geometry;
         mesh.addSurface(material,0,1);
         mesh.calculateBoundBox();
         this.method_198(collisionTriangle,mesh);
         return mesh;
      }
      
      private function method_198(collisionPrimitive:name_235, object:name_78) : void
      {
         var t:Matrix4 = collisionPrimitive.transform;
         var eulerAngles:name_194 = new name_194();
         t.name_341(eulerAngles);
         object.x = t.d;
         object.y = t.h;
         object.z = t.l;
         object.rotationX = eulerAngles.x;
         object.rotationY = eulerAngles.y;
         object.rotationZ = eulerAngles.z;
      }
      
      private function method_204() : void
      {
         var collisionRect:name_381 = new name_381(new name_194(20000,20000),1,255);
         var collisionPrimitives:Vector.<name_235> = Vector.<name_235>([collisionRect]);
         this.gameKernel.method_112().name_382(collisionPrimitives);
         var renderSystem:name_44 = this.gameKernel.name_5();
         renderSystem.method_40(name_44.LIGHTS_CONTAINER_ID).addChild(new name_376(16777215));
         this.method_201(renderSystem);
         var bitmapData:BitmapData = new BitmapData(512,512);
         bitmapData.perlinNoise(10,10,3,13,false,true);
         var bitmapTextureResource:name_93 = new name_93(bitmapData);
         var box:name_279 = new name_279(2 * 20000,2 * 20000,10);
         box.setMaterialToAllSurfaces(new class_5(bitmapTextureResource));
         box.z = -5;
         renderSystem.method_68().addChild(box);
         renderSystem.method_32(box.getResources());
         setTimeout(this.complete,0);
      }
      
      private function method_201(renderSystem:name_44) : void
      {
         var resource:name_77 = null;
         var box:name_279 = new name_279(50,50,50);
         box.setMaterialToAllSurfaces(new name_313(11141120));
         for each(resource in box.getResources())
         {
            renderSystem.method_29(resource);
         }
         renderSystem.method_68().addChild(box);
      }
      
      private function method_15(eventType:name_83, keyCode:uint) : void
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
      
      private function method_213() : void
      {
         var d:name_91 = null;
         this.var_91 = !this.var_91;
         for each(d in this.var_89.decals)
         {
            d.visible = this.var_91;
         }
      }
      
      private function get method_203() : Number
      {
         return this.var_90;
      }
      
      private function set method_203(value:Number) : void
      {
         var decal:name_91 = null;
         this.var_90 = value;
         for each(decal in this.var_89.decals)
         {
            decal.offset = this.var_90;
         }
         name_4(name_3.name_8().name_30(name_4)).name_145("Decals offset: " + this.var_90);
      }
      
      private function method_212(containerId:String) : void
      {
         var container:name_78 = this.gameKernel.name_5().method_40(containerId);
         if(container != null)
         {
            container.visible = !container.visible;
         }
      }
   }
}

