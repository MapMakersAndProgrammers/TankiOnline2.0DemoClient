package alternativa.tanks.game.usertitle.component
{
   import alternativa.tanks.game.usertitle.name_607;
   import alternativa.tanks.game.usertitle.name_610;
   import alternativa.tanks.game.usertitle.name_613;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_114.name_488;
   import package_18.name_44;
   import package_18.name_82;
   import package_45.name_182;
   import package_46.name_194;
   import package_71.name_252;
   import package_74.class_25;
   import package_75.name_236;
   
   public class name_245 extends EntityComponent implements name_82
   {
      private static const REMOTE_LABEL_OFFSET_Z:int = 200;
      
      private static var position:name_194 = new name_194();
      
      private var var_505:name_607;
      
      private var chassisComponent:name_236;
      
      private var var_442:class_25;
      
      private var localPlayer:Boolean;
      
      private var var_424:name_488;
      
      private var gameKernel:GameKernel;
      
      private var var_426:Boolean;
      
      private var var_506:name_609;
      
      private var titleRenderer:name_610;
      
      public function name_245(maxHealth:int, rankIcon:name_613, name:String, localPlayer:Boolean, label:name_617, configFlags:int, titleRenderer:name_610)
      {
         super();
         this.var_505 = new name_607(maxHealth,rankIcon,label);
         this.localPlayer = localPlayer;
         this.titleRenderer = titleRenderer;
         this.var_505.name_620(name);
         this.var_505.name_619(configFlags);
      }
      
      public function name_328() : Boolean
      {
         return this.var_426;
      }
      
      public function method_527() : Boolean
      {
         return this.localPlayer;
      }
      
      public function method_524(maxHealth:int) : void
      {
         this.var_505.method_524(maxHealth);
      }
      
      public function name_339(indicatorId:int, duration:int) : void
      {
         this.var_505.name_339(indicatorId,duration);
      }
      
      public function name_330(indicatorId:int) : void
      {
         this.var_505.name_330(indicatorId);
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = name_236(entity.getComponentStrict(name_236));
         this.var_442 = class_25(entity.getComponent(class_25));
         this.var_424 = new name_488();
         this.var_506 = new name_609(this);
         this.var_424.name_486(entity,name_252.SET_ACTIVATING_STATE,this.var_506);
         this.var_424.name_486(entity,name_252.SET_ACTIVE_STATE,this.var_506);
         this.var_424.name_486(entity,name_252.SET_DEAD_STATE,new name_492(this));
         var offSceneState:name_608 = new name_608(this);
         this.var_424.name_486(entity,name_252.SET_RESPAWN_STATE,offSceneState);
         this.var_424.name_493 = offSceneState;
         entity.addEventHandler(name_252.SET_HEALTH,this.method_525);
      }
      
      private function method_525(eventType:String, data:*) : void
      {
         this.setHealth(Number(data));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.var_505.name_612(gameKernel.name_5());
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.var_424.name_493.stop();
         this.removeFromScene();
      }
      
      public function addToScene() : void
      {
         var renderSystem:name_44 = null;
         if(!this.var_426)
         {
            renderSystem = this.gameKernel.name_5();
            if(this.localPlayer)
            {
               this.var_505.name_615();
            }
            this.var_505.name_611(renderSystem.method_46());
            renderSystem.method_63(this);
            this.var_426 = true;
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.var_426)
         {
            this.var_505.name_618();
            this.gameKernel.name_5().method_64(this);
            this.var_426 = false;
         }
      }
      
      public function setHealth(health:Number) : void
      {
         this.var_505.setHealth(health);
      }
      
      public function method_526(rankId:int) : void
      {
         this.var_505.method_526(rankId);
      }
      
      public function render() : void
      {
         this.chassisComponent.name_503(position);
         position.transform4(this.chassisComponent.name_502());
         if(this.localPlayer && this.var_442 != null)
         {
            this.var_505.name_616(this.var_442.method_396() * 100);
         }
         else
         {
            position.z += REMOTE_LABEL_OFFSET_Z;
         }
         this.titleRenderer.name_614(entity,this);
         this.var_505.update(position,name_182.time,name_182.timeDelta);
      }
      
      public function getTitle() : name_607
      {
         return this.var_505;
      }
   }
}

