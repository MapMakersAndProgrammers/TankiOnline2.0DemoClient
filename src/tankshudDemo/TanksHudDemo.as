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
      
      private var name_d0:Bitmap;
      
      private var name_7U:Bitmap;
      
      private var name_4m:Bitmap;
      
      private var fullScreenButtonState1:Bitmap;
      
      private var fullScreenButtonState2:Bitmap;
      
      private var nextTankButtonState1:Bitmap;
      
      private var nextTankButtonState2:Bitmap;
      
      private var name_at:Sprite;
      
      private var name_I5:Sprite;
      
      private var name_kn:Boolean;
      
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
         this.name_d0 = new topLeftIconClass();
         addChild(this.name_d0);
         this.name_7U = new topRightIconClass();
         addChild(this.name_7U);
         this.name_4m = new bottomLeftIconClass();
         addChild(this.name_4m);
         this.name_at = new Sprite();
         this.name_at.mouseChildren = false;
         addChild(this.name_at);
         this.fullScreenButtonState1 = new fullScreenState1Class();
         this.name_at.addChild(this.fullScreenButtonState1);
         this.fullScreenButtonState2 = new fullScreenState2Class();
         this.name_at.addChild(this.fullScreenButtonState2);
         this.name_at.addEventListener(MouseEvent.ROLL_OVER,this.onOverFullScreenBtn);
         this.name_at.addEventListener(MouseEvent.ROLL_OUT,this.onOutFullScreenBtn);
         this.name_at.addEventListener(MouseEvent.CLICK,this.onClickFullScreenBtn);
         this.isFullScreen = false;
         this.name_I5 = new Sprite();
         this.name_I5.mouseChildren = false;
         addChild(this.name_I5);
         this.nextTankButtonState1 = new nextTankState1Class();
         this.name_I5.addChild(this.nextTankButtonState1);
         this.nextTankButtonState2 = new nextTankState2Class();
         this.name_I5.addChild(this.nextTankButtonState2);
         this.nextTankButtonState2.visible = false;
         this.name_I5.addEventListener(MouseEvent.ROLL_OVER,this.onOverNextTankBtn);
         this.name_I5.addEventListener(MouseEvent.ROLL_OUT,this.onOutNextTankBtn);
         this.name_I5.addEventListener(MouseEvent.CLICK,this.onClickNextTankBtn);
      }
      
      public function destroy() : void
      {
         if(this.name_d0 != null)
         {
            removeChild(this.name_d0);
         }
         if(this.name_7U != null)
         {
            removeChild(this.name_7U);
         }
         if(this.name_4m != null)
         {
            removeChild(this.name_4m);
         }
         if(this.name_at != null)
         {
            this.name_at.removeEventListener(MouseEvent.ROLL_OVER,this.onOverFullScreenBtn);
            this.name_at.removeEventListener(MouseEvent.ROLL_OUT,this.onOutFullScreenBtn);
            this.name_at.removeEventListener(MouseEvent.CLICK,this.onClickFullScreenBtn);
            removeChild(this.name_at);
         }
         if(this.name_I5 != null)
         {
            this.name_I5.removeEventListener(MouseEvent.ROLL_OVER,this.onOverNextTankBtn);
            this.name_I5.removeEventListener(MouseEvent.ROLL_OUT,this.onOutNextTankBtn);
            this.name_I5.removeEventListener(MouseEvent.CLICK,this.onClickNextTankBtn);
            removeChild(this.name_I5);
         }
         this.name_d0 = null;
         this.name_7U = null;
         this.name_4m = null;
         this.name_at = null;
         this.name_I5 = null;
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         if(this.name_7U != null)
         {
            this.name_7U.x = param1 - this.name_7U.width;
         }
         if(this.name_4m != null)
         {
            this.name_4m.y = param2 - this.name_4m.height;
         }
         if(this.name_at != null)
         {
            this.name_at.x = param1 - this.name_at.width - GAP_RIGHT;
            this.name_at.y = param2 - this.name_at.height - GAP_BOTTOM;
         }
         if(this.name_I5 != null)
         {
            this.name_I5.x = param1 - this.name_at.width - this.name_I5.width - GAP_BEEWEN_BUTTON - GAP_RIGHT;
            this.name_I5.y = param2 - this.name_I5.height - GAP_BOTTOM;
         }
      }
      
      public function get isFullScreen() : Boolean
      {
         return this.name_kn;
      }
      
      public function set isFullScreen(param1:Boolean) : void
      {
         this.name_kn = param1;
         if(this.name_kn == false)
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
         if(this.name_kn == false)
         {
            this.fullScreenButtonState2.visible = true;
         }
      }
      
      private function onOutFullScreenBtn(param1:MouseEvent) : void
      {
         if(this.name_kn == false)
         {
            this.fullScreenButtonState2.visible = false;
         }
      }
      
      private function onClickFullScreenBtn(param1:MouseEvent) : void
      {
         this.isFullScreen = !this.name_kn;
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

