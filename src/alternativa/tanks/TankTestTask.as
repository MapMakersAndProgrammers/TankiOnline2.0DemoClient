package alternativa.tanks
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Resource;
   import alternativa.engine3d.core.events.MouseEvent3D;
   import alternativa.engine3d.effects.TextureAtlas;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.primitives.Box;
   import alternativa.engine3d.resources.ATFTextureResource;
   import alternativa.engine3d.resources.BitmapCubeTextureResource;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.physics.Body;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.display.DebugPanel;
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.GameEvents;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.camera.FollowCameraController;
   import alternativa.tanks.game.camera.FreeCameraController;
   import alternativa.tanks.game.camera.OrbitCameraController;
   import alternativa.tanks.game.effects.AnimatedPlaneEffect;
   import alternativa.tanks.game.effects.AnimatedSpriteEffect;
   import alternativa.tanks.game.effects.ColorTransformEntry;
   import alternativa.tanks.game.effects.Fire;
   import alternativa.tanks.game.effects.MovingAnimatedSprite;
   import alternativa.tanks.game.effects.SimpleWeaponShotSFXComponent;
   import alternativa.tanks.game.effects.debug.FloatingTextEffect;
   import alternativa.tanks.game.entities.tank.BasicWeaponManualControlComponent;
   import alternativa.tanks.game.entities.tank.TankControlComponent;
   import alternativa.tanks.game.entities.tank.TankEvents;
   import alternativa.tanks.game.entities.tank.TankHull;
   import alternativa.tanks.game.entities.tank.TankPart;
   import alternativa.tanks.game.entities.tank.TankPartMaterials;
   import alternativa.tanks.game.entities.tank.TankTurret;
   import alternativa.tanks.game.entities.tank.TankWheel;
   import alternativa.tanks.game.entities.tank.TrackedChassisManualControlComponent;
   import alternativa.tanks.game.entities.tank.TurretManualControlComponent;
   import alternativa.tanks.game.entities.tank.graphics.GraphicsControlComponent;
   import alternativa.tanks.game.entities.tank.graphics.PhysicsRendererComponent;
   import alternativa.tanks.game.entities.tank.graphics.TankExplosionComponent;
   import alternativa.tanks.game.entities.tank.graphics.chassis.tracked.TrackedChassisGraphicsComponent;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.turret.TurretGraphicsComponent;
   import alternativa.tanks.game.entities.tank.parsers.TankHullParser;
   import alternativa.tanks.game.entities.tank.parsers.TankPartParser;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.InterpolationComponent;
   import alternativa.tanks.game.entities.tank.physics.chassis.tracked.legacy.LegacyTrackedChassisComponent;
   import alternativa.tanks.game.entities.tank.physics.turret.TurretPhysicsComponent;
   import alternativa.tanks.game.physics.CollisionGroup;
   import alternativa.tanks.game.subsystems.battlemessages.BattleMessagesSubsystem;
   import alternativa.tanks.game.subsystems.eventsystem.IEventSystem;
   import alternativa.tanks.game.subsystems.eventsystem.IGameEventListener;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.subsystems.rendersystem.ICameraController;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.tanks.game.usertitle.component.UserTitleComponent;
   import alternativa.tanks.game.utils.datacache.DataCache;
   import alternativa.tanks.game.weapons.ContinuousActionGunPlatformComponent;
   import alternativa.tanks.game.weapons.EnergyShotWeaponComponent;
   import alternativa.tanks.game.weapons.IGenericAmmunition;
   import alternativa.tanks.game.weapons.IWeaponDistanceWeakening;
   import alternativa.tanks.game.weapons.InstantShotWeaponComponent;
   import alternativa.tanks.game.weapons.SimpleTargetEvaluator;
   import alternativa.tanks.game.weapons.WeaponConst;
   import alternativa.tanks.game.weapons.ammunition.energy.EnergyAmmunitionComponent;
   import alternativa.tanks.game.weapons.ammunition.energy.IEnergyRoundEffectsFactory;
   import alternativa.tanks.game.weapons.ammunition.plasma.PlasmaRoundEffectsFactory;
   import alternativa.tanks.game.weapons.ammunition.railgun.debug.DebugRailgunTargetEvaluator;
   import alternativa.tanks.game.weapons.ammunition.splashhit.debug.DebugSplashDamageAmmo;
   import alternativa.tanks.game.weapons.ammunition.splashhit.debug.DebugSplashDamageEffects;
   import alternativa.tanks.game.weapons.conicareadamage.ConicAreaWeaponComponent;
   import alternativa.tanks.game.weapons.debug.DebugWeaponDistanceWeakening;
   import alternativa.tanks.game.weapons.flamethrower.FlamethrowerSFXComponent;
   import alternativa.tanks.game.weapons.flamethrower.FlamethrowerSFXData;
   import alternativa.tanks.game.weapons.targeting.ConicAreaTargetingSystem;
   import alternativa.tanks.game.weapons.targeting.EnergyTargetingSystem;
   import alternativa.tanks.game.weapons.targeting.GenericTargetingSystem;
   import alternativa.tanks.game.weapons.targeting.IGenericTargetEvaluator;
   import alternativa.tanks.game.weapons.targeting.RailgunTargetingSystem;
   import alternativa.tanks.game.weapons.thunder.ThunderShotEffectComponent;
   import alternativa.tanks.game.weapons.thunder.effects.ThunderShotEffect;
   import alternativa.tanks.lightsmanager.LightsManager;
   import alternativa.tanks.sounds.ChassisSoundCallback;
   import alternativa.tanks.sounds.FlamethrowerSoundWeaponCallback;
   import alternativa.tanks.sounds.SoundInstantShotWeaponCallback;
   import alternativa.tanks.sounds.TurretSoundCallback;
   import alternativa.tanks.utils.TextureUtils;
   import alternativa.utils.ByteArrayMap;
   import alternativa.utils.ColorUtils;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Vector3D;
   import flash.ui.Keyboard;
   import alternativa.engine3d.materials.StandardMaterial;
   
   use namespace alternativa3d;
   
   public class TankTestTask extends GameTask implements IGameEventListener
   {
      private static const DEAD_TEXTURE_ID:String = "dead";
      
      private static var conShockSize:ConsoleVarFloat = new ConsoleVarFloat("shock_size",1200,0,2000);
      
      private static var conShockSizeGrow:ConsoleVarFloat = new ConsoleVarFloat("shock_size_grow",200,0,2000);
      
      private static var conPysicsDebug:ConsoleVarInt = new ConsoleVarInt("physics_debug",0,0,1);
      
      private static var conMaxSpeed:ConsoleVarFloat = new ConsoleVarFloat("max_speed",800,0,2000);
      
      private static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
      
      private var config:Config;
      
      private var gameKernel:GameKernel;
      
      private var name_D1:int = 0;
      
      private var name_Dl:Vector.<Fire> = new Vector.<Fire>();
      
      private var tanks:Vector.<Entity>;
      
      private var name_Dx:int;
      
      private var name_LW:TextureAtlas;
      
      private var name_J4:TextureAtlas;
      
      private var name_FD:TextureAtlas;
      
      private var name_Qv:BitmapData;
      
      private var name_Wv:FollowCameraController;
      
      private var name_al:OrbitCameraController;
      
      private var freeCameraController:FreeCameraController;
      
      private var name_8c:ICameraController;
      
      private var name_Xq:LightsManager;
      
      private var name_34:DebugPanel;
      
      private var name_T2:FloatingTextEffect;
      
      private var name_pn:int;
      
      private var name_8m:int;
      
      private var name_lw:int;
      
      private var name_BT:TextureResourceCache;
      
      private var name_pb:MultiBitmapTextureResourceCache;
      
      private var name_fa:TextureResourceService;
      
      private var name_n6:BattleMessagesSubsystem;
      
      private var preloader:Preloader;
      
      private var name_3t:Entity;
      
      private var name_3u:DataCache = new DataCache();
      
      public function TankTestTask(param1:int, param2:Config, param3:GameKernel, param4:FreeCameraController, param5:Preloader)
      {
         super(param1);
         this.preloader = param5;
         this.config = param2;
         this.gameKernel = param3;
         this.freeCameraController = param4;
         this.tanks = new Vector.<Entity>();
         this.name_Dx = -1;
         this.name_Qv = new BitmapData(1,1);
         this.name_Qv.setPixel(0,0,11141120);
         this.name_8c = param4;
         this.name_BT = new TextureResourceCache(param2.name_WX);
         this.name_pb = new MultiBitmapTextureResourceCache(param2.name_WX);
         this.name_fa = new TextureResourceService(param3);
         TanksTestingTool.testTask = this;
      }
      
      override public function start() : void
      {
         var _loc1_:IInput = IInput(name_Uw.getTaskInterface(IInput));
         _loc1_.addKeyboardListener(KeyboardEventType.KEY_DOWN,this.onKeyDown);
         var _loc2_:IEventSystem = IEventSystem(name_Uw.getTaskInterface(IEventSystem));
         _loc2_.addEventListener(TrackedChassisGraphicsComponent.TANK_CLICK,this);
         this.name_Wv = new FollowCameraController(this.gameKernel.getRenderSystem().getCamera(),this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector,CollisionGroup.STATIC,_loc1_);
         this.name_al = new OrbitCameraController(this.gameKernel.getRenderSystem().getCamera(),this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector,CollisionGroup.STATIC,_loc1_);
         this.name_Xq = new LightsManager(this.gameKernel.getRenderSystem());
         this.name_34 = new DebugPanel();
         this.gameKernel.stage.addChild(this.name_34);
         var _loc3_:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         _loc3_.setCommandHandler("addtank",this.consoleAddTankHandler);
         var _loc4_:XMLList = this.config.xml.elements("console-commands");
         if(_loc4_.length() > 0)
         {
            this.executeConsoleCommands(_loc3_,this.config.xml.elements("console-commands")[0].toString());
         }
         _loc3_.setCommandHandler("lstanks",this.listTanks);
         this.name_n6 = new BattleMessagesSubsystem(GameKernel.RENDER_SYSTEM_PRIORITY + 1,10,this.gameKernel.stage,0,0);
         this.gameKernel.addTask(this.name_n6);
         this.gameKernel.getEventSystem().addEventListener(GameEvents.MAP_COMPLETE,this);
      }
      
      private function get activeTank() : Entity
      {
         return this.name_Dx >= 0 ? this.tanks[this.name_Dx] : null;
      }
      
      private function selectTank(param1:int) : void
      {
         if(param1 >= 0 && param1 < this.tanks.length)
         {
            if(this.activeTank != null)
            {
               this.activeTank.dispatchEvent(TankEvents.SET_DISABLED_STATE);
            }
            this.name_Dx = param1;
            this.activeTank.dispatchEvent(TankEvents.SET_ACTIVE_STATE);
            if(this.name_8c == this.name_Wv)
            {
               this.name_Wv.setTarget(this.activeTank);
            }
            if(this.name_8c == this.name_al)
            {
               this.name_al.setTarget(this.activeTank);
            }
         }
      }
      
      public function selectNextTank() : void
      {
         if(this.tanks.length > 0)
         {
            this.selectTank((this.name_Dx + 1) % this.tanks.length);
         }
         if(this.name_8c != this.name_Wv)
         {
            this.setCameraController(this.name_Wv);
         }
      }
      
      private function selectPrevTank() : void
      {
         var _loc1_:int = 0;
         if(this.tanks.length > 0)
         {
            _loc1_ = this.name_Dx - 1;
            if(_loc1_ < 0)
            {
               _loc1_ = this.tanks.length - 1;
            }
            this.selectTank(_loc1_);
         }
      }
      
      private function executeConsoleCommands(param1:IConsole, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc3_:Array = param2.split(/\r*\n/);
         for each(_loc4_ in _loc3_)
         {
            param1.executeCommand(_loc4_);
         }
      }
      
      private function consoleAddTankHandler(param1:IConsole, param2:Array) : void
      {
         this.addTank(TankParams.fromArray(param2));
      }
      
      private function onKeyDown(param1:KeyboardEventType, param2:uint) : void
      {
         var _loc3_:RenderSystem = null;
         var _loc4_:int = 0;
         switch(param2)
         {
            case Keyboard.Q:
               _loc3_ = this.gameKernel.getRenderSystem();
               _loc4_ = _loc3_.getAnitaliasing();
               _loc3_.setAntialiasing(_loc4_ == 0 ? 4 : 0);
               break;
            case Keyboard.M:
            case Keyboard.BACKSLASH:
               this.switchCameraController();
               break;
            case Keyboard.N:
               if(this.name_8c == this.freeCameraController)
               {
                  FreeCameraController.targeted = !FreeCameraController.targeted;
                  break;
               }
               FreeCameraController.targeted = true;
               this.setCameraController(this.freeCameraController);
               break;
            case Keyboard.ENTER:
               this.selectNextTank();
         }
      }
      
      private function jump() : void
      {
         var _loc1_:LegacyTrackedChassisComponent = null;
         var _loc2_:Body = null;
         if(this.activeTank != null)
         {
            _loc1_ = LegacyTrackedChassisComponent(this.activeTank.getComponent(LegacyTrackedChassisComponent));
            _loc2_ = _loc1_.body;
            _loc2_.state.velocity.z = 1000;
         }
      }
      
      private function toggleTankTitle() : void
      {
         var _loc2_:UserTitleComponent = null;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = UserTitleComponent(_loc1_.getComponent(UserTitleComponent));
            if(_loc2_.isOnScene())
            {
               _loc2_.removeFromScene();
            }
            else
            {
               _loc2_.addToScene();
            }
         }
      }
      
      private function createRandomBattleMessage() : void
      {
         this.name_n6.addMessage("Message: " + Math.random(),ColorUtils.random());
      }
      
      private function controlKeyPressed() : Boolean
      {
         return this.gameKernel.getInputSystem().keyPressed(Keyboard.CONTROL);
      }
      
      private function startIndicator(param1:int, param2:Boolean) : void
      {
         var _loc3_:UserTitleComponent = null;
         if(this.activeTank != null)
         {
            _loc3_ = UserTitleComponent(this.activeTank.getComponentStrict(UserTitleComponent));
            if(param2)
            {
               _loc3_.showIndicator(param1,10000);
            }
            else
            {
               _loc3_.hideIndicator(param1);
            }
         }
      }
      
      private function createRandomAnimatedSprite() : void
      {
         var _loc3_:TextureResource = null;
         var _loc4_:Vector.<Material> = null;
         var _loc5_:int = 0;
         var _loc8_:TextureMaterial = null;
         var _loc1_:Vector.<TextureResource> = this.name_pb.getFrames("thunder/explosion");
         var _loc2_:RenderSystem = this.gameKernel.getRenderSystem();
         for each(_loc3_ in _loc1_)
         {
            _loc2_.useResource(_loc3_);
         }
         _loc4_ = new Vector.<Material>(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc8_ = new TextureMaterial(_loc1_[_loc5_]);
            _loc8_.transparentPass = true;
            _loc4_[_loc5_] = _loc8_;
            _loc5_++;
         }
         var _loc6_:AnimatedSpriteEffect = AnimatedSpriteEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedSpriteEffect));
         var _loc7_:Vector3 = new Vector3(Math.random() * 3000,Math.random() * 3000,1000 + Math.random() * 3000);
         _loc6_.init(300,300,_loc4_,_loc7_,0,0,30,true);
         _loc2_.addEffect(_loc6_);
      }
      
      private function createThunderShotEffect() : void
      {
         var _loc1_:TextureResource = this.name_BT.getResource("smoky/diffuse");
         var _loc2_:TextureResource = this.name_BT.getResource("smoky/opacity");
         var _loc3_:RenderSystem = this.gameKernel.getRenderSystem();
         _loc3_.useResource(_loc1_);
         _loc3_.useResource(_loc2_);
         var _loc4_:ThunderShotEffect = ThunderShotEffect(this.gameKernel.getObjectPoolManager().getObject(ThunderShotEffect));
         _loc4_.init(new DummyTurret(),_loc1_,_loc2_);
         _loc3_.addEffect(_loc4_);
      }
      
      private function selectPrevTurret() : void
      {
         --this.name_8m;
         if(this.name_8m < 0)
         {
            this.name_8m += this.config.tankParts.numTurrets;
         }
         this.rebuildActiveTank();
      }
      
      private function selectNextTurret() : void
      {
         this.name_8m = (this.name_8m + 1) % this.config.tankParts.numTurrets;
         this.rebuildActiveTank();
      }
      
      private function selectPrevHull() : void
      {
         --this.name_pn;
         if(this.name_pn < 0)
         {
            this.name_pn += this.config.tankParts.numHulls;
         }
         this.rebuildActiveTank();
      }
      
      public function selectNextHull() : void
      {
         this.name_pn = (this.name_pn + 1) % this.config.tankParts.numHulls;
         this.rebuildActiveTank();
      }
      
      private function rebuildActiveTank() : void
      {
         var _loc2_:TankParams = null;
         var _loc3_:Entity = null;
         var _loc4_:IChassisPhysicsComponent = null;
         var _loc5_:IChassisPhysicsComponent = null;
         var _loc6_:Vector3 = null;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            this.removeActiveTank();
            _loc2_ = new TankParams();
            _loc2_.hull = this.config.tankParts.getHull(this.name_pn).id;
            _loc2_.turret = this.config.tankParts.getTurret(this.name_8m).id;
            _loc2_.coloring = this.name_lw;
            _loc3_ = this.addTank(_loc2_);
            this.selectTank(this.tanks.length - 1);
            _loc4_ = IChassisPhysicsComponent(_loc1_.getComponentStrict(IChassisPhysicsComponent));
            _loc5_ = IChassisPhysicsComponent(_loc3_.getComponentStrict(IChassisPhysicsComponent));
            _loc5_.getBody().setOrientation(_loc4_.getBody().state.orientation);
            _loc6_ = _loc4_.getBody().state.position.clone();
            _loc6_.z += 200;
            _loc5_.getBody().setPosition(_loc6_);
         }
      }
      
      override public function run() : void
      {
      }
      
      private function addDebugMessage() : void
      {
         var _loc1_:TurretGraphicsComponent = null;
         if(this.activeTank != null)
         {
            if(this.name_T2 == null)
            {
               this.name_T2 = FloatingTextEffect(this.gameKernel.getObjectPoolManager().getObject(FloatingTextEffect));
               _loc1_ = TurretGraphicsComponent(this.activeTank.getComponentStrict(TurretGraphicsComponent));
               this.name_T2.init(5000,_loc1_.getObject3D(),this.onFloatingTextEffectDestroy);
               this.gameKernel.getRenderSystem().addEffect(this.name_T2);
            }
            this.name_T2.addMessage("Message " + Math.random(),65280);
         }
      }
      
      public function onGameEvent(param1:String, param2:*) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<Resource> = null;
         var _loc5_:Vector.<Resource> = null;
         var _loc6_:TankParams = null;
         var _loc7_:XMLList = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Entity = null;
         var _loc11_:BitmapCubeTextureResource = null;
         var _loc12_:ATFTextureResource = null;
         switch(param1)
         {
            case TrackedChassisGraphicsComponent.TANK_CLICK:
               _loc3_ = int(this.tanks.indexOf(Entity(param2)));
               if(_loc3_ >= 0)
               {
                  this.selectTank(_loc3_);
               }
               break;
            case GameEvents.MAP_COMPLETE:
               this.setCameraController(this.name_Wv);
               if(this.config.xml.user.length() > 0)
               {
                  _loc6_ = TankParams.fromXML(this.config.xml.user[0],true);
                  this.name_lw = _loc6_.coloring;
                  this.name_pn = this.config.tankParts.getHullIndex(_loc6_.hull);
                  this.name_8m = this.config.tankParts.getTurretIndex(_loc6_.turret);
                  if(this.name_pn < 0)
                  {
                     throw new ArgumentError("bad hull: " + _loc6_.hull);
                  }
                  if(this.name_8m < 0)
                  {
                     throw new ArgumentError("bad turret: " + _loc6_.turret);
                  }
                  this.addTank(_loc6_);
               }
               else
               {
                  this.addTank(TankParams.defaultTankParams);
               }
               this.selectTank(this.tanks.length - 1);
               if(this.config.xml.tanks.length() > 0)
               {
                  _loc7_ = this.config.xml.tanks[0].tank;
                  _loc8_ = 0;
                  _loc9_ = int(_loc7_.length());
                  while(_loc8_ < _loc9_)
                  {
                     _loc10_ = this.addTank(TankParams.fromXML(_loc7_[_loc8_]));
                     _loc10_.dispatchEvent(TankEvents.SET_ACTIVE_STATE);
                     _loc10_.dispatchEvent(TankEvents.SET_DISABLED_STATE);
                     _loc8_++;
                  }
               }
               _loc4_ = this.gameKernel.getRenderSystem().getRootContainer().getResources(true,BitmapCubeTextureResource);
               if(_loc4_.length > 0)
               {
                  _loc11_ = _loc4_[0] as BitmapCubeTextureResource;
                  _loc11_.left = this.config.name_WX.getTexture("left_01") as BitmapData;
                  _loc11_.right = this.config.name_WX.getTexture("right_01") as BitmapData;
                  _loc11_.back = this.config.name_WX.getTexture("back_01") as BitmapData;
                  _loc11_.front = this.config.name_WX.getTexture("front_01") as BitmapData;
                  _loc11_.top = this.config.name_WX.getTexture("top_01") as BitmapData;
                  _loc11_.bottom = this.config.name_WX.getTexture("bottom_01") as BitmapData;
                  this.gameKernel.getRenderSystem().useResource(_loc11_);
               }
               this.createFire();
               this.config.clear();
               _loc5_ = this.gameKernel.getRenderSystem().getRootContainer().getResources(true,ATFTextureResource);
               for each(_loc12_ in _loc5_)
               {
                  _loc12_.data.clear();
                  _loc12_.data = null;
               }
               this.preloader.setProgress(1);
         }
      }
      
      private function onMouseDown(param1:MouseEvent3D) : void
      {
         var _loc2_:Vector3D = Object3D(param1.target).localToGlobal(new Vector3D(param1.localX,param1.localY,param1.localZ));
         log.log("mouse","click pos %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function precacheTank() : void
      {
      }
      
      private function addCachedTank() : void
      {
         this.gameKernel.addEntity(this.name_3t);
         this.tanks.push(this.name_3t);
         this.selectTank(this.tanks.length - 1);
      }
      
      private function addTank(param1:TankParams) : Entity
      {
         var _loc2_:Entity = this.createTank(param1);
         this.gameKernel.addEntity(_loc2_);
         this.tanks.push(_loc2_);
         return _loc2_;
      }
      
      private function createTank(param1:TankParams) : Entity
      {
         var _loc2_:TankHull = this.config.tankParts.getHullByID(param1.hull);
         var _loc3_:TankTurret = this.config.tankParts.getTurretByID(param1.turret);
         var _loc4_:BitmapData = this.config.tankParts.getColormap(param1.coloring);
         var _loc5_:BitmapData = this.config.name_WX.getTexture(DEAD_TEXTURE_ID) as BitmapData;
         var _loc6_:Entity = new Entity(Entity.generateId());
         var _loc9_:LegacyTrackedChassisComponent = new LegacyTrackedChassisComponent(_loc2_,1000,80000);
         var _loc10_:int = conMaxSpeed.value;
         _loc9_.setMaxSpeed(_loc10_,true);
         _loc9_.setMaxTurnSpeed(2,true);
         _loc9_.setPosition(new Vector3(param1.x,param1.y,param1.z));
         _loc9_.body.setRotationXYZ(param1.rotationX / 180 * Math.PI,param1.rotationY / 180 * Math.PI,param1.rotationZ / 180 * Math.PI);
         var _loc12_:TrackedChassisGraphicsComponent = new TrackedChassisGraphicsComponent(_loc2_);
         _loc12_.setHullMaterials(this.getPartMaterials(_loc2_,_loc4_,_loc5_,6,6));
         _loc12_.setTracksMaterial(this.createTracksMaterial(_loc2_));
         _loc12_.setShadowMaterial(this.createShadowMaterial(_loc2_));
         _loc6_.addComponent(_loc9_);
         _loc6_.addComponent(_loc12_);
         _loc6_.addComponent(new TrackedChassisManualControlComponent(new ChassisSoundCallback(this.config.soundsLibrary)));
         var _loc13_:TankControlComponent = new TankControlComponent();
         _loc6_.addComponent(_loc13_);
         _loc6_.addComponent(new GraphicsControlComponent());
         _loc6_.addComponent(new InterpolationComponent());
         var _loc14_:TurretPhysicsComponent = new TurretPhysicsComponent(_loc3_,1,2);
         var _loc15_:TurretGraphicsComponent = new TurretGraphicsComponent(_loc3_);
         _loc15_.setTurretMaterials(this.getPartMaterials(_loc3_,_loc4_,_loc5_,3,3));
         _loc6_.addComponent(_loc14_);
         _loc6_.addComponent(_loc15_);
         _loc6_.addComponent(new TurretManualControlComponent(new TurretSoundCallback(this.config.soundsLibrary)));
         if(_loc3_.id.indexOf("Smoky") >= 0)
         {
            this.createSmoky(_loc6_);
         }
         else if(_loc3_.id.indexOf("Thunder") >= 0)
         {
            this.createThunder(_loc6_);
         }
         else
         {
            this.createContinuousActionGun(_loc6_);
         }
         _loc6_.addComponent(new BasicWeaponManualControlComponent());
         if(conPysicsDebug.value == 1)
         {
            _loc6_.addComponent(new PhysicsRendererComponent());
         }
         if(param1.isUser)
         {
         }
         var _loc16_:Vector.<Material> = this.getFrameMaterials(this.name_pb.getFrames("tank_explosion/shock_wave"));
         var _loc17_:Vector.<Material> = this.getFrameMaterials(this.name_pb.getFrames("tank_explosion/explosion"));
         var _loc18_:Vector.<Material> = this.getFrameMaterials(this.name_pb.getFrames("tank_explosion/smoke"));
         var _loc19_:TankExplosionComponent = new TankExplosionComponent(1200,200,_loc16_,_loc17_,_loc18_);
         _loc6_.addComponent(_loc19_);
         _loc6_.initComponents();
         return _loc6_;
      }
      
      private function tracePos() : void
      {
         var _loc1_:LegacyTrackedChassisComponent = LegacyTrackedChassisComponent(this.tanks[this.name_Dx].getComponent(LegacyTrackedChassisComponent));
         var _loc2_:Vector3 = new Vector3();
         _loc1_.name_UQ.getEulerAngles(_loc2_);
         _loc2_.x = _loc2_.x * 180 / Math.PI;
         _loc2_.y = _loc2_.y * 180 / Math.PI;
         _loc2_.z = _loc2_.z * 180 / Math.PI;
         log.log("tank","position %1 %2 %3",_loc1_.name_bi.x.toFixed(),_loc1_.name_bi.y.toFixed(),_loc1_.name_bi.z.toFixed());
         log.log("tank","rotation %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function createFire() : void
      {
         var _loc4_:XMLList = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         var _loc8_:Fire = null;
         var _loc9_:Array = null;
         var _loc1_:TextureResource = this.name_BT.getResource("fire/diffuse");
         var _loc2_:TextureResource = this.name_BT.getResource("fire/opacity");
         var _loc3_:RenderSystem = this.gameKernel.getRenderSystem();
         _loc3_.useResource(_loc1_);
         _loc3_.useResource(_loc2_);
         this.name_LW = new TextureAtlas(_loc1_,_loc2_,8,8,0,16,30,true);
         this.name_J4 = new TextureAtlas(_loc1_,_loc2_,8,8,16,16,30,true);
         this.name_FD = new TextureAtlas(_loc1_,_loc2_,8,8,32,32,45,true,0.5,0.5);
         if(this.config.xml.effects.length() > 0)
         {
            _loc4_ = this.config.xml.effects[0].fire;
            _loc5_ = 0;
            _loc6_ = int(_loc4_.length());
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc4_[_loc5_];
               _loc8_ = new Fire(this.name_LW,this.name_J4,this.name_FD,5,true);
               _loc9_ = _loc7_.@position.toString().split(/\s+/);
               _loc8_.position = new Vector3D(Number(_loc9_[0]),Number(_loc9_[1]),Number(_loc9_[2]));
               _loc8_.scale = Number(_loc7_.@scale);
               this.name_Dl.push(_loc8_);
               this.gameKernel.getRenderSystem().addA3DEffect(_loc8_);
               _loc5_++;
            }
         }
      }
      
      private function createTracksMaterial(param1:TankHull) : StandardMaterial
      {
         var _loc2_:ByteArrayMap = param1.textureData;
         var _loc3_:ATFTextureResource = this.name_fa.getCompressedTextureResource(_loc2_.getValue(TankHullParser.KEY_TRACKS_DIFFUSE));
         var _loc4_:ATFTextureResource = this.name_fa.getCompressedTextureResource(_loc2_.getValue(TankHullParser.KEY_TRACKS_NORMAL));
         var _loc5_:StandardMaterial = new StandardMaterial();
         _loc5_.glossiness = 65;
         _loc5_.specularPower = 0.6;
         _loc5_.diffuseMap = _loc3_;
         _loc5_.normalMap = _loc4_;
         if(_loc2_.getValue(TankHullParser.KEY_TRACKS_OPACITY) != null)
         {
            _loc5_.opacityMap = this.name_fa.getCompressedTextureResource(_loc2_.getValue(TankHullParser.KEY_TRACKS_OPACITY));
         }
         return _loc5_;
      }
      
      private function createShadowMaterial(param1:TankHull) : GiShadowMaterial
      {
         var _loc3_:ATFTextureResource = null;
         var _loc2_:ByteArrayMap = param1.textureData;
         if(_loc2_.getValue(TankHullParser.KEY_SHADOW) != null)
         {
            _loc3_ = this.name_fa.getCompressedTextureResource(_loc2_.getValue(TankHullParser.KEY_SHADOW));
            return new GiShadowMaterial(_loc3_);
         }
         return null;
      }
      
      private function createSmoky(param1:Entity) : void
      {
         var _loc9_:TextureResource = null;
         var _loc10_:Vector.<Material> = null;
         var _loc11_:int = 0;
         var _loc18_:TextureMaterial = null;
         var _loc3_:Number = 10000000 / 3;
         var _loc4_:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         var _loc5_:SimpleTargetEvaluator = new SimpleTargetEvaluator();
         var _loc6_:GenericTargetingSystem = new GenericTargetingSystem(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.setCollisionDetector(this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector);
         _loc6_.setTargetValidator(new SimpleTargetEvaluator());
         var _loc7_:Vector.<TextureResource> = this.name_pb.getFrames("thunder/explosion");
         var _loc8_:RenderSystem = this.gameKernel.getRenderSystem();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.useResource(_loc9_);
         }
         _loc10_ = new Vector.<Material>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new TextureMaterial(_loc7_[_loc11_]);
            _loc18_.transparentPass = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:TextureResource = this.name_BT.getResource("smoky/diffuse");
         var _loc13_:TextureResource = this.name_BT.getResource("smoky/opacity");
         _loc8_.useResource(_loc12_);
         _loc8_.useResource(_loc13_);
         DebugSplashDamageEffects.init(_loc12_,_loc13_);
         var _loc14_:IGenericAmmunition = new DebugSplashDamageAmmo(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:InstantShotWeaponComponent = new InstantShotWeaponComponent(1000,_loc3_,_loc6_,_loc14_,new SoundInstantShotWeaponCallback(this.config.soundsLibrary.getSound("smoky/shot")),true);
         _loc15_.enabled = true;
         param1.addComponent(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         ThunderShotEffectComponent.init(_loc12_,_loc13_);
         var _loc17_:ThunderShotEffectComponent = new ThunderShotEffectComponent(this.name_BT.getResource("thunder/shot"));
         param1.addComponent(_loc17_);
      }
      
      private function createThunder(param1:Entity) : void
      {
         var _loc9_:TextureResource = null;
         var _loc10_:Vector.<Material> = null;
         var _loc11_:int = 0;
         var _loc18_:TextureMaterial = null;
         var _loc4_:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         var _loc5_:SimpleTargetEvaluator = new SimpleTargetEvaluator();
         var _loc6_:GenericTargetingSystem = new GenericTargetingSystem(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.setCollisionDetector(this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector);
         _loc6_.setTargetValidator(new SimpleTargetEvaluator());
         var _loc7_:Vector.<TextureResource> = this.name_pb.getFrames("thunder/explosion");
         var _loc8_:RenderSystem = this.gameKernel.getRenderSystem();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.useResource(_loc9_);
         }
         _loc10_ = new Vector.<Material>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new TextureMaterial(_loc7_[_loc11_]);
            _loc18_.transparentPass = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:TextureResource = this.name_BT.getResource("smoky/diffuse");
         var _loc13_:TextureResource = this.name_BT.getResource("smoky/opacity");
         _loc8_.useResource(_loc12_);
         _loc8_.useResource(_loc13_);
         DebugSplashDamageEffects.init(_loc12_,_loc13_);
         var _loc14_:IGenericAmmunition = new DebugSplashDamageAmmo(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:InstantShotWeaponComponent = new InstantShotWeaponComponent(1000,3333333.3333333335,_loc6_,_loc14_,new SoundInstantShotWeaponCallback(this.config.soundsLibrary.getSound("thunder/shot")),true);
         _loc15_.enabled = true;
         param1.addComponent(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         ThunderShotEffectComponent.init(_loc12_,_loc13_);
         var _loc17_:ThunderShotEffectComponent = new ThunderShotEffectComponent(this.name_BT.getResource("thunder/shot"));
         param1.addComponent(_loc17_);
      }
      
      private function createRailgun(param1:Entity) : void
      {
         var _loc5_:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         var _loc6_:DebugRailgunTargetEvaluator = new DebugRailgunTargetEvaluator();
         var _loc7_:RailgunTargetingSystem = new RailgunTargetingSystem(Math.PI / 9,20,Math.PI / 9,20,_loc5_,_loc6_);
      }
      
      private function createEnergyGun(param1:Entity) : void
      {
         var _loc9_:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         var _loc10_:SimpleTargetEvaluator = new SimpleTargetEvaluator();
         var _loc11_:EnergyTargetingSystem = new EnergyTargetingSystem(Math.PI / 4,20,Math.PI / 4,20,100,_loc9_,_loc10_);
         var _loc13_:Number = WeaponConst.BASE_FORCE;
         var _loc14_:IWeaponDistanceWeakening = new DebugWeaponDistanceWeakening(2000,4000,0.5);
         var _loc15_:BitmapData = this.config.name_WX.getTexture("plasma/charge") as BitmapData;
         var _loc16_:Vector.<BitmapData> = TextureUtils.parseImageStrip(_loc15_,_loc15_.height);
         var _loc17_:Vector.<Material> = this.getMaterialStrip(_loc16_);
         var _loc18_:BitmapData = this.config.name_WX.getTexture("plasma/explosion") as BitmapData;
         _loc16_ = TextureUtils.parseImageStrip(_loc18_,_loc18_.height);
         var _loc19_:Vector.<Material> = this.getMaterialStrip(_loc16_);
         var _loc20_:ColorTransform = new ColorTransform(5);
         var _loc22_:IEnergyRoundEffectsFactory = new PlasmaRoundEffectsFactory(this.gameKernel,_loc17_,_loc19_,_loc20_);
         var _loc23_:EnergyAmmunitionComponent = new EnergyAmmunitionComponent(50,2000,100,_loc13_,_loc14_,_loc22_,null);
         param1.addComponent(_loc23_);
         var _loc24_:EnergyShotWeaponComponent = new EnergyShotWeaponComponent(1000,1000,1000,1000,0,8000,_loc11_,null,true);
         param1.addComponent(_loc24_);
         var _loc25_:BitmapData = new BitmapData(20,20,false,0);
         _loc25_.perlinNoise(20,20,3,13,false,true);
         var _loc26_:TextureResource = this.name_BT.getResource("plasma/shot");
         var _loc27_:SimpleWeaponShotSFXComponent = new SimpleWeaponShotSFXComponent(_loc26_,null);
         param1.addComponent(_loc27_);
      }
      
      private function createContinuousActionGun(param1:Entity) : void
      {
         var _loc5_:ContinuousActionGunPlatformComponent = new ContinuousActionGunPlatformComponent(1000,1,15,true);
         param1.addComponent(_loc5_);
         var _loc7_:Number = 30 * Math.PI / 180;
         var _loc10_:FlamethrowerSFXData = this.getFlamethrowerSFXData();
         var _loc11_:FlamethrowerSFXComponent = new FlamethrowerSFXComponent(3000,_loc7_,20,3000,_loc10_);
         param1.addComponent(_loc11_);
         var _loc16_:RenderSystem = this.gameKernel.getRenderSystem();
         var _loc17_:TextureResource = this.name_BT.getResource("firebird/diffuse");
         var _loc18_:TextureResource = this.name_BT.getResource("firebird/opacity");
         _loc16_.useResource(_loc17_);
         _loc16_.useResource(_loc18_);
         FlamethrowerSFXComponent.init(_loc17_,_loc18_);
         var _loc19_:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         var _loc20_:IGenericTargetEvaluator = SimpleTargetEvaluator.INSTANCE;
         var _loc21_:ConicAreaTargetingSystem = new ConicAreaTargetingSystem(3000,_loc7_,10,10,_loc19_,_loc20_);
         var _loc22_:FlamethrowerSoundWeaponCallback = new FlamethrowerSoundWeaponCallback(this.config.soundsLibrary.getSound("flamethrower/shot"));
         var _loc23_:ConicAreaWeaponComponent = new ConicAreaWeaponComponent(1000,100,_loc21_,_loc22_,true,false);
         param1.addComponent(_loc23_);
      }
      
      private function getMaterialStrip(param1:Vector.<BitmapData>) : Vector.<Material>
      {
         var _loc3_:BitmapData = null;
         var _loc2_:Vector.<Material> = new Vector.<Material>();
         for each(_loc3_ in param1)
         {
         }
         return _loc2_;
      }
      
      private function removeActiveTank() : void
      {
         var _loc1_:Entity = null;
         if(this.name_Dx >= 0)
         {
            _loc1_ = this.activeTank;
            this.gameKernel.removeEntity(_loc1_);
            this.tanks.splice(this.name_Dx,1);
            if(this.tanks.length == 0)
            {
               this.name_Dx = -1;
            }
            else
            {
               this.name_Dx--;
               this.selectTank(this.name_Dx);
            }
         }
      }
      
      private function switchCameraController() : void
      {
         if(this.name_8c == this.name_al)
         {
            this.setCameraController(this.name_Wv);
         }
         else if(this.name_8c == this.freeCameraController)
         {
            this.setCameraController(this.name_al);
         }
         else
         {
            this.setCameraController(this.freeCameraController);
         }
      }
      
      private function setCameraController(param1:ICameraController) : void
      {
         if(this.activeTank != null)
         {
            if(param1 == this.name_Wv)
            {
               this.name_Wv.setTarget(this.activeTank);
            }
            if(param1 == this.name_al)
            {
               this.name_al.setTarget(this.activeTank);
            }
            if(param1 == this.freeCameraController)
            {
               this.freeCameraController.setTarget(this.activeTank);
            }
         }
         this.gameKernel.getRenderSystem().setCameraController(param1);
         this.name_8c = param1;
      }
      
      private function getPartMaterials(param1:TankPart, param2:BitmapData, param3:BitmapData, param4:Number, param5:Number) : TankPartMaterials
      {
         var _loc15_:TankHull = null;
         var _loc16_:TankWheel = null;
         var _loc6_:RenderSystem = this.gameKernel.getRenderSystem();
         var _loc7_:ByteArrayMap = param1.textureData;
         var _loc8_:ATFTextureResource = this.name_fa.getCompressedTextureResource(_loc7_.getValue(TankPartParser.KEY_DIFFUSE_MAP));
         var _loc9_:ATFTextureResource = this.name_fa.getCompressedTextureResource(_loc7_.getValue(TankPartParser.KEY_NORMAL_MAP));
         var _loc10_:ATFTextureResource = this.name_fa.getCompressedTextureResource(_loc7_.getValue(TankPartParser.KEY_SURFACE_MAP));
         var _loc11_:BitmapTextureResource = this.name_fa.getBitmapTextureResource(param2);
         var _loc12_:BitmapTextureResource = this.name_fa.getBitmapTextureResource(param3);
         var _loc13_:StandardMaterial = new StandardMaterial(_loc8_, _loc9_);
         var _loc14_:StandardMaterial = new StandardMaterial(_loc8_, _loc9_);
         // _loc13_.name_jM = param4;
         // _loc13_.name_Sf = param5;
         // _loc14_.name_jM = param4;
         // _loc14_.name_Sf = param5;
         _loc6_.useResource(param1.geometry);
         if(param1 is TankHull)
         {
            _loc15_ = TankHull(param1);
            for each(var _loc19_ in _loc15_.name_EY.concat(_loc15_.name_M4))
            {
               _loc16_ = _loc19_;
               _loc19_;
               _loc6_.useResource(_loc16_.geometry);
            }
            _loc6_.useResource(_loc15_.name_Ei.geometry);
            _loc6_.useResource(_loc15_.name_iA.geometry);
            _loc6_.useResource(_loc15_.shadow.geometry);
         }
         return new TankPartMaterials(_loc13_,_loc14_);
      }
      
      private function showZeroMarker() : void
      {
         var _loc1_:Box = new Box(20,20,20);
      }
      
      private function onFloatingTextEffectDestroy() : void
      {
         this.name_T2 = null;
         null;
      }
      
      private function getFlamethrowerSFXData() : FlamethrowerSFXData
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Vector.<ColorTransformEntry> = null;
         var _loc6_:FlamethrowerSFXData = null;
         var _loc1_:BitmapData = this.config.name_WX.getTexture("flame/sprite") as BitmapData;
         var _loc2_:Vector.<BitmapData> = TextureUtils.parseImageStrip(_loc1_);
         var _loc3_:Vector.<Material> = new Vector.<Material>();
         for each(var _loc9_ in _loc2_)
         {
            _loc4_ = _loc9_;
            _loc9_;
         }
         _loc5_ = new Vector.<ColorTransformEntry>();
         _loc5_.push(new ColorTransformEntry(0,3));
         _loc5_.push(new ColorTransformEntry(0.5));
         _loc5_.push(new ColorTransformEntry(0.75,0.2,0.2,0.2));
         _loc5_.push(new ColorTransformEntry(1,0,0,0,0));
         return new FlamethrowerSFXData(_loc3_,_loc5_);
      }
      
      private function createTankExplostionEffects() : void
      {
         this.createShockWave();
         this.createExplosion();
         this.createExplosionSmoke();
      }
      
      private function createShockWave() : void
      {
         var _loc2_:ICollisionDetector = null;
         var _loc3_:IChassisPhysicsComponent = null;
         var _loc4_:Vector3 = null;
         var _loc5_:RayHit = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Vector3 = null;
         var _loc8_:Vector.<TextureResource> = null;
         var _loc9_:Vector.<Material> = null;
         var _loc10_:AnimatedPlaneEffect = null;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
            _loc3_ = IChassisPhysicsComponent(_loc1_.getComponentStrict(IChassisPhysicsComponent));
            _loc4_ = _loc3_.getBody().state.position;
            _loc5_ = new RayHit();
            if(_loc2_.raycastStatic(_loc4_,Vector3.DOWN,CollisionGroup.STATIC,1000,null,_loc5_))
            {
               _loc6_ = _loc5_.position.clone();
               _loc6_.z = _loc6_.z + 1;
               _loc7_ = new Vector3();
               _loc7_.x = -Math.acos(_loc5_.normal.z);
               if(_loc5_.normal.z < 0.999)
               {
                  _loc7_.z = Math.atan2(-_loc5_.normal.x,_loc5_.normal.y);
               }
               _loc8_ = this.name_pb.getFrames("tank_explosion/shock_wave");
               _loc9_ = this.getFrameMaterials(_loc8_);
               _loc10_ = AnimatedPlaneEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedPlaneEffect));
               _loc10_.init(conShockSize.value,_loc6_,_loc7_,_loc9_,30,conShockSizeGrow.value);
               this.gameKernel.getRenderSystem().addEffect(_loc10_);
            }
         }
      }
      
      private function createExplosion() : void
      {
         var _loc2_:Vector.<TextureResource> = null;
         var _loc3_:Vector.<Material> = null;
         var _loc4_:AnimatedSpriteEffect = null;
         var _loc5_:IChassisPhysicsComponent = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.name_pb.getFrames("tank_explosion/explosion");
            _loc3_ = this.getFrameMaterials(_loc2_);
            _loc4_ = AnimatedSpriteEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedSpriteEffect));
            _loc5_ = IChassisPhysicsComponent(this.activeTank.getComponentStrict(IChassisPhysicsComponent));
            _loc6_ = _loc5_.getBody().state.position.clone();
            _loc6_.z = _loc6_.z + 100;
            _loc7_ = Math.random() * Math.PI;
            _loc8_ = 400;
            _loc9_ = 25;
            _loc4_.init(600,600,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_,false);
            this.gameKernel.getRenderSystem().addEffect(_loc4_);
         }
      }
      
      private function createExplosionSmoke() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Vector.<TextureResource> = null;
         var _loc11_:Vector.<Material> = null;
         var _loc12_:IChassisPhysicsComponent = null;
         var _loc13_:Vector3 = null;
         var _loc14_:Vector3 = null;
         var _loc15_:Number = NaN;
         var _loc16_:Vector3 = null;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:MovingAnimatedSprite = null;
         var _loc21_:Number = NaN;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = 100;
            _loc3_ = 10 * Math.PI / 180;
            _loc4_ = 60 * Math.PI / 180;
            _loc5_ = 700;
            _loc6_ = 1100;
            _loc7_ = 15;
            _loc8_ = -1000;
            _loc9_ = 400;
            _loc10_ = this.name_pb.getFrames("tank_explosion/smoke");
            _loc11_ = this.getFrameMaterials(_loc10_);
            _loc12_ = IChassisPhysicsComponent(this.activeTank.getComponentStrict(IChassisPhysicsComponent));
            _loc13_ = _loc12_.getBody().state.position.clone();
            _loc13_.z = _loc13_.z + _loc2_;
            _loc14_ = new Vector3();
            _loc15_ = Math.random() * Math.PI;
            _loc16_ = new Vector3();
            _loc17_ = 0;
            while(_loc17_ < 3)
            {
               _loc16_.x = Math.cos(_loc15_);
               _loc16_.y = Math.sin(_loc15_);
               _loc18_ = Math.random() * (_loc4_ - _loc3_) + _loc3_;
               _loc19_ = _loc5_ + Math.random() * (_loc6_ - _loc5_);
               _loc14_.copy(_loc16_).scale(Math.sin(_loc18_)).add(Vector3.UP).normalize().scale(_loc19_);
               _loc20_ = MovingAnimatedSprite(this.gameKernel.getObjectPoolManager().getObject(MovingAnimatedSprite));
               _loc21_ = Math.random() * Math.PI;
               _loc20_.init(_loc9_,_loc9_,_loc11_,_loc13_,_loc14_,_loc8_,_loc21_,_loc7_,false);
               this.gameKernel.getRenderSystem().addEffect(_loc20_);
               _loc15_ = _loc15_ + 2 / 3 * Math.PI;
               _loc17_++;
            }
         }
      }
      
      private function getFrameMaterials(param1:Vector.<TextureResource>) : Vector.<Material>
      {
         FrameMaterialsFactory.INSTANCE.renderSystem = this.gameKernel.getRenderSystem();
         return this.name_3u.getData(param1,FrameMaterialsFactory.INSTANCE) as Vector.<Material>;
      }
      
      private function listTanks(param1:IConsole, param2:Array) : void
      {
         var _loc3_:Entity = null;
         var _loc4_:LegacyTrackedChassisComponent = null;
         var _loc5_:Body = null;
         for each(var _loc8_ in this.tanks)
         {
            _loc3_ = _loc8_;
            _loc8_;
            _loc4_ = LegacyTrackedChassisComponent(_loc3_.getComponentStrict(LegacyTrackedChassisComponent));
            _loc5_ = _loc4_.body;
            param1.addText("Tank " + _loc5_.id);
            param1.addText("position " + _loc5_.state.position);
            param1.addText("velocity " + _loc5_.state.velocity);
         }
      }
   }
}

import alternativa.engine3d.materials.FillMaterial;
import alternativa.engine3d.materials.Material;
import alternativa.engine3d.materials.TextureMaterial;
import alternativa.engine3d.resources.ATFTextureResource;
import alternativa.engine3d.resources.BitmapTextureResource;
import alternativa.engine3d.resources.TextureResource;
import alternativa.math.Matrix4;
import alternativa.math.Vector3;
import alternativa.physics.collision.CollisionPrimitive;
import alternativa.tanks.config.TextureLibrary;
import alternativa.tanks.game.GameKernel;
import alternativa.tanks.game.effects.AnimatedSpriteEffect;
import alternativa.tanks.game.effects.IAreaOfEffectSFX;
import alternativa.tanks.game.entities.tank.ITurretManualControlCallback;
import alternativa.tanks.game.entities.tank.TankTurret;
import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
import alternativa.tanks.game.utils.datacache.IDataFactory;
import alternativa.tanks.game.weapons.IGenericAmmunition;
import alternativa.tanks.game.weapons.IGenericRound;
import alternativa.tanks.game.weapons.ammunition.pointhit.PointHitRound;
import alternativa.tanks.game.weapons.debug.DebugWeaponDistanceWeakening;
import alternativa.tanks.utils.TextureUtils;
import alternativa.utils.ColorUtils;
import flash.display.BitmapData;
import flash.media.Sound;
import flash.utils.ByteArray;

class FrameMaterialsFactory implements IDataFactory
{
   public static const INSTANCE:FrameMaterialsFactory = new FrameMaterialsFactory();
   
   public var renderSystem:RenderSystem;
   
   public function FrameMaterialsFactory()
   {
      super();
   }
   
   public function createData(param1:Object) : Object
   {
      var _loc6_:TextureMaterial = null;
      var _loc2_:Vector.<TextureResource> = param1 as Vector.<TextureResource>;
      var _loc3_:int = int(_loc2_.length);
      var _loc4_:Vector.<Material> = new Vector.<Material>(_loc3_);
      var _loc5_:int = 0;
      while(_loc5_ < _loc3_)
      {
         this.renderSystem.useResource(_loc2_[_loc5_]);
         _loc6_ = new TextureMaterial(_loc2_[_loc5_]);
         _loc6_.transparentPass = true;
         _loc4_[_loc5_] = _loc6_;
         _loc5_++;
      }
      return _loc4_;
   }
}

class DummyTurretCallback implements ITurretManualControlCallback
{
   public function DummyTurretCallback()
   {
      super();
   }
   
   public function onTurretControlChanged(param1:int, param2:Boolean) : void
   {
   }
}

class PointHitRoundAmmo implements IGenericAmmunition
{
   private var impactForce:Number;
   
   private var weaponDistanceWeakening:DebugWeaponDistanceWeakening;
   
   private var weaponHitEffects:WeaponHitEffects;
   
   public function PointHitRoundAmmo(param1:GameKernel)
   {
      var _loc5_:int = 0;
      super();
      this.impactForce = 10000;
      this.weaponDistanceWeakening = new DebugWeaponDistanceWeakening(10000,15000,0.5);
      var _loc2_:Vector.<Material> = new Vector.<Material>();
      var _loc4_:int = 0;
      while(_loc4_ < 20)
      {
         _loc5_ = 255 - 255 / (20 - 1) * _loc4_;
         _loc2_.push(new FillMaterial(ColorUtils.rgb(_loc5_,_loc5_,_loc5_),_loc5_ / 255 + 0.5));
         _loc4_++;
      }
      this.weaponHitEffects = new WeaponHitEffects(null,_loc2_,param1);
   }
   
   public function getRound() : IGenericRound
   {
      return new PointHitRound(this.impactForce,this.weaponDistanceWeakening,this.weaponHitEffects);
   }
}

class WeaponHitEffects implements IAreaOfEffectSFX
{
   private var sound:Sound;
   
   private var frames:Vector.<Material>;
   
   private var gameKernel:GameKernel;
   
   public function WeaponHitEffects(param1:Sound, param2:Vector.<Material>, param3:GameKernel)
   {
      super();
      this.sound = param1;
      this.frames = param2;
      this.gameKernel = param3;
   }
   
   public function createEffects(param1:Vector3, param2:Number, param3:Number) : void
   {
      var _loc4_:AnimatedSpriteEffect = AnimatedSpriteEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedSpriteEffect));
      _loc4_.init(600,600,this.frames,param1,0,50,30,false);
      this.gameKernel.getRenderSystem().addEffect(_loc4_);
   }
}

class TextureResourceCache
{
   private var textureLibrary:TextureLibrary;
   
   private var cache:Object = {};
   
   public function TextureResourceCache(param1:TextureLibrary)
   {
      super();
      this.textureLibrary = param1;
   }
   
   public function getResource(param1:String) : TextureResource
   {
      var _loc3_:Object = null;
      var _loc2_:TextureResource = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.getTexture(param1);
         if(_loc3_ is BitmapData)
         {
            _loc2_ = new BitmapTextureResource(_loc3_ as BitmapData);
            this.cache[param1] = _loc2_;
         }
         else if(_loc3_ is ByteArray)
         {
            _loc2_ = new ATFTextureResource(_loc3_ as ByteArray);
            this.cache[param1] = _loc2_;
         }
      }
      return _loc2_;
   }
}

class MultiBitmapTextureResourceCache
{
   private var textureLibrary:TextureLibrary;
   
   private var cache:Object = {};
   
   public function MultiBitmapTextureResourceCache(param1:TextureLibrary)
   {
      super();
      this.textureLibrary = param1;
   }
   
   public function getFrames(param1:String) : Vector.<TextureResource>
   {
      var _loc3_:BitmapData = null;
      var _loc4_:Vector.<BitmapData> = null;
      var _loc5_:int = 0;
      var _loc2_:Vector.<TextureResource> = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.getTexture(param1) as BitmapData;
         _loc4_ = TextureUtils.parseImageStrip(_loc3_);
         _loc2_ = new Vector.<TextureResource>(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_[_loc5_] = new BitmapTextureResource(_loc4_[_loc5_]);
            _loc5_++;
         }
         this.cache[param1] = _loc2_;
      }
      return _loc2_;
   }
}

class DummyTurret implements ITurretPhysicsComponent
{
   public function DummyTurret()
   {
      super();
   }
   
   public function setTurret(param1:TankTurret) : void
   {
   }
   
   public function getTurretDirection() : Number
   {
      return 0;
   }
   
   public function setTurretDirection(param1:Number) : void
   {
   }
   
   public function setTurretControls(param1:int) : Boolean
   {
      return false;
   }
   
   public function centerTurret(param1:Boolean) : void
   {
   }
   
   public function setTurretMountPoint(param1:Vector3) : void
   {
   }
   
   public function getTurretPrimitives() : Vector.<CollisionPrimitive>
   {
      return null;
   }
   
   public function getChassisMatrix() : Matrix4
   {
      return null;
   }
   
   public function getInterpolatedTurretDirection() : Number
   {
      return 0;
   }
   
   public function getSkinMountPoint(param1:Vector3) : void
   {
   }
   
   public function getGunData(param1:int, param2:Vector3, param3:Vector3, param4:Vector3) : void
   {
   }
   
   public function getGunMuzzleData(param1:int, param2:Vector3, param3:Vector3) : void
   {
      param2.reset(0,0,2000);
      param3.reset(0,0,1);
   }
   
   public function getGunMuzzleData2(param1:int, param2:Vector3, param3:Vector3) : void
   {
   }
   
   public function getBarrelLength(param1:int) : Number
   {
      return 0;
   }
   
   public function getBarrelCount() : int
   {
      return 0;
   }
}
