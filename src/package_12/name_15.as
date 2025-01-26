package package_12
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class name_15 extends Sprite
   {
      private static const topLeftIconClass:Class = name_221;
      
      private static const topRightIconClass:Class = name_222;
      
      private static const bottomLeftIconClass:Class = name_220;
      
      private static const fullScreenState1Class:Class = TanksHudDemo_fullScreenState1Class;
      
      private static const fullScreenState2Class:Class = TanksHudDemo_fullScreenState2Class;
      
      private static const nextTankState1Class:Class = TanksHudDemo_nextTankState1Class;
      
      private static const nextTankState2Class:Class = TanksHudDemo_nextTankState2Class;
      
      private static const GAP_RIGHT:int = 7;
      
      private static const GAP_BOTTOM:int = 7;
      
      private static const GAP_BEEWEN_BUTTON:int = 1;
      
      private var var_60:Bitmap;
      
      private var var_57:Bitmap;
      
      private var var_58:Bitmap;
      
      private var fullScreenButtonState1:Bitmap;
      
      private var fullScreenButtonState2:Bitmap;
      
      private var nextTankButtonState1:Bitmap;
      
      private var nextTankButtonState2:Bitmap;
      
      private var var_55:Sprite;
      
      private var var_56:Sprite;
      
      private var var_59:Boolean;
      
      public function name_15()
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
         this.var_57 = new topRightIconClass();
         addChild(this.var_57);
         this.var_58 = new bottomLeftIconClass();
         addChild(this.var_58);
         this.var_55 = new Sprite();
         this.var_55.mouseChildren = false;
         addChild(this.var_55);
         this.fullScreenButtonState1 = new fullScreenState1Class();
         this.var_55.addChild(this.fullScreenButtonState1);
         this.fullScreenButtonState2 = new fullScreenState2Class();
         this.var_55.addChild(this.fullScreenButtonState2);
         this.var_55.addEventListener(MouseEvent.ROLL_OVER,this.method_132);
         this.var_55.addEventListener(MouseEvent.ROLL_OUT,this.method_131);
         this.var_55.addEventListener(MouseEvent.CLICK,this.method_134);
         this.name_31 = false;
         this.var_56 = new Sprite();
         this.var_56.mouseChildren = false;
         addChild(this.var_56);
         this.nextTankButtonState1 = new nextTankState1Class();
         this.var_56.addChild(this.nextTankButtonState1);
         this.nextTankButtonState2 = new nextTankState2Class();
         this.var_56.addChild(this.nextTankButtonState2);
         this.nextTankButtonState2.visible = false;
         this.var_56.addEventListener(MouseEvent.ROLL_OVER,this.method_136);
         this.var_56.addEventListener(MouseEvent.ROLL_OUT,this.method_133);
         this.var_56.addEventListener(MouseEvent.CLICK,this.method_135);
      }
      
      public function destroy() : void
      {
         if(this.var_60 != null)
         {
            removeChild(this.var_60);
         }
         if(this.var_57 != null)
         {
            removeChild(this.var_57);
         }
         if(this.var_58 != null)
         {
            removeChild(this.var_58);
         }
         if(this.var_55 != null)
         {
            this.var_55.removeEventListener(MouseEvent.ROLL_OVER,this.method_132);
            this.var_55.removeEventListener(MouseEvent.ROLL_OUT,this.method_131);
            this.var_55.removeEventListener(MouseEvent.CLICK,this.method_134);
            removeChild(this.var_55);
         }
         if(this.var_56 != null)
         {
            this.var_56.removeEventListener(MouseEvent.ROLL_OVER,this.method_136);
            this.var_56.removeEventListener(MouseEvent.ROLL_OUT,this.method_133);
            this.var_56.removeEventListener(MouseEvent.CLICK,this.method_135);
            removeChild(this.var_56);
         }
         this.var_60 = null;
         this.var_57 = null;
         this.var_58 = null;
         this.var_55 = null;
         this.var_56 = null;
      }
      
      public function name_50(param1:Number, param2:Number) : void
      {
         if(this.var_57 != null)
         {
            this.var_57.x = param1 - this.var_57.width;
         }
         if(this.var_58 != null)
         {
            this.var_58.y = param2 - this.var_58.height;
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
      
      public function get name_31() : Boolean
      {
         return this.var_59;
      }
      
      public function set name_31(param1:Boolean) : void
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
      
      private function method_132(param1:MouseEvent) : void
      {
         if(this.var_59 == false)
         {
            this.fullScreenButtonState2.visible = true;
         }
      }
      
      private function method_131(param1:MouseEvent) : void
      {
         if(this.var_59 == false)
         {
            this.fullScreenButtonState2.visible = false;
         }
      }
      
      private function method_134(param1:MouseEvent) : void
      {
         this.name_31 = !this.var_59;
         dispatchEvent(new Event("CLICK_FULL_SCREEN_BUTTON"));
      }
      
      private function method_136(param1:MouseEvent) : void
      {
         this.nextTankButtonState2.visible = true;
      }
      
      private function method_133(param1:MouseEvent) : void
      {
         this.nextTankButtonState2.visible = false;
      }
      
      private function method_135(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("CLICK_NEXT_TANK_BUTTON"));
      }
   }
}

