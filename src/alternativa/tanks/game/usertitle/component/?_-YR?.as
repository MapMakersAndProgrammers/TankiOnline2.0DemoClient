package alternativa.tanks.game.usertitle.component
{
   import §_-78§.§_-M2§;
   import §_-7A§.§_-Is§;
   import §_-az§.§_-2J§;
   import §_-az§.§_-AG§;
   import §_-dz§.§_-lm§;
   import §_-e6§.§_-1I§;
   import §_-e6§.§_-Kn§;
   import §_-lS§.§_-h2§;
   import §_-nl§.§_-bj§;
   import alternativa.tanks.game.usertitle.§_-C6§;
   import alternativa.tanks.game.usertitle.§_-fe§;
   import alternativa.tanks.game.usertitle.§class§;
   import §default§.§_-kU§;
   
   public class §_-YR§ extends §_-2J§ implements §_-Kn§
   {
      private static const REMOTE_LABEL_OFFSET_Z:int = 200;
      
      private static var position:§_-bj§ = new §_-bj§();
      
      private var §_-Xa§:§class§;
      
      private var chassisComponent:§_-Is§;
      
      private var §_-lp§:§_-lm§;
      
      private var localPlayer:Boolean;
      
      private var §_-z§:§_-M2§;
      
      private var gameKernel:§_-AG§;
      
      private var §case §:Boolean;
      
      private var §_-S3§:§_-Up§;
      
      private var titleRenderer:§_-C6§;
      
      public function §_-YR§(maxHealth:int, rankIcon:§_-fe§, name:String, localPlayer:Boolean, label:§_-3v§, configFlags:int, titleRenderer:§_-C6§)
      {
         super();
         this.§_-Xa§ = new §class§(maxHealth,rankIcon,label);
         this.localPlayer = localPlayer;
         this.titleRenderer = titleRenderer;
         this.§_-Xa§.§_-03§(name);
         this.§_-Xa§.§_-ag§(configFlags);
      }
      
      public function §_-l-§() : Boolean
      {
         return this.§case §;
      }
      
      public function §_-Vj§() : Boolean
      {
         return this.localPlayer;
      }
      
      public function §_-a7§(maxHealth:int) : void
      {
         this.§_-Xa§.§_-a7§(maxHealth);
      }
      
      public function §_-0W§(indicatorId:int, duration:int) : void
      {
         this.§_-Xa§.§_-0W§(indicatorId,duration);
      }
      
      public function §_-kd§(indicatorId:int) : void
      {
         this.§_-Xa§.§_-kd§(indicatorId);
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = §_-Is§(entity.getComponentStrict(§_-Is§));
         this.§_-lp§ = §_-lm§(entity.getComponent(§_-lm§));
         this.§_-z§ = new §_-M2§();
         this.§_-S3§ = new §_-Up§(this);
         this.§_-z§.§_-W§(entity,§_-kU§.SET_ACTIVATING_STATE,this.§_-S3§);
         this.§_-z§.§_-W§(entity,§_-kU§.SET_ACTIVE_STATE,this.§_-S3§);
         this.§_-z§.§_-W§(entity,§_-kU§.SET_DEAD_STATE,new §_-Rd§(this));
         var offSceneState:§_-po§ = new §_-po§(this);
         this.§_-z§.§_-W§(entity,§_-kU§.SET_RESPAWN_STATE,offSceneState);
         this.§_-z§.§_-Ah§ = offSceneState;
         entity.addEventHandler(§_-kU§.SET_HEALTH,this.§_-RO§);
      }
      
      private function §_-RO§(eventType:String, data:*) : void
      {
         this.setHealth(Number(data));
      }
      
      override public function addToGame(gameKernel:§_-AG§) : void
      {
         this.gameKernel = gameKernel;
         this.§_-Xa§.§_-58§(gameKernel.§_-DZ§());
      }
      
      override public function removeFromGame(gameKernel:§_-AG§) : void
      {
         this.§_-z§.§_-Ah§.stop();
         this.removeFromScene();
      }
      
      public function addToScene() : void
      {
         var renderSystem:§_-1I§ = null;
         if(!this.§case §)
         {
            renderSystem = this.gameKernel.§_-DZ§();
            if(this.localPlayer)
            {
               this.§_-Xa§.§_-S5§();
            }
            this.§_-Xa§.§_-p6§(renderSystem.§_-Bj§());
            renderSystem.§_-mA§(this);
            this.§case § = true;
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.§case §)
         {
            this.§_-Xa§.§_-Md§();
            this.gameKernel.§_-DZ§().§_-EI§(this);
            this.§case § = false;
         }
      }
      
      public function setHealth(health:Number) : void
      {
         this.§_-Xa§.setHealth(health);
      }
      
      public function §_-Qx§(rankId:int) : void
      {
         this.§_-Xa§.§_-Qx§(rankId);
      }
      
      public function render() : void
      {
         this.chassisComponent.§_-Cj§(position);
         position.transform4(this.chassisComponent.§_-Cd§());
         if(this.localPlayer && this.§_-lp§ != null)
         {
            this.§_-Xa§.§_-XE§(this.§_-lp§.§_-j0§() * 100);
         }
         else
         {
            position.z += REMOTE_LABEL_OFFSET_Z;
         }
         this.titleRenderer.§_-hh§(entity,this);
         this.§_-Xa§.update(position,§_-h2§.time,§_-h2§.timeDelta);
      }
      
      public function getTitle() : §class§
      {
         return this.§_-Xa§;
      }
   }
}

