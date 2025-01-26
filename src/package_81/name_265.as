package package_81
{
   import package_10.class_17;
   import package_10.name_17;
   import package_25.name_250;
   import package_28.name_129;
   import package_75.class_15;
   import package_75.name_236;
   import package_76.name_256;
   import package_95.class_28;
   
   public class name_265 extends class_17 implements class_28
   {
      private static var flamethrowerSmokeAtlas:name_250;
      
      private static var flamethrowerFlashAtlas:name_250;
      
      private static var flamethrowerFireAtlas:name_250;
      
      private var gameKernel:name_17;
      
      private var effect:name_544;
      
      private var range:Number;
      
      private var coneAngle:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var sfxData:name_262;
      
      private var chassis:name_236;
      
      private var turret:class_15;
      
      public function name_265(range:Number, coneAngle:Number, maxParticles:int, particleSpeed:Number, sfxData:name_262)
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
      
      public static function init(diffuse:name_129, opacity:name_129) : void
      {
         flamethrowerSmokeAtlas = new name_250(diffuse,opacity,8,8,0,16,30,true);
         flamethrowerFlashAtlas = new name_250(diffuse,opacity,8,8,16,16,60,true);
         flamethrowerFireAtlas = new name_250(diffuse,opacity,8,8,32,32,60,false);
      }
      
      override public function initComponent() : void
      {
         this.turret = class_15(entity.getComponentStrict(class_15));
         this.chassis = name_236(entity.getComponentStrict(name_236));
      }
      
      override public function addToGame(gameKernel:name_17) : void
      {
         this.gameKernel = gameKernel;
      }
      
      override public function removeFromGame(gameKernel:name_17) : void
      {
         this.gameKernel = null;
      }
      
      public function start() : void
      {
         if(this.effect != null)
         {
            this.effect.method_255();
         }
         this.effect = name_544(this.gameKernel.method_108().name_110(name_544));
         var collisionDetector:name_256 = this.gameKernel.method_112().name_246().collisionDetector;
         this.effect.init(this.turret,flamethrowerSmokeAtlas,flamethrowerFlashAtlas,flamethrowerFireAtlas);
         this.gameKernel.name_5().method_37(this.effect);
      }
      
      public function stop() : void
      {
         if(this.effect != null)
         {
            this.effect.method_255();
         }
         this.effect = null;
      }
   }
}

