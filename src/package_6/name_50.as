package package_6
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.tanks.game.usertitle.component.name_156;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Vector3D;
   import flash.ui.Keyboard;
   import package_1.TankMaterial2;
   import package_1.name_30;
   import package_1.name_31;
   import package_11.name_4;
   import package_12.name_191;
   import package_12.name_54;
   import package_14.name_3;
   import package_15.class_1;
   import package_15.name_17;
   import package_15.name_53;
   import package_15.name_56;
   import package_16.name_18;
   import package_18.name_228;
   import package_18.name_51;
   import package_2.name_1;
   import package_2.name_9;
   import package_20.class_7;
   import package_20.name_55;
   import package_21.name_152;
   import package_21.name_172;
   import package_21.name_84;
   import package_21.name_86;
   import package_22.name_163;
   import package_28.name_112;
   import package_28.name_201;
   import package_3.class_5;
   import package_3.name_139;
   import package_32.name_180;
   import package_33.name_130;
   import package_33.name_187;
   import package_37.name_150;
   import package_37.name_153;
   import package_37.name_168;
   import package_37.name_173;
   import package_37.name_177;
   import package_37.name_212;
   import package_38.name_145;
   import package_39.name_161;
   import package_39.name_164;
   import package_39.name_193;
   import package_39.name_194;
   import package_39.name_227;
   import package_39.name_232;
   import package_39.name_236;
   import package_39.name_238;
   import package_39.name_240;
   import package_39.name_257;
   import package_4.name_215;
   import package_4.name_216;
   import package_4.name_24;
   import package_40.class_10;
   import package_40.name_151;
   import package_40.name_176;
   import package_40.name_199;
   import package_40.name_203;
   import package_40.name_225;
   import package_40.name_250;
   import package_41.name_146;
   import package_41.name_229;
   import package_42.name_147;
   import package_43.name_154;
   import package_43.name_171;
   import package_44.name_174;
   import package_44.name_196;
   import package_44.name_198;
   import package_44.name_208;
   import package_44.name_249;
   import package_45.name_190;
   import package_45.name_204;
   import package_45.name_224;
   import package_45.name_233;
   import package_46.name_175;
   import package_46.name_178;
   import package_47.name_158;
   import package_48.name_162;
   import package_49.name_159;
   import package_50.name_184;
   import package_50.name_185;
   import package_51.name_169;
   import package_52.name_166;
   import package_53.name_200;
   import package_53.name_235;
   import package_53.name_241;
   import package_54.name_170;
   import package_55.name_182;
   import package_56.name_183;
   import package_57.name_179;
   import package_58.name_189;
   import package_59.name_210;
   import package_60.name_213;
   import package_60.name_278;
   import package_61.name_186;
   import package_62.name_211;
   import package_63.name_192;
   import package_64.name_197;
   import package_65.name_195;
   import package_66.name_209;
   import package_67.name_207;
   import package_68.name_202;
   import package_69.name_219;
   import package_71.MouseEvent3D;
   
   use namespace alternativa3d;
   
   public class name_50 extends class_1 implements class_7
   {
      private static const DEAD_TEXTURE_ID:String = "dead";
      
      private static var conShockSize:name_1 = new name_1("shock_size",1200,0,2000);
      
      private static var conShockSizeGrow:name_1 = new name_1("shock_size_grow",200,0,2000);
      
      private static var conPysicsDebug:name_9 = new name_9("physics_debug",0,0,1);
      
      private static var conMaxSpeed:name_1 = new name_1("max_speed",800,0,2000);
      
      private static var log:name_180 = name_180(name_3.name_8().name_21(name_180));
      
      private var config:name_18;
      
      private var gameKernel:name_17;
      
      private var var_82:int = 0;
      
      private var var_79:Vector.<name_168> = new Vector.<name_168>();
      
      private var tanks:Vector.<name_53>;
      
      private var var_62:int;
      
      private var var_74:name_162;
      
      private var var_77:name_162;
      
      private var var_76:name_162;
      
      private var var_73:BitmapData;
      
      private var var_67:name_216;
      
      private var var_69:name_215;
      
      private var freeCameraController:name_24;
      
      private var var_68:name_228;
      
      private var var_81:name_207;
      
      private var var_75:name_202;
      
      private var var_70:name_183;
      
      private var var_63:int;
      
      private var var_66:int;
      
      private var var_78:int;
      
      private var var_61:TextureResourceCache;
      
      private var var_64:MultiBitmapTextureResourceCache;
      
      private var var_65:name_206;
      
      private var var_71:name_211;
      
      private var preloader:Preloader;
      
      private var var_72:name_53;
      
      private var var_80:name_210 = new name_210();
      
      public function name_50(param1:int, param2:name_18, param3:name_17, param4:name_24, param5:Preloader)
      {
         super(param1);
         this.preloader = param5;
         this.config = param2;
         this.gameKernel = param3;
         this.freeCameraController = param4;
         this.tanks = new Vector.<name_53>();
         this.var_62 = -1;
         this.var_73 = new BitmapData(1,1);
         this.var_73.setPixel(0,0,11141120);
         this.var_68 = param4;
         this.var_61 = new TextureResourceCache(param2.var_37);
         this.var_64 = new MultiBitmapTextureResourceCache(param2.var_37);
         this.var_65 = new name_206(param3);
         TanksTestingTool.testTask = this;
      }
      
      override public function start() : void
      {
         var _loc1_:name_112 = name_112(var_4.getTaskInterface(name_112));
         _loc1_.name_262(name_201.KEY_DOWN,this.method_14);
         var _loc2_:name_55 = name_55(var_4.getTaskInterface(name_55));
         _loc2_.addEventListener(name_166.TANK_CLICK,this);
         this.var_67 = new name_216(this.gameKernel.name_5().name_20(),this.gameKernel.method_37().name_157().collisionDetector,name_170.STATIC,_loc1_);
         this.var_69 = new name_215(this.gameKernel.name_5().name_20(),this.gameKernel.method_37().name_157().collisionDetector,name_170.STATIC,_loc1_);
         this.var_81 = new name_207(this.gameKernel.name_5());
         this.var_75 = new name_202();
         this.gameKernel.stage.addChild(this.var_75);
         var _loc3_:name_4 = name_4(name_3.name_8().name_21(name_4));
         _loc3_.name_34("addtank",this.method_72);
         var _loc4_:XMLList = this.config.xml.elements("console-commands");
         if(_loc4_.length() > 0)
         {
            this.method_65(_loc3_,this.config.xml.elements("console-commands")[0].toString());
         }
         _loc3_.name_34("lstanks",this.method_63);
         this.var_71 = new name_211(name_17.RENDER_SYSTEM_PRIORITY + 1,10,this.gameKernel.stage,0,0);
         this.gameKernel.addTask(this.var_71);
         this.gameKernel.name_60().addEventListener(name_56.MAP_COMPLETE,this);
      }
      
      private function get activeTank() : name_53
      {
         return this.var_62 >= 0 ? this.tanks[this.var_62] : null;
      }
      
      private function method_53(param1:int) : void
      {
         if(param1 >= 0 && param1 < this.tanks.length)
         {
            if(this.activeTank != null)
            {
               this.activeTank.dispatchEvent(name_164.SET_DISABLED_STATE);
            }
            this.var_62 = param1;
            this.activeTank.dispatchEvent(name_164.SET_ACTIVE_STATE);
            if(this.var_68 == this.var_67)
            {
               this.var_67.name_181(this.activeTank);
            }
            if(this.var_68 == this.var_69)
            {
               this.var_69.name_181(this.activeTank);
            }
         }
      }
      
      public function include() : void
      {
         if(this.tanks.length > 0)
         {
            this.method_53((this.var_62 + 1) % this.tanks.length);
         }
         if(this.var_68 != this.var_67)
         {
            this.name_62(this.var_67);
         }
      }
      
      private function method_79() : void
      {
         var _loc1_:int = 0;
         if(this.tanks.length > 0)
         {
            _loc1_ = this.var_62 - 1;
            if(_loc1_ < 0)
            {
               _loc1_ = this.tanks.length - 1;
            }
            this.method_53(_loc1_);
         }
      }
      
      private function method_65(param1:name_4, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc3_:Array = param2.split(/\r*\n/);
         for each(_loc4_ in _loc3_)
         {
            param1.name_248(_loc4_);
         }
      }
      
      private function method_72(param1:name_4, param2:Array) : void
      {
         this.method_55(name_149.name_244(param2));
      }
      
      private function method_14(param1:name_201, param2:uint) : void
      {
         var _loc3_:name_51 = null;
         var _loc4_:int = 0;
         switch(param2)
         {
            case Keyboard.Q:
               _loc3_ = this.gameKernel.name_5();
               _loc4_ = int(_loc3_.name_253());
               _loc3_.name_275(_loc4_ == 0 ? 4 : 0);
               break;
            case Keyboard.M:
            case Keyboard.BACKSLASH:
               this.method_71();
               break;
            case Keyboard.N:
               if(this.var_68 == this.freeCameraController)
               {
                  name_24.targeted = !name_24.targeted;
                  break;
               }
               name_24.targeted = true;
               this.name_62(this.freeCameraController);
               break;
            case Keyboard.ENTER:
               this.include();
         }
      }
      
      private function method_95() : void
      {
         var _loc1_:name_147 = null;
         var _loc2_:name_186 = null;
         if(this.activeTank != null)
         {
            _loc1_ = name_147(this.activeTank.getComponent(name_147));
            _loc2_ = _loc1_.body;
            _loc2_.state.velocity.z = 1000;
         }
      }
      
      private function method_89() : void
      {
         var _loc2_:name_156 = null;
         var _loc1_:name_53 = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = name_156(_loc1_.getComponent(name_156));
            if(_loc2_.name_251())
            {
               _loc2_.removeFromScene();
            }
            else
            {
               _loc2_.addToScene();
            }
         }
      }
      
      private function method_91() : void
      {
         this.var_71.name_223("Message: " + Math.random(),name_191.random());
      }
      
      private function method_93() : Boolean
      {
         return this.gameKernel.name_65().name_272(Keyboard.CONTROL);
      }
      
      private function method_84(param1:int, param2:Boolean) : void
      {
         var _loc3_:name_156 = null;
         if(this.activeTank != null)
         {
            _loc3_ = name_156(this.activeTank.getComponentStrict(name_156));
            if(param2)
            {
               _loc3_.name_265(param1,10000);
            }
            else
            {
               _loc3_.name_254(param1);
            }
         }
      }
      
      private function method_88() : void
      {
         var _loc3_:name_86 = null;
         var _loc4_:Vector.<name_139> = null;
         var _loc5_:int = 0;
         var _loc8_:class_5 = null;
         var _loc1_:Vector.<name_86> = this.var_64.getFrames("thunder/explosion");
         var _loc2_:name_51 = this.gameKernel.name_5();
         for each(_loc3_ in _loc1_)
         {
            _loc2_.name_148(_loc3_);
         }
         _loc4_ = new Vector.<name_139>(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc8_ = new class_5(_loc1_[_loc5_]);
            _loc8_.var_21 = true;
            _loc4_[_loc5_] = _loc8_;
            _loc5_++;
         }
         var _loc6_:name_150 = name_150(this.gameKernel.method_33().name_165(name_150));
         var _loc7_:name_145 = new name_145(Math.random() * 3000,Math.random() * 3000,1000 + Math.random() * 3000);
         _loc6_.init(300,300,_loc4_,_loc7_,0,0,30,true);
         _loc2_.method_21(_loc6_);
      }
      
      private function method_85() : void
      {
         var _loc1_:name_86 = this.var_61.getResource("smoky/diffuse");
         var _loc2_:name_86 = this.var_61.getResource("smoky/opacity");
         var _loc3_:name_51 = this.gameKernel.name_5();
         _loc3_.name_148(_loc1_);
         _loc3_.name_148(_loc2_);
         var _loc4_:name_179 = name_179(this.gameKernel.method_33().name_165(name_179));
         _loc4_.init(new DummyTurret(),_loc1_,_loc2_);
         _loc3_.method_21(_loc4_);
      }
      
      private function method_86() : void
      {
         --this.var_66;
         if(this.var_66 < 0)
         {
            this.var_66 += this.config.tankParts.name_220;
         }
         this.method_56();
      }
      
      private function method_78() : void
      {
         this.var_66 = (this.var_66 + 1) % this.config.tankParts.name_220;
         this.method_56();
      }
      
      private function method_76() : void
      {
         --this.var_63;
         if(this.var_63 < 0)
         {
            this.var_63 += this.config.tankParts.name_218;
         }
         this.method_56();
      }
      
      public function method_77() : void
      {
         this.var_63 = (this.var_63 + 1) % this.config.tankParts.name_218;
         this.method_56();
      }
      
      private function method_56() : void
      {
         var _loc2_:name_149 = null;
         var _loc3_:name_53 = null;
         var _loc4_:name_146 = null;
         var _loc5_:name_146 = null;
         var _loc6_:name_145 = null;
         var _loc1_:name_53 = this.activeTank;
         if(_loc1_ != null)
         {
            this.method_67();
            _loc2_ = new name_149();
            _loc2_.hull = this.config.tankParts.name_280(this.var_63).id;
            _loc2_.turret = this.config.tankParts.name_260(this.var_66).id;
            _loc2_.coloring = this.var_78;
            _loc3_ = this.method_55(_loc2_);
            this.method_53(this.tanks.length - 1);
            _loc4_ = name_146(_loc1_.getComponentStrict(name_146));
            _loc5_ = name_146(_loc3_.getComponentStrict(name_146));
            _loc5_.getBody().name_282(_loc4_.getBody().state.orientation);
            _loc6_ = _loc4_.getBody().state.position.clone();
            _loc6_.z += 200;
            _loc5_.getBody().name_230(_loc6_);
         }
      }
      
      override public function run() : void
      {
      }
      
      private function method_80() : void
      {
         var _loc1_:name_159 = null;
         if(this.activeTank != null)
         {
            if(this.var_70 == null)
            {
               this.var_70 = name_183(this.gameKernel.method_33().name_165(name_183));
               _loc1_ = name_159(this.activeTank.getComponentStrict(name_159));
               this.var_70.init(5000,_loc1_.name_252(),this.method_64);
               this.gameKernel.name_5().method_21(this.var_70);
            }
            this.var_70.name_223("Message " + Math.random(),65280);
         }
      }
      
      public function method_81(param1:String, param2:*) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<name_187> = null;
         var _loc5_:Vector.<name_187> = null;
         var _loc6_:name_149 = null;
         var _loc7_:XMLList = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:name_53 = null;
         var _loc11_:name_172 = null;
         var _loc12_:name_152 = null;
         switch(param1)
         {
            case name_166.TANK_CLICK:
               _loc3_ = int(this.tanks.indexOf(name_53(param2)));
               if(_loc3_ >= 0)
               {
                  this.method_53(_loc3_);
               }
               break;
            case name_56.MAP_COMPLETE:
               this.name_62(this.var_67);
               if(this.config.xml.user.length() > 0)
               {
                  _loc6_ = name_149.name_239(this.config.xml.user[0],true);
                  this.var_78 = _loc6_.coloring;
                  this.var_63 = this.config.tankParts.name_279(_loc6_.hull);
                  this.var_66 = this.config.tankParts.name_263(_loc6_.turret);
                  if(this.var_63 < 0)
                  {
                     throw new ArgumentError("bad hull: " + _loc6_.hull);
                  }
                  if(this.var_66 < 0)
                  {
                     throw new ArgumentError("bad turret: " + _loc6_.turret);
                  }
                  this.method_55(_loc6_);
               }
               else
               {
                  this.method_55(name_149.defaultTankParams);
               }
               this.method_53(this.tanks.length - 1);
               if(this.config.xml.tanks.length() > 0)
               {
                  _loc7_ = this.config.xml.tanks[0].tank;
                  _loc8_ = 0;
                  _loc9_ = int(_loc7_.length());
                  while(_loc8_ < _loc9_)
                  {
                     _loc10_ = this.method_55(name_149.name_239(_loc7_[_loc8_]));
                     _loc10_.dispatchEvent(name_164.SET_ACTIVE_STATE);
                     _loc10_.dispatchEvent(name_164.SET_DISABLED_STATE);
                     _loc8_++;
                  }
               }
               _loc4_ = this.gameKernel.name_5().name_237().getResources(true,name_172);
               if(_loc4_.length > 0)
               {
                  _loc11_ = _loc4_[0] as name_172;
                  _loc11_.left = this.config.var_37.name_155("left_01") as BitmapData;
                  _loc11_.right = this.config.var_37.name_155("right_01") as BitmapData;
                  _loc11_.back = this.config.var_37.name_155("back_01") as BitmapData;
                  _loc11_.front = this.config.var_37.name_155("front_01") as BitmapData;
                  _loc11_.top = this.config.var_37.name_155("top_01") as BitmapData;
                  _loc11_.bottom = this.config.var_37.name_155("bottom_01") as BitmapData;
                  this.gameKernel.name_5().name_148(_loc11_);
               }
               this.method_62();
               this.config.clear();
               _loc5_ = this.gameKernel.name_5().name_237().getResources(true,name_152);
               for each(_loc12_ in _loc5_)
               {
                  _loc12_.data.clear();
                  _loc12_.data = null;
               }
               this.preloader.name_68(1);
         }
      }
      
      private function onMouseDown(param1:MouseEvent3D) : void
      {
         var _loc2_:Vector3D = name_130(param1.target).localToGlobal(new Vector3D(param1.localX,param1.localY,param1.localZ));
         log.log("mouse","click pos %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function method_90() : void
      {
      }
      
      private function method_94() : void
      {
         this.gameKernel.name_72(this.var_72);
         this.tanks.push(this.var_72);
         this.method_53(this.tanks.length - 1);
      }
      
      private function method_55(param1:name_149) : name_53
      {
         var _loc2_:name_53 = this.method_61(param1);
         this.gameKernel.name_72(_loc2_);
         this.tanks.push(_loc2_);
         return _loc2_;
      }
      
      private function method_61(param1:name_149) : name_53
      {
         var _loc2_:name_161 = this.config.tankParts.name_283(param1.hull);
         var _loc3_:name_227 = this.config.tankParts.name_255(param1.turret);
         var _loc4_:BitmapData = this.config.tankParts.name_274(param1.coloring);
         var _loc5_:BitmapData = this.config.var_37.name_155(DEAD_TEXTURE_ID) as BitmapData;
         var _loc6_:name_53 = new name_53(name_53.name_73());
         var _loc9_:name_147 = new name_147(_loc2_,1000,80000);
         var _loc10_:int = int(conMaxSpeed.value);
         _loc9_.name_243(_loc10_,true);
         _loc9_.name_259(2,true);
         _loc9_.name_230(new name_145(param1.x,param1.y,param1.z));
         _loc9_.body.name_256(param1.rotationX / 180 * Math.PI,param1.rotationY / 180 * Math.PI,param1.rotationZ / 180 * Math.PI);
         var _loc12_:name_166 = new name_166(_loc2_);
         _loc12_.name_269(this.method_58(_loc2_,_loc4_,_loc5_,6,6));
         _loc12_.name_268(this.method_69(_loc2_));
         _loc12_.name_270(this.method_59(_loc2_));
         _loc6_.name_59(_loc9_);
         _loc6_.name_59(_loc12_);
         _loc6_.name_59(new name_238(new name_233(this.config.soundsLibrary)));
         var _loc13_:name_194 = new name_194();
         _loc6_.name_59(_loc13_);
         _loc6_.name_59(new name_235());
         _loc6_.name_59(new name_229());
         var _loc14_:name_192 = new name_192(_loc3_,1,2);
         var _loc15_:name_159 = new name_159(_loc3_);
         _loc15_.name_277(this.method_58(_loc3_,_loc4_,_loc5_,3,3));
         _loc6_.name_59(_loc14_);
         _loc6_.name_59(_loc15_);
         _loc6_.name_59(new name_232(new name_224(this.config.soundsLibrary)));
         if(_loc3_.id.indexOf("Smoky") >= 0)
         {
            this.method_75(_loc6_);
         }
         else if(_loc3_.id.indexOf("Thunder") >= 0)
         {
            this.method_70(_loc6_);
         }
         else
         {
            this.method_60(_loc6_);
         }
         _loc6_.name_59(new name_236());
         if(conPysicsDebug.value == 1)
         {
            _loc6_.name_59(new name_241());
         }
         if(!param1.isUser)
         {
         }
         var _loc16_:Vector.<name_139> = this.method_54(this.var_64.getFrames("tank_explosion/shock_wave"));
         var _loc17_:Vector.<name_139> = this.method_54(this.var_64.getFrames("tank_explosion/explosion"));
         var _loc18_:Vector.<name_139> = this.method_54(this.var_64.getFrames("tank_explosion/smoke"));
         var _loc19_:name_200 = new name_200(1200,200,_loc16_,_loc17_,_loc18_);
         _loc6_.name_59(_loc19_);
         _loc6_.name_63();
         return _loc6_;
      }
      
      private function method_92() : void
      {
         var _loc1_:name_147 = name_147(this.tanks[this.var_62].getComponent(name_147));
         var _loc2_:name_145 = new name_145();
         _loc1_.name_258.name_267(_loc2_);
         _loc2_.x = _loc2_.x * 180 / Math.PI;
         _loc2_.y = _loc2_.y * 180 / Math.PI;
         _loc2_.z = _loc2_.z * 180 / Math.PI;
         log.log("tank","position %1 %2 %3",_loc1_.name_205.x.toFixed(),_loc1_.name_205.y.toFixed(),_loc1_.name_205.z.toFixed());
         log.log("tank","rotation %1 %2 %3",_loc2_.x.toFixed(),_loc2_.y.toFixed(),_loc2_.z.toFixed());
      }
      
      private function method_62() : void
      {
         var _loc4_:XMLList = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         var _loc8_:name_168 = null;
         var _loc9_:Array = null;
         var _loc1_:name_86 = this.var_61.getResource("fire/diffuse");
         var _loc2_:name_86 = this.var_61.getResource("fire/opacity");
         var _loc3_:name_51 = this.gameKernel.name_5();
         _loc3_.name_148(_loc1_);
         _loc3_.name_148(_loc2_);
         this.var_74 = new name_162(_loc1_,_loc2_,8,8,0,16,30,true);
         this.var_77 = new name_162(_loc1_,_loc2_,8,8,16,16,30,true);
         this.var_76 = new name_162(_loc1_,_loc2_,8,8,32,32,45,true,0.5,0.5);
         if(this.config.xml.effects.length() > 0)
         {
            _loc4_ = this.config.xml.effects[0].fire;
            _loc5_ = 0;
            _loc6_ = int(_loc4_.length());
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc4_[_loc5_];
               _loc8_ = new name_168(this.var_74,this.var_77,this.var_76,5,true);
               _loc9_ = _loc7_.@position.toString().split(/\s+/);
               _loc8_.position = new Vector3D(Number(_loc9_[0]),Number(_loc9_[1]),Number(_loc9_[2]));
               _loc8_.scale = Number(_loc7_.@scale);
               this.var_79.push(_loc8_);
               this.gameKernel.name_5().name_281(_loc8_);
               _loc5_++;
            }
         }
      }
      
      private function method_69(param1:name_161) : name_30
      {
         var _loc2_:name_54 = param1.textureData;
         var _loc3_:name_152 = this.var_65.name_167(_loc2_.name_160(name_154.KEY_TRACKS_DIFFUSE));
         var _loc4_:name_152 = this.var_65.name_167(_loc2_.name_160(name_154.KEY_TRACKS_NORMAL));
         var _loc5_:name_30 = new name_30();
         _loc5_.glossiness = 65;
         _loc5_.var_26 = 0.6;
         _loc5_.diffuseMap = _loc3_;
         _loc5_.normalMap = _loc4_;
         if(_loc2_.name_160(name_154.KEY_TRACKS_OPACITY) != null)
         {
            _loc5_.opacityMap = this.var_65.name_167(_loc2_.name_160(name_154.KEY_TRACKS_OPACITY));
         }
         return _loc5_;
      }
      
      private function method_59(param1:name_161) : name_31
      {
         var _loc3_:name_152 = null;
         var _loc2_:name_54 = param1.textureData;
         if(_loc2_.name_160(name_154.KEY_SHADOW) != null)
         {
            _loc3_ = this.var_65.name_167(_loc2_.name_160(name_154.KEY_SHADOW));
            return new name_31(_loc3_);
         }
         return null;
      }
      
      private function method_75(param1:name_53) : void
      {
         var _loc9_:name_86 = null;
         var _loc10_:Vector.<name_139> = null;
         var _loc11_:int = 0;
         var _loc18_:class_5 = null;
         var _loc3_:Number = 10000000 / 3;
         var _loc4_:name_169 = this.gameKernel.method_37().name_157().collisionDetector;
         var _loc5_:name_151 = new name_151();
         var _loc6_:name_174 = new name_174(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.name_231(this.gameKernel.method_37().name_157().collisionDetector);
         _loc6_.name_221(new name_151());
         var _loc7_:Vector.<name_86> = this.var_64.getFrames("thunder/explosion");
         var _loc8_:name_51 = this.gameKernel.name_5();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.name_148(_loc9_);
         }
         _loc10_ = new Vector.<name_139>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new class_5(_loc7_[_loc11_]);
            _loc18_.var_21 = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:name_86 = this.var_61.getResource("smoky/diffuse");
         var _loc13_:name_86 = this.var_61.getResource("smoky/opacity");
         _loc8_.name_148(_loc12_);
         _loc8_.name_148(_loc13_);
         name_185.init(_loc12_,_loc13_);
         var _loc14_:class_10 = new name_184(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:name_176 = new name_176(1000,_loc3_,_loc6_,_loc14_,new name_190(this.config.soundsLibrary.name_214("smoky/shot")),true);
         _loc15_.name_226 = true;
         param1.name_59(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         name_158.init(_loc12_,_loc13_);
         var _loc17_:name_158 = new name_158(this.var_61.getResource("thunder/shot"));
         param1.name_59(_loc17_);
      }
      
      private function method_70(param1:name_53) : void
      {
         var _loc9_:name_86 = null;
         var _loc10_:Vector.<name_139> = null;
         var _loc11_:int = 0;
         var _loc18_:class_5 = null;
         var _loc4_:name_169 = this.gameKernel.method_37().name_157().collisionDetector;
         var _loc5_:name_151 = new name_151();
         var _loc6_:name_174 = new name_174(Math.PI / 9,20,Math.PI / 9,20,_loc4_,_loc5_);
         _loc6_.name_231(this.gameKernel.method_37().name_157().collisionDetector);
         _loc6_.name_221(new name_151());
         var _loc7_:Vector.<name_86> = this.var_64.getFrames("thunder/explosion");
         var _loc8_:name_51 = this.gameKernel.name_5();
         for each(_loc9_ in _loc7_)
         {
            _loc8_.name_148(_loc9_);
         }
         _loc10_ = new Vector.<name_139>(_loc7_.length);
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc18_ = new class_5(_loc7_[_loc11_]);
            _loc18_.var_21 = true;
            _loc10_[_loc11_] = _loc18_;
            _loc11_++;
         }
         var _loc12_:name_86 = this.var_61.getResource("smoky/diffuse");
         var _loc13_:name_86 = this.var_61.getResource("smoky/opacity");
         _loc8_.name_148(_loc12_);
         _loc8_.name_148(_loc13_);
         name_185.init(_loc12_,_loc13_);
         var _loc14_:class_10 = new name_184(this.gameKernel,1000,10000000,200,100,0.5,null,_loc10_);
         var _loc15_:name_176 = new name_176(1000,3333333.3333333335,_loc6_,_loc14_,new name_190(this.config.soundsLibrary.name_214("thunder/shot")),true);
         _loc15_.name_226 = true;
         param1.name_59(_loc15_);
         var _loc16_:BitmapData = new BitmapData(20,20,false,0);
         _loc16_.perlinNoise(20,20,3,13,false,true);
         name_158.init(_loc12_,_loc13_);
         var _loc17_:name_158 = new name_158(this.var_61.getResource("thunder/shot"));
         param1.name_59(_loc17_);
      }
      
      private function method_83(param1:name_53) : void
      {
         var _loc5_:name_169 = this.gameKernel.method_37().name_157().collisionDetector;
         var _loc6_:name_209 = new name_209();
         var _loc7_:name_208 = new name_208(Math.PI / 9,20,Math.PI / 9,20,_loc5_,_loc6_);
      }
      
      private function method_82(param1:name_53) : void
      {
         var _loc9_:name_169 = this.gameKernel.method_37().name_157().collisionDetector;
         var _loc10_:name_151 = new name_151();
         var _loc11_:name_196 = new name_196(Math.PI / 4,20,Math.PI / 4,20,100,_loc9_,_loc10_);
         var _loc13_:Number = Number(name_225.BASE_FORCE);
         var _loc14_:name_250 = new name_182(2000,4000,0.5);
         var _loc15_:BitmapData = this.config.var_37.name_155("plasma/charge") as BitmapData;
         var _loc16_:Vector.<BitmapData> = name_163.name_188(_loc15_,_loc15_.height);
         var _loc17_:Vector.<name_139> = this.method_57(_loc16_);
         var _loc18_:BitmapData = this.config.var_37.name_155("plasma/explosion") as BitmapData;
         _loc16_ = name_163.name_188(_loc18_,_loc18_.height);
         var _loc19_:Vector.<name_139> = this.method_57(_loc16_);
         var _loc20_:ColorTransform = new ColorTransform(5);
         var _loc22_:name_278 = new name_219(this.gameKernel,_loc17_,_loc19_,_loc20_);
         var _loc23_:name_213 = new name_213(50,2000,100,_loc13_,_loc14_,_loc22_,null);
         param1.name_59(_loc23_);
         var _loc24_:name_199 = new name_199(1000,1000,1000,1000,0,8000,_loc11_,null,true);
         param1.name_59(_loc24_);
         var _loc25_:BitmapData = new BitmapData(20,20,false,0);
         _loc25_.perlinNoise(20,20,3,13,false,true);
         var _loc26_:name_86 = this.var_61.getResource("plasma/shot");
         var _loc27_:name_212 = new name_212(_loc26_,null);
         param1.name_59(_loc27_);
      }
      
      private function method_60(param1:name_53) : void
      {
         var _loc5_:name_203 = new name_203(1000,1,15,true);
         param1.name_59(_loc5_);
         var _loc7_:Number = 30 * Math.PI / 180;
         var _loc10_:name_175 = this.method_73();
         var _loc11_:name_178 = new name_178(3000,_loc7_,20,3000,_loc10_);
         param1.name_59(_loc11_);
         var _loc16_:name_51 = this.gameKernel.name_5();
         var _loc17_:name_86 = this.var_61.getResource("firebird/diffuse");
         var _loc18_:name_86 = this.var_61.getResource("firebird/opacity");
         _loc16_.name_148(_loc17_);
         _loc16_.name_148(_loc18_);
         name_178.init(_loc17_,_loc18_);
         var _loc19_:name_169 = this.gameKernel.method_37().name_157().collisionDetector;
         var _loc20_:name_249 = name_151.INSTANCE;
         var _loc21_:name_198 = new name_198(3000,_loc7_,10,10,_loc19_,_loc20_);
         var _loc22_:name_204 = new name_204(this.config.soundsLibrary.name_214("flamethrower/shot"));
         var _loc23_:name_197 = new name_197(1000,100,_loc21_,_loc22_,true,false);
         param1.name_59(_loc23_);
      }
      
      private function method_57(param1:Vector.<BitmapData>) : Vector.<name_139>
      {
         var _loc3_:BitmapData = null;
         var _loc2_:Vector.<name_139> = new Vector.<name_139>();
         for each(_loc3_ in param1)
         {
         }
         return _loc2_;
      }
      
      private function method_67() : void
      {
         var _loc1_:name_53 = null;
         if(this.var_62 >= 0)
         {
            _loc1_ = this.activeTank;
            this.gameKernel.method_34(_loc1_);
            this.tanks.splice(this.var_62,1);
            if(this.tanks.length == 0)
            {
               this.var_62 = -1;
            }
            else
            {
               this.var_62--;
               this.method_53(this.var_62);
            }
         }
      }
      
      private function method_71() : void
      {
         if(this.var_68 == this.var_69)
         {
            this.name_62(this.var_67);
         }
         else if(this.var_68 == this.freeCameraController)
         {
            this.name_62(this.var_69);
         }
         else
         {
            this.name_62(this.freeCameraController);
         }
      }
      
      private function name_62(param1:name_228) : void
      {
         if(this.activeTank != null)
         {
            if(param1 == this.var_67)
            {
               this.var_67.name_181(this.activeTank);
            }
            if(param1 == this.var_69)
            {
               this.var_69.name_181(this.activeTank);
            }
            if(param1 == this.freeCameraController)
            {
               this.freeCameraController.name_181(this.activeTank);
            }
         }
         this.gameKernel.name_5().name_62(param1);
         this.var_68 = param1;
      }
      
      private function method_58(param1:name_257, param2:BitmapData, param3:BitmapData, param4:Number, param5:Number) : name_193
      {
         var _loc15_:name_161 = null;
         var _loc16_:name_240 = null;
         var _loc6_:name_51 = this.gameKernel.name_5();
         var _loc7_:name_54 = param1.textureData;
         var _loc8_:name_152 = this.var_65.name_167(_loc7_.name_160(name_171.KEY_DIFFUSE_MAP));
         var _loc9_:name_152 = this.var_65.name_167(_loc7_.name_160(name_171.KEY_NORMAL_MAP));
         var _loc10_:name_152 = this.var_65.name_167(_loc7_.name_160(name_171.KEY_SURFACE_MAP));
         var _loc11_:name_84 = this.var_65.name_242(param2);
         var _loc12_:name_84 = this.var_65.name_242(param3);
         var _loc13_:TankMaterial2 = new TankMaterial2(_loc11_,_loc8_,_loc9_,_loc10_);
         var _loc14_:TankMaterial2 = new TankMaterial2(_loc12_,_loc8_,_loc9_,_loc10_);
         _loc13_.var_25 = param4;
         _loc13_.var_24 = param5;
         _loc14_.var_25 = param4;
         _loc14_.var_24 = param5;
         _loc6_.name_148(param1.geometry);
         if(param1 is name_161)
         {
            _loc15_ = name_161(param1);
            for each(var _loc19_ in _loc15_.name_247.concat(_loc15_.name_245))
            {
               _loc16_ = _loc19_;
               _loc19_;
               _loc6_.name_148(_loc16_.geometry);
            }
            _loc6_.name_148(_loc15_.name_261.geometry);
            _loc6_.name_148(_loc15_.name_266.geometry);
            _loc6_.name_148(_loc15_.shadow.geometry);
         }
         return new name_193(_loc13_,_loc14_);
      }
      
      private function method_87() : void
      {
         var _loc1_:name_195 = new name_195(20,20,20);
      }
      
      private function method_64() : void
      {
         this.var_70 = null;
         null;
      }
      
      private function method_73() : name_175
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Vector.<name_153> = null;
         var _loc6_:name_175 = null;
         var _loc1_:BitmapData = this.config.var_37.name_155("flame/sprite") as BitmapData;
         var _loc2_:Vector.<BitmapData> = name_163.name_188(_loc1_);
         var _loc3_:Vector.<name_139> = new Vector.<name_139>();
         for each(var _loc9_ in _loc2_)
         {
            _loc4_ = _loc9_;
            _loc9_;
         }
         _loc5_ = new Vector.<name_153>();
         _loc5_.push(new name_153(0,3));
         _loc5_.push(new name_153(0.5));
         _loc5_.push(new name_153(0.75,0.2,0.2,0.2));
         _loc5_.push(new name_153(1,0,0,0,0));
         return new name_175(_loc3_,_loc5_);
      }
      
      private function method_96() : void
      {
         this.method_68();
         this.method_74();
         this.method_66();
      }
      
      private function method_68() : void
      {
         var _loc2_:name_169 = null;
         var _loc3_:name_146 = null;
         var _loc4_:name_145 = null;
         var _loc5_:name_189 = null;
         var _loc6_:name_145 = null;
         var _loc7_:name_145 = null;
         var _loc8_:Vector.<name_86> = null;
         var _loc9_:Vector.<name_139> = null;
         var _loc10_:name_177 = null;
         var _loc1_:name_53 = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.gameKernel.method_37().name_157().collisionDetector;
            _loc3_ = name_146(_loc1_.getComponentStrict(name_146));
            _loc4_ = _loc3_.getBody().state.position;
            _loc5_ = new name_189();
            if(_loc2_.name_246(_loc4_,name_145.DOWN,name_170.STATIC,1000,null,_loc5_))
            {
               _loc6_ = _loc5_.position.clone();
               _loc6_.z = _loc6_.z + 1;
               _loc7_ = new name_145();
               _loc7_.x = -Math.acos(_loc5_.normal.z);
               if(_loc5_.normal.z < 0.999)
               {
                  _loc7_.z = Math.atan2(-_loc5_.normal.x,_loc5_.normal.y);
               }
               _loc8_ = this.var_64.getFrames("tank_explosion/shock_wave");
               _loc9_ = this.method_54(_loc8_);
               _loc10_ = name_177(this.gameKernel.method_33().name_165(name_177));
               _loc10_.init(conShockSize.value,_loc6_,_loc7_,_loc9_,30,conShockSizeGrow.value);
               this.gameKernel.name_5().method_21(_loc10_);
            }
         }
      }
      
      private function method_74() : void
      {
         var _loc2_:Vector.<name_86> = null;
         var _loc3_:Vector.<name_139> = null;
         var _loc4_:name_150 = null;
         var _loc5_:name_146 = null;
         var _loc6_:name_145 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:name_53 = this.activeTank;
         if(_loc1_ != null)
         {
            _loc2_ = this.var_64.getFrames("tank_explosion/explosion");
            _loc3_ = this.method_54(_loc2_);
            _loc4_ = name_150(this.gameKernel.method_33().name_165(name_150));
            _loc5_ = name_146(this.activeTank.getComponentStrict(name_146));
            _loc6_ = _loc5_.getBody().state.position.clone();
            _loc6_.z = _loc6_.z + 100;
            _loc7_ = Math.random() * Math.PI;
            _loc8_ = 400;
            _loc9_ = 25;
            _loc4_.init(600,600,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_,false);
            this.gameKernel.name_5().method_21(_loc4_);
         }
      }
      
      private function method_66() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Vector.<name_86> = null;
         var _loc11_:Vector.<name_139> = null;
         var _loc12_:name_146 = null;
         var _loc13_:name_145 = null;
         var _loc14_:name_145 = null;
         var _loc15_:Number = NaN;
         var _loc16_:name_145 = null;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:name_173 = null;
         var _loc21_:Number = NaN;
         var _loc1_:name_53 = this.activeTank;
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
            _loc11_ = this.method_54(_loc10_);
            _loc12_ = name_146(this.activeTank.getComponentStrict(name_146));
            _loc13_ = _loc12_.getBody().state.position.clone();
            _loc13_.z = _loc13_.z + _loc2_;
            _loc14_ = new name_145();
            _loc15_ = Math.random() * Math.PI;
            _loc16_ = new name_145();
            _loc17_ = 0;
            while(_loc17_ < 3)
            {
               _loc16_.x = Math.cos(_loc15_);
               _loc16_.y = Math.sin(_loc15_);
               _loc18_ = Math.random() * (_loc4_ - _loc3_) + _loc3_;
               _loc19_ = _loc5_ + Math.random() * (_loc6_ - _loc5_);
               _loc14_.copy(_loc16_).scale(Math.sin(_loc18_)).add(name_145.UP).normalize().scale(_loc19_);
               _loc20_ = name_173(this.gameKernel.method_33().name_165(name_173));
               _loc21_ = Math.random() * Math.PI;
               _loc20_.init(_loc9_,_loc9_,_loc11_,_loc13_,_loc14_,_loc8_,_loc21_,_loc7_,false);
               this.gameKernel.name_5().method_21(_loc20_);
               _loc15_ = _loc15_ + 2 / 3 * Math.PI;
               _loc17_++;
            }
         }
      }
      
      private function method_54(param1:Vector.<name_86>) : Vector.<name_139>
      {
         FrameMaterialsFactory.INSTANCE.renderSystem = this.gameKernel.name_5();
         return this.var_80.name_273(param1,FrameMaterialsFactory.INSTANCE) as Vector.<name_139>;
      }
      
      private function method_63(param1:name_4, param2:Array) : void
      {
         var _loc3_:name_53 = null;
         var _loc4_:name_147 = null;
         var _loc5_:name_186 = null;
         for each(var _loc8_ in this.tanks)
         {
            _loc3_ = _loc8_;
            _loc8_;
            _loc4_ = name_147(_loc3_.getComponentStrict(name_147));
            _loc5_ = _loc4_.body;
            param1.name_217("Tank " + _loc5_.id);
            param1.name_217("position " + _loc5_.state.position);
            param1.name_217("velocity " + _loc5_.state.velocity);
         }
      }
   }
}

import flash.display.BitmapData;
import flash.media.Sound;
import flash.utils.ByteArray;
import package_12.name_191;
import package_15.name_17;
import package_16.name_91;
import package_18.name_51;
import package_21.name_152;
import package_21.name_84;
import package_21.name_86;
import package_22.name_163;
import package_3.class_5;
import package_3.name_139;
import package_3.name_234;
import package_37.class_11;
import package_37.name_150;
import package_38.Matrix4;
import package_38.name_145;
import package_39.class_9;
import package_39.name_227;
import package_40.class_10;
import package_40.name_264;
import package_41.class_12;
import package_51.name_276;
import package_55.name_182;
import package_59.class_8;
import package_70.name_222;

class FrameMaterialsFactory implements class_8
{
   public static const INSTANCE:FrameMaterialsFactory = new FrameMaterialsFactory();
   
   public var renderSystem:name_51;
   
   public function FrameMaterialsFactory()
   {
      super();
   }
   
   public function createData(param1:Object) : Object
   {
      var _loc6_:class_5 = null;
      var _loc2_:Vector.<name_86> = param1 as Vector.<name_86>;
      var _loc3_:int = int(_loc2_.length);
      var _loc4_:Vector.<name_139> = new Vector.<name_139>(_loc3_);
      var _loc5_:int = 0;
      while(_loc5_ < _loc3_)
      {
         this.renderSystem.name_148(_loc2_[_loc5_]);
         _loc6_ = new class_5(_loc2_[_loc5_]);
         _loc6_.var_21 = true;
         _loc4_[_loc5_] = _loc6_;
         _loc5_++;
      }
      return _loc4_;
   }
}

class DummyTurretCallback implements class_9
{
   public function DummyTurretCallback()
   {
      super();
   }
   
   public function onTurretControlChanged(param1:int, param2:Boolean) : void
   {
   }
}

class PointHitRoundAmmo implements class_10
{
   private var impactForce:Number;
   
   private var weaponDistanceWeakening:name_182;
   
   private var weaponHitEffects:WeaponHitEffects;
   
   public function PointHitRoundAmmo(param1:name_17)
   {
      var _loc5_:int = 0;
      super();
      this.impactForce = 10000;
      this.weaponDistanceWeakening = new name_182(10000,15000,0.5);
      var _loc2_:Vector.<name_139> = new Vector.<name_139>();
      var _loc4_:int = 0;
      while(_loc4_ < 20)
      {
         _loc5_ = 255 - 255 / (20 - 1) * _loc4_;
         _loc2_.push(new name_234(name_191.name_271(_loc5_,_loc5_,_loc5_),_loc5_ / 255 + 0.5));
         _loc4_++;
      }
      this.weaponHitEffects = new WeaponHitEffects(null,_loc2_,param1);
   }
   
   public function getRound() : name_264
   {
      return new name_222(this.impactForce,this.weaponDistanceWeakening,this.weaponHitEffects);
   }
}

class WeaponHitEffects implements class_11
{
   private var sound:Sound;
   
   private var frames:Vector.<name_139>;
   
   private var gameKernel:name_17;
   
   public function WeaponHitEffects(param1:Sound, param2:Vector.<name_139>, param3:name_17)
   {
      super();
      this.sound = param1;
      this.frames = param2;
      this.gameKernel = param3;
   }
   
   public function createEffects(param1:name_145, param2:Number, param3:Number) : void
   {
      var _loc4_:name_150 = name_150(this.gameKernel.method_33().name_165(name_150));
      _loc4_.init(600,600,this.frames,param1,0,50,30,false);
      this.gameKernel.name_5().method_21(_loc4_);
   }
}

class TextureResourceCache
{
   private var textureLibrary:name_91;
   
   private var cache:Object = {};
   
   public function TextureResourceCache(param1:name_91)
   {
      super();
      this.textureLibrary = param1;
   }
   
   public function getResource(param1:String) : name_86
   {
      var _loc3_:Object = null;
      var _loc2_:name_86 = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.name_155(param1);
         if(_loc3_ is BitmapData)
         {
            _loc2_ = new name_84(_loc3_ as BitmapData);
            this.cache[param1] = _loc2_;
         }
         else if(_loc3_ is ByteArray)
         {
            _loc2_ = new name_152(_loc3_ as ByteArray);
            this.cache[param1] = _loc2_;
         }
      }
      return _loc2_;
   }
}

class MultiBitmapTextureResourceCache
{
   private var textureLibrary:name_91;
   
   private var cache:Object = {};
   
   public function MultiBitmapTextureResourceCache(param1:name_91)
   {
      super();
      this.textureLibrary = param1;
   }
   
   public function getFrames(param1:String) : Vector.<name_86>
   {
      var _loc3_:BitmapData = null;
      var _loc4_:Vector.<BitmapData> = null;
      var _loc5_:int = 0;
      var _loc2_:Vector.<name_86> = this.cache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.textureLibrary.name_155(param1) as BitmapData;
         _loc4_ = name_163.name_188(_loc3_);
         _loc2_ = new Vector.<name_86>(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_[_loc5_] = new name_84(_loc4_[_loc5_]);
            _loc5_++;
         }
         this.cache[param1] = _loc2_;
      }
      return _loc2_;
   }
}

class DummyTurret implements class_12
{
   public function DummyTurret()
   {
      super();
   }
   
   public function setTurret(param1:name_227) : void
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
   
   public function setTurretMountPoint(param1:name_145) : void
   {
   }
   
   public function getTurretPrimitives() : Vector.<name_276>
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
   
   public function getSkinMountPoint(param1:name_145) : void
   {
   }
   
   public function getGunData(param1:int, param2:name_145, param3:name_145, param4:name_145) : void
   {
   }
   
   public function getGunMuzzleData(param1:int, param2:name_145, param3:name_145) : void
   {
      param2.reset(0,0,2000);
      param3.reset(0,0,1);
   }
   
   public function getGunMuzzleData2(param1:int, param2:name_145, param3:name_145) : void
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
