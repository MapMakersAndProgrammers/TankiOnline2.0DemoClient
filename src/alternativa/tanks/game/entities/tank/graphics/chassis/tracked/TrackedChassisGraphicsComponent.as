package alternativa.tanks.game.entities.tank.graphics.chassis.tracked
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.VertexAttributes;
   import alternativa.engine3d.core.events.MouseEvent3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Decal;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Skin;
   import alternativa.engine3d.shadows.DirectionalShadowRenderer;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.*;
   import alternativa.tanks.game.entities.tank.graphics.DirectionalShadowRendererConstructor;
   import alternativa.tanks.game.entities.tank.graphics.GraphicsControlComponent;
   import alternativa.tanks.game.entities.tank.graphics.IDirectionalShadowRendererConsumer;
   import alternativa.tanks.game.entities.tank.graphics.ITankGraphicsComponent;
   import alternativa.tanks.game.entities.tank.graphics.MaterialType;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy.LegacyTrackedChassisComponent;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import flash.geom.Point;
   
   use namespace alternativa3d;
   
   public class TrackedChassisGraphicsComponent extends EntityComponent implements ITankGraphicsComponent, IDirectionalShadowRendererConsumer
   {
      public static const TANK_CLICK:String = "tankClick";
      
      private static var hullMatrix:Matrix4 = new Matrix4();
      
      private static var eulerAngles:Vector3 = new Vector3();
      
      private var shadow:Decal;
      
      private var hull:TankHull;
      
      private var var_488:Mesh;
      
      private var hullMaterials:TankPartMaterials;
      
      private var container:Object3D;
      
      private var physicsComponent:LegacyTrackedChassisComponent;
      
      private var gameKernel:GameKernel;
      
      private var var_233:TextureMaterial;
      
      private var name_247:Vector.<Mesh>;
      
      private var name_245:Vector.<Mesh>;
      
      private var name_261:Skin;
      
      private var name_266:Skin;
      
      private var var_489:TrackAnimator;
      
      private var var_490:TrackAnimator;
      
      private var shadowRenderer:DirectionalShadowRenderer;
      
      private var var_491:DirectionalShadowRendererConstructor;
      
      public function TrackedChassisGraphicsComponent(hull:TankHull)
      {
         super();
         this.setHull(hull);
      }
      
      public function getHull() : TankHull
      {
         return this.hull;
      }
      
      public function setTracksMaterial(tracksMaterial:TracksMaterial2) : void
      {
         this.var_489.material = TracksMaterial2(tracksMaterial.clone());
         this.name_261.setMaterialToAllSurfaces(this.var_489.material);
         this.var_490.material = TracksMaterial2(tracksMaterial.clone());
         this.name_266.setMaterialToAllSurfaces(this.var_490.material);
      }
      
      public function setShadowMaterial(material:GiShadowMaterial) : void
      {
         if(this.shadow != null)
         {
            this.shadow.setMaterialToAllSurfaces(material);
         }
      }
      
      public function getObject3D() : Object3D
      {
         return this.var_488;
      }
      
      public function setShadowRenderer(shadowRenderer:DirectionalShadowRenderer) : void
      {
         this.shadowRenderer = shadowRenderer;
         this.var_491 = null;
         if(this.container != null)
         {
            this.gameKernel.getRenderSystem().addShadowRenderer(shadowRenderer);
         }
      }
      
      public function setHull(newHull:TankHull) : void
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
            this.var_488 = new Mesh();
            this.var_488.geometry = this.hull.geometry;
            this.var_488.addSurface(this.var_233,0,this.hull.geometry.numTriangles);
            this.var_488.calculateBoundBox();
            this.name_247 = this.createWheels(this.var_488,this.hull.name_247);
            this.name_245 = this.createWheels(this.var_488,this.hull.name_245);
            this.name_261 = this.createTrackMesh(this.hull.name_261,this.var_488);
            this.name_266 = this.createTrackMesh(this.hull.name_266,this.var_488);
            dUdY = this.getRatio(this.name_261);
            this.var_489 = new TrackAnimator(this.name_261,this.name_247,dUdY);
            this.var_490 = new TrackAnimator(this.name_266,this.name_245,dUdY);
            if(this.hull.shadow != null)
            {
               this.shadow = new Decal(100);
               this.shadow.geometry = this.hull.shadow.geometry;
               this.shadow.matrix = this.hull.shadow.matrix;
               this.shadow.addSurface(null,0,this.shadow.geometry.numTriangles);
               this.shadow.useShadow = false;
               this.hullMesh.addChild(this.shadow);
            }
            if(this.container != null)
            {
               this.container.addChild(this.var_488);
            }
         }
      }
      
      private function getRatio(mesh:Mesh) : Number
      {
         var j:int = 0;
         var vertexIndex:int = 0;
         var vertexBaseIndex:uint = 0;
         var v:Vector3 = null;
         var uv:Point = null;
         var ratio:Number = 0;
         var indices:Vector.<uint> = mesh.geometry.indices;
         var vertexCoordinates:Vector.<Number> = mesh.geometry.getAttributeValues(VertexAttributes.POSITION);
         var uvs:Vector.<Number> = mesh.geometry.getAttributeValues(VertexAttributes.TEXCOORDS[0]);
         var faceVertices:Vector.<Vector3> = Vector.<Vector3>([new Vector3(),new Vector3(),new Vector3()]);
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
            ratio = this.getMaxRatio(faceVertices,faceUVs,ratio);
         }
         return ratio;
      }
      
      private function getMaxRatio(faceVertices:Vector.<Vector3>, faceUVs:Vector.<Point>, ratio:Number) : Number
      {
         var v2:Vector3 = null;
         var p2:Point = null;
         var dy:Number = NaN;
         var dv:Number = NaN;
         var newRatio:Number = NaN;
         var v1:Vector3 = faceVertices[2];
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
      
      private function createTrackMesh(tankTrack:Skin, container:Mesh) : Skin
      {
         var skin:Skin = Skin(tankTrack.clone());
         skin.calculateBoundBox();
         container.addChild(skin);
         return skin;
      }
      
      private function createWheels(container:Object3D, wheels:Vector.<TankWheel>) : Vector.<Mesh>
      {
         var tankWheel:TankWheel = null;
         var wheelMesh:Mesh = null;
         var position:Vector3 = null;
         var numWheels:int = int(wheels.length);
         var wheelMeshes:Vector.<Mesh> = new Vector.<Mesh>(numWheels);
         for(var i:int = 0; i < numWheels; i++)
         {
            tankWheel = wheels[i];
            wheelMesh = new Mesh();
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
      
      public function setHullMaterials(hullMaterials:TankPartMaterials) : void
      {
         this.hullMaterials = hullMaterials;
      }
      
      public function get visible() : Boolean
      {
         return this.var_488.visible;
      }
      
      public function addToScene() : void
      {
         var renderSystem:RenderSystem = null;
         if(this.container == null)
         {
            renderSystem = this.gameKernel.getRenderSystem();
            this.container = renderSystem.getDynamicObjectsContainer();
            if(this.var_488 != null)
            {
               this.container.addChild(this.var_488);
               if(this.shadowRenderer != null)
               {
                  renderSystem.addShadowRenderer(this.shadowRenderer);
               }
            }
            this.enableMouseListeners();
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
                  this.gameKernel.getRenderSystem().removeShadowRenderer(this.shadowRenderer);
               }
            }
            this.container = null;
         }
         this.disableMouseListeners();
      }
      
      public function get hullMesh() : Mesh
      {
         return this.var_488;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = LegacyTrackedChassisComponent(entity.getComponentStrict(LegacyTrackedChassisComponent));
         GraphicsControlComponent(entity.getComponentStrict(GraphicsControlComponent)).addComponent(this);
         this.var_489.physicsComponent = this.physicsComponent;
         this.var_490.physicsComponent = this.physicsComponent;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var renderSystem:RenderSystem = gameKernel.getRenderSystem();
         this.var_491 = new DirectionalShadowRendererConstructor(this.var_488,renderSystem,this);
         if(renderSystem.isShadowSystemReady())
         {
            this.var_491.createShadowRenderer();
            this.var_491 = null;
         }
         else
         {
            renderSystem.addShadowRendererConstructor(this.var_491);
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         if(this.var_491 != null)
         {
            gameKernel.getRenderSystem().removeShadowRendererConstructor(this.var_491);
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
         hullMatrix.toIdentity();
         hullMatrix.setPosition(this.hull.name_400);
         hullMatrix.append(this.physicsComponent.var_483);
         hullMatrix.getEulerAngles(eulerAngles);
         this.var_488.x = hullMatrix.d;
         this.var_488.y = hullMatrix.h;
         this.var_488.z = hullMatrix.l;
         this.var_488.rotationX = eulerAngles.x;
         this.var_488.rotationY = eulerAngles.y;
         this.var_488.rotationZ = eulerAngles.z;
         this.animateTracks();
      }
      
      private function animateTracks() : void
      {
         var dt:Number = NaN;
         if(this.var_489 != null)
         {
            dt = TimeSystem.timeDeltaSeconds;
            this.var_489.animate(this.hull.name_437,this.physicsComponent.getLeftTrackSpeed(),dt);
            this.var_490.animate(this.hull.name_437,this.physicsComponent.getRightTrackSpeed(),dt);
         }
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         switch(materialType)
         {
            case MaterialType.DEAD:
               this.hullMaterials.deadMaterial.alpha = 1;
               this.var_489.material.alpha = 1;
               this.var_490.material.alpha = 1;
               this.var_488.setMaterialToAllSurfaces(this.hullMaterials.deadMaterial);
               this.var_233 = this.hullMaterials.deadMaterial;
               break;
            case MaterialType.NORMAL:
               this.hullMaterials.normalMaterial.alpha = 1;
               this.var_489.material.alpha = 1;
               this.var_490.material.alpha = 1;
               this.var_488.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.var_233 = this.hullMaterials.normalMaterial;
               break;
            case MaterialType.ACTIVATING:
               this.hullMaterials.normalMaterial.alpha = 0.5;
               this.var_489.material.alpha = 0.5;
               this.var_490.material.alpha = 0.5;
               this.var_488.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.var_233 = this.hullMaterials.normalMaterial;
         }
         var numWheels:int = int(this.name_247.length);
         for(var i:int = 0; i < numWheels; i++)
         {
            this.name_247[i].setMaterialToAllSurfaces(this.var_233);
            this.name_245[i].setMaterialToAllSurfaces(this.var_233);
         }
      }
      
      public function setAlpha(value:Number) : void
      {
         this.var_233.alpha = value;
         this.var_489.material.alpha = value;
         this.var_490.material.alpha = value;
      }
      
      private function enableMouseListeners() : void
      {
         if(this.var_488 != null)
         {
            this.var_488.addEventListener(MouseEvent3D.CLICK,this.onMouseClick);
         }
      }
      
      private function disableMouseListeners() : void
      {
         if(this.var_488 != null)
         {
            this.var_488.removeEventListener(MouseEvent3D.CLICK,this.onMouseClick);
         }
      }
      
      private function onMouseOver(event:MouseEvent3D) : void
      {
      }
      
      private function onMouseOut(event:MouseEvent3D) : void
      {
      }
      
      private function onMouseClick(event:MouseEvent3D) : void
      {
         this.gameKernel.getEventSystem().dispatchEvent(TANK_CLICK,entity);
      }
   }
}

