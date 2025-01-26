package package_81
{
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   import package_21.name_386;
   import package_25.name_113;
   import package_25.name_250;
   import package_25.name_626;
   
   public class name_717 extends name_113
   {
      private static var smokePrototype1:name_626;
      
      private static var smokePrototype2:name_626;
      
      private static var flashPrototype1:name_626;
      
      private static var flashPrototype2:name_626;
      
      private static var flashPrototype3:name_626;
      
      private static var firePrototype:name_626;
      
      private static var pos:Vector3D = new Vector3D();
      
      private static var dir:Vector3D = new Vector3D();
      
      private static var liftSpeed:Number = 25;
      
      private static var windSpeed:Number = 10;
      
      public function name_717(smoke:name_250, fire:name_250, flash:name_250, live:Number = 1)
      {
         var keyTime:Number = NaN;
         super();
         if(flashPrototype1 == null)
         {
            flashPrototype1 = new name_626(50,50,flash,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype1.method_257(0 * 0.03333333333333333,0,0.13,0.13,1,1,1,0.8);
            flashPrototype1.method_257(2 * 0.03333333333333333,0,0.4,0.4,1,1,1,1);
            flashPrototype1.method_257(6 * 0.03333333333333333,0,1.1,1.1,1,1,1,0.8);
            flashPrototype1.method_257(11 * 0.03333333333333333,0,1.26,1.26,1,1,1,0.8);
            flashPrototype1.method_257(17 * 0.03333333333333333,0,1.47,1.47,1,1,0.3,0);
            flashPrototype2 = new name_626(50,50,flash,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype2.method_257(1 * 0.03333333333333333,0,0.13,0.13,1,1,1,0.8);
            flashPrototype2.method_257(3 * 0.03333333333333333,0,0.3,0.3,1,1,1,1);
            flashPrototype2.method_257(8 * 0.03333333333333333,0,0.8,0.8,1,1,1,0.5);
            flashPrototype2.method_257(12 * 0.03333333333333333,0,1.26,1.26,1,1,1,0);
            flashPrototype3 = new name_626(50,50,flash,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype3.method_257(2 * 0.03333333333333333,0,0.13,0.13,1,1,1,0.8);
            flashPrototype3.method_257(4 * 0.03333333333333333,0,0.3,0.3,1,1,1,1);
            flashPrototype3.method_257(8 * 0.03333333333333333,0,0.6,0.6,1,1,1,0);
         }
         if(firePrototype == null)
         {
            firePrototype = new name_626(50,50,fire,true);
            firePrototype.method_257(6 * 0.03333333333333333,0,1.53,1.53,1,1,1,0);
            firePrototype.method_257(11 * 0.03333333333333333,0,1.53,1.53,1,1,1,0.6);
            firePrototype.method_257(17 * 0.03333333333333333,0,1.85,1.85,1,0.7,0,0.8);
            firePrototype.method_257(24 * 0.03333333333333333,0,1.98,1.98,1,0.3,0,0.2);
         }
         if(smokePrototype1 == null)
         {
            smokePrototype1 = new name_626(50,50,smoke,true);
            smokePrototype1.method_257(6 * 0.03333333333333333,0,1.51,1.51,1,1,1,0);
            smokePrototype1.method_257(11 * 0.03333333333333333,0,1.92,1.92,1,1,1,0.9);
            smokePrototype1.method_257(17 * 0.03333333333333333,0,2.49,2.49,0.5,0.5,0.5,1);
            smokePrototype1.method_257(24 * 0.03333333333333333,0,2.66,2.66,0,0,0,0);
            smokePrototype2 = new name_626(50,50,smoke,false);
            smokePrototype2.method_257(15 * 0.03333333333333333,0,1.51,1.51,1,1,1,0);
            smokePrototype2.method_257(20 * 0.03333333333333333,0,1.92,1.92,0.8,0.8,0.8,0.3);
            smokePrototype2.method_257(26 * 0.03333333333333333,0,2.49,2.49,0.5,0.5,0.5,0.6);
            smokePrototype2.method_257(55 * 0.03333333333333333,0,2.66,2.66,0,0,0,0);
         }
         boundBox = new name_386();
         boundBox.minX = -350;
         boundBox.minY = -350;
         boundBox.minZ = -350;
         boundBox.maxX = 350;
         boundBox.maxY = 350;
         boundBox.maxZ = 350;
         var i:int = 0;
         while(true)
         {
            keyTime = i * 2 * 0.03333333333333333;
            if(keyTime >= live)
            {
               break;
            }
            method_257(keyTime,this.keyFrame1);
            i++;
         }
         method_258(var_151[var_148 - 1] + smokePrototype2.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         var ang:Number = 6 * 3.14 / 180;
         dir.x = var_156.x;
         dir.y = var_156.y;
         dir.z = var_156.z + 0.2;
         dir.normalize();
         this.method_531(var_156,ang,pos);
         pos.scaleBy(time * 300 + 10);
         flashPrototype1.name_627(this,time,pos,random() * 6.28,1,1,1,random() * flashPrototype1.atlas.rangeLength);
         this.method_531(var_156,ang,pos);
         pos.scaleBy((time - 0.03333333333333333) * 150 + 10);
         flashPrototype2.name_627(this,time,pos,random() * 6.28,1,1,1,random() * flashPrototype1.atlas.rangeLength);
         this.method_531(var_156,ang,pos);
         pos.scaleBy((time - 0.03333333333333333 - 0.03333333333333333) * 80 + 10);
         flashPrototype3.name_627(this,time,pos,random() * 6.28,1,1,1,random() * flashPrototype1.atlas.rangeLength);
         this.method_531(var_156,ang,pos);
         pos.scaleBy(time * 240 + 10);
         firePrototype.name_627(this,time,pos,random() * 6.28,1,1,1,-6 * 0.03333333333333333 * firePrototype.atlas.fps);
         this.method_531(dir,ang,pos);
         pos.scaleBy(time * 300 + 10);
         firePrototype.name_627(this,time,pos,random() * 6.28,1,1,1,-6 * 0.03333333333333333 * firePrototype.atlas.fps);
         this.method_531(var_156,ang,pos);
         pos.scaleBy(time * 300 + 10);
         smokePrototype1.name_627(this,time,pos,random() * 6.28,1,1,1,random() * smokePrototype1.atlas.rangeLength);
         this.method_531(dir,ang,pos);
         pos.scaleBy(time * 330 + 10);
         smokePrototype1.name_627(this,time,pos,random() * 6.28,1,1,1,random() * smokePrototype1.atlas.rangeLength);
         this.method_531(dir,ang,pos);
         pos.scaleBy(time * 40 + 100 + random() * 120);
         pos.x += random() * 50 - 25;
         pos.y += random() * 50 - 25;
         pos.z += random() * 50 - 25;
         this.method_529(time - 15 * 0.03333333333333333,1,pos);
         smokePrototype2.name_627(this,time,pos,random() * 6.28,1,1,1,random() * smokePrototype1.atlas.rangeLength);
      }
      
      private function method_531(direction:Vector3D, angle:Number, result:Vector3D) : void
      {
         var x:Number = random() * 2 - 1;
         var y:Number = random() * 2 - 1;
         var z:Number = random() * 2 - 1;
         result.x = direction.z * y - direction.y * z;
         result.y = direction.x * z - direction.z * x;
         result.z = direction.y * x - direction.x * y;
         result.normalize();
         result.scaleBy(Math.sin(angle / 2));
         result.x += direction.x;
         result.y += direction.y;
         result.z += direction.z;
         result.normalize();
      }
      
      private function method_529(time:Number, factor:Number, result:Vector3D) : void
      {
         result.x += time * windSpeed * var_5.wind.x;
         result.y += time * windSpeed * var_5.wind.y;
         result.z += time * windSpeed * var_5.wind.z + time * liftSpeed * factor;
      }
   }
}

