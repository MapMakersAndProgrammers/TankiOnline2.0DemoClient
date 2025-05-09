package alternativa.tanks.game.weapons.ammunition.splashhit.debug
{
   import alternativa.engine3d.effects.TextureAtlas;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.resources.TextureResource;
   import alternativa.math.Vector3;
   import alternativa.tanks.game.GameKernel;
   import alternativa.tanks.game.effects.IAreaOfEffectSFX;
   import alternativa.tanks.game.subsystems.rendersystem.RenderSystem;
   import flash.geom.Vector3D;
   
   public class DebugSplashDamageEffects implements IAreaOfEffectSFX
   {
      private static var smokeAtlas:TextureAtlas;
      
      private static var fireAtlas:TextureAtlas;
      
      private static var flashAtlas:TextureAtlas;
      
      private static var fragmentAtlas:TextureAtlas;
      
      private static var glowAtlas:TextureAtlas;
      
      private static var sparkAtlas:TextureAtlas;
      
      private static const tempVector:Vector3D = new Vector3D();
      
      private var gameKernel:GameKernel;
      
      private var frames:Vector.<Material>;
      
      public function DebugSplashDamageEffects(gameKernel:GameKernel, frames:Vector.<Material>)
      {
         super();
         this.gameKernel = gameKernel;
         this.frames = frames;
      }
      
      public static function init(diffuse:TextureResource, opacity:TextureResource) : void
      {
         smokeAtlas = new TextureAtlas(diffuse,opacity,8,8,0,16,30,true);
         fireAtlas = new TextureAtlas(diffuse,opacity,8,8,16,16,30,true);
         flashAtlas = new TextureAtlas(diffuse,opacity,8,8,32,16,30,true,0.5,0.5);
         fragmentAtlas = new TextureAtlas(diffuse,opacity,8,8,48,8,30,true);
         glowAtlas = new TextureAtlas(diffuse,opacity,8,8,56,1,30,true);
         sparkAtlas = new TextureAtlas(diffuse,opacity,8,8,57,1,30,true);
      }
      
      public function createEffects(position:Vector3, weakeningCoefficient:Number, radius:Number) : void
      {
         var renderSystem:RenderSystem = this.gameKernel.getRenderSystem();
         var explosion:SmokyExplosion = new SmokyExplosion(smokeAtlas,fireAtlas,flashAtlas,glowAtlas,sparkAtlas,fragmentAtlas);
         tempVector.x = position.x;
         tempVector.y = position.y;
         tempVector.z = position.z;
         explosion.position = tempVector;
         explosion.scale = 6;
         renderSystem.addA3DEffect(explosion);
      }
   }
}

