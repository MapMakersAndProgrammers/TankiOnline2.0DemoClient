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
      
      private var var_231:Mesh;
      
      private var var_232:TankPartMaterials;
      
      private var physicsComponent:ITurretPhysicsComponent;
      
      private var var_233:TextureMaterial;
      
      private var renderSystem:RenderSystem;
      
      public function TurretGraphicsComponent(turret:TankTurret)
      {
         super();
         this.setTurret(turret);
      }
      
      public function getObject3D() : Object3D
      {
         return this.var_231;
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
               trackedChassisGraphicsComponent.hullMesh.addChild(this.var_231);
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
         this.var_231.x = vector.x;
         this.var_231.y = vector.y;
         this.var_231.z = vector.z;
         this.var_231.rotationZ = this.physicsComponent.getInterpolatedTurretDirection();
      }
      
      public function setMaterial(materialType:MaterialType) : void
      {
         switch(materialType)
         {
            case MaterialType.DEAD:
               this.var_232.deadMaterial.alpha = 1;
               this.var_231.setMaterialToAllSurfaces(this.var_232.deadMaterial);
               this.var_233 = this.var_232.deadMaterial;
               break;
            case MaterialType.ACTIVATING:
               this.var_232.normalMaterial.alpha = 0.5;
               this.var_231.setMaterialToAllSurfaces(this.var_232.normalMaterial);
               this.var_233 = this.var_232.normalMaterial;
               break;
            case MaterialType.NORMAL:
               this.var_232.normalMaterial.alpha = 1;
               this.var_231.setMaterialToAllSurfaces(this.var_232.normalMaterial);
               this.var_233 = this.var_232.normalMaterial;
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
         this.var_233.alpha = value;
      }
      
      public function setTurret(value:TankTurret) : void
      {
         if(this.turret == value)
         {
            return;
         }
         if(this.turret != null)
         {
            this.var_231.alternativa3d::removeFromParent();
         }
         this.turret = value;
         if(this.turret != null)
         {
            this.var_231 = new Mesh();
            this.var_231.geometry = this.turret.geometry;
            this.var_231.addSurface(this.var_233,0,this.turret.geometry.numTriangles);
            this.var_231.calculateBoundBox();
            this.addToChassisSkin();
         }
      }
      
      public function setTurretMaterials(materials:TankPartMaterials) : void
      {
         this.var_232 = materials;
      }
      
      public function get turretMesh() : Mesh
      {
         return this.var_231;
      }
   }
}

