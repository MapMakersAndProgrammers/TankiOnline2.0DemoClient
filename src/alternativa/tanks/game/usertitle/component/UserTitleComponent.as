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
      
      private var name_Xa:UserTitle;
      
      private var chassisComponent:IChassisPhysicsComponent;
      
      private var name_lp:IWeapon;
      
      private var localPlayer:Boolean;
      
      private var name_z:EventStates;
      
      private var gameKernel:GameKernel;
      
      private var name_case:Boolean;
      
      private var name_S3:VisibleState;
      
      private var titleRenderer:IUserTitleRenderer;
      
      public function UserTitleComponent(maxHealth:int, rankIcon:IRankIcon, name:String, localPlayer:Boolean, label:IUserName, configFlags:int, titleRenderer:IUserTitleRenderer)
      {
         super();
         this.name_Xa = new UserTitle(maxHealth,rankIcon,label);
         this.localPlayer = localPlayer;
         this.titleRenderer = titleRenderer;
         this.name_Xa.setLabelText(name);
         this.name_Xa.setConfiguration(configFlags);
      }
      
      public function isOnScene() : Boolean
      {
         return this.name_case;
      }
      
      public function isLocalPlayer() : Boolean
      {
         return this.localPlayer;
      }
      
      public function setMaxHealth(maxHealth:int) : void
      {
         this.name_Xa.setMaxHealth(maxHealth);
      }
      
      public function showIndicator(indicatorId:int, duration:int) : void
      {
         this.name_Xa.showIndicator(indicatorId,duration);
      }
      
      public function hideIndicator(indicatorId:int) : void
      {
         this.name_Xa.hideIndicator(indicatorId);
      }
      
      override public function initComponent() : void
      {
         this.chassisComponent = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
         this.name_lp = IWeapon(entity.getComponent(IWeapon));
         this.name_z = new EventStates();
         this.name_S3 = new VisibleState(this);
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVATING_STATE,this.name_S3);
         this.name_z.setEventState(entity,TankEvents.SET_ACTIVE_STATE,this.name_S3);
         this.name_z.setEventState(entity,TankEvents.SET_DEAD_STATE,new DeadState(this));
         var offSceneState:OffSceneState = new OffSceneState(this);
         this.name_z.setEventState(entity,TankEvents.SET_RESPAWN_STATE,offSceneState);
         this.name_z.name_Ah = offSceneState;
         entity.addEventHandler(TankEvents.SET_HEALTH,this.onSetHealth);
      }
      
      private function onSetHealth(eventType:String, data:*) : void
      {
         this.setHealth(Number(data));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         this.name_Xa.setResourceManager(gameKernel.getRenderSystem());
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.name_z.name_Ah.stop();
         this.removeFromScene();
      }
      
      public function addToScene() : void
      {
         var renderSystem:RenderSystem = null;
         if(!this.name_case)
         {
            renderSystem = this.gameKernel.getRenderSystem();
            if(this.localPlayer)
            {
               this.name_Xa.setLocal();
            }
            this.name_Xa.addToContainer(renderSystem.getDynamicObjectsContainer());
            renderSystem.addRenderer(this);
            this.name_case = true;
         }
      }
      
      public function removeFromScene() : void
      {
         if(this.name_case)
         {
            this.name_Xa.removeFromContainer();
            this.gameKernel.getRenderSystem().removeRenderer(this);
            this.name_case = false;
         }
      }
      
      public function setHealth(health:Number) : void
      {
         this.name_Xa.setHealth(health);
      }
      
      public function setRank(rankId:int) : void
      {
         this.name_Xa.setRank(rankId);
      }
      
      public function render() : void
      {
         this.chassisComponent.getTurretMountPoint(position);
         position.transform4(this.chassisComponent.getInterpolatedMatrix());
         if(this.localPlayer && this.name_lp != null)
         {
            this.name_Xa.setWeaponStatus(this.name_lp.getStatus() * 100);
         }
         else
         {
            position.z += REMOTE_LABEL_OFFSET_Z;
         }
         this.titleRenderer.renderUserTitle(entity,this);
         this.name_Xa.update(position,TimeSystem.time,TimeSystem.timeDelta);
      }
      
      public function getTitle() : UserTitle
      {
         return this.name_Xa;
      }
   }
}

