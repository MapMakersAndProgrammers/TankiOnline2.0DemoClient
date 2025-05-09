package alternativa.tanks.game.weapons.thunder
{
   import alternativa.engine3d.effects.TextureAtlas;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.weapons.ammunition.splashhit.debug.SmokyShot;
   import alternativa.tanks.game.weapons.effects.IWeaponShotEffects;
   import flash.geom.Vector3D;
   
   public class ThunderShotEffectComponent extends EntityComponent implements IWeaponShotEffects
   {
      private static var smokyShotAtlas:TextureAtlas;
      
      private var gameKernel:GameKernel;
      
      private var turretPhysicsComponent:ITurretPhysicsComponent;
      
      private var textureResource:TextureResource;
      
      private var var_487:Vector3D = new Vector3D();
      
      public function ThunderShotEffectComponent(textureResource:TextureResource)
      {
         super();
         this.textureResource = textureResource;
      }
      
      public static function init(diffuse:TextureResource, opacity:TextureResource) : void
      {
         smokyShotAtlas = new TextureAtlas(diffuse,opacity,8,8,58,1,30,true);
      }
      
      override public function initComponent() : void
      {
         this.turretPhysicsComponent = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
         gameKernel.getRenderSystem().useResource(this.textureResource);
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         gameKernel.getRenderSystem().releaseResource(this.textureResource);
      }
      
      public function createShotEffects(barrelIndex:int, barrelOrigin:Vector3, muzzlePosition:Vector3, gunDirection:Vector3, gunElevationAxis:Vector3) : void
      {
         var eff:SmokyShot = new SmokyShot(smokyShotAtlas);
         this.var_487.x = muzzlePosition.x;
         this.var_487.y = muzzlePosition.y;
         this.var_487.z = muzzlePosition.z + 20;
         eff.position = this.var_487;
         this.var_487.x = gunDirection.x;
         this.var_487.y = gunDirection.y;
         this.var_487.z = gunDirection.z;
         eff.direction = this.var_487;
         eff.scale = 3;
         this.gameKernel.getRenderSystem().addA3DEffect(eff);
      }
   }
}

