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
      
      private var var_60:Bitmap;
      
      private var var_58:Bitmap;
      
      private var var_57:Bitmap;
      
      private var fullScreenButtonState1:Bitmap;
      
      private var fullScreenButtonState2:Bitmap;
      
      private var nextTankButtonState1:Bitmap;
      
      private var nextTankButtonState2:Bitmap;
      
      private var var_55:Sprite;
      
      private var var_56:Sprite;
      
      private var var_59:Boolean;
      
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
         this.var_60 = new topLeftIconClass();
         addChild(this.var_60);
         this.var_58 = new topRightIconClass();
         addChild(this.var_58);
         this.var_57 = new bottomLeftIconClass();
         addChild(this.var_57);
         this.var_55 = new Sprite();
         this.var_55.mouseChildren = false;
         addChild(this.var_55);
         this.fullScreenButtonState1 = new fullScreenState1Class();
         this.var_55.addChild(this.fullScreenButtonState1);
         this.fullScreenButtonState2 = new fullScreenState2Class();
         this.var_55.addChild(this.fullScreenButtonState2);
         this.var_55.addEventListener(MouseEvent.ROLL_OVER,this.onOverFullScreenBtn);
         this.var_55.addEventListener(MouseEvent.ROLL_OUT,this.onOutFullScreenBtn);
         this.var_55.addEventListener(MouseEvent.CLICK,this.onClickFullScreenBtn);
         this.isFullScreen = false;
         this.var_56 = new Sprite();
         this.var_56.mouseChildren = false;
         addChild(this.var_56);
         this.nextTankButtonState1 = new nextTankState1Class();
         this.var_56.addChild(this.nextTankButtonState1);
         this.nextTankButtonState2 = new nextTankState2Class();
         this.var_56.addChild(this.nextTankButtonState2);
         this.nextTankButtonState2.visible = false;
         this.var_56.addEventListener(MouseEvent.ROLL_OVER,this.onOverNextTankBtn);
         this.var_56.addEventListener(MouseEvent.ROLL_OUT,this.onOutNextTankBtn);
         this.var_56.addEventListener(MouseEvent.CLICK,this.onClickNextTankBtn);
      }
      
      public function destroy() : void
      {
         if(this.var_60 != null)
         {
            removeChild(this.var_60);
         }
         if(this.var_58 != null)
         {
            removeChild(this.var_58);
         }
         if(this.var_57 != null)
         {
            removeChild(this.var_57);
         }
         if(this.var_55 != null)
         {
            this.var_55.removeEventListener(MouseEvent.ROLL_OVER,this.onOverFullScreenBtn);
            this.var_55.removeEventListener(MouseEvent.ROLL_OUT,this.onOutFullScreenBtn);
            this.var_55.removeEventListener(MouseEvent.CLICK,this.onClickFullScreenBtn);
            removeChild(this.var_55);
         }
         if(this.var_56 != null)
         {
            this.var_56.removeEventListener(MouseEvent.ROLL_OVER,this.onOverNextTankBtn);
            this.var_56.removeEventListener(MouseEvent.ROLL_OUT,this.onOutNextTankBtn);
            this.var_56.removeEventListener(MouseEvent.CLICK,this.onClickNextTankBtn);
            removeChild(this.var_56);
         }
         this.var_60 = null;
         this.var_58 = null;
         this.var_57 = null;
         this.var_55 = null;
         this.var_56 = null;
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         if(this.var_58 != null)
         {
            this.var_58.x = param1 - this.var_58.width;
         }
         if(this.var_57 != null)
         {
            this.var_57.y = param2 - this.var_57.height;
         }
         if(this.var_55 != null)
         {
            this.var_55.x = param1 - this.var_55.width - GAP_RIGHT;
            this.var_55.y = param2 - this.var_55.height - GAP_BOTTOM;
         }
         if(this.var_56 != null)
         {
            this.var_56.x = param1 - this.var_55.width - this.var_56.width - GAP_BEEWEN_BUTTON - GAP_RIGHT;
            this.var_56.y = param2 - this.var_56.height - GAP_BOTTOM;
         }
      }
      
      public function get isFullScreen() : Boolean
      {
         return this.var_59;
      }
      
      public function set isFullScreen(param1:Boolean) : void
      {
         this.var_59 = param1;
         if(this.var_59 == false)
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
         if(this.var_59 == false)
         {
            this.fullScreenButtonState2.visible = true;
         }
      }
      
      private function onOutFullScreenBtn(param1:MouseEvent) : void
      {
         if(this.var_59 == false)
         {
            this.fullScreenButtonState2.visible = false;
         }
      }
      
      private function onClickFullScreenBtn(param1:MouseEvent) : void
      {
         this.isFullScreen = !this.var_59;
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

