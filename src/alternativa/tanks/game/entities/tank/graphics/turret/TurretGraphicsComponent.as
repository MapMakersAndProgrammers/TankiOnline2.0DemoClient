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
      
      private var name_Pf:Mesh;
      
      private var name_a:TankPartMaterials;
      
      private var physicsComponent:ITurretPhysicsComponent;
      
      private var name_Gf:TextureMaterial;
      
      private var renderSystem:RenderSystem;
      
      public function TurretGraphicsComponent(turret:TankTurret)
      {
         super();
         this.setTurret(turret);
      }
      
      public function getObject3D() : Object3D
      {
         return this.name_Pf;
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
               trackedChassisGraphicsComponent.hullMesh.addChild(this.name_Pf);
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
         this.name_Pf.x = vector.x;
         this.name_Pf.y = vector.y;
         this.name_Pf.z = vector.z;
         this.name_Pf.rotationZ = this.physicsComponent.getInterpolatedTurretDirection();
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         switch(materialType)
         {
            case MaterialType.DEAD:
               this.name_a.deadMaterial.alpha = 1;
               this.name_Pf.setMaterialToAllSurfaces(this.name_a.deadMaterial);
               this.name_Gf = this.name_a.deadMaterial;
               break;
            case MaterialType.ACTIVATING:
               this.name_a.normalMaterial.alpha = 0.5;
               this.name_Pf.setMaterialToAllSurfaces(this.name_a.normalMaterial);
               this.name_Gf = this.name_a.normalMaterial;
               break;
            case MaterialType.NORMAL:
               this.name_a.normalMaterial.alpha = 1;
               this.name_Pf.setMaterialToAllSurfaces(this.name_a.normalMaterial);
               this.name_Gf = this.name_a.normalMaterial;
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
         this.name_Gf.alpha = value;
      }
      
      public function setTurret(value:TankTurret) : void
      {
         if(this.turret == value)
         {
            return;
         }
         if(this.turret != null)
         {
            this.name_Pf.alternativa3d::removeFromParent();
         }
         this.turret = value;
         if(this.turret != null)
         {
            this.name_Pf = new Mesh();
            this.name_Pf.geometry = this.turret.geometry;
            this.name_Pf.addSurface(this.name_Gf,0,this.turret.geometry.numTriangles);
            this.name_Pf.calculateBoundBox();
            this.addToChassisSkin();
         }
      }
      
      public function setTurretMaterials(materials:TankPartMaterials) : void
      {
         this.name_a = materials;
      }
      
      public function get turretMesh() : Mesh
      {
         return this.name_Pf;
      }
   }
}

