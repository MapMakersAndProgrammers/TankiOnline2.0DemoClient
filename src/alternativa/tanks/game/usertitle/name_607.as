package alternativa.tanks.game.usertitle
{
   import alternativa.tanks.game.usertitle.component.name_617;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import package_126.name_723;
   import alternativa.tanks.game.subsystems.rendersystem.IResourceManager;
   import package_19.name_494;
   import package_21.name_78;
   import package_28.name_93;
   import package_39.name_160;
   import package_4.class_5;
   import package_46.name_194;
   import alternativa.osgi.OSGi;
   
   public class name_607
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
      
      private static const indicatorTypes:Vector.<int> = Vector.<int>([name_722.TYPE_HEALTH,name_722.TYPE_ARMOR,name_722.TYPE_POWER,name_722.TYPE_NITRO]);
      
      private static var teamTypeSkin:Dictionary = new Dictionary();
      
      teamTypeSkin[name_723.NONE] = name_724.HEALTHBAR_DM;
      teamTypeSkin[name_723.BLUE] = name_724.HEALTHBAR_BLUE;
      teamTypeSkin[name_723.RED] = name_724.HEALTHBAR_RED;
      
      private var flags:int;
      
      private var sprite:name_494;
      
      private var var_650:Rectangle;
      
      private var material:class_5;
      
      private var textureResource:name_93;
      
      private var texture:BitmapData;
      
      private var label:name_617;
      
      private var labelText:String;
      
      private var rankIcon:name_613;
      
      private var rankId:int;
      
      private var var_652:name_725;
      
      private var var_654:name_725;
      
      private var var_649:Vector.<name_722>;
      
      private var var_651:int;
      
      private var var_655:int;
      
      private var var_653:Boolean;
      
      private var maxHealth:int;
      
      private var health:Number;
      
      private var weaponStatus:Number;
      
      private var teamType:name_723 = name_723.NONE;
      
      private var resourceManager:IResourceManager;
      
      public function name_607(maxHealth:int, rankIcon:name_613, label:name_617)
      {
         super();
         this.maxHealth = maxHealth;
         this.rankIcon = rankIcon;
         this.label = label;
         this.resourceManager = this.resourceManager;
         this.textureResource = new name_93(null);
         this.material = new class_5(this.textureResource);
         this.material.var_21 = true;
         this.sprite = new name_494(100,100,this.material);
         this.sprite.material = this.material;
         this.sprite.perspectiveScale = false;
         this.setDeadState();
      }
      
      public function name_612(resourceManager:IResourceManager) : void
      {
         this.resourceManager = resourceManager;
      }
      
      public function name_615() : void
      {
         this.sprite.alwaysOnTop = true;
      }
      
      public function method_524(maxHealth:int) : void
      {
         this.maxHealth = maxHealth;
      }
      
      public function method_798() : void
      {
         this.method_782(BIT_STATE_HIDDEN);
      }
      
      public function method_796() : void
      {
         this.method_781(BIT_STATE_HIDDEN);
      }
      
      public function setDeadState() : void
      {
         this.method_782(BIT_STATE_DEAD);
      }
      
      public function clearDeadState() : void
      {
         this.method_781(BIT_STATE_DEAD);
      }
      
      public function method_141() : Boolean
      {
         return (this.flags & HIDDEN_STATE_FLAGS) == 0;
      }
      
      public function name_619(configFlags:int) : void
      {
         if(!this.method_778(configFlags))
         {
            this.method_782(configFlags);
            this.method_783();
         }
      }
      
      public function method_795(teamType:name_723) : void
      {
         var bit:int = 0;
         if(this.teamType != teamType)
         {
            this.teamType = teamType;
            for each(bit in [BIT_LABEL,BIT_HEALTH,BIT_WEAPON])
            {
               if(this.method_778(bit))
               {
                  this.method_779(bit);
               }
            }
         }
      }
      
      public function method_526(rankId:int) : void
      {
         if(this.rankId != rankId)
         {
            this.rankId = rankId;
            if(this.method_778(BIT_LABEL))
            {
               this.method_779(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function name_620(labelText:String) : void
      {
         if(this.labelText != labelText)
         {
            this.labelText = labelText;
            if(this.method_778(BIT_LABEL))
            {
               this.method_783();
               this.method_779(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function setHealth(health:Number) : void
      {
         if(this.health != health)
         {
            this.health = health;
            if(this.method_778(BIT_HEALTH))
            {
               this.method_779(BIT_HEALTH);
            }
         }
      }
      
      public function name_616(weaponStatus:Number) : void
      {
         if(this.weaponStatus != weaponStatus)
         {
            this.weaponStatus = weaponStatus;
            if(this.method_778(BIT_WEAPON))
            {
               this.method_779(BIT_WEAPON);
            }
         }
      }
      
      public function name_339(indicatorId:int, duration:int) : void
      {
         var indicator:name_722 = null;
         if(this.method_778(BIT_EFFECTS))
         {
            indicator = this.method_785(indicatorId);
            if(indicator != null)
            {
               if(indicator.name_726())
               {
                  this.method_787(1);
               }
               indicator.show(duration);
            }
         }
      }
      
      public function name_330(indicatorId:int) : void
      {
         var indicator:name_722 = null;
         if(this.method_778(BIT_EFFECTS))
         {
            indicator = this.method_785(indicatorId);
            if(indicator != null)
            {
               indicator.hide();
            }
         }
      }
      
      public function method_797() : void
      {
         var indicatorId:int = 0;
         if(this.var_649 != null && this.method_778(BIT_EFFECTS))
         {
            for each(indicatorId in indicatorTypes)
            {
               this.name_330(indicatorId);
            }
         }
      }
      
      internal function method_794(indicator:name_722) : void
      {
         indicator.clear(this.texture);
         this.method_787(-1);
      }
      
      public function update(pos:name_194, time:int, timeDelta:int) : void
      {
         var reloadResource:Boolean = false;
         var effectIndicator:name_722 = null;
         this.name_201(pos);
         this.method_791(timeDelta);
         if(this.method_786(DIRTY_MASK))
         {
            reloadResource = true;
            if(this.method_780(BIT_LABEL))
            {
               this.method_789();
            }
            if(this.method_780(BIT_HEALTH))
            {
               this.var_652.name_727(teamTypeSkin[this.teamType]);
               this.var_652.progress = MAX_PROGRESS * this.health / this.maxHealth;
               this.var_652.draw(this.texture);
            }
            if(this.method_780(BIT_WEAPON))
            {
               this.var_654.progress = this.weaponStatus;
               this.var_654.draw(this.texture);
            }
            if(this.method_780(BIT_EFFECTS))
            {
               for each(effectIndicator in this.var_649)
               {
                  effectIndicator.name_728();
               }
            }
            this.method_781(DIRTY_MASK);
         }
         if(this.method_778(BIT_EFFECTS))
         {
            reloadResource = this.method_792(time,timeDelta) || reloadResource;
         }
         if(reloadResource)
         {
            this.resourceManager.method_30(this.textureResource);
         }
      }
      
      private function method_780(bit:int) : Boolean
      {
         var mask:int = bit | bit << 8;
         return (mask & this.flags) == mask;
      }
      
      private function method_792(now:int, delta:int) : Boolean
      {
         var indicator:name_722 = null;
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
               if(indicator.method_141())
               {
                  indicator.clear(this.texture);
               }
               if(!indicator.name_726())
               {
                  indicator.name_201(x,this.var_655);
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
      
      private function method_787(increment:int) : void
      {
         this.var_651 += increment;
         this.var_653 = true;
      }
      
      private function method_783() : void
      {
         if(this.method_786(CONFIG_FLAGS))
         {
            this.method_788();
            this.method_790();
         }
      }
      
      private function method_788() : void
      {
         var width:int = 0;
         var height:int = 0;
         var numEffects:int = 0;
         var w:int = 0;
         if(this.method_778(BIT_LABEL))
         {
            this.label.text = this.labelText || "";
            width = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
            height = LABEL_HEIGHT;
         }
         if(this.method_778(BIT_HEALTH))
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
            if(this.method_778(BIT_WEAPON))
            {
               height += WEAPON_BAR_SPACING_Y + BAR_HEIGHT;
            }
         }
         if(this.method_778(BIT_EFFECTS))
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
         width = this.method_784(width);
         height += 2 * TEXTURE_MARGIN;
         height = this.method_784(height);
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
            this.method_779(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      private function method_784(value:int) : int
      {
         for(var power:int = 2; value > power; )
         {
            power <<= 1;
         }
         return power;
      }
      
      private function method_790() : void
      {
         var left:int = 0;
         var top:int = TEXTURE_MARGIN;
         if(this.method_778(BIT_LABEL))
         {
            top += LABEL_HEIGHT;
         }
         if(this.method_778(BIT_HEALTH))
         {
            if(this.method_778(BIT_LABEL))
            {
               top += HEALTH_BAR_SPACING_Y;
            }
            left = this.var_650.width - BAR_WIDTH >> 1;
            this.var_652 = new name_725(left,top,MAX_PROGRESS,BAR_WIDTH,teamTypeSkin[this.teamType]);
            top += BAR_HEIGHT;
            if(this.method_778(BIT_WEAPON))
            {
               top += WEAPON_BAR_SPACING_Y;
               this.var_654 = new name_725(left,top,MAX_PROGRESS,BAR_WIDTH,name_724.WEAPONBAR);
               top += BAR_HEIGHT;
            }
         }
         if(this.method_778(BIT_EFFECTS))
         {
            top += EFFECTS_SPACING_Y;
            this.var_655 = top;
            this.method_793();
         }
      }
      
      public function name_611(container:name_78) : void
      {
         if(this.sprite.parent == null)
         {
            container.addChild(this.sprite);
         }
      }
      
      public function name_618() : void
      {
         if(this.sprite.parent != null)
         {
            this.sprite.parent.removeChild(this.sprite);
         }
      }
      
      public function name_201(pos:name_194) : void
      {
         this.sprite.x = pos.x;
         this.sprite.y = pos.y;
         this.sprite.z = pos.z;
      }
      
      private function method_779(configBit:int) : void
      {
         this.flags |= configBit << 8;
      }
      
      private function method_789() : void
      {
         var clientLog:name_160 = null;
         var tmpBitmapData:BitmapData = this.texture.clone();
         tmpBitmapData.fillRect(this.var_650,0);
         var labelWidth:int = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
         var left:int = tmpBitmapData.width - labelWidth >> 1;
         matrix.tx = left;
         matrix.ty = TEXTURE_MARGIN + RANK_ICON_OFFSET_Y;
         var icon:BitmapData = this.rankIcon.method_776(this.rankId);
         clientLog = name_160(OSGi.name_8().name_30(name_160));
         clientLog.log("icon","UserTitle::updateLabel() icon size: %1x%2",icon.width,icon.height);
         clientLog.log("icon","UserTitle::updateLabel() label height: %1",this.label.textHeight);
         tmpBitmapData.draw(icon,matrix,null,null,null,true);
         matrix.tx = left + RANK_ICON_SIZE + LABEL_SPACING;
         matrix.ty = TEXTURE_MARGIN;
         var skin:name_724 = teamTypeSkin[this.teamType];
         this.label.textColor = skin.color;
         tmpBitmapData.draw(this.label.method_777(),matrix,null,null,null,true);
         this.texture.applyFilter(tmpBitmapData,this.var_650,new Point(),filter);
         tmpBitmapData.dispose();
      }
      
      private function method_793() : void
      {
         var indicatorType:int = 0;
         if(this.var_649 != null)
         {
            return;
         }
         this.var_649 = new Vector.<name_722>();
         for each(indicatorType in indicatorTypes)
         {
            if(indicatorType == name_722.TYPE_HEALTH)
            {
               this.var_649.push(new name_722(indicatorType,100000,this,300,0));
            }
            else
            {
               this.var_649.push(new name_722(indicatorType,EFFECT_WARNING_TIME,this,300,30));
            }
         }
      }
      
      private function method_785(effectId:int) : name_722
      {
         var len:int = 0;
         var i:int = 0;
         var indicator:name_722 = null;
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
      
      private function method_791(delta:int) : void
      {
      }
      
      private function method_782(mask:int) : void
      {
         this.flags |= mask;
      }
      
      private function method_781(mask:int) : void
      {
         this.flags &= ~mask;
      }
      
      private function method_786(mask:int) : Boolean
      {
         return (this.flags & mask) != 0;
      }
      
      private function method_778(mask:int) : Boolean
      {
         return (this.flags & mask) == mask;
      }
   }
}

