package package_84
{
   import alternativa.engine3d.alternativa3d;
   import flash.geom.Point;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_18.name_44;
   import package_19.name_380;
   import package_19.name_528;
   import package_19.name_91;
   import package_21.name_126;
   import package_21.name_78;
   import package_23.name_208;
   import package_29.MouseEvent3D;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import package_4.class_5;
   import package_45.name_182;
   import package_46.Matrix4;
   import package_46.name_194;
   import package_71.*;
   import package_77.name_237;
   import package_85.class_22;
   import package_85.class_31;
   import package_85.name_314;
   import package_85.name_481;
   import package_85.name_596;
   
   use namespace alternativa3d;
   
   public class name_253 extends EntityComponent implements class_22, class_31
   {
      public static const TANK_CLICK:String = "tankClick";
      
      private static var hullMatrix:Matrix4 = new Matrix4();
      
      private static var eulerAngles:name_194 = new name_194();
      
      private var shadow:name_91;
      
      private var hull:name_249;
      
      private var var_488:name_380;
      
      private var hullMaterials:name_277;
      
      private var container:name_78;
      
      private var physicsComponent:name_237;
      
      private var gameKernel:GameKernel;
      
      private var var_233:class_5;
      
      private var name_325:Vector.<name_380>;
      
      private var name_323:Vector.<name_380>;
      
      private var name_337:name_528;
      
      private var name_340:name_528;
      
      private var var_489:name_595;
      
      private var var_490:name_595;
      
      private var shadowRenderer:name_208;
      
      private var var_491:name_596;
      
      public function name_253(hull:name_249)
      {
         super();
         this.method_488(hull);
      }
      
      public function name_351() : name_249
      {
         return this.hull;
      }
      
      public function name_342(tracksMaterial:TracksMaterial2) : void
      {
         this.var_489.material = TracksMaterial2(tracksMaterial.clone());
         this.name_337.setMaterialToAllSurfaces(this.var_489.material);
         this.var_490.material = TracksMaterial2(tracksMaterial.clone());
         this.name_340.setMaterialToAllSurfaces(this.var_490.material);
      }
      
      public function name_344(material:GiShadowMaterial) : void
      {
         if(this.shadow != null)
         {
            this.shadow.setMaterialToAllSurfaces(material);
         }
      }
      
      public function name_329() : name_78
      {
         return this.var_488;
      }
      
      public function method_496(shadowRenderer:name_208) : void
      {
         this.shadowRenderer = shadowRenderer;
         this.var_491 = null;
         if(this.container != null)
         {
            this.gameKernel.name_5().method_70(shadowRenderer);
         }
      }
      
      public function method_488(newHull:name_249) : void
      {
         var dUdY:Number = NaN;
         if(this.hull == newHull)
         {
            return;
         }
         if(this.hull != null && this.container != null)
         {
            this.container.removeChild(this.var_488);
         }
         this.hull = newHull;
         if(this.hull != null)
         {
            this.var_488 = new name_380();
            this.var_488.geometry = this.hull.geometry;
            this.var_488.addSurface(this.var_233,0,this.hull.geometry.numTriangles);
            this.var_488.calculateBoundBox();
            this.name_325 = this.method_499(this.var_488,this.hull.name_325);
            this.name_323 = this.method_499(this.var_488,this.hull.name_323);
            this.name_337 = this.method_497(this.hull.name_337,this.var_488);
            this.name_340 = this.method_497(this.hull.name_340,this.var_488);
            dUdY = this.method_504(this.name_337);
            this.var_489 = new name_595(this.name_337,this.name_325,dUdY);
            this.var_490 = new name_595(this.name_340,this.name_323,dUdY);
            if(this.hull.shadow != null)
            {
               this.shadow = new name_91(100);
               this.shadow.geometry = this.hull.shadow.geometry;
               this.shadow.matrix = this.hull.shadow.matrix;
               this.shadow.addSurface(null,0,this.shadow.geometry.numTriangles);
               this.shadow.useShadow = false;
               this.name_482.addChild(this.shadow);
            }
            if(this.container != null)
            {
               this.container.addChild(this.var_488);
            }
         }
      }
      
      private function method_504(mesh:name_380) : Number
      {
         var j:int = 0;
         var vertexIndex:int = 0;
         var vertexBaseIndex:uint = 0;
         var v:name_194 = null;
         var uv:Point = null;
         var ratio:Number = 0;
         var indices:Vector.<uint> = mesh.geometry.indices;
         var vertexCoordinates:Vector.<Number> = mesh.geometry.method_275(name_126.POSITION);
         var uvs:Vector.<Number> = mesh.geometry.method_275(name_126.TEXCOORDS[0]);
         var faceVertices:Vector.<name_194> = Vector.<name_194>([new name_194(),new name_194(),new name_194()]);
         var faceUVs:Vector.<Point> = Vector.<Point>([new Point(),new Point(),new Point()]);
         for(var i:int = 0; i < indices.length; i += 3)
         {
            for(j = 0; j < 3; j++)
            {
               vertexIndex = int(indices[i + j]);
               vertexBaseIndex = uint(3 * vertexIndex);
               v = faceVertices[j];
               v.x = vertexCoordinates[vertexBaseIndex];
               v.y = vertexCoordinates[vertexBaseIndex + 1];
               v.z = vertexCoordinates[vertexBaseIndex + 2];
               v.scale(mesh.scaleX);
               uv = faceUVs[j];
               uv.x = uvs[2 * vertexIndex];
               uv.y = uvs[2 * vertexIndex + 1];
            }
            ratio = this.method_500(faceVertices,faceUVs,ratio);
         }
         return ratio;
      }
      
      private function method_500(faceVertices:Vector.<name_194>, faceUVs:Vector.<Point>, ratio:Number) : Number
      {
         var v2:name_194 = null;
         var p2:Point = null;
         var dy:Number = NaN;
         var dv:Number = NaN;
         var newRatio:Number = NaN;
         var v1:name_194 = faceVertices[2];
         var p1:Point = faceUVs[2];
         for(var i:int = 0; i < 3; i++)
         {
            v2 = faceVertices[i];
            p2 = faceUVs[i];
            dy = Number(Math.abs(v2.y - v1.y));
            dv = Number(Math.abs(p2.y - p1.y));
            if(dy > 100)
            {
               newRatio = dv / dy;
               if(newRatio > ratio)
               {
                  ratio = newRatio;
               }
            }
            v1 = v2;
            p1 = p2;
         }
         return ratio;
      }
      
      private function method_497(tankTrack:name_528, container:name_380) : name_528
      {
         var skin:name_528 = name_528(tankTrack.clone());
         skin.calculateBoundBox();
         container.addChild(skin);
         return skin;
      }
      
      private function method_499(container:name_78, wheels:Vector.<name_318>) : Vector.<name_380>
      {
         var tankWheel:name_318 = null;
         var wheelMesh:name_380 = null;
         var position:name_194 = null;
         var numWheels:int = int(wheels.length);
         var wheelMeshes:Vector.<name_380> = new Vector.<name_380>(numWheels);
         for(var i:int = 0; i < numWheels; i++)
         {
            tankWheel = wheels[i];
            wheelMesh = new name_380();
            wheelMesh.name = tankWheel.name;
            wheelMesh.geometry = tankWheel.geometry;
            wheelMesh.addSurface(this.var_233,0,wheelMesh.geometry.numTriangles);
            wheelMesh.calculateBoundBox();
            position = tankWheel.position;
            wheelMesh.x = position.x;
            wheelMesh.y = position.y;
            wheelMesh.z = position.z;
            wheelMesh.rotationX = Math.random() * Math.PI * 2;
            container.addChild(wheelMesh);
            wheelMeshes[i] = wheelMesh;
         }
         return wheelMeshes;
      }
      
      public function name_343(hullMaterials:name_277) : void
      {
         this.hullMaterials = hullMaterials;
      }
      
      public function get visible() : Boolean
      {
         return this.var_488.visible;
      }
      
      public function addToScene() : void
      {
         var renderSystem:name_44 = null;
         if(this.container == null)
         {
            renderSystem = this.gameKernel.name_5();
            this.container = renderSystem.method_46();
            if(this.var_488 != null)
            {
               this.container.addChild(this.var_488);
               if(this.shadowRenderer != null)
               {
                  renderSystem.method_70(this.shadowRenderer);
               }
            }
            this.method_501();
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.container != null)
         {
            if(this.var_488 != null)
            {
               this.container.removeChild(this.var_488);
               if(this.shadowRenderer != null)
               {
                  this.gameKernel.name_5().method_65(this.shadowRenderer);
               }
            }
            this.container = null;
         }
         this.method_503();
      }
      
      public function get name_482() : name_380
      {
         return this.var_488;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = name_237(entity.getComponentStrict(name_237));
         name_314(entity.getComponentStrict(name_314)).name_60(this);
         this.var_489.physicsComponent = this.physicsComponent;
         this.var_490.physicsComponent = this.physicsComponent;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var renderSystem:name_44 = gameKernel.name_5();
         this.var_491 = new name_596(this.var_488,renderSystem,this);
         if(renderSystem.method_57())
         {
            this.var_491.name_111();
            this.var_491 = null;
         }
         else
         {
            renderSystem.method_59(this.var_491);
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         if(this.var_491 != null)
         {
            gameKernel.name_5().method_49(this.var_491);
            this.var_491 = null;
         }
         this.removeFromScene();
         gameKernel = null;
      }
      
      public function render() : void
      {
         if(this.hull == null)
         {
            return;
         }
         hullMatrix.method_347();
         hullMatrix.name_201(this.hull.name_538);
         hullMatrix.append(this.physicsComponent.var_483);
         hullMatrix.name_341(eulerAngles);
         this.var_488.x = hullMatrix.d;
         this.var_488.y = hullMatrix.h;
         this.var_488.z = hullMatrix.l;
         this.var_488.rotationX = eulerAngles.x;
         this.var_488.rotationY = eulerAngles.y;
         this.var_488.rotationZ = eulerAngles.z;
         this.method_502();
      }
      
      private function method_502() : void
      {
         var dt:Number = NaN;
         if(this.var_489 != null)
         {
            dt = name_182.timeDeltaSeconds;
            this.var_489.name_598(this.hull.name_597,this.physicsComponent.method_492(),dt);
            this.var_490.name_598(this.hull.name_597,this.physicsComponent.method_495(),dt);
         }
      }
      
      public function setMaterial(materialType:name_481) : void
      {
         switch(materialType)
         {
            case name_481.DEAD:
               this.hullMaterials.deadMaterial.alpha = 1;
               this.var_489.material.alpha = 1;
               this.var_490.material.alpha = 1;
               this.var_488.setMaterialToAllSurfaces(this.hullMaterials.deadMaterial);
               this.var_233 = this.hullMaterials.deadMaterial;
               break;
            case name_481.NORMAL:
               this.hullMaterials.normalMaterial.alpha = 1;
               this.var_489.material.alpha = 1;
               this.var_490.material.alpha = 1;
               this.var_488.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.var_233 = this.hullMaterials.normalMaterial;
               break;
            case name_481.ACTIVATING:
               this.hullMaterials.normalMaterial.alpha = 0.5;
               this.var_489.material.alpha = 0.5;
               this.var_490.material.alpha = 0.5;
               this.var_488.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.var_233 = this.hullMaterials.normalMaterial;
         }
         var numWheels:int = int(this.name_325.length);
         for(var i:int = 0; i < numWheels; i++)
         {
            this.name_325[i].setMaterialToAllSurfaces(this.var_233);
            this.name_323[i].setMaterialToAllSurfaces(this.var_233);
         }
      }
      
      public function method_342(value:Number) : void
      {
         this.var_233.alpha = value;
         this.var_489.material.alpha = value;
         this.var_490.material.alpha = value;
      }
      
      private function method_501() : void
      {
         if(this.var_488 != null)
         {
            this.var_488.addEventListener(MouseEvent3D.CLICK,this.method_498);
         }
      }
      
      private function method_503() : void
      {
         if(this.var_488 != null)
         {
            this.var_488.removeEventListener(MouseEvent3D.CLICK,this.method_498);
         }
      }
      
      private function method_505(event:MouseEvent3D) : void
      {
      }
      
      private function onMouseOut(event:MouseEvent3D) : void
      {
      }
      
      private function method_498(event:MouseEvent3D) : void
      {
         this.gameKernel.name_61().dispatchEvent(TANK_CLICK,entity);
      }
   }
}

