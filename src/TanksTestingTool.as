package
{
   import §_-1c§.§_-0F§;
   import §_-5U§.§_-Kr§;
   import §_-FM§.§_-fl§;
   import §_-GD§.§_-6A§;
   import §_-I0§.§_-Jv§;
   import §_-I0§.§_-VT§;
   import §_-KT§.§_-6L§;
   import §_-KT§.§_-Ju§;
   import §_-KT§.§_-UT§;
   import §_-KT§.§_-mN§;
   import §_-O5§.§_-c-§;
   import §_-RG§.§_-Au§;
   import §_-RG§.§_-pE§;
   import §_-TX§.§_-R3§;
   import §_-Uy§.§_-oP§;
   import §_-Vh§.§_-Pt§;
   import §_-Vh§.§_-Wn§;
   import §_-Vh§.§_-dn§;
   import §_-YQ§.§_-A3§;
   import §_-YQ§.§_-DN§;
   import §_-Yj§.TankMaterial2;
   import §_-Yj§.§_-4X§;
   import §_-Yj§.§_-as§;
   import §_-Yj§.§_-bZ§;
   import §_-Yj§.§_-jj§;
   import §_-aA§.§_-1O§;
   import §_-aA§.§_-a-§;
   import §_-az§.§_-AG§;
   import §_-cv§.§_-YU§;
   import §_-d8§.§_-R3§;
   import §_-e6§.§_-1I§;
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
   
   [SWF(backgroundColor="#333333",frameRate="100",width="1024",height="768")]
   public class TanksTestingTool extends Sprite
   {
      public static var testTask:§_-A3§;
      
      private var config:§_-YU§;
      
      private var gameKernel:§_-AG§;
      
      private var §_-6s§:§_-0F§;
      
      private var stage3D:Stage3D;
      
      private var §_-nZ§:§_-Kr§;
      
      private var preloader:Preloader = new Preloader();
      
      public function TanksTestingTool()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.§_-PK§();
         this.§_-l2§();
         this.§_-33§();
         this.§_-5D§();
         §_-Au§.fadeRadius = 7000;
         §_-Au§.spotAngle = 140 * Math.PI / 180;
         §_-Au§.fallofAngle = 170 * Math.PI / 180;
         this.stage3D = stage.stage3Ds[0];
         this.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.§_-9x§);
         this.stage3D.requestContext3D();
      }
      
      private function §_-9x§(param1:Event) : void
      {
         switch(§_-Pt§.§_-OP§(this.stage3D.context3D))
         {
            case §_-Wn§.DXT1:
               this.§_-Bw§("cfg.dxt1.xml");
               break;
            case §_-Wn§.ETC1:
               this.§_-Bw§("cfg.etc1.xml");
               break;
            case §_-Wn§.PVRTC:
               this.§_-Bw§("cfg.pvrtc.xml");
         }
      }
      
      private function §_-5D§() : void
      {
         new §_-UT§("fog_mode",0,0,3,this.§_-JG§);
         new §_-Ju§("fog_near",0,0,1000000,this.§_-JG§);
         new §_-Ju§("fog_far",5000,0,1000000,this.§_-JG§);
         new §_-Ju§("fog_density",1,0,1,this.§_-JG§);
         new §_-Ju§("horizon_offset",0,-1000000,1000000,this.§_-JG§);
         new §_-Ju§("horizon_size",5000,0,1000000,this.§_-JG§);
         new §_-mN§("fog_color","0x0",this.§_-JG§);
         var _loc1_:§_-6A§ = §_-6A§(§_-oP§.§_-nQ§().§_-N6§(§_-6A§));
         _loc1_.§_-0j§("fog_texture",this.§_-nx§);
         new §_-Ju§("beam_distance",7000,0,1000000,this.§_-1B§);
         new §_-Ju§("beam_spot",140,0,180,this.§_-1B§);
         new §_-Ju§("beam_fallof",170,0,180,this.§_-1B§);
         new §_-Ju§("beam_fallof",170,0,180,this.§_-1B§);
         new §_-Ju§("camera_smoothing",20,0,200,this.§_-27§);
         §_-pE§.fogMode = §_-pE§.DISABLED;
         §_-4X§.fogMode = §_-4X§.DISABLED;
         §_-as§.fogMode = §_-as§.DISABLED;
         TankMaterial2.fogMode = §_-as§.DISABLED;
         §_-jj§.fogMode = §_-dn§.DISABLED;
         §_-bZ§.fogMode = §_-dn§.DISABLED;
      }
      
      private function §_-27§(param1:§_-Ju§) : void
      {
         §_-Jv§.smoothing = param1.value;
      }
      
      private function §_-1B§(param1:§_-6L§) : void
      {
         switch(param1.§_-cC§())
         {
            case "beam_distance":
               §_-Au§.fadeRadius = §_-Ju§(param1).value;
               break;
            case "beam_spot":
               §_-Au§.spotAngle = §_-Ju§(param1).value * Math.PI / 180;
               break;
            case "beam_fallof":
               §_-Au§.fallofAngle = §_-Ju§(param1).value * Math.PI / 180;
         }
      }
      
      private function §_-JG§(param1:§_-6L§) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:§_-1I§ = this.gameKernel.§_-DZ§();
         switch(param1.§_-cC§())
         {
            case "fog_mode":
               _loc6_.§_-ev§(§_-UT§(param1).value);
               break;
            case "fog_near":
               _loc6_.§_-9g§(§_-Ju§(param1).value);
               break;
            case "fog_far":
               _loc6_.§_-H9§(§_-Ju§(param1).value);
               break;
            case "fog_density":
               _loc6_.§_-J0§(§_-Ju§(param1).value);
               break;
            case "horizon_size":
               _loc6_.§_-Jk§(§_-Ju§(param1).value);
               break;
            case "horizon_offset":
               _loc6_.§_-Dd§(§_-Ju§(param1).value);
               break;
            case "fog_color":
               _loc6_.§_-5d§(parseInt(§_-mN§(param1).value,16));
         }
      }
      
      private function §_-nx§(param1:§_-6A§, param2:Array) : void
      {
         this.gameKernel.§_-DZ§().§_-FZ§(param2.join(" "));
      }
      
      private function §_-PK§() : void
      {
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.quality = StageQuality.LOW;
      }
      
      private function §_-l2§() : void
      {
         new §_-oP§();
         this.§_-nZ§ = new §_-Kr§();
         this.§_-nZ§.start(this,new §_-c-§(loaderInfo.parameters),new Vector.<§_-a-§>(),new §_-1O§(null,null,null),new Vector.<String>());
         new §_-fl§().start(§_-oP§.§_-nQ§());
         new §_-TX§.§_-R3§().start(§_-oP§.§_-nQ§());
         new §_-d8§.§_-R3§().start(§_-oP§.§_-nQ§());
      }
      
      private function §_-33§() : void
      {
         var _loc1_:§_-6A§ = §_-6A§(§_-oP§.§_-nQ§().§_-N6§(§_-6A§));
         _loc1_.width = 100;
         _loc1_.alpha = 0.8;
         _loc1_.height = 30;
      }
      
      private function §_-Bw§(param1:String) : void
      {
         addChild(this.preloader);
         this.config = new §_-YU§();
         this.config.addEventListener(Event.COMPLETE,this.§_-JY§);
         this.config.load(param1,this.preloader);
      }
      
      private function §_-JY§(param1:Event) : void
      {
         this.§_-G-§();
         this.§_-lN§();
      }
      
      private function §_-lN§() : void
      {
         this.§_-6s§ = new §_-0F§();
         stage.addChild(this.§_-6s§);
         this.§_-6s§.mouseChildren = true;
         this.§_-6s§.mouseEnabled = true;
         this.§_-6s§.addEventListener("CLICK_FULL_SCREEN_BUTTON",this.§_-GO§);
         this.§_-6s§.addEventListener("CLICK_NEXT_TANK_BUTTON",this.§_-gC§);
         stage.addChild(this.preloader);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.§_-Ze§);
         this.gameKernel.§_-DZ§().§_-GW§().diagramVerticalMargin = 85;
         this.gameKernel.§_-DZ§().§_-GW§().diagramHorizontalMargin = 12;
         this.§_-7B§(null);
      }
      
      private function §_-Ze§(param1:KeyboardEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.keyCode == Keyboard.G)
         {
            _loc2_ = this.gameKernel.§_-DZ§().§_-G§();
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
      
      private function §_-GO§(param1:Event) : void
      {
         stage.displayState = !!this.§_-6s§.§_-8F§ ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.§_-Tp§);
      }
      
      private function §_-Tp§(param1:Event) : void
      {
         stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.§_-Tp§);
         this.§_-6s§.§_-8F§ = stage.displayState != StageDisplayState.NORMAL;
      }
      
      private function §_-gC§(param1:Event) : void
      {
         if(testTask != null)
         {
            testTask.include();
         }
      }
      
      private function §_-G-§() : void
      {
         this.gameKernel = new §_-AG§(stage,this.config.options);
         this.gameKernel.§_-DZ§().§_-X4§(this.stage3D);
         var _loc1_:§_-DN§ = new §_-DN§(this.gameKernel,this.config,this,this.preloader);
         this.gameKernel.addTask(_loc1_);
         stage.addEventListener(Event.RESIZE,this.§_-7B§);
         this.§_-7B§(null);
         stage.addEventListener(Event.ENTER_FRAME,this.§_-ba§);
      }
      
      private function §_-ba§(param1:Event) : void
      {
         this.gameKernel.§_-Kf§();
      }
      
      private function §_-7B§(param1:Event) : void
      {
         var _loc2_:§_-VT§ = null;
         if(this.gameKernel != null)
         {
            this.gameKernel.§_-DZ§().§_-3N§(0,0,stage.stageWidth,stage.stageHeight);
            _loc2_ = this.gameKernel.§_-DZ§().§_-MG§();
            _loc2_.y = stage.stageHeight - _loc2_.size;
         }
         if(this.§_-6s§ != null)
         {
            this.§_-6s§.§_-K6§(stage.stageWidth,stage.stageHeight);
         }
      }
   }
}

