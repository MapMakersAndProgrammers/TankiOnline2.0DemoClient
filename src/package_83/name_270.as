package package_83
{
   import flash.geom.Vector3D;
   import package_10.name_17;
   import package_18.name_44;
   import package_25.name_250;
   import package_28.name_129;
   import package_4.class_4;
   import package_46.name_194;
   import package_72.class_12;
   
   public class name_270 implements class_12
   {
      private static var smokeAtlas:name_250;
      
      private static var fireAtlas:name_250;
      
      private static var flashAtlas:name_250;
      
      private static var fragmentAtlas:name_250;
      
      private static var glowAtlas:name_250;
      
      private static var sparkAtlas:name_250;
      
      private static const tempVector:Vector3D = new Vector3D();
      
      private var gameKernel:name_17;
      
      private var frames:Vector.<class_4>;
      
      public function name_270(gameKernel:name_17, frames:Vector.<class_4>)
      {
         super();
         this.gameKernel = gameKernel;
         this.frames = frames;
      }
      
      public static function init(diffuse:name_129, opacity:name_129) : void
      {
         smokeAtlas = new name_250(diffuse,opacity,8,8,0,16,30,true);
         fireAtlas = new name_250(diffuse,opacity,8,8,16,16,30,true);
         flashAtlas = new name_250(diffuse,opacity,8,8,32,16,30,true,0.5,0.5);
         fragmentAtlas = new name_250(diffuse,opacity,8,8,48,8,30,true);
         glowAtlas = new name_250(diffuse,opacity,8,8,56,1,30,true);
         sparkAtlas = new name_250(diffuse,opacity,8,8,57,1,30,true);
      }
      
      public function createEffects(position:name_194, weakeningCoefficient:Number, radius:Number) : void
      {
         var renderSystem:name_44 = this.gameKernel.name_5();
         var explosion:name_543 = new name_543(smokeAtlas,fireAtlas,flashAtlas,glowAtlas,sparkAtlas,fragmentAtlas);
         tempVector.x = position.x;
         tempVector.y = position.y;
         tempVector.z = position.z;
         explosion.position = tempVector;
         explosion.scale = 6;
         renderSystem.method_48(explosion);
      }
   }
}

