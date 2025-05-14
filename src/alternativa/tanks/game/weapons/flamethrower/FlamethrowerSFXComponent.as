package alternativa.tanks.game.weapons.flamethrower
{
   import alternativa.engine3d.effects.TextureAtlas;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.tanks.game.EntityComponent;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.entities.tank.physics.IChassisPhysicsComponent;
   import alternativa.tanks.game.entities.tank.physics.ITurretPhysicsComponent;
   import alternativa.tanks.game.weapons.conicareadamage.IConicAreaWeaponSFX;
   
   public class FlamethrowerSFXComponent extends EntityComponent implements IConicAreaWeaponSFX
   {
      private static var flamethrowerSmokeAtlas:TextureAtlas;
      
      private static var flamethrowerFlashAtlas:TextureAtlas;
      
      private static var flamethrowerFireAtlas:TextureAtlas;
      
      private var gameKernel:GameKernel;
      
      private var effect:FlamethrowerGraphicEffect;
      
      private var range:Number;
      
      private var coneAngle:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var sfxData:FlamethrowerSFXData;
      
      private var chassis:IChassisPhysicsComponent;
      
      private var turret:ITurretPhysicsComponent;
      
      public function FlamethrowerSFXComponent(range:Number, coneAngle:Number, maxParticles:int, particleSpeed:Number, sfxData:FlamethrowerSFXData)
      {
         super();
         this.range = range;
         this.coneAngle = coneAngle;
         this.maxParticles = maxParticles;
         this.particleSpeed = particleSpeed;
         this.sfxData = sfxData;
         this.chassis = this.chassis;
         this.turret = this.turret;
      }
      
      public static function init(diffuse:TextureResource, opacity:TextureResource) : void
      {
         flamethrowerSmokeAtlas = new TextureAtlas(diffuse,opacity,8,8,0,16,30,true);
         flamethrowerFlashAtlas = new TextureAtlas(diffuse,opacity,8,8,16,16,60,true);
         flamethrowerFireAtlas = new TextureAtlas(diffuse,opacity,8,8,32,32,60,false);
      }
      
      override public function initComponent() : void
      {
         this.turret = ITurretPhysicsComponent(entity.getComponentStrict(ITurretPhysicsComponent));
         this.chassis = IChassisPhysicsComponent(entity.getComponentStrict(IChassisPhysicsComponent));
      }
      
      override public function addToGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:GameKernel) : void
      {
         this.gameKernel = null;
      }
      
      public function start() : void
      {
         if(this.effect != null)
         {
            this.effect.kill();
         }
         this.effect = FlamethrowerGraphicEffect(this.gameKernel.getObjectPoolManager().getObject(FlamethrowerGraphicEffect));
         var collisionDetector:ICollisionDetector = this.gameKernel.getPhysicsSystem().getPhysicsScene().collisionDetector;
         this.effect.init(this.turret,flamethrowerSmokeAtlas,flamethrowerFlashAtlas,flamethrowerFireAtlas);
         this.gameKernel.getRenderSystem().addEffect(this.effect);
      }
      
      public function stop() : void
      {
         if(this.effect != null)
         {
            this.effect.kill();
         }
         this.effect = null;
      }
   }
}

