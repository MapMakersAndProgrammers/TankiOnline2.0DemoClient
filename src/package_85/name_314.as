package package_85
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_114.name_488;
   import package_114.name_489;
   import package_18.name_44;
   import package_18.name_82;
   import package_45.name_182;
   import package_71.name_252;
   
   use namespace alternativa3d;
   
   public class name_314 extends EntityComponent implements name_82
   {
      private var var_424:name_488;
      
      private var components:Vector.<class_22>;
      
      private var var_426:Boolean;
      
      private var var_425:Boolean;
      
      private var alpha:Number = 1;
      
      private var gameKernel:GameKernel;
      
      public function name_314()
      {
         super();
         this.components = new Vector.<class_22>();
      }
      
      override public function initComponent() : void
      {
         this.var_424 = new name_488();
         this.var_424.name_486(entity,name_252.SET_ACTIVATING_STATE,new name_490(this));
         this.var_424.name_486(entity,name_252.SET_ACTIVE_STATE,new name_491(this));
         this.var_424.name_486(entity,name_252.SET_DEAD_STATE,new name_492(this));
         var respawnState:name_487 = new name_487(this);
         this.var_424.name_486(entity,name_252.SET_RESPAWN_STATE,respawnState);
         this.var_424.name_493 = name_489.INSTANCE;
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      public function addToScene() : void
      {
         var tankGraphicsComponent:class_22 = null;
         var renderSystem:name_44 = null;
         if(!this.var_426)
         {
            for each(tankGraphicsComponent in this.components)
            {
               tankGraphicsComponent.addToScene();
            }
            renderSystem = this.gameKernel.name_5();
            renderSystem.method_63(this);
            this.var_426 = true;
         }
         this.var_425 = false;
         this.alpha = 1;
      }
      
      public function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.var_425 = true;
         }
      }
      
      public function method_376() : void
      {
         var tankGraphicsComponent:class_22 = null;
         this.var_425 = false;
         this.var_426 = false;
         for each(tankGraphicsComponent in this.components)
         {
            tankGraphicsComponent.removeFromScene();
         }
         this.gameKernel.name_5().method_64(this);
      }
      
      public function setMaterial(materialType:name_481) : void
      {
         var tankGraphicsComponent:class_22 = null;
         for each(tankGraphicsComponent in this.components)
         {
            tankGraphicsComponent.setMaterial(materialType);
         }
      }
      
      public function name_60(component:class_22) : void
      {
         this.components.push(component);
      }
      
      public function render() : void
      {
         var tankGraphicsComponent:class_22 = null;
         if(this.var_425)
         {
            if(this.alpha == 0)
            {
               this.method_376();
            }
            this.alpha -= name_182.timeDeltaSeconds;
            if(this.alpha < 0)
            {
               this.alpha = 0;
            }
            for each(tankGraphicsComponent in this.components)
            {
               tankGraphicsComponent.method_342(this.alpha);
            }
         }
         var numComponents:int = int(this.components.length);
         for(var i:int = 0; i < numComponents; i++)
         {
            tankGraphicsComponent = this.components[i];
            tankGraphicsComponent.render();
         }
      }
   }
}

