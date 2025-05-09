package §_-YQ§
{
   import § var§.§_-Uk§;
   import § var§.§_-gx§;
   import §_-1e§.§_-fx§;
   import §_-1s§.MouseEvent3D;
   import §_-1z§.§_-KJ§;
   import §_-1z§.§_-VF§;
   import §_-1z§.§_-b1§;
   import §_-1z§.§_-pi§;
   import §_-7A§.§_-Is§;
   import §_-7A§.§_-U-§;
   import §_-8D§.§_-HO§;
   import §_-8D§.§_-OX§;
   import §_-8T§.§_-j8§;
   import §_-8T§.§_-mW§;
   import §_-8w§.§_-87§;
   import §_-8w§.§_-BD§;
   import §_-8w§.§_-HR§;
   import §_-8w§.§_-bh§;
   import §_-9-§.§_-Yo§;
   import §_-9Z§.§_-47§;
   import §_-9Z§.§_-Fj§;
   import §_-GD§.§_-6A§;
   import §_-I0§.§_-Jv§;
   import §_-I0§.§_-bt§;
   import §_-I0§.§_-hB§;
   import §_-IG§.§_-h4§;
   import §_-IQ§.§_-Pa§;
   import §_-K8§.§_-e5§;
   import §_-KA§.§_-jr§;
   import §_-KT§.§_-Ju§;
   import §_-KT§.§_-UT§;
   import §_-LL§.§_-nR§;
   import §_-LX§.§_-VO§;
   import §_-MU§.§_-5-§;
   import §_-My§.§_-3-§;
   import §_-O5§.§_-Hk§;
   import §_-O5§.§_-hM§;
   import §_-OR§.§_-om§;
   import §_-R8§.§_-QM§;
   import §_-US§.§_-BV§;
   import §_-Uy§.§_-oP§;
   import §_-V5§.§_-oN§;
   import §_-Vh§.§_-b9§;
   import §_-Vh§.§_-pZ§;
   import §_-Wh§.§_-4Q§;
   import §_-Wh§.§_-OG§;
   import §_-Wh§.§_-iU§;
   import §_-XN§.§_-O2§;
   import §_-XN§.§_-Rp§;
   import §_-XN§.§_-YE§;
   import §_-XN§.§_-e3§;
   import §_-XN§.§_-kW§;
   import §_-Yj§.TankMaterial2;
   import §_-Yj§.§_-bZ§;
   import §_-Yj§.§_-jj§;
   import §_-aF§.§_-S8§;
   import §_-aG§.§_-7-§;
   import §_-aM§.§_-Lm§;
   import §_-aM§.§_-X0§;
   import §_-az§.§_-AG§;
   import §_-az§.§_-Ss§;
   import §_-az§.§_-gw§;
   import §_-az§.§_-ps§;
   import §_-cv§.§_-YU§;
   import §_-dz§.§_-2G§;
   import §_-dz§.§_-Dm§;
   import §_-dz§.§_-NB§;
   import §_-dz§.§_-VX§;
   import §_-dz§.§_-Zh§;
   import §_-dz§.§_-l3§;
   import §_-dz§.§_-od§;
   import §_-e6§.§_-1I§;
   import §_-e6§.§_-gb§;
   import §_-eb§.§_-7a§;
   import §_-eb§.§_-ka§;
   import §_-fT§.§_-HM§;
   import §_-fj§.§_-cx§;
   import §_-gP§.§_-ke§;
   import §_-j-§.§_-B7§;
   import §_-j-§.§_-Fr§;
   import §_-jT§.§_-0K§;
   import §_-jd§.§_-82§;
   import §_-ks§.§_-ig§;
   import §_-nl§.§_-bj§;
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.usertitle.component.§_-YR§;
   import §default§.§_-2W§;
   import §default§.§_-49§;
   import §default§.§_-4a§;
   import §default§.§_-7d§;
   import §default§.§_-MC§;
   import §default§.§_-Vp§;
   import §default§.§_-b7§;
   import §default§.§_-dT§;
   import §default§.§_-gX§;
   import §default§.§_-kU§;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Vector3D;
   import flash.ui.Keyboard;
   import §function§.§_-7Y§;
   import §function§.§_-KQ§;
   import §function§.§_-T§;
   import §function§.§_-Xx§;
   import §function§.§_-Y1§;
   import §function§.§_-ok§;
   import §return§.§_-mc§;
   
   use namespace alternativa3d;
   
   public class §_-A3§ extends §_-ps§ implements §_-Fr§
   {
      private static const DEAD_TEXTURE_ID:String = "dead";
      
      private static var conShockSize:§_-Ju§ = new §_-Ju§("shock_size",1200,0,2000);
      
      private static var conShockSizeGrow:§_-Ju§ = new §_-Ju§("shock_size_grow",200,0,2000);
      
      private static var conPysicsDebug:§_-UT§ = new §_-UT§("physics_debug",0,0,1);
      
      private static var conMaxSpeed:§_-Ju§ = new §_-Ju§("max_speed",800,0,2000);
      
      private static var log:§_-5-§ = §_-5-§(§_-oP§.§_-nQ§().§_-N6§(§_-5-§));
      
      private var config:§_-YU§;
      
      private var gameKernel:§_-AG§;
      
      private var §_-D1§:int = 0;
      
      private var §_-Dl§:Vector.<§_-KQ§> = new Vector.<§_-KQ§>();
      
      private var tanks:Vector.<§_-gw§>;
      
      private var §_-Dx§:int;
      
      private var §_-LW§:§_-S8§;
      
      private var §_-J4§:§_-S8§;
      
      private var §_-FD§:§_-S8§;
      
      private var §_-Qv§:BitmapData;
      
      private var §_-Wv§:§_-hB§;
      
      private var §_-al§:§_-bt§;
      
      private var freeCameraController:§_-Jv§;
      
      private var §_-8c§:§_-gb§;
      
      private var §_-Xq§:§_-Pa§;
      
      private var §_-34§:§_-Yo§;
      
      private var §_-T2§:§_-e5§;
      
      private var §_-pn§:int;
      
      private var §_-8m§:int;
      
      private var §_-lw§:int;
      
      private var §_-BT§:TextureResourceCache;
      
      private var §_-pb§:MultiBitmapTextureResourceCache;
      
      private var §_-fa§:§_-iQ§;
      
      private var §_-n6§:§_-ig§;
      
      private var preloader:Preloader;
      
      private var §_-3t§:§_-gw§;
      
      private var §_-3u§:§_-3-§ = new §_-3-§();
      
      public function §_-A3§(param1:int, param2:§_-YU§, param3:§_-AG§, param4:§_-Jv§, param5:Preloader)
      {
         super(param1);
         this.preloader = param5;
         this.config = param2;
         this.gameKernel = param3;
         this.freeCameraController = param4;
         this.tanks = new Vector.<§_-gw§>();
         this.§_-Dx§ = -1;
         this.§_-Qv§ = new BitmapData(1,1);
         this.§_-Qv§.setPixel(0,0,11141120);
         this.§_-8c§ = param4;
         this.§_-BT§ = new TextureResourceCache(param2.§_-WX§);
         this.§_-pb§ = new MultiBitmapTextureResourceCache(param2.§_-WX§);
         this.§_-fa§ = new §_-iQ§(param3);
         TanksTestingTool.testTask = this;
      }
      
      override public function start() : void
      {
         var _loc1_:§_-Lm§ = §_-Lm§(§_-Uw§.getTaskInterface(§_-Lm§));
         _loc1_.§_-hn§(§_-X0§.KEY_DOWN,this.§_-Ze§);
         var _loc2_:§_-B7§ = §_-B7§(§_-Uw§.getTaskInterface(§_-B7§));
         _loc2_.addEventListener(§_-VO§.TANK_CLICK,this);
         this.§_-Wv§ = new §_-hB§(this.gameKernel.§_-DZ§().§_-GW§(),this.gameKernel.§_-m8§().§_-d-§().collisionDetector,§_-HM§.STATIC,_loc1_);
         this.§_-al§ = new §_-bt§(this.gameKernel.§_-DZ§().§_-GW§(),this.gameKernel.§_-m8§().§_-d-§().collisionDetector,§_-HM§.STATIC,_loc1_);
         this.§_-Xq§ = new §_-Pa§(this.gameKernel.§_-DZ§());
         this.§_-34§ = new §_-Yo§();
         this.gameKernel.stage.addChild(this.§_-34§);
         var _loc3_:§_-6A§ = §_-6A§(§_-oP§.§_-nQ§().§_-N6§(§_-6A§));
         _loc3_.§_-0j§("addtank",this.§_-gr§);
         var _loc4_:XMLList = this.config.xml.elements("console-commands");
         if(_loc4_.length() > 0)
         {
            this.§_-Bl§(_loc3_,this.config.xml.elements("console-commands")[0].toString());
         }
         _loc3_.§_-0j§("lstanks",this.§_-3R§);
         this.§_-n6§ = new §_-ig§(§_-AG§.RENDER_SYSTEM_PRIORITY + 1,10,this.gameKernel.stage,0,0);
         this.gameKernel.addTask(this.§_-n6§);
         this.gameKernel.§_-Ev§().addEventListener(§_-Ss§.MAP_COMPLETE,this);
      }
      
      private function get activeTank() : §_-gw§
      {
         return this.§_-Dx§ >= 0 ? this.tanks[this.§_-Dx§] : null;
      }
      
      private function §_-mn§(param1:int) : void
      {
         if(param1 >= 0 && param1 < this.tanks.length)
         {
            if(this.activeTank != null)
            {
               this.activeTank.dispatchEvent(§_-kU§.SET_DISABLED_STATE);
            }
            this.§_-Dx§ = param1;
            this.activeTank.dispatchEvent(§_-kU§.SET_ACTIVE_STATE);
            if(this.§_-8c§ == this.§_-Wv§)
            {
               this.§_-Wv§.§_-O-§(this.activeTank);
            }
            if(this.§_-8c§ == this.§_-al§)
            {
               this.§_-al§.§_-O-§(this.activeTank);
            }
         }
      }
      
      public function include() : void
      {
         if(this.tanks.length > 0)
         {
            this.§_-mn§((this.§_-Dx§ + 1) % this.tanks.length);
         }
         if(this.§_-8c§ != this.§_-Wv§)
         {
            this.§_-N8§(this.§_-Wv§);
         }
      }
      
      private function §_-C4§() : void
      {
         var _loc1_:int = 0;
         if(this.tanks.length > 0)
         {
            _loc1_ = this.§_-Dx§ - 1;
            if(_loc1_ < 0)
            {
               _loc1_ = this.tanks.length - 1;
            }
            this.§_-mn§(_loc1_);
         }
      }
      
      private function §_-Bl§(param1:§_-6A§, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc3_:Array = param2.split(/\r*\n/);
         for each(_loc4_ in _loc3_)
         {
            param1.§_-I1§(_loc4_);
         }
      }
      
      private function §_-gr§(param1:§_-6A§, param2:Array) : void
      {
         this.§_-kX§(§_-E8§.§_-mS§(param2));
      }
      
      private function §_-Ze§(param1:§_-X0§, param2:uint) : void
      {
         var _loc3_:§_-1I§ = null;
         var _loc4_:int = 0;
         switch(param2)
         {
            case Keyboard.Q:
               _loc3_ = this.gameKernel.§_-DZ§();
               _loc4_ = int(_loc3_.§_-m9§());
               _loc3_.§_-dO§(_loc4_ == 0 ? 4 : 0);
               break;
            case Keyboard.M:
            case Keyboard.BACKSLASH:
               this.§_-v§();
               break;
            case Keyboard.N:
               if(this.§_-8c§ == this.freeCameraController)
               {
                  §_-Jv§.targeted = !§_-Jv§.targeted;
                  break;
               }
               §_-Jv§.targeted = true;
               this.§_-N8§(this.freeCameraController);
               break;
            case Keyboard.ENTER:
               this.include();
         }
      }
      
      private function §_-3S§() : void
      {
         var _loc1_:§_-cx§ = null;
         var _loc2_:§_-BV§ = null;
         if(this.activeTank != null)
         {
            _loc1_ = §_-cx§(this.activeTank.getComponent(§_-cx§));
            _loc2_ = _loc1_.body;
            _loc2_.state.velocity.z = 1000;
         }
      }
      
      private function §_-gE§() : void
      {
         var _loc2_:§_-YR§ = null;
         var _loc1_:§_-gw§ = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = §_-YR§(_loc1_.getComponent(§_-YR§));
            if(_loc2_.§_-l-§())
            {
               _loc2_.removeFromScene();
            }
            else
            {
               _loc2_.addToScene();
            }
         }
      }
      
      private function §_-fy§() : void
      {
         this.§_-n6§.§_-U8§("Message: " + Math.random(),§_-hM§.random());
      }
      
      private function §_-3Y§() : Boolean
      {
         return this.gameKernel.§_-Ku§().§_-IA§(Keyboard.CONTROL);
      }
      
      private function §_-iR§(param1:int, param2:Boolean) : void
      {
         var _loc3_:§_-YR§ = null;
         if(this.activeTank != null)
         {
            _loc3_ = §_-YR§(this.activeTank.getComponentStrict(§_-YR§));
            if(param2)
            {
               _loc3_.§_-0W§(param1,10000);
            }
            else
            {
               _loc3_.§_-kd§(param1);
            }
         }
      }
      
      private function §_-Hj§() : void
      {
         var _loc3_:§_-pi§ = null;
         var _loc4_:Vector.<§_-b9§> = null;
         var _loc5_:int = 0;
         var _loc8_:§_-pZ§ = null;
         var _loc1_:Vector.<§_-pi§> = this.§_-pb§.getFrames("thunder/explosion");
         var _loc2_:§_-1I§ = this.gameKernel.§_-DZ§();
         for each(_loc3_ in _loc1_)
         {
            _loc2_.§_-09§(_loc3_);
         }
         _loc4_ = new Vector.<§_-b9§>(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc8_ = new §_-pZ§(_loc1_[_loc5_]);
            _loc8_.§_-L4§ = true;
            _loc4_[_loc5_] = _loc8_;
            _loc5_++;
         }
         var _loc6_:§_-Xx§ = §_-Xx§(this.gameKernel.§_-11§().§_-kP§(§_-Xx§));
         var _loc7_:§_-bj§ = new §_-bj§(Math.random() * 3000,Math.random() * 3000,1000 + Math.random() * 3000);
         _loc6_.init(300,300,_loc4_,_loc7_,0,0,30,true);
         _loc2_.each(_loc6_);
      }
      
      private function §_-dK§() : void
      {
         var _loc1_:§_-pi§ = this.§_-BT§.getResource("smoky/diffuse");
         var _loc2_:§_-pi§ = this.§_-BT§.getResource("smoky/opacity");
         var _loc3_:§_-1I§ = this.gameKernel.§_-DZ§();
         _loc3_.§_-09§(_loc1_);
         _loc3_.§_-09§(_loc2_);
         var _loc4_:§_-nR§ = §_-nR§(this.gameKernel.§_-11§().§_-kP§(§_-nR§));
         _loc4_.init(new DummyTurret(),_loc1_,_loc2_);
         _loc3_.each(_loc4_);
      }
      
      private function §_-fC§() : void
      {
         --this.§_-8m§;
         if(this.§_-8m§ < 0)
         {
            this.§_-8m§ += this.config.tankParts.§_-OC§;
         }
         this.§_-1y§();
      }
      
      private function §_-WI§() : void
      {
         this.§_-8m§ = (this.§_-8m§ + 1) % this.config.tankParts.§_-OC§;
         this.§_-1y§();
      }
      
      private function §_-hd§() : void
      {
         --this.§_-pn§;
         if(this.§_-pn§ < 0)
         {
            this.§_-pn§ += this.config.tankParts.§_-pg§;
         }
         this.§_-1y§();
      }
      
      public function §_-42§() : void
      {
         this.§_-pn§ = (this.§_-pn§ + 1) % this.config.tankParts.§_-pg§;
         this.§_-1y§();
      }
      
      private function §_-1y§() : void
      {
         var _loc2_:§_-E8§ = null;
         var _loc3_:§_-gw§ = null;
         var _loc4_:§_-Is§ = null;
         var _loc5_:§_-Is§ = null;
         var _loc6_:§_-bj§ = null;
         var _loc1_:§_-gw§ = this.activeTank;
         if(_loc1_ != null)
         {
            this.§_-1w§();
            _loc2_ = new §_-E8§();
            _loc2_.hull = this.config.tankParts.§_-lD§(this.§_-pn§).id;
            _loc2_.turret = this.config.tankParts.§_-eq§(this.§_-8m§).id;
            _loc2_.coloring = this.§_-lw§;
            _loc3_ = this.§_-kX§(_loc2_);
            this.§_-mn§(this.tanks.length - 1);
            _loc4_ = §_-Is§(_loc1_.getComponentStrict(§_-Is§));
            _loc5_ = §_-Is§(_loc3_.getComponentStrict(§_-Is§));
            _loc5_.getBody().§_-LV§(_loc4_.getBody().state.orientation);
            _loc6_ = _loc4_.getBody().state.position.clone();
            _loc6_.z += 200;
            _loc5_.getBody().§_-Vi§(_loc6_);
         }
      }
      
      override public function run() : void
      {
      }
      
      private function §_-Qe§() : void
      {
         var _loc1_:§_-om§ = null;
         if(this.activeTank != null)
         {
            if(this.§_-T2§ == null)
            {
               this.§_-T2§ = §_-e5§(this.gameKernel.§_-11§().§_-kP§(§_-e5§));
               _loc1_ = §_-om§(this.activeTank.getComponentStrict(§_-om§));
               this.§_-T2§.init(5000,_loc1_.§_-5x§(),this.§_-ab§);
               this.gameKernel.§_-DZ§().each(this.§_-T2§);
            }
            this.§_-T2§.§_-U8§("Message " + Math.random(),65280);
         }
      }
      
      public function §_-86§(param1:String, param2:*) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<§_-HO§> = null;
         var _loc5_:Vector.<§_-HO§> = null;
         var _loc6_:§_-E8§ = null;
         var _loc7_:XMLList = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:§_-gw§ = null;
         var _loc11_:§_-VF§ = null;
         var _loc12_:§_-KJ§ = null;
         switch(param1)
         {
            case §_-VO§.TANK_CLICK:
               _loc3_ = int(this.tanks.indexOf(§_-gw§(param2)));
               if(_loc3_ >= 0)
               {
                  this.§_-mn§(_loc3_);
               }
               break;
            case §_-Ss§.MAP_COMPLETE:
               this.§_-N8§(this.§_-Wv§);
               if(this.config.xml.user.length() > 0)
               {
                  _loc6_ = §_-E8§.§_-CW§(this.config.xml.user[0],true);
                  this.§_-lw§ = _loc6_.coloring;
                  this.§_-pn§ = this.config.tankParts.§_-mh§(_loc6_.hull);
                  this.§_-8m§ = this.config.tankParts.§_-mR§(_loc6_.turret);
                  if(this.§_-pn§ < 0)
                  {
                     throw new ArgumentError("bad hull: " + _loc6_.hull);
                  }
                  if(this.§_-8m§ < 0)
                  {
                     throw new ArgumentError("bad turret: " + _loc6_.turret);
                  }
                  this.§_-kX§(_loc6_);
               }
               else
               {
                  this.§_-kX§(§_-E8§.defaultTankParams);
               }
               this.§_-mn§(this.tanks.length - 1);
               if(this.config.xml.tanks.length() > 0)
               {
                  _loc7_ = this.config.xml.tanks[0].tank;
                  _loc8_ = 0;
                  _loc9_ = int(_loc7_.length());
                  while(_loc8_ < _loc9_)
                  {
                     _loc10_ = this.§_-kX§(§_-E8§.§_-CW§(_loc7_[_loc8_]));
                     _loc10_.dispatchEvent(§_-kU§.SET_ACTIVE_STATE);
                     _loc10_.dispatchEvent(§_-kU§.SET_DISABLED_STATE);
                     _loc8_++;
                  }
               }
               _loc4_ = this.gameKernel.§_-DZ§().§_-Hn§().getResources(true,§_-VF§);
               if(_loc4_.length > 0)
               {
                  _loc11_ = _loc4_[0] as §_-VF§;
                  _loc11_.left = this.config.§_-WX§.§_-o0§("left_01") as BitmapData;
                  _loc11_.right = this.config.§_-WX§.§_-o0§("right_01") as BitmapData;
                  _loc11_.back = this.config.§_-WX§.§_-o0§("back_01") as BitmapData;
                  _loc11_.front = this.config.§_-WX§.§_-o0§("front_01") as BitmapData;
                  _loc11_.top = this.config.§_-WX§.§_-o0§("top_01") as BitmapData;
                  _loc11_.bottom = this.config.§_-WX§.§_-o0§("bottom_01") as BitmapData;
                  this.gameKernel.§_-DZ§().§_-09§(_loc11_);
               }
               this.§_-Q§();
               this.config.clear();
               _loc5_ = this.gameKernel.§_-DZ§().§_-Hn§().getResources(true,§_-KJ§);
               for each(_loc12_ in _loc5_)
               {
                  _loc12_.data.clear();
                  _loc12_.data = null;
               }
               this.preloader.§_-QU§(1);
         }
      }
      
      private function onMouseDown(param1:MouseEvent3D) : void
      {
         var _loc2_:Vector3D = §_-OX§(param1.target).localToGlobal(new Vector3D(param1.localX,param1.localY,param1.localZ));
         log.log("mouse","click pos %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function §_-kq§() : void
      {
      }
      
      private function §_-14§() : void
      {
         this.gameKernel.§_-oR§(this.§_-3t§);
         this.tanks.push(this.§_-3t§);
         this.§_-mn§(this.tanks.length - 1);
      }
      
      private function §_-kX§(param1:§_-E8§) : §_-gw§
      {
         var _loc2_:§_-gw§ = this.§_-As§(param1);
         this.gameKernel.§_-oR§(_loc2_);
         this.tanks.push(_loc2_);
         return _loc2_;
      }
      
      private function §_-As§(param1:§_-E8§) : §_-gw§
      {
         var _loc2_:§_-dT§ = this.config.tankParts.§_-N1§(param1.hull);
         var _loc3_:§_-Vp§ = this.config.tankParts.§_-Sw§(param1.turret);
         var _loc4_:BitmapData = this.config.tankParts.§_-bR§(param1.coloring);
         var _loc5_:BitmapData = this.config.§_-WX§.§_-o0§(DEAD_TEXTURE_ID) as BitmapData;
         var _loc6_:§_-gw§ = new §_-gw§(§_-gw§.§_-9o§());
         var _loc9_:§_-cx§ = new §_-cx§(_loc2_,1000,80000);
         var _loc10_:int = int(conMaxSpeed.value);
         _loc9_.§_-la§(_loc10_,true);
         _loc9_.§_-Gu§(2,true);
         _loc9_.§_-Vi§(new §_-bj§(param1.x,param1.y,param1.z));
         _loc9_.body.§_-U4§(param1.rotationX / 180 * Math.PI,param1.rotationY / 180 * Math.PI,param1.rotationZ / 180 * Math.PI);
         var _loc12_:§_-VO§ = new §_-VO§(_loc2_);
         _loc12_.§_-Ru§(this.§_-E-§(_loc2_,_loc4_,_loc5_,6,6));
         _loc12_.§_-gq§(this.§_-Bi§(_loc2_));
         _loc12_.§_-CE§(this.§_-TH§(_loc2_));
         _loc6_.§_-2d§(_loc9_);
         _loc6_.§_-2d§(_loc12_);
         _loc6_.§_-2d§(new §_-MC§(new §_-BD§(this.config.soundsLibrary)));
         var _loc13_:§_-gX§ = new §_-gX§();
         _loc6_.§_-2d§(_loc13_);
         _loc6_.§_-2d§(new §_-iU§());
         _loc6_.§_-2d§(new §_-U-§());
         var _loc14_:§_-82§ = new §_-82§(_loc3_,1,2);
         var _loc15_:§_-om§ = new §_-om§(_loc3_);
         _loc15_.§_-CI§(this.§_-E-§(_loc3_,_loc4_,_loc5_,3,3));
         _loc6_.§_-2d§(_loc14_);
         _loc6_.§_-2d§(_loc15_);
         _loc6_.§_-2d§(new §_-4a§(new §_-HR§(this.config.soundsLibrary)));
         if(_loc3_.id.indexOf("Smoky") >= 0)
         {
            this.§_-0A§(_loc6_);
         }
         else if(_loc3_.id.indexOf("Thunder") >= 0)
         {
            this.§_-D5§(_loc6_);
         }
         else
         {
            this.§_-Gy§(_loc6_);
         }
         _loc6_.§_-2d§(new §_-b7§());
         if(conPysicsDebug.value == 1)
         {
            _loc6_.§_-2d§(new §_-4Q§());
         }
         if(!param1.isUser)
         {
         }
         var _loc16_:Vector.<§_-b9§> = this.§_-0u§(this.§_-pb§.getFrames("tank_explosion/shock_wave"));
         var _loc17_:Vector.<§_-b9§> = this.§_-0u§(this.§_-pb§.getFrames("tank_explosion/explosion"));
         var _loc18_:Vector.<§_-b9§> = this.§_-0u§(this.§_-pb§.getFrames("tank_explosion/smoke"));
         var _loc19_:§_-OG§ = new §_-OG§(1200,200,_loc16_,_loc17_,_loc18_);
         _loc6_.§_-2d§(_loc19_);
         _loc6_.§_-m7§();
         return _loc6_;
      }
      
      private function §_-8j§() : void
      {
         var _loc1_:§_-cx§ = §_-cx§(this.tanks[this.§_-Dx§].getComponent(§_-cx§));
         var _loc2_:§_-bj§ = new §_-bj§();
         _loc1_.§_-UQ§.§_-fJ§(_loc2_);
         _loc2_.x = _loc2_.x * 180 / Math.PI;
         _loc2_.y = _loc2_.y * 180 / Math.PI;
         _loc2_.z = _loc2_.z * 180 / Math.PI;
         log.log("tank","position %1 %2 %3",_loc1_.§_-bi§.x.toFixed(),_loc1_.§_-bi§.y.toFixed(),_loc1_.§_-bi§.z.toFixed());
         log.log("tank","rotation %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function §_-Q§() : void
      {
         var _loc4_:XMLList = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         var _loc8_:§_-KQ§ = null;
         var _loc9_:Array = null;
         var _loc1_:§_-pi§ = this.§_-BT§.getResource("fire/diffuse");
         var _loc2_:§_-pi§ = this.§_-BT§.getResource("fire/opacity");
         var _loc3_:§_-1I§ = this.gameKernel.§_-DZ§();
         _loc3_.§_-09§(_loc1_);
         _loc3_.§_-09§(_loc2_);
         this.§_-LW§ = new §_-S8§(_loc1_,_loc2_,8,8,0,16,30,true);
         this.§_-J4§ = new §_-S8§(_loc1_,_loc2_,8,8,16,16,30,true);
         this.§_-FD§ = new §_-S8§(_loc1_,_loc2_,8,8,32,32,45,true,0.5,0.5);
         if(this.config.xml.effects.length() > 0)
         {
            _loc4_ = this.config.xml.effects[0].fire;
            _loc5_ = 0;
            _loc6_ = int(_loc4_.length());
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc4_[_loc5_];
               _loc8_ = new §_-KQ§(this.§_-LW§,this.§_-J4§,this.§_-FD§,5,true);
               _loc9_ = _loc7_.@position.toString().split(/\s+/);
               _loc8_.position = new Vector3D(Number(_loc9_[0]),Number(_loc9_[1]),Number(_loc9_[2]));
               _loc8_.scale = Number(_loc7_.@scale);
               this.§_-Dl§.push(_loc8_);
               this.gameKernel.§_-DZ§().§_-9p§(_loc8_);
               _loc5_++;
            }
         }
      }
      
      private function §_-Bi§(param1:§_-dT§) : §_-bZ§
      {
         var _loc2_:§_-Hk§ = param1.textureData;
         var _loc3_:§_-KJ§ = this.§_-fa§.§_-kb§(_loc2_.§_-HG§(§_-gx§.KEY_TRACKS_DIFFUSE));
         var _loc4_:§_-KJ§ = this.§_-fa§.§_-kb§(_loc2_.§_-HG§(§_-gx§.KEY_TRACKS_NORMAL));
         var _loc5_:§_-bZ§ = new §_-bZ§();
         _loc5_.glossiness = 65;
         _loc5_.§_-kj§ = 0.6;
         _loc5_.diffuseMap = _loc3_;
         _loc5_.normalMap = _loc4_;
         if(_loc2_.§_-HG§(§_-gx§.KEY_TRACKS_OPACITY) != null)
         {
            _loc5_.opacityMap = this.§_-fa§.§_-kb§(_loc2_.§_-HG§(§_-gx§.KEY_TRACKS_OPACITY));
         }
         return _loc5_;
      }
      
      private function §_-TH§(param1:§_-dT§) : §_-jj§
      {
         var _loc3_:§_-KJ§ = null;
         var _loc2_:§_-Hk§ = param1.textureData;
         if(_loc2_.§_-HG§(§_-gx§.KEY_SHADOW) != null)
         {
            _loc3_ = this.§_-fa§.§_-kb§(_loc2_.§_-HG§(§_-gx§.KEY_SHADOW));
            return new §_-jj§(_loc3_);
         }
         return null;
      }
      
      private function §_-0A§(param1:§_-gw§) : void
      {
         var _loc9_:§_-pi§ = null;
         var _loc10_:Vector.<§_-b9§> = null;
         var _loc11_:int = 0;
         var _loc18_:§_-pZ§ = null;
         var _loc3_:Number = 10000000 / 3;
         var _loc4_:§_-fx§ = this.gameKernel.§_-m8§().§_-d-§().collisionDetector;
         var _loc5_:§_-NB§ = new §_-NB§();
         var _loc6_:§_-O2§ = new §_-O2§(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.§_-JD§(this.gameKernel.§_-m8§().§_-d-§().collisionDetector);
         _loc6_.§_-XH§(new §_-NB§());
         var _loc7_:Vector.<§_-pi§> = this.§_-pb§.getFrames("thunder/explosion");
         var _loc8_:§_-1I§ = this.gameKernel.§_-DZ§();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.§_-09§(_loc9_);
         }
         _loc10_ = new Vector.<§_-b9§>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new §_-pZ§(_loc7_[_loc11_]);
            _loc18_.§_-L4§ = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:§_-pi§ = this.§_-BT§.getResource("smoky/diffuse");
         var _loc13_:§_-pi§ = this.§_-BT§.getResource("smoky/opacity");
         _loc8_.§_-09§(_loc12_);
         _loc8_.§_-09§(_loc13_);
         §_-j8§.init(_loc12_,_loc13_);
         var _loc14_:§_-Zh§ = new §_-mW§(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:§_-od§ = new §_-od§(1000,_loc3_,_loc6_,_loc14_,new §_-87§(this.config.soundsLibrary.§_-lM§("smoky/shot")),true);
         _loc15_.§_-BE§ = true;
         param1.§_-2d§(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         §_-oN§.init(_loc12_,_loc13_);
         var _loc17_:§_-oN§ = new §_-oN§(this.§_-BT§.getResource("thunder/shot"));
         param1.§_-2d§(_loc17_);
      }
      
      private function §_-D5§(param1:§_-gw§) : void
      {
         var _loc9_:§_-pi§ = null;
         var _loc10_:Vector.<§_-b9§> = null;
         var _loc11_:int = 0;
         var _loc18_:§_-pZ§ = null;
         var _loc4_:§_-fx§ = this.gameKernel.§_-m8§().§_-d-§().collisionDetector;
         var _loc5_:§_-NB§ = new §_-NB§();
         var _loc6_:§_-O2§ = new §_-O2§(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.§_-JD§(this.gameKernel.§_-m8§().§_-d-§().collisionDetector);
         _loc6_.§_-XH§(new §_-NB§());
         var _loc7_:Vector.<§_-pi§> = this.§_-pb§.getFrames("thunder/explosion");
         var _loc8_:§_-1I§ = this.gameKernel.§_-DZ§();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.§_-09§(_loc9_);
         }
         _loc10_ = new Vector.<§_-b9§>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new §_-pZ§(_loc7_[_loc11_]);
            _loc18_.§_-L4§ = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:§_-pi§ = this.§_-BT§.getResource("smoky/diffuse");
         var _loc13_:§_-pi§ = this.§_-BT§.getResource("smoky/opacity");
         _loc8_.§_-09§(_loc12_);
         _loc8_.§_-09§(_loc13_);
         §_-j8§.init(_loc12_,_loc13_);
         var _loc14_:§_-Zh§ = new §_-mW§(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:§_-od§ = new §_-od§(1000,3333333.3333333335,_loc6_,_loc14_,new §_-87§(this.config.soundsLibrary.§_-lM§("thunder/shot")),true);
         _loc15_.§_-BE§ = true;
         param1.§_-2d§(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         §_-oN§.init(_loc12_,_loc13_);
         var _loc17_:§_-oN§ = new §_-oN§(this.§_-BT§.getResource("thunder/shot"));
         param1.§_-2d§(_loc17_);
      }
      
      private function §_-2a§(param1:§_-gw§) : void
      {
         var _loc5_:§_-fx§ = this.gameKernel.§_-m8§().§_-d-§().collisionDetector;
         var _loc6_:§_-0K§ = new §_-0K§();
         var _loc7_:§_-e3§ = new §_-e3§(Math.PI / 9,20,Math.PI / 9,20,_loc5_,_loc6_);
      }
      
      private function §_-Ar§(param1:§_-gw§) : void
      {
         var _loc9_:§_-fx§ = this.gameKernel.§_-m8§().§_-d-§().collisionDetector;
         var _loc10_:§_-NB§ = new §_-NB§();
         var _loc11_:§_-YE§ = new §_-YE§(Math.PI / 4,20,Math.PI / 4,20,100,_loc9_,_loc10_);
         var _loc13_:Number = Number(§_-Dm§.BASE_FORCE);
         var _loc14_:§_-2G§ = new §_-QM§(2000,4000,0.5);
         var _loc15_:BitmapData = this.config.§_-WX§.§_-o0§("plasma/charge") as BitmapData;
         var _loc16_:Vector.<BitmapData> = §_-mc§.§_-YA§(_loc15_,_loc15_.height);
         var _loc17_:Vector.<§_-b9§> = this.§_-Gt§(_loc16_);
         var _loc18_:BitmapData = this.config.§_-WX§.§_-o0§("plasma/explosion") as BitmapData;
         _loc16_ = §_-mc§.§_-YA§(_loc18_,_loc18_.height);
         var _loc19_:Vector.<§_-b9§> = this.§_-Gt§(_loc16_);
         var _loc20_:ColorTransform = new ColorTransform(5);
         var _loc22_:§_-7a§ = new §_-h4§(this.gameKernel,_loc17_,_loc19_,_loc20_);
         var _loc23_:§_-ka§ = new §_-ka§(50,2000,100,_loc13_,_loc14_,_loc22_,null);
         param1.§_-2d§(_loc23_);
         var _loc24_:§_-VX§ = new §_-VX§(1000,1000,1000,1000,0,8000,_loc11_,null,true);
         param1.§_-2d§(_loc24_);
         var _loc25_:BitmapData = new BitmapData(20,20,false,0);
         _loc25_.perlinNoise(20,20,3,13,false,true);
         var _loc26_:§_-pi§ = this.§_-BT§.getResource("plasma/shot");
         var _loc27_:§_-T§ = new §_-T§(_loc26_,null);
         param1.§_-2d§(_loc27_);
      }
      
      private function §_-Gy§(param1:§_-gw§) : void
      {
         var _loc5_:§_-l3§ = new §_-l3§(1000,1,15,true);
         param1.§_-2d§(_loc5_);
         var _loc7_:Number = 30 * Math.PI / 180;
         var _loc10_:§_-Fj§ = this.§_-N§();
         var _loc11_:§_-47§ = new §_-47§(3000,_loc7_,20,3000,_loc10_);
         param1.§_-2d§(_loc11_);
         var _loc16_:§_-1I§ = this.gameKernel.§_-DZ§();
         var _loc17_:§_-pi§ = this.§_-BT§.getResource("firebird/diffuse");
         var _loc18_:§_-pi§ = this.§_-BT§.getResource("firebird/opacity");
         _loc16_.§_-09§(_loc17_);
         _loc16_.§_-09§(_loc18_);
         §_-47§.init(_loc17_,_loc18_);
         var _loc19_:§_-fx§ = this.gameKernel.§_-m8§().§_-d-§().collisionDetector;
         var _loc20_:§_-Rp§ = §_-NB§.INSTANCE;
         var _loc21_:§_-kW§ = new §_-kW§(3000,_loc7_,10,10,_loc19_,_loc20_);
         var _loc22_:§_-bh§ = new §_-bh§(this.config.soundsLibrary.§_-lM§("flamethrower/shot"));
         var _loc23_:§_-ke§ = new §_-ke§(1000,100,_loc21_,_loc22_,true,false);
         param1.§_-2d§(_loc23_);
      }
      
      private function §_-Gt§(param1:Vector.<BitmapData>) : Vector.<§_-b9§>
      {
         var _loc3_:BitmapData = null;
         var _loc2_:Vector.<§_-b9§> = new Vector.<§_-b9§>();
         for each(_loc3_ in param1)
         {
         }
         return _loc2_;
      }
      
      private function §_-1w§() : void
      {
         var _loc1_:§_-gw§ = null;
         if(this.§_-Dx§ >= 0)
         {
            _loc1_ = this.activeTank;
            this.gameKernel.§_-13§(_loc1_);
            this.tanks.splice(this.§_-Dx§,1);
            if(this.tanks.length == 0)
            {
               this.§_-Dx§ = -1;
            }
            else
            {
               this.§_-Dx§--;
               this.§_-mn§(this.§_-Dx§);
            }
         }
      }
      
      private function §_-v§() : void
      {
         if(this.§_-8c§ == this.§_-al§)
         {
            this.§_-N8§(this.§_-Wv§);
         }
         else if(this.§_-8c§ == this.freeCameraController)
         {
            this.§_-N8§(this.§_-al§);
         }
         else
         {
            this.§_-N8§(this.freeCameraController);
         }
      }
      
      private function §_-N8§(param1:§_-gb§) : void
      {
         if(this.activeTank != null)
         {
            if(param1 == this.§_-Wv§)
            {
               this.§_-Wv§.§_-O-§(this.activeTank);
            }
            if(param1 == this.§_-al§)
            {
               this.§_-al§.§_-O-§(this.activeTank);
            }
            if(param1 == this.freeCameraController)
            {
               this.freeCameraController.§_-O-§(this.activeTank);
            }
         }
         this.gameKernel.§_-DZ§().§_-N8§(param1);
         this.§_-8c§ = param1;
      }
      
      private function §_-E-§(param1:§_-7d§, param2:BitmapData, param3:BitmapData, param4:Number, param5:Number) : §_-2W§
      {
         var _loc15_:§_-dT§ = null;
         var _loc16_:§_-49§ = null;
         var _loc6_:§_-1I§ = this.gameKernel.§_-DZ§();
         var _loc7_:§_-Hk§ = param1.textureData;
         var _loc8_:§_-KJ§ = this.§_-fa§.§_-kb§(_loc7_.§_-HG§(§_-Uk§.KEY_DIFFUSE_MAP));
         var _loc9_:§_-KJ§ = this.§_-fa§.§_-kb§(_loc7_.§_-HG§(§_-Uk§.KEY_NORMAL_MAP));
         var _loc10_:§_-KJ§ = this.§_-fa§.§_-kb§(_loc7_.§_-HG§(§_-Uk§.KEY_SURFACE_MAP));
         var _loc11_:§_-b1§ = this.§_-fa§.§_-F6§(param2);
         var _loc12_:§_-b1§ = this.§_-fa§.§_-F6§(param3);
         var _loc13_:TankMaterial2 = new TankMaterial2(_loc11_,_loc8_,_loc9_,_loc10_);
         var _loc14_:TankMaterial2 = new TankMaterial2(_loc12_,_loc8_,_loc9_,_loc10_);
         _loc13_.§_-jM§ = param4;
         _loc13_.§_-Sf§ = param5;
         _loc14_.§_-jM§ = param4;
         _loc14_.§_-Sf§ = param5;
         _loc6_.§_-09§(param1.geometry);
         if(param1 is §_-dT§)
         {
            _loc15_ = §_-dT§(param1);
            for each(var _loc19_ in _loc15_.§_-EY§.concat(_loc15_.§_-M4§))
            {
               _loc16_ = _loc19_;
               _loc19_;
               _loc6_.§_-09§(_loc16_.geometry);
            }
            _loc6_.§_-09§(_loc15_.§_-Ei§.geometry);
            _loc6_.§_-09§(_loc15_.§_-iA§.geometry);
            _loc6_.§_-09§(_loc15_.shadow.geometry);
         }
         return new §_-2W§(_loc13_,_loc14_);
      }
      
      private function §_-Ps§() : void
      {
         var _loc1_:§_-7-§ = new §_-7-§(20,20,20);
      }
      
      private function §_-ab§() : void
      {
         this.§_-T2§ = null;
         null;
      }
      
      private function §_-N§() : §_-Fj§
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Vector.<§_-ok§> = null;
         var _loc6_:§_-Fj§ = null;
         var _loc1_:BitmapData = this.config.§_-WX§.§_-o0§("flame/sprite") as BitmapData;
         var _loc2_:Vector.<BitmapData> = §_-mc§.§_-YA§(_loc1_);
         var _loc3_:Vector.<§_-b9§> = new Vector.<§_-b9§>();
         for each(var _loc9_ in _loc2_)
         {
            _loc4_ = _loc9_;
            _loc9_;
         }
         _loc5_ = new Vector.<§_-ok§>();
         _loc5_.push(new §_-ok§(0,3));
         _loc5_.push(new §_-ok§(0.5));
         _loc5_.push(new §_-ok§(0.75,0.2,0.2,0.2));
         _loc5_.push(new §_-ok§(1,0,0,0,0));
         return new §_-Fj§(_loc3_,_loc5_);
      }
      
      private function §_-3i§() : void
      {
         this.§_-X7§();
         this.§_-N3§();
         this.§_-5L§();
      }
      
      private function §_-X7§() : void
      {
         var _loc2_:§_-fx§ = null;
         var _loc3_:§_-Is§ = null;
         var _loc4_:§_-bj§ = null;
         var _loc5_:§_-jr§ = null;
         var _loc6_:§_-bj§ = null;
         var _loc7_:§_-bj§ = null;
         var _loc8_:Vector.<§_-pi§> = null;
         var _loc9_:Vector.<§_-b9§> = null;
         var _loc10_:§_-Y1§ = null;
         var _loc1_:§_-gw§ = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.gameKernel.§_-m8§().§_-d-§().collisionDetector;
            _loc3_ = §_-Is§(_loc1_.getComponentStrict(§_-Is§));
            _loc4_ = _loc3_.getBody().state.position;
            _loc5_ = new §_-jr§();
            if(_loc2_.§_-cX§(_loc4_,§_-bj§.DOWN,§_-HM§.STATIC,1000,null,_loc5_))
            {
               _loc6_ = _loc5_.position.clone();
               _loc6_.z = _loc6_.z + 1;
               _loc7_ = new §_-bj§();
               _loc7_.x = -Math.acos(_loc5_.normal.z);
               if(_loc5_.normal.z < 0.999)
               {
                  _loc7_.z = Math.atan2(-_loc5_.normal.x,_loc5_.normal.y);
               }
               _loc8_ = this.§_-pb§.getFrames("tank_explosion/shock_wave");
               _loc9_ = this.§_-0u§(_loc8_);
               _loc10_ = §_-Y1§(this.gameKernel.§_-11§().§_-kP§(§_-Y1§));
               _loc10_.init(conShockSize.value,_loc6_,_loc7_,_loc9_,30,conShockSizeGrow.value);
               this.gameKernel.§_-DZ§().each(_loc10_);
            }
         }
      }
      
      private function §_-N3§() : void
      {
         var _loc2_:Vector.<§_-pi§> = null;
         var _loc3_:Vector.<§_-b9§> = null;
         var _loc4_:§_-Xx§ = null;
         var _loc5_:§_-Is§ = null;
         var _loc6_:§_-bj§ = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:§_-gw§ = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.§_-pb§.getFrames("tank_explosion/explosion");
            _loc3_ = this.§_-0u§(_loc2_);
            _loc4_ = §_-Xx§(this.gameKernel.§_-11§().§_-kP§(§_-Xx§));
            _loc5_ = §_-Is§(this.activeTank.getComponentStrict(§_-Is§));
            _loc6_ = _loc5_.getBody().state.position.clone();
            _loc6_.z = _loc6_.z + 100;
            _loc7_ = Math.random() * Math.PI;
            _loc8_ = 400;
            _loc9_ = 25;
            _loc4_.init(600,600,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_,false);
            this.gameKernel.§_-DZ§().each(_loc4_);
         }
      }
      
      private function §_-5L§() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Vector.<§_-pi§> = null;
         var _loc11_:Vector.<§_-b9§> = null;
         var _loc12_:§_-Is§ = null;
         var _loc13_:§_-bj§ = null;
         var _loc14_:§_-bj§ = null;
         var _loc15_:Number = NaN;
         var _loc16_:§_-bj§ = null;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:§_-7Y§ = null;
         var _loc21_:Number = NaN;
         var _loc1_:§_-gw§ = this.activeTank;
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
            _loc10_ = this.§_-pb§.getFrames("tank_explosion/smoke");
            _loc11_ = this.§_-0u§(_loc10_);
            _loc12_ = §_-Is§(this.activeTank.getComponentStrict(§_-Is§));
            _loc13_ = _loc12_.getBody().state.position.clone();
            _loc13_.z = _loc13_.z + _loc2_;
            _loc14_ = new §_-bj§();
            _loc15_ = Math.random() * Math.PI;
            _loc16_ = new §_-bj§();
            _loc17_ = 0;
            while(_loc17_ < 3)
            {
               _loc16_.x = Math.cos(_loc15_);
               _loc16_.y = Math.sin(_loc15_);
               _loc18_ = Math.random() * (_loc4_ - _loc3_) + _loc3_;
               _loc19_ = _loc5_ + Math.random() * (_loc6_ - _loc5_);
               _loc14_.copy(_loc16_).scale(Math.sin(_loc18_)).add(§_-bj§.UP).normalize().scale(_loc19_);
               _loc20_ = §_-7Y§(this.gameKernel.§_-11§().§_-kP§(§_-7Y§));
               _loc21_ = Math.random() * Math.PI;
               _loc20_.init(_loc9_,_loc9_,_loc11_,_loc13_,_loc14_,_loc8_,_loc21_,_loc7_,false);
               this.gameKernel.§_-DZ§().each(_loc20_);
               _loc15_ = _loc15_ + 2 / 3 * Math.PI;
               _loc17_++;
            }
         }
      }
      
      private function §_-0u§(param1:Vector.<§_-pi§>) : Vector.<§_-b9§>
      {
         FrameMaterialsFactory.INSTANCE.renderSystem = this.gameKernel.§_-DZ§();
         return this.§_-3u§.§_-6i§(param1,FrameMaterialsFactory.INSTANCE) as Vector.<§_-b9§>;
      }
      
      private function §_-3R§(param1:§_-6A§, param2:Array) : void
      {
         var _loc3_:§_-gw§ = null;
         var _loc4_:§_-cx§ = null;
         var _loc5_:§_-BV§ = null;
         for each(var _loc8_ in this.tanks)
         {
            _loc3_ = _loc8_;
            _loc8_;
            _loc4_ = §_-cx§(_loc3_.getComponentStrict(§_-cx§));
            _loc5_ = _loc4_.body;
            param1.§_-MR§("Tank " + _loc5_.id);
            param1.§_-MR§("position " + _loc5_.state.position);
            param1.§_-MR§("velocity " + _loc5_.state.velocity);
         }
      }
   }
}

import §_-1e§.§_-Nh§;
import §_-1z§.§_-KJ§;
import §_-1z§.§_-b1§;
import §_-1z§.§_-pi§;
import §_-7A§.§_-3e§;
import §_-My§.§_-8z§;
import §_-O5§.§_-hM§;
import §_-R8§.§_-QM§;
import §_-Vh§.§_-YD§;
import §_-Vh§.§_-b9§;
import §_-Vh§.§_-pZ§;
import §_-Yn§.§_-L8§;
import §_-az§.§_-AG§;
import §_-cv§.§_-Tv§;
import §_-dz§.§_-2p§;
import §_-dz§.§_-Zh§;
import §_-e6§.§_-1I§;
import §_-nl§.Matrix4;
import §_-nl§.§_-bj§;
import §default§.§_-Vp§;
import §default§.§_-af§;
import flash.display.BitmapData;
import flash.media.Sound;
import flash.utils.ByteArray;
import §function§.§_-OF§;
import §function§.§_-Xx§;
import §return§.§_-mc§;

class FrameMaterialsFactory implements §_-8z§
{
   public static const INSTANCE:FrameMaterialsFactory = new FrameMaterialsFactory();
   
   public var renderSystem:§_-1I§;
   
   public function FrameMaterialsFactory()
   {
      super();
   }
   
   public function createData(param1:Object) : Object
   {
      var _loc6_:§_-pZ§ = null;
      var _loc2_:Vector.<§_-pi§> = param1 as Vector.<§_-pi§>;
      var _loc3_:int = int(_loc2_.length);
      var _loc4_:Vector.<§_-b9§> = new Vector.<§_-b9§>(_loc3_);
      var _loc5_:int = 0;
      while(_loc5_ < _loc3_)
      {
         this.renderSystem.§_-09§(_loc2_[_loc5_]);
         _loc6_ = new §_-pZ§(_loc2_[_loc5_]);
         _loc6_.§_-L4§ = true;
         _loc4_[_loc5_] = _loc6_;
         _loc5_++;
      }
      return _loc4_;
   }
}

class DummyTurretCallback implements §_-af§
{
   public function DummyTurretCallback()
   {
      super();
   }
   
   public function onTurretControlChanged(param1:int, param2:Boolean) : void
   {
   }
}

class PointHitRoundAmmo implements §_-Zh§
{
   private var impactForce:Number;
   
   private var weaponDistanceWeakening:§_-QM§;
   
   private var weaponHitEffects:WeaponHitEffects;
   
   public function PointHitRoundAmmo(param1:§_-AG§)
   {
      var _loc5_:int = 0;
      super();
      this.impactForce = 10000;
      this.weaponDistanceWeakening = new §_-QM§(10000,15000,0.5);
      var _loc2_:Vector.<§_-b9§> = new Vector.<§_-b9§>();
      var _loc4_:int = 0;
      while(_loc4_ < 20)
      {
         _loc5_ = 255 - 255 / (20 - 1) * _loc4_;
         _loc2_.push(new §_-YD§(§_-hM§.§_-TU§(_loc5_,_loc5_,_loc5_),_loc5_ / 255 + 0.5));
         _loc4_++;
      }
      this.weaponHitEffects = new WeaponHitEffects(null,_loc2_,param1);
   }
   
   public function getRound() : §_-2p§
   {
      return new §_-L8§(this.impactForce,this.weaponDistanceWeakening,this.weaponHitEffects);
   }
}

class WeaponHitEffects implements §_-OF§
{
   private var sound:Sound;
   
   private var frames:Vector.<§_-b9§>;
   
   private var gameKernel:§_-AG§;
   
   public function WeaponHitEffects(param1:Sound, param2:Vector.<§_-b9§>, param3:§_-AG§)
   {
      super();
      this.sound = param1;
      this.frames = param2;
      this.gameKernel = param3;
   }
   
   public function createEffects(param1:§_-bj§, param2:Number, param3:Number) : void
   {
      var _loc4_:§_-Xx§ = §_-Xx§(this.gameKernel.§_-11§().§_-kP§(§_-Xx§));
      _loc4_.init(600,600,this.frames,param1,0,50,30,false);
      this.gameKernel.§_-DZ§().each(_loc4_);
   }
}

class TextureResourceCache
{
   private var textureLibrary:§_-Tv§;
   
   private var cache:Object = {};
   
   public function TextureResourceCache(param1:§_-Tv§)
   {
      super();
      this.textureLibrary = param1;
   }
   
   public function getResource(param1:String) : §_-pi§
   {
      var _loc3_:Object = null;
      var _loc2_:§_-pi§ = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.§_-o0§(param1);
         if(_loc3_ is BitmapData)
         {
            _loc2_ = new §_-b1§(_loc3_ as BitmapData);
            this.cache[param1] = _loc2_;
         }
         else if(_loc3_ is ByteArray)
         {
            _loc2_ = new §_-KJ§(_loc3_ as ByteArray);
            this.cache[param1] = _loc2_;
         }
      }
      return _loc2_;
   }
}

class MultiBitmapTextureResourceCache
{
   private var textureLibrary:§_-Tv§;
   
   private var cache:Object = {};
   
   public function MultiBitmapTextureResourceCache(param1:§_-Tv§)
   {
      super();
      this.textureLibrary = param1;
   }
   
   public function getFrames(param1:String) : Vector.<§_-pi§>
   {
      var _loc3_:BitmapData = null;
      var _loc4_:Vector.<BitmapData> = null;
      var _loc5_:int = 0;
      var _loc2_:Vector.<§_-pi§> = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.§_-o0§(param1) as BitmapData;
         _loc4_ = §_-mc§.§_-YA§(_loc3_);
         _loc2_ = new Vector.<§_-pi§>(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_[_loc5_] = new §_-b1§(_loc4_[_loc5_]);
            _loc5_++;
         }
         this.cache[param1] = _loc2_;
      }
      return _loc2_;
   }
}

class DummyTurret implements §_-3e§
{
   public function DummyTurret()
   {
      super();
   }
   
   public function setTurret(param1:§_-Vp§) : void
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
   
   public function setTurretMountPoint(param1:§_-bj§) : void
   {
   }
   
   public function getTurretPrimitives() : Vector.<§_-Nh§>
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
   
   public function getSkinMountPoint(param1:§_-bj§) : void
   {
   }
   
   public function getGunData(param1:int, param2:§_-bj§, param3:§_-bj§, param4:§_-bj§) : void
   {
   }
   
   public function getGunMuzzleData(param1:int, param2:§_-bj§, param3:§_-bj§) : void
   {
      param2.reset(0,0,2000);
      param3.reset(0,0,1);
   }
   
   public function getGunMuzzleData2(param1:int, param2:§_-bj§, param3:§_-bj§) : void
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
