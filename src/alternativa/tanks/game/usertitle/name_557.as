package alternativa.tanks.game.usertitle
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_37.name_593;
   
   public class name_557
   {
      public static const TYPE_HEALTH:int = 1;
      
      public static const TYPE_ARMOR:int = 2;
      
      public static const TYPE_POWER:int = 3;
      
      public static const TYPE_NITRO:int = 4;
      
      private static const STATE_HIDDEN:int = 1;
      
      private static const STATE_PREPARED:int = 2;
      
      private static const STATE_VISIBLE:int = 4;
      
      private static const STATE_HIDING:int = 8;
      
      private static const iconHealthCls:Class = EffectIndicator_iconHealthCls;
      
      private static const iconArmorCls:Class = EffectIndicator_iconArmorCls;
      
      private static const iconPowerCls:Class = EffectIndicator_iconPowerCls;
      
      private static const iconNitroCls:Class = EffectIndicator_iconNitroCls;
      
      private static const MIN_ALPHA:Number = 0.2;
      
      private static var matrix:Matrix = new Matrix();
      
      private static var icons:Dictionary = new Dictionary();
      
      icons[TYPE_HEALTH] = Bitmap(new iconHealthCls()).bitmapData;
      icons[TYPE_ARMOR] = Bitmap(new iconArmorCls()).bitmapData;
      icons[TYPE_POWER] = Bitmap(new iconPowerCls()).bitmapData;
      icons[TYPE_NITRO] = Bitmap(new iconNitroCls()).bitmapData;
      
      private static var iconRect:Rectangle = BitmapData(icons[TYPE_HEALTH]).rect;
      
      private var var_712:int;
      
      private var icon:BitmapData;
      
      private var blinkingTime:int;
      
      private var colorTransform:ColorTransform = new ColorTransform();
      
      private var var_711:int;
      
      private var var_708:name_593;
      
      private var alpha:Number = 1;
      
      private var var_710:Boolean;
      
      private var x:int;
      
      private var y:int;
      
      private var userTitle:name_440;
      
      private var state:int;
      
      private var var_709:Boolean;
      
      public function name_557(effectId:int, blinkingTime:int, userTitle:name_440, initialBlinkInterval:int, blinkIntervalDecrement:int)
      {
         super();
         this.var_712 = effectId;
         this.icon = icons[effectId];
         this.blinkingTime = blinkingTime;
         this.userTitle = userTitle;
         this.var_708 = new name_593(initialBlinkInterval,20,blinkIntervalDecrement,MIN_ALPHA,1,10);
         this.state = STATE_HIDDEN;
      }
      
      public function get effectId() : int
      {
         return this.var_712;
      }
      
      public function method_320() : Boolean
      {
         return (this.state & STATE_VISIBLE) != 0;
      }
      
      public function name_561() : Boolean
      {
         return this.state == STATE_HIDDEN;
      }
      
      public function show(duration:int) : void
      {
         this.state &= ~STATE_HIDING;
         if(this.state != STATE_VISIBLE || this.alpha != 1)
         {
            this.var_710 = true;
         }
         this.var_711 = getTimer() + duration - this.blinkingTime;
         this.var_709 = false;
         this.alpha = 1;
         if(this.state == STATE_HIDDEN)
         {
            this.state = STATE_PREPARED;
         }
      }
      
      public function hide() : void
      {
         if(this.state == STATE_PREPARED)
         {
            this.userTitle.method_325(this);
            this.state = STATE_HIDDEN;
            return;
         }
         if((this.state & (STATE_HIDDEN | STATE_HIDING)) != 0)
         {
            return;
         }
         this.state |= STATE_HIDING;
         this.var_708.name_594(0);
         if(!this.var_709)
         {
            this.var_711 = 0;
            this.var_708.init(getTimer());
            this.var_709 = true;
         }
      }
      
      public function clear(texture:BitmapData) : void
      {
         if(this.state == STATE_HIDDEN || this.state == STATE_PREPARED)
         {
            return;
         }
         iconRect.x = this.x;
         iconRect.y = this.y;
         texture.fillRect(iconRect,0);
      }
      
      public function name_230(x:int, y:int) : void
      {
         this.x = x;
         this.y = y;
         this.var_710 = true;
      }
      
      public function name_565() : void
      {
         this.var_710 = true;
      }
      
      public function update(now:int, delta:int, texture:BitmapData) : Boolean
      {
         var updated:Boolean = false;
         if(this.state == STATE_HIDDEN)
         {
            return false;
         }
         if(this.var_710)
         {
            this.draw(texture);
            this.var_710 = false;
            updated = true;
         }
         if(now > this.var_711)
         {
            this.method_367(now,delta,texture);
            updated = true;
         }
         if(this.state == STATE_PREPARED)
         {
            this.state = STATE_VISIBLE;
         }
         return updated;
      }
      
      private function method_367(now:int, delta:int, texture:BitmapData) : void
      {
         var newAlpha:Number = NaN;
         if(this.var_709)
         {
            newAlpha = Number(this.var_708.name_595(now,delta));
            if(newAlpha != this.alpha)
            {
               this.alpha = newAlpha;
               this.draw(texture);
            }
            if((this.state & STATE_HIDING) != 0 && this.alpha == 0)
            {
               this.userTitle.method_325(this);
               this.state = STATE_HIDDEN;
            }
         }
         else
         {
            this.var_708.name_594(MIN_ALPHA);
            this.var_708.init(now);
            this.var_709 = true;
         }
      }
      
      private function draw(texture:BitmapData) : void
      {
         this.clear(texture);
         matrix.tx = this.x;
         matrix.ty = this.y;
         this.colorTransform.alphaMultiplier = this.alpha;
         texture.draw(this.icon,matrix,this.colorTransform,null,null,true);
      }
   }
}

