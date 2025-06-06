package alternativa.tanks.game.usertitle
{
   import alternativa.tanks.game.effects.Blinker;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class EffectIndicator
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
      
      private var name_oz:int;
      
      private var icon:BitmapData;
      
      private var blinkingTime:int;
      
      private var colorTransform:ColorTransform = new ColorTransform();
      
      private var name_im:int;
      
      private var name_Jj:Blinker;
      
      private var alpha:Number = 1;
      
      private var name_aw:Boolean;
      
      private var x:int;
      
      private var y:int;
      
      private var userTitle:UserTitle;
      
      private var state:int;
      
      private var name_VQ:Boolean;
      
      public function EffectIndicator(effectId:int, blinkingTime:int, userTitle:UserTitle, initialBlinkInterval:int, blinkIntervalDecrement:int)
      {
         super();
         this.name_oz = effectId;
         this.icon = icons[effectId];
         this.blinkingTime = blinkingTime;
         this.userTitle = userTitle;
         this.name_Jj = new Blinker(initialBlinkInterval,20,blinkIntervalDecrement,MIN_ALPHA,1,10);
         this.state = STATE_HIDDEN;
      }
      
      public function get effectId() : int
      {
         return this.name_oz;
      }
      
      public function isVisible() : Boolean
      {
         return (this.state & STATE_VISIBLE) != 0;
      }
      
      public function isHidden() : Boolean
      {
         return this.state == STATE_HIDDEN;
      }
      
      public function show(duration:int) : void
      {
         this.state &= ~STATE_HIDING;
         if(this.state != STATE_VISIBLE || this.alpha != 1)
         {
            this.name_aw = true;
         }
         this.name_im = getTimer() + duration - this.blinkingTime;
         this.name_VQ = false;
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
            this.userTitle.doHideIndicator(this);
            this.state = STATE_HIDDEN;
            return;
         }
         if((this.state & (STATE_HIDDEN | STATE_HIDING)) != 0)
         {
            return;
         }
         this.state |= STATE_HIDING;
         this.name_Jj.setMinValue(0);
         if(!this.name_VQ)
         {
            this.name_im = 0;
            this.name_Jj.init(getTimer());
            this.name_VQ = true;
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
      
      public function setPosition(x:int, y:int) : void
      {
         this.x = x;
         this.y = y;
         this.name_aw = true;
      }
      
      public function forceRedraw() : void
      {
         this.name_aw = true;
      }
      
      public function update(now:int, delta:int, texture:BitmapData) : Boolean
      {
         var updated:Boolean = false;
         if(this.state == STATE_HIDDEN)
         {
            return false;
         }
         if(this.name_aw)
         {
            this.draw(texture);
            this.name_aw = false;
            updated = true;
         }
         if(now > this.name_im)
         {
            this.updateBlinking(now,delta,texture);
            updated = true;
         }
         if(this.state == STATE_PREPARED)
         {
            this.state = STATE_VISIBLE;
         }
         return updated;
      }
      
      private function updateBlinking(now:int, delta:int, texture:BitmapData) : void
      {
         var newAlpha:Number = NaN;
         if(this.name_VQ)
         {
            newAlpha = this.name_Jj.updateValue(now,delta);
            if(newAlpha != this.alpha)
            {
               this.alpha = newAlpha;
               this.draw(texture);
            }
            if((this.state & STATE_HIDING) != 0 && this.alpha == 0)
            {
               this.userTitle.doHideIndicator(this);
               this.state = STATE_HIDDEN;
            }
         }
         else
         {
            this.name_Jj.setMinValue(MIN_ALPHA);
            this.name_Jj.init(now);
            this.name_VQ = true;
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

