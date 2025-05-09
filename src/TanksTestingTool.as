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
   import package_1.TankMaterial2;
   import package_1.name_13;
   import package_1.name_30;
   import package_1.name_31;
   import package_1.name_7;
   import package_10.name_23;
   import package_11.name_4;
   import package_12.name_27;
   import package_13.name_28;
   import package_14.name_3;
   import package_15.name_17;
   import package_16.name_18;
   import package_17.name_28;
   import package_18.name_51;
   import package_2.name_1;
   import package_2.name_10;
   import package_2.name_26;
   import package_2.name_9;
   import package_3.name_12;
   import package_3.name_29;
   import package_3.name_6;
   import package_4.name_24;
   import package_4.name_25;
   import package_5.name_11;
   import package_5.name_2;
   import package_6.name_16;
   import package_6.name_50;
   import package_7.name_32;
   import package_7.name_33;
   import package_8.name_14;
   import package_9.name_15;
   
   [SWF(backgroundColor="#333333",frameRate="100",width="1024",height="768")]
   public class TanksTestingTool extends Sprite
   {
      public static var testTask:name_50;
      
      private var config:name_18;
      
      private var gameKernel:name_17;
      
      private var var_1:name_14;
      
      private var stage3D:Stage3D;
      
      private var var_2:name_15;
      
      private var preloader:Preloader = new Preloader();
      
      public function TanksTestingTool()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.method_13();
         this.method_17();
         this.method_7();
         this.method_8();
         name_2.fadeRadius = 7000;
         name_2.spotAngle = 140 * Math.PI / 180;
         name_2.fallofAngle = 170 * Math.PI / 180;
         this.stage3D = stage.stage3Ds[0];
         this.stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.method_9);
         this.stage3D.requestContext3D();
      }
      
      private function method_9(param1:Event) : void
      {
         switch(name_29.name_47(this.stage3D.context3D))
         {
            case name_6.DXT1:
               this.method_4("cfg.dxt1.xml");
               break;
            case name_6.ETC1:
               this.method_4("cfg.etc1.xml");
               break;
            case name_6.PVRTC:
               this.method_4("cfg.pvrtc.xml");
         }
      }
      
      private function method_8() : void
      {
         new name_9("fog_mode",0,0,3,this.method_1);
         new name_1("fog_near",0,0,1000000,this.method_1);
         new name_1("fog_far",5000,0,1000000,this.method_1);
         new name_1("fog_density",1,0,1,this.method_1);
         new name_1("horizon_offset",0,-1000000,1000000,this.method_1);
         new name_1("horizon_size",5000,0,1000000,this.method_1);
         new name_10("fog_color","0x0",this.method_1);
         var _loc1_:name_4 = name_4(name_3.name_8().name_21(name_4));
         _loc1_.name_34("fog_texture",this.method_19);
         new name_1("beam_distance",7000,0,1000000,this.method_2);
         new name_1("beam_spot",140,0,180,this.method_2);
         new name_1("beam_fallof",170,0,180,this.method_2);
         new name_1("beam_fallof",170,0,180,this.method_2);
         new name_1("camera_smoothing",20,0,200,this.method_6);
         name_11.fogMode = name_11.DISABLED;
         name_13.fogMode = name_13.DISABLED;
         name_7.fogMode = name_7.DISABLED;
         TankMaterial2.fogMode = name_7.DISABLED;
         name_31.fogMode = name_12.DISABLED;
         name_30.fogMode = name_12.DISABLED;
      }
      
      private function method_6(param1:name_1) : void
      {
         name_24.smoothing = param1.value;
      }
      
      private function method_2(param1:name_26) : void
      {
         switch(param1.name_22())
         {
            case "beam_distance":
               name_2.fadeRadius = name_1(param1).value;
               break;
            case "beam_spot":
               name_2.spotAngle = name_1(param1).value * Math.PI / 180;
               break;
            case "beam_fallof":
               name_2.fallofAngle = name_1(param1).value * Math.PI / 180;
         }
      }
      
      private function method_1(param1:name_26) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:name_51 = this.gameKernel.name_5();
         switch(param1.name_22())
         {
            case "fog_mode":
               _loc6_.name_49(name_9(param1).value);
               break;
            case "fog_near":
               _loc6_.name_37(name_1(param1).value);
               break;
            case "fog_far":
               _loc6_.name_41(name_1(param1).value);
               break;
            case "fog_density":
               _loc6_.name_42(name_1(param1).value);
               break;
            case "horizon_size":
               _loc6_.name_43(name_1(param1).value);
               break;
            case "horizon_offset":
               _loc6_.name_38(name_1(param1).value);
               break;
            case "fog_color":
               _loc6_.name_36(parseInt(name_10(param1).value,16));
         }
      }
      
      private function method_19(param1:name_4, param2:Array) : void
      {
         this.gameKernel.name_5().name_39(param2.join(" "));
      }
      
      private function method_13() : void
      {
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.quality = StageQuality.LOW;
      }
      
      private function method_17() : void
      {
         new name_3();
         this.var_2 = new name_15();
         this.var_2.start(this,new name_27(loaderInfo.parameters),new Vector.<name_33>(),new name_32(null,null,null),new Vector.<String>());
         new name_23().start(name_3.name_8());
         new package_13.name_28().start(name_3.name_8());
         new package_17.name_28().start(name_3.name_8());
      }
      
      private function method_7() : void
      {
         var _loc1_:name_4 = name_4(name_3.name_8().name_21(name_4));
         _loc1_.width = 100;
         _loc1_.alpha = 0.8;
         _loc1_.height = 30;
      }
      
      private function method_4(param1:String) : void
      {
         addChild(this.preloader);
         this.config = new name_18();
         this.config.addEventListener(Event.COMPLETE,this.method_12);
         this.config.load(param1,this.preloader);
      }
      
      private function method_12(param1:Event) : void
      {
         this.method_10();
         this.method_18();
      }
      
      private function method_18() : void
      {
         this.var_1 = new name_14();
         stage.addChild(this.var_1);
         this.var_1.mouseChildren = true;
         this.var_1.mouseEnabled = true;
         this.var_1.addEventListener("CLICK_FULL_SCREEN_BUTTON",this.method_11);
         this.var_1.addEventListener("CLICK_NEXT_TANK_BUTTON",this.method_16);
         stage.addChild(this.preloader);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.method_14);
         this.gameKernel.name_5().name_20().diagramVerticalMargin = 85;
         this.gameKernel.name_5().name_20().diagramHorizontalMargin = 12;
         this.method_3(null);
      }
      
      private function method_14(param1:KeyboardEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.keyCode == Keyboard.G)
         {
            _loc2_ = this.gameKernel.name_5().name_40();
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
      
      private function method_11(param1:Event) : void
      {
         stage.displayState = !!this.var_1.name_19 ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.method_5);
      }
      
      private function method_5(param1:Event) : void
      {
         stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.method_5);
         this.var_1.name_19 = stage.displayState != StageDisplayState.NORMAL;
      }
      
      private function method_16(param1:Event) : void
      {
         if(testTask != null)
         {
            testTask.include();
         }
      }
      
      private function method_10() : void
      {
         this.gameKernel = new name_17(stage,this.config.options);
         this.gameKernel.name_5().name_48(this.stage3D);
         var _loc1_:name_16 = new name_16(this.gameKernel,this.config,this,this.preloader);
         this.gameKernel.addTask(_loc1_);
         stage.addEventListener(Event.RESIZE,this.method_3);
         this.method_3(null);
         stage.addEventListener(Event.ENTER_FRAME,this.method_15);
      }
      
      private function method_15(param1:Event) : void
      {
         this.gameKernel.name_45();
      }
      
      private function method_3(param1:Event) : void
      {
         var _loc2_:name_25 = null;
         if(this.gameKernel != null)
         {
            this.gameKernel.name_5().name_35(0,0,stage.stageWidth,stage.stageHeight);
            _loc2_ = this.gameKernel.name_5().name_46();
            _loc2_.y = stage.stageHeight - _loc2_.size;
         }
         if(this.var_1 != null)
         {
            this.var_1.name_44(stage.stageWidth,stage.stageHeight);
         }
      }
   }
}

