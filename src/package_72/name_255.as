package package_72
{
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   import flash.utils.setTimeout;
   import package_21.name_386;
   import package_25.name_113;
   import package_25.name_250;
   import package_25.name_626;
   
   public class name_255 extends name_113
   {
      private static var smokePrototype:name_626;
      
      private static var firePrototype:name_626;
      
      private static var flamePrototype:name_626;
      
      private static var liftSpeed:Number = 60;
      
      private static var windSpeed:Number = 40;
      
      private static var pos:Vector3D = new Vector3D();
      
      public function name_255(smoke:name_250, fire:name_250, flame:name_250, live:Number = 1, repeat:Boolean = false)
      {
         var i:int;
         var ft:Number = NaN;
         var keyTime:Number = NaN;
         super();
         ft = 1 / 30;
         if(smokePrototype == null)
         {
            smokePrototype = new name_626(128,128,smoke,false);
            smokePrototype.method_257(0 * ft,0,0.4,0.4,0.65,0.25,0,0);
            smokePrototype.method_257(9 * ft,0,0.58,0.58,0.65,0.45,0.23,0.3);
            smokePrototype.method_257(19 * ft,0,0.78,0.78,0.65,0.55,0.5,0.66);
            smokePrototype.method_257(40 * ft,0,1.21,1.21,0.4,0.4,0.4,0.27);
            smokePrototype.method_257(54 * ft,0,1.5,1.5,0,0,0,0);
         }
         if(firePrototype == null)
         {
            firePrototype = new name_626(128,128,fire,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            firePrototype.method_257(0 * ft,0,0.3,0.3,1,1,1,0);
            firePrototype.method_257(8 * ft,0,0.4,0.4,1,1,1,0.85);
            firePrototype.method_257(17 * ft,0,0.51,0.51,1,0.56,0.48,0.1);
            firePrototype.method_257(24 * ft,0,0.6,0.6,1,0.56,0.48,0);
         }
         if(flamePrototype == null)
         {
            flamePrototype = new name_626(128,128,flame,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flamePrototype.method_257(0 * ft,0,1,1,1,1,1,0);
            flamePrototype.method_257(10 * ft,0,1,1,1,1,1,1);
            flamePrototype.method_257(live - 10 * ft,0,1,1,1,1,1,1);
            flamePrototype.method_257(live,0,1,1,1,1,1,0);
         }
         boundBox = new name_386();
         boundBox.minX = -100;
         boundBox.minY = -100;
         boundBox.minZ = -20;
         boundBox.maxX = 100;
         boundBox.maxY = 100;
         boundBox.maxZ = 200;
         method_257(0,this.keyFrame1);
         i = 0;
         while(true)
         {
            keyTime = ft + i * 5 * ft;
            if(keyTime >= live)
            {
               break;
            }
            method_257(keyTime,this.method_530);
            i++;
         }
         if(repeat)
         {
            setTimeout(function():void
            {
               var newFire:name_255 = new name_255(smoke,fire,flame,live,repeat);
               newFire.name = name;
               newFire.scale = scale;
               newFire.position = position;
               newFire.direction = direction;
               var_5.method_37(newFire);
            },(live - 5 * ft) * 1000);
         }
         method_258(var_151[var_148 - 1] + smokePrototype.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         pos.x = random() * 10 - 10 * 0.5;
         pos.y = random() * 10 - 10 * 0.5;
         pos.z = random() * 10 * 0.5;
         var rnd:Number = 0.2 + random() * 0.2;
         flamePrototype.name_627(this,time,pos,0,rnd,rnd,1,0);
         pos.x = random() * 10 - 10 * 0.5;
         pos.y = random() * 10 - 10 * 0.5;
         pos.z = random() * 10 * 0.5;
         rnd = 0.2 + random() * 0.2;
         flamePrototype.name_627(this,time,pos,0,rnd,rnd,1,0.5 * flamePrototype.atlas.rangeLength);
      }
      
      private function method_530(keyTime:Number, time:Number) : void
      {
         for(var i:int = 0; i < 1; i++)
         {
            pos.x = random() * 10 - 10 * 0.5;
            pos.y = random() * 10 - 10 * 0.5;
            pos.z = 10 + random() * 10 * 0.5;
            this.method_529(time,0.7 + random() * 0.5,pos);
            smokePrototype.name_627(this,time,pos,random() - 0.5,1,1,1,random() * smokePrototype.atlas.rangeLength);
            pos.x = 0;
            pos.y = 0;
            pos.z = 0;
            this.method_529(time,0.7 + random() * 0.5,pos);
            firePrototype.name_627(this,time,pos,random() - 0.5,1,1,0.2,random() * firePrototype.atlas.rangeLength);
         }
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

