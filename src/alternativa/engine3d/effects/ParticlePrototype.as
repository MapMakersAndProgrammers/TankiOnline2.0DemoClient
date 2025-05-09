package alternativa.engine3d.effects
{
   import alternativa.engine3d.alternativa3d;
   import alternativa.engine3d.core.Transform3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Vector3D;
   
   use namespace alternativa3d;
   
   public class ParticlePrototype
   {
      public var atlas:TextureAtlas;
      
      private var blendSource:String;
      
      private var blendDestination:String;
      
      private var animated:Boolean;
      
      private var width:Number;
      
      private var height:Number;
      
      private var §_-gV§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-0r§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-4e§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-Oj§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-07§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-3l§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-7S§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-Ch§:Vector.<Number> = new Vector.<Number>();
      
      private var §_-kf§:int = 0;
      
      public function ParticlePrototype(width:Number, height:Number, atlas:TextureAtlas, animated:Boolean = false, blendSource:String = "sourceAlpha", blendDestination:String = "oneMinusSourceAlpha")
      {
         super();
         this.width = width;
         this.height = height;
         this.atlas = atlas;
         this.animated = animated;
         this.blendSource = blendSource;
         this.blendDestination = blendDestination;
      }
      
      public function addKey(time:Number, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1, red:Number = 1, green:Number = 1, blue:Number = 1, alpha:Number = 1) : void
      {
         var lastIndex:int = this.§_-kf§ - 1;
         if(this.§_-kf§ > 0 && time <= this.§_-gV§[lastIndex])
         {
            throw new Error("Keys must be successively.");
         }
         this.§_-gV§[this.§_-kf§] = time;
         this.§_-0r§[this.§_-kf§] = rotation;
         this.§_-4e§[this.§_-kf§] = scaleX;
         this.§_-Oj§[this.§_-kf§] = scaleY;
         this.§_-07§[this.§_-kf§] = red;
         this.§_-3l§[this.§_-kf§] = green;
         this.§_-7S§[this.§_-kf§] = blue;
         this.§_-Ch§[this.§_-kf§] = alpha;
         ++this.§_-kf§;
      }
      
      public function createParticle(effect:§_-SG§, time:Number, position:Vector3D, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1, alpha:Number = 1, firstFrame:int = 0) : void
      {
         var systemScale:Number = NaN;
         var effectScale:Number = NaN;
         var transform:Transform3D = null;
         var wind:Vector3D = null;
         var gravity:Vector3D = null;
         var a:int = 0;
         var t:Number = NaN;
         var pos:int = 0;
         var col:int = 0;
         var row:int = 0;
         var particle:Particle = null;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var cz:Number = NaN;
         var rot:Number = NaN;
         var b:int = this.§_-kf§ - 1;
         if(this.atlas.diffuse.alternativa3d::_texture != null && this.§_-kf§ > 1 && time >= this.§_-gV§[0] && time < this.§_-gV§[b])
         {
            for(b = 1; b < this.§_-kf§; )
            {
               if(time < this.§_-gV§[b])
               {
                  systemScale = Number(effect.alternativa3d::system.alternativa3d::scale);
                  effectScale = Number(effect.scale);
                  transform = effect.alternativa3d::system.alternativa3d::localToCameraTransform;
                  wind = effect.alternativa3d::system.wind;
                  gravity = effect.alternativa3d::system.gravity;
                  a = b - 1;
                  t = (time - this.§_-gV§[a]) / (this.§_-gV§[b] - this.§_-gV§[a]);
                  pos = firstFrame + (this.animated ? time * this.atlas.fps : 0);
                  if(this.atlas.loop)
                  {
                     pos %= this.atlas.rangeLength;
                     if(pos < 0)
                     {
                        pos += this.atlas.rangeLength;
                     }
                  }
                  else
                  {
                     if(pos < 0)
                     {
                        pos = 0;
                     }
                     if(pos >= this.atlas.rangeLength)
                     {
                        pos = this.atlas.rangeLength - 1;
                     }
                  }
                  pos += this.atlas.rangeBegin;
                  col = pos % this.atlas.columnsCount;
                  row = pos / this.atlas.columnsCount;
                  particle = Particle.create();
                  particle.diffuse = this.atlas.diffuse.alternativa3d::_texture;
                  particle.opacity = this.atlas.opacity != null ? this.atlas.opacity.alternativa3d::_texture : null;
                  particle.blendSource = this.blendSource;
                  particle.blendDestination = this.blendDestination;
                  cx = effect.alternativa3d::_-M7.x + position.x * effectScale;
                  cy = effect.alternativa3d::_-M7.y + position.y * effectScale;
                  cz = effect.alternativa3d::_-M7.z + position.z * effectScale;
                  particle.x = cx * transform.a + cy * transform.b + cz * transform.c + transform.d;
                  particle.y = cx * transform.e + cy * transform.f + cz * transform.g + transform.h;
                  particle.z = cx * transform.i + cy * transform.j + cz * transform.k + transform.l;
                  rot = this.§_-0r§[a] + (this.§_-0r§[b] - this.§_-0r§[a]) * t;
                  particle.rotation = scaleX * scaleY > 0 ? rotation + rot : rotation - rot;
                  particle.width = systemScale * effectScale * scaleX * this.width * (this.§_-4e§[a] + (this.§_-4e§[b] - this.§_-4e§[a]) * t);
                  particle.height = systemScale * effectScale * scaleY * this.height * (this.§_-Oj§[a] + (this.§_-Oj§[b] - this.§_-Oj§[a]) * t);
                  particle.originX = this.atlas.originX;
                  particle.originY = this.atlas.originY;
                  particle.§_-q§ = 1 / this.atlas.columnsCount;
                  particle.§_-Ts§ = 1 / this.atlas.rowsCount;
                  particle.§_-ej§ = col / this.atlas.columnsCount;
                  particle.§_-W5§ = row / this.atlas.rowsCount;
                  particle.red = this.§_-07§[a] + (this.§_-07§[b] - this.§_-07§[a]) * t;
                  particle.green = this.§_-3l§[a] + (this.§_-3l§[b] - this.§_-3l§[a]) * t;
                  particle.blue = this.§_-7S§[a] + (this.§_-7S§[b] - this.§_-7S§[a]) * t;
                  particle.alpha = alpha * (this.§_-Ch§[a] + (this.§_-Ch§[b] - this.§_-Ch§[a]) * t);
                  particle.next = effect.alternativa3d::particleList;
                  effect.alternativa3d::particleList = particle;
                  break;
               }
               b++;
            }
         }
      }
      
      public function get lifeTime() : Number
      {
         var lastIndex:int = this.§_-kf§ - 1;
         return this.§_-gV§[lastIndex];
      }
   }
}

