package tankshudDemo
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TanksHudDemo extends Sprite
   {
      private static const topLeftIconClass:Class = TanksHudDemo_topLeftIconClass;
      
      private static const topRightIconClass:Class = TanksHudDemo_topRightIconClass;
      
      private static const bottomLeftIconClass:Class = TanksHudDemo_bottomLeftIconClass;
      
      private static const fullScreenState1Class:Class = TanksHudDemo_fullScreenState1Class;
      
      private static const fullScreenState2Class:Class = TanksHudDemo_fullScreenState2Class;
      
      private static const nextTankState1Class:Class = TanksHudDemo_nextTankState1Class;
      
      private static const nextTankState2Class:Class = TanksHudDemo_nextTankState2Class;
      
      private static const GAP_RIGHT:int = 7;
      
      private static const GAP_BOTTOM:int = 7;
      
      private static const GAP_BEEWEN_BUTTON:int = 1;
      
      private var §_-d0§:Bitmap;
      
      private var §_-7U§:Bitmap;
      
      private var §_-4m§:Bitmap;
      
      private var fullScreenButtonState1:Bitmap;
      
      private var fullScreenButtonState2:Bitmap;
      
      private var nextTankButtonState1:Bitmap;
      
      private var nextTankButtonState2:Bitmap;
      
      private var §_-at§:Sprite;
      
      private var §_-I5§:Sprite;
      
      private var §_-kn§:Boolean;
      
      public function TanksHudDemo()
      {
         super();
         this.init();
      }
      
      private function init(param1:Event = null) : void
      {
         tabEnabled = false;
         tabChildren = false;
         mouseEnabled = false;
         this.§_-d0§ = new topLeftIconClass();
         addChild(this.§_-d0§);
         this.§_-7U§ = new topRightIconClass();
         addChild(this.§_-7U§);
         this.§_-4m§ = new bottomLeftIconClass();
         addChild(this.§_-4m§);
         this.§_-at§ = new Sprite();
         this.§_-at§.mouseChildren = false;
         addChild(this.§_-at§);
         this.fullScreenButtonState1 = new fullScreenState1Class();
         this.§_-at§.addChild(this.fullScreenButtonState1);
         this.fullScreenButtonState2 = new fullScreenState2Class();
         this.§_-at§.addChild(this.fullScreenButtonState2);
         this.§_-at§.addEventListener(MouseEvent.ROLL_OVER,this.onOverFullScreenBtn);
         this.§_-at§.addEventListener(MouseEvent.ROLL_OUT,this.onOutFullScreenBtn);
         this.§_-at§.addEventListener(MouseEvent.CLICK,this.onClickFullScreenBtn);
         this.isFullScreen = false;
         this.§_-I5§ = new Sprite();
         this.§_-I5§.mouseChildren = false;
         addChild(this.§_-I5§);
         this.nextTankButtonState1 = new nextTankState1Class();
         this.§_-I5§.addChild(this.nextTankButtonState1);
         this.nextTankButtonState2 = new nextTankState2Class();
         this.§_-I5§.addChild(this.nextTankButtonState2);
         this.nextTankButtonState2.visible = false;
         this.§_-I5§.addEventListener(MouseEvent.ROLL_OVER,this.onOverNextTankBtn);
         this.§_-I5§.addEventListener(MouseEvent.ROLL_OUT,this.onOutNextTankBtn);
         this.§_-I5§.addEventListener(MouseEvent.CLICK,this.onClickNextTankBtn);
      }
      
      public function destroy() : void
      {
         if(this.§_-d0§ != null)
         {
            removeChild(this.§_-d0§);
         }
         if(this.§_-7U§ != null)
         {
            removeChild(this.§_-7U§);
         }
         if(this.§_-4m§ != null)
         {
            removeChild(this.§_-4m§);
         }
         if(this.§_-at§ != null)
         {
            this.§_-at§.removeEventListener(MouseEvent.ROLL_OVER,this.onOverFullScreenBtn);
            this.§_-at§.removeEventListener(MouseEvent.ROLL_OUT,this.onOutFullScreenBtn);
            this.§_-at§.removeEventListener(MouseEvent.CLICK,this.onClickFullScreenBtn);
            removeChild(this.§_-at§);
         }
         if(this.§_-I5§ != null)
         {
            this.§_-I5§.removeEventListener(MouseEvent.ROLL_OVER,this.onOverNextTankBtn);
            this.§_-I5§.removeEventListener(MouseEvent.ROLL_OUT,this.onOutNextTankBtn);
            this.§_-I5§.removeEventListener(MouseEvent.CLICK,this.onClickNextTankBtn);
            removeChild(this.§_-I5§);
         }
         this.§_-d0§ = null;
         this.§_-7U§ = null;
         this.§_-4m§ = null;
         this.§_-at§ = null;
         this.§_-I5§ = null;
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         if(this.§_-7U§ != null)
         {
            this.§_-7U§.x = param1 - this.§_-7U§.width;
         }
         if(this.§_-4m§ != null)
         {
            this.§_-4m§.y = param2 - this.§_-4m§.height;
         }
         if(this.§_-at§ != null)
         {
            this.§_-at§.x = param1 - this.§_-at§.width - GAP_RIGHT;
            this.§_-at§.y = param2 - this.§_-at§.height - GAP_BOTTOM;
         }
         if(this.§_-I5§ != null)
         {
            this.§_-I5§.x = param1 - this.§_-at§.width - this.§_-I5§.width - GAP_BEEWEN_BUTTON - GAP_RIGHT;
            this.§_-I5§.y = param2 - this.§_-I5§.height - GAP_BOTTOM;
         }
      }
      
      public function get isFullScreen() : Boolean
      {
         return this.§_-kn§;
      }
      
      public function set isFullScreen(param1:Boolean) : void
      {
         this.§_-kn§ = param1;
         if(this.§_-kn§ == false)
         {
            this.fullScreenButtonState2.visible = false;
         }
         else
         {
            this.fullScreenButtonState2.visible = true;
         }
      }
      
      private function onOverFullScreenBtn(param1:MouseEvent) : void
      {
         if(this.§_-kn§ == false)
         {
            this.fullScreenButtonState2.visible = true;
         }
      }
      
      private function onOutFullScreenBtn(param1:MouseEvent) : void
      {
         if(this.§_-kn§ == false)
         {
            this.fullScreenButtonState2.visible = false;
         }
      }
      
      private function onClickFullScreenBtn(param1:MouseEvent) : void
      {
         this.isFullScreen = !this.§_-kn§;
         dispatchEvent(new Event("CLICK_FULL_SCREEN_BUTTON"));
      }
      
      private function onOverNextTankBtn(param1:MouseEvent) : void
      {
         this.nextTankButtonState2.visible = true;
      }
      
      private function onOutNextTankBtn(param1:MouseEvent) : void
      {
         this.nextTankButtonState2.visible = false;
      }
      
      private function onClickNextTankBtn(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("CLICK_NEXT_TANK_BUTTON"));
      }
   }
}

