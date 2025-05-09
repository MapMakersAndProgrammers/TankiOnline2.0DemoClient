package package_37
{
   import flash.media.Sound;
   import package_15.class_18;
   import package_15.name_17;
   import package_21.name_86;
   import package_38.name_145;
   import package_41.class_12;
   import package_81.class_20;
   
   public class name_212 extends class_18 implements class_20
   {
      private var shotTextureResource:name_86;
      
      private var shotSound:Sound;
      
      private var gameKernel:name_17;
      
      private var turret:class_12;
      
      public function name_212(shotTextureResource:name_86, shotSound:Sound)
      {
         super();
         this.shotTextureResource = shotTextureResource;
         this.shotSound = shotSound;
      }
      
      override public function initComponent() : void
      {
         this.turret = class_12(entity.getComponentStrict(class_12));
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
      }
      
      public function method_169(barrelIndex:int, barrelOrigin:name_145, muzzlePosition:name_145, gunDirection:name_145, gunElevationAxis:name_145) : void
      {
         var simpleWeaponShotEffect:SimpleWeaponShotEffect = SimpleWeaponShotEffect(this.gameKernel.method_33().name_165(SimpleWeaponShotEffect));
         simpleWeaponShotEffect.init(barrelIndex,this.turret,this.shotTextureResource,100);
         this.gameKernel.name_5().method_21(simpleWeaponShotEffect);
      }
   }
}

import alternativa.engine3d.alternativa3d;
import package_18.class_17;
import package_18.name_375;
import package_18.name_51;
import package_19.class_16;
import package_21.name_86;
import package_25.name_353;
import package_25.name_355;
import package_29.name_391;
import package_3.class_5;
import package_30.name_103;
import package_38.name_145;
import package_41.class_12;

use namespace alternativa3d;

class SimpleWeaponShotEffect extends name_353 implements class_17
{
   private static var muzzlePosition:name_145 = new name_145();
   
   private static var gunDirection:name_145 = new name_145();
   
   private var turret:class_12;
   
   private var mesh:class_16;
   
   private var material:class_5;
   
   private var timeToLive:int;
   
   private var barrelIndex:int;
   
   public function SimpleWeaponShotEffect(objectPool:name_355)
   {
      super(objectPool);
      this.mesh = new name_392(40,250,0,250 / 2);
      this.material = new class_5();
      this.material.var_21 = true;
      this.mesh.setMaterialToAllSurfaces(this.material);
   }
   
   public function init(barrelIndex:int, turret:class_12, textureResource:name_86, timeToLive:int) : void
   {
      this.barrelIndex = barrelIndex;
      this.turret = turret;
      this.timeToLive = timeToLive;
      this.material.diffuseMap = textureResource;
   }
   
   public function addedToRenderSystem(system:name_51) : void
   {
      system.name_148(this.mesh.geometry);
      system.name_394().addChild(this.mesh);
   }
   
   public function play(camera:name_375) : Boolean
   {
      if(this.timeToLive < 0)
      {
         return false;
      }
      this.turret.getGunMuzzleData(this.barrelIndex,muzzlePosition,gunDirection);
      name_391.name_393(this.mesh,muzzlePosition,gunDirection,camera.position);
      this.timeToLive -= name_103.timeDelta;
      return true;
   }
   
   public function destroy() : void
   {
      this.mesh.alternativa3d::removeFromParent();
   }
}
