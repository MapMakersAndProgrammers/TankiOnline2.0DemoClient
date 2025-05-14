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
   import alternativa.engine3d.materials.StandardMaterial;
   
   use namespace alternativa3d;
   
   public class TrackedChassisGraphicsComponent extends EntityComponent implements ITankGraphicsComponent
   {
      public static const TANK_CLICK:String = "tankClick";
      
      private static var hullMatrix:Matrix4 = new Matrix4();
      
      private static var eulerAngles:Vector3 = new Vector3();
      
      private var shadow:Decal;
      
      private var hull:TankHull;
      
      private var name_nh:Mesh;
      
      private var hullMaterials:TankPartMaterials;
      
      private var container:Object3D;
      
      private var physicsComponent:LegacyTrackedChassisComponent;
      
      private var gameKernel:GameKernel;
      
      private var name_Gf:TextureMaterial;
      
      private var name_EY:Vector.<Mesh>;
      
      private var name_M4:Vector.<Mesh>;
      
      private var name_Ei:Skin;
      
      private var name_iA:Skin;
      
      private var name_dh:TrackAnimator;
      
      private var name_R4:TrackAnimator;
      
      public function TrackedChassisGraphicsComponent(hull:TankHull)
      {
         super();
         this.setHull(hull);
      }
      
      public function getHull() : TankHull
      {
         return this.hull;
      }
      
      public function setTracksMaterial(tracksMaterial:StandardMaterial) : void
      {
         this.name_dh.material = StandardMaterial(tracksMaterial.clone());
         this.name_Ei.setMaterialToAllSurfaces(this.name_dh.material);
         this.name_R4.material = StandardMaterial(tracksMaterial.clone());
         this.name_iA.setMaterialToAllSurfaces(this.name_R4.material);
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
         return this.name_nh;
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
            this.container.removeChild(this.name_nh);
         }
         this.hull = newHull;
         if(this.hull != null)
         {
            this.name_nh = new Mesh();
            this.name_nh.geometry = this.hull.geometry;
            this.name_nh.addSurface(this.name_Gf,0,this.hull.geometry.numTriangles);
            this.name_nh.calculateBoundBox();
            this.name_EY = this.createWheels(this.name_nh,this.hull.name_EY);
            this.name_M4 = this.createWheels(this.name_nh,this.hull.name_M4);
            this.name_Ei = this.createTrackMesh(this.hull.name_Ei,this.name_nh);
            this.name_iA = this.createTrackMesh(this.hull.name_iA,this.name_nh);
            dUdY = this.getRatio(this.name_Ei);
            this.name_dh = new TrackAnimator(this.name_Ei,this.name_EY,dUdY);
            this.name_R4 = new TrackAnimator(this.name_iA,this.name_M4,dUdY);
            if(this.hull.shadow != null)
            {
               this.shadow = new Decal(); //XXX: offset = 100
               this.shadow.geometry = this.hull.shadow.geometry;
               this.shadow.matrix = this.hull.shadow.matrix;
               this.shadow.addSurface(null,0,this.shadow.geometry.numTriangles);
               this.shadow.useShadow = false;
               this.hullMesh.addChild(this.shadow);
            }
            if(this.container != null)
            {
               this.container.addChild(this.name_nh);
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
            wheelMesh.addSurface(this.name_Gf,0,wheelMesh.geometry.numTriangles);
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
         return this.name_nh.visible;
      }
      
      public function addToScene() : void
      {
         var renderSystem:RenderSystem = null;
         if(this.container == null)
         {
            renderSystem = this.gameKernel.getRenderSystem();
            this.container = renderSystem.getDynamicObjectsContainer();
            if(this.name_nh != null)
            {
               this.container.addChild(this.name_nh);
            }
            this.enableMouseListeners();
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.container != null)
         {
            if(this.name_nh != null)
            {
               this.container.removeChild(this.name_nh);
            }
            this.container = null;
         }
         this.disableMouseListeners();
      }
      
      public function get hullMesh() : Mesh
      {
         return this.name_nh;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = LegacyTrackedChassisComponent(entity.getComponentStrict(LegacyTrackedChassisComponent));
         GraphicsControlComponent(entity.getComponentStrict(GraphicsControlComponent)).addComponent(this);
         this.name_dh.physicsComponent = this.physicsComponent;
         this.name_R4.physicsComponent = this.physicsComponent;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         var renderSystem:RenderSystem = gameKernel.getRenderSystem();
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
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
         hullMatrix.setPosition(this.hull.name_Sh);
         hullMatrix.append(this.physicsComponent.name_YH);
         hullMatrix.getEulerAngles(eulerAngles);
         this.name_nh.x = hullMatrix.d;
         this.name_nh.y = hullMatrix.h;
         this.name_nh.z = hullMatrix.l;
         this.name_nh.rotationX = eulerAngles.x;
         this.name_nh.rotationY = eulerAngles.y;
         this.name_nh.rotationZ = eulerAngles.z;
         this.animateTracks();
      }
      
      private function animateTracks() : void
      {
         var dt:Number = NaN;
         if(this.name_dh != null)
         {
            dt = TimeSystem.timeDeltaSeconds;
            this.name_dh.animate(this.hull.name_DH,this.physicsComponent.getLeftTrackSpeed(),dt);
            this.name_R4.animate(this.hull.name_DH,this.physicsComponent.getRightTrackSpeed(),dt);
         }
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         switch(materialType)
         {
            case MaterialType.DEAD:
               this.hullMaterials.deadMaterial.alpha = 1;
               this.name_dh.material.alpha = 1;
               this.name_R4.material.alpha = 1;
               this.name_nh.setMaterialToAllSurfaces(this.hullMaterials.deadMaterial);
               this.name_Gf = this.hullMaterials.deadMaterial;
               break;
            case MaterialType.NORMAL:
               this.hullMaterials.normalMaterial.alpha = 1;
               this.name_dh.material.alpha = 1;
               this.name_R4.material.alpha = 1;
               this.name_nh.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.name_Gf = this.hullMaterials.normalMaterial;
               break;
            case MaterialType.ACTIVATING:
               this.hullMaterials.normalMaterial.alpha = 0.5;
               this.name_dh.material.alpha = 0.5;
               this.name_R4.material.alpha = 0.5;
               this.name_nh.setMaterialToAllSurfaces(this.hullMaterials.normalMaterial);
               this.name_Gf = this.hullMaterials.normalMaterial;
         }
         var numWheels:int = int(this.name_EY.length);
         for(var i:int = 0; i < numWheels; i++)
         {
            this.name_EY[i].setMaterialToAllSurfaces(this.name_Gf);
            this.name_M4[i].setMaterialToAllSurfaces(this.name_Gf);
         }
      }
      
      public function setAlpha(value:Number) : void
      {
         this.name_Gf.alpha = value;
         this.name_dh.material.alpha = value;
         this.name_R4.material.alpha = value;
      }
      
      private function enableMouseListeners() : void
      {
         if(this.name_nh != null)
         {
            this.name_nh.addEventListener(MouseEvent3D.CLICK,this.onMouseClick);
         }
      }
      
      private function disableMouseListeners() : void
      {
         if(this.name_nh != null)
         {
            this.name_nh.removeEventListener(MouseEvent3D.CLICK,this.onMouseClick);
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

