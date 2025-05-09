package §function§
{
   import §_-8D§.§_-FW§;
   import §_-aF§.§_-S8§;
   import §_-aF§.§_-SG§;
   import §_-aF§.§_-nN§;
   import flash.display3D.Context3DBlendFactor;
   import flash.geom.Vector3D;
   import flash.utils.setTimeout;
   
   public class §_-KQ§ extends §_-SG§
   {
      private static var smokePrototype:§_-nN§;
      
      private static var firePrototype:§_-nN§;
      
      private static var flamePrototype:§_-nN§;
      
      private static var liftSpeed:Number = 60;
      
      private static var windSpeed:Number = 40;
      
      private static var pos:Vector3D = new Vector3D();
      
      public function §_-KQ§(smoke:§_-S8§, fire:§_-S8§, flame:§_-S8§, live:Number = 1, repeat:Boolean = false)
      {
         var i:int;
         var ft:Number = NaN;
         var keyTime:Number = NaN;
         super();
         ft = 1 / 30;
         if(smokePrototype == null)
         {
            smokePrototype = new §_-nN§(128,128,smoke,false);
            smokePrototype.§_-Le§(0 * ft,0,0.4,0.4,0.65,0.25,0,0);
            smokePrototype.§_-Le§(9 * ft,0,0.58,0.58,0.65,0.45,0.23,0.3);
            smokePrototype.§_-Le§(19 * ft,0,0.78,0.78,0.65,0.55,0.5,0.66);
            smokePrototype.§_-Le§(40 * ft,0,1.21,1.21,0.4,0.4,0.4,0.27);
            smokePrototype.§_-Le§(54 * ft,0,1.5,1.5,0,0,0,0);
         }
         if(firePrototype == null)
         {
            firePrototype = new §_-nN§(128,128,fire,false,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            firePrototype.§_-Le§(0 * ft,0,0.3,0.3,1,1,1,0);
            firePrototype.§_-Le§(8 * ft,0,0.4,0.4,1,1,1,0.85);
            firePrototype.§_-Le§(17 * ft,0,0.51,0.51,1,0.56,0.48,0.1);
            firePrototype.§_-Le§(24 * ft,0,0.6,0.6,1,0.56,0.48,0);
         }
         if(flamePrototype == null)
         {
            flamePrototype = new §_-nN§(128,128,flame,true,Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            flamePrototype.§_-Le§(0 * ft,0,1,1,1,1,1,0);
            flamePrototype.§_-Le§(10 * ft,0,1,1,1,1,1,1);
            flamePrototype.§_-Le§(live - 10 * ft,0,1,1,1,1,1,1);
            flamePrototype.§_-Le§(live,0,1,1,1,1,1,0);
         }
         boundBox = new §_-FW§();
         boundBox.minX = -100;
         boundBox.minY = -100;
         boundBox.minZ = -20;
         boundBox.maxX = 100;
         boundBox.maxY = 100;
         boundBox.maxZ = 200;
         §_-Le§(0,this.keyFrame1);
         i = 0;
         while(true)
         {
            keyTime = ft + i * 5 * ft;
            if(keyTime >= live)
            {
               break;
            }
            §_-Le§(keyTime,this.§_-IJ§);
            i++;
         }
         if(repeat)
         {
            setTimeout(function():void
            {
               var newFire:§_-KQ§ = new §_-KQ§(smoke,fire,flame,live,repeat);
               newFire.name = name;
               newFire.scale = scale;
               newFire.position = position;
               newFire.direction = direction;
               §_-Ta§.each(newFire);
            },(live - 5 * ft) * 1000);
         }
         §_-DM§(§_-gV§[§_-kf§ - 1] + smokePrototype.lifeTime);
      }
      
      private function keyFrame1(keyTime:Number, time:Number) : void
      {
         pos.x = random() * 10 - 10 * 0.5;
         pos.y = random() * 10 - 10 * 0.5;
         pos.z = random() * 10 * 0.5;
         var rnd:Number = 0.2 + random() * 0.2;
         flamePrototype.§_-fs§(this,time,pos,0,rnd,rnd,1,0);
         pos.x = random() * 10 - 10 * 0.5;
         pos.y = random() * 10 - 10 * 0.5;
         pos.z = random() * 10 * 0.5;
         rnd = 0.2 + random() * 0.2;
         flamePrototype.§_-fs§(this,time,pos,0,rnd,rnd,1,0.5 * flamePrototype.atlas.rangeLength);
      }
      
      private function §_-IJ§(keyTime:Number, time:Number) : void
      {
         for(var i:int = 0; i < 1; i++)
         {
            pos.x = random() * 10 - 10 * 0.5;
            pos.y = random() * 10 - 10 * 0.5;
            pos.z = 10 + random() * 10 * 0.5;
            this.§_-C8§(time,0.7 + random() * 0.5,pos);
            smokePrototype.§_-fs§(this,time,pos,random() - 0.5,1,1,1,random() * smokePrototype.atlas.rangeLength);
            pos.x = 0;
            pos.y = 0;
            pos.z = 0;
            this.§_-C8§(time,0.7 + random() * 0.5,pos);
            firePrototype.§_-fs§(this,time,pos,random() - 0.5,1,1,0.2,random() * firePrototype.atlas.rangeLength);
         }
      }
      
      private function §_-ky§(direction:Vector3D, angle:Number, result:Vector3D) : void
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
      
      private function §_-C8§(time:Number, factor:Number, result:Vector3D) : void
      {
         result.x += time * windSpeed * §_-Ta§.wind.x;
         result.y += time * windSpeed * §_-Ta§.wind.y;
         result.z += time * windSpeed * §_-Ta§.wind.z + time * liftSpeed * factor;
      }
   }
}

