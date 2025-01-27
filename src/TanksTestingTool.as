package
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage3D;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.osgi.service.console.variables.ConsoleVarString;
   import alternativa.osgi.service.console.variables.ConsoleVar;
   import alternativa.tanks.game.GameKernel;
   import alternativa.ClientConfigurator;
   import package_12.name_15;
   import alternativa.tanks.config.Config;
   import platform.client.a3d.osgi.Activator;
   import package_15.name_19;
   import alternativa.protocol.osgi.ProtocolActivator;
   import platform.clients.fp10.libraries.alternativaprotocol.Activator;
   import package_18.name_44;
   import alternativa.tanks.game.entities.map.VisibleLightMaterial;
   import alternativa.tanks.game.entities.map.MapMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TreesMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial;
   import package_4.name_11;
   import package_4.name_28;
   import package_4.name_6;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.tanks.InitBattleTask;
   import alternativa.tanks.TankTestTask;
   import alternativa.startup.LibraryInfo;
   import alternativa.startup.ConnectionParameters;
   import alternativa.tanks.game.camera.FreeCameraController;
   import alternativa.tanks.game.camera.AxisIndicator;
   
   [SWF(backgroundColor="#333333",frameRate="100",width="1024",height="768")]
   public class TanksTestingTool extends Sprite
   {
      public static var testTask:TankTestTask;
      
      private var config:Config;
      
      private var gameKernel:GameKernel;
      
      private var var_1:name_15;
      
      private var stage3D:Stage3D;
      
      private var var_2:ClientConfigurator;
      
      private var preloader:Preloader = new Preloader();
      
      public function TanksTestingTool()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.initStage();
         this.initClient();
         this.initConsole();
         this.initOptionsSupport();
         VisibleLightMaterial.fadeRadius = 7000;
         VisibleLightMaterial.spotAngle = 140 * Math.PI / 180;
         VisibleLightMaterial.fallofAngle = 170 * Math.PI / 180;
         this.stage3D = stage.stage3Ds[0];
         this.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreate);
         this.stage3D.requestContext3D();
      }
      
      private function onContextCreate(param1:Event) : void
      {
         switch(name_28.name_35(this.stage3D.context3D))
         {
            case name_6.DXT1:
               this.loadConfig("cfg.dxt1.xml");
               break;
            case name_6.ETC1:
               this.loadConfig("cfg.etc1.xml");
               break;
            case name_6.PVRTC:
               this.loadConfig("cfg.pvrtc.xml");
         }         }

      }
      
      private function initOptionsSupport() : void
      {
         new ConsoleVarInt("fog_mode",0,0,3,this.onFogSettingsChange);
         new ConsoleVarFloat("fog_near",0,0,1000000,this.onFogSettingsChange);
         new ConsoleVarFloat("fog_far",5000,0,1000000,this.onFogSettingsChange);
         new ConsoleVarFloat("fog_density",1,0,1,this.onFogSettingsChange);
         new ConsoleVarFloat("horizon_offset",0,-1000000,1000000,this.onFogSettingsChange);
         new ConsoleVarFloat("horizon_size",5000,0,1000000,this.onFogSettingsChange);
         new ConsoleVarString("fog_color","0x0",this.onFogSettingsChange);
         var _loc1_:IConsole = IConsole(OSGi.name_8().name_30(IConsole));
         _loc1_.name_45("fog_texture",this.onFogTextureChange);
         new ConsoleVarFloat("beam_distance",7000,0,1000000,this.onLightSettingsChange);
         new ConsoleVarFloat("beam_spot",140,0,180,this.onLightSettingsChange);
         new ConsoleVarFloat("beam_fallof",170,0,180,this.onLightSettingsChange);
         new ConsoleVarFloat("beam_fallof",170,0,180,this.onLightSettingsChange);
         new ConsoleVarFloat("camera_smoothing",20,0,200,this.onControllerSettingsChange);
         MapMaterial.fogMode = MapMaterial.DISABLED;
         TreesMaterial.fogMode = TreesMaterial.DISABLED;
         TankMaterial.fogMode = TankMaterial.DISABLED;
         TankMaterial2.fogMode = TankMaterial.DISABLED;
         GiShadowMaterial.fogMode = name_11.DISABLED;
         TracksMaterial2.fogMode = name_11.DISABLED;
      }
      
      private function onControllerSettingsChange(param1:ConsoleVarFloat) : void
      {
         FreeCameraController.smoothing = param1.value;
      }
      
      private function onLightSettingsChange(param1:ConsoleVar) : void
      {
         switch(param1.name_32())
         {
            case "beam_distance":
               VisibleLightMaterial.fadeRadius = ConsoleVarFloat(param1).value;
               break;
            case "beam_spot":
               VisibleLightMaterial.spotAngle = ConsoleVarFloat(param1).value * Math.PI / 180;
               break;
            case "beam_fallof":
               VisibleLightMaterial.fallofAngle = ConsoleVarFloat(param1).value * Math.PI / 180;
         }
      }
      
      private function onFogSettingsChange(param1:ConsoleVar) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:name_44 = this.gameKernel.name_5();
         switch(param1.name_32())
         {
            case "fog_mode":
               _loc6_.name_41(ConsoleVarInt(param1).value);
               break;
            case "fog_near":
               _loc6_.name_47(ConsoleVarFloat(param1).value);
               break;
            case "fog_far":
               _loc6_.name_48(ConsoleVarFloat(param1).value);
               break;
            case "fog_density":
               _loc6_.name_49(ConsoleVarFloat(param1).value);
               break;
            case "horizon_size":
               _loc6_.name_38(ConsoleVarFloat(param1).value);
               break;
            case "horizon_offset":
               _loc6_.name_34(ConsoleVarFloat(param1).value);
               break;
            case "fog_color":
               _loc6_.name_40(parseInt(ConsoleVarString(param1).value,16));
         }
      }
      
      private function onFogTextureChange(param1:IConsole, param2:Array) : void
      {
         this.gameKernel.name_5().name_36(param2.join(" "));
      }
      
      private function initStage() : void
      {
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.quality = StageQuality.LOW;
      }
      
      private function initClient() : void
      {
         new OSGi();
         this.var_2 = new ClientConfigurator();
         this.var_2.start(this,new name_19(loaderInfo.parameters),new Vector.<LibraryInfo>(),new ConnectionParameters(null,null,null),new Vector.<String>());
         new ProtocolActivator().start(OSGi.name_8());
         new platform.clients.fp10.libraries.alternativaprotocol.Activator().start(OSGi.name_8());
         new platform.client.a3d.osgi.Activator().start(OSGi.name_8());
      }
      
      private function initConsole() : void
      {
         var _loc1_:IConsole = IConsole(OSGi.name_8().name_30(IConsole));
         _loc1_.width = 100;
         _loc1_.alpha = 0.8;
         _loc1_.height = 30;
      }
      
      private function loadConfig(param1:String) : void
      {
         addChild(this.preloader);
         this.config = new Config();
         this.config.addEventListener(Event.COMPLETE,this.onConfigLoadingComplete);
         this.config.load(param1,this.preloader);
      }
      
      private function onConfigLoadingComplete(param1:Event) : void
      {
         this.initGame();
         this.initHUD();
      }
      
      private function initHUD() : void
      {
         this.var_1 = new name_15();
         stage.addChild(this.var_1);
         this.var_1.mouseChildren = true;
         this.var_1.mouseEnabled = true;
         this.var_1.addEventListener("CLICK_FULL_SCREEN_BUTTON",this.onClickFullScreenButton);
         this.var_1.addEventListener("CLICK_NEXT_TANK_BUTTON",this.onClickNextTankButton);
         stage.addChild(this.preloader);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.gameKernel.name_5().name_27().diagramVerticalMargin = 85;
         this.gameKernel.name_5().name_27().diagramHorizontalMargin = 12;
         this.onResize(null);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.keyCode == Keyboard.G)
         {
            _loc2_ = this.gameKernel.name_5().name_39();
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            else
            {
               stage.addChild(_loc2_);
            }
         }
      }
      
      private function onClickFullScreenButton(param1:Event) : void
      {
         stage.displayState = this.var_1.name_31 ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenChange);
      }
      
      private function onFullScreenChange(param1:Event) : void
      {
         stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenChange);
         this.var_1.name_31 = stage.displayState != StageDisplayState.NORMAL;
      }
      
      private function onClickNextTankButton(param1:Event) : void
      {
         if(testTask != null)
         {
            testTask.include();
         }
      }
      
      private function initGame() : void
      {
         this.gameKernel = new GameKernel(stage,this.config.options);
         this.gameKernel.name_5().name_37(this.stage3D);
         var _loc1_:InitBattleTask = new InitBattleTask(this.gameKernel,this.config,this,this.preloader);
         this.gameKernel.addTask(_loc1_);
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
         stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.gameKernel.name_51();
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc2_:AxisIndicator = null;
         if(this.gameKernel != null)
         {
            this.gameKernel.name_5().name_46(0,0,stage.stageWidth,stage.stageHeight);
            _loc2_ = this.gameKernel.name_5().name_42();
            _loc2_.y = stage.stageHeight - _loc2_.size;
         }
         if(this.var_1 != null)
         {
            this.var_1.name_50(stage.stageWidth,stage.stageHeight);
         }
      }
   }
}

