package alternativa.tanks.game.usertitle
{
   import alternativa.tanks.game.usertitle.component.name_455;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import package_14.name_3;
   import package_18.name_562;
   import package_19.name_372;
   import package_21.name_84;
   import package_3.class_5;
   import package_32.name_180;
   import package_33.name_130;
   import package_38.name_145;
   import package_99.name_558;
   
   public class name_440
   {
      public static const BIT_LABEL:int = 1;
      
      public static const BIT_HEALTH:int = 2;
      
      public static const BIT_WEAPON:int = 4;
      
      public static const BIT_EFFECTS:int = 8;
      
      private static const CONFIG_FLAGS:int = BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS;
      
      private static const DIRTY_MASK:int = CONFIG_FLAGS << 8;
      
      private static const BIT_STATE_HIDDEN:int = 1 << 16;
      
      private static const BIT_STATE_DEAD:int = 1 << 17;
      
      private static const HIDDEN_STATE_FLAGS:int = BIT_STATE_HIDDEN | BIT_STATE_DEAD;
      
      private static const MAX_PROGRESS:int = 100;
      
      private static const EFFECT_WARNING_TIME:int = 3000;
      
      private static const RANK_ICON_SIZE:int = 12;
      
      private static const RANK_ICON_OFFSET_Y:int = 0;
      
      private static const EFFECTS_ICON_SIZE:int = 16;
      
      private static const LABEL_HEIGHT:int = 12;
      
      private static const LABEL_SPACING:int = 0;
      
      private static const HEALTH_BAR_SPACING_Y:int = 2;
      
      private static const WEAPON_BAR_SPACING_Y:int = -1;
      
      private static const EFFECTS_SPACING_Y:int = 4;
      
      private static const EFFECTS_SPACING_X:int = 4;
      
      private static const BAR_WIDTH:int = 100;
      
      private static const BAR_HEIGHT:int = 13;
      
      private static const TEXTURE_MARGIN:int = 3;
      
      private static const TEXTURE_MARGIN_2:int = 2 * TEXTURE_MARGIN;
      
      private static const ALPHA_SPEED:Number = 0.002;
      
      private static const matrix:Matrix = new Matrix();
      
      private static const filter:GlowFilter = new GlowFilter(0,0.8,4,4,3);
      
      private static const indicatorTypes:Vector.<int> = Vector.<int>([name_557.TYPE_HEALTH,name_557.TYPE_ARMOR,name_557.TYPE_POWER,name_557.TYPE_NITRO]);
      
      private static var teamTypeSkin:Dictionary = new Dictionary();
      
      teamTypeSkin[name_558.NONE] = name_559.HEALTHBAR_DM;
      teamTypeSkin[name_558.BLUE] = name_559.HEALTHBAR_BLUE;
      teamTypeSkin[name_558.RED] = name_559.HEALTHBAR_RED;
      
      private var flags:int;
      
      private var sprite:name_372;
      
      private var var_650:Rectangle;
      
      private var material:class_5;
      
      private var textureResource:name_84;
      
      private var texture:BitmapData;
      
      private var label:name_455;
      
      private var labelText:String;
      
      private var rankIcon:name_454;
      
      private var rankId:int;
      
      private var var_652:name_560;
      
      private var var_654:name_560;
      
      private var var_649:Vector.<name_557>;
      
      private var var_651:int;
      
      private var var_655:int;
      
      private var var_653:Boolean;
      
      private var maxHealth:int;
      
      private var health:Number;
      
      private var weaponStatus:Number;
      
      private var teamType:name_558 = name_558.NONE;
      
      private var resourceManager:name_562;
      
      public function name_440(maxHealth:int, rankIcon:name_454, label:name_455)
      {
         super();
         this.maxHealth = maxHealth;
         this.rankIcon = rankIcon;
         this.label = label;
         this.resourceManager = this.resourceManager;
         this.textureResource = new name_84(null);
         this.material = new class_5(this.textureResource);
         this.material.var_21 = true;
         this.sprite = new name_372(100,100,this.material);
         this.sprite.material = this.material;
         this.sprite.perspectiveScale = false;
         this.setDeadState();
      }
      
      public function name_448(resourceManager:name_562) : void
      {
         this.resourceManager = resourceManager;
      }
      
      public function name_450() : void
      {
         this.sprite.alwaysOnTop = true;
      }
      
      public function method_197(maxHealth:int) : void
      {
         this.maxHealth = maxHealth;
      }
      
      public function method_323() : void
      {
         this.method_308(BIT_STATE_HIDDEN);
      }
      
      public function method_324() : void
      {
         this.method_307(BIT_STATE_HIDDEN);
      }
      
      public function setDeadState() : void
      {
         this.method_308(BIT_STATE_DEAD);
      }
      
      public function clearDeadState() : void
      {
         this.method_307(BIT_STATE_DEAD);
      }
      
      public function method_320() : Boolean
      {
         return (this.flags & HIDDEN_STATE_FLAGS) == 0;
      }
      
      public function name_452(configFlags:int) : void
      {
         if(!this.method_304(configFlags))
         {
            this.method_308(configFlags);
            this.method_312();
         }
      }
      
      public function method_322(teamType:name_558) : void
      {
         var bit:int = 0;
         if(this.teamType != teamType)
         {
            this.teamType = teamType;
            for each(bit in [BIT_LABEL,BIT_HEALTH,BIT_WEAPON])
            {
               if(this.method_304(bit))
               {
                  this.method_305(bit);
               }
            }
         }
      }
      
      public function method_196(rankId:int) : void
      {
         if(this.rankId != rankId)
         {
            this.rankId = rankId;
            if(this.method_304(BIT_LABEL))
            {
               this.method_305(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function name_447(labelText:String) : void
      {
         if(this.labelText != labelText)
         {
            this.labelText = labelText;
            if(this.method_304(BIT_LABEL))
            {
               this.method_312();
               this.method_305(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function setHealth(health:Number) : void
      {
         if(this.health != health)
         {
            this.health = health;
            if(this.method_304(BIT_HEALTH))
            {
               this.method_305(BIT_HEALTH);
            }
         }
      }
      
      public function name_451(weaponStatus:Number) : void
      {
         if(this.weaponStatus != weaponStatus)
         {
            this.weaponStatus = weaponStatus;
            if(this.method_304(BIT_WEAPON))
            {
               this.method_305(BIT_WEAPON);
            }
         }
      }
      
      public function name_265(indicatorId:int, duration:int) : void
      {
         var indicator:name_557 = null;
         if(this.method_304(BIT_EFFECTS))
         {
            indicator = this.method_310(indicatorId);
            if(indicator != null)
            {
               if(indicator.name_561())
               {
                  this.method_309(1);
               }
               indicator.show(duration);
            }
         }
      }
      
      public function name_254(indicatorId:int) : void
      {
         var indicator:name_557 = null;
         if(this.method_304(BIT_EFFECTS))
         {
            indicator = this.method_310(indicatorId);
            if(indicator != null)
            {
               indicator.hide();
            }
         }
      }
      
      public function method_321() : void
      {
         var indicatorId:int = 0;
         if(this.var_649 != null && this.method_304(BIT_EFFECTS))
         {
            for each(indicatorId in indicatorTypes)
            {
               this.name_254(indicatorId);
            }
         }
      }
      
      internal function method_325(indicator:name_557) : void
      {
         indicator.clear(this.texture);
         this.method_309(-1);
      }
      
      public function update(pos:name_145, time:int, timeDelta:int) : void
      {
         var reloadResource:Boolean = false;
         var effectIndicator:name_557 = null;
         this.name_230(pos);
         this.method_318(timeDelta);
         if(this.method_313(DIRTY_MASK))
         {
            reloadResource = true;
            if(this.method_306(BIT_LABEL))
            {
               this.method_319();
            }
            if(this.method_306(BIT_HEALTH))
            {
               this.var_652.name_564(teamTypeSkin[this.teamType]);
               this.var_652.progress = MAX_PROGRESS * this.health / this.maxHealth;
               this.var_652.draw(this.texture);
            }
            if(this.method_306(BIT_WEAPON))
            {
               this.var_654.progress = this.weaponStatus;
               this.var_654.draw(this.texture);
            }
            if(this.method_306(BIT_EFFECTS))
            {
               for each(effectIndicator in this.var_649)
               {
                  effectIndicator.name_565();
               }
            }
            this.method_307(DIRTY_MASK);
         }
         if(this.method_304(BIT_EFFECTS))
         {
            reloadResource = this.method_315(time,timeDelta) || reloadResource;
         }
         if(reloadResource)
         {
            this.resourceManager.name_563(this.textureResource);
         }
      }
      
      private function method_306(bit:int) : Boolean
      {
         var mask:int = bit | bit << 8;
         return (mask & this.flags) == mask;
      }
      
      private function method_315(now:int, delta:int) : Boolean
      {
         var indicator:name_557 = null;
         var i:int = 0;
         var wereUpdated:Boolean = false;
         var x:int = 0;
         var num:int = int(this.var_649.length);
         if(this.var_653)
         {
            this.var_653 = false;
            x = this.var_650.width + TEXTURE_MARGIN_2 - this.var_651 * EFFECTS_ICON_SIZE - (this.var_651 - 1) * EFFECTS_SPACING_X >> 1;
            for(i = 0; i < num; )
            {
               indicator = this.var_649[i];
               if(indicator.method_320())
               {
                  indicator.clear(this.texture);
               }
               if(!indicator.name_561())
               {
                  indicator.name_230(x,this.var_655);
                  x += EFFECTS_ICON_SIZE + EFFECTS_SPACING_X;
               }
               i++;
            }
            wereUpdated = true;
         }
         for(i = 0; i < num; )
         {
            indicator = this.var_649[i];
            wereUpdated = indicator.update(now,delta,this.texture) || wereUpdated;
            i++;
         }
         return wereUpdated;
      }
      
      private function method_309(increment:int) : void
      {
         this.var_651 += increment;
         this.var_653 = true;
      }
      
      private function method_312() : void
      {
         if(this.method_313(CONFIG_FLAGS))
         {
            this.method_316();
            this.method_314();
         }
      }
      
      private function method_316() : void
      {
         var width:int = 0;
         var height:int = 0;
         var numEffects:int = 0;
         var w:int = 0;
         if(this.method_304(BIT_LABEL))
         {
            this.label.text = this.labelText || "";
            width = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
            height = LABEL_HEIGHT;
         }
         if(this.method_304(BIT_HEALTH))
         {
            if(width < BAR_WIDTH)
            {
               width = BAR_WIDTH;
            }
            if(height > 0)
            {
               height += HEALTH_BAR_SPACING_Y;
            }
            height += BAR_HEIGHT;
            if(this.method_304(BIT_WEAPON))
            {
               height += WEAPON_BAR_SPACING_Y + BAR_HEIGHT;
            }
         }
         if(this.method_304(BIT_EFFECTS))
         {
            numEffects = 4;
            w = numEffects * EFFECTS_ICON_SIZE + (numEffects - 1) * EFFECTS_SPACING_X;
            if(width < w)
            {
               width = w;
            }
            if(height > 0)
            {
               height += EFFECTS_SPACING_Y;
            }
            height += EFFECTS_ICON_SIZE;
         }
         width += 2 * TEXTURE_MARGIN;
         width = this.method_311(width);
         height += 2 * TEXTURE_MARGIN;
         height = this.method_311(height);
         if(this.texture == null || this.texture.width != width || this.texture.height != height)
         {
            if(this.texture != null)
            {
               this.texture.dispose();
            }
            this.texture = new BitmapData(width,height,true,0);
            this.textureResource.data = this.texture;
            this.sprite.width = width;
            this.sprite.height = height;
            this.var_650 = this.texture.rect;
            this.method_305(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      private function method_311(value:int) : int
      {
         for(var power:int = 2; value > power; )
         {
            power <<= 1;
         }
         return power;
      }
      
      private function method_314() : void
      {
         var left:int = 0;
         var top:int = TEXTURE_MARGIN;
         if(this.method_304(BIT_LABEL))
         {
            top += LABEL_HEIGHT;
         }
         if(this.method_304(BIT_HEALTH))
         {
            if(this.method_304(BIT_LABEL))
            {
               top += HEALTH_BAR_SPACING_Y;
            }
            left = this.var_650.width - BAR_WIDTH >> 1;
            this.var_652 = new name_560(left,top,MAX_PROGRESS,BAR_WIDTH,teamTypeSkin[this.teamType]);
            top += BAR_HEIGHT;
            if(this.method_304(BIT_WEAPON))
            {
               top += WEAPON_BAR_SPACING_Y;
               this.var_654 = new name_560(left,top,MAX_PROGRESS,BAR_WIDTH,name_559.WEAPONBAR);
               top += BAR_HEIGHT;
            }
         }
         if(this.method_304(BIT_EFFECTS))
         {
            top += EFFECTS_SPACING_Y;
            this.var_655 = top;
            this.method_317();
         }
      }
      
      public function name_453(container:name_130) : void
      {
         if(this.sprite.parent == null)
         {
            container.addChild(this.sprite);
         }
      }
      
      public function name_449() : void
      {
         if(this.sprite.parent != null)
         {
            this.sprite.parent.removeChild(this.sprite);
         }
      }
      
      public function name_230(pos:name_145) : void
      {
         this.sprite.x = pos.x;
         this.sprite.y = pos.y;
         this.sprite.z = pos.z;
      }
      
      private function method_305(configBit:int) : void
      {
         this.flags |= configBit << 8;
      }
      
      private function method_319() : void
      {
         var clientLog:name_180 = null;
         var tmpBitmapData:BitmapData = this.texture.clone();
         tmpBitmapData.fillRect(this.var_650,0);
         var labelWidth:int = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
         var left:int = tmpBitmapData.width - labelWidth >> 1;
         matrix.tx = left;
         matrix.ty = TEXTURE_MARGIN + RANK_ICON_OFFSET_Y;
         var icon:BitmapData = this.rankIcon.method_302(this.rankId);
         clientLog = name_180(name_3.name_8().name_21(name_180));
         clientLog.log("icon","UserTitle::updateLabel() icon size: %1x%2",icon.width,icon.height);
         clientLog.log("icon","UserTitle::updateLabel() label height: %1",this.label.textHeight);
         tmpBitmapData.draw(icon,matrix,null,null,null,true);
         matrix.tx = left + RANK_ICON_SIZE + LABEL_SPACING;
         matrix.ty = TEXTURE_MARGIN;
         var skin:name_559 = teamTypeSkin[this.teamType];
         this.label.textColor = skin.color;
         tmpBitmapData.draw(this.label.method_303(),matrix,null,null,null,true);
         this.texture.applyFilter(tmpBitmapData,this.var_650,new Point(),filter);
         tmpBitmapData.dispose();
      }
      
      private function method_317() : void
      {
         var indicatorType:int = 0;
         if(this.var_649 != null)
         {
            return;
         }
         this.var_649 = new Vector.<name_557>();
         for each(indicatorType in indicatorTypes)
         {
            if(indicatorType == name_557.TYPE_HEALTH)
            {
               this.var_649.push(new name_557(indicatorType,100000,this,300,0));
            }
            else
            {
               this.var_649.push(new name_557(indicatorType,EFFECT_WARNING_TIME,this,300,30));
            }
         }
      }
      
      private function method_310(effectId:int) : name_557
      {
         var len:int = 0;
         var i:int = 0;
         var indicator:name_557 = null;
         if(this.var_649 != null)
         {
            len = int(this.var_649.length);
            for(i = 0; i < len; )
            {
               indicator = this.var_649[i];
               if(indicator.effectId == effectId)
               {
                  return indicator;
               }
               i++;
            }
         }
         return null;
      }
      
      private function method_318(delta:int) : void
      {
      }
      
      private function method_308(mask:int) : void
      {
         this.flags |= mask;
      }
      
      private function method_307(mask:int) : void
      {
         this.flags &= ~mask;
      }
      
      private function method_313(mask:int) : Boolean
      {
         return (this.flags & mask) != 0;
      }
      
      private function method_304(mask:int) : Boolean
      {
         return (this.flags & mask) == mask;
      }
   }
}

