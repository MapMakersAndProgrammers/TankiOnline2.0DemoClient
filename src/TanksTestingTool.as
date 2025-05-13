package
{
   import alternativa.ClientConfigurator;
   import alternativa.engine3d.materials.A3DUtils;
   import alternativa.engine3d.materials.FogMode;
   import alternativa.engine3d.materials.TextureFormat;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.console.IConsole;
   import alternativa.osgi.service.console.variables.ConsoleVar;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.osgi.service.console.variables.ConsoleVarString;
   import alternativa.protocol.osgi.ProtocolActivator;
   import alternativa.startup.ConnectionParameters;
   import alternativa.startup.LibraryInfo;
   import alternativa.tanks.InitBattleTask;
   import alternativa.tanks.TankTestTask;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.camera.AxisIndicator;
   import alternativa.tanks.game.camera.FreeCameraController;
   import alternativa.tanks.game.entities.map.MapMaterial;
   import alternativa.tanks.game.entities.map.VisibleLightMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.GiShadowMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial;
   import alternativa.tanks.game.entities.tank.graphics.materials.TankMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TracksMaterial2;
   import alternativa.tanks.game.entities.tank.graphics.materials.TreesMaterial;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import alternativa.utils.Properties;
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
   import platform.client.formats.a3d.osgi.Activator;
   import platform.clients.fp10.libraries.alternativaprotocol.Activator;
   import tankshudDemo.TanksHudDemo;
   
   [SWF(backgroundColor="#333333",frameRate="100",width="1024",height="768")]
   public class TanksTestingTool extends Sprite
   {
      public static var testTask:TankTestTask;
      
      private var config:Config;
      
      private var gameKernel:GameKernel;
      
      private var name_6s:TanksHudDemo;
      
      private var stage3D:Stage3D;
      
      private var name_nZ:ClientConfigurator;
      
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
         switch(A3DUtils.getSupportedTextureFormat(this.stage3D.context3D))
         {
            case TextureFormat.DXT1:
               this.loadConfig("cfg.dxt1.xml");
               break;
            case TextureFormat.ETC1:
               this.loadConfig("cfg.etc1.xml");
               break;
            case TextureFormat.PVRTC:
               this.loadConfig("cfg.pvrtc.xml");
         }
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
         var _loc1_:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
         _loc1_.setCommandHandler("fog_texture",this.onFogTextureChange);
         new ConsoleVarFloat("beam_distance",7000,0,1000000,this.onLightSettingsChange);
         new ConsoleVarFloat("beam_spot",140,0,180,this.onLightSettingsChange);
         new ConsoleVarFloat("beam_fallof",170,0,180,this.onLightSettingsChange);
         new ConsoleVarFloat("beam_fallof",170,0,180,this.onLightSettingsChange);
         new ConsoleVarFloat("camera_smoothing",20,0,200,this.onControllerSettingsChange);
         MapMaterial.fogMode = MapMaterial.DISABLED;
         TreesMaterial.fogMode = TreesMaterial.DISABLED;
         TankMaterial.fogMode = TankMaterial.DISABLED;
         TankMaterial2.fogMode = TankMaterial.DISABLED;
         GiShadowMaterial.fogMode = FogMode.DISABLED;
         TracksMaterial2.fogMode = FogMode.DISABLED;
      }
      
      private function onControllerSettingsChange(param1:ConsoleVarFloat) : void
      {
         FreeCameraController.smoothing = param1.value;
      }
      
      private function onLightSettingsChange(param1:ConsoleVar) : void
      {
         switch(param1.getName())
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
         var _loc6_:RenderSystem = this.gameKernel.getRenderSystem();
         switch(param1.getName())
         {
            case "fog_mode":
               _loc6_.setFogMode(ConsoleVarInt(param1).value);
               break;
            case "fog_near":
               _loc6_.setFogNear(ConsoleVarFloat(param1).value);
               break;
            case "fog_far":
               _loc6_.setFogFar(ConsoleVarFloat(param1).value);
               break;
            case "fog_density":
               _loc6_.setMaxFogDensity(ConsoleVarFloat(param1).value);
               break;
            case "horizon_size":
               _loc6_.setFogHorizonSize(ConsoleVarFloat(param1).value);
               break;
            case "horizon_offset":
               _loc6_.setFogHorizonOffset(ConsoleVarFloat(param1).value);
               break;
            case "fog_color":
               _loc6_.setFogColor(parseInt(ConsoleVarString(param1).value,16));
         }
      }
      
      private function onFogTextureChange(param1:IConsole, param2:Array) : void
      {
         this.gameKernel.getRenderSystem().setFogTextureParams(param2.join(" "));
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
         this.name_nZ = new ClientConfigurator();
         this.name_nZ.start(this,new Properties(loaderInfo.parameters),new Vector.<LibraryInfo>(),new ConnectionParameters(null,null,null),new Vector.<String>());
         new ProtocolActivator().start(OSGi.getInstance());
         new platform.clients.fp10.libraries.alternativaprotocol.Activator().start(OSGi.getInstance());
         new platform.client.formats.a3d.osgi.Activator().start(OSGi.getInstance());
      }
      
      private function initConsole() : void
      {
         var _loc1_:IConsole = IConsole(OSGi.getInstance().getService(IConsole));
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
         this.name_6s = new TanksHudDemo();
         stage.addChild(this.name_6s);
         this.name_6s.mouseChildren = true;
         this.name_6s.mouseEnabled = true;
         this.name_6s.addEventListener("CLICK_FULL_SCREEN_BUTTON",this.onClickFullScreenButton);
         this.name_6s.addEventListener("CLICK_NEXT_TANK_BUTTON",this.onClickNextTankButton);
         stage.addChild(this.preloader);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.gameKernel.getRenderSystem().getCamera().diagramVerticalMargin = 85;
         this.gameKernel.getRenderSystem().getCamera().diagramHorizontalMargin = 12;
         this.onResize(null);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.keyCode == Keyboard.G)
         {
            _loc2_ = this.gameKernel.getRenderSystem().getCameraDiagram();
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
         stage.displayState = this.name_6s.isFullScreen ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenChange);
      }
      
      private function onFullScreenChange(param1:Event) : void
      {
         stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenChange);
         this.name_6s.isFullScreen = stage.displayState != StageDisplayState.NORMAL;
      }
      
      private function onClickNextTankButton(param1:Event) : void
      {
         if(testTask != null)
         {
            testTask.selectNextTank();
         }
      }
      
      private function initGame() : void
      {
         this.gameKernel = new GameKernel(stage,this.config.options);
         this.gameKernel.getRenderSystem().setStage3D(this.stage3D);
         var _loc1_:InitBattleTask = new InitBattleTask(this.gameKernel,this.config,this,this.preloader);
         this.gameKernel.addTask(_loc1_);
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
         stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.gameKernel.tick();
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc2_:AxisIndicator = null;
         if(this.gameKernel != null)
         {
            this.gameKernel.getRenderSystem().setViewRect(0,0,stage.stageWidth,stage.stageHeight);
            _loc2_ = this.gameKernel.getRenderSystem().getAxisIndicator();
            _loc2_.y = stage.stageHeight - _loc2_.size;
         }
         if(this.name_6s != null)
         {
            this.name_6s.resize(stage.stageWidth,stage.stageHeight);
         }
      }
   }
}

