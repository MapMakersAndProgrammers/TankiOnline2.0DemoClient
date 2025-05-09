package alternativa.tanks.game.usertitle
{
   import §_-1z§.§_-b1§;
   import §_-7j§.§_-BN§;
   import §_-8D§.§_-OX§;
   import §_-Ex§.§_-hW§;
   import §_-MU§.§_-5-§;
   import §_-Uy§.§_-oP§;
   import §_-Vh§.§_-pZ§;
   import §_-e6§.§_-B-§;
   import §_-nl§.§_-bj§;
   import alternativa.tanks.game.usertitle.component.§_-3v§;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class §class§
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
      
      private static const indicatorTypes:Vector.<int> = Vector.<int>([§_-Ip§.TYPE_HEALTH,§_-Ip§.TYPE_ARMOR,§_-Ip§.TYPE_POWER,§_-Ip§.TYPE_NITRO]);
      
      private static var teamTypeSkin:Dictionary = new Dictionary();
      
      teamTypeSkin[§_-BN§.NONE] = §_-4R§.HEALTHBAR_DM;
      teamTypeSkin[§_-BN§.BLUE] = §_-4R§.HEALTHBAR_BLUE;
      teamTypeSkin[§_-BN§.RED] = §_-4R§.HEALTHBAR_RED;
      
      private var flags:int;
      
      private var sprite:§_-hW§;
      
      private var §_-iy§:Rectangle;
      
      private var material:§_-pZ§;
      
      private var textureResource:§_-b1§;
      
      private var texture:BitmapData;
      
      private var label:§_-3v§;
      
      private var labelText:String;
      
      private var rankIcon:§_-fe§;
      
      private var rankId:int;
      
      private var §_-f1§:§_-K9§;
      
      private var §_-ie§:§_-K9§;
      
      private var §_-os§:Vector.<§_-Ip§>;
      
      private var §_-8o§:int;
      
      private var §_-oS§:int;
      
      private var §_-P4§:Boolean;
      
      private var maxHealth:int;
      
      private var health:Number;
      
      private var weaponStatus:Number;
      
      private var teamType:§_-BN§ = §_-BN§.NONE;
      
      private var resourceManager:§_-B-§;
      
      public function §class§(maxHealth:int, rankIcon:§_-fe§, label:§_-3v§)
      {
         super();
         this.maxHealth = maxHealth;
         this.rankIcon = rankIcon;
         this.label = label;
         this.resourceManager = this.resourceManager;
         this.textureResource = new §_-b1§(null);
         this.material = new §_-pZ§(this.textureResource);
         this.material.§_-L4§ = true;
         this.sprite = new §_-hW§(100,100,this.material);
         this.sprite.material = this.material;
         this.sprite.perspectiveScale = false;
         this.setDeadState();
      }
      
      public function §_-58§(resourceManager:§_-B-§) : void
      {
         this.resourceManager = resourceManager;
      }
      
      public function §_-S5§() : void
      {
         this.sprite.alwaysOnTop = true;
      }
      
      public function §_-a7§(maxHealth:int) : void
      {
         this.maxHealth = maxHealth;
      }
      
      public function §_-Wx§() : void
      {
         this.§_-I7§(BIT_STATE_HIDDEN);
      }
      
      public function §_-cI§() : void
      {
         this.§_-F2§(BIT_STATE_HIDDEN);
      }
      
      public function setDeadState() : void
      {
         this.§_-I7§(BIT_STATE_DEAD);
      }
      
      public function clearDeadState() : void
      {
         this.§_-F2§(BIT_STATE_DEAD);
      }
      
      public function §_-bG§() : Boolean
      {
         return (this.flags & HIDDEN_STATE_FLAGS) == 0;
      }
      
      public function §_-ag§(configFlags:int) : void
      {
         if(!this.§_-qq§(configFlags))
         {
            this.§_-I7§(configFlags);
            this.§_-Z1§();
         }
      }
      
      public function §_-NR§(teamType:§_-BN§) : void
      {
         var bit:int = 0;
         if(this.teamType != teamType)
         {
            this.teamType = teamType;
            for each(bit in [BIT_LABEL,BIT_HEALTH,BIT_WEAPON])
            {
               if(this.§_-qq§(bit))
               {
                  this.§_-Xw§(bit);
               }
            }
         }
      }
      
      public function §_-Qx§(rankId:int) : void
      {
         if(this.rankId != rankId)
         {
            this.rankId = rankId;
            if(this.§_-qq§(BIT_LABEL))
            {
               this.§_-Xw§(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function §_-03§(labelText:String) : void
      {
         if(this.labelText != labelText)
         {
            this.labelText = labelText;
            if(this.§_-qq§(BIT_LABEL))
            {
               this.§_-Z1§();
               this.§_-Xw§(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function setHealth(health:Number) : void
      {
         if(this.health != health)
         {
            this.health = health;
            if(this.§_-qq§(BIT_HEALTH))
            {
               this.§_-Xw§(BIT_HEALTH);
            }
         }
      }
      
      public function §_-XE§(weaponStatus:Number) : void
      {
         if(this.weaponStatus != weaponStatus)
         {
            this.weaponStatus = weaponStatus;
            if(this.§_-qq§(BIT_WEAPON))
            {
               this.§_-Xw§(BIT_WEAPON);
            }
         }
      }
      
      public function §_-0W§(indicatorId:int, duration:int) : void
      {
         var indicator:§_-Ip§ = null;
         if(this.§_-qq§(BIT_EFFECTS))
         {
            indicator = this.§_-Ty§(indicatorId);
            if(indicator != null)
            {
               if(indicator.§_-gZ§())
               {
                  this.§_-Ka§(1);
               }
               indicator.show(duration);
            }
         }
      }
      
      public function §_-kd§(indicatorId:int) : void
      {
         var indicator:§_-Ip§ = null;
         if(this.§_-qq§(BIT_EFFECTS))
         {
            indicator = this.§_-Ty§(indicatorId);
            if(indicator != null)
            {
               indicator.hide();
            }
         }
      }
      
      public function §_-5i§() : void
      {
         var indicatorId:int = 0;
         if(this.§_-os§ != null && this.§_-qq§(BIT_EFFECTS))
         {
            for each(indicatorId in indicatorTypes)
            {
               this.§_-kd§(indicatorId);
            }
         }
      }
      
      internal function §_-nC§(indicator:§_-Ip§) : void
      {
         indicator.clear(this.texture);
         this.§_-Ka§(-1);
      }
      
      public function update(pos:§_-bj§, time:int, timeDelta:int) : void
      {
         var reloadResource:Boolean = false;
         var effectIndicator:§_-Ip§ = null;
         this.§_-Vi§(pos);
         this.§_-mM§(timeDelta);
         if(this.§_-c7§(DIRTY_MASK))
         {
            reloadResource = true;
            if(this.§_-ki§(BIT_LABEL))
            {
               this.§_-o9§();
            }
            if(this.§_-ki§(BIT_HEALTH))
            {
               this.§_-f1§.§_-gM§(teamTypeSkin[this.teamType]);
               this.§_-f1§.progress = MAX_PROGRESS * this.health / this.maxHealth;
               this.§_-f1§.draw(this.texture);
            }
            if(this.§_-ki§(BIT_WEAPON))
            {
               this.§_-ie§.progress = this.weaponStatus;
               this.§_-ie§.draw(this.texture);
            }
            if(this.§_-ki§(BIT_EFFECTS))
            {
               for each(effectIndicator in this.§_-os§)
               {
                  effectIndicator.§_-mo§();
               }
            }
            this.§_-F2§(DIRTY_MASK);
         }
         if(this.§_-qq§(BIT_EFFECTS))
         {
            reloadResource = this.§_-Hh§(time,timeDelta) || reloadResource;
         }
         if(reloadResource)
         {
            this.resourceManager.§_-bL§(this.textureResource);
         }
      }
      
      private function §_-ki§(bit:int) : Boolean
      {
         var mask:int = bit | bit << 8;
         return (mask & this.flags) == mask;
      }
      
      private function §_-Hh§(now:int, delta:int) : Boolean
      {
         var indicator:§_-Ip§ = null;
         var i:int = 0;
         var wereUpdated:Boolean = false;
         var x:int = 0;
         var num:int = int(this.§_-os§.length);
         if(this.§_-P4§)
         {
            this.§_-P4§ = false;
            x = this.§_-iy§.width + TEXTURE_MARGIN_2 - this.§_-8o§ * EFFECTS_ICON_SIZE - (this.§_-8o§ - 1) * EFFECTS_SPACING_X >> 1;
            for(i = 0; i < num; )
            {
               indicator = this.§_-os§[i];
               if(indicator.§_-bG§())
               {
                  indicator.clear(this.texture);
               }
               if(!indicator.§_-gZ§())
               {
                  indicator.§_-Vi§(x,this.§_-oS§);
                  x += EFFECTS_ICON_SIZE + EFFECTS_SPACING_X;
               }
               i++;
            }
            wereUpdated = true;
         }
         for(i = 0; i < num; )
         {
            indicator = this.§_-os§[i];
            wereUpdated = indicator.update(now,delta,this.texture) || wereUpdated;
            i++;
         }
         return wereUpdated;
      }
      
      private function §_-Ka§(increment:int) : void
      {
         this.§_-8o§ += increment;
         this.§_-P4§ = true;
      }
      
      private function §_-Z1§() : void
      {
         if(this.§_-c7§(CONFIG_FLAGS))
         {
            this.§_-Op§();
            this.§_-8n§();
         }
      }
      
      private function §_-Op§() : void
      {
         var width:int = 0;
         var height:int = 0;
         var numEffects:int = 0;
         var w:int = 0;
         if(this.§_-qq§(BIT_LABEL))
         {
            this.label.text = this.labelText || "";
            width = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
            height = LABEL_HEIGHT;
         }
         if(this.§_-qq§(BIT_HEALTH))
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
            if(this.§_-qq§(BIT_WEAPON))
            {
               height += WEAPON_BAR_SPACING_Y + BAR_HEIGHT;
            }
         }
         if(this.§_-qq§(BIT_EFFECTS))
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
         width = this.§_-Uv§(width);
         height += 2 * TEXTURE_MARGIN;
         height = this.§_-Uv§(height);
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
            this.§_-iy§ = this.texture.rect;
            this.§_-Xw§(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      private function §_-Uv§(value:int) : int
      {
         for(var power:int = 2; value > power; )
         {
            power <<= 1;
         }
         return power;
      }
      
      private function §_-8n§() : void
      {
         var left:int = 0;
         var top:int = TEXTURE_MARGIN;
         if(this.§_-qq§(BIT_LABEL))
         {
            top += LABEL_HEIGHT;
         }
         if(this.§_-qq§(BIT_HEALTH))
         {
            if(this.§_-qq§(BIT_LABEL))
            {
               top += HEALTH_BAR_SPACING_Y;
            }
            left = this.§_-iy§.width - BAR_WIDTH >> 1;
            this.§_-f1§ = new §_-K9§(left,top,MAX_PROGRESS,BAR_WIDTH,teamTypeSkin[this.teamType]);
            top += BAR_HEIGHT;
            if(this.§_-qq§(BIT_WEAPON))
            {
               top += WEAPON_BAR_SPACING_Y;
               this.§_-ie§ = new §_-K9§(left,top,MAX_PROGRESS,BAR_WIDTH,§_-4R§.WEAPONBAR);
               top += BAR_HEIGHT;
            }
         }
         if(this.§_-qq§(BIT_EFFECTS))
         {
            top += EFFECTS_SPACING_Y;
            this.§_-oS§ = top;
            this.§_-ez§();
         }
      }
      
      public function §_-p6§(container:§_-OX§) : void
      {
         if(this.sprite.parent == null)
         {
            container.addChild(this.sprite);
         }
      }
      
      public function §_-Md§() : void
      {
         if(this.sprite.parent != null)
         {
            this.sprite.parent.removeChild(this.sprite);
         }
      }
      
      public function §_-Vi§(pos:§_-bj§) : void
      {
         this.sprite.x = pos.x;
         this.sprite.y = pos.y;
         this.sprite.z = pos.z;
      }
      
      private function §_-Xw§(configBit:int) : void
      {
         this.flags |= configBit << 8;
      }
      
      private function §_-o9§() : void
      {
         var clientLog:§_-5-§ = null;
         var tmpBitmapData:BitmapData = this.texture.clone();
         tmpBitmapData.fillRect(this.§_-iy§,0);
         var labelWidth:int = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
         var left:int = tmpBitmapData.width - labelWidth >> 1;
         matrix.tx = left;
         matrix.ty = TEXTURE_MARGIN + RANK_ICON_OFFSET_Y;
         var icon:BitmapData = this.rankIcon.§null §(this.rankId);
         clientLog = §_-5-§(§_-oP§.§_-nQ§().§_-N6§(§_-5-§));
         clientLog.log("icon","UserTitle::updateLabel() icon size: %1x%2",icon.width,icon.height);
         clientLog.log("icon","UserTitle::updateLabel() label height: %1",this.label.textHeight);
         tmpBitmapData.draw(icon,matrix,null,null,null,true);
         matrix.tx = left + RANK_ICON_SIZE + LABEL_SPACING;
         matrix.ty = TEXTURE_MARGIN;
         var skin:§_-4R§ = teamTypeSkin[this.teamType];
         this.label.textColor = skin.color;
         tmpBitmapData.draw(this.label.§_-Qc§(),matrix,null,null,null,true);
         this.texture.applyFilter(tmpBitmapData,this.§_-iy§,new Point(),filter);
         tmpBitmapData.dispose();
      }
      
      private function §_-ez§() : void
      {
         var indicatorType:int = 0;
         if(this.§_-os§ != null)
         {
            return;
         }
         this.§_-os§ = new Vector.<§_-Ip§>();
         for each(indicatorType in indicatorTypes)
         {
            if(indicatorType == §_-Ip§.TYPE_HEALTH)
            {
               this.§_-os§.push(new §_-Ip§(indicatorType,100000,this,300,0));
            }
            else
            {
               this.§_-os§.push(new §_-Ip§(indicatorType,EFFECT_WARNING_TIME,this,300,30));
            }
         }
      }
      
      private function §_-Ty§(effectId:int) : §_-Ip§
      {
         var len:int = 0;
         var i:int = 0;
         var indicator:§_-Ip§ = null;
         if(this.§_-os§ != null)
         {
            len = int(this.§_-os§.length);
            for(i = 0; i < len; )
            {
               indicator = this.§_-os§[i];
               if(indicator.effectId == effectId)
               {
                  return indicator;
               }
               i++;
            }
         }
         return null;
      }
      
      private function §_-mM§(delta:int) : void
      {
      }
      
      private function §_-I7§(mask:int) : void
      {
         this.flags |= mask;
      }
      
      private function §_-F2§(mask:int) : void
      {
         this.flags &= ~mask;
      }
      
      private function §_-c7§(mask:int) : Boolean
      {
         return (this.flags & mask) != 0;
      }
      
      private function §_-qq§(mask:int) : Boolean
      {
         return (this.flags & mask) == mask;
      }
   }
}

