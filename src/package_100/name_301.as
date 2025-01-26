package package_100
{
   import flash.geom.ColorTransform;
   import package_10.name_17;
   import package_4.class_4;
   import package_46.name_194;
   import package_72.name_239;
   import package_91.name_349;
   import package_91.name_522;
   
   public class name_301 implements name_349
   {
      private static const EFFECT_SIZE:Number = 300;
      
      private static const EFFECT_FPS:Number = 30;
      
      private static const EXPLOSION_EFFECT_SIZE:Number = 600;
      
      private static const EXPLOSION_FPS:int = 30;
      
      private var gameKernel:name_17;
      
      private var roundFrames:Vector.<class_4>;
      
      private var explosionFrames:Vector.<class_4>;
      
      private var colorTransform:ColorTransform;
      
      public function name_301(gameKernel:name_17, roundFrames:Vector.<class_4>, explosionFrames:Vector.<class_4>, colorTransform:ColorTransform)
      {
         super();
         this.gameKernel = gameKernel;
         this.roundFrames = roundFrames;
         this.explosionFrames = explosionFrames;
         this.colorTransform = colorTransform;
      }
      
      public function method_414() : name_522
      {
         var effect:name_625 = name_625(this.gameKernel.method_108().name_110(name_625));
         var rotation:Number = Math.random() * Math.PI;
         effect.init(EFFECT_SIZE,EFFECT_SIZE,this.roundFrames,name_194.ZERO,rotation,50,EFFECT_FPS,true,0.5,0.5);
         this.gameKernel.name_5().method_37(effect);
         return effect;
      }
      
      public function method_413(position:name_194) : void
      {
         var explosionEffect:name_239 = name_239(this.gameKernel.method_108().name_110(name_239));
         var rotation:Number = Math.random() * Math.PI;
         explosionEffect.init(EXPLOSION_EFFECT_SIZE,EXPLOSION_EFFECT_SIZE,this.explosionFrames,position,rotation,50,EXPLOSION_FPS,false,0.5,0.5);
         this.gameKernel.name_5().method_37(explosionEffect);
      }
      
      public function method_412(position:name_194, normal:name_194, direction:name_194) : void
      {
      }
   }
}

