package alternativa.tanks
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.usertitle.component.name_245;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Vector3D;
   import flash.ui.Keyboard;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.tanks.game.GameTask;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.Entity;
   import alternativa.tanks.game.GameEvents;
   import package_100.name_301;
   import alternativa.tanks.config.Config;
   import package_15.name_275;
   import package_15.name_55;
   import package_18.name_102;
   import package_18.name_44;
   import package_20.class_11;
   import package_20.name_56;
   import package_21.name_77;
   import package_21.name_78;
   import alternativa.tanks.game.subsystems.inputsystem.KeyboardEventType;
   import alternativa.tanks.game.subsystems.inputsystem.IInput;
   import package_25.name_250;
   import package_28.name_129;
   import package_28.name_241;
   import package_28.name_259;
   import package_28.name_93;
   import package_29.MouseEvent3D;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import package_39.name_160;
   import package_4.class_4;
   import package_4.class_5;
   import package_40.name_251;
   import package_46.name_194;
   import package_47.name_193;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import package_71.name_234;
   import package_71.name_249;
   import package_71.name_252;
   import package_71.name_277;
   import package_71.name_278;
   import package_71.name_311;
   import package_71.name_315;
   import package_71.name_316;
   import package_71.name_318;
   import package_71.name_333;
   import package_72.name_239;
   import package_72.name_242;
   import package_72.name_255;
   import package_72.name_260;
   import package_72.name_264;
   import package_72.name_295;
   import package_73.name_293;
   import package_74.class_14;
   import package_74.name_240;
   import package_74.name_263;
   import package_74.name_283;
   import package_74.name_286;
   import package_74.name_307;
   import package_74.name_327;
   import package_75.name_236;
   import package_75.name_309;
   import package_76.name_256;
   import package_77.name_237;
   import package_78.name_243;
   import package_78.name_258;
   import package_79.name_261;
   import package_79.name_280;
   import package_79.name_282;
   import package_79.name_291;
   import package_79.name_326;
   import package_80.name_274;
   import package_80.name_287;
   import package_80.name_306;
   import package_80.name_312;
   import package_81.name_262;
   import package_81.name_265;
   import package_82.name_247;
   import package_83.name_269;
   import package_83.name_270;
   import package_84.name_253;
   import package_85.name_284;
   import package_85.name_314;
   import package_85.name_319;
   import package_86.name_257;
   import package_87.name_267;
   import package_88.name_268;
   import package_89.name_266;
   import package_9.name_20;
   import package_9.name_298;
   import package_9.name_299;
   import package_90.name_273;
   import package_91.name_296;
   import package_91.name_349;
   import package_92.name_271;
   import package_93.name_294;
   import package_94.name_276;
   import package_95.name_281;
   import package_96.name_279;
   import package_97.name_292;
   import package_98.name_290;
   import package_99.name_285;
   
   use namespace alternativa3d;
   
   public class TankTestTask extends GameTask implements class_11
   {
      private static const DEAD_TEXTURE_ID:String = "dead";
      
      private static var conShockSize:ConsoleVarFloat = new ConsoleVarFloat("shock_size",1200,0,2000);
      
      private static var conShockSizeGrow:ConsoleVarFloat = new ConsoleVarFloat("shock_size_grow",200,0,2000);
      
      private static var conPysicsDebug:ConsoleVarInt = new ConsoleVarInt("physics_debug",0,0,1);
      
      private static var conMaxSpeed:ConsoleVarFloat = new ConsoleVarFloat("max_speed",800,0,2000);
      
      private static var log:name_160 = name_160(OSGi.name_8().name_30(name_160));
      
      private var config:Config;
      
      private var gameKernel:GameKernel;
      
      private var var_82:int = 0;
      
      private var var_79:Vector.<name_255> = new Vector.<name_255>();
      
      private var tanks:Vector.<Entity>;
      
      private var var_62:int;
      
      private var var_74:name_250;
      
      private var var_77:name_250;
      
      private var var_76:name_250;
      
      private var var_73:BitmapData;
      
      private var var_67:name_299;
      
      private var var_69:name_298;
      
      private var freeCameraController:name_20;
      
      private var var_68:name_102;
      
      private var var_81:name_290;
      
      private var var_75:name_285;
      
      private var var_70:name_268;
      
      private var var_63:int;
      
      private var var_66:int;
      
      private var var_78:int;
      
      private var var_61:TextureResourceCache;
      
      private var var_64:MultiBitmapTextureResourceCache;
      
      private var var_65:TextureResourceService;
      
      private var var_71:name_294;
      
      private var preloader:Preloader;
      
      private var var_72:Entity;
      
      private var var_80:name_293 = new name_293();
      
      public function TankTestTask(param1:int, param2:Config, param3:GameKernel, param4:name_20, param5:Preloader)
      {
         super(param1);
         this.preloader = param5;
         this.config = param2;
         this.gameKernel = param3;
         this.freeCameraController = param4;
         this.tanks = new Vector.<Entity>();
         this.var_62 = -1;
         this.var_73 = new BitmapData(1,1);
         this.var_73.setPixel(0,0,11141120);
         this.var_68 = param4;
         this.var_61 = new TextureResourceCache(param2.var_37);
         this.var_64 = new MultiBitmapTextureResourceCache(param2.var_37);
         this.var_65 = new TextureResourceService(param3);
         TanksTestingTool.testTask = this;
      }
      
      override public function start() : void
      {
         var _loc1_:IInput = IInput(var_4.getTaskInterface(IInput));
         _loc1_.name_94(KeyboardEventType.KEY_DOWN,this.onKeyDown);
         var _loc2_:name_56 = name_56(var_4.getTaskInterface(name_56));
         _loc2_.addEventListener(name_253.TANK_CLICK,this);
         this.var_67 = new name_299(this.gameKernel.name_5().name_27(),this.gameKernel.method_112().name_246().collisionDetector,name_257.STATIC,_loc1_);
         this.var_69 = new name_298(this.gameKernel.name_5().name_27(),this.gameKernel.method_112().name_246().collisionDetector,name_257.STATIC,_loc1_);
         this.var_81 = new name_290(this.gameKernel.name_5());
         this.var_75 = new name_285();
         this.gameKernel.stage.addChild(this.var_75);
         var _loc3_:IConsole = IConsole(OSGi.name_8().name_30(IConsole));
         _loc3_.name_45("addtank",this.consoleAddTankHandler);
         var _loc4_:XMLList = this.config.xml.elements("console-commands");
         if(_loc4_.length() > 0)
         {
            this.executeConsoleCommands(_loc3_,this.config.xml.elements("console-commands")[0].toString());
         }
         _loc3_.name_45("lstanks",this.listTanks);
         this.var_71 = new name_294(GameKernel.RENDER_SYSTEM_PRIORITY + 1,10,this.gameKernel.stage,0,0);
         this.gameKernel.addTask(this.var_71);
         this.gameKernel.name_61().addEventListener(GameEvents.MAP_COMPLETE,this);
      }
      
      private function get activeTank() : Entity
      {
         return this.var_62 >= 0 ? this.tanks[this.var_62] : null;
      }
      
      private function selectTank(param1:int) : void
      {
         if(param1 >= 0 && param1 < this.tanks.length)
         {
            if(this.activeTank != null)
            {
               this.activeTank.dispatchEvent(name_252.SET_DISABLED_STATE);
            }
            this.var_62 = param1;
            this.activeTank.dispatchEvent(name_252.SET_ACTIVE_STATE);
            if(this.var_68 == this.var_67)
            {
               this.var_67.method_115(this.activeTank);
            }
            if(this.var_68 == this.var_69)
            {
               this.var_69.method_115(this.activeTank);
            }
         }
      }
      
      public function include() : void
      {
         if(this.tanks.length > 0)
         {
            this.selectTank((this.var_62 + 1) % this.tanks.length);
         }
         if(this.var_68 != this.var_67)
         {
            this.setCameraController(this.var_67);
         }
      }
      
      private function selectPrevTank() : void
      {
         var _loc1_:int = 0;
         if(this.tanks.length > 0)
         {
            _loc1_ = this.var_62 - 1;
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
            param1.method_139(_loc4_);
         }
      }
      
      private function consoleAddTankHandler(param1:IConsole, param2:Array) : void
      {
         this.addTank(TankParams.name_322(param2));
      }
      
      private function onKeyDown(param1:KeyboardEventType, param2:uint) : void
      {
         var _loc3_:name_44 = null;
         var _loc4_:int = 0;
         switch(param2)
         {
            case Keyboard.Q:
               _loc3_ = this.gameKernel.name_5();
               _loc4_ = _loc3_.method_72();
               _loc3_.method_54(_loc4_ == 0 ? 4 : 0);
               break;
            case Keyboard.M:
            case Keyboard.BACKSLASH:
               this.switchCameraController();
               break;
            case Keyboard.N:
               if(this.var_68 == this.freeCameraController)
               {
                  name_20.targeted = !name_20.targeted;
                  break;
               }
               name_20.targeted = true;
               this.setCameraController(this.freeCameraController);
               break;
            case Keyboard.ENTER:
               this.include();
         }
      }
      
      private function jump() : void
      {
         var _loc1_:name_237 = null;
         var _loc2_:name_271 = null;
         if(this.activeTank != null)
         {
            _loc1_ = name_237(this.activeTank.getComponent(name_237));
            _loc2_ = _loc1_.body;
            _loc2_.state.velocity.z = 1000;
         }
      }
      
      private function toggleTankTitle() : void
      {
         var _loc2_:name_245 = null;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = name_245(_loc1_.getComponent(name_245));
            if(_loc2_.name_328())
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
         this.var_71.name_305("Message: " + Math.random(),name_275.random());
      }
      
      private function controlKeyPressed() : Boolean
      {
         return this.gameKernel.name_66().name_346(Keyboard.CONTROL);
      }
      
      private function startIndicator(param1:int, param2:Boolean) : void
      {
         var _loc3_:name_245 = null;
         if(this.activeTank != null)
         {
            _loc3_ = name_245(this.activeTank.getComponentStrict(name_245));
            if(param2)
            {
               _loc3_.name_339(param1,10000);
            }
            else
            {
               _loc3_.name_330(param1);
            }
         }
      }
      
      private function createRandomAnimatedSprite() : void
      {
         var _loc3_:name_129 = null;
         var _loc4_:Vector.<class_4> = null;
         var _loc5_:int = 0;
         var _loc8_:class_5 = null;
         var _loc1_:Vector.<name_129> = this.var_64.getFrames("thunder/explosion");
         var _loc2_:name_44 = this.gameKernel.name_5();
         for each(_loc3_ in _loc1_)
         {
            _loc2_.method_29(_loc3_);
         }
         _loc4_ = new Vector.<class_4>(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc8_ = new class_5(_loc1_[_loc5_]);
            _loc8_.var_21 = true;
            _loc4_[_loc5_] = _loc8_;
            _loc5_++;
         }
         var _loc6_:name_239 = name_239(this.gameKernel.method_108().name_110(name_239));
         var _loc7_:name_194 = new name_194(Math.random() * 3000,Math.random() * 3000,1000 + Math.random() * 3000);
         _loc6_.init(300,300,_loc4_,_loc7_,0,0,30,true);
         _loc2_.method_37(_loc6_);
      }
      
      private function createThunderShotEffect() : void
      {
         var _loc1_:name_129 = this.var_61.getResource("smoky/diffuse");
         var _loc2_:name_129 = this.var_61.getResource("smoky/opacity");
         var _loc3_:name_44 = this.gameKernel.name_5();
         _loc3_.method_29(_loc1_);
         _loc3_.method_29(_loc2_);
         var _loc4_:name_266 = name_266(this.gameKernel.method_108().name_110(name_266));
         _loc4_.init(new DummyTurret(),_loc1_,_loc2_);
         _loc3_.method_37(_loc4_);
      }
      
      private function selectPrevTurret() : void
      {
         --this.var_66;
         if(this.var_66 < 0)
         {
            this.var_66 += this.config.tankParts.name_302;
         }
         this.rebuildActiveTank();
      }
      
      private function selectNextTurret() : void
      {
         this.var_66 = (this.var_66 + 1) % this.config.tankParts.name_302;
         this.rebuildActiveTank();
      }
      
      private function selectPrevHull() : void
      {
         --this.var_63;
         if(this.var_63 < 0)
         {
            this.var_63 += this.config.tankParts.name_300;
         }
         this.rebuildActiveTank();
      }
      
      public function selectNextHull() : void
      {
         this.var_63 = (this.var_63 + 1) % this.config.tankParts.name_300;
         this.rebuildActiveTank();
      }
      
      private function rebuildActiveTank() : void
      {
         var _loc2_:TankParams = null;
         var _loc3_:Entity = null;
         var _loc4_:name_236 = null;
         var _loc5_:name_236 = null;
         var _loc6_:name_194 = null;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            this.removeActiveTank();
            _loc2_ = new TankParams();
            _loc2_.hull = this.config.tankParts.name_351(this.var_63).id;
            _loc2_.turret = this.config.tankParts.name_336(this.var_66).id;
            _loc2_.coloring = this.var_78;
            _loc3_ = this.addTank(_loc2_);
            this.selectTank(this.tanks.length - 1);
            _loc4_ = name_236(_loc1_.getComponentStrict(name_236));
            _loc5_ = name_236(_loc3_.getComponentStrict(name_236));
            _loc5_.getBody().name_352(_loc4_.getBody().state.orientation);
            _loc6_ = _loc4_.getBody().state.position.clone();
            _loc6_.z += 200;
            _loc5_.getBody().name_201(_loc6_);
         }
      }
      
      override public function run() : void
      {
      }
      
      private function addDebugMessage() : void
      {
         var _loc1_:name_193 = null;
         if(this.activeTank != null)
         {
            if(this.var_70 == null)
            {
               this.var_70 = name_268(this.gameKernel.method_108().name_110(name_268));
               _loc1_ = name_193(this.activeTank.getComponentStrict(name_193));
               this.var_70.init(5000,_loc1_.name_329(),this.onFloatingTextEffectDestroy);
               this.gameKernel.name_5().method_37(this.var_70);
            }
            this.var_70.name_305("Message " + Math.random(),65280);
         }
      }
      
      public function method_146(param1:String, param2:*) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<name_77> = null;
         var _loc5_:Vector.<name_77> = null;
         var _loc6_:TankParams = null;
         var _loc7_:XMLList = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Entity = null;
         var _loc11_:name_259 = null;
         var _loc12_:name_241 = null;
         switch(param1)
         {
            case name_253.TANK_CLICK:
               _loc3_ = int(this.tanks.indexOf(Entity(param2)));
               if(_loc3_ >= 0)
               {
                  this.selectTank(_loc3_);
               }
               break;
            case GameEvents.MAP_COMPLETE:
               this.setCameraController(this.var_67);
               if(this.config.xml.user.length() > 0)
               {
                  _loc6_ = TankParams.name_317(this.config.xml.user[0],true);
                  this.var_78 = _loc6_.coloring;
                  this.var_63 = this.config.tankParts.name_350(_loc6_.hull);
                  this.var_66 = this.config.tankParts.name_338(_loc6_.turret);
                  if(this.var_63 < 0)
                  {
                     throw new ArgumentError("bad hull: " + _loc6_.hull);
                  }
                  if(this.var_66 < 0)
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
                     _loc10_ = this.addTank(TankParams.name_317(_loc7_[_loc8_]));
                     _loc10_.dispatchEvent(name_252.SET_ACTIVE_STATE);
                     _loc10_.dispatchEvent(name_252.SET_DISABLED_STATE);
                     _loc8_++;
                  }
               }
               _loc4_ = this.gameKernel.name_5().method_62().getResources(true,name_259);
               if(_loc4_.length > 0)
               {
                  _loc11_ = _loc4_[0] as name_259;
                  _loc11_.left = this.config.var_37.name_244("left_01") as BitmapData;
                  _loc11_.right = this.config.var_37.name_244("right_01") as BitmapData;
                  _loc11_.back = this.config.var_37.name_244("back_01") as BitmapData;
                  _loc11_.front = this.config.var_37.name_244("front_01") as BitmapData;
                  _loc11_.top = this.config.var_37.name_244("top_01") as BitmapData;
                  _loc11_.bottom = this.config.var_37.name_244("bottom_01") as BitmapData;
                  this.gameKernel.name_5().method_29(_loc11_);
               }
               this.createFire();
               this.config.clear();
               _loc5_ = this.gameKernel.name_5().method_62().getResources(true,name_241);
               for each(_loc12_ in _loc5_)
               {
                  _loc12_.data.clear();
                  _loc12_.data = null;
               }
               this.preloader.name_69(1);
         }
      }
      
      private function onMouseDown(param1:MouseEvent3D) : void
      {
         var _loc2_:Vector3D = name_78(param1.target).localToGlobal(new Vector3D(param1.localX,param1.localY,param1.localZ));
         log.log("mouse","click pos %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function precacheTank() : void
      {
      }
      
      private function addCachedTank() : void
      {
         this.gameKernel.name_73(this.var_72);
         this.tanks.push(this.var_72);
         this.selectTank(this.tanks.length - 1);
      }
      
      private function addTank(param1:TankParams) : Entity
      {
         var _loc2_:Entity = this.createTank(param1);
         this.gameKernel.name_73(_loc2_);
         this.tanks.push(_loc2_);
         return _loc2_;
      }
      
      private function createTank(param1:TankParams) : Entity
      {
         var _loc2_:name_249 = this.config.tankParts.name_353(param1.hull);
         var _loc3_:name_234 = this.config.tankParts.name_331(param1.turret);
         var _loc4_:BitmapData = this.config.tankParts.name_347(param1.coloring);
         var _loc5_:BitmapData = this.config.var_37.name_244(DEAD_TEXTURE_ID) as BitmapData;
         var _loc6_:Entity = new Entity(Entity.name_74());
         var _loc9_:name_237 = new name_237(_loc2_,1000,80000);
         var _loc10_:int = conMaxSpeed.value;
         _loc9_.name_321(_loc10_,true);
         _loc9_.name_335(2,true);
         _loc9_.name_201(new name_194(param1.x,param1.y,param1.z));
         _loc9_.body.name_332(param1.rotationX / 180 * Math.PI,param1.rotationY / 180 * Math.PI,param1.rotationZ / 180 * Math.PI);
         var _loc12_:name_253 = new name_253(_loc2_);
         _loc12_.name_343(this.getPartMaterials(_loc2_,_loc4_,_loc5_,6,6));
         _loc12_.name_342(this.createTracksMaterial(_loc2_));
         _loc12_.name_344(this.createShadowMaterial(_loc2_));
         _loc6_.name_60(_loc9_);
         _loc6_.name_60(_loc12_);
         _loc6_.name_60(new name_316(new name_312(this.config.soundsLibrary)));
         var _loc13_:name_278 = new name_278();
         _loc6_.name_60(_loc13_);
         _loc6_.name_60(new name_314());
         _loc6_.name_60(new name_309());
         var _loc14_:name_276 = new name_276(_loc3_,1,2);
         var _loc15_:name_193 = new name_193(_loc3_);
         _loc15_.name_348(this.getPartMaterials(_loc3_,_loc4_,_loc5_,3,3));
         _loc6_.name_60(_loc14_);
         _loc6_.name_60(_loc15_);
         _loc6_.name_60(new name_311(new name_306(this.config.soundsLibrary)));
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
         _loc6_.name_60(new name_315());
         if(conPysicsDebug.value == 1)
         {
            _loc6_.name_60(new name_319());
         }
         if(param1.isUser)
         {
         }
         var _loc16_:Vector.<class_4> = this.getFrameMaterials(this.var_64.getFrames("tank_explosion/shock_wave"));
         var _loc17_:Vector.<class_4> = this.getFrameMaterials(this.var_64.getFrames("tank_explosion/explosion"));
         var _loc18_:Vector.<class_4> = this.getFrameMaterials(this.var_64.getFrames("tank_explosion/smoke"));
         var _loc19_:name_284 = new name_284(1200,200,_loc16_,_loc17_,_loc18_);
         _loc6_.name_60(_loc19_);
         _loc6_.name_64();
         return _loc6_;
      }
      
      private function tracePos() : void
      {
         var _loc1_:name_237 = name_237(this.tanks[this.var_62].getComponent(name_237));
         var _loc2_:name_194 = new name_194();
         _loc1_.name_334.name_341(_loc2_);
         _loc2_.x = _loc2_.x * 180 / Math.PI;
         _loc2_.y = _loc2_.y * 180 / Math.PI;
         _loc2_.z = _loc2_.z * 180 / Math.PI;
         log.log("tank","position %1 %2 %3",_loc1_.name_288.x.toFixed(),_loc1_.name_288.y.toFixed(),_loc1_.name_288.z.toFixed());
         log.log("tank","rotation %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function createFire() : void
      {
         var _loc4_:XMLList = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         var _loc8_:name_255 = null;
         var _loc9_:Array = null;
         var _loc1_:name_129 = this.var_61.getResource("fire/diffuse");
         var _loc2_:name_129 = this.var_61.getResource("fire/opacity");
         var _loc3_:name_44 = this.gameKernel.name_5();
         _loc3_.method_29(_loc1_);
         _loc3_.method_29(_loc2_);
         this.var_74 = new name_250(_loc1_,_loc2_,8,8,0,16,30,true);
         this.var_77 = new name_250(_loc1_,_loc2_,8,8,16,16,30,true);
         this.var_76 = new name_250(_loc1_,_loc2_,8,8,32,32,45,true,0.5,0.5);
         if(this.config.xml.effects.length() > 0)
         {
            _loc4_ = this.config.xml.effects[0].fire;
            _loc5_ = 0;
            _loc6_ = int(_loc4_.length());
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc4_[_loc5_];
               _loc8_ = new name_255(this.var_74,this.var_77,this.var_76,5,true);
               _loc9_ = _loc7_.@position.toString().split(/\s+/);
               _loc8_.position = new Vector3D(Number(_loc9_[0]),Number(_loc9_[1]),Number(_loc9_[2]));
               _loc8_.scale = Number(_loc7_.@scale);
               this.var_79.push(_loc8_);
               this.gameKernel.name_5().method_48(_loc8_);
               _loc5_++;
            }
         }
      }
      
      private function createTracksMaterial(param1:name_249) : TracksMaterial2
      {
         var _loc2_:name_55 = param1.textureData;
         var _loc3_:name_241 = this.var_65.name_254(_loc2_.name_248(name_243.KEY_TRACKS_DIFFUSE));
         var _loc4_:name_241 = this.var_65.name_254(_loc2_.name_248(name_243.KEY_TRACKS_NORMAL));
         var _loc5_:TracksMaterial2 = new TracksMaterial2();
         _loc5_.glossiness = 65;
         _loc5_.var_25 = 0.6;
         _loc5_.diffuseMap = _loc3_;
         _loc5_.normalMap = _loc4_;
         if(_loc2_.name_248(name_243.KEY_TRACKS_OPACITY) != null)
         {
            _loc5_.opacityMap = this.var_65.name_254(_loc2_.name_248(name_243.KEY_TRACKS_OPACITY));
         }
         return _loc5_;
      }
      
      private function createShadowMaterial(param1:name_249) : GiShadowMaterial
      {
         var _loc3_:name_241 = null;
         var _loc2_:name_55 = param1.textureData;
         if(_loc2_.name_248(name_243.KEY_SHADOW) != null)
         {
            _loc3_ = this.var_65.name_254(_loc2_.name_248(name_243.KEY_SHADOW));
            return new GiShadowMaterial(_loc3_);
         }
         return null;
      }
      
      private function createSmoky(param1:Entity) : void
      {
         var _loc9_:name_129 = null;
         var _loc10_:Vector.<class_4> = null;
         var _loc11_:int = 0;
         var _loc18_:class_5 = null;
         var _loc3_:Number = 10000000 / 3;
         var _loc4_:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         var _loc5_:name_240 = new name_240();
         var _loc6_:name_261 = new name_261(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.name_310(this.gameKernel.method_112().name_246().collisionDetector);
         _loc6_.name_303(new name_240());
         var _loc7_:Vector.<name_129> = this.var_64.getFrames("thunder/explosion");
         var _loc8_:name_44 = this.gameKernel.name_5();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.method_29(_loc9_);
         }
         _loc10_ = new Vector.<class_4>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new class_5(_loc7_[_loc11_]);
            _loc18_.var_21 = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:name_129 = this.var_61.getResource("smoky/diffuse");
         var _loc13_:name_129 = this.var_61.getResource("smoky/opacity");
         _loc8_.method_29(_loc12_);
         _loc8_.method_29(_loc13_);
         name_270.init(_loc12_,_loc13_);
         var _loc14_:class_14 = new name_269(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:name_263 = new name_263(1000,_loc3_,_loc6_,_loc14_,new name_274(this.config.soundsLibrary.name_297("smoky/shot")),true);
         _loc15_.name_308 = true;
         param1.name_60(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         name_247.init(_loc12_,_loc13_);
         var _loc17_:name_247 = new name_247(this.var_61.getResource("thunder/shot"));
         param1.name_60(_loc17_);
      }
      
      private function createThunder(param1:Entity) : void
      {
         var _loc9_:name_129 = null;
         var _loc10_:Vector.<class_4> = null;
         var _loc11_:int = 0;
         var _loc18_:class_5 = null;
         var _loc4_:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         var _loc5_:name_240 = new name_240();
         var _loc6_:name_261 = new name_261(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.name_310(this.gameKernel.method_112().name_246().collisionDetector);
         _loc6_.name_303(new name_240());
         var _loc7_:Vector.<name_129> = this.var_64.getFrames("thunder/explosion");
         var _loc8_:name_44 = this.gameKernel.name_5();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.method_29(_loc9_);
         }
         _loc10_ = new Vector.<class_4>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new class_5(_loc7_[_loc11_]);
            _loc18_.var_21 = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:name_129 = this.var_61.getResource("smoky/diffuse");
         var _loc13_:name_129 = this.var_61.getResource("smoky/opacity");
         _loc8_.method_29(_loc12_);
         _loc8_.method_29(_loc13_);
         name_270.init(_loc12_,_loc13_);
         var _loc14_:class_14 = new name_269(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:name_263 = new name_263(1000,3333333.3333333335,_loc6_,_loc14_,new name_274(this.config.soundsLibrary.name_297("thunder/shot")),true);
         _loc15_.name_308 = true;
         param1.name_60(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         name_247.init(_loc12_,_loc13_);
         var _loc17_:name_247 = new name_247(this.var_61.getResource("thunder/shot"));
         param1.name_60(_loc17_);
      }
      
      private function createRailgun(param1:Entity) : void
      {
         var _loc5_:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         var _loc6_:name_292 = new name_292();
         var _loc7_:name_291 = new name_291(Math.PI / 9,20,Math.PI / 9,20,_loc5_,_loc6_);
      }
      
      private function createEnergyGun(param1:Entity) : void
      {
         var _loc9_:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         var _loc10_:name_240 = new name_240();
         var _loc11_:name_280 = new name_280(Math.PI / 4,20,Math.PI / 4,20,100,_loc9_,_loc10_);
         var _loc13_:Number = name_307.BASE_FORCE;
         var _loc14_:name_327 = new name_267(2000,4000,0.5);
         var _loc15_:BitmapData = this.config.var_37.name_244("plasma/charge") as BitmapData;
         var _loc16_:Vector.<BitmapData> = name_251.name_272(_loc15_,_loc15_.height);
         var _loc17_:Vector.<class_4> = this.getMaterialStrip(_loc16_);
         var _loc18_:BitmapData = this.config.var_37.name_244("plasma/explosion") as BitmapData;
         _loc16_ = name_251.name_272(_loc18_,_loc18_.height);
         var _loc19_:Vector.<class_4> = this.getMaterialStrip(_loc16_);
         var _loc20_:ColorTransform = new ColorTransform(5);
         var _loc22_:name_349 = new name_301(this.gameKernel,_loc17_,_loc19_,_loc20_);
         var _loc23_:name_296 = new name_296(50,2000,100,_loc13_,_loc14_,_loc22_,null);
         param1.name_60(_loc23_);
         var _loc24_:name_283 = new name_283(1000,1000,1000,1000,0,8000,_loc11_,null,true);
         param1.name_60(_loc24_);
         var _loc25_:BitmapData = new BitmapData(20,20,false,0);
         _loc25_.perlinNoise(20,20,3,13,false,true);
         var _loc26_:name_129 = this.var_61.getResource("plasma/shot");
         var _loc27_:name_295 = new name_295(_loc26_,null);
         param1.name_60(_loc27_);
      }
      
      private function createContinuousActionGun(param1:Entity) : void
      {
         var _loc5_:name_286 = new name_286(1000,1,15,true);
         param1.name_60(_loc5_);
         var _loc7_:Number = 30 * Math.PI / 180;
         var _loc10_:name_262 = this.getFlamethrowerSFXData();
         var _loc11_:name_265 = new name_265(3000,_loc7_,20,3000,_loc10_);
         param1.name_60(_loc11_);
         var _loc16_:name_44 = this.gameKernel.name_5();
         var _loc17_:name_129 = this.var_61.getResource("firebird/diffuse");
         var _loc18_:name_129 = this.var_61.getResource("firebird/opacity");
         _loc16_.method_29(_loc17_);
         _loc16_.method_29(_loc18_);
         name_265.init(_loc17_,_loc18_);
         var _loc19_:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         var _loc20_:name_326 = name_240.INSTANCE;
         var _loc21_:name_282 = new name_282(3000,_loc7_,10,10,_loc19_,_loc20_);
         var _loc22_:name_287 = new name_287(this.config.soundsLibrary.name_297("flamethrower/shot"));
         var _loc23_:name_281 = new name_281(1000,100,_loc21_,_loc22_,true,false);
         param1.name_60(_loc23_);
      }
      
      private function getMaterialStrip(param1:Vector.<BitmapData>) : Vector.<class_4>
      {
         var _loc3_:BitmapData = null;
         var _loc2_:Vector.<class_4> = new Vector.<class_4>();
         for each(_loc3_ in param1)
         {
         }
         return _loc2_;
      }
      
      private function removeActiveTank() : void
      {
         var _loc1_:Entity = null;
         if(this.var_62 >= 0)
         {
            _loc1_ = this.activeTank;
            this.gameKernel.method_109(_loc1_);
            this.tanks.splice(this.var_62,1);
            if(this.tanks.length == 0)
            {
               this.var_62 = -1;
            }
            else
            {
               this.var_62--;
               this.selectTank(this.var_62);
            }
         }
      }
      
      private function switchCameraController() : void
      {
         if(this.var_68 == this.var_69)
         {
            this.setCameraController(this.var_67);
         }
         else if(this.var_68 == this.freeCameraController)
         {
            this.setCameraController(this.var_69);
         }
         else
         {
            this.setCameraController(this.freeCameraController);
         }
      }
      
      private function setCameraController(param1:name_102) : void
      {
         if(this.activeTank != null)
         {
            if(param1 == this.var_67)
            {
               this.var_67.method_115(this.activeTank);
            }
            if(param1 == this.var_69)
            {
               this.var_69.method_115(this.activeTank);
            }
            if(param1 == this.freeCameraController)
            {
               this.freeCameraController.method_115(this.activeTank);
            }
         }
         this.gameKernel.name_5().setCameraController(param1);
         this.var_68 = param1;
      }
      
      private function getPartMaterials(param1:name_333, param2:BitmapData, param3:BitmapData, param4:Number, param5:Number) : name_277
      {
         var _loc15_:name_249 = null;
         var _loc16_:name_318 = null;
         var _loc6_:name_44 = this.gameKernel.name_5();
         var _loc7_:name_55 = param1.textureData;
         var _loc8_:name_241 = this.var_65.name_254(_loc7_.name_248(name_258.KEY_DIFFUSE_MAP));
         var _loc9_:name_241 = this.var_65.name_254(_loc7_.name_248(name_258.KEY_NORMAL_MAP));
         var _loc10_:name_241 = this.var_65.name_254(_loc7_.name_248(name_258.KEY_SURFACE_MAP));
         var _loc11_:name_93 = this.var_65.name_320(param2);
         var _loc12_:name_93 = this.var_65.name_320(param3);
         var _loc13_:TankMaterial2 = new TankMaterial2(_loc11_,_loc8_,_loc9_,_loc10_);
         var _loc14_:TankMaterial2 = new TankMaterial2(_loc12_,_loc8_,_loc9_,_loc10_);
         _loc13_.var_26 = param4;
         _loc13_.var_24 = param5;
         _loc14_.var_26 = param4;
         _loc14_.var_24 = param5;
         _loc6_.method_29(param1.geometry);
         if(param1 is name_249)
         {
            _loc15_ = name_249(param1);
            for each(var _loc19_ in _loc15_.name_325.concat(_loc15_.name_323))
            {
               _loc16_ = _loc19_;
               _loc19_;
               _loc6_.method_29(_loc16_.geometry);
            }
            _loc6_.method_29(_loc15_.name_337.geometry);
            _loc6_.method_29(_loc15_.name_340.geometry);
            _loc6_.method_29(_loc15_.shadow.geometry);
         }
         return new name_277(_loc13_,_loc14_);
      }
      
      private function showZeroMarker() : void
      {
         var _loc1_:name_279 = new name_279(20,20,20);
      }
      
      private function onFloatingTextEffectDestroy() : void
      {
         this.var_70 = null;
         null;
      }
      
      private function getFlamethrowerSFXData() : name_262
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Vector.<name_242> = null;
         var _loc6_:name_262 = null;
         var _loc1_:BitmapData = this.config.var_37.name_244("flame/sprite") as BitmapData;
         var _loc2_:Vector.<BitmapData> = name_251.name_272(_loc1_);
         var _loc3_:Vector.<class_4> = new Vector.<class_4>();
         for each(var _loc9_ in _loc2_)
         {
            _loc4_ = _loc9_;
            _loc9_;
         }
         _loc5_ = new Vector.<name_242>();
         _loc5_.push(new name_242(0,3));
         _loc5_.push(new name_242(0.5));
         _loc5_.push(new name_242(0.75,0.2,0.2,0.2));
         _loc5_.push(new name_242(1,0,0,0,0));
         return new name_262(_loc3_,_loc5_);
      }
      
      private function createTankExplostionEffects() : void
      {
         this.createShockWave();
         this.createExplosion();
         this.createExplosionSmoke();
      }
      
      private function createShockWave() : void
      {
         var _loc2_:name_256 = null;
         var _loc3_:name_236 = null;
         var _loc4_:name_194 = null;
         var _loc5_:name_273 = null;
         var _loc6_:name_194 = null;
         var _loc7_:name_194 = null;
         var _loc8_:Vector.<name_129> = null;
         var _loc9_:Vector.<class_4> = null;
         var _loc10_:name_264 = null;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.gameKernel.method_112().name_246().collisionDetector;
            _loc3_ = name_236(_loc1_.getComponentStrict(name_236));
            _loc4_ = _loc3_.getBody().state.position;
            _loc5_ = new name_273();
            if(_loc2_.name_324(_loc4_,name_194.DOWN,name_257.STATIC,1000,null,_loc5_))
            {
               _loc6_ = _loc5_.position.clone();
               _loc6_.z = _loc6_.z + 1;
               _loc7_ = new name_194();
               _loc7_.x = -Math.acos(_loc5_.normal.z);
               if(_loc5_.normal.z < 0.999)
               {
                  _loc7_.z = Math.atan2(-_loc5_.normal.x,_loc5_.normal.y);
               }
               _loc8_ = this.var_64.getFrames("tank_explosion/shock_wave");
               _loc9_ = this.getFrameMaterials(_loc8_);
               _loc10_ = name_264(this.gameKernel.method_108().name_110(name_264));
               _loc10_.init(conShockSize.value,_loc6_,_loc7_,_loc9_,30,conShockSizeGrow.value);
               this.gameKernel.name_5().method_37(_loc10_);
            }
         }
      }
      
      private function createExplosion() : void
      {
         var _loc2_:Vector.<name_129> = null;
         var _loc3_:Vector.<class_4> = null;
         var _loc4_:name_239 = null;
         var _loc5_:name_236 = null;
         var _loc6_:name_194 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:Entity = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.var_64.getFrames("tank_explosion/explosion");
            _loc3_ = this.getFrameMaterials(_loc2_);
            _loc4_ = name_239(this.gameKernel.method_108().name_110(name_239));
            _loc5_ = name_236(this.activeTank.getComponentStrict(name_236));
            _loc6_ = _loc5_.getBody().state.position.clone();
            _loc6_.z = _loc6_.z + 100;
            _loc7_ = Math.random() * Math.PI;
            _loc8_ = 400;
            _loc9_ = 25;
            _loc4_.init(600,600,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_,false);
            this.gameKernel.name_5().method_37(_loc4_);
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
         var _loc10_:Vector.<name_129> = null;
         var _loc11_:Vector.<class_4> = null;
         var _loc12_:name_236 = null;
         var _loc13_:name_194 = null;
         var _loc14_:name_194 = null;
         var _loc15_:Number = NaN;
         var _loc16_:name_194 = null;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:name_260 = null;
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
            _loc10_ = this.var_64.getFrames("tank_explosion/smoke");
            _loc11_ = this.getFrameMaterials(_loc10_);
            _loc12_ = name_236(this.activeTank.getComponentStrict(name_236));
            _loc13_ = _loc12_.getBody().state.position.clone();
            _loc13_.z = _loc13_.z + _loc2_;
            _loc14_ = new name_194();
            _loc15_ = Math.random() * Math.PI;
            _loc16_ = new name_194();
            _loc17_ = 0;
            while(_loc17_ < 3)
            {
               _loc16_.x = Math.cos(_loc15_);
               _loc16_.y = Math.sin(_loc15_);
               _loc18_ = Math.random() * (_loc4_ - _loc3_) + _loc3_;
               _loc19_ = _loc5_ + Math.random() * (_loc6_ - _loc5_);
               _loc14_.copy(_loc16_).scale(Math.sin(_loc18_)).add(name_194.UP).normalize().scale(_loc19_);
               _loc20_ = name_260(this.gameKernel.method_108().name_110(name_260));
               _loc21_ = Math.random() * Math.PI;
               _loc20_.init(_loc9_,_loc9_,_loc11_,_loc13_,_loc14_,_loc8_,_loc21_,_loc7_,false);
               this.gameKernel.name_5().method_37(_loc20_);
               _loc15_ = _loc15_ + 2 / 3 * Math.PI;
               _loc17_++;
            }
         }
      }
      
      private function getFrameMaterials(param1:Vector.<name_129>) : Vector.<class_4>
      {
         FrameMaterialsFactory.INSTANCE.renderSystem = this.gameKernel.name_5();
         return this.var_80.method_84(param1,FrameMaterialsFactory.INSTANCE) as Vector.<class_4>;
      }
      
      private function listTanks(param1:IConsole, param2:Array) : void
      {
         var _loc3_:Entity = null;
         var _loc4_:name_237 = null;
         var _loc5_:name_271 = null;
         for each(var _loc8_ in this.tanks)
         {
            _loc3_ = _loc8_;
            _loc8_;
            _loc4_ = name_237(_loc3_.getComponentStrict(name_237));
            _loc5_ = _loc4_.body;
            param1.name_145("Tank " + _loc5_.id);
            param1.name_145("position " + _loc5_.state.position);
            param1.name_145("velocity " + _loc5_.state.velocity);
         }
      }
   }
}

import flash.display.BitmapData;
import flash.media.Sound;
import flash.utils.ByteArray;
import alternativa.tanks.game.GameKernel;
import package_101.name_304;
import alternativa.tanks.config.TextureLibrary;
import package_15.name_275;
import package_18.name_44;
import package_28.name_129;
import package_28.name_241;
import package_28.name_93;
import package_4.class_4;
import package_4.class_5;
import package_4.name_313;
import package_40.name_251;
import package_46.Matrix4;
import package_46.name_194;
import package_71.class_10;
import package_71.name_234;
import package_72.class_12;
import package_72.name_239;
import package_73.class_13;
import package_74.class_14;
import package_74.name_233;
import package_75.class_15;
import package_76.name_235;
import package_87.name_267;

class FrameMaterialsFactory implements class_13
{
   public static const INSTANCE:FrameMaterialsFactory = new FrameMaterialsFactory();
   
   public var renderSystem:name_44;
   
   public function FrameMaterialsFactory()
   {
      super();
   }
   
   public function createData(param1:Object) : Object
   {
      var _loc6_:class_5 = null;
      var _loc2_:Vector.<name_129> = param1 as Vector.<name_129>;
      var _loc3_:int = int(_loc2_.length);
      var _loc4_:Vector.<class_4> = new Vector.<class_4>(_loc3_);
      var _loc5_:int = 0;
      while(_loc5_ < _loc3_)
      {
         this.renderSystem.method_29(_loc2_[_loc5_]);
         _loc6_ = new class_5(_loc2_[_loc5_]);
         _loc6_.var_21 = true;
         _loc4_[_loc5_] = _loc6_;
         _loc5_++;
      }
      return _loc4_;
   }
}

class DummyTurretCallback implements class_10
{
   public function DummyTurretCallback()
   {
      super();
   }
   
   public function onTurretControlChanged(param1:int, param2:Boolean) : void
   {
   }
}

class PointHitRoundAmmo implements class_14
{
   private var impactForce:Number;
   
   private var weaponDistanceWeakening:name_267;
   
   private var weaponHitEffects:WeaponHitEffects;
   
   public function PointHitRoundAmmo(param1:GameKernel)
   {
      var _loc5_:int = 0;
      super();
      this.impactForce = 10000;
      this.weaponDistanceWeakening = new name_267(10000,15000,0.5);
      var _loc2_:Vector.<class_4> = new Vector.<class_4>();
      var _loc4_:int = 0;
      while(_loc4_ < 20)
      {
         _loc5_ = 255 - 255 / (20 - 1) * _loc4_;
         _loc2_.push(new name_313(name_275.name_345(_loc5_,_loc5_,_loc5_),_loc5_ / 255 + 0.5));
         _loc4_++;
      }
      this.weaponHitEffects = new WeaponHitEffects(null,_loc2_,param1);
   }
   
   public function getRound() : name_233
   {
      return new name_304(this.impactForce,this.weaponDistanceWeakening,this.weaponHitEffects);
   }
}

class WeaponHitEffects implements class_12
{
   private var sound:Sound;
   
   private var frames:Vector.<class_4>;
   
   private var gameKernel:GameKernel;
   
   public function WeaponHitEffects(param1:Sound, param2:Vector.<class_4>, param3:GameKernel)
   {
      super();
      this.sound = param1;
      this.frames = param2;
      this.gameKernel = param3;
   }
   
   public function createEffects(param1:name_194, param2:Number, param3:Number) : void
   {
      var _loc4_:name_239 = name_239(this.gameKernel.method_108().name_110(name_239));
      _loc4_.init(600,600,this.frames,param1,0,50,30,false);
      this.gameKernel.name_5().method_37(_loc4_);
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
   
   public function getResource(param1:String) : name_129
   {
      var _loc3_:Object = null;
      var _loc2_:name_129 = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.name_244(param1);
         if(_loc3_ is BitmapData)
         {
            _loc2_ = new name_93(_loc3_ as BitmapData);
            this.cache[param1] = _loc2_;
         }
         else if(_loc3_ is ByteArray)
         {
            _loc2_ = new name_241(_loc3_ as ByteArray);
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
   
   public function getFrames(param1:String) : Vector.<name_129>
   {
      var _loc3_:BitmapData = null;
      var _loc4_:Vector.<BitmapData> = null;
      var _loc5_:int = 0;
      var _loc2_:Vector.<name_129> = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.name_244(param1) as BitmapData;
         _loc4_ = name_251.name_272(_loc3_);
         _loc2_ = new Vector.<name_129>(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_[_loc5_] = new name_93(_loc4_[_loc5_]);
            _loc5_++;
         }
         this.cache[param1] = _loc2_;
      }
      return _loc2_;
   }
}

class DummyTurret implements class_15
{
   public function DummyTurret()
   {
      super();
   }
   
   public function setTurret(param1:name_234) : void
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
   
   public function setTurretMountPoint(param1:name_194) : void
   {
   }
   
   public function getTurretPrimitives() : Vector.<name_235>
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
   
   public function getSkinMountPoint(param1:name_194) : void
   {
   }
   
   public function getGunData(param1:int, param2:name_194, param3:name_194, param4:name_194) : void
   {
   }
   
   public function getGunMuzzleData(param1:int, param2:name_194, param3:name_194) : void
   {
      param2.reset(0,0,2000);
      param3.reset(0,0,1);
   }
   
   public function getGunMuzzleData2(param1:int, param2:name_194, param3:name_194) : void
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
