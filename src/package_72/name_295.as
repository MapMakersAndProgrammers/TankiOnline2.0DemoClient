package package_72
{
   import flash.media.Sound;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import package_115.class_26;
   import package_28.name_129;
   import package_46.name_194;
   import package_75.class_15;
   
   public class name_295 extends EntityComponent implements class_26
   {
      private var shotTextureResource:name_129;
      
      private var shotSound:Sound;
      
      private var gameKernel:GameKernel;
      
      private var turret:class_15;
      
      public function name_295(shotTextureResource:name_129, shotSound:Sound)
      {
         super();
         this.shotTextureResource = shotTextureResource;
         this.shotSound = shotSound;
      }
      
      override public function initComponent() : void
      {
         this.turret = class_15(entity.getComponentStrict(class_15));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
      }
      
      public function method_411(barrelIndex:int, barrelOrigin:name_194, muzzlePosition:name_194, gunDirection:name_194, gunElevationAxis:name_194) : void
      {
         var simpleWeaponShotEffect:SimpleWeaponShotEffect = SimpleWeaponShotEffect(this.gameKernel.method_108().name_110(SimpleWeaponShotEffect));
         simpleWeaponShotEffect.init(barrelIndex,this.turret,this.shotTextureResource,100);
         this.gameKernel.name_5().method_37(simpleWeaponShotEffect);
      }
   }
}

import alternativa.engine3d.alternativa3d;
import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
import package_19.name_380;
import alternativa.tanks.game.utils.objectpool.PooledObject;
import alternativa.tanks.game.utils.objectpool.ObjectPool;
import package_27.name_519;
import package_28.name_129;
import package_4.class_5;
import package_45.name_182;
import package_46.name_194;
import package_75.class_15;

use namespace alternativa3d;

class SimpleWeaponShotEffect extends PooledObject implements IGraphicEffect
{
   private static var muzzlePosition:name_194 = new name_194();
   
   private static var gunDirection:name_194 = new name_194();
   
   private var turret:class_15;
   
   private var mesh:name_380;
   
   private var material:class_5;
   
   private var timeToLive:int;
   
   private var barrelIndex:int;
   
   public function SimpleWeaponShotEffect(objectPool:ObjectPool)
   {
      super(objectPool);
      this.mesh = new name_520(40,250,0,250 / 2);
      this.material = new class_5();
      this.material.var_21 = true;
      this.mesh.setMaterialToAllSurfaces(this.material);
   }
   
   public function init(barrelIndex:int, turret:class_15, textureResource:name_129, timeToLive:int) : void
   {
      this.barrelIndex = barrelIndex;
      this.turret = turret;
      this.timeToLive = timeToLive;
      this.material.diffuseMap = textureResource;
   }
   
   public function addedToRenderSystem(system:RenderSystem) : void
   {
      system.method_29(this.mesh.geometry);
      system.method_60().addChild(this.mesh);
   }
   
   public function play(camera:GameCamera) : Boolean
   {
      if(this.timeToLive < 0)
      {
         return false;
      }
      this.turret.getGunMuzzleData(this.barrelIndex,muzzlePosition,gunDirection);
      name_519.name_521(this.mesh,muzzlePosition,gunDirection,camera.position);
      this.timeToLive -= name_182.timeDelta;
      return true;
   }
   
   public function destroy() : void
   {
      this.mesh.alternativa3d::removeFromParent();
   }
}
