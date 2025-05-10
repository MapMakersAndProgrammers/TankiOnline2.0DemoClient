package alternativa.tanks.game.weapons.ammunition.plasma
{
   import alternativa.engine3d.materials.Material;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.effects.AnimatedSpriteEffect;
   import alternativa.tanks.game.weapons.ammunition.energy.IEnergyRoundEffect;
   import alternativa.tanks.game.weapons.ammunition.energy.IEnergyRoundEffectsFactory;
   import flash.geom.ColorTransform;
   
   public class PlasmaRoundEffectsFactory implements IEnergyRoundEffectsFactory
   {
      private static const EFFECT_SIZE:Number = 300;
      
      private static const EFFECT_FPS:Number = 30;
      
      private static const EXPLOSION_EFFECT_SIZE:Number = 600;
      
      private static const EXPLOSION_FPS:int = 30;
      
      private var gameKernel:GameKernel;
      
      private var roundFrames:Vector.<Material>;
      
      private var explosionFrames:Vector.<Material>;
      
      private var colorTransform:ColorTransform;
      
      public function PlasmaRoundEffectsFactory(gameKernel:GameKernel, roundFrames:Vector.<Material>, explosionFrames:Vector.<Material>, colorTransform:ColorTransform)
      {
         super();
         this.gameKernel = gameKernel;
         this.roundFrames = roundFrames;
         this.explosionFrames = explosionFrames;
         this.colorTransform = colorTransform;
      }
      
      public function createEnergyRoundEffect() : IEnergyRoundEffect
      {
         var effect:PlasmaRoundEffect = PlasmaRoundEffect(this.gameKernel.getObjectPoolManager().getObject(PlasmaRoundEffect));
         var rotation:Number = Math.random() * Math.PI;
         effect.init(EFFECT_SIZE,EFFECT_SIZE,this.roundFrames,Vector3.ZERO,rotation,50,EFFECT_FPS,true,0.5,0.5);
         this.gameKernel.getRenderSystem().each(effect);
         return effect;
      }
      
      public function createExplosionEffects(position:Vector3) : void
      {
         var explosionEffect:AnimatedSpriteEffect = AnimatedSpriteEffect(this.gameKernel.getObjectPoolManager().getObject(AnimatedSpriteEffect));
         var rotation:Number = Math.random() * Math.PI;
         explosionEffect.init(EXPLOSION_EFFECT_SIZE,EXPLOSION_EFFECT_SIZE,this.explosionFrames,position,rotation,50,EXPLOSION_FPS,false,0.5,0.5);
         this.gameKernel.getRenderSystem().each(explosionEffect);
      }
      
      public function createRicochetEffects(position:Vector3, normal:Vector3, direction:Vector3) : void
      {
      }
   }
}

