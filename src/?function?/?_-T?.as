package §function§
{
   import §_-1z§.§_-pi§;
   import §_-7A§.§_-3e§;
   import §_-az§.§_-2J§;
   import §_-az§.§_-AG§;
   import §_-jG§.§_-gg§;
   import §_-nl§.§_-bj§;
   import flash.media.Sound;
   
   public class §_-T§ extends §_-2J§ implements §_-gg§
   {
      private var shotTextureResource:§_-pi§;
      
      private var shotSound:Sound;
      
      private var gameKernel:§_-AG§;
      
      private var turret:§_-3e§;
      
      public function §_-T§(shotTextureResource:§_-pi§, shotSound:Sound)
      {
         super();
         this.shotTextureResource = shotTextureResource;
         this.shotSound = shotSound;
      }
      
      override public function initComponent() : void
      {
         this.turret = §_-3e§(entity.getComponentStrict(§_-3e§));
      }
      
      override public function addToGame(gameKernel:§_-AG§) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:§_-AG§) : void
      {
      }
      
      public function §_-km§(barrelIndex:int, barrelOrigin:§_-bj§, muzzlePosition:§_-bj§, gunDirection:§_-bj§, gunElevationAxis:§_-bj§) : void
      {
         var simpleWeaponShotEffect:SimpleWeaponShotEffect = SimpleWeaponShotEffect(this.gameKernel.§_-11§().§_-kP§(SimpleWeaponShotEffect));
         simpleWeaponShotEffect.init(barrelIndex,this.turret,this.shotTextureResource,100);
         this.gameKernel.§_-DZ§().each(simpleWeaponShotEffect);
      }
   }
}

import §_-1z§.§_-pi§;
import §_-7A§.§_-3e§;
import §_-Ex§.§_-U2§;
import §_-RQ§.§_-HE§;
import §_-RQ§.§_-Va§;
import §_-V-§.§_-Eh§;
import §_-Vh§.§_-pZ§;
import §_-e6§.§_-1I§;
import §_-e6§.§_-RE§;
import §_-e6§.§_-fX§;
import §_-lS§.§_-h2§;
import §_-nl§.§_-bj§;
import alternativa.engine3d.alternativa3d;

use namespace alternativa3d;

class SimpleWeaponShotEffect extends §_-HE§ implements §_-fX§
{
   private static var muzzlePosition:§_-bj§ = new §_-bj§();
   
   private static var gunDirection:§_-bj§ = new §_-bj§();
   
   private var turret:§_-3e§;
   
   private var mesh:§_-U2§;
   
   private var material:§_-pZ§;
   
   private var timeToLive:int;
   
   private var barrelIndex:int;
   
   public function SimpleWeaponShotEffect(objectPool:§_-Va§)
   {
      super(objectPool);
      this.mesh = new §_-Gi§(40,250,0,250 / 2);
      this.material = new §_-pZ§();
      this.material.§_-L4§ = true;
      this.mesh.setMaterialToAllSurfaces(this.material);
   }
   
   public function init(barrelIndex:int, turret:§_-3e§, textureResource:§_-pi§, timeToLive:int) : void
   {
      this.barrelIndex = barrelIndex;
      this.turret = turret;
      this.timeToLive = timeToLive;
      this.material.diffuseMap = textureResource;
   }
   
   public function addedToRenderSystem(system:§_-1I§) : void
   {
      system.§_-09§(this.mesh.geometry);
      system.§_-p1§().addChild(this.mesh);
   }
   
   public function play(camera:§_-RE§) : Boolean
   {
      if(this.timeToLive < 0)
      {
         return false;
      }
      this.turret.getGunMuzzleData(this.barrelIndex,muzzlePosition,gunDirection);
      §_-Eh§.§_-Wr§(this.mesh,muzzlePosition,gunDirection,camera.position);
      this.timeToLive -= §_-h2§.timeDelta;
      return true;
   }
   
   public function destroy() : void
   {
      this.mesh.alternativa3d::removeFromParent();
   }
}
