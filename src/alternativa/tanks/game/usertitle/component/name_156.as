package alternativa.tanks.game.usertitle.component
{
   import alternativa.tanks.game.usertitle.name_440;
   import alternativa.tanks.game.usertitle.name_443;
   import alternativa.tanks.game.usertitle.name_454;
   import package_15.class_18;
   import package_15.name_17;
   import package_18.class_19;
   import package_18.name_51;
   import package_30.name_103;
   import package_38.name_145;
   import package_39.name_164;
   import package_40.name_439;
   import package_41.name_146;
   import package_82.name_409;
   
   public class name_156 extends class_18 implements class_19
   {
      private static const REMOTE_LABEL_OFFSET_Z:int = 200;
      
      private static var position:name_145 = new name_145();
      
      private var var_505:name_440;
      
      private var chassisComponent:name_146;
      
      private var var_442:name_439;
      
      private var localPlayer:Boolean;
      
      private var var_424:name_409;
      
      private var gameKernel:name_17;
      
      private var var_426:Boolean;
      
      private var var_506:name_441;
      
      private var titleRenderer:name_443;
      
      public function name_156(maxHealth:int, rankIcon:name_454, name:String, localPlayer:Boolean, label:name_455, configFlags:int, titleRenderer:name_443)
      {
         super();
         this.var_505 = new name_440(maxHealth,rankIcon,label);
         this.localPlayer = localPlayer;
         this.titleRenderer = titleRenderer;
         this.var_505.name_447(name);
         this.var_505.name_452(configFlags);
      }
      
      public function name_251() : Boolean
      {
         return this.var_426;
      }
      
      public function method_198() : Boolean
      {
         return this.localPlayer;
      }
      
      public function method_197(maxHealth:int) : void
      {
         this.var_505.method_197(maxHealth);
      }
      
      public function name_265(indicatorId:int, duration:int) : void
      {
         this.var_505.name_265(indicatorId,duration);
      }
      
      public function name_254(indicatorId:int) : void
      {
         this.var_505.name_254(indicatorId);
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = name_146(entity.getComponentStrict(name_146));
         this.var_442 = name_439(entity.getComponent(name_439));
         this.var_424 = new name_409();
         this.var_506 = new name_441(this);
         this.var_424.name_404(entity,name_164.SET_ACTIVATING_STATE,this.var_506);
         this.var_424.name_404(entity,name_164.SET_ACTIVE_STATE,this.var_506);
         this.var_424.name_404(entity,name_164.SET_DEAD_STATE,new name_444(this));
         var offSceneState:name_442 = new name_442(this);
         this.var_424.name_404(entity,name_164.SET_RESPAWN_STATE,offSceneState);
         this.var_424.name_371 = offSceneState;
         entity.addEventHandler(name_164.SET_HEALTH,this.method_195);
      }
      
      private function method_195(eventType:String, data:*) : void
      {
         this.setHealth(Number(data));
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
         this.var_505.name_448(gameKernel.name_5());
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         this.var_424.name_371.stop();
         this.removeFromScene();
      }
      
      public function addToScene() : void
      {
         var renderSystem:name_51 = null;
         if(!this.var_426)
         {
            renderSystem = this.gameKernel.name_5();
            if(this.localPlayer)
            {
               this.var_505.name_450();
            }
            this.var_505.name_453(renderSystem.name_386());
            renderSystem.name_387(this);
            this.var_426 = true;
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.var_505.name_449();
            this.gameKernel.name_5().name_381(this);
            this.var_426 = false;
         }
      }
      
      public function setHealth(health:Number) : void
      {
         this.var_505.setHealth(health);
      }
      
      public function method_196(rankId:int) : void
      {
         this.var_505.method_196(rankId);
      }
      
      public function render() : void
      {
         this.chassisComponent.method_193(position);
         position.transform4(this.chassisComponent.method_191());
         if(this.localPlayer && this.var_442 != null)
         {
            this.var_505.name_451(this.var_442.name_446() * 100);
         }
         else
         {
            position.z += REMOTE_LABEL_OFFSET_Z;
         }
         this.titleRenderer.name_445(entity,this);
         this.var_505.update(position,name_103.time,name_103.timeDelta);
      }
      
      public function getTitle() : name_440
      {
         return this.var_505;
      }
   }
}

