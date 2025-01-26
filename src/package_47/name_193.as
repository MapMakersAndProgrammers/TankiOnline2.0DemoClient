package package_47
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_18.name_44;
   import package_19.name_380;
   import package_21.name_78;
   import package_4.class_5;
   import package_46.name_194;
   import package_71.name_234;
   import package_71.name_277;
   import package_75.class_15;
   import package_84.name_253;
   import package_85.class_22;
   import package_85.name_314;
   import package_85.name_481;
   
   use namespace alternativa3d;
   
   public class name_193 extends EntityComponent implements class_22
   {
      private static var vector:name_194 = new name_194();
      
      private var turret:name_234;
      
      private var var_231:name_380;
      
      private var var_232:name_277;
      
      private var physicsComponent:class_15;
      
      private var var_233:class_5;
      
      private var renderSystem:name_44;
      
      public function name_193(turret:name_234)
      {
         super();
         this.setTurret(turret);
      }
      
      public function name_329() : name_78
      {
         return this.var_231;
      }
      
      override public function initComponent() : void
      {
         this.physicsComponent = class_15(entity.getComponentStrict(class_15));
         name_314(entity.getComponentStrict(name_314)).name_60(this);
         this.method_343();
      }
      
      private function method_343() : void
      {
         var trackedChassisGraphicsComponent:name_253 = null;
         if(entity != null)
         {
            trackedChassisGraphicsComponent = name_253(entity.getComponent(name_253));
            if(trackedChassisGraphicsComponent != null)
            {
               trackedChassisGraphicsComponent.name_482.addChild(this.var_231);
            }
         }
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.renderSystem = gameKernel.name_5();
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
      
      public function setMaterial(materialType:name_481) : void
      {
         switch(materialType)
         {
            case name_481.DEAD:
               this.var_232.deadMaterial.alpha = 1;
               this.var_231.setMaterialToAllSurfaces(this.var_232.deadMaterial);
               this.var_233 = this.var_232.deadMaterial;
               break;
            case name_481.ACTIVATING:
               this.var_232.normalMaterial.alpha = 0.5;
               this.var_231.setMaterialToAllSurfaces(this.var_232.normalMaterial);
               this.var_233 = this.var_232.normalMaterial;
               break;
            case name_481.NORMAL:
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
      
      public function method_342(value:Number) : void
      {
         this.var_233.alpha = value;
      }
      
      public function setTurret(value:name_234) : void
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
            this.var_231 = new name_380();
            this.var_231.geometry = this.turret.geometry;
            this.var_231.addSurface(this.var_233,0,this.turret.geometry.numTriangles);
            this.var_231.calculateBoundBox();
            this.method_343();
         }
      }
      
      public function name_348(materials:name_277) : void
      {
         this.var_232 = materials;
      }
      
      public function get name_198() : name_380
      {
         return this.var_231;
      }
   }
}

