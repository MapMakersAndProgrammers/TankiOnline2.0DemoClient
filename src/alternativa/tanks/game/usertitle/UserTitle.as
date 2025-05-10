package alternativa.tanks.game.usertitle
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.engine3d.resources.BitmapTextureResource;
   import alternativa.math.Vector3;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.clientlog.IClientLog;
   import alternativa.tanks.game.subsystems.rendersystem.IResourceManager;
   import alternativa.tanks.game.types.TeamType;
   import alternativa.tanks.game.usertitle.component.IUserName;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class UserTitle
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
      
      private static const indicatorTypes:Vector.<int> = Vector.<int>([EffectIndicator.TYPE_HEALTH,EffectIndicator.TYPE_ARMOR,EffectIndicator.TYPE_POWER,EffectIndicator.TYPE_NITRO]);
      
      private static var teamTypeSkin:Dictionary = new Dictionary();
      
      teamTypeSkin[TeamType.NONE] = ProgressBarSkin.HEALTHBAR_DM;
      teamTypeSkin[TeamType.BLUE] = ProgressBarSkin.HEALTHBAR_BLUE;
      teamTypeSkin[TeamType.RED] = ProgressBarSkin.HEALTHBAR_RED;
      
      private var flags:int;
      
      private var sprite:Sprite3D;
      
      private var §_-iy§:Rectangle;
      
      private var material:TextureMaterial;
      
      private var textureResource:BitmapTextureResource;
      
      private var texture:BitmapData;
      
      private var label:IUserName;
      
      private var labelText:String;
      
      private var rankIcon:IRankIcon;
      
      private var rankId:int;
      
      private var §_-f1§:ProgressBar;
      
      private var §_-ie§:ProgressBar;
      
      private var §_-os§:Vector.<EffectIndicator>;
      
      private var §_-8o§:int;
      
      private var §_-oS§:int;
      
      private var §_-P4§:Boolean;
      
      private var maxHealth:int;
      
      private var health:Number;
      
      private var weaponStatus:Number;
      
      private var teamType:TeamType = TeamType.NONE;
      
      private var resourceManager:IResourceManager;
      
      public function UserTitle(maxHealth:int, rankIcon:IRankIcon, label:IUserName)
      {
         super();
         this.maxHealth = maxHealth;
         this.rankIcon = rankIcon;
         this.label = label;
         this.resourceManager = this.resourceManager;
         this.textureResource = new BitmapTextureResource(null);
         this.material = new TextureMaterial(this.textureResource);
         this.material.§_-L4§ = true;
         this.sprite = new Sprite3D(100,100,this.material);
         this.sprite.material = this.material;
         this.sprite.perspectiveScale = false;
         this.setDeadState();
      }
      
      public function setResourceManager(resourceManager:IResourceManager) : void
      {
         this.resourceManager = resourceManager;
      }
      
      public function setLocal() : void
      {
         this.sprite.alwaysOnTop = true;
      }
      
      public function setMaxHealth(maxHealth:int) : void
      {
         this.maxHealth = maxHealth;
      }
      
      public function setHiddenState() : void
      {
         this.setFlags(BIT_STATE_HIDDEN);
      }
      
      public function clearHiddenState() : void
      {
         this.clearFlags(BIT_STATE_HIDDEN);
      }
      
      public function setDeadState() : void
      {
         this.setFlags(BIT_STATE_DEAD);
      }
      
      public function clearDeadState() : void
      {
         this.clearFlags(BIT_STATE_DEAD);
      }
      
      public function isVisible() : Boolean
      {
         return (this.flags & HIDDEN_STATE_FLAGS) == 0;
      }
      
      public function setConfiguration(configFlags:int) : void
      {
         if(!this.hasAllFlags(configFlags))
         {
            this.setFlags(configFlags);
            this.updateConfiguration();
         }
      }
      
      public function setTeamType(teamType:TeamType) : void
      {
         var bit:int = 0;
         if(this.teamType != teamType)
         {
            this.teamType = teamType;
            for each(bit in [BIT_LABEL,BIT_HEALTH,BIT_WEAPON])
            {
               if(this.hasAllFlags(bit))
               {
                  this.markDirty(bit);
               }
            }
         }
      }
      
      public function setRank(rankId:int) : void
      {
         if(this.rankId != rankId)
         {
            this.rankId = rankId;
            if(this.hasAllFlags(BIT_LABEL))
            {
               this.markDirty(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function setLabelText(labelText:String) : void
      {
         if(this.labelText != labelText)
         {
            this.labelText = labelText;
            if(this.hasAllFlags(BIT_LABEL))
            {
               this.updateConfiguration();
               this.markDirty(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
            }
         }
      }
      
      public function setHealth(health:Number) : void
      {
         if(this.health != health)
         {
            this.health = health;
            if(this.hasAllFlags(BIT_HEALTH))
            {
               this.markDirty(BIT_HEALTH);
            }
         }
      }
      
      public function setWeaponStatus(weaponStatus:Number) : void
      {
         if(this.weaponStatus != weaponStatus)
         {
            this.weaponStatus = weaponStatus;
            if(this.hasAllFlags(BIT_WEAPON))
            {
               this.markDirty(BIT_WEAPON);
            }
         }
      }
      
      public function showIndicator(indicatorId:int, duration:int) : void
      {
         var indicator:EffectIndicator = null;
         if(this.hasAllFlags(BIT_EFFECTS))
         {
            indicator = this.getEffectIndicatorById(indicatorId);
            if(indicator != null)
            {
               if(indicator.isHidden())
               {
                  this.changeVisibleIndicatorsNumber(1);
               }
               indicator.show(duration);
            }
         }
      }
      
      public function hideIndicator(indicatorId:int) : void
      {
         var indicator:EffectIndicator = null;
         if(this.hasAllFlags(BIT_EFFECTS))
         {
            indicator = this.getEffectIndicatorById(indicatorId);
            if(indicator != null)
            {
               indicator.hide();
            }
         }
      }
      
      public function hideIndicators() : void
      {
         var indicatorId:int = 0;
         if(this.§_-os§ != null && this.hasAllFlags(BIT_EFFECTS))
         {
            for each(indicatorId in indicatorTypes)
            {
               this.hideIndicator(indicatorId);
            }
         }
      }
      
      internal function doHideIndicator(indicator:EffectIndicator) : void
      {
         indicator.clear(this.texture);
         this.changeVisibleIndicatorsNumber(-1);
      }
      
      public function update(pos:Vector3, time:int, timeDelta:int) : void
      {
         var reloadResource:Boolean = false;
         var effectIndicator:EffectIndicator = null;
         this.setPosition(pos);
         this.updateVisibility(timeDelta);
         if(this.hasAnyFlags(DIRTY_MASK))
         {
            reloadResource = true;
            if(this.isDirtyAndHasOption(BIT_LABEL))
            {
               this.updateLabel();
            }
            if(this.isDirtyAndHasOption(BIT_HEALTH))
            {
               this.§_-f1§.setSkin(teamTypeSkin[this.teamType]);
               this.§_-f1§.progress = MAX_PROGRESS * this.health / this.maxHealth;
               this.§_-f1§.draw(this.texture);
            }
            if(this.isDirtyAndHasOption(BIT_WEAPON))
            {
               this.§_-ie§.progress = this.weaponStatus;
               this.§_-ie§.draw(this.texture);
            }
            if(this.isDirtyAndHasOption(BIT_EFFECTS))
            {
               for each(effectIndicator in this.§_-os§)
               {
                  effectIndicator.forceRedraw();
               }
            }
            this.clearFlags(DIRTY_MASK);
         }
         if(this.hasAllFlags(BIT_EFFECTS))
         {
            reloadResource = this.updateEffectIndicators(time,timeDelta) || reloadResource;
         }
         if(reloadResource)
         {
            this.resourceManager.uploadResource(this.textureResource);
         }
      }
      
      private function isDirtyAndHasOption(bit:int) : Boolean
      {
         var mask:int = bit | bit << 8;
         return (mask & this.flags) == mask;
      }
      
      private function updateEffectIndicators(now:int, delta:int) : Boolean
      {
         var indicator:EffectIndicator = null;
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
               if(indicator.isVisible())
               {
                  indicator.clear(this.texture);
               }
               if(!indicator.isHidden())
               {
                  indicator.setPosition(x,this.§_-oS§);
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
      
      private function changeVisibleIndicatorsNumber(increment:int) : void
      {
         this.§_-8o§ += increment;
         this.§_-P4§ = true;
      }
      
      private function updateConfiguration() : void
      {
         if(this.hasAnyFlags(CONFIG_FLAGS))
         {
            this.setupTexture();
            this.setupComponents();
         }
      }
      
      private function setupTexture() : void
      {
         var width:int = 0;
         var height:int = 0;
         var numEffects:int = 0;
         var w:int = 0;
         if(this.hasAllFlags(BIT_LABEL))
         {
            this.label.text = this.labelText || "";
            width = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
            height = LABEL_HEIGHT;
         }
         if(this.hasAllFlags(BIT_HEALTH))
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
            if(this.hasAllFlags(BIT_WEAPON))
            {
               height += WEAPON_BAR_SPACING_Y + BAR_HEIGHT;
            }
         }
         if(this.hasAllFlags(BIT_EFFECTS))
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
         width = this.findNearestPowerOfTwo(width);
         height += 2 * TEXTURE_MARGIN;
         height = this.findNearestPowerOfTwo(height);
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
            this.markDirty(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      private function findNearestPowerOfTwo(value:int) : int
      {
         for(var power:int = 2; value > power; )
         {
            power <<= 1;
         }
         return power;
      }
      
      private function setupComponents() : void
      {
         var left:int = 0;
         var top:int = TEXTURE_MARGIN;
         if(this.hasAllFlags(BIT_LABEL))
         {
            top += LABEL_HEIGHT;
         }
         if(this.hasAllFlags(BIT_HEALTH))
         {
            if(this.hasAllFlags(BIT_LABEL))
            {
               top += HEALTH_BAR_SPACING_Y;
            }
            left = this.§_-iy§.width - BAR_WIDTH >> 1;
            this.§_-f1§ = new ProgressBar(left,top,MAX_PROGRESS,BAR_WIDTH,teamTypeSkin[this.teamType]);
            top += BAR_HEIGHT;
            if(this.hasAllFlags(BIT_WEAPON))
            {
               top += WEAPON_BAR_SPACING_Y;
               this.§_-ie§ = new ProgressBar(left,top,MAX_PROGRESS,BAR_WIDTH,ProgressBarSkin.WEAPONBAR);
               top += BAR_HEIGHT;
            }
         }
         if(this.hasAllFlags(BIT_EFFECTS))
         {
            top += EFFECTS_SPACING_Y;
            this.§_-oS§ = top;
            this.createEffectsIndicators();
         }
      }
      
      public function addToContainer(container:Object3D) : void
      {
         if(this.sprite.parent == null)
         {
            container.addChild(this.sprite);
         }
      }
      
      public function removeFromContainer() : void
      {
         if(this.sprite.parent != null)
         {
            this.sprite.parent.removeChild(this.sprite);
         }
      }
      
      public function setPosition(pos:Vector3) : void
      {
         this.sprite.x = pos.x;
         this.sprite.y = pos.y;
         this.sprite.z = pos.z;
      }
      
      private function markDirty(configBit:int) : void
      {
         this.flags |= configBit << 8;
      }
      
      private function updateLabel() : void
      {
         var clientLog:IClientLog = null;
         var tmpBitmapData:BitmapData = this.texture.clone();
         tmpBitmapData.fillRect(this.§_-iy§,0);
         var labelWidth:int = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
         var left:int = tmpBitmapData.width - labelWidth >> 1;
         matrix.tx = left;
         matrix.ty = TEXTURE_MARGIN + RANK_ICON_OFFSET_Y;
         var icon:BitmapData = this.rankIcon.getIcon(this.rankId);
         clientLog = IClientLog(OSGi.getInstance().getService(IClientLog));
         clientLog.log("icon","UserTitle::updateLabel() icon size: %1x%2",icon.width,icon.height);
         clientLog.log("icon","UserTitle::updateLabel() label height: %1",this.label.textHeight);
         tmpBitmapData.draw(icon,matrix,null,null,null,true);
         matrix.tx = left + RANK_ICON_SIZE + LABEL_SPACING;
         matrix.ty = TEXTURE_MARGIN;
         var skin:ProgressBarSkin = teamTypeSkin[this.teamType];
         this.label.textColor = skin.color;
         tmpBitmapData.draw(this.label.getLabel(),matrix,null,null,null,true);
         this.texture.applyFilter(tmpBitmapData,this.§_-iy§,new Point(),filter);
         tmpBitmapData.dispose();
      }
      
      private function createEffectsIndicators() : void
      {
         var indicatorType:int = 0;
         if(this.§_-os§ != null)
         {
            return;
         }
         this.§_-os§ = new Vector.<EffectIndicator>();
         for each(indicatorType in indicatorTypes)
         {
            if(indicatorType == EffectIndicator.TYPE_HEALTH)
            {
               this.§_-os§.push(new EffectIndicator(indicatorType,100000,this,300,0));
            }
            else
            {
               this.§_-os§.push(new EffectIndicator(indicatorType,EFFECT_WARNING_TIME,this,300,30));
            }
         }
      }
      
      private function getEffectIndicatorById(effectId:int) : EffectIndicator
      {
         var len:int = 0;
         var i:int = 0;
         var indicator:EffectIndicator = null;
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
      
      private function updateVisibility(delta:int) : void
      {
      }
      
      private function setFlags(mask:int) : void
      {
         this.flags |= mask;
      }
      
      private function clearFlags(mask:int) : void
      {
         this.flags &= ~mask;
      }
      
      private function hasAnyFlags(mask:int) : Boolean
      {
         return (this.flags & mask) != 0;
      }
      
      private function hasAllFlags(mask:int) : Boolean
      {
         return (this.flags & mask) == mask;
      }
   }
}

