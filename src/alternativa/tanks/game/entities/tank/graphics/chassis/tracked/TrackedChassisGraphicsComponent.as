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
      
      private var §_-nh§:Mesh;
      
      private var hullMaterials:TankPartMaterials;
      
      private var container:Object3D;
      
      private var physicsComponent:LegacyTrackedChassisComponent;
      
      private var gameKernel:GameKernel;
      
      private var §_-Gf§:TextureMaterial;
      
      private var §_-EY§:Vector.<Mesh>;
      
      private var §_-M4§:Vector.<Mesh>;
      
      private var §_-Ei§:Skin;
      
      private var §_-iA§:Skin;
      
      private var §_-dh§:TrackAnimator;
      
      private var §_-R4§:TrackAnimator;
      
      private var shadowRenderer:DirectionalShadowRenderer;
      
      private var §_-5s§:DirectionalShadowRendererConstructor;
      
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
         this.§_-dh§.material = TracksMaterial2(tracksMaterial.clone());
         this.§_-Ei§.setMaterialToAllSurfaces(this.§_-dh§.material);
         this.§_-R4§.material = TracksMaterial2(tracksMaterial.clone());
         this.§_-iA§.setMaterialToAllSurfaces(this.§_-R4§.material);
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
         return this.§_-nh§;
      }
      
      public function setShadowRenderer(shadowRenderer:DirectionalShadowRenderer) : void
      {
         this.shadowRenderer = shadowRenderer;
         this.§_-5s§ = null;
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
            this.container.removeChild(this.§_-nh§);
         }
         this.hull = newHull;
         if(this.hull != null)
         {
            this.§_-nh§ = new Mesh();
            this.§_-nh§.geometry = this.hull.geometry;
            this.§_-nh§.addSurface(this.§_-Gf§,0,this.hull.geometry.numTriangles);
            this.§_-nh§.calculateBoundBox();
            this.§_-EY§ = this.createWheels(this.§_-nh§,this.hull.§_-EY§);
            this.§_-M4§ = this.createWheels(this.§_-nh§,this.hull.§_-M4§);
            this.§_-Ei§ = this.createTrackMesh(this.hull.§_-Ei§,this.§_-nh§);
            this.§_-iA§ = this.createTrackMesh(this.hull.§_-iA§,this.§_-nh§);
            dUdY = this.getRatio(this.§_-Ei§);
            this.§_-dh§ = new TrackAnimator(this.§_-Ei§,this.§_-EY§,dUdY);
            this.§_-R4§ = new TrackAnimator(this.§_-iA§,this.§_-M4§,dUdY);
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
               this.container.addChild(this.§_-nh§);
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
            wheelMesh.addSurface(this.§_-Gf§,0,wheelMesh.geometry.numTriangles);
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
         return this.§_-nh§.visible;
      }
      
      public function addToScene() : void
      {
         var renderSystem:RenderSystem = null;
         if(this.container == null)
         {
            renderSystem = this.gameKernel.getRenderSystem();
            this.container = renderSystem.getDynamicObjectsContainer();
            if(this.§_-nh§ != null)
            {
               this.container.addChild(this.§_-nh§);
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
            if(this.§_-nh§ != null)
            {
               this.container.removeChild(this.§_-nh§);
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
         return this.§_-nh§;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = LegacyTrackedChassisComponent(entity.getComponentStrict(LegacyTrackedChassisComponent));
         GraphicsControlComponent(entity.getComponentStrict(GraphicsControlComponent)).addComponent(this);
         this.§_-dh§.physicsComponent = this.physicsComponent;
         this.§_-R4§.physicsComponent = this.physicsComponent;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var renderSystem:RenderSystem = gameKernel.getRenderSystem();
         this.§_-5s§ = new DirectionalShadowRendererConstructor(this.§_-nh§,renderSystem,this);
         if(renderSystem.isShadowSystemReady())
         {
            this.§_-5s§.createShadowRenderer();
            this.§_-5s§ = null;
         }
         else
         {
            renderSystem.addShadowRendererConstructor(this.§_-5s§);
         }
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         if(this.§_-5s§ != null)
         {
            gameKernel.getRenderSystem().removeShadowRendererConstructor(this.§_-5s§);
            this.§_-5s§ = null;
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
         hullMatrix.setPosition(this.hull.§_-Sh§);
         hullMatrix.append(this.physicsComponent.§_-YH§);
         hullMatrix.getEulerAngles(eulerAngles);
         this.§_-nh§.x = hullMatrix.d;
         this.§_-nh§.y = hullMatrix.h;
         this.§_-nh§.z = hullMatrix.l;
         this.§_-nh§.rotationX = eulerAngles.x;
         this.§_-nh§.rotationY = eulerAngles.y;
         this.§_-nh§.rotationZ = eulerAngles.z;
         this.animateTracks();
      }
      
      private function animateTracks() : void
      {
         var dt:Number = NaN;
         if(this.§_-dh§ != null)
         {
            dt = TimeSystem.timeDeltaSeconds;
            this.§_-dh§.animate(this.hull.§_-DH§,this.physicsComponent.getLeftTrackSpeed(),dt);
            this.§_-R4§.animate(this.hull.§_-DH§,this.physicsComponent.getRightTrackSpeed(),dt);
         }
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         switch(materialType)
         {
            case MaterialType.DEAD:
               this.hullMaterials.deadMaterial.alpha = 1;
               this.§_-dh§.material.alpha = 1;
               this.§_-R4§.material.alpha = 1;
               this.§_-nh§.setMaterialToAllSurfaces(this.hullMaterials.deadMaterial);
               this.§_-Gf§ = this.hullMaterials.deadMaterial;
               break;
            case MaterialType.NORMAL:
               this.hullMaterials.normalMaterial.alpha = 1;
               this.§_-dh§.material.alpha = 1;
               this.§_-R4§.material.alpha = 1;
               this.§_-nh§.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.§_-Gf§ = this.hullMaterials.normalMaterial;
               break;
            case MaterialType.ACTIVATING:
               this.hullMaterials.normalMaterial.alpha = 0.5;
               this.§_-dh§.material.alpha = 0.5;
               this.§_-R4§.material.alpha = 0.5;
               this.§_-nh§.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.§_-Gf§ = this.hullMaterials.normalMaterial;
         }
         var numWheels:int = int(this.§_-EY§.length);
         for(var i:int = 0; i < numWheels; i++)
         {
            this.§_-EY§[i].setMaterialToAllSurfaces(this.§_-Gf§);
            this.§_-M4§[i].setMaterialToAllSurfaces(this.§_-Gf§);
         }
      }
      
      public function setAlpha(value:Number) : void
      {
         this.§_-Gf§.alpha = value;
         this.§_-dh§.material.alpha = value;
         this.§_-R4§.material.alpha = value;
      }
      
      private function enableMouseListeners() : void
      {
         if(this.§_-nh§ != null)
         {
            this.§_-nh§.addEventListener(MouseEvent3D.CLICK,this.onMouseClick);
         }
      }
      
      private function disableMouseListeners() : void
      {
         if(this.§_-nh§ != null)
         {
            this.§_-nh§.removeEventListener(MouseEvent3D.CLICK,this.onMouseClick);
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

