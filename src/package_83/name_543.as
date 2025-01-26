package package_83
{
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   import package_21.name_386;
   import package_25.name_113;
   import package_25.name_250;
   import package_25.name_626;
   
   public class name_543 extends name_113
   {
      private static var smokePrototype:name_626;
      
      private static var firePrototype:name_626;
      
      private static var flashPrototype:name_626;
      
      private static var glowPrototype:name_626;
      
      private static var sparkPrototype:name_626;
      
      private static var fragmentPrototype:name_626;
      
      private static const smokeDirections:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D()]);
      
      private static const smokeDirectionsCount:int = 7;
      
      private static const sparkDirections:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D()]);
      
      private static const sparkDirectionsCount:int = 20;
      
      private static const fragmentDirections:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D(),new Vector3D()]);
      
      private static const fragmentDirectionsCount:int = 20;
      
      private static var pos:Vector3D = new Vector3D();
      
      private static var dir:Vector3D = new Vector3D();
      
      private static var gravity:Number = 700;
      
      private static var movingSpeed:Number = 700;
      
      private static var liftSpeed:Number = 17;
      
      private static var windSpeed:Number = 10;
      
      private static var littleTime:Number = 0.01;
      
      public function name_543(smoke:name_250, fire:name_250, flash:name_250, glow:name_250, spark:name_250, fragment:name_250)
      {
         super();
         if(smokePrototype == null)
         {
            smokePrototype = new name_626(128,128,smoke,false);
            smokePrototype.method_257(0 * 0.03333333333333333,0,0.4,0.4,1,1,1,0);
            smokePrototype.method_257(2 * 0.03333333333333333,0,0.74,0.74,0.86,0.86,0.86,0.34);
            smokePrototype.method_257(4 * 0.03333333333333333,0,0.94,0.94,0.78,0.78,0.78,0.54);
            smokePrototype.method_257(6 * 0.03333333333333333,0,1,1,0.75,0.75,0.75,0.6);
            smokePrototype.method_257(100 * 0.03333333333333333,0,1.5,1.5,0,0,0,0);
         }
         if(firePrototype == null)
         {
            firePrototype = new name_626(128,128,fire,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            firePrototype.method_257(0 * 0.03333333333333333,0,0.4,0.4,1,1,1,0);
            firePrototype.method_257(1 * 0.03333333333333333,0,0.85,0.85,1,1,1,0.85);
            firePrototype.method_257(2 * 0.03333333333333333,0,1,1,1,1,1,1);
            firePrototype.method_257(9 * 0.03333333333333333,0,1,1,0,0,0,0);
         }
         if(flashPrototype == null)
         {
            flashPrototype = new name_626(128,128,flash,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flashPrototype.method_257(0 * 0.03333333333333333,0,0.6,0.6,1,1,1,1);
            flashPrototype.method_257(1 * 0.03333333333333333,0,1,1,1,1,1,1);
            flashPrototype.method_257(3 * 0.03333333333333333,0,0.95,0.95,1,1,1,0.75);
            flashPrototype.method_257(5 * 0.03333333333333333,0,0.79,0.79,1,1,1,0);
         }
         if(glowPrototype == null)
         {
            glowPrototype = new name_626(256,256,glow,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            glowPrototype.method_257(0 * 0.03333333333333333,0,0.6,0.6,1,1,1,0.4);
            glowPrototype.method_257(1 * 0.03333333333333333,0,1,1,1,1,1,0.45);
            glowPrototype.method_257(8 * 0.03333333333333333,0,1,1,1,1,1,0);
         }
         if(sparkPrototype == null)
         {
            sparkPrototype = new name_626(8,8,spark,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            sparkPrototype.method_257(0 * 0.03333333333333333,0,1,1,1,1,1,1);
            sparkPrototype.method_257(4.5 * 0.03333333333333333,0,0.3,0.3,1,1,0.5,0.5);
         }
         if(fragmentPrototype == null)
         {
            fragmentPrototype = new name_626(16,16,fragment,false);
            fragmentPrototype.method_257(0 * 0.03333333333333333,0,0.5,0.5,2,1.4,0.7,0.6);
            fragmentPrototype.method_257(7 * 0.03333333333333333,0,0.3,0.3,0.6,0.6,0.6,0.5);
         }
         boundBox = new name_386();
         boundBox.minX = -160;
         boundBox.minY = -160;
         boundBox.minZ = -90;
         boundBox.maxX = 160;
         boundBox.maxY = 160;
         boundBox.maxZ = 200;
         method_257(0 * 0.03333333333333333,this.keyFrame1);
         method_257(1 * 0.03333333333333333,this.keyFrame2);
         method_257(2 * 0.03333333333333333,this.keyFrame3);
         method_257(3 * 0.03333333333333333,this.keyFrame4);
         method_257(4 * 0.03333333333333333,this.keyFrame5);
         method_257(4.7 * 0.03333333333333333,this.keyFrame6);
         method_258(var_151[var_148 - 1] + smokePrototype.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         var i:int = 0;
         var direction:Vector3D = null;
         var t:Number = NaN;
         var j:int = 0;
         var deg:Number = Math.PI / 180;
         var delta:Number = 30 * deg;
         var bot:Number = -15 * deg;
         var top:Number = 30 * deg;
         this.method_531(45 * deg - delta,45 * deg + delta,bot,top,smokeDirections[0]);
         this.method_531(135 * deg - delta,135 * deg + delta,bot,top,smokeDirections[1]);
         this.method_531(225 * deg - delta,225 * deg + delta,bot,top,smokeDirections[2]);
         this.method_531(315 * deg - delta,315 * deg + delta,bot,top,smokeDirections[3]);
         this.method_531(0,Math.PI + Math.PI,40 * deg,90 * deg,smokeDirections[4]);
         this.method_531(0,Math.PI + Math.PI,40 * deg,90 * deg,smokeDirections[5]);
         this.method_531(0,Math.PI + Math.PI,40 * deg,90 * deg,smokeDirections[6]);
         (smokeDirections[0] as Vector3D).scaleBy(0.8 + random() * 0.2);
         (smokeDirections[1] as Vector3D).scaleBy(0.8 + random() * 0.2);
         (smokeDirections[2] as Vector3D).scaleBy(0.8 + random() * 0.2);
         (smokeDirections[3] as Vector3D).scaleBy(0.8 + random() * 0.2);
         (smokeDirections[4] as Vector3D).scaleBy(1 + random() * 0.2);
         (smokeDirections[5] as Vector3D).scaleBy(0.8 + random() * 0.2);
         (smokeDirections[6] as Vector3D).scaleBy(0.8 + random() * 0.2);
         for(i = 0; i < sparkDirectionsCount; i++)
         {
            direction = sparkDirections[i];
            this.method_531(0,360 * deg,bot,90 * deg,direction);
            direction.scaleBy(0.4 + random() * 0.3);
         }
         for(i = 0; i < fragmentDirectionsCount; i++)
         {
            direction = fragmentDirections[i];
            this.method_531(0,360 * deg,bot,90 * deg,direction);
            direction.scaleBy(0.4 + random() * 0.3);
         }
         for(i = 0; i < smokeDirectionsCount; i++)
         {
            direction = smokeDirections[i];
            this.method_754(keyTime + littleTime,direction,pos);
            this.method_529(time,1.17,pos);
            smokePrototype.name_627(this,time,pos,random() - 0.5,1.17,1.17,1,random() * smokePrototype.atlas.rangeLength);
            this.method_754((keyTime + littleTime) * 0.9,direction,pos);
            firePrototype.name_627(this,time,pos,random() - 0.5,1.07,1.07,1,random() * firePrototype.atlas.rangeLength);
            this.method_754(keyTime + 0 * 0.03333333333333333,direction,pos);
            flashPrototype.name_627(this,time,pos,random() - 0.5,0.8,0.8,1,random() * flashPrototype.atlas.rangeLength);
            this.method_754(keyTime + 1.3 * 0.03333333333333333,direction,pos);
            flashPrototype.name_627(this,time,pos,random() - 0.5,0.5,0.5,1,random() * flashPrototype.atlas.rangeLength);
            this.method_754(keyTime + 2 * 0.03333333333333333,direction,pos);
            flashPrototype.name_627(this,time,pos,random() - 0.5,0.3,0.3,1,random() * flashPrototype.atlas.rangeLength);
         }
         pos.x = 0;
         pos.y = 0;
         pos.z = 0;
         flashPrototype.name_627(this,time,pos,random() - 0.5,1,1,1,random() * flashPrototype.atlas.rangeLength);
         glowPrototype.name_627(this,time,pos,0,0.75,0.75,1,0);
         for(i = 0; i < sparkDirectionsCount >> 1; i++)
         {
            direction = sparkDirections[i];
            t = keyTime + 0.1;
            for(j = 0; j < 8; j++)
            {
               this.method_754(time + t,direction,pos,0.4);
               sparkPrototype.name_627(this,time,pos,0,1 - j * 0.05,1 - j * 0.05,1,0);
               t -= 0.003;
            }
         }
      }
      
      private function keyFrame2(keyTime:Number, time:Number) : void
      {
         var i:int = 0;
         var rnd:Number = NaN;
         var direction:Vector3D = null;
         var t:Number = NaN;
         var j:int = 0;
         for(i = 0; i < smokeDirectionsCount; i++)
         {
            direction = smokeDirections[i];
            this.method_754(keyTime + littleTime,direction,pos);
            this.method_529(time,0.95,pos);
            smokePrototype.name_627(this,time,pos,random() - 0.5,0.95,0.95,1,random() * smokePrototype.atlas.rangeLength);
            this.method_754((keyTime + littleTime) * 0.9,direction,pos);
            firePrototype.name_627(this,time,pos,random() - 0.5,0.87,0.87,1,random() * firePrototype.atlas.rangeLength);
            rnd = 0.5 + random();
            this.method_754(time + littleTime,direction,pos);
            fragmentPrototype.name_627(this,time,pos,random() * 6.28,rnd,rnd,1,random() * fragmentPrototype.atlas.rangeLength);
         }
         for(i = sparkDirectionsCount >> 1; i < sparkDirectionsCount; i++)
         {
            direction = sparkDirections[i];
            t = keyTime + 0.1;
            for(j = 0; j < 8; j++)
            {
               this.method_754(time + t,direction,pos,0.4);
               sparkPrototype.name_627(this,time,pos,0,1 - j * 0.05,1 - j * 0.05,1,0);
               t -= 0.003;
            }
         }
         for(i = 0; i < fragmentDirectionsCount; i++)
         {
            direction = fragmentDirections[i];
            rnd = 0.5 + random();
            this.method_754(time + littleTime,direction,pos);
            fragmentPrototype.name_627(this,time,pos,random() * 6.28,rnd,rnd,1,random() * fragmentPrototype.atlas.rangeLength);
         }
      }
      
      private function keyFrame3(keyTime:Number, time:Number) : void
      {
         var direction:Vector3D = null;
         for(var i:int = 0; i < smokeDirectionsCount; i++)
         {
            direction = smokeDirections[i];
            this.method_754(keyTime + littleTime,direction,pos);
            this.method_529(time,0.85,pos);
            smokePrototype.name_627(this,time,pos,random() - 0.5,0.85,0.85,1,random() * smokePrototype.atlas.rangeLength);
            this.method_754((keyTime + littleTime) * 0.9,direction,pos);
            firePrototype.name_627(this,time,pos,random() - 0.5,0.78,0.78,0.73,random() * firePrototype.atlas.rangeLength);
         }
      }
      
      private function keyFrame4(keyTime:Number, time:Number) : void
      {
         var direction:Vector3D = null;
         for(var i:int = 0; i < smokeDirectionsCount; i++)
         {
            direction = smokeDirections[i];
            this.method_754(keyTime + littleTime,direction,pos);
            this.method_529(time,0.7,pos);
            smokePrototype.name_627(this,time,pos,random() - 0.5,0.7,0.7,1,random() * smokePrototype.atlas.rangeLength);
            this.method_754((keyTime + littleTime) * 0.9,direction,pos);
            firePrototype.name_627(this,time,pos,random() - 0.5,0.44,0.44,0.53,random() * firePrototype.atlas.rangeLength);
         }
      }
      
      private function keyFrame5(keyTime:Number, time:Number) : void
      {
         var direction:Vector3D = null;
         var rnd:Number = NaN;
         for(var i:int = 0; i < smokeDirectionsCount; i++)
         {
            direction = smokeDirections[i];
            this.method_754(keyTime + littleTime,direction,pos);
            this.method_529(time,0.4,pos);
            smokePrototype.name_627(this,time,pos,random() - 0.5,0.4,0.4,1,random() * smokePrototype.atlas.rangeLength);
         }
         for(var j:int = 0; j < 3; j++)
         {
            pos.x = random() * 50 - 25;
            pos.y = random() * 50 - 25;
            pos.z = random() * 20 - 10;
            this.method_529(time,0.18,pos);
            rnd = 0.5 + random() * 0.5;
            smokePrototype.name_627(this,time,pos,random() - 0.5,rnd,rnd,1,random() * smokePrototype.atlas.rangeLength);
            pos.x = random() * 10 - 5;
            pos.y = random() * 10 - 5;
            pos.z = random() * 10 - 5;
            rnd = 0.3 + random() * 0.5;
            firePrototype.name_627(this,time,pos,random() - 0.5,rnd,rnd,1,random() * firePrototype.atlas.rangeLength);
         }
      }
      
      private function keyFrame6(keyTime:Number, time:Number) : void
      {
         var direction:Vector3D = null;
         var rnd:Number = NaN;
         for(var i:int = 0; i < smokeDirectionsCount; )
         {
            direction = smokeDirections[i];
            if(random() > 0.25)
            {
               this.method_754(keyTime + littleTime,direction,pos);
               this.method_529(time,0.25,pos);
               smokePrototype.name_627(this,time,pos,random() - 0.5,0.19,0.19,1,random() * smokePrototype.atlas.rangeLength);
            }
            i++;
         }
         for(var j:int = 0; j < 3; j++)
         {
            pos.x = random() * 50 - 25;
            pos.y = random() * 50 - 25;
            pos.z = random() * 20 - 10;
            this.method_529(time,0.16,pos);
            rnd = 0.5 + random() * 0.5;
            smokePrototype.name_627(this,time,pos,random() - 0.5,rnd,rnd,1,random() * smokePrototype.atlas.rangeLength);
         }
      }
      
      private function method_531(xyBegin:Number, xyEnd:Number, zBegin:Number, zEnd:Number, result:Vector3D) : void
      {
         var xyAng:Number = xyBegin + random() * (xyEnd - xyBegin);
         var zAng:Number = zBegin + random() * (zEnd - zBegin);
         var cosZAng:Number = Number(Math.cos(zAng));
         result.x = Math.cos(xyAng) * cosZAng;
         result.y = Math.sin(xyAng) * cosZAng;
         result.z = Math.sin(zAng);
      }
      
      private function method_754(time:Number, direction:Vector3D, result:Vector3D, gravityInfluence:Number = 1) : void
      {
         result.x = time * movingSpeed * direction.x;
         result.y = time * movingSpeed * direction.y;
         result.z = time * movingSpeed * direction.z - time * time * gravity * gravityInfluence;
      }
      
      private function method_529(time:Number, factor:Number, result:Vector3D) : void
      {
         result.x += time * windSpeed * var_5.wind.x;
         result.y += time * windSpeed * var_5.wind.y;
         result.z += time * windSpeed * var_5.wind.z + time * liftSpeed * factor;
      }
   }
}

