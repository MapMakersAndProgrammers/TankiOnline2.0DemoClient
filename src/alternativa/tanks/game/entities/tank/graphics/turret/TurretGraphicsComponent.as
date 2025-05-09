package alternativa.tanks.game.entities.tank.graphics.turret
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.TankPartMaterials;
   import alternativa.tanks.game.entities.tank.TankTurret;
   import alternativa.tanks.game.entities.tank.graphics.GraphicsControlComponent;
   import alternativa.tanks.game.entities.tank.graphics.ITankGraphicsComponent;
   import alternativa.tanks.game.entities.tank.graphics.MaterialType;
   import alternativa.tanks.game.entities.tank.graphics.chassis.tracked.TrackedChassisGraphicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   
   use namespace alternativa3d;
   
   public class TurretGraphicsComponent extends EntityComponent implements ITankGraphicsComponent
   {
      private static var vector:Vector3 = new Vector3();
      
      private var turret:TankTurret;
      
      private var §_-Pf§:Mesh;
      
      private var §_-a§:TankPartMaterials;
      
      private var physicsComponent:ITurretPhysicsComponent;
      
      private var §_-Gf§:TextureMaterial;
      
      private var renderSystem:RenderSystem;
      
      public function TurretGraphicsComponent(turret:TankTurret)
      {
         super();
         this.setTurret(turret);
      }
      
      public function getObject3D() : Object3D
      {
         return this.§_-Pf§;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         GraphicsControlComponent(entity.getComponentStrict(GraphicsControlComponent)).addComponent(this);
         this.addToChassisSkin();
      }
      
      private function addToChassisSkin() : void
      {
         var trackedChassisGraphicsComponent:TrackedChassisGraphicsComponent = null;
         if(entity != null)
         {
            trackedChassisGraphicsComponent = TrackedChassisGraphicsComponent(entity.getComponent(TrackedChassisGraphicsComponent));
            if(trackedChassisGraphicsComponent != null)
            {
               trackedChassisGraphicsComponent.hullMesh.addChild(this.§_-Pf§);
            }
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.renderSystem = gameKernel.getRenderSystem();
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.removeFromScene();
         this.renderSystem = null;
      }
      
      public function render() : void
      {
         if(this.turret == null)
         {
            return;
         }
         this.physicsComponent.getSkinMountPoint(vector);
         this.§_-Pf§.x = vector.x;
         this.§_-Pf§.y = vector.y;
         this.§_-Pf§.z = vector.z;
         this.§_-Pf§.rotationZ = this.physicsComponent.getInterpolatedTurretDirection();
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         switch(materialType)
         {
            case MaterialType.DEAD:
               this.§_-a§.deadMaterial.alpha = 1;
               this.§_-Pf§.setMaterialToAllSurfaces(this.§_-a§.deadMaterial);
               this.§_-Gf§ = this.§_-a§.deadMaterial;
               break;
            case MaterialType.ACTIVATING:
               this.§_-a§.normalMaterial.alpha = 0.5;
               this.§_-Pf§.setMaterialToAllSurfaces(this.§_-a§.normalMaterial);
               this.§_-Gf§ = this.§_-a§.normalMaterial;
               break;
            case MaterialType.NORMAL:
               this.§_-a§.normalMaterial.alpha = 1;
               this.§_-Pf§.setMaterialToAllSurfaces(this.§_-a§.normalMaterial);
               this.§_-Gf§ = this.§_-a§.normalMaterial;
         }
      }
      
      public function addToScene() : void
      {
      }
      
      public function removeFromScene() : void
      {
      }
      
      public function setAlpha(value:Number) : void
      {
         this.§_-Gf§.alpha = value;
      }
      
      public function setTurret(value:TankTurret) : void
      {
         if(this.turret == value)
         {
            return;
         }
         if(this.turret != null)
         {
            this.§_-Pf§.alternativa3d::removeFromParent();
         }
         this.turret = value;
         if(this.turret != null)
         {
            this.§_-Pf§ = new Mesh();
            this.§_-Pf§.geometry = this.turret.geometry;
            this.§_-Pf§.addSurface(this.§_-Gf§,0,this.turret.geometry.numTriangles);
            this.§_-Pf§.calculateBoundBox();
            this.addToChassisSkin();
         }
      }
      
      public function setTurretMaterials(materials:TankPartMaterials) : void
      {
         this.§_-a§ = materials;
      }
      
      public function get turretMesh() : Mesh
      {
         return this.§_-Pf§;
      }
   }
}

