package alternativa.tanks.game.usertitle.component
{
   import alternativa.math.Vector3;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.EventStates;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.subsystems.rendersystem.IRenderer;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
   import alternativa.tanks.game.usertitle.IRankIcon;
   import alternativa.tanks.game.usertitle.IUserTitleRenderer;
   import alternativa.tanks.game.usertitle.UserTitle;
   import alternativa.tanks.game.weapons.IWeapon;
   
   public class UserTitleComponent extends EntityComponent implements IRenderer
   {
      private static const REMOTE_LABEL_OFFSET_Z:int = 200;
      
      private static var position:Vector3 = new Vector3();
      
      private var §_-Xa§:UserTitle;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var §_-lp§:IWeapon;
      
      private var localPlayer:Boolean;
      
      private var §_-z§:EventStates;
      
      private var gameKernel:GameKernel;
      
      private var §case §:Boolean;
      
      private var §_-S3§:VisibleState;
      
      private var titleRenderer:IUserTitleRenderer;
      
      public function UserTitleComponent(maxHealth:int, rankIcon:IRankIcon, name:String, localPlayer:Boolean, label:IUserName, configFlags:int, titleRenderer:IUserTitleRenderer)
      {
         super();
         this.§_-Xa§ = new UserTitle(maxHealth,rankIcon,label);
         this.localPlayer = localPlayer;
         this.titleRenderer = titleRenderer;
         this.§_-Xa§.setLabelText(name);
         this.§_-Xa§.setConfiguration(configFlags);
      }
      
      public function isOnScene() : Boolean
      {
         return this.§case §;
      }
      
      public function isLocalPlayer() : Boolean
      {
         return this.localPlayer;
      }
      
      public function setMaxHealth(maxHealth:int) : void
      {
         this.§_-Xa§.setMaxHealth(maxHealth);
      }
      
      public function showIndicator(indicatorId:int, duration:int) : void
      {
         this.§_-Xa§.showIndicator(indicatorId,duration);
      }
      
      public function hideIndicator(indicatorId:int) : void
      {
         this.§_-Xa§.hideIndicator(indicatorId);
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.§_-lp§ = IWeapon(entity.getComponent(IWeapon));
         this.§_-z§ = new EventStates();
         this.§_-S3§ = new VisibleState(this);
         this.§_-z§.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,this.§_-S3§);
         this.§_-z§.setEventState(entity,TankEvents.SET_ACTIVE_STATE,this.§_-S3§);
         this.§_-z§.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         var offSceneState:OffSceneState = new OffSceneState(this);
         this.§_-z§.setEventState(entity,TankEvents.SET_RESPAWN_STATE,offSceneState);
         this.§_-z§.§_-Ah§ = offSceneState;
         entity.addEventHandler(TankEvents.SET_HEALTH,this.onSetHealth);
      }
      
      private function onSetHealth(eventType:String, data:*) : void
      {
         this.setHealth(Number(data));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.§_-Xa§.setResourceManager(gameKernel.getRenderSystem());
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.§_-z§.§_-Ah§.stop();
         this.removeFromScene();
      }
      
      public function addToScene() : void
      {
         var renderSystem:RenderSystem = null;
         if(!this.§case §)
         {
            renderSystem = this.gameKernel.getRenderSystem();
            if(this.localPlayer)
            {
               this.§_-Xa§.setLocal();
            }
            this.§_-Xa§.addToContainer(renderSystem.getDynamicObjectsContainer());
            renderSystem.addRenderer(this);
            this.§case § = true;
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.§case §)
         {
            this.§_-Xa§.removeFromContainer();
            this.gameKernel.getRenderSystem().removeRenderer(this);
            this.§case § = false;
         }
      }
      
      public function setHealth(health:Number) : void
      {
         this.§_-Xa§.setHealth(health);
      }
      
      public function setRank(rankId:int) : void
      {
         this.§_-Xa§.setRank(rankId);
      }
      
      public function render() : void
      {
         this.chassisComponent.getTurretMountPoint(position);
         position.transform4(this.chassisComponent.getInterpolatedMatrix());
         if(this.localPlayer && this.§_-lp§ != null)
         {
            this.§_-Xa§.setWeaponStatus(this.§_-lp§.getStatus() * 100);
         }
         else
         {
            position.z += REMOTE_LABEL_OFFSET_Z;
         }
         this.titleRenderer.renderUserTitle(entity,this);
         this.§_-Xa§.update(position,TimeSystem.time,TimeSystem.timeDelta);
      }
      
      public function getTitle() : UserTitle
      {
         return this.§_-Xa§;
      }
   }
}

