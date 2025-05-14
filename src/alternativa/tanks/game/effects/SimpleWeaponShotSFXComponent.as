package alternativa.tanks.game.effects
{
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.weapons.effects.IWeaponShotEffects;
   import flash.media.Sound;
   
   public class SimpleWeaponShotSFXComponent extends EntityComponent implements IWeaponShotEffects
   {
      private var shotTextureResource:TextureResource;
      
      private var shotSound:Sound;
      
      private var gameKernel:GameKernel;
      
      private var turret:ITurretPhysicsComponent;
      
      public function SimpleWeaponShotSFXComponent(shotTextureResource:TextureResource, shotSound:Sound)
      {
         super();
         this.shotTextureResource = shotTextureResource;
         this.shotSound = shotSound;
      }
      
      override public function initComponent() : void
      {
         this.turret = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
      }
      
      public function createShotEffects(barrelIndex:int, barrelOrigin:Vector3, muzzlePosition:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         var simpleWeaponShotEffect:SimpleWeaponShotEffect = SimpleWeaponShotEffect(this.gameKernel.getObjectPoolManager().getObject(SimpleWeaponShotEffect));
         simpleWeaponShotEffect.init(barrelIndex,this.turret,this.shotTextureResource,100);
         this.gameKernel.getRenderSystem().addEffect(simpleWeaponShotEffect);
      }
   }
}

import alternativa.engine3d.alternativa3d;
import alternativa.engine3d.materials.TextureMaterial;
import alternativa.engine3d.objects.Mesh;
import alternativa.engine3d.resources.TextureResource;
import alternativa.math.Vector3;
import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
import alternativa.tanks.game.subsystems.rendersystem.GameCamera;
import alternativa.tanks.game.subsystems.rendersystem.IGraphicEffect;
import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
import alternativa.tanks.game.subsystems.timesystem.TimeSystem;
import alternativa.tanks.game.utils.SFXUtils;
import alternativa.tanks.game.utils.objectpool.ObjectPool;
import alternativa.tanks.game.utils.objectpool.PooledObject;
import alternativa.tanks.game.effects.Plane;

use namespace alternativa3d;

class SimpleWeaponShotEffect extends PooledObject implements IGraphicEffect
{
   private static var muzzlePosition:Vector3 = new Vector3();
   
   private static var gunDirection:Vector3 = new Vector3();
   
   private var turret:ITurretPhysicsComponent;
   
   private var mesh:Mesh;
   
   private var material:TextureMaterial;
   
   private var timeToLive:int;
   
   private var barrelIndex:int;
   
   public function SimpleWeaponShotEffect(objectPool:ObjectPool)
   {
      super(objectPool);
      this.mesh = new Plane(40,250,0,250 / 2);
      this.material = new TextureMaterial();
      this.material.transparentPass = true;
      this.mesh.setMaterialToAllSurfaces(this.material);
   }
   
   public function init(barrelIndex:int, turret:ITurretPhysicsComponent, textureResource:TextureResource, timeToLive:int) : void
   {
      this.barrelIndex = barrelIndex;
      this.turret = turret;
      this.timeToLive = timeToLive;
      this.material.diffuseMap = textureResource;
   }
   
   public function addedToRenderSystem(system:RenderSystem) : void
   {
      system.useResource(this.mesh.geometry);
      system.getEffectsContainer().addChild(this.mesh);
   }
   
   public function play(camera:GameCamera) : Boolean
   {
      if(this.timeToLive < 0)
      {
         return false;
      }
      this.turret.getGunMuzzleData(this.barrelIndex,muzzlePosition,gunDirection);
      SFXUtils.alignObjectPlaneToView(this.mesh,muzzlePosition,gunDirection,camera.position);
      this.timeToLive -= TimeSystem.timeDelta;
      return true;
   }
   
   public function destroy() : void
   {
      this.mesh.alternativa3d::removeFromParent();
   }
}
