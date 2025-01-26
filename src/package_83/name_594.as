package package_83
{
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   import package_21.name_386;
   import package_25.name_113;
   import package_25.name_250;
   import package_25.name_626;
   
   public class name_594 extends name_113
   {
      private static var shotPrototype:name_626;
      
      private static var pos:Vector3D = new Vector3D();
      
      public function name_594(shot:name_250)
      {
         super();
         if(shotPrototype == null)
         {
            shotPrototype = new name_626(50,50,shot,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            shotPrototype.method_257(0 * 0.03333333333333333,0,0.85,0.85,1,1,1,0.6);
            shotPrototype.method_257(1 * 0.03333333333333333,0,1,1,1,1,1,1);
            shotPrototype.method_257(2 * 0.03333333333333333,0,1,1,1,1,1,0.5);
            shotPrototype.method_257(3 * 0.03333333333333333,0,1,1,1,1,1,0.5);
         }
         boundBox = new name_386();
         boundBox.minX = -100;
         boundBox.minY = -100;
         boundBox.minZ = -100;
         boundBox.maxX = 100;
         boundBox.maxY = 100;
         boundBox.maxZ = 100;
         method_257(0 * 0.03333333333333333,this.keyFrame1);
         method_258(var_151[var_148 - 1] + shotPrototype.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         pos.copyFrom(var_156);
         pos.scaleBy(time * 100 + 25);
         shotPrototype.name_627(this,time,pos,random() * 6.28,1,1,1,0);
         pos.copyFrom(var_156);
         pos.scaleBy(time * 300 + 32);
         shotPrototype.name_627(this,time,pos,random() * 6.28,0.88,0.88,1,0);
         pos.copyFrom(var_156);
         pos.scaleBy(time * 400 + 39);
         shotPrototype.name_627(this,time,pos,random() * 6.28,0.66,0.66,1,0);
      }
   }
}

